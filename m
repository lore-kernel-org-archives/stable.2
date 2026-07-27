Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853F641D22F
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158381; cv=none; b=G2rqCLtxASWE1TQLL64LLvuPVctGZ1cFTEoJhfJQXKsYmwpqSXtLFICFL8C/S2krsDsWq0Hj0D1HT5mo3BkSrh4J4R47tT18B/Qo/ofF9mdVFWzK7n3EedErKWhtqcY77tzST0ZaWvmMAbv/rAO4DCTeLhFK5UuLHtKBZcwN+Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158381; c=relaxed/simple;
	bh=I9vMfNeWDW8vVIK64rObbKWN0nswY5MCMTBYme08kgg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=syqCeIDJm5iVFRRfOvSF2+7vPP2wFYl656ZUug2vOgunII1maJN5P2aLj1MtSEDpNQ41Qx1TfHCiiOT9v5tex7BODD9XGfVsOQ+mFo/QZVuE315pnHczyJP+gOuonqIcU7LLzCsHarm+BX/dx8qmynF0pe8Dac4PM91qGTdDlQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBxQtbte; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBxQtbte"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so1936253a12.2
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 06:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785158377; x=1785763177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lEceZ6FrG9kgXwqbPymkbPYYUj1GiTAukTMmaD6Bev0=;
        b=nBxQtbteer4fAHAQBYcYFrkPNHaeS3qp2TK6sPG6+4e+bZ8yqeoV8Es5cQkKsCk/S2
         9drk17HANjAK3axs8B4CZBkClnyL0i0dWQOipUE9TtrlMs37mIWtahtAaDeNL1EvGfsj
         HVdA1N0YyO5882s5OAbI1ghcOqmAuzxd3IbNog1bh5u8CS5gDdBPiO/nqAQ7/Qj9qC4T
         pOQisYdSpkmAKhNshEg8GHBHiQ6f3p5DeNonWCWP3z2KfRfXSA2r2/ygnjQyyS7/q3WT
         rkXNi530lp4ygMm60vbSBcCTnFO6or/53CpON/wsa0hSqJ9t1rEiwi083s8u8gXk4nUp
         H1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785158377; x=1785763177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lEceZ6FrG9kgXwqbPymkbPYYUj1GiTAukTMmaD6Bev0=;
        b=qrQfcFBnvGs+c1h5POpw6S/KMe41ZVBMwNzrV+o8ctdfBX3RHFQ3nKub+U8H77sS+9
         gaapaUqICahotooMmZv4ksxOaNEKMehNv9fAMu+pjNSKlGG4wO4VNHrNUllQj4zu9DRE
         SDSP9jCVzQmmgqWMWDJgcBDMe3CQReYro/lmAs5+Kxcosh191lnOmEV5TIuLed19D3jC
         TSGBHQRiwAFrkti0o8b1niGzH3yA8WTWDr2B9IJRaz7jqRHCuqrWjezvzBgEQ2diPCFN
         9Ta6sRniLK2njFvSs6PdzQzdvkOfRa49R4ih7Wi1mkeyMHZAirI385RC6NeG5b9C/6Gz
         EqGQ==
X-Forwarded-Encrypted: i=1; AHgh+RqnbMV+SQmK15tJTQy1WE3YbAUH1ltodoOL9doAGW58Uq2pmsxkspHnmP30dcXqO7uBNEQtMBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YydEBbrw4Jf2oN1EaJ1kcpvMcdsa5hzb/9kEkUQwrpWDVQaiaLq
	KJFCl5zgLVs5NnihTklVKij7sHCuF1o4sQxoBjgt8yeYieIuolYJesFN
X-Gm-Gg: AR+sD10Tk+4tQwas7JazaNOdomGcNJcnlF961Rmj4lAdKHnmqM5qJYDmYreAzszyVWT
	sWk3lcf88cRvNV9HxP6gLCnwA19Qf1frr/ntUSYoowPRayvGQ1rdcjVsJqlJg+TwEJ7aDqQ8hJo
	2vqjRhDfpwo9Hba/YQ8xcxCE7NXksRt2dSRvFxwwE7gYGoee5/CPhVRfL0tn+mslE4PlS5t8VMy
	ddkSGs56ju4FbqbxAYDXJPVzXX5eptO6LPBR3xMWAb9GbKRW2TpsB8xwCpSMVs5gHJrL0514VvL
	X35ozN0AWXLNLMoL8Ke/t+pKo5iUvKDuZwtDRz3Bq5cXfWrVtyK5JYx8cdyxYPhhN/+Xrd3R2Xc
	pG09Z1PHUq/F3Ysxw0JfO4vwGbov9XqLaz4ejarxCuYLwJA6y52tdHVXChnVzPmeTvUSB9jCJAa
	yA3/4MKKnf0uiZpMOABS27
