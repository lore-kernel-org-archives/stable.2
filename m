Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FBF30E858
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 05:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792129765; cv=none; b=fVlWIGBcZEWqlPOv9kdaTVN28sJmBZrwGpKSCy6KbMOV5jS6j77WuBke3oRgjZclvRg/FFcTwBd0dlAszKXO8zKAcZT3JNNw88oreEZrOETBj/NCLNWiUzsl15jA2C8liJ4xKd5WoX9iOuREkSf2TKHwa9cW3BFsrvEyPIuve0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792129765; c=relaxed/simple;
	bh=rCTBXZWsA+DFjYHLb8u5Oa7Bvqyi+ouM5tudHnnjwtA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r+i7YTKfMRwDWdOvSlDfbalr2BmSU4Ts/MrS4/0qOETXXMMtb94t4KwaAxO0KlB34N6bqseGMno1DFKUiCVhvgVqlBOIBIQObGuGZAS8685kWlMBhGuFF+Xcjtj9Vn1TGf88OFqPEwxUZIT5ubEsYVMPmBBYev5PX+5620rQUhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=d2XQTzi9; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="d2XQTzi9"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e915887d9dso24940065ad.1
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 22:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1792129762; x=1792734562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z5sNEdkVrvo7sH9ZJvBOJJZb8XmvxfiMz5rU6UHY+Ek=;
        b=d2XQTzi94gWL5bPrnej0TQLZ6cSFRh/+4KyRVkXIZpmehGuKz8TLkxYAApU8LFHGo9
         04OkzblTr02VxpRoNrYBpB3T2KrcfTgCQqenwMklyuZwSCk2KoClphHhk6w/SN/2K5FJ
         O5GN7D4mSX/z00OYGk8LIRM7Dt59P4JM7ifQBxOQUF6HcyEPFIM3ffQh0qlOq5pHH2Ri
         RgUVkPkIgcy1oVlIIFuVSRvKzdYUDIeQXWSCtLZSlMjrbUT3AEMT3lLbMJ5YV5qJUJoL
         iMUc+JVh8p1IsJWpZl3qqqv0TP7QJ6HV0RwGbYxdZjVwr7fAR2wKVjQOwALpDUxwy783
         a8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792129762; x=1792734562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z5sNEdkVrvo7sH9ZJvBOJJZb8XmvxfiMz5rU6UHY+Ek=;
        b=nHWpfxzuhoilyEPGCYf2kt1BfL39i3FOQEJMr/PECe/uCaNYcEIn/qnq9udmePnP0E
         6Rsfuas63PLua64GOs8ALaQL+/2m+UvdG6Qxr4PynQ7rBXMlq0OECeCmyNHzk/kXBf7f
         AC3l8CaF2mnFrbTACy60VH7M6tvRie6HsZ9uK9BVOnRY0r3seUw+TnzXOvmNRvD7oTZZ
         G7TDETqDPcbDJdjGmTVqKgk2cnT0TYyNYLOAD3V5rZlHvovKKHLOHDujdimnOgUh4BQX
         Bu1Uy8u8fN335MINNxtQGLeKddspAzvG+3u/8P4A27q+EJUzK6h/nDUWJjgLkUMoM/U4
         1WyA==
X-Forwarded-Encrypted: i=1; AKwUvBxIEeIlVDZTTUOc8rs6ZlGMrKHX6ioBFRuyqOvXCYvnYBDGQ4x+UgcVcCIumrtnP1KMHMqnkNo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJR8edBnw77hwhnLFxze1IT8f8gqs53xUebZVY9MIJi/YZAgwPa
	UiqqdWXN21gbvTIDfn3ivOBPzit4KnGxzZNM3MBICmOCB+bkFVwwJ1eW32Hx8xG2bCA=
