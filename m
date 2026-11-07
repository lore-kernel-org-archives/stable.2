Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794067153;
	b=MaKXaRn7Ew/GzCkulxMtAeI0fEsYbYiTyScRskAt6JBS0UmPI/Zhf1jGB0qPtLQ9nJ/X
	 CWKgWOGwMzbVgKrsfVSRDNrWJ+gXuJVa0EpuN4HzXjmVnWl+VulbHEoKuAPJZ5fK31dmW
	 QRY5omDYQBVltV1OQ/8xRKUq6v8QXCzHIzrq4nYuXWB4NixoZH8wbrMqLrq88xxA1pvgX
	 +ceuDy/wbkn+MRfhM/t5l7K8GkP+Nsj2vUPhkv9yQK1gNGVsLWH1ejs4UeoyPRqrL7nAr
	 l//A6m92wVynxRgXPUixgYGYDmSq+pkph30/GvW5VVndMz0edOoqIncYH+159cN6syg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794067153;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=Sf6AC7hRs5XMVbwntsu0gHw56cul5YWRJyyG1ROoCpg=;
	b=d7cv23fLsJMLkdtewPWRsBqRJEnQSwf6VEvMGlzwCktCTdI4pvST6XjUY/7mMZsn3WCT
	 DJeZSx+9hW2jEJpi8ARrajOodHXlaeE0okfQJu4da/jI14Im2u7+cVEJEJGN2sxmIkIAw
	 MhLq8mnPHpzIhz6YO13hhHAG0Ooz1ejLepZ6jPQLQf2POmHyV1Mumwi3nKciNsiZz7haf
	 w/ITik0S1X137mzD0vfoAvAD25s2NNDCFFHWoxJ0Vw45Z7R+q1Fq/By4jMJ58HKiBOM8L
	 5qLszVwu7LG27JfXLDQDPD29xvKJf0Fgit4GO4LELsrQh8hpazdHZWisx9KEswaxpLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=WAiSW176;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66726606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 15:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66726606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=WAiSW176
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so2652328eec.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 07:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1794067153; x=1794671953; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Sf6AC7hRs5XMVbwntsu0gHw56cul5YWRJyyG1ROoCpg=;
        b=WAiSW176sA93lMc5Km4dOLEaJM/oTP5/e+elnmboWFu9l0hE6x9psFs6TvvfL/NRR4
         YyS2fxndK9uhHYzqurLYYSsQ+LuUtd1F/onips3NnTqQIcgPD83tjb7kL1lXJayw/2fI
         RBCIya0SNDuYSEVJgOvW/v2LPsnsQwoqAhR04PSatexzITf+jQWtTrrcyH3M2koOn/F/
         ZonDWkNfQt1BNMz1t3MpUEHGDDXnRnQMF3VRjqUYkYBtEB10c9AfzJ1H2eVCnlb1z9f0
         1uaswRSls00Ud8sBWNN6yxUl77SVJ06AccAZIT1iilfAdwmkOWI1Zt+CjajKJ4/RVhWM
         AOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794067153; x=1794671953;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sf6AC7hRs5XMVbwntsu0gHw56cul5YWRJyyG1ROoCpg=;
        b=tyuLUjtEG94Xhx02CNYkHnJavSucmymIVrgh6CQAys210ESc+zFYcy0f1MetYBGHFQ
         1jEgfhYI4XSs+VSZWL5654zXC3MlnKYaT9E1qcZ3P/o6Yn1zFPGWxSDK/mqBUh4P2y7+
         hSyMtRsIi+93rh4TANiU6rp0vwQ9WUt68CaAUjn1nQbmlzu40e01UVEctITnIEjWbUAX
         V4mw/mkLyRRbtzPMK8efbGo3JNmjsferR3AkOeqSQytwF/3yzHEJPKvZNkqAqmQae+ZI
         42WFnTdQI3xAMMLt5fXsazCFYn/NpP49mE0xW7Y9/jRAWLCkUo5j7siPgt7gTC3yM3xD
         dzHw==
