FROM gradle:6.5-jdk8

RUN apt-get update -qm \
  && apt-get install -qy unzip

ENV TINI_VERSION=v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

ENV ANDROID_HOME=/opt/android-sdk \
  ANDROID_SDK_ROOT=/opt/android-sdk \
  SDKMANAGER_VERSION=6609375_latest
ADD https://dl.google.com/android/repository/commandlinetools-linux-${SDKMANAGER_VERSION}.zip /opt/sdk.zip
RUN mkdir -p ${ANDROID_SDK_ROOT}/cmdline-tools \
  && unzip /opt/sdk.zip -d ${ANDROID_SDK_ROOT}/cmdline-tools \
  && rm /opt/sdk.zip
ENV PATH=${PATH}:${ANDROID_SDK_ROOT}/cmdline-tools/tools/bin

ENTRYPOINT ["/tini", "--"]
CMD ["/bin/bash"]
