Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793210351;
	b=BVS2iQ8hmf3eILMMhWbf72TGRJt+Kiof/Q/39i9x74oJ7ICjNMaG6wlGBUI5Ht3Wg3Bk
	 3bN4aDQrmWrT4S3SVaJsSe1sLMMY1dloPfizeHCUcBKYFhHeCEkl4ibWNMWHkUd3LN2Uo
	 KIRQRkc3/tqrztpm7a0KwjKMZHqfYy12LhrqIklleAXEZr6Qn3Qx3NkCRCNJtJHF3T9KH
	 0rQ7u48NrDTcam6ULvtpq3wucedI2GzwBfLrWcF78cBk9T3Bn056jW/aAHQV0VKTV0LEl
	 nq74Q/dw9nARmbLcImZr1TjhaFZLSRd88knVLerQfUMa3qse6fFeRh15lGKj4hPuA8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793210351;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=pogLwM2qSDiK8eijxXwnkYNv1jauyTEBfe4JKqbQ5i8=;
	b=DFH72fxk/CgNTula/VtHVnDoaGo22a+hzL2DAZeVjvMO5PM/HedeBxfVTTXb3NnMKQx0
	 6Hsnwx7hYSL8QOpeL4CwZRTZTtkiYMf5m5QxKDHikrqrVO+YPg3zRoZXHtGcBIWt8AGEZ
	 vIdvd0biXGosj1bCcxBgKyzu8CRCxdFoqTj9qw/AGlZe7ys1Yvpk+k1eWgfTESj3igHle
	 vQr0VBOlP+lxqnh1P2o/xDgxnbwp+5l8UQxluZ8GXP48GcbXBEsyFdxdZlVvvRwop6rQi
	 Y8m9aNjWUc1rK0V6Or6/BgtPf4APGBMBbndMdUyqzgAiMWvw4dI7c0CxwYA7T3wmyYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b="SUPRZ/6g";
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A09606A31E
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 17:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46A09606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=SUPRZ/6g
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1a2761c69fbso2956223c88.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 10:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1793210350; x=1793815150; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pogLwM2qSDiK8eijxXwnkYNv1jauyTEBfe4JKqbQ5i8=;
        b=SUPRZ/6g3UYNh+JZSztWbzMzJmixbodO/endqqnE4tSWy7PgHCi3lg6VXIIKx2sx7y
         fs3uPgMuaaFxuVkcZTf5XP1JAvqu0NpfcI2uIXWEOqAHUnq+hK9QwUsrQSAvEVu+BAkN
         puPOsXb4XNYEerFasOST+cfDC3niCGOXWhVuny8qpitGpne4HBJZ6XNmzPIkglNdqGsR
         z6ryNeoDaXe7Z/KElp2YeB3KMqw356iXQ3EWALKp5JEoNUZoWV8GnrBgNKteCKQGo5RS
         TVdQaC2o3E92HSNklrGycE6r/uEVIkG/JgsKR2uD9qYQL3cTNjYgsbagVcrOYc8gCpWi
         S7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793210350; x=1793815150;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pogLwM2qSDiK8eijxXwnkYNv1jauyTEBfe4JKqbQ5i8=;
        b=PqW7GgZNinMaRgPVbxDxEJw7Ax0JG5WNKQV5SzhpbosVwV1bJnwYSk6mRVhGe0lJjS
         i/3NEtBWLw5uLw1QT0gOGhEBLrInxybvJTLVi0oYiBf7EzKI5U4YYQcqs1pjro6Eh6i2
         pxz/+Yt3C77Wc1i/IdSAyqj3KV8CSJBVbqD5x9jKLnN6E5RP6heRRqYFd2/6faebcgdy
         mGw4aEny5MXq36xTCElbH1TY+7IByCByMa/dg52H5VZ13Hc7Y02fG36dtNksAxfrziZy
         pTrmKGbrPhYpjHV62pG9UzyLFL5vgWH/MIVrplPfATVZCkp4JyoNm2vN0dPR7muburFt
         fwLg==
X-Gm-Message-State: AFq9FYJ+d0hDLlttO6dZ7jEtT6iA6toLfIIj6QXqCYWR27VeJQaAe38p
	xzatvMbAKu4yWF201r2nyJgcOR4EerBM6okWt/+K3TtRcUyCVTSvIfIgRBHQ1x2mgAf1pH/nLAK
	3v6NF
