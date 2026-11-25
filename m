Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618767;
	b=GbQJtbq9RbjifpSi2uHA7bLIztOVTZJ13EdaW3lsy0LZKWEnLb90V8g8ixxPDgd3nZuk
	 SxXd+KTScrKLYhDx4wYC7HFS4xSloJusnUqmIGJB5Xlfr34dbhNwuEKSmV8ORI/tL5d+W
	 ZmRw5lb468ef+IpL2wkDtkYspeywBjq9FKjIgwOG19zkMTaUlJy6tza5CXhM2JFaajjJl
	 aNxGJCcKf1TndFkIIH+7ZWqBxEimtP2xLZv5Qi8hisYIVDVQ/aj7N3W/JbJkBpXSQs9Gc
	 45Gc5lBAtje4UbZDLdIUsTmwESXwIDAc0sMykr6nKRt2wRTEfGUwanpBN3zXo4lxyrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618767;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=/MwJibSw5T48QBkvRb4xp23HwjnJQsCdX4Awyvb6ALw=;
	b=M2hXHdTEfuzpzpbBNGjJXR5v/9CzWIz3SPtck6R2l1IOQ6zKAAjTLABNKvQNINZvFRnT
	 9H/VyXPbvcTAhR0XPzIe6Qz7rjeUgsjihZh04b3DGSbK+Jt+XPasCfpJSoM9zZ6wNd82c
	 FJfd9u66tiLG6Fh1Yq514iGQ5w8E5z3eFqxk2AONLXTFEibuOOTDREvnOa5XqG0a12nnL
	 +Mi/nkyCf3MFUrRErBUAMPtrQWt2IhVL76AHlDodsnU90uy2XBlAJhq6xnQaxDVhwmUPq
	 P+Nu1Gb76OuouGMqnUWyVdGQaI2UC5if2Fc4v1de/unLo2InRlwDbAGmgzdKtxrRcLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=KA2cc6IO;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9C0606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A9C0606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=KA2cc6IO
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1b563e5cbc3so192723c88.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 06:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795618766; x=1796223566; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/MwJibSw5T48QBkvRb4xp23HwjnJQsCdX4Awyvb6ALw=;
        b=KA2cc6IOPTDMpgy9aTHBkJgZXvkrLkmgBhcHqrv8yf7+f5S9q4PwM/hHBWKhzG3ZTC
         IAQpBfWw1OrF2wT+pC+IssVaPe8Mbo3LDsCm6iXqcPZZkT0O+83cnaRmThGEt51kx3mo
         gzrSjulaWuF81a/XoRbfJhpnILgtes6liDOw4IKXxNKOG0ob+DCgFg2pudhrLFTLs0oL
         /RYkZb54AbUNi9tfY2X6lebuURMAVH1HEUdwoiOq+MDjrLWWsCbbmY+msL58h9ZZNPZA
         vHeWAIDmUv5kHr4A741ShKF3SCdoFTnPwE4XdpG7WTNVn+LQaUt4bVNLw3iM9zktxKzN
         HFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795618766; x=1796223566;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/MwJibSw5T48QBkvRb4xp23HwjnJQsCdX4Awyvb6ALw=;
        b=dpVTcAYvJRSJXrrhCDOeEeikWszQPU4jxgdrZSrWAjB5wBbUpfTUWcusYXxP1VbF7f
         9gwzhDdhaZTg5Fg68J30QUS2NULwEQCHtnfM6HPyEYjogsoSsfu2QRfJNfxO+UMlBpA/
         SJpx6pHNbp6+r5HRLy+gCh4WOdH2HgRdYYAAIzmHzoqVV0QqTF9q88947Kd9i9FlSQKH
         V5BjimAjFQD0gBD5fUi30OB3SNs0LPtb6+JYRvM9s4mHOYyrHy44MnnHmwuSQzfmPMvw
         g9rfFdS03CKHaxf40WPHfF9awaP1WpXSI5Chwncu8JCAiVybchP8eCWN22T5jrdExSm/
         hN1g==
X-Gm-Message-State: APuU4Z8jNpbWPsSgs5BThRWDt/I+ERO7vgpmKbya85A9CtYGetuVmf9m
	zVDf2J6dCWRfmoCX3tLFhOFCE2kL/NFsu1+DmwOw9LCm0r+6S2NaBjVHZgwED50v7xoIKpjqfuD
	GCk7w
