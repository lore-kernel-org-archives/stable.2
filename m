Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793840348;
	b=ZshqAV9c5rkAYBhHaUvy9L/12SU2imd2aPl7IOl63Nk/zTnvkMwYa3iOvNeSTThFb9Ya
	 TlQhmn4ledkIH8q0tZTAz9Mk0htCCASOiCiWLtSXz9TUbBlkGJj2vUUYBPafYMyIq3D2T
	 9nBoDjffY21q3+KsOXI1lzDXoXeAwTPFyYSMe7EMWw6zSuacGn28HreaRrUeLifAssAc5
	 xNkZIkh98vXQIpViC4y2S9wQi8ZS/FAUXy/2oG0fI3SyBwS6yhr9uhVndLLfSSO8TUK97
	 Br9Lw5tYstuIBS3hhnaPNW0gPDTxp4IeB5NnRii7XzvwJwrIWnOKeTcKkfiOjPfhRhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793840348;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=SlhpeRNGvJ4W9y0s1b9XQoCV7Lu/lLWTAkHf6eGNEsU=;
	b=cCfWY37U7deZMq8MC1vtOCC4QNp0J3dCwq3ndleSJ30RNhM9xVOAo6iKIyr4icEayTey
	 +7eE6DvTJWrYtEnoiIzAzcnu+CnM9gttOOCvnqM6EvcarHPAV7UltQUgkHMOw4JB+nlKx
	 vN4DNAqu121Us0cHIdn+A4D6jEQf1Zjt51tlfWSRI7ABUkRJdtN71X4xvtG4QxOY5qTsd
	 y8Y0UZgu12sLn5srONyUHXajQIHjn1t7DteFbj9C1Gnmn7X1KRUOCSp7THlLp1QUEyXqs
	 TLsWJENKm2m26YMZtzVtvAmb2FJoGBTLGC0sOs5yojEiM2+1IiPho3Bb+38TEzEdgug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=WhcFR7RN;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BF0606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 00:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2BF0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=WhcFR7RN
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-33fb4680717so2358064eec.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 16:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1793840347; x=1794445147; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SlhpeRNGvJ4W9y0s1b9XQoCV7Lu/lLWTAkHf6eGNEsU=;
        b=WhcFR7RNtwE18pjKXpCRnWoSgK19GaM+UaLz5UzRl8KPbZPsziQSUfwmo9aWgCPidg
         sNqg40V1tsuIYDAUisMvv7vkOCNUCJPt/Pf451bCayy/hvk3HpGn86oygD7HxjRwcMff
         5QCVEoOBDkXFHIXN87Rvss3qpav8NBbisxrHXMCcCxqBtTFBZzoys44qHAztdgtEiXyZ
         54zg4UvlzmPaedytKm3Uxff61RnKCIIdWz8KkT6QDiqg7OD324mjye472paxF6j0kjMY
         TTyYrZRgI5Zft5cb/kNJsSZr6MkxBOPvZo2OkSOm99W0smSgoqABntXTcNg6gi/rDx/G
         KYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793840347; x=1794445147;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SlhpeRNGvJ4W9y0s1b9XQoCV7Lu/lLWTAkHf6eGNEsU=;
        b=c4BStxIj/EOBwoQu67Q9cdVjsxbA75Yb3ARNdLULlghQUW0PLyu1gZn6Y8Zw1r4yg8
         h/ofNGtunkaVH5UxeZtubKrEo29vMkk2znVX7gxBsRNhNfhRZpp55Z9v2XPswwHC8Wei
         inK/wZKzMgxdkjCPG2uafTRIlzoFjuKLsdtShYCK+j7rsPAHoaVh3MwlfmbHFaBYSEk4
         maaJDvsLAm57DVNClR+XLfrfWK0/vPbeM/B5LIxYIKqsVyiuvA8PjWV3xpW99XZ5k+Xy
         1r37pVub0/sWW0ZnE1j8K6bbqDi38UPM3al7QLQ4qztOfCM49R70U8uHGJCVMFHq7O4w
         3ckg==
