# app_turno

versões usadas:
- Flutter: 3.24.3
- Dart: 3.5.3
- DevTools: 2.37.3
- Android Studio: Ladybug | 2024.2.1 Patch 2
- Xcode: Version 16.1 (16B40)

## EC2 MacOs remote
ssh -i macos.pem ec2-user@ec2-54-198-252-248.compute-1.amazonaws.com


## Getting Started

### Conferir se há erros na instalação do flutter:

```console
flutter doctor
```

#### Instalar as dependências:

```console
flutter pub get
```

#### Gerar o folder .dart_tool e seus ficheiros para a localização e tradução:


```console
flutter gen-l10n
```
#### Gerar assets e splash screen:

```console
dart run flutter_native_splash:create
```
## IOs


### installs on macos
sudo gem install securerandom-0.3.2
sudo gem install cocoapods


### Navegar ao folder ios:

```console
cd ios/
```

#### Instalar os pods (se já houver pods instalados anteriormente pode ser preciso remover e instalar novamente):

- Instalar pods 

```console
pod install
```

- Para remover os pods
- 
```console
rm -rf Pods
rm Podfile.lock
pod cache clean --all
pod deintegrate
```

### Retornar a raiz do projeto:

```console
cd ..
```
- Gerar a build
  
```console
flutter build ios
```

## Android

### Navegar ao folder android:

```console
cd android/
```

#### Criar o ficheiro key.properties: (project folder > android > key.properties)

```console
touch key.properties
```

- Copiar o colar o conteúdo para o ficheiro key.properties

```console
storePassword={colocar a password da upload-keystore sem as chaves}
keyPassword=={colocar novamente password da upload-keystore sem as chaves}
keyAlias=upload
storeFile={path para o ficheiro upload-keystore.jks sem as chaves}
```

### Retornar a raiz do projeto:

```console
cd ..
```
- Gerar a build (.apk)
  
```console
flutter build apk
```

- Gerar a build (.aab)
  
```console
flutter build appbundle
```

#### Links úteis

- documentação flutter:
  - <https://docs.flutter.dev/>
  - <https://docs.flutter.dev/deployment/ios>
  - <https://docs.flutter.dev/deployment/android>
  
- android keystore
  - <https://developer.android.com/studio/publish/app-signing#generate-key>
  
- apple
  - <https://developer.apple.com/help/app-store-connect/>
  - <https://developer.apple.com/distribute/app-review/>
  
- Flutter pub.dev
  - <https://pub.dev/>
