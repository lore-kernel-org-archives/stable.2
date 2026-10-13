Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB4A3B059F
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 12:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791893992; cv=none; b=pwRRc5DnV6Q/wYXcsmdwsT7Z8yuEEgMCF0VvgLlLZ6dahFYcflyFjmCtaxhUmN9uERv7zUSWe1HUQOJauB+RYus99Rh4zvZ55JR9CvodBWVim20bdVQnrrQ2KK+MNcv5HW+FzCXmkKFREtQE6JXbIIkVyV98C4+lD5b/q3WGopQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791893992; c=relaxed/simple;
	bh=y4qpe0tgvGpYrTTX2TUZf8EY0t68Wbod8QGn65cyHK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mfu4QL69wXbRpurfxDpkEqYKT4JcQZQwEWDXQFzNKKeVCO0dlxsuPGvjsuLLghIkSFMgdMGTp6EPM8haJiO9WMZ1Dj1D/iVpBHqzZoOXWB9r2dz0v/t5xXRctd6cTbh4cB/Ph8YmsFushTFgmxgFVrDvHK6I/EehZH+gDZAqGoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=oTLtZu/J; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="oTLtZu/J"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48bbb06e746so1694258f8f.3
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 05:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1791893989; x=1792498789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7OLEATEFg9EwTB6dtGbWTtK5m6qNSnDgXdqZaAx1bWM=;
        b=oTLtZu/JKw47jCq3mBWkw+lI99IH00RTwUwg4nJ287h/Bv7rvVfMMGvVaZExd+GaYB
         XBf9Upk0QTt3Y5u8xV9OhwksrXrg9AepTy4NM3/HHayGC+rykW1ykVCrXsOmayU7g/+R
         +sjkQBiMrEb65q1YXJ67Qt1uABjyA/DMUXOAD39aMvWRuZct0h+FTqnxw2nidmGrz8rz
         BySKQ/NJCg7PiEPzAAvv+Jk7NjZPYjTQkZyJFDH3cAu78yKvvXffsfKH8tYbSAJnHFwi
         iZ0JZgthomWf8RtKF1mD7DARPbmnxBfCHooVFSiO/w8uRbnrNZ3ZzdRseKgcYVcQsMG7
         aSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791893989; x=1792498789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7OLEATEFg9EwTB6dtGbWTtK5m6qNSnDgXdqZaAx1bWM=;
        b=SN5OhCqgP7yGJJ0UCqGflb4/4WAzG8tu8xJJf2UF+uAlRVUkioIdBulPeBCd/I1liQ
         2xc6Hr2XD3HD/ZZZpuIWYbTYO8f4T8xdgWvgJL4rUZI7ZrnTzHaH3cRx66xDUqAhRpE1
         4ApEfg8fA/eRXoYQmnDkP+zzpGQRymtk64XITy8/vMiNby7hs9KVeccYjtY+FlpMzXSo
         hqrNmOfumfyqC1hTt7Hx+K8Of44QJo4yGHuakI91hs3u2oByvahel+rYpKv8BpeMZ2Gr
         kbAubGcBT0cSHvpntF3+kNzpYfFMcP69IxcCDvNY1eHj89iG3TuvRnNarl3Ljcn6e2zf
         70xQ==
X-Forwarded-Encrypted: i=1; AKwUvBxddBEFzZWXwGZ2CaqzuI4RHWqYI76O7lGFJwzWmOtGhbO+nsd2qWX6WypvAVvKFH62P2Z4Ovs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJsQ1jk4idZ7Uy8iHqa+0Cz1RXaOUElgRip/kQAKldA6EjS3czh
	BUAisD4ucIp12V72niGFh+LsUX/574nQ7/EzL86wmsFzPmFIusPX75Il6h65RPvSjow=
X-Gm-Gg: AYBFou228ESKG+aqx5cNqtXsEjd31qKegxD8GAO1J3ilUNZ4f18a+PBLc710fvI2TZd
	9Wgc/qCxq/KHNoXqj0Qoktt9RS9Ftgl4HPPPs0w+fSPxN/J2AUrzp+13LC+vrF7x37hU0COMt/t
	3Hx9zghLsB+AsVbkYtaYJrnQASbEnC9FDLn40JW2t9t9eNAIMHsvYZI3yc4jjVuCCbFKXVfM/u8
	lbaC55gViTPXujUrKP3l6uMsiW/oZ1ZzMTzu+0jHQovtzoNjKLcGeJOgbjmGiInpiZAHjeuMNax
	2HwVQlSfmu3XuV+ZuJlngm3HnFyvodpDjNadEB7V8PKgIYA4wblpwkdRrIpPjgJB1i9snw0bhWg
	60MJ8cnsb5U+JzGFMeAXgNXTYtjX4bF/RkKQv9bI37vcQKJf2Zg8v2JModhkrMTS2KwW15zC+vi
	PO49qnNVymCd11LIXwyMEmdiV0LfV7OBC295Uc8kFxhiEwwE/BB81AugRNm+21kL+lS+eXrI6b
X-Received: by 2002:a5d:44cd:0:b0:488:89e4:c3af with SMTP id ffacd0b85a97d-48dbaae4869mr18341163f8f.45.1791893988877;
        Tue, 13 Oct 2026 05:19:48 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac6:37a8:26c8::3dd:3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc5e0asm4806155f8f.50.2026.10.13.05.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 05:19:48 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Sairaj Kodilkar <sarunkod@amd.com>,
	Ankit Soni <Ankit.Soni@amd.com>,
	Baoquan He <bhe@redhat.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>
Subject: [PATCH v2 0/2] iommu/amd: Fix device table setup in kdump kernels
Date: Tue, 13 Oct 2026 13:19:42 +0100
Message-ID: <20261013121944.4060097-1-matt@readmodwrite.com>
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
and the dump was written over the network. The reuse-failure path in
patch 1 was found by code inspection, not exercised by this test.

---
Changes in v2:
- Explain the split base-register write and DMA32 requirement in patch 2.
- Limit patch 2's stable backports to 6.18.x and later, which contain
  38e5f33ee359.
- Add Ashish Kalra's and Ankit Soni's Reviewed-by tags to both patches,
  and Vasant Hegde's Reviewed-by tag to patch 1.
- No code changes from v1.

v1: https://lore.kernel.org/r/20261002133143.3628181-1-matt@readmodwrite.com

Matt Fleming (2):
  iommu/amd: Program device table when kdump reuse fails
  iommu/amd: Don't allocate kdump device table from DMA32

 drivers/iommu/amd/init.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

-- 
2.43.0

