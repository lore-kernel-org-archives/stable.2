Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9F440BCCE
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 11:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787570684; cv=none; b=h3ZmgGUSG0CIwor/TO15mzZzChuyObu+ntv4Lp12UAnM6b/oB+Hugyv0KU/cx28sTUDQmRbJJ5FqIOJzGt5GVb+cndU6Unxd+AskK/g7ovw2rWsG2zp8LnO6hV+3vhcq5bFXie4fuQawAvk/dxRcZEycD/Rs5O4Z7bvwx+LJEbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787570684; c=relaxed/simple;
	bh=gVEGw2nAPUcPjU6qYIoF85NaY19TwmeIyZH2C6/EOUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GLssiusFSWi0ewmIPRcHY0hWKbI8ihrQ29zvLEZ8jVs4Ca3/WfNXpC15+mbL+MkeEu9/EJhaXNi1L5LVUKdZXLvc7cz2HWV48EJ8FyAPuZ2cAGfYi1cbEJl0d1eAmyy2qITJrgmG4vyM/ek8fcf/mLknTeabG983O8GvI7HIKoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWv8ETQ3; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWv8ETQ3"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cbe437a530dso217954a12.1
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 04:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787570681; x=1788175481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zsWUj6D2O23IjGwV7U+g6CAWZzqgDR0i/7tBeONboys=;
        b=HWv8ETQ3ajkvxfXrnAF8cbCRsiWuTPuZyDwEnx0CKVH47aRqLzxil0iECS0kPltpkX
         Ckd5lJ+4FQo0uOZB4gqubxlus2IDqH9GAZ5zZFZpo88BEb0V0F+mNqrtZpKGMhEBfPgC
         IhUny0e3DVpmvhR3+SZSzT6uaJKanCNtUBEiFyXZrXXr/A0xZTO2p7Xe49apHm28srPc
         QPYAydp/Ak31JUmNJfMv7OzjB/F5ep/U+fkfQAGobVisyzX5oagvNE90zlpGPkN/oLf6
         VEmfhhk9lzp4O8sRTeuDr3IWtJMymsRe8cNkDGbm7C0xlQRenWoBYj2ffFGH/lilD+Uu
         rw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787570681; x=1788175481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zsWUj6D2O23IjGwV7U+g6CAWZzqgDR0i/7tBeONboys=;
        b=VBEaqsAdCoMRGn7kec8mxuumIOuCFQX7xkwMlpWfKR1z6f3lCSHKqUWqBFHpbImtGP
         WBpWECrzYWOKwp2d3HyloSGlIxDcrT6ZlQ61m3gmlWkQ6w0aSYL5q74oPZ9Jc7EOrLrp
         HCfQIx1MH03qlKe5VtC8IDj9jhLuKNJv7R2F6gpj1whR4b/7HUZgaTHtBD9Tz96PN0yn
         xMxr4fPulKm/DKmr/9DRoeggdj1ztDlVZ52XSccFPeGSbbUW3XiFYixFvU6/ir0B4tSf
         1lS1l86Xy5QR3xMA0OaXBBCjQmIhZmZOpf6Ai9gW7p5AcrzEyRqmxSicN5yBRhJ0AoEs
         VoCg==
X-Forwarded-Encrypted: i=1; AHgh+Rq7GszoZuv+34wmmRy/jg6Rg28yr1jyt0xHyqAxgsZ6SFZe88U1mgEfvoY+6cOddU5j8YrMVJQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mfQjXKyyHgd6FCEvZPGOu9ULIv628oeVhqOjse3WgyYh2JEkBA
	5I20KAFy1bIcoODwKXZjnVahW0stNmGjqQUyTpx0qOfREDp4cvSOoJDc
