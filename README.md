# CollectionView Pagenation With Prefetch

## Project 설명

- CollectionView prefetchDataSource를 사용하여 scrolling pagenation 기능 구현
- CollectionView List에 보여질 내용은 PunkAPI(https://punkapi.com/) 사용.
- UICollectionViewDataSourcePrefetching 구현이 이 프로젝트의 핵심.

## Library

- Alamofire
- Kingfisher
- RxSwift
- SnapKit

## Project 디자인

- Delegate
	- Code 기반 UI 구성을 위해 window를 연결해주는 작업을 SceneDelegate에서 진행
	- main 스토리 보드 제거
	- rootViewController를 BreweryViewController로 설정하고 UINavigationController로 설정

- Scene
	- BreweryViewController
		- Brewery API에서 받아온 데이터를 보여줄 뷰를 SnapKit으로 구현하였다.
		- collectionView로 구성되어 있다.
	- BreweryCollectionViewCell
		- ImageView, label, collectionView로 구성되어 있으며, collectionView에는 tag가 들어가게 된다.
	- BreweryDetailViewController(미구현)

- ViewModel
	- BreweryViewModel
		- Input, Output, type protocol을 각각 구현하고 BreweryViewModel이 상속하는 형태로 구성되어 있다.
		- Input requestBrewery() 함수를 호출하면 Repository에서 service를 호출하여 서버에 데이터를 요청하고 Observable 값을 받아온다.
		- outputs에 PublishSubject를 선언하고 [BreweryModel]를 onNext로 비동기 처리한다.
		- ViewController에서 ViewModel outputs를 바인딩하여 값이 들어오면 collectionView cell에 값을 세팅한다.

- Repository
	- protocol Repository를 선언하고 BreweryRepository를 구현하여 service를 사용하여 API 호출한다.
	- service에서 받아온 entity 값을 뷰에서 사용할 BreweryModel로 변경해주는 작업을 진행한다.

- Service
	- RequestGet 함수를 구현
	- Alamofire를 사용하여 데이터를 요청하고 받아와 response.statusCode 값에 따라 에러 처리 및 jsonModel decoding을 진행했다.
	- enum으로 NetworkError를 구현하여 decoding, network error를 구분하였다.

	