X-Received: by 2002:a05:6a20:1602:b0:3c3:a140:9380 with SMTP id adf61e73a8af0-3c67da110cbmr7404589637.16.1785158376963;
        Mon, 27 Jul 2026 06:19:36 -0700 (PDT)
Received: from spr1.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb662329fsm3185355a12.9.2026.07.27.06.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 06:19:36 -0700 (PDT)
From: Hengbin Zhang <uqbarz@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hengbin Zhang <uqbarz@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>
Subject: [RFC PATCH v2] mm/thp: serialize huge-zero folio state transitions
Date: Mon, 27 Jul 2026 13:18:14 +0000
Message-Id: <20260727131814.3983064-1-uqbarz@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <177a1767-c782-4210-b377-44c520c74619@kernel.org>
References: <177a1767-c782-4210-b377-44c520c74619@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The nonpersistent huge-zero shrinker clears huge_zero_folio and then
invalidates huge_zero_pfn. A concurrent fault can publish a replacement
folio and PFN between those updates, after which the old shrinker
invalidates the replacement generation's PFN identity.

A later partial mprotect() can then misidentify the live special PMD and
enter the ordinary anonymous THP split path.

A writer-side spinlock keeps huge_zero_folio and huge_zero_pfn updates
from different generations together. Lockless getters still use the
refcount fast path. atomic_set_release() publishes an initialized new
generation before a successful atomic_inc_not_zero() can admit a getter
on weakly ordered architectures.

The race was reproduced using test-only instrumentation that widens the
shrinker/allocation window; that instrumentation is not included here.

Suggested-by: David Hildenbrand <david@kernel.org>
Link: https://lore.kernel.org/r/20260724100509.2300200-1-uqbarz@gmail.com
Signed-off-by: Hengbin Zhang <uqbarz@gmail.com>
---
 mm/huge_memory.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b5d1e9d4463d..89771a9b282d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -78,6 +78,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 static bool split_underused_thp = true;
 
 static atomic_t huge_zero_refcount;
+static DEFINE_SPINLOCK(huge_zero_lock);
 struct folio *huge_zero_folio __read_mostly;
 unsigned long huge_zero_pfn __read_mostly = ~0UL;
 unsigned long huge_anon_orders_always __read_mostly;
@@ -237,17 +238,19 @@ static bool get_huge_zero_folio(void)
 	}
 	/* Ensure zero folio won't have large_rmappable flag set. */
 	folio_clear_large_rmappable(zero_folio);
-	preempt_disable();
-	if (cmpxchg(&huge_zero_folio, NULL, zero_folio)) {
-		preempt_enable();
+	spin_lock(&huge_zero_lock);
+	if (READ_ONCE(huge_zero_folio)) {
+		spin_unlock(&huge_zero_lock);
 		folio_put(zero_folio);
 		goto retry;
 	}
 	WRITE_ONCE(huge_zero_pfn, folio_pfn(zero_folio));
+	WRITE_ONCE(huge_zero_folio, zero_folio);
+
+	/* Publish the identity before admitting lockless getters. */
+	atomic_set_release(&huge_zero_refcount, 2);
+	spin_unlock(&huge_zero_lock);
 
-	/* We take additional reference here. It will be put back by shrinker */
-	atomic_set(&huge_zero_refcount, 2);
-	preempt_enable();
 	count_vm_event(THP_ZERO_PAGE_ALLOC);
 	return true;
 }
@@ -297,15 +300,22 @@ static unsigned long shrink_huge_zero_folio_count(struct shrinker *shrink,
 static unsigned long shrink_huge_zero_folio_scan(struct shrinker *shrink,
 						 struct shrink_control *sc)
 {
-	if (atomic_cmpxchg(&huge_zero_refcount, 1, 0) == 1) {
-		struct folio *zero_folio = xchg(&huge_zero_folio, NULL);
-		BUG_ON(zero_folio == NULL);
-		WRITE_ONCE(huge_zero_pfn, ~0UL);
-		folio_put(zero_folio);
-		return HPAGE_PMD_NR;
+	struct folio *zero_folio;
+
+	spin_lock(&huge_zero_lock);
+	if (atomic_cmpxchg(&huge_zero_refcount, 1, 0) != 1) {
+		spin_unlock(&huge_zero_lock);
+		return 0;
 	}
 
-	return 0;
+	zero_folio = READ_ONCE(huge_zero_folio);
+	BUG_ON(zero_folio == NULL);
+	WRITE_ONCE(huge_zero_pfn, ~0UL);
+	WRITE_ONCE(huge_zero_folio, NULL);
+	spin_unlock(&huge_zero_lock);
+
+	folio_put(zero_folio);
+	return HPAGE_PMD_NR;
 }
 
 static struct shrinker *huge_zero_folio_shrinker;
-- 
2.34.1

