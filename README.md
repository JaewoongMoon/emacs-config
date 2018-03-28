# 이맥스 설정

## 로컬 git을 이맥스 설정에 동기화
```
cd ~/emacs-config
git pull
cp -Rf * ~/.emacs.d
```

## 로컬의 elpa를 리모트 git 저장소에 동기화
```
cp -Rf ~/.emacs.d/elpa/* ~/emacs-config/elpa/*
cd ~/emacs-config
git add elpa/
git commit -m "sync package"
git push -u origin master
```