X-Gm-Message-State: APuU4Z8Yt95HFvAD4aE0HU0EanIpPQUqEap2MW3zX/+5CRu0a1QDu5Y3
	ilG2LLE9xhksFAtY+JEzJYuy2vt7IFgTV5BhpwhoeQSQR4M3jdaO623p2QP9Kopa9Ok=
X-Gm-Gg: AYBFou3q+vV6WzQehBLO4maYCqkcVwdzIzELgQI3VZ+7/Ccy9ocGCG7c5H/d9nLvUSi
	fqOdeQ6ogv7/TPx/CjmujXbGTUiJTRwFaAuB1ymfKO1gwaG8qbXDSqHVsBVDlJc5tO6mHtJ+q0i
	6qM2+plgvrci1rLIS5aQBd4dLJaJc0i+Ab/NvJqRa2EjEO25nudwuVUorW1NioxLanLDgvXoKGw
	bt/sl+HMG4mqqXFik/u8DEqsJI3IdRuyesUmBLj3CfuVJGcxMWQw1hLQzHZMDTHib9a1A3/NRpr
	0pNDQM3UGCIjRguHhEESWPJ5pHtVBFY7Fs92ABO21tfQRUcKNTTBAq2TTBKXSc/VeZpxpnkjref
	fDRz6xFaY2k7Vbyo5bkNT0Vzqb1DtzP8n+c/xQp8BDCkrkDeISSKYxQpqIot5MOopEXJWDidmZR
	UUQC4FoyJTDISWGqDAB6AeReVxl1132zka0n/7F34BCuL5uOUH/B+MSqBAEkggOF0+q0x0AU07f
	kY+QrJukdM8KZQsEeHlY6x9LOUNSlG59rHG9+xYcu8h33ilDc1DDXeuVEN7IzrKvzSWBqDgzUD6
	Rq4Sgl2hQdiVY5N9p7PYyQ==
X-Received: by 2002:a05:7301:1605:b0:370:d7fe:6585 with SMTP id 5a478bee46e88-370d7fe663emr3618003eec.11.1794067152467;
        Sat, 07 Nov 2026 07:59:12 -0800 (PST)
Received: from 34406640b1f4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa922b205sm17413348eec.11.2026.11.07.07.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 07:59:11 -0800 (PST)
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
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC02LjYueTogKGJ1aWxkKWltcGxp?=
 =?utf-8?b?Y2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmGNmaV9nZXRfZnVuY19oYXNo?=
 =?utf-8?b?4oCZIFstV2ltcGxpY2l0LWZ1Li4u?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 07 Nov 2026 15:59:11 -0000
Message-ID: <179406715140.479450.3416299125446737749@kernelci.org>

New build issue found on stable-rc/linux-6.6.y:

---
implicit declaration of function ‘cfi_get_func_hash’ [-Wimplicit-function-declaration] in arch/arm/mach-imx/pm-imx6.o (arch/arm/mach-imx/pm-imx6.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/arch/arm/mach-imx/pm-imx6.c:589:17: error: implicit declaration of function ‘cfi_get_func_hash’ [-Wimplicit-function-declaration]
  589 |                 cfi_get_func_hash((void *)((uintptr_t)&imx6_suspend & ~1UL));
      |                 ^~~~~~~~~~~~~~~~~

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:a20c9221f215fdea99fccb2441fcad9ae87d97d3
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  28fb23348c6d391618c8f69ffebd953abd36ea09

# Builds where the incident occurred:

## imx_v6_v7_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aef3ad95b429d354e1151c0

## multi_v7_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aef3bb25b429d354e117bd7

## multi_v7_defconfig on (arm):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aef3b9d5b429d354e117bc1

## multi_v7_defconfig+kselftest on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aef3baa5b429d354e117bd1

## multi_v7_defconfig+netdev+nfs-root-boot+ltp+crypto+ima on (arm):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aef3ad55b429d354e1151bd

#kernelci issue maestro:a20c9221f215fdea99fccb2441fcad9ae87d97d3

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
