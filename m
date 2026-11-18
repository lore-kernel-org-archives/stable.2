Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794969040;
	b=w2pz0MULUya5i+xMoAyStak/KP4WoDjkgkgiPlNunOWHXlhr5aVlTEAomewXrFTWjnye
	 QVwza/dbjhtgJx5B60zmD6AEpOAi23E/3bbleADoLZkeOdKZdvPfp+1MEDt1+4lln7/6l
	 3uQ37mvuJb1xXUdGBTZCf0enyh+yw981eJte1bU+vX760Y2bSYKYWQCyt7jlL/OPfVi0O
	 NU7AgSVeqnxb7KUdiYY1cxoFF6S2rorSE1pH/OJXJRFly4uCkof9MmAHAfR+hEm4qYAra
	 0kCBhYh3Rwgf7iGqnAV3c/Fo78/PUu0hNy+5YsKs7nQ/u8mItPRlHZTSQrJYOR7tpJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794969040;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=DMAYMjFw7lq465cm9eAR7/r/ubempqskqvq1xGoVf5M=;
	b=YSZ4Nv0OOiCwoZa0Qhaxd72YyfqyOi2t1FkRZXMi2+MDlm90oKw9J/2F5YF+8s+RIavV
	 9nCatvRONFfQ0FNlMBJKJ4AMaMPh4BWenMPZNzoOOLlJldCNpSIHtTWTrEad0qAbJPlBk
	 z+KDJDu6QVO1u94hrqjWOfC9LR/syhMK544hQ/XykT2IFNRzObNlNqpi4GCV0s1KRfi5o
	 99f4Y1JPycD3xOSDuHgv453pBaf8HfYZKV0/mmTnsbaXoJLCMrjpt0i/PZ7d2jvBgwq8W
	 S6mNOnrKSjKSTXKdSkiwWnDG/zLZz7jJxxtr4U+udLWexdaNMZ3RTH6zAcxt2IiWJ7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=hCwG6oFk;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E11606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 02:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99E11606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=hCwG6oFk
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso664319c88.1
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 18:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1794969038; x=1795573838; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DMAYMjFw7lq465cm9eAR7/r/ubempqskqvq1xGoVf5M=;
        b=hCwG6oFkpxvtDomiBinUNuNyklr8uqPjQaDtjx4rlf4YY3ZzYc1ooG0bAKr2JzxG7G
         OMvEAPRHuGZxckfpAGaO3TTAEkxEVa78F2niWmJ3ZH/u85qoAr3e4Px9/En3H7rDSEQo
         YYhqG40Stw1HHWLKkiNwHsYsyUVtMfo+zpB1hxUYhTffBDogFTsYrnFh8u8I9g5F67JD
         7euy6hc33X23vAyDSSeiNYaA3vOSOgZP6Xc01o7Qkmut33UrqXBtbdRGEkwlOAxISrd5
         LyrC7IVDAYiL3cGiXWJ89rlRqRm0epgGUkKmSDpMPsU+PSN5Ou0KIv5PF7LGe8N2vEdG
         jmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794969038; x=1795573838;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DMAYMjFw7lq465cm9eAR7/r/ubempqskqvq1xGoVf5M=;
        b=EvXOvHy2JaS9IF4nm5LKidbMWlDKt5Hlv9rBwz2HaFxi3XvHPPTENSElmT++t5btFK
         KebPUS3MZr4UU3WhtolWwVyDIm2zmGp8pqU905V7Z/WyED/y2VjV2JaN/+mBZdzdT6xG
         l9UZ6HM07PPTwYf3khxu6s1tCUTinuBSzMWA+98YmqQwRsVOrGCK1D55zPhiR0NsteRN
         S06uy/0mwtHEN7HDCvz3JjqJ2+PuDrGesHjflixvY0uH3JeWL7fjj9rXl4nwxqUbJm33
         sdStJuBEWCGtFwJSrJparjOTNUyBM1M+yJww5I/J4AkS1JRhMJvTBU5VwvlM1Mzr6dB/
         koVQ==
