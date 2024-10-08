
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_cards_new/models/folder_model.dart';
import 'package:flash_cards_new/models/user_model.dart';
import '../screens/authenticate/registration_screen.dart';

const String FOLDERS_COLLECTON_REF = "Folders";
const String USERS_COLLECTION_REF = "Users";

class FirestoreDatabase {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _folderCollectionRef;
  late final CollectionReference _usersCollectionRef;

  FirestoreDatabase() {
    _folderCollectionRef = _firestore.collection(FOLDERS_COLLECTON_REF).withConverter<FolderModel>(
        fromFirestore: (snapshots, _) => FolderModel.fromJson(
          snapshots.data()!,
        ),
        toFirestore: (folderModel, _) => folderModel.toJson());

    _usersCollectionRef = _firestore.collection(USERS_COLLECTION_REF).withConverter<UserModel>(
        fromFirestore: (snapshots, _) => UserModel.fromJson(
          snapshots.data()!,
        ),
        toFirestore: (userModel, _) => userModel.toJson());
  }

  Stream<QuerySnapshot> getFolders() {
    return _folderCollectionRef.snapshots();
  }

  //You might need this:
  Stream<DocumentSnapshot> getCards(String docId) {
    return _folderCollectionRef
        .doc(docId)
        .snapshots();
  }

  void createFolder(String folderName, String ownerId) async {
    FolderModel folderModel = FolderModel(name: folderName, contents: [], ownerId: ownerId);
    _folderCollectionRef.add(folderModel);
  }

  void addFlashCard(List folderContent, String folderName, String docId, String ownerId) async {
    FolderModel folderModel= FolderModel(name: folderName, contents: folderContent, ownerId: ownerId);
    _folderCollectionRef.doc(docId).set(folderModel);
  }

  void updateFlashCard(String docId, List folderContent, int indexOfCard, Map flashCard) {
    folderContent[indexOfCard] = flashCard;
    _folderCollectionRef.doc(docId).update({'contents': folderContent});
  }

  void deleteFlashCard(String docId, List folderContent, int indexOfCard) {
    folderContent.removeAt(indexOfCard);
    _folderCollectionRef.doc(docId).update({'contents': folderContent});
  }
  //TODO: Should these be async? ^^^^^^^^^^^^^^

  //User operations

  void addUser(String nickName, String userId, String email, UserRoles role) async {
    UserModel userModel = UserModel(nickName: nickName, userId: userId, email: email, role: role.toString()
        .split('.').last);
    _usersCollectionRef.add(userModel);
  }

  Future<UserModel> getUser(String userId) async {
    QuerySnapshot userDoc = await _usersCollectionRef.where('userId', isEqualTo: userId).get();
    return userDoc.docs[0].data() as UserModel;
  }
}