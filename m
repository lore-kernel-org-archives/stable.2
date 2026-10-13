Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDC34F68AD
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 12:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791893993; cv=none; b=nsf/iUimCij0VfhKAvtnj6PMy0ADmvbddej/158sgDSRtHRZ2JQurHluX548ifBR+r8IWUhvVKZocJYZ0x5QLkMHfWrMoGYdCdC59jGrDme8Pak1L/wWEAsqLj3YNTA00qn4h1p9LNMwwyj3BCjW3eU3NpVcGdFo69iruicU3rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791893993; c=relaxed/simple;
	bh=s5emk8cFtirRGCseiGygX//y5idLtVzc0HzJCE1i+YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=txu5kZGiq/FOWd77GqL5ZXZUoHIZr28gC4cDQACeJs0e7qakkKsDGI7OtsmnKaVipMkPDw9Yg3DCxoJ2qmRTQ2RCxNg61unSuSJdvL2MNwDuyybwHtfUE8RlI1CcBu2rDWjaEFsBw74PcMikxA/urGVQJJJmdrlTytzSU66w9Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=P1oyx05j; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="P1oyx05j"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48afcd7ba9bso1618736f8f.3
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 05:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1791893990; x=1792498790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n9uGCpvQermHDBtNBPxInsuZtK4DVOzfBsyPIO70t8w=;
        b=P1oyx05j/tNTSJUSf+6VzzZTfQGM6mNNw9hTmEJW8V2nHDeMYRao3pWoIHu31TBuP8
         zASgJnSN1/keZ2Zd14gq/Wux4EbibOrN/alsh8Z9/PL9fuR9jZDflFgcZOHzhKqhC2Rf
         OcPPkU/NtRrc9mPKgp6qcAuWe7A/62sRjz46uZWuX1jnqYvaUHp34ZUY1cc3kEOxTnyP
         DKPoH38idXXauirXWsEJqyMtpCIUhhbUe+jinB6Lsx34Kh5lFQeM2oANjUH9bpJ0PjLm
         Q4Vx70HApQeQhHdircb9PCkT+pxvf8WDSZ7n137a4LukdZ3qSeg+ZZZ1DCqWLaerz53F
         UYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791893990; x=1792498790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n9uGCpvQermHDBtNBPxInsuZtK4DVOzfBsyPIO70t8w=;
        b=ZrugNBw5KwP5jSM1XlxClNRrfWg1ZXsAW2ibCijxAI0yHGKa/x1gpEosNoRCv31J6H
         8rp8KQTU15x2D28cdBqcK+0tfqecZxy+N/bTO8N3awn5GU5hCs/TdJOazwPRaiCOnoPF
         nh8qNF/ejP9ndN6682quTBcDVG5iPJQVxRA/XLF1ZT7OKYn6yvGjPPjyEcsz/w2ZEgqw
         xUE5RUCwrE4QD9rs361bHh2INZvm47QN+D3yy423DzSG8CAh3ZGEvW0W7ugWKW2Vk/kp
         zFedGG+OvIZBVa/CqJENQMcU5H+8FzgfjMC8QFu/AW2Bv5FbyLFGt33yd0ys/A+4KLGh
         sZ3Q==
X-Forwarded-Encrypted: i=1; AKwUvBwZervSIqQyQHK8iUyikvgJharcFozh6mdYq9fWaSrVEIFqmgrENxmdkNanFoHPIMQIm9i+KZ8=@vger.kernel.org
X-Gm-Message-State: AFq9FYI9PtjHoEMoPNNskkXmk6DwStWw3QcobdDLHxcW7A8hPx0tde0g
	U//oZvkjklN2Izrb1868TnLL4jcSt5uzsVBs0fT9tWUU1c0AxFh2HTTdXmrG3eIjyEU=
X-Gm-Gg: AYBFou0qF0TiI+8xlm9LMx+5QH9ZGuHdlb9JJkBBfa15WYw9qLvtsqtowWJScjS4DBY
	0UcbTlJWeC3F4zX8Ej7oK8UtfofNnprt8idZ9XoZvuwCrIXHnrbqZ0roRPxJpLFnJodMqxF1L36
	HP1i3d/audNHmz7uLtWjs3N+zkqKGlenfIPBvfoLOIzrtRVFw90A5qYstia5IspaEc1piX1Hu75
	eYafYK7QFLx8TnksPRIlCBsG9hgPCz1mWAbuFevDwHnpfcY437a1/kr6jaXXWnTR4Vj3JJf8uBg
	CuNsawdM9L9p6jtg1AuI9VUgeNC6PON0hg1JyoSRNE7Sr9Tr9yAYZRVcrq61YC8BVeQEpaAMk/w
	moU6PuBpdKB/wPr2OgoTNGFf+792MbHh40K8DUQg4tDJKhjQ8N2YMfF3V1FM3xwzhPGFC8VA74w
	Q1TWAfBWDJmDfxE8WvHRuwrUsCbpv0Jku5uh1qTHZ2oAGrr8bK/ZAZkTggkpz62rCNxK+YUIx6B
	hFyO+wzzOA=
X-Received: by 2002:a05:6000:4288:b0:488:6ed9:b11d with SMTP id ffacd0b85a97d-48dbacf554cmr22783078f8f.52.1791893990090;
        Tue, 13 Oct 2026 05:19:50 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac6:37a8:26c8::3dd:3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc5e0asm4806155f8f.50.2026.10.13.05.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 05:19:49 -0700 (PDT)
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
Subject: [PATCH v2 1/2] iommu/amd: Program device table when kdump reuse fails
Date: Tue, 13 Oct 2026 13:19:43 +0100
Message-ID: <20261013121944.4060097-2-matt@readmodwrite.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013121944.4060097-1-matt@readmodwrite.com>
References: <20261013121944.4060097-1-matt@readmodwrite.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matt Fleming <mfleming@cloudflare.com>

Commit 38e5f33ee359 ("iommu/amd: Reuse device table for kdump") made
iommu_set_device_table() return early in every kdump kernel. That is
needed when the previous kernel's device table is reused: the base
register already points at it, and on SNP-enabled systems the register
is locked.

But if reuse isn't possible, early_enable_iommus() falls back to the
freshly allocated table and calls early_enable_iommu(). Because of the
early return, that table is never written to the base register. The
IOMMU keeps using whatever table the register pointed at before, while
the driver writes entries into the new one.

Only skip the write when the previous kernel's table was reused.

Fixes: 38e5f33ee359 ("iommu/amd: Reuse device table for kdump")
Cc: stable@vger.kernel.org
Reviewed-by: Ashish Kalra <ashish.kalra@amd.com>
Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
---
 drivers/iommu/amd/init.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index c07c3a01b978..0572e1a674f0 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -409,7 +409,13 @@ static void iommu_set_device_table(struct amd_iommu *iommu)
 
 	BUG_ON(iommu->mmio_base == NULL);
 
-	if (is_kdump_kernel())
+	/*
+	 * A kdump kernel that reuses the previous kernel's device table must
+	 * leave the base register alone. It already points at that table, and
+	 * with SNP enabled the register is locked. If reuse failed, program
+	 * the freshly allocated table like a normal boot.
+	 */
+	if (iommu->pci_seg->old_dev_tbl_cpy)
 		return;
 
 	entry = iommu_virt_to_phys(dev_table);
-- 
2.43.0

