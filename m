Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FEB366057
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 14:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138762; cv=none; b=sTeQRQas5Gh9X4tblepa1i2AyAAgtI+yaOlP2oenGsir6vu1PioO4NYh+ZtKtWdwNou636Lj4nwd+rXuXIqO8Kp44+qZChUAek7hfBaHxT3e1h7anuktkjHmCU3cOsBbls2FF2Hd/KMPc+dEzaCjli2IS0oxKmBfC7GnwIEULfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138762; c=relaxed/simple;
	bh=AB/X0xuSrX+NwSABgUwJ7866I2mzIltI2+gysFnMAws=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=feYpKO652Dqo0rM43IekZXd3hSnopaiTefZKMBBCx+9jeimJ9j9S45cZZWe8Dqw4RR22wcMGvMy+tif8xxPVu35xm9CVf8KmR0D2p3ALGRJpIa/jlHqhR+NCd2lJA34GF6aLqNGqZ90QqVA82L4MrxBoX3BmdstPLgajVYtVNGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=YR30sCvk; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="YR30sCvk"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8541875f596so797546b3a.0
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 07:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789138755; x=1789743555; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gC1Ig7pFNUTBAwBEDySF7lclqJtqwQcVJvzaR1q64vU=;
        b=YR30sCvk7wlZxSzVeNxhCyXbjGbVJAPWhNTrBLse0i2XfV30XWTXXhXmygn0feiatL
         rznebvEhVQoh0ke7yGoRPaElf7j4b2PzJ4TS1oPJlSeJr1sMgogX4P8jn0cZocFBExcZ
         7rosJQmFKcfyqyqsfPFMjpLfJ/nxlAbJp0NuMGp5hJ+VwvkoZzUmv7zEkRnxc/XsRca5
         AB7z7K7Zp4W77bD57BJx/oElO9vvcJGSUlul2xmkCx2lyAv5LPrRxpJchYE9w2MyoXDY
         Q/HRkZHN/MCeiwIQxoNizKBNPY0BwncP3KBlJcxCcjJK2CAkpRbEWNgT8lEuTH0iMS2p
         IiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789138755; x=1789743555;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gC1Ig7pFNUTBAwBEDySF7lclqJtqwQcVJvzaR1q64vU=;
        b=n5tV9sN4fBR5EaUTJd1/CTxHOC9XrKzpw33HSju8pHVS5Pd/8UQ6+1yCmlXjl/bOk0
         IiFu81vVXon7YtFy95X6fNtCICSEo5fjCTgXH4RZ2asb2Anc9CXkxqiC8IMgZD+uaRnL
         MNxp198KNWydAovHzdGIBQA/O0fKVYZHet8aZwAWY9/UJvzl1dsb3y3iWUvVyjQBB4N1
         e7J3K1ikUDwI6/bSEeMqxidnqI8GJVnn0SwV/rzKdh7vJAydF/+EfaM56p4hdihDzpMa
         wuU5ohmSdZIU8UDtmx4c5iDO5pnEAfSPNrqKCnHELGu34bKnzvuWI7hqMJLWsxn7Gd9T
         4HuA==
X-Gm-Message-State: AFuF++lcK4XuJBB9G+pmJZLmsQ1qDQuJ/Dk9F7Lh6P9MJIUBxa0diMc1
	WYS4J+URaGbYGGDzytoo5NxUmfHTyOFTwzfCGwXWrZpLh2pE113WdTbh0PVTkEmrjL8=
X-Gm-Gg: AYBFou26YZbpOf4enifsmxJ6cs2Fdn0SvD5pLserfUEUcHAwrN2488OVnJHtImd3+6Z
	D7l0njh7C58VSqD9wP/Rmb8a74po+Rd19YcfTy0zsm8HXF+sOTmCwSRjYYckbt4mZAStu76K2rU
	IbbTwNad/iQN2mF9IYqHQ5v3ezREyeMJlkQ50sC3r4QOerV8Al0Ff1p2of2+D3BYrWHZ0a5rhmY
	UYc/+XmW8zqFcPifj7oCvhY/4o5+MWc62kYN40gnKA0qPDtQKHyinDe4YIUf+ylWK2csxMsru+u
	KYIrU8UVVkZwA9OKqyUOrpHHi3kgo5skkz2e/q7/kr5aqhQIyMZXWkcspOAhmxKqeoUAi0AGbMl
	9yQq08DYvKTQADCMjAIR4R1Worg3M9azoJCaQeUzygBFjtwiR5a5lMAmByqqWArFIVa0DzbICfr
	6vW1MBMHYyQiYIsq5E39puhcQ0jsQSUG4DAFlTHmmyMZXD85nUN4KfE/t3fbr5tSY=
X-Received: by 2002:a05:6a21:339a:b0:3d3:ad3c:49a7 with SMTP id adf61e73a8af0-3daed3b7c8emr8629214637.21.1789138755504;
        Fri, 11 Sep 2026 07:59:15 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f1e434sm7222520eec.22.2026.09.11.07.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:59:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.6.y: (build)undefined reference to
 `irq_domain_alloc_generic_chips' in kernel/i...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 11 Sep 2026 14:59:15 -0000
Message-ID: <178913875471.4387.2008035205321691428@kernelci.org>

New build issue found on stable-rc/linux-6.6.y:

---
undefined reference to `irq_domain_alloc_generic_chips' in kernel/irq/irqdomain (kernel/irq/irqdomain.c) [logspec:kbuild,kbuild.compiler.linker_error]
---

Log excerpt:
=====================================================
ld: kernel/irq/irqdomain.o: in function `irq_domain_instantiate':
irqdomain.c:(.text+0xb47): undefined reference to `irq_domain_alloc_generic_chips'
ld: irqdomain.c:(.text+0xbaa): undefined reference to `irq_domain_remove_generic_chips'
ld: fs/ext4/bitmap.o: in function `ext4_inode_bitmap_csum_verify':
bitmap.c:(.text+0x63): undefined reference to `crc32c'
ld: fs/ext4/bitmap.o: in function `ext4_inode_bitmap_csum_set':
bitmap.c:(.text+0xcf): undefined reference to `crc32c'
ld: fs/ext4/bitmap.o: in function `ext4_block_bitmap_csum_verify':
bitmap.c:(.text+0x13e): undefined reference to `crc32c'
ld: fs/ext4/bitmap.o: in function `ext4_block_bitmap_csum_set':
bitmap.c:(.text+0x1b6): undefined reference to `crc32c'
ld: fs/ext4/extents.o: in function `__ext4_ext_check':
extents.c:(.text+0x737): undefined reference to `crc32c'
ld: fs/ext4/extents.o:extents.c:(.text+0xa59): more undefined references to `crc32c' follow

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:7026716632ef18722970f7e68f1c91673f5fa0cd
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  c33bbcf64a1d0e2170b7cdee977e2c00e258a70f

# Builds where the incident occurred:

## i386_defconfig on (i386):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-i386-6aa40c6020239ade9022a027/.config
- dashboard: https://d.kernelci.org/build/maestro:6aa40c6020239ade9022a027

#kernelci issue maestro:7026716632ef18722970f7e68f1c91673f5fa0cd

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
