Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010351;
	b=K0pXZvoCrDfbmDvNKhlPWHX8PmmfZCT6tBD5ZjjSRr03jWLmN8ZS+ZbFzIiCbSTvrxqH
	 OheUJ9wMUEH2NO3jE/svKxksRZLLakiR3vRNlARMLxB/ojLityG+/fT89emnQgBEJlyfN
	 WIP8hF04XmoKma212IX6/UHLIQJKlaloEJXOaStdW8b/sTrKzCZog5o4ZPeWHinB1p/tH
	 IGM2cjFEdTQG8C6qcf99SfmMLVziE/uBM6ekrb02ad7uipwVG7TMQQrieRSuKiVrs+15r
	 +zXKa++6eCpzrrlHEMP6cBlyq/6icHT2f4JNZ2XOqN4OI1wqpjUG+QLFJSpj1Rl2/Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010351;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=dJUVwftRY1iwIeYL9P8mLEUwk3JNrF8srd3FyqYGVZs=;
	b=oGKF+BF5w1CmXUGFO+Ap0kiMicvZgQyW2HD8x033nLTkJJoEnZno+WVFgmkIXcqYQSdZ
	 /9esahD11Q5mwod/0aEPSFjKRs5qpi8v5DcOxzeqjkOs9ZQ9mwCt1liVvTJtynViF5gr8
	 BdZVOn/BI5ISOWD7iEYEm6/NO1/FOVnenJ5v4i9VT66FEy8VPe/CYAD9c+cS50Efg7KOM
	 G4mdlIvRaDxW2dhT+7y2Dkj+0EI5OhueQxlkY2z+VSibR5X5Q14htrjNA0o/BPTIU7yaU
	 I9AL+sXBUgjh9WJP56vAP8E482EpLWwws2fCbsOTID0dCNbaFMPjUMriA32hPWuudfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=Abf0T1E4;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5E9606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 13:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D5E9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=Abf0T1E4
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1a8cc11ac42so1408028c88.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 05:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795010350; x=1795615150; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dJUVwftRY1iwIeYL9P8mLEUwk3JNrF8srd3FyqYGVZs=;
        b=Abf0T1E4SSpSG0r7l45OFb62FqZDKGfIvyCMkASsPVNkyQ3e3C8wMkhEydmhglCfnm
         siQ26RGKk1bK2fjmo9sTXAcG+EZFLjhJ8L5DmSCF7n0cm152xbhsfB9+51g7HwrYib5d
         k7mEArYnnaFZM6WbiVjjAe7g7VI2Tzj9UYOqPvtRYW9EhTaLT99OpDQkUsa6WqmQT9Ca
         6q39t9xTGz+tr/lTdyZP02WPBnG5En+f61wKEbU5yv1eWFAu1Q32mzI/OcevktFyy0hQ
         IaM9JDlFtBpr2Mo625JUq/3Kov7EBzf8uESri+K6zAU0+IyxKzqjhhgfeiM5u3ppanyV
         G+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010350; x=1795615150;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dJUVwftRY1iwIeYL9P8mLEUwk3JNrF8srd3FyqYGVZs=;
        b=UYCHmEa8Rz0Xuw5cPmhUrXQ9+A1u5v1qdApTNtj0lB+cCcMA+zDLWguXjHXhYECnYG
         OOGfZ223/Jn2I5aGcih8otSkGucYdCrvnUzwuCpS/9mGJL13jCSUBHKThJqktDZGQ9wu
         UZ02skoZ3AMKxUh8ARRKThnjdqKbjDF66J3uhI/dx39A7E9rDZP3HgklLmSG2qSM6pPD
         vXiRi33nSxnZZ2/qSiyfgHsa4h+G6VLgnNPS+Db0lOvnmcEcGQMurlWh1mP3y4ZaWbZr
         prQvtpH2KRZAc1cqDPSCBzmIxouRupf6+3fGAcBwxKZdxStlwhWe1HrtL0tj6YvwgTnT
         NgYQ==
X-Gm-Message-State: APuU4Z/Y2J2imtDYpKua732oYFfqBCZkBnsO9Ii0nCul5qOlCxJoj1MT
	XLfmZAN0LOt/hlVRP8wCCjlkZwEqYn4oyTBiia4M1xxGR1Hlt1eKKfhz2RYoUZEe3HQ=
X-Gm-Gg: AYBFou1nMTsS00nQGyJTKj9ktCRRAlvlKyKFjy39lUM0FqomfgAPovPI6S4jiM49Oxo
	PPGxilPWlKs5Mki5CdXYCRdfwm9PY40tvfAq7O7GsBinDB9VifLBs8Prw3nn/TCNxsJ++MbVHLd
	BAr65PXk8uOe2/MzpZhWjIU87eX3ryuCj7eY+6qumHAMJaFdFi8TVma7nXRbRbefWndNytsUWPQ
	LjEet0bBuPT7+Mo1SRfCanTwTEmGyFs4zA/y+iGJO8Tn+5thQV6erstm58ZF+wBES97ckAbidJ4
	Pq9SR7nFZ4Ij9HYL8d/OBtyTdKrVkNfnBJNNOMfJbQNJrxXLv5oI1j9N2zxiKxWwvuEtH1OpQkD
	qKKQLlO4RFOT5NHJ21NPzTzF38NS31McptIFu4K76y0RkmF3JzX6/LQSMuw0iuyqcCfR69qTkzC
	N4b+ZGABK3YVAH2snsc9IlpbUq+7xR2Rmk0QJejok9Co7WF3F3dzkPXa3qf6zhuVbjD2/HPr4n+
	oEF4uAmTIMUX8tr/jw6Isb2wZ03BtIsKpbu4rSQwCCKOUu5ePStzQ/6ZEWpXMBWQZSik8kdHLqV
	p2dKF/TaApJfrCpXxR2ArQ==
X-Received: by 2002:a05:701a:844e:10b0:1b0:430d:d81c with SMTP id a92af1059eb24-1b543cebc8emr2494459c88.25.1795010350313;
        Wed, 18 Nov 2026 05:59:10 -0800 (PST)
Received: from 8439c401ee69 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b544784017sm6875180c88.4.2026.11.18.05.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 05:59:09 -0800 (PST)
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
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.15.y: (build)too few arguments to
 function
 call, expected 2, have 1 in drivers/d...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 18 Nov 2026 13:59:09 -0000
Message-ID: <179501034795.303994.18338228483300661482@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-5.15.y:

---
too few arguments to function call, expected 2, have 1 in drivers/dma/ste_dma40.o (drivers/dma/ste_dma40.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/dma/ste_dma40.c:1681:42: error: too few arguments to function call, expected 2, have 1
 1681 |         ret = pm_runtime_get_if_active(base->dev);
      |               ~~~~~~~~~~~~~~~~~~~~~~~~          ^
/tmp/kci/linux/include/linux/pm_runtime.h:56:12: note: 'pm_runtime_get_if_active' declared here
   56 | extern int pm_runtime_get_if_active(struct device *dev, bool ign_usage_count);
      |            ^                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/drivers/dma/ste_dma40.c:3292:11: error: incompatible integer to pointer conversion returning 'int' from a function with result type 'struct d40_base *' [-Wint-conversion]
 3292 |                         return -EINVAL;
      |                                ^~~~~~~
2 errors generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:fdf1da2535f71ff5e6cbd02aed7a0493a4ff306c
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  ca6b7ac346ad69f2084705cbed131e31f0f0b45c

# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6afd9d8699c74e1a997dc15d

#kernelci issue maestro:fdf1da2535f71ff5e6cbd02aed7a0493a4ff306c

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