X-Gm-Gg: AZFdTZesbAty14IQgJ0YX7yq9bI7GhPpF+XnGNqC6UvSl6DTU0KGoHZ68ghJ1iPlhSx
	xvknXiVeH1psThB9cDfsMCbGmjFYM1G4CIGo2KUM77fCCcWG+ODUHCRGxuwR48OykwxqujypXUo
	XmlEl4uLRnCnYcDx+oWp1naaZul09uf4SEM5azx0RPVlm5RAwLC6JtHPzP1D3Ipz90slb+6R0Dm
	eRQl2r0zlVhx8eX6zm2lvVe0ByOixk2+950DGoSSkFxg/Q28tOqcMHmVzBMbls/dT/jSiztME+v
	AaAioZ7uVVT0rV5D1qYhPFY6SQMfwecW7Ep8GCu3qSiU/MlBknYzG2KmhgAy79VFfr4wrL/M5qo
	3XoNpdrWDpDomJ4YzQI8geA/IwbcHBnVM1WJ9qTb5wYOJB9LA0Bs2QiufpoXiWz4NJq8bSu+i4x
	MuZ68+pE+8VgNF0EySes6Br5P3VmOc7itZjhIgnGLemQS6Ac1xfIjLF3YCeyIavb1V3JYTEx9Mi
	5Qjp+Pgv6iGNjjg8vXDZDd28rxvzRpO7yepa+b+0rkPVP8CouY8fL2XZeCxx7BJSdA5866M2Sjt
	7h3QT8eUVj/hNFN2zKLnmg==
X-Received: by 2002:a05:701b:2603:b0:1b2:5ecf:9bd1 with SMTP id a92af1059eb24-1b55249484cmr18677773c88.7.1795618766164;
        Wed, 25 Nov 2026 06:59:26 -0800 (PST)
Received: from 52d83ede7c60 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5568592adsm42019326c88.15.2026.11.25.06.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:59:25 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-5=2E10=2Ey=3A_=28build=29variable?=
 =?utf-8?q?_=E2=80=98cbnl=E2=80=99_has_initializer_but_incomplete_type_in_fs?=
 =?utf-8?q?/nfs/nfs4p=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 25 Nov 2026 14:59:25 -0000
Message-ID: <179561876529.101431.9964479734950720653@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-5.10.y:

---
variable ‘cbnl’ has initializer but incomplete type in fs/nfs/nfs4proc.o (fs/nfs/nfs4proc.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/fs/nfs/nfs4proc.c:6941:24: error: variable ‘cbnl’ has initializer but incomplete type
 6941 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                        ^~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/fs/nfs/nfs4proc.c:6941:54: error: ‘struct cb_notify_lock_args’ has no member named ‘cbnl_valid’
 6941 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                                                      ^~~~~~~~~~
/tmp/kci/linux/fs/nfs/nfs4proc.c:6941:67: warning: excess elements in struct initializer
 6941 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                                                                   ^~~~~
/tmp/kci/linux/fs/nfs/nfs4proc.c:6941:67: note: (near initialization for ‘cbnl’)
/tmp/kci/linux/fs/nfs/nfs4proc.c:6941:44: error: storage size of ‘cbnl’ isn’t known
 6941 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                                            ^~~~
/tmp/kci/linux/fs/nfs/nfs4proc.c:6945:33: error: ‘struct nfs_client’ has no member named ‘cl_lock_waitq’; did you mean ‘cl_rpcwaitq’?
 6945 |                 __wake_up(&clp->cl_lock_waitq, TASK_NORMAL, 0, &cbnl);
      |                                 ^~~~~~~~~~~~~
      |                                 cl_rpcwaitq
/tmp/kci/linux/fs/nfs/nfs4proc.c:6941:44: warning: unused variable ‘cbnl’ [-Wunused-variable]
 6941 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                                            ^~~~

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:e9fa331f149da8c86ff89158e4022079093db90e
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  8e2fb60ab96e45de1da9779df42907b2dd01b85f

# Builds where the incident occurred:

## i386_defconfig+kselftest on (i386):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-i386-kselftest-6b06eecb286e1965ecb35a0f/.config
- dashboard: https://d.kernelci.org/build/maestro:6b06eecb286e1965ecb35a0f

## x86_64_defconfig+kselftest+x86-board on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6b06eef1286e1965ecb35aee

## x86_64_defconfig+lab-setup+x86-board+kselftest on (x86_64):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6b06eee9286e1965ecb35ada

#kernelci issue maestro:e9fa331f149da8c86ff89158e4022079093db90e

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