X-Gm-Gg: AR+sD10IRgzNsU+ab1cRb4XVfpfQlb96Mvw09Kna68VgD2PurIHjYPdeoxgxucX5F9P
	mP+CPCplh+E8JUxtFafjCZ10h9mpqfEc3vc2ZftKMKZ57OHmYi5ceEz1oR+JTGOxFxLUyr2Aqf6
	RoUVtDwy8T9RIUVqJyA1UaLaCWqfEYBInRa7zqXQfG68FTt50IgZXXyzzBMTK/vIagMNm1toGJU
	+07+C2JMSAg+QcgWo7hLF4bl48aG3ZKMS48fF19oyCqRAagA7STkWWlVsH5INTXmhFYEO3k02lz
	7ZEyddwH3n6bsa1ffv6WZS88vDqUQInZ53syqKpk1jqwT5LqzmREwYzlQmMytPZhuxVKrNRLDIY
	aEUuDV8U+piYeeC9BpQ9ixVUznxtwLSImPr0WjbNo50W3l44mm7JFvP2sVHrbNTBq0g9dwt6O13
	b5KffpaZXlcmhwHKYqCnKDs82iFuobcgzP6nzRLbC5ZK12nISKB7NCplMihTJdHN05NMzwdykmN
	2tk3Cf+EyK2kKNp/T0jdLuj40uQ2ET1xA==
X-Received: by 2002:a05:6a20:7288:b0:3c3:2dc0:7cbd with SMTP id adf61e73a8af0-3cd2ff087fdmr23133335637.1.1787570681051;
        Mon, 24 Aug 2026 04:24:41 -0700 (PDT)
Received: from localhost.localdomain ([14.216.85.214])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc199e5fcaasm912995a12.24.2026.08.24.04.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 04:24:40 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/ksm: mark migration stores with WRITE_ONCE()
Date: Mon, 24 Aug 2026 19:24:33 +0800
Message-ID: <20260824112433.191301-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ksm_get_folio() deliberately samples stable_node->kpfn and
folio->mapping without taking the folio lock because the KSM folio may be
migrated concurrently.  folio_migrate_ksm() updates the same state using
plain assignments.

The reader can load the old kpfn, then the migrator can store the new kpfn,
execute smp_wmb(), and clear the old folio's mapping before the reader
checks that mapping.  Thus the initial kpfn load can overlap its update and
the subsequent mapping load can overlap the clear, with no common lock.
This leaves marked READ_ONCE() accesses racing with plain stores.

The kernel reported:

  BUG: KCSAN: data-race in folio_migrate_ksm / ksm_get_folio

  read (marked) to 0xffff8ce401421330 of 8 bytes by task 48 on cpu 3:
   ksm_get_folio+0x7f/0x2a0
   ksm_scan_thread+0x1635/0x3330
   kthread+0x1af/0x1f0

  write to 0xffff8ce401421330 of 8 bytes by task 102 on cpu 1:
   folio_migrate_ksm+0x6a/0xd0
   folio_migrate_flags+0x193/0x420
   __migrate_folio.isra.0+0x162/0x1a0
   migrate_folio+0x4c/0x70
   move_to_new_folio+0xd6/0x170

Use WRITE_ONCE() for both stores to pair them with the existing lockless
reads.  This preserves the existing smp_wmb()/smp_rmb() migration protocol
and control flow while preventing compiler transformations of the shared
accesses.

Fixes: c8d6553b9580 ("ksm: make KSM page migration possible")
Cc: stable@vger.kernel.org
Acked-by: Xu Xin <xu.xin16@zte.com.cn>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
Changes in v2:
- Add the Fixes tag requested during review.
- Add Cc: stable@vger.kernel.org.
- Add David Hildenbrand's Acked-by.

 mm/ksm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index b4142746777e..bec6fea0fdb4 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1116,7 +1116,8 @@ static inline void folio_set_stable_node(struct folio *folio,
 					 struct ksm_stable_node *stable_node)
 {
 	VM_WARN_ON_FOLIO(folio_test_anon(folio) && PageAnonExclusive(&folio->page), folio);
-	folio->mapping = (void *)((unsigned long)stable_node | FOLIO_MAPPING_KSM);
+	WRITE_ONCE(folio->mapping,
+		   (void *)((unsigned long)stable_node | FOLIO_MAPPING_KSM));
 }
 
 #ifdef CONFIG_SYSFS
@@ -3318,7 +3319,7 @@ void folio_migrate_ksm(struct folio *newfolio, struct folio *folio)
 	stable_node = folio_stable_node(folio);
 	if (stable_node) {
 		VM_BUG_ON_FOLIO(stable_node->kpfn != folio_pfn(folio), folio);
-		stable_node->kpfn = folio_pfn(newfolio);
+		WRITE_ONCE(stable_node->kpfn, folio_pfn(newfolio));
 		/*
 		 * newfolio->mapping was set in advance; now we need smp_wmb()
 		 * to make sure that the new stable_node->kpfn is visible
-- 
2.43.0

