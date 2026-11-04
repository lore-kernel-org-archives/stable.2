Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793829550;
	b=VBzPvriqBkTAe3JmdHw39i3OMqFuJar7yeefnlssA8JZSuygBrDLtr5B0BlBJythB2SS
	 pW0LmUeEtUJZKtf5Rf2tJPq/ISiQSXAycz5m3WISIJUTeoXBjvtoO/q8DoZGCyM6KgQ3p
	 I2gWIxvdYpZpZ7JQimnb840E3Tj5petBYYp0ZPXW0I/UPziqnVNO0PViugehv09CCr91R
	 dz1J7Oc54lDUOlIWIvHLWClbgcgswD2KfhV7q5idSe0T8BJ8np4I6MzMOIsIy6HoYR7r4
	 LRM1gHLo+5WYLdLhs89Ez0TcZiy9yc5T8nxke0RlMWkH/lpnR5D4R6Q6e+aEj0UzL0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793829550;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=HOGjeCK7VZpRFJVP6L7mKTf3wU4l+KENiauumJCgqRM=;
	b=wU440l8JRIInOMJkB92o56l7cPwfKSBG+tGe0OFlCmEKemjdvInuGQN2dPtz6G/IZHXZ
	 pRBBbF5b1XhRlLXyY5AQUEUf1qGZhiARGr0BWX4JFuF+Kqi9B/25VdX2Ckf6ZCnim2vwe
	 69/kTFuq+og2vCvIEEVMcCZe4YCKgZYqRFbqe+00i7nLWBvA23y7KG2jzj/nY1yz3c5Jp
	 XiRAl+ECmJbIDdMKFXVAUqF5rzuTou6j5RmRzD+Jx7v5Ev3ZCkmDZhl4kQvl90cRIvEr2
	 SvT/xZS+nEMe6u+mKShWi69zogTiUpEYiuvOmKn5PaV+N5Qs6REwdyp0N9f95pUTIew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=i9LJesId;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DFC6075273
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 21:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3DFC6075273
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=i9LJesId
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-36d6765756fso1163327eec.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 13:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1793829549; x=1794434349; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HOGjeCK7VZpRFJVP6L7mKTf3wU4l+KENiauumJCgqRM=;
        b=i9LJesIdUTDj+2xnu8bQp0JHImHoWn2Pb2ZlJAPXW4DPbcZ/PU3ELwrVT3LVTwC7e0
         QmYLJDXUl7j0901dA9vC/AlCxUDbvB1+nWtaOFFh6UViFRgASS9+sK1SkyCu081rb4CS
         jJv82ffXJPOi9ClGtpJr8Qo9GwAjFeD8roZu0ZD4r8cIL+xize6Zf5RwkojWgSfTGojf
         dfpLugq6IBA9yhzmA4tpeHCSd+/w1iNCX0IScXx64xHKpMhiw0JwRFPaYsgCNiaLbXWk
         cLoyY3DjxoGmucPrBlE9gCj/maIEI16YdEXbQ5SWAbb8wdN+fKUNNow395YJJGdQtpOm
         T7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793829549; x=1794434349;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HOGjeCK7VZpRFJVP6L7mKTf3wU4l+KENiauumJCgqRM=;
        b=FU585SMhIjSoqTWJrYTgBvZ0Ix8wnRcYuMNnfI2DH9yLYz8ClIguFQR855feBkh5Th
         m5EXvjzU8LqLwHzxbUn0i5xjikJzEKrJPuKw2Hw1Fy1NXSuHJ8InRl8HilNIgPYH97rR
         aFnhZqFet7mE4PVLbrpfJc3qD1bq7aWas4LI2VOabVHdBkzfV0wD5i6G6zNIGHRvQwTI
         p5ZOQuDde6rDbyVjelOV3nDsFpDq8RYKK97G2BagsthcR93ARkXeyD3r/S/DOsObbGxI
         FLfBZvrjAYQwyNEzB8thnB/WKEgMry5laK6cBTCB72Zru9Q+AH0hlPr6pgkn0VhB4NuM
         Dplw==
