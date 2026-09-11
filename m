Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA0235E549
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 14:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138761; cv=none; b=jGUoeBLOliRuWvl2XcqDnpkbzQcJL6Mx+eekzRHTE9rVL31AoOSJtniCKcgdlkzsg50JfkwBupzUD4FANHHGBtsXdBej9uSoknBsL2aXe2yPj7lvuStLjwQLvFbbhwylzUCIIJbn8JJ66HdjXg8szqdCC2cUKZNGU9UlaaDWJVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138761; c=relaxed/simple;
	bh=nS9l+34xdX2/uEEYtQgfdO7mR1z+B2bud6L1Zd5vlN4=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=cAP1uC64UVv9S/fjoQRaQSYS28HH9S9fNPqPfy9OrXnXBdU6ZiWNvhRquuMiUJXGDUAn+TnzMfNLshEkovVDR9oUGbRQXHwvvFWHWhPrLb7w2Q7O+EwuaH483Ocx/VqUAeoEAo/MXFpqec2wmo8g5tiJCOJ4cvrmvwLocqOS8Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=IGmuXJ+B; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="IGmuXJ+B"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d8f265cbe6so9788745ad.0
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 07:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789138755; x=1789743555; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Skd29GhxgAeTUJExCzjBSINvdpnDBkmBpN02E7wcTbo=;
        b=IGmuXJ+BnmvOqty4LZJNLaPwkRCGJ2opCednB94N+GtvvFUzSxsh7lvP2qNjDyMg3z
         /XmMXVCIERp70GQibV1v7yGhEKUlKFmiHD1sso3dl8IuUS/GzOCVdD4acRO46F8AdoQb
         Paee1q/8V4ZliBGOjgib8lxnOAg4Hy5s2sBq6UL8um7wFtoK6SroBYGIpksehOvSJkYt
         mE7x7pIs47ZT3f3Fd3+FqrlSZaULMNdaDReHjT2vudqnzUKD5Gny2ITnuSRDMF2MAylm
         ntZDcHRxBULULyeIy4EmgeDHWc0iv3/JJuUVD+SEodi/EsoxM0tOCF8DTFwwUEtxegKk
         OBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789138755; x=1789743555;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Skd29GhxgAeTUJExCzjBSINvdpnDBkmBpN02E7wcTbo=;
        b=B2fLt+xNz27gp50VsobdLp0s9pR7/KYbPDOxN/viDuvnYTnjz9DI+9KCTqB+jO7vBu
         7hdwPcoUYrnE/buUYBYV2oUBzETQ8rxoj7R61Rd5nju+TxZ/HJ5siiGoPE1juRG1eGoG
         ljeIAFQL3DbfsFRf5jNEy35SpYOmhXccAX/HOQCi9RwbjSOK80hUcDMSqLopd7pFY2Kj
         Q86Ftft1Zg1FOA8iNBrXCnKNuMIw8hWELS3EEe9RVpggXSoQmCr1W9Xn/zP2iE98DnfK
         /DbP2MDhGHYpC+RL27TJTeaDDhLSJtJyxpxk+MjifL31YBk93PL/0KYqGKdapR4fAYPt
         N/Cw==
X-Gm-Message-State: AFuF++m3//Ja6gojMZH/GgpmTBigZsTziv2qstcL/YGOTOXpnJxPTOTV
	1Tmohxze8gN/U/DzLgw1TP6JrqGCKDwM141fLeitDoG0y90dE6hlbP7Gp2TVBmOhkMhLBtz6vZw
	WlPVF
X-Gm-Gg: AYBFou1/v7Fa11U2Kag1K1hKJku1UbFp6Yij8YZkwsiNUSIqFW5nsK/e2JihHg/U49Y
	q6oQLoIq/tMFXODSi7miWZxkgJSF0zUsQZSmD00HIamDoZlnY2nx/7LcOAnn9aUnYefmTI0ObY/
	ZZS0ZMvtD9+g2GOzj+MkSVL5Wu2L1XMNBJ0TD8gPcK2nuuVERIeeB9DoqRN6+Vgz0QIFiCZZTiB
	2YVIFAmXc2S3hzVQNPwW8ckwUEj3HYkMRqgHanfevQDMuM5qdQ1Mc9AiMqN89HgfusrXj5YfFXZ
	pCFwGBlpsLHKIrl5AOmCNFlnvPC/l2aGDL+XJbXyCC1UQtUfZ7KvBUPYj+mpa85GCQ9j/o1GjyG
	HTJOa/epyo6bkW1yuu3+Esmm6JqTZjecwi/W3F0rtX0iv1jvC/MPzcqVcn63G94cV8aOgZ7CQf3
	gyofvIiKFouTPOB6eoK63+QYJ1qCMMoPPhhuIVmXa8dz2MEAFI8f7Ix5E7b2SMjDSJ
X-Received: by 2002:a17:902:d4ce:b0:2d7:5ebe:a588 with SMTP id d9443c01a7336-2dd2a3481b8mr79173185ad.13.1789138754554;
        Fri, 11 Sep 2026 07:59:14 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e95075sm7286454eec.11.2026.09.11.07.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:59:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.6.y: (build)undefined reference to
 `crc32c' in
 fs/ext4/bitmap (fs/ext4/bitmap.c...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 11 Sep 2026 14:59:13 -0000
Message-ID: <178913875358.4387.13350606724568735926@kernelci.org>

New build issue found on stable-rc/linux-6.6.y:

---
undefined reference to `crc32c' in fs/ext4/bitmap (fs/ext4/bitmap.c) [logspec:kbuild,kbuild.compiler.linker_error]
---

Log excerpt:
=====================================================
arm-linux-gnueabihf-ld: fs/ext4/bitmap.o: in function `ext4_block_bitmap_csum_set':
bitmap.c:(.text+0x140): undefined reference to `crc32c'
arm-linux-gnueabihf-ld: fs/ext4/extents.o: in function `__ext4_ext_check':
extents.c:(.text+0x258): undefined reference to `crc32c'
arm-linux-gnueabihf-ld: fs/ext4/extents.o:extents.c:(.text+0xe6c): more undefined references to `crc32c' follow

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:496c66186ff93925f79d437d8bb2e7b5e65c61d8
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  c33bbcf64a1d0e2170b7cdee977e2c00e258a70f

# Builds where the incident occurred:

## imx_v6_v7_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa40c2320239ade90229eba

## multi_v7_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa40c1b20239ade90229e99

#kernelci issue maestro:496c66186ff93925f79d437d8bb2e7b5e65c61d8

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