X-Gm-Gg: AYBFou2tum/iG7s9KRIdffYv4ZQbsHjeLW7XUG5169K7dE2C/G05iOneWARmhEodbf7
	dvRupKPVHJm9UPSX9Lv2np9ICmqdwq6PDki7fbJ3NWyJqgg0ceJHyGZsqEZoTkHSYWkbNbcfAYL
	GB7IwC18IkbFiEacbIb+j4eWakLDrL7bFveA29Nz7xg3BXHTayVWtTUSBfw+F7ofbZx7BuSidQ4
	UZYlTbdzfOlPku/dzk04cllZ/2+LkCVUHVV4tLA32tDPkyEGtOQ+MVt/OG9QlttgIFFRlRsZQ9o
	K1FHwY5Wn6S0YsWdWWc8e1LmT2OUUNKeLrzxY31il2dBjMqfv1tTnYGBNRr5+3+dhPHalmvjHqR
	yYQp2fAmxUQd8THaV+Pkrq85EHXD2MuMC3UC1WWweDcX2v5HpE6Eq+5+wbG+T0xEyTN7aPNzuVI
	FW61MX/YDdMoO5k2USX7eSLw5bMvwaeZZYvMOzKW4FRjhkHzPWqqQWKDefLnTenZ5lhbPg/pMSw
	gv3bJPpqy++/ZbG+AnNSpOqQZpZ52SeeFPxqfAKgjtLFyNAHCxP2X8s1z2TLRvK9xwBUnBjFYr7
	oqJviVj0Oc+BKo9aqSxEtA==
X-Received: by 2002:a05:701b:2515:b0:191:5cd8:818b with SMTP id a92af1059eb24-1a6cc90e890mr3855081c88.7.1793210350231;
        Wed, 28 Oct 2026 10:59:10 -0700 (PDT)
Received: from 4cb1f8191411 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75e5c6d4fsm13174337c88.14.2026.10.28.10.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 10:59:09 -0700 (PDT)
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
Subject: [REGRESSION] stable-rc/linux-6.1.y:
 (build)/tmp/kci/linux/include/linux/highmem.h:427:7: error: call to undecl...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 28 Oct 2026 17:59:09 -0000
Message-ID: <179321034921.43309.9505103803249097685@kernelci.org>

New build issue found on stable-rc/linux-6.1.y:

---
/tmp/kci/linux/include/linux/highmem.h:427:7: error: call to undeclared function 'folio_test_highmem'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration] in init/do_mounts_rd.o (init/do_mounts_rd.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
In file included from /tmp/kci/linux/init/do_mounts_rd.c:12:
In file included from /tmp/kci/linux/init/do_mounts.h:3:
In file included from /tmp/kci/linux/include/linux/blkdev.h:9:
In file included from /tmp/kci/linux/include/linux/blk_types.h:10:
In file included from /tmp/kci/linux/include/linux/bvec.h:10:
/tmp/kci/linux/include/linux/highmem.h:427:7: error: call to undeclared function 'folio_test_highmem'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  427 |                 if (folio_test_highmem(folio) &&
      |                     ^
/tmp/kci/linux/include/linux/highmem.h:448:7: error: call to undeclared function 'folio_test_highmem'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  448 |                 if (folio_test_highmem(folio) &&
      |                     ^
In file included from /tmp/kci/linux/init/main.c:50:
In file included from /tmp/kci/linux/include/linux/writeback.h:13:
In file included from /tmp/kci/linux/include/linux/blk_types.h:10:
In file included from /tmp/kci/linux/include/linux/bvec.h:10:
/tmp/kci/linux/include/linux/highmem.h:427:7: error: call to undeclared function 'folio_test_highmem'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  427 |                 if (folio_test_highmem(folio) &&
      |                     ^
/tmp/kci/linux/include/linux/highmem.h:448:7: error: call to undeclared function 'folio_test_highmem'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  448 |                 if (folio_test_highmem(folio) &&
      |                     ^
In file included from /tmp/kci/linux/init/do_mounts.c:7:
In file included from /tmp/kci/linux/include/linux/suspend.h:5:
In file included from /tmp/kci/linux/include/linux/swap.h:9:
In file included from /tmp/kci/linux/include/linux/memcontrol.h:22:
In file included from /tmp/kci/linux/include/linux/writeback.h:13:
In file included from /tmp/kci/linux/include/linux/blk_types.h:10:
In file included from /tmp/kci/linux/include/linux/bvec.h:10:
/tmp/kci/linux/include/linux/highmem.h:427:7: error: call to undeclared function 'folio_test_highmem'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  427 |                 if (folio_test_highmem(folio) &&
      |                     ^
/tmp/kci/linux/include/linux/highmem.h:448:7: error: call to undeclared function 'folio_test_highmem'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  448 |                 if (folio_test_highmem(folio) &&
      |                     ^
2 errors generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:5156d8f33ff8f75c8afe9500cf628f15887c4c30
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  406de00ce2971abe3010eaabc26c71e84b4ee9b3

# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6ae228425c0836a8c2f04350

#kernelci issue maestro:5156d8f33ff8f75c8afe9500cf628f15887c4c30

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
