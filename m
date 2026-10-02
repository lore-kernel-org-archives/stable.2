Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C32B4A0908
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 13:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790947915; cv=none; b=DEo61jnuZxs9pahhzv8ZNjyZ6m923EvUS6rVLohjgJ3yC6+wCBaplUfbUnZZD08ucB/sUFyuarRNn5AyFw7lesV10ncbUXdn02o7nzCDEa1NKsoxNEgHPlWfAPlhTZWQbgExFdA1MxazbJJ9L1efMHTfr+2o96XP9QfZbCuqZxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790947915; c=relaxed/simple;
	bh=lxd6po6fgSciMb1Ro4LbKXumzbF23PPies3d62RHoUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KKR4aocz4FlEv+S4Q0G53rlE1UIt9vwUo6+UsMpatnse3c/FwOvoHS+ltR8AQ05Eg6LFFYRVCZ5ffqRKo1GGN2XnnahOtxtYcPmnwnd36grD0xWOq0/1J2VvxPYxz3q2c/s+j6zm339Mi7DnEnqveKe905nkmJar6kr1fBtNWus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=eaPRLQTH; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="eaPRLQTH"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48af9f88c95so1291987f8f.0
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 06:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1790947911; x=1791552711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b5IXHgAtL8/tcae5bQMBJzUP97M7snujo3DcDARBgYc=;
        b=eaPRLQTHXHdy5be5YH+uQAbyhY/2qEjVz7xp1PK5ynlkGywxtHaxuoCQMNc1h7MjVz
         CozKzjyJ+vZoZpF8lJyrAJTqhQ5P57fXQLnF6kiSlTWWdnFAsY1s6LO02UqpE62sUoxL
         8k1RV1FM70T7fIlWUiMpeYcREo5IVH1E2CyYC5ZkFrcYimLzYbH1FHJeEKQlGSFGuys3
         pxWf3pmDIQEI5Ajzv4LrbYeScjDdpFFefXrAOKfWHVz6LPzdsgNJEuuajogbdrARFEB2
         8E+rxZCdkB+TetZikEj3TG/NtYsN1Plitdh3Iyn+ZLMkDSuKWXK/nYgtKM3okvBQkZiB
         XJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790947911; x=1791552711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b5IXHgAtL8/tcae5bQMBJzUP97M7snujo3DcDARBgYc=;
        b=TAljbbQnaMa0Byq9Et3oeKX8aK949zZHrXl/769rrA+jpMf2+EPZLe12ZunRER560X
         b3AdoVIpm7q5GV3GM5z23tTKFmd0ayhiaE0zpX10vczmQqo/J/BJIqXpjXzRrKXp5esE
         9Xel/7JDKXQ/yhnJtxMZXouN1Uc52iMoRKoBClIEQHUDJs6EFqWATgDzTtGero99Mx51
         JiSPJ9uYVm+4HXvOmILEPLKx79IxciJVZDyBoPtaRL6h7nnLIePY9/DFdJzGeb80kiO+
         i5DLRaDc1+41rEhnQZTJYtrBsUJqcas0yVT4yRG9fvGPXHfEL4VxMKSe/jL1owQJ6F63
         NTvQ==
X-Forwarded-Encrypted: i=1; AKwUvBzUQ3tO/rK6fCHjkWmWq5YusDBI+wQX/pmi6QHKWK42Vn0OFKiU/2F7Cl0FOtXRiteXIIAwvj4=@vger.kernel.org
X-Gm-Message-State: AFuF++kOJZmWSjpiBq/AQwVFzamnDymmzTv05d1JkJ202QX7DBDhl4rA
	zS8mDJ+tUL63jw7YQwbZbJEjAQ/DTw0p6BcmfhAtnDOhWxngxO+bmxJ3ET4uxLl1gdM=
X-Gm-Gg: AYBFou1ao8Ls4l7TrBSUEFr/+SZjgcpt/XaEpdv/uw8+JIrVS/Ji7eynz/iP2NIJzXh
	LXAK642I+RhQcRlCuOwhnYMIR8+zA/+oJD+Agy1Eh8bQ0rIyCfpECHxBO53dqYWAkX3HJ1AKJya
	TxblUSfAlFAY/KfqWnfFg06JDV3+SBWbjNeQfOk6KmtMSvwyLlIDtkt5/J/ZKuwvPzhswysRlQu
	KfYDxjo1H/pi4gogaZkeHcOxUk7Ddg0JqFmzZZHBUicOD4m8WKkuSgkC1hrB4pMDOakH8QW9ync
	7n6uV9eZ3hpD2WtN3u4+CGqQLQVD9J5PZNXoIO+ENQ7UaaQD78UhbBLzJvo8C3JEZZX6CcEgM6U
	0Fg2EiI/w82Ah3qLTsaR/2pnt3N5qE49Zgh1gPTwHQnQ2c9N8GtGEl42m1ahBymMiX7Tg6guEv7
	WSJpK1A5N1K768kojTWh087fN9WDIGBKvBaoYBbmLAnqkqq+l6xPhQfm18zPKOq1zjTyEeIeIOx
	tbh/FjXDcI=
X-Received: by 2002:a05:600c:3b05:b0:49e:715d:95ca with SMTP id 5b1f17b1804b1-4a027561e0fmr48312725e9.13.1790947910026;
        Fri, 02 Oct 2026 06:31:50 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac6:37a8:ebe::178:143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0394e6c5asm60543205e9.2.2026.10.02.06.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 06:31:49 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Sairaj Kodilkar <sarunkod@amd.com>,
	Baoquan He <bhe@redhat.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>
Subject: [PATCH 0/2] iommu/amd: Fix device table setup in kdump kernels
Date: Fri,  2 Oct 2026 14:31:41 +0100
Message-ID: <20261002133143.3628181-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matt Fleming <mfleming@cloudflare.com>

An AMD kdump kernel booted with crashkernel=512M,high and
crashkernel=0,low fails to allocate its device table because there's no
memory below 4G. IOMMU init fails and, on our systems with an Intel
E810 NIC, the ice driver's TX queues time out, so the dump never gets
sent.

Since commit 38e5f33ee359 ("iommu/amd: Reuse device table for kdump"), a
kdump kernel normally reuses the previous kernel's table. Patch 1
programs the new table if reuse fails. Patch 2 drops GFP_DMA32 for
kdump kernels. Normal kernels still allocate below 4G, because that's
what the kdump kernel checks before reusing the table.

On an AMD EPYC system with an E810 NIC, the kdump kernel without these
patches failed the order-9 GFP_DMA32 allocation and its TX queues timed
out. With these patches, the kdump kernel reused the old device table
and the dump was written over the network.

Matt Fleming (2):
  iommu/amd: Program device table when kdump reuse fails
  iommu/amd: Don't allocate kdump device table from DMA32

 drivers/iommu/amd/init.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

-- 
2.43.0

