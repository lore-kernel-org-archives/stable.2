Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E333D5246
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 22:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787004500; cv=none; b=bVHilnY8MROZmv+FXpAXYc4CeczAQkR0BnFMRv4c/fQzkI2WCf1z2ISBpPacwZVu7Z83EPHlXDoydFETfesCSPchu4/ZcjHLP5NFLsQx0bR3KXxM7o1ldQYXGUfy9I5mlRJJOKTYKRMCc9TiZgmQsLjLyWRJ6+ykB6jS6AH0YZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787004500; c=relaxed/simple;
	bh=eGQzoSEE5m0muRmnymqYrMlvGNiyTyTu7qrpYKn3c/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R2H+rzPbdEh6Eww3mRlTgIIP9N82/ob1ZSzb85yVvHVpw5sWHuFjzeMUXYrW3nfJlVNxwWJcKueU9jFJyX92zpW78HNF5Mi82lho4cxBmeZDG49hnncj8gZOIQQQk7Zv68wlX6T8q+qqsrMEqMvg4DoHr0JCmHVEa/V+Ft0wVUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=etvdKpc2; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="etvdKpc2"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-930f618435cso229696185a.3
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 15:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1787004497; x=1787609297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2TbSdQcY7KD6I3WslktwD+M/q5vUGGfVm2gu43i1aVI=;
        b=etvdKpc2xritJ0nNaQaJ1DR2HWbhoonO9gXUxKyC16t3DfgUfRMGyEDzdLNeo4H2po
         1N7Kqkj7BWcF7OJH0Rfq/ymV7Q2nlov7f840eqp3LsnGXRbVoxUv4NZp/gf+oiai0G9v
         oQExtBYc7EgQCRUIv9ZWgrp+/F2EsSeX9oj0ZiPAsHGiPCkBCErIqaoGyIDsTaUyOkpG
         ZDe+3dgYz4X7O0p968iwoExwSagDA/iLST8AV3nqvZcmFfsT2q7mY7X3oXyzqNLH2DaJ
         DOr2TP4cvBwyHSdlMOTXIf5hzZUJzs/tqAbBSX3yZ34OWFJoRIVI6YpMOZA+4ArDsKMT
         eA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787004497; x=1787609297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2TbSdQcY7KD6I3WslktwD+M/q5vUGGfVm2gu43i1aVI=;
        b=cgKe/ZqR2SXbUGcNdUimcj5xkiTLE4MQLsJy0sztjdu7QW10GOrWDIjy6lnWJ+1N7o
         YA/I5cBXMya54jbORldcHTtohzVkdPRK2ypLdVuH6WhEvh5pCgppMJh9wTeMr/xzT+bB
         hFTlBD+EIsLyHtXz8vEndA/OykKhP46Jmz3TvY/eN+wUKLNdUaKYj6HuHxnYUkAYlhnC
         kbhHKPRGLHHuXr9IeuiYOQ2e2JzG0f39y7w4LdLy/fLVNexTJ/qo0HXlhN63o5n0yKu2
         4fXCtfHHa9WKRHaS88gJ9gntT1ps2VE8CVeTEGW+bMnkzXn1Qzm0fZeYbGfRZri7vGay
         OngQ==
X-Forwarded-Encrypted: i=1; AHgh+RqZ1QfO8ea4gflRmS40gySO2TOGK6fYZU9Czkzjif2YxIpiac+SjpRURynX9lprbXMDvnAzIXM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys1tupSC+M3MlXwBXkod5rXrP3VdwpV7aTZOqB5NlkpUSMPsal
	Ryu64MhbXqQAtlINImaJlXYFQFqQgnAN9ssb/dMzJGOmNokc0p+kAOoB6fLsziD0XNs=
X-Gm-Gg: AR+sD11U4UauIeKXCRR0FrV4bWJJR5IyAfP6isCf3zvskoDi/tuZ+B26xVO7X4pGY0j
	/DFP4gvwJkOXU0i9WSk5Fs5qXXI62VQqsfJ4cFx05YUw+QCtfxpHV7xE/DWO8ARDGJTkGbkJUnR
	X9Tk2g4Giew8X36uZNs+QxKnxjCW/USS2RRO2NiuwqEOWL/eaz4iQnBK3xN4cZNLGrFGT9IYBgV
	vOC6SWaG/ra0ceU2cgBNRgwOZqSoA119d0J8gcGgPU/SOvxJDm3sAIh0f//Vaz7IPjN7AEe9CEO
	6/osoQAxSE+ZkQZQ0J7WjWzc6TiL5BRYgZbDSBv4tafJwvPONzu/sBXQYxwrYRPjLXtym0/mbOk
	C08j3v5rYWI90m1XCijb+x7ffQ7FZ3M2ls9IWH54RkSkG/xuWKjzQFd1xxEkYkQnuSQB22WED4a
	DPZO2t1VpGLaxv8DLnFCINacuKiqKBKg3pLEJcEtKIJBPUGNyZwOG82y3WnAr6nLsyXPpcAOCkO
	uvJqSHpsyM6UfyomGV9Bb8pNGS1u3c2+AvCSemwfrcIKSmubA==
X-Received: by 2002:a05:620a:80d:b0:930:c12d:b915 with SMTP id af79cd13be357-936d202fbedmr2459244885a.18.1787004497552;
        Mon, 17 Aug 2026 15:08:17 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-937033ce78csm147108885a.31.2026.08.17.15.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 15:08:17 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	vbabka@kernel.org,
	jannh@google.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	balbirs@nvidia.com,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] mm/huge_memory: skip zone device folios in madvise_free_huge_pmd()
Date: Mon, 17 Aug 2026 18:08:08 -0400
Message-ID: <20260817220810.1175596-2-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817220810.1175596-1-gourry@gourry.net>
References: <20260817220810.1175596-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

madvise_free_huge_pmd() resolves the folio backing a PMD via pmd_folio()
and marks it lazyfree without checking for zone device memory.

The surrounding guards do not cover every zone device case:
 - MADV_FREE only operates on anonymous VMAs (DAX mappings are excluded)

 - !pmd_present() branch rejects device-private and migration entries

 - present zone device PMD (device coherent THP) is not filtered.
   Unlike vm_normal_page_pmd(), it performs no special/pfnmap check,
   and would be marked lazyfree here.

Bail out when the folio is a zone device folio.

Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/huge_memory.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ced400f72d43a..714773695bbff 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2381,6 +2381,10 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	}
 
 	folio = pmd_folio(orig_pmd);
+
+	if (folio_is_zone_device(folio))
+		goto out;
+
 	/*
 	 * If other processes are mapping this folio, we couldn't discard
 	 * the folio unless they all do MADV_FREE so let's skip the folio.
-- 
2.53.0-Meta

