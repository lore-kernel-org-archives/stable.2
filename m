Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929F93624C8
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138757; cv=none; b=T2p1bquOVzT/QI47REacZTfHRzXL1yb3kcWPSBciEBT4efMGXkuc6KhpYQWatlqBqb7kqRTf95z34IBAfqiW/0ST+avOpWPC+SOKCJ8+t7oTgg+/Z+8ISBFiijdZw/F4YRlAwOXb5lAUd5ugebpweuaLnqneDxnbnPiSBfVJfyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138757; c=relaxed/simple;
	bh=TUyBRruTEKGTz5kk91TkReNNdCYPokBv2phiEAQI9yI=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=gbDYnWSONnEsUromXW1TnfEkMnp6tF8c7oHltvGDZqdh8/Ch0XvcyEH7u/0azJdIpHF4AoDHKBq8wVEOgKRhoSOuRtnyPmPV2Uro8ImCHzgSsHeE0PiMkeODDXk87IHO4leh+2fx1MfqQKa3nyuUq5cprGSbdNa0NRLwFZAPcLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=UXloXpwC; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="UXloXpwC"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccda24a3so787287a91.0
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 07:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789138753; x=1789743553; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4yT/pOgTKSVTqfJy74G8Bw1bmMB7lGRNgsNUqrvEmso=;
        b=UXloXpwCBwnEo0oCDI7CTdLKt0DJN6WzFfOh2DFkEHYSIozstBNI4THJqx1N6MHWOi
         reuMeqWi18AvtHztMRja9sc7qIYae8AyEBKl3exy4EMn9djEiYaiRCQLmUBzrJmBQveq
         EJYGMNVuP/KF70XJBWGBUqmCmdJgzw4c3g/MeaCrbfRoOw702iBJt1ImG0hScKwgMpJv
         SdKU+l6cdVg4ou4ZMpilVaFg8W684TQDjxHT4LyheBC0xBCiEKUOXOHK1/9IRg8SJZRi
         OPUlN4SRaCg6QSAiEKHvLUjVrXPF5pAPP/YEKSajFixdIOGwpTVAkul+1JUNQHZ+SZIk
         M8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789138753; x=1789743553;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4yT/pOgTKSVTqfJy74G8Bw1bmMB7lGRNgsNUqrvEmso=;
        b=JT7YCmmJMR1Tnzr/PTu36DxQtaGGy638whdXDMzLRdeRKHWD9CZYCDCSUQ2nGcmqoK
         k5Dx46NXX3xD+72M1vaAnmqikR4Wqx9ZXinxrONikjX+2chGUy6P3cPGekYzNgtpneGu
         wGjU0CVJ6khJ6K1XdYGgnFAx3uYRBp92RZ5+7GFz7/eWDZvszAoRx/y5PSjDlQ+v2yOq
         JeDKPzAsNV3EVbOPJor9/pFuS7t485wmuAYfNnYO4nY4tQMrCfNNBG0KgB0PYRZnqKwU
         JqJYCu5MkIVplFYCRvZwGAAe5ddfYTMU7uy/EPWhhmUQf/szEkqEjLGf9KV5P/WS8j3K
         90Zg==
X-Gm-Message-State: AFuF++lLjyHebnheDGubnKsc2mquHQc2tXwfv+UoihGOofxVDqQo5OtI
	ji+XaIguGGj0OO6PD0eZdQMGfk8IJUE4mzKzF86/1a9OI2gWr2iFkSDgpFDIyuzb0SRUD7Zwmpr
	e9+cj
X-Gm-Gg: AYBFou37PUN8DInYrzYwu8o7xb/bP38mX7jSSi5jzBEHbhY6nE9qr//JqrZkupAtK3M
	lE9quvN1W7Pj9SHZ8FHiQj22T32+sLSerCbMz9zQAH9Y+cZOWVCHeWBNhFX+PcSQjq+9NWvIqEK
	cZmQyIsT0wZPzP3S4tKWewB8SDcagbbRMqy7/koG/tbtQInQCkKMQgPOWvqwat97I3GTb+qIGD/
	BIqnd6NZyAPE+fuVJKd/VMHBPNXr2Zwx7hUXQJ/IYWj5LgOjejPGCb1STA6xnOvUhDcY6IuOIqW
	QSza8tBnKVzsWLR0sbQbgfzBwLG1p2hwRfFD6s1wFIwem3ivSO3qaiGNApNET4hEGmP90ZeUuyI
	zb57L2v1gdWvzMo/xEGbAEdLjVazAAMWFeDWzruvGzrjwyuqb8FctEs94TszrW09WSgu8WLLY1K
	z25KROHn6CT/3aLvHrrg/yIwHqVqHnZtq5j27ekWmCtvyIa+0MvsKq289GfC4f3AY=
X-Received: by 2002:a17:90b:5281:b0:393:194d:5366 with SMTP id 98e67ed59e1d1-39d9bdaacc6mr8659142a91.10.1789138753390;
        Fri, 11 Sep 2026 07:59:13 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365a598aasm6944466c88.1.2026.09.11.07.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:59:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.6.y: (build)undefined reference to
 `irq_domain_remove_generic_chips' in kernel/...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 11 Sep 2026 14:59:12 -0000
Message-ID: <178913875249.4387.7006965637699134343@kernelci.org>

New build issue found on stable-rc/linux-6.6.y:

---
undefined reference to `irq_domain_remove_generic_chips' in kernel/irq/irqdomain (kernel/irq/irqdomain.c) [logspec:kbuild,kbuild.compiler.linker_error]
---

Log excerpt:
=====================================================
riscv64-linux-gnu-ld: kernel/irq/irqdomain.o: in function `irq_domain_add_legacy':
irqdomain.c:(.text+0x11ce): undefined reference to `irq_domain_remove_generic_chips'
riscv64-linux-gnu-ld: fs/ext4/bitmap.o: in function `ext4_inode_bitmap_csum_verify':
bitmap.c:(.text+0x64): undefined reference to `crc32c'
riscv64-linux-gnu-ld: fs/ext4/bitmap.o: in function `ext4_inode_bitmap_csum_set':
bitmap.c:(.text+0xd8): undefined reference to `crc32c'
riscv64-linux-gnu-ld: fs/ext4/bitmap.o: in function `ext4_block_bitmap_csum_verify':
bitmap.c:(.text+0x152): undefined reference to `crc32c'
riscv64-linux-gnu-ld: fs/ext4/bitmap.o: in function `ext4_block_bitmap_csum_set':
bitmap.c:(.text+0x1ce): undefined reference to `crc32c'
riscv64-linux-gnu-ld: fs/ext4/extents.o: in function `__ext4_ext_check':
extents.c:(.text+0x532): undefined reference to `crc32c'
riscv64-linux-gnu-ld: fs/ext4/extents.o:extents.c:(.text+0xb02): more undefined references to `crc32c' follow

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:c6acff05093551ba7f563282305a5d7696049270
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  c33bbcf64a1d0e2170b7cdee977e2c00e258a70f

# Builds where the incident occurred:

## defconfig on (riscv):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa40c8320239ade9022a0ff

#kernelci issue maestro:c6acff05093551ba7f563282305a5d7696049270

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
