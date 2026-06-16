Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CAB477E51
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781632747; cv=none; b=McI8fEQvR15H8zUnWETMlk6dJz0FdcklrRRjCt4Wbd0fbG4Hvi0Jww6BZsT7HDqIvlq4T1SxfMandYjTIh20FyqGzL/s09xjlEmktvDguEE6gWA5yJIZWOMG6Az+Susjx5HIXtErRLN1+lXz8DOmTPP6E8J2Kz9fqw40nkP1bL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781632747; c=relaxed/simple;
	bh=Jk8USRVKKQrnGIlSXDKIbda0XmIUnLiS/MzWqiL3sVI=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=XxDvYHmlnIgZXUtjastackIJdbpcG5yWWnSo3S6W3Oseqwd7YJ6cTWXg0b744dJ4VrVRnPrvSQLhMMdXSFcMPCvqeR2ERQ83OSYyxWrtLc2otPy8Kw5q3IJnaNNPUoxHEc6bDtYQNqUYEJx0a2JKJJBlYpjgXlAgPVuXJc4GqB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=cSCnvCUB; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="cSCnvCUB"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-307631dbfedso10333339eec.0
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 10:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1781632745; x=1782237545; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0H4CeMlHiZWURMp2Vh8ZB5H30yIJIASfffy9npAxJA=;
        b=cSCnvCUB0vaiVQoEXKk8Bmo2wvPmg04dHkGHLEYt8cM6070BG+Q+fjFPjesDqWnEIQ
         m/uYeIzbZPBVZe6K5DHriQELTlHdjR9+pcjXEVh5Jwi5xjPiZTtBjZNW9i3dkNbfQtqB
         kIFxYh2y2Hxnz5Tk0dx5g+5spla0CwvQvF4EB+1x+XWMwQkACXO147czMANcH8wYvWF4
         4bYVU3ffTn+17IjE6IuNwbXVYBKYZOKcZebjfeUFRB8+p/uyUJvx9tDHXE0/g34XVyZ0
         k5MZU9RGRK9QwkmkWML0E7DAlPN9iI4zBiaEWE1u7M1kpXyVhhkQoXctRM0OY0BXeiTJ
         EEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781632745; x=1782237545;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q0H4CeMlHiZWURMp2Vh8ZB5H30yIJIASfffy9npAxJA=;
        b=B1kCcRhCBj1yeBy3YLhi/MvppCp/6sqrQKMF06iNFtN2vxIkPZ/B5mpJxVCEYuaIXm
         iyhGhEafn87fjx5ZySwKbuz4azSIbdq+QoaiUSTTAeHKo4Nijh4drUFaJbXdqkeUcIYX
         C7LQZsKqnRaROIMD1R7Jf+XBioPwTmf11CY4/Q+JxVJv5C1ved3SE8WHZe0X+ZhcUCno
         L6GIncighJqesrBTfDZ8PNUIGPkqof1D7W1ucrurJ85QWMA/MuUc/uwNUoxNgtUVGetM
         i1NLYNP+aYjAFs945xE4hzcV+eacZhQdIQNpT2H0m7IMGgmO1UGVyqmpGPgIlh8A/RRf
         lTSA==
X-Forwarded-Encrypted: i=1; AFNElJ9gFOa4RVCh0OeAa2SJGZrbY1bM2wToUl3v/pW1r7kjho8gPhZU7Is/0hlCyuldkvmrEKlWLn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMp9iF+M57RlpN+AAfgnV08/aX8aVmu7q6tajBhwVwk0rSz0me
	ud4OJtiqKjF5teJEAC+Ex2AJpxLzPXa3kd8T0vCzeGuGoiiaTPEdkVeB0poiBwXOSjA=
X-Gm-Gg: Acq92OEJWaIKc3ODC7rUt4k9ArTvvCU2Hm7QPJA23+bs8Vb2hkZru5smnu7Y6G3SxF+
	k9Bl2uo0WXZBX2mRr6CdH2ohqOhlozxib/XyhsGkNAewJdoctkof9b/wBmwuFFaoVGp5UX1Ay4G
	IWaeiNt8uq5NKXHUxDbraC7GWGMn3De1YK7GNZOs4iQdi0OxTrDbd2l3SGOYDvl22bOq5XeyFtq
	S9vUERrEJZyBmYBSrLVD3DnL4spot77B0XYtNWT8sbm4yRymCaQfmzKp2gkqcS1xtMmBFepVcaC
	EEj3qUQQGurvQ3HQzt3M4NyoZM52sawccomBJr4yU6KFyx5mhOjGyrxLICsVVEgg35C7peMsp5l
	K+fwmzUYSe4rupPR86L2AyaUDkMGwU6tCdvaisEgxiWJfsbQxQeoZQrq7R9XFMEfPOEAhU8ZHFt
	6cmbAu3RMnFTqiBKyL
X-Received: by 2002:a05:693c:3109:b0:2c0:c5e4:605f with SMTP id 5a478bee46e88-30bca10ce70mr207486eec.24.1781632745160;
        Tue, 16 Jun 2026 10:59:05 -0700 (PDT)
Received: from 330cfa3079ca ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081eb95450sm24463639eec.28.2026.06.16.10.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 10:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC02LjEueTogKGJ1aWxkKSBpbml0?=
 =?utf-8?b?aWFsaXphdGlvbiBvZiDigJh2b2lkICogKCopKHN0cnVjdCBjcnlwdG9fc2NvbXAg?=
 =?utf-8?b?KinigJkgZnJvbSBpbmNvbXBhLi4u?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 16 Jun 2026 17:59:04 -0000
Message-ID: <178163274374.15780.8786280632641904056@330cfa3079ca>





Hello,

New build issue found on stable-rc/linux-6.1.y:

---
 initialization of ‘void * (*)(struct crypto_scomp *)’ from incompatible pointer type ‘void * (*)(void)’ [-Wincompatible-pointer-types] in drivers/crypto/nx/nx-common-pseries.o (drivers/crypto/nx/nx-common-pseries.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:1375b68ba02b04141195eefa90ac22ac50bec7ac
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  6db5a9e163ae633aafc12ac53e9fa24e7e6919dd


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
/tmp/kci/linux/drivers/crypto/nx/nx-common-pseries.c:1021:35: error: initialization of ‘void * (*)(struct crypto_scomp *)’ from incompatible pointer type ‘void * (*)(void)’ [-Wincompatible-pointer-types]
 1021 |         .alloc_ctx              = nx842_pseries_crypto_alloc_ctx,
      |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/drivers/crypto/nx/nx-common-pseries.c:1021:35: note: (near initialization for ‘nx842_pseries_alg.alloc_ctx’)
/tmp/kci/linux/drivers/crypto/nx/nx-common-pseries.c:1022:35: error: initialization of ‘void (*)(struct crypto_scomp *, void *)’ from incompatible pointer type ‘void (*)(void *)’ [-Wincompatible-pointer-types]
 1022 |         .free_ctx               = nx842_crypto_free_ctx,
      |                                   ^~~~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/drivers/crypto/nx/nx-common-pseries.c:1022:35: note: (near initialization for ‘nx842_pseries_alg.free_ctx’)

=====================================================


# Builds where the incident occurred:

## ppc64le_defconfig on (powerpc):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a316be1ec8c02389388c38e


#kernelci issue maestro:1375b68ba02b04141195eefa90ac22ac50bec7ac

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