X-Gm-Message-State: APuU4Z8ywrlGDY+EztMy1P8X8UBhQxt/YYdlFNTbyGueAhssAD96vqEC
	fPzwZY3uysxBGPXANUNGPX5IGg9LXZTDu5qAkiQvQlfCR+kXEL/qAbII6B+3s6PtINtXDWCcGki
	pDiot
X-Gm-Gg: AYBFou2jRIDDigqZjUyApBRkPAe6wBxQLuv6QSBgua7wip4+QkMY0qgCK00T/nnNcG0
	Wa+mViwk/8rf8JBf02YIAGMDyTKjB6+zZJRPKD0kIKAY5Mv51Ibad9+LJLbpv14ffOW+ZUtBqpd
	5iBaClWHEqwVBaFY/lYgSlkBWxtx0lbP8w6mvOHdECqLKhKyO4wzz5fTBUOz0skmBMv/d2OaZDD
	PjH5FJLTxdnqduMwjoMvNxiR5WPeZB5fOswLeN/qyRbDPLAHi63LnpFjndeQBlhr+5HksnHEoGK
	9WZCPBcdkIoTtSCIZ+s+L1TywRV81OiClBuCX5kirj8SxhRNZJsR5TVROLPwVOZ5jdQKqKulqQ8
	OSPt8k7H489QtYC6jvZYvBQs2KNWOzEuGIbePeLMfRw0UKRLEJ54ULLNoQcC1WHhF1jTgBCDcau
	w9A5Ob6veKLxWYb+HJqexoPMXHgc0fg9GlZ7X7qQ4HnYeKWz6vFU6dpbvGOGQTBZadZ61X10mvR
	7dYWV3jkfUcgf7Co503Mq+2OPDg8vdrwdpPNRoP4F93mmOzwe1GPfq44H6FvXAGHJXAVUbyJMMK
	ID5QcB+gWCTlOkNRVx/VZA==
X-Received: by 2002:a05:7301:6f09:b0:36a:5126:a8aa with SMTP id 5a478bee46e88-36a5126a932mr21130034eec.27.1793829548557;
        Wed, 04 Nov 2026 13:59:08 -0800 (PST)
Received: from 34406640b1f4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3989670sm13747501eec.25.2026.11.04.13.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:59:07 -0800 (PST)
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
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-5=2E10=2Ey=3A_=28build=29implicit?=
 =?utf-8?q?_declaration_of_function_=E2=80=98huge=5Fpage=5Fmask=5Falign?=
 =?utf-8?q?=E2=80=99=3B_did_you_me=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 04 Nov 2026 21:59:07 -0000
Message-ID: <179382954733.331468.11563971463195002541@kernelci.org>

New build issue found on stable-rc/linux-5.10.y:

---
implicit declaration of function ‘huge_page_mask_align’; did you mean ‘huge_page_mask’? [-Werror=implicit-function-declaration] in arch/arm/mm/mmap.o (arch/arm/mm/mmap.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/arch/arm/mm/mmap.c:77:35: error: implicit declaration of function ‘huge_page_mask_align’; did you mean ‘huge_page_mask’? [-Werror=implicit-function-declaration]
   77 |                 info.align_mask = huge_page_mask_align(filp);
      |                                   ^~~~~~~~~~~~~~~~~~~~
      |                                   huge_page_mask
cc1: some warnings being treated as errors

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:576f227846e1cfffb888e812add51c1251260b5d
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  87f290f068db5c53cdb05eabedd694141b5eaeac

# Builds where the incident occurred:

## imx_v6_v7_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aeba2105b429d354eeea8f1

## multi_v5_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aeba2185b429d354eeea8fe

## multi_v7_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aeba21c5b429d354eeea94b

## multi_v7_defconfig on (arm):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aeba2085b429d354eeea8eb

## multi_v7_defconfig+kselftest on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aeba2145b429d354eeea8fb

## multi_v7_defconfig+netdev+nfs-root-boot+ltp+crypto+ima on (arm):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aeba20b5b429d354eeea8ee

## vexpress_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aeba2205b429d354eeea94e

#kernelci issue maestro:576f227846e1cfffb888e812add51c1251260b5d

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