X-Gm-Message-State: APuU4Z9X/y51nRvmQFy1rRB4k5LUWGqjjYGZqTKC/WEvEFouVlb5swt2
	ApJv94xVddc2I+XzOCLRQPXvdFKN4xpTEScbwEw8Km6JfHLlOnKez/hEgsPYProLXyg9DA1WC5E
	ZHXn7
X-Gm-Gg: AYBFou0uWm1AzitBTg2oNdM4VQjn3fdjdvI/3jLNn1m6r1eL/60yshVN/BJ7e+Xg3vL
	/tk2GAzBxqcgJL30fJ+P2rul0KB2enYSArCU9RP97uIyzDFoXVVr3pi4ABoHKA9V3qdBKJpidJj
	uLAzqN3toTNEbl7JpRh3ck8yfO84Re5ET0+rlBuHNuJ3miH+VQ3bKtP+uDn4bheZYZJN3Uauxc1
	cqeRN1Sy9UcQDINgiEwmSvWPoXKz0kbUOb48lD4SnSIOPwEFNE6a1d4OjbfHQ/4XZk//vloPTIj
	L6aTjBKdv+ZUh/qTmyJ4I0gkkuAC66HlRABsohXAqFXVDFcJeAxXaaxrRQHzyemEEfj6uRgZU+9
	Y3Y7O6XCQj95bOJMdEQbj1u82qHtsfSXQT3Ibr0dMaOjkhsuSnQgs9ymbqP94IRIvueMS9QZXs8
	o8hNpkKFugOGf/wH3rNuuU3d9us5etjVgUNS+IBmh9Ju2j/kOwbYBwqvtwF8Czf29Rz5TizKi8l
	/8NLkkjAaOi7DTneVQT1uOt8k+mVcJbYy/l+3mDEQp7puBPLBxonOaoOq8DBZF1RU/bcWbYu7FX
	0MgUHJKrvaIK5j6zsZoC/cdPwn0JKJOeMAtakzwL58g=
X-Received: by 2002:a05:7022:29c:20b0:1b2:46ee:4cc1 with SMTP id a92af1059eb24-1b543d414e7mr1254081c88.43.1794969038106;
        Tue, 17 Nov 2026 18:30:38 -0800 (PST)
Received: from 8439c401ee69 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5447c1193sm2239952c88.7.2026.11.17.18.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 18:30:37 -0800 (PST)
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
Subject: [STATUS] stable/linux-6.12.y -
 b869a5313cbfe7102873d3de318ddb68675146d0
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 18 Nov 2026 02:30:37 -0000
Message-ID: <179496903724.278076.10575304958568871576@8439c401ee69>



Hello,

Status summary for stable/linux-6.12.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.12.y/b869a5313cbfe7102873d3de318ddb68675146d0/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.12.y
commit hash: b869a5313cbfe7102873d3de318ddb68675146d0
origin: maestro
test start time: 2026-11-17 10:39:52.684000+00:00

Builds:	   48 ✅    0 ❌    0 ⚠️
Boots: 	   73 ✅    0 ❌    0 ⚠️
Tests: 	 8883 ✅  842 ❌ 1650 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: qemu-arm64
  > Config: defconfig+netdev+nfs-root-boot+ltp+crypto+ima
    - Architecture/compiler: arm64/gcc-15
      - ltp
      last run: https://d.kernelci.org/test/maestro:6afc3aa899c74e1a996d11bf
      history:  > ✅  > ✅  > ❌  > ✅  > ❌  
            
Hardware: bcm2711-rpi-4-b
  > Config: defconfig+netdev+nfs-root-boot+ltp+crypto+ima
    - Architecture/compiler: arm64/gcc-15
      - ltp
      last run: https://d.kernelci.org/test/maestro:6afc8adc99c74e1a9971d273
      history:  > ❌  > ❌  > ❌  > ⚠️  > ❌  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