X-Gm-Gg: AYBFou0Ee3g33qn/4OkvU+mDl50655tCrMVziVAsxTYMrX0VioaAMNwORe6mOW0ES4G
	oscdWs+b0wSl/0a+y1qH4V7BU8Z+lI5OWaLBBKYRHmdak37ADBw2lB8SSxxu12APrW2uwMu3ED5
	Iy/HXgr+mvdhsSQIJkvF9LFkdYty+hY1BQIZ5+ca7L9Y8twxJ7F/FNHtsE1QkTNkoU7Vs7IMhTE
	rHUL8Prej9PSDxVj8mgnyF4hnzIdwAu9Y6/LURe9ruB6UeNhncBbJhHyo4wlIQg0SoE4N1czBLv
	LMY0MJY+epHbwUGOzopXVZVamXVV/AbFPBoZJ+MFKtuZa2wGtgwHjgdPkbKhYl29sZV9DRYtWsN
	/zM1tpYqwaxRYN5YLprUVuBMFECYtnuEWSLqUImPNOg+bHDz/31h08+3BXGJubs9MjdTYWz7CSs
	rEjGCEI18nCFamjPX2gk6jVCOGIuvdvKnwQGBdeYLyPHVGTlJbRxOTMpk0Uzzo6satZW0F/4qfI
	ISqlCsvyvtdjYs2zM8=
X-Received: by 2002:a17:903:1b4f:b0:2e9:7ff5:544c with SMTP id d9443c01a7336-2e97ff55897mr13235965ad.25.1792129762374;
        Thu, 15 Oct 2026 22:49:22 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.99])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e804d7csm4697445ad.15.2026.10.15.22.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 22:49:21 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Dan Williams <djbw@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Joao Martins <joao.m.martins@oracle.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Muchun Song <muchun.song@linux.dev>,
	stable@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] dax/pmem: fix unaligned compound devmap initialization
Date: Fri, 16 Oct 2026 13:49:14 +0800
Message-ID: <20261016054914.2601510-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Static pmem Device DAX namespaces reserve space for namespace metadata
before the user-visible data range, and may also include padding needed
to satisfy the Device DAX alignment. __dax_pmem_probe() adjusts the
dax_region range to start at the data range, but the dev_pagemap range
still starts at the beginning of the namespace.

That is not valid for compound devmap mappings whose memmap is stored in
system RAM. Compound page initialization requires the start PFN to be
naturally aligned to the compound page size, because the head and tail
struct pages are initialized according to that geometry. If the pgmap
starts before the aligned data range, memmap_init_zone_device() can build
compound page metadata from an unaligned PFN.

The resulting struct page layout is inconsistent with the Device DAX
mapping. A later mmap fault can then resolve the user-visible PFN through
invalid compound page metadata and hit a kernel panic while inserting the
DAX folio.

Fix this by advancing the pgmap start to the aligned Device DAX data
range for non-altmap compound mappings. Leave base-page namespaces
unchanged, and leave the altmap path unchanged because
memmap_init_zone_device() already skips the altmap reservation itself.

Fixes: 14606001efb4 ("device-dax: compound devmap support")
Cc: <stable@vger.kernel.org>
Reported-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Closes: https://lore.kernel.org/r/wlrkqqvg.ritesh.list@gmail.com
Assisted-by: LLM
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/dax/pmem.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
index bee93066a849..d3a9b85107b0 100644
--- a/drivers/dax/pmem.c
+++ b/drivers/dax/pmem.c
@@ -51,6 +51,13 @@ static struct dev_dax *__dax_pmem_probe(struct device *dev)
 	/* adjust the dax_region range to the start of data */
 	range = pgmap.range;
 	range.start += offset;
+	/*
+	 * When the memmap is stored in RAM, exclude metadata and alignment
+	 * padding from compound page initialization.  Otherwise, the pgmap
+	 * may start before the naturally aligned Device DAX data range.
+	 */
+	if (!pgmap_altmap(&pgmap) && le32_to_cpu(pfn_sb->align) > PAGE_SIZE)
+		pgmap.range.start = range.start;
 	dax_region = alloc_dax_region(dev, region_id, &range,
 			nd_region->target_node, le32_to_cpu(pfn_sb->align),
 			IORESOURCE_DAX_STATIC);

base-commit: 0fcb05b72344f40806cbe810de8872f1698bf053
-- 
2.54.0

