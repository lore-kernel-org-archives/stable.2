Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C8D3921FA
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785347957; cv=none; b=Dp2YctQ0DkHDsdB+rL5zLkL8g9WS/8vhAgWHLKTMyZQO9ocs1Z1IKUHG7u8uxfK0DayXUGeHXYU7Ps2Q1oi9Us/tk2GgrRraD49sdztc36MVdgttvVAvbXzCFhhFwC5NJiPWMHZGhbeCHjlvVJn3DLBQmlQ8XXQp111is8gMe0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785347957; c=relaxed/simple;
	bh=KVMdMfwu6S7Oc3wjhIDhzzxx5/oD69vgUPQk/GfkeXU=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=ThjuhMhRHQ2UrMuBpw0oJ11S33mWkjnjPSBehRz8+1BEKct5q4lgcVq7tZHSwzKf+s1JPheNKpjg7CfjQ6ZrfiZniM27fi812KhQCYEfbiK+X162Qe4ZzYmriCZH00y4McHt0c77Fz5dQsVIBnRmhfC/vwqzkIhyGOMXmKxCBFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=hdMve9Ux; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="hdMve9Ux"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ce7d2adef4so18999965ad.3
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 10:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1785347950; x=1785952750; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Kj+K2IwjofPvUsIgKNoi8C7kJF8UVCAmFwkEFU2TQUg=;
        b=hdMve9Uxm1DgNp2+RSkkX0t7mZIa+xoYqASY5Gl72mzZKi2ApvAWsk5Ak4XcdAa3iz
         HTIo4n/GMwv2IDDthflMHhUCDBk3ITOiPZOHpmevBtuvxvshjaE0I8/wrA6gXrLGEHHt
         9mmo/i3eRJJTZhboggogHLh6JqCp6peUjL+Yf4F5vUEtXBaKTI9T+suFQARthZe2eop3
         zJXe5NH+Q+0lh6ua5KmdaQFdyvwRBkQmQqcsgFKW30u1IX51bvf89Jszev1jWTf2kj4r
         lzePbpN2ZMvx8zEC42U+RldCYPANhjC0uA89wmLSRqyjRnkzsbAdPxeH0HolzDLe0naO
         2p7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785347950; x=1785952750;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kj+K2IwjofPvUsIgKNoi8C7kJF8UVCAmFwkEFU2TQUg=;
        b=UMG31UDImwQAFoftlmamSJQHQFT+RZwaEEnyc34lJ3Lcvjj7Y9NaywIe1KrPCXxNUN
         xGveSW9gYivYBhPSp6dtp1hUk7yYlRZXzC8fNLNvomfdkMsV0f39qUclmNt7FuE+qfaG
         GaT1Ev1mok5dnWl53ERTF8CIoA2kBTdcD86IrLdTzmG12077heSZOLKtlOFdMDlY86cQ
         dN1FYYxVrQ07lUsuYkhvppeNmXiGpob/g2AQ/NaYqRZLRM7RacllE//+sDHLLrjjYdgx
         huLzgeitDBqw7znbxjkWGeY15QkMsnHxOQOmC9DEaVTnu8VT+mqLbCI6N8dMtbflVsLw
         WP3g==
X-Gm-Message-State: AOJu0YztrwtgsUsEhntar4gE0pYesxHi70vTYmiBVDTAT6e0mW8YXr8b
	j/gqQYWGlR4EFgqoA1285YaA1h0GN6L8MdqDNrpZUjGDZM+h++DULcXSXvf3kFDlLPeIMJnySzn
	gGWqa
X-Gm-Gg: AR+sD11XqZXqSzfTDCXvNyucP3QRV4rlgcwVKI3Z8HCnbsHec8KPQqqQYN6HpSWKLIZ
	cJA6crRMFwboL3DI435yVffOEkU2KuB3cES2ql0HBFrnbUiT+d8kLVNwMUVW3mRBlkpDn+knhC/
	bixSXkGJeiCpwZAbUBncYhTW39ALLRof9j4oZ1ruBOxU+rfmmMcrFI6uyxGzPRRIqD37/kzexV2
	Kott/K0hxLwzjIo5BA9UcZBXDDcvufpxWFELOVBJVAl4LwdXDCPvWAmVoUQSrZV2hP3Lgac44ij
	XFHuywQnRXtn42trdFtMsPTX/Tm26ttuTqPEf3j6gt16t3YNgGSp66EzX1d1/aIbHut2t6tUBry
	LL8cTs/BNQMK/VFwDDIHcJXc2d3a+eDP1YBOOqOi4tgEM9nLznlbUmu66wUTHUF7JY0369ZFywl
	1wHLng77f64TKFf/V+mLZV0DgjtYQ6J7WJsGOqpEejsc98mueS/W/18bYQLcjgywfDcw==
X-Received: by 2002:a17:902:da91:b0:2ce:93a3:c168 with SMTP id d9443c01a7336-2d015c9c0aemr91238135ad.7.1785347949785;
        Wed, 29 Jul 2026 10:59:09 -0700 (PDT)
Received: from 92650adf53de ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504d2ec2asm14098682eec.21.2026.07.29.10.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 10:59:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC02LjYueTogKGJ1aWxkKSBpbXBs?=
 =?utf-8?b?aWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhremFsbG9jX29iauKAmTsg?=
 =?utf-8?b?ZGlkIHlvdSBtZWFuIOKAmGt6YWwuLi4=?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 29 Jul 2026 17:59:08 -0000
Message-ID: <178534794766.3623.16438584328718327926@kernelci.org>

New build issue found on stable-rc/linux-6.6.y:

---
 implicit declaration of function ‘kzalloc_obj’; did you mean ‘kzalloc_node’? [-Wimplicit-function-declaration] in drivers/firmware/stratix10-svc.o (drivers/firmware/stratix10-svc.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
drivers/firmware/stratix10-svc.c:1086:16: error: implicit declaration of function ‘kzalloc_obj’; did you mean ‘kzalloc_node’? [-Wimplicit-function-declaration]
 1086 |         pmem = kzalloc_obj(*pmem);
      |                ^~~~~~~~~~~
      |                kzalloc_node
drivers/firmware/stratix10-svc.c:1086:14: error: assignment to ‘struct stratix10_svc_data_mem *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
 1086 |         pmem = kzalloc_obj(*pmem);
      |              ^
  AR      drivers/leds/rgb/built-in.a
  CC      drivers/mmc/host/mmci_qcom_dml.o

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:c97eca425aa52249c5b5ea39a5b62d08baeed5fd
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  9c792855fefcc3161b47b8794beaa1a26f0dafde

# Builds where the incident occurred:

## defconfig+arm64-chromebook+kselftest on (arm64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a6a3372798ea6c1ef87b510

## defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y on (arm64):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm64-chromebook-6a6a3306798ea6c1ef87b172/.config
- dashboard: https://d.kernelci.org/build/maestro:6a6a3306798ea6c1ef87b172

## defconfig+lab-setup+kselftest on (arm64):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a6a3357798ea6c1ef87b4e2

## defconfig+netdev+nfs-root-boot+kselftest on (arm64):
- compiler: gcc-15
- config: https://files.kernelci.org/kbuild-gcc-15-arm64-nfsboot-6a6a3368798ea6c1ef87b503/.config
- dashboard: https://d.kernelci.org/build/maestro:6a6a3368798ea6c1ef87b503

#kernelci issue maestro:c97eca425aa52249c5b5ea39a5b62d08baeed5fd

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
