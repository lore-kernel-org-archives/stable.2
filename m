Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD2E497B97
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 13:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790947918; cv=none; b=qsEC9vYP1sQZSOIGxO8mSEmZa3sX+ADRKsMc19UEzzXf9FVOf1CtsufOFJSWagFExFhqbrWYpTSQg8at4ES1Wb3bKdD7k3j5a8iay+XJGm4fVKYAEfX3fR7PUzQGLn52WpmOCPqmv6MsMIRoBzcZQIJuolnGYW2va6ASzVxEY7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790947918; c=relaxed/simple;
	bh=brthmMIhFTOepPGDXICFqqrSL14K4+Sr9qndgom0CTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DlKRjHQO/1phoxY/dclS7xjUf9pkH9cr4JKTj4BcxrLGQdLN4MhttDXgSpUumcrVvW784brQ92EXEp2pbXzojLalSHB3FP/424jwQguOJyekfS4Q6ZZiCMhaRyiQjdxM5jtkF0grz38b48WfAP+tHYUSUrLTP+BLmDduVDQVc1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=N3kwN3zA; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="N3kwN3zA"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e69b9e16aso585585e9.1
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 06:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1790947912; x=1791552712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M9Ano9xC6R+jtMAGzXzbGvkWFfYtvDDQfjL8dZJy8z0=;
        b=N3kwN3zA/8IphmcTs28ofAQD2tBhKmnCYz1xqaXZIvRp7725wp1FNZ+RFcuq4OqZ60
         MvhJ8jpLQLlHs6OzzmSQL6Yu79R/wk/r3pnm/HIlB47V6lsS86afk/wFGTOJL+7atoIF
         ZMGzA3X7sqkQXnIsu5zbCoQifOCIYz8fdkAYilr0zq6nuKOOELQc/IUvxC6Xxbdydumz
         Yla2neoy1A5RDvQbuFoFMusK+So/oLSx4fXac8/S8al8/YsRt/tQ8hW/ruphHxmxJEfL
         jY0lJ7lNSUHnDSyGXNXMQ9tPV378Ua7u9qqW3sH74yOKNg+/hnY/nkLEKmxjta8m8nLi
         0uPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790947912; x=1791552712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M9Ano9xC6R+jtMAGzXzbGvkWFfYtvDDQfjL8dZJy8z0=;
        b=L9csObgkNnED61uHyEtsca/d/HGQ+EJWjgruaZ/ynQXr5yPtVQHHHX4ARFpbMi8wsI
         DgHiAebe3gVsRkyT6kX2+SCsvYy3zDUfSFbTZMB5aJUcnCi9BCnQHqTSzHfCUEtOVtpU
         itEVML72LvPqII00Q1lpwRSM4HO46mHhQppCM8u62VI4XzGMcAqrSo95GYJ5OCv2iolr
         6/VbVtsS+qQFJy4sGZF2gCPXBxjJKV68D8SNxJuZ78NKAF53a+FAr5OIRhOnu401pMVu
         6aH9tIZNvkYuedcFnHOmBqYp+DQWanIHbGULalWePPyyiXAHx/SHHN0cXbXRljSRTx5u
         eQhw==
X-Forwarded-Encrypted: i=1; AKwUvBzJckdhoaQB21ubcF0Og95wJrIDPMr64aZGjGVYPWQnEWEX2MH9kpdQR996OzQW87fOlI4Jni0=@vger.kernel.org
X-Gm-Message-State: AFuF++kqX5ZtDFw1Vr7djm/UMqRzMALLF2q+lh7UUviE3QRVI8dYg74K
	aCh6t778aufkCM7zFFdS/aFRNkzqAOY6u5TYnabiTVLOqxQJNZ0AgwB2a7XvHTmakuc=
X-Gm-Gg: AYBFou3LDGBvtgAyvKxDESwe0Pii8/URypN0Dj2Lx75I8tbWs9RqWRrsEA+yPdIYLLY
	9cVKmmMBpDx2fGI/uyDjqPDTPHF99VmiM3MwxC7B0jUP/t1zhXQsFcWM+Ao2ulbmRNM+EsM0/jO
	KomJw0UPbty210lhtUnJI/zEncnYQMHM+FeatT3+4CMAxUSQOSwLWjorcKgX5rhnpKeYKyL8xaz
	7BNqajw+sgdW3fd8wM1p9kPMI1457qWSPPcFIgPSFEgFBRJJBqEZlLFVcBlR0MxLE5Qlv2UuGtx
	36Wn047Ay/6bd0GvKc6XBJ/iJ0rSh2YWDnjwbUdtUo+FA51KcIRK2F+/GUZyL1Ukk4pQE+EnCSK
	Xdd9w+kGMFLUKdY91L258Gx/gb9b+ADYwRX7m0aB/Q3DK0h0gUMiS2zQl9Rdx1dm1/XlS+Bcv8K
	RMdFoNnf6S7hOejDXMCPKLrkJ3i9mBfQq43vtxSJz6DrSIbymH1AhgLlFCQ42iDZGu30M4rJP1C
	IdFE/k1P/M=
X-Received: by 2002:a05:600c:4e93:b0:4a0:1e68:d28d with SMTP id 5b1f17b1804b1-4a02756715fmr52492915e9.6.1790947911590;
        Fri, 02 Oct 2026 06:31:51 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac6:37a8:ebe::178:143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0394e6c5asm60543205e9.2.2026.10.02.06.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 06:31:51 -0700 (PDT)
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
Subject: [PATCH 1/2] iommu/amd: Program device table when kdump reuse fails
Date: Fri,  2 Oct 2026 14:31:42 +0100
Message-ID: <20261002133143.3628181-2-matt@readmodwrite.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002133143.3628181-1-matt@readmodwrite.com>
References: <20261002133143.3628181-1-matt@readmodwrite.com>
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