X-Gm-Message-State: APuU4Z/CA4FschOvr2szUbPmbvB+ckDrUykZRAupC6RnA17v1Fr1VnlK
	6veTbOYowuiF36J7IzLWFTn9p8y8UptC+g0RMylfe7rHchf7Urfbe6mYHK5w63NwBL9O8Pa/lGV
	J+yEw
X-Gm-Gg: AYBFou14v+HIwFkNBFbGQirlxX1xD6MDzUXbLeYYHZ5P+fB/coJexbDznC5XUdrsN6D
	gzZ0XWaxj7Th7d7Nq8mVNpweOOHwetj6NFTudRYb8LA6QofqtVm9gBiVJ0ADrRHsBjxGMD5qMJe
	hhGSDWwuliNx4Jy3SOQEY0p05GbJx2RnaG7iRac5LvqlwiVBHSgk+xCHreCl+Lk/cyq+39a7kzW
	z+o9LoUFkD57p+oh2/wc0PY2QKEKPvVtpu0Bq/eA5FIoGmNJkVj7BQK0JkNu3NZXR18ooOYjen8
	BwWNcpbWrusyXpYcMnvspomqPAigP1Tdz+2Gqpm565B962q4PorttLA0L/OUNkTKTtwGwr36ky0
	octLQkJErHXSSljHGvyaejtqCjOBLZ1wM6nMCa4WMBEs1qZXBuv0rFSTwSsCvddkUeK1H4nH9b0
	3py6ssf+iHeKF1jgEooLa4XyAZvR4Gu9vwL8GhYmDRhc5k1SdRoQA4+EAdisXFm3fQW93GL1QuW
	zoLkUDXegOJ35iQkcRbmPptxvGoB3uf37vx/fs6i2sBHjWZ9mt1lBtkq29h3YtTZ+KJOhBQ1syA
	MPRLI2mSfu07tvM4bjW69A==
X-Received: by 2002:a05:693c:864d:10b0:369:9062:c392 with SMTP id 5a478bee46e88-36a424261c5mr29832393eec.37.1793840346473;
        Wed, 04 Nov 2026 16:59:06 -0800 (PST)
Received: from 34406640b1f4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca39b8eb3sm14948210eec.27.2026.11.04.16.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 16:59:06 -0800 (PST)
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
Subject: [REGRESSION] stable-rc/linux-6.18.y: (build)variable 'error' is used
 uninitialized whenever 'if' condition is t...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 05 Nov 2026 00:59:05 -0000
Message-ID: <179384034406.338301.15557640860251283864@kernelci.org>

New build issue found on stable-rc/linux-6.18.y:

---
variable 'error' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized] in fs/xfs/scrub/agheader.o (fs/xfs/scrub/agheader.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
fs/xfs/scrub/agheader.c:123:6: error: variable 'error' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
  123 |         if (agno == 0)
      |             ^~~~~~~~~
fs/xfs/scrub/agheader.c:435:9: note: uninitialized use occurs here
  435 |         return error;
      |                ^~~~~
fs/xfs/scrub/agheader.c:123:2: note: remove the 'if' if its condition is always false
  123 |         if (agno == 0)
      |         ^~~~~~~~~~~~~~
  124 |                 goto out_xref;
      |                 ~~~~~~~~~~~~~
fs/xfs/scrub/agheader.c:111:13: note: initialize the variable 'error' to silence this warning
  111 |         int                     error;
      |                                      ^
      |                                       = 0
1 error generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:3345b57e716989d3671b62ffc076466c21710d7f
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  a7c80de5ffd00886e3e6b7469611536b0d481cda

# Builds where the incident occurred:

## defconfig+allmodconfig on (arm64):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aebb2ac5b429d354eef24a9

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aebb2a75b429d354eef24a6

## i386_defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (i386):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-i386-allmodconfig-6aebb32b5b429d354eef319b/.config
- dashboard: https://d.kernelci.org/build/maestro:6aebb32b5b429d354eef319b

#kernelci issue maestro:3345b57e716989d3671b62ffc076466c21710d7f

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
