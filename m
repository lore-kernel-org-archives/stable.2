Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792481487;
	b=qrgyEv55RZGzYFx648eNkQOTr1FfMk2Xd5rJupVXaCZl3xc1v3SRciwTfXvuUfJepBs+
	 +Ev3qp1Dk6m1Dt06iDsWiaUoHK6931WOR2x3CMrMRHeA6UDVXdVetnpFbUwb1URM3HQ8K
	 OPc0v1dhbfzSj/VRg5ti7kHFGiMZvp0ooD+4LnW0om+g7E0i2V0N6LJ3RdbG21KE/fY58
	 IVyTUnDwzOPbKMCcpn7RRbplbUodoR6s692IxE0n5dIgIS3CeMw1iMcM/w9VO6537h0RG
	 ptej+v9aTvMMoiMlCcqs/h9g5t7lGkWyWzgTiNB9KOmXM5SV/qEE1B1WGr8hAJs0wVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792481487;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=DUpm1Avc0nkEXJ+1xf9Uuhznoyw2NJnoVeQzyuyKlAM=;
	b=ShGuUSk2Gv25fydy3X6kurDcTf00cLkm4D3sVN9i6Dq1VruZeV4/HkJ+SGEVSH++SCVN
	 dTyUF7RAw4cL+fuvUmpA7jTQ955n4z/fEfMx3wbGDJCQjJBpbeEeGwS/Q93xzVPMpDt0d
	 tBuAUwhXnO0097wadvLEuNvZQD5ash2Wo0Uyo3VNpTU1r038SZXpn7kauLlHlb6S6bj/u
	 n/fj+wWT6Hdltci2/qlV8deE4lXcjEidmICl6N5O01Y6tN95yub7f46UhY0MuBDua/rXi
	 vrXp/qK+0L4M3wnTccQEc7p6VZ03s4DqrsyOydpTFpSHIwOT8JLUmQwQNRRYtGrxqUg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=eRVdLYJL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDE8606A319
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 07:31:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BDE8606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=eRVdLYJL
Received: from mosel.fritz.box (unknown [IPv6:2a02:810a:88b:4f00:82ef:16f8:b54b:d8b])
	(Authenticated sender: jre@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id F2A3A202285;
	Tue, 20 Oct 2026 09:31:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792481484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DUpm1Avc0nkEXJ+1xf9Uuhznoyw2NJnoVeQzyuyKlAM=;
	b=eRVdLYJLkDnRSJUK1hSCCMaorSmvSF+joCRB5hetIi4+3uxIaRhulVdJQd/1gJurOgTOWA
	JSYMoA4Byd+DM1TCAeVbSwVkXX3wzJdeCvrYj7TXdX00bDWL6LckmFd0O+0y5bMco5KfqY
	uwSs3/fEksmNiXLwbQSbQlupLgvM2jqaLHqFUd01eNRpqJyyTwQaxJv1cEIj95jam5SOpb
	4VeREKBEpEVzwdgx1dpXw/Pv8+j3aYUlZkwfbW4KHuuV5bIhIoF2MqtTqREnIB7iZaQrOz
	t2AnfqwWGLyiFc0dKOPpnXszMahIpIwdsIFGKlbQ4UvsZf742CDaeymK1KrVCw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792481484; a=rsa-sha256;
	cv=none;
	b=Gy16M7b776uu+4goT+LEsSobjJpQfbkBaZ2xo0gi1QFx09JoDSPFjic7vDFUmknD7LQMUb
	91EXOHbCs5ioeAYRe9mfEH0ZrcMj/cuFrNayhrkJPlrt+xUFgxWGhMrHTR79QT21Qh2Lby
	QJcltp3s8sbLvEXSo85J+08EfhPLmXlKpKkPJFcDmNyvw1N9pLomthGYfqWi8uMRPPVi6b
	ZlY67KKQ9WH6yuELZN32h/HsRQsOu4HVpDsUdT4HujimhRYteZZAlrswz2nC1whkPQkYSC
	UqPiGx9IyILPfLMNfMITpH/tfJpuPPPWSwm9AlNxP+UZquKwnqgTmkYb0gAoFA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=jre@pengutronix.de smtp.mailfrom=jre@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792481484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DUpm1Avc0nkEXJ+1xf9Uuhznoyw2NJnoVeQzyuyKlAM=;
	b=MmYofbNobTDVCYmKhcTLpGs5DnTa2LkhbdpWT0aLnmvvDHqNlZSpO6gl7KcO4xYYHBGrzX
	t38jFhjE3AcjegRksFKwHH/UeoSpb7/TIT21zH996WeNwxly7wvzsJDRDK+aoiLgIfOPlO
	GCnp/9hpEZJ14adIxsCKatNSuxrtXqBCAgKM7vQaG7wDe6fVGH1ImcneC9rDPOVwfFepz/
	TOIUzJgllZsuXorKwUIL1HVDQCbF1UGjiShbB2DHf1pOwnViNgnHoYKKYnBx697wtGbxBS
	hkaxKRfccmo9M7rrznt8OgyHfyhM0fS+/opHkUUNGdumJKGv9Bd05nP1Nc5jeA==
From: Jonas Rebmann <jre@pengutronix.de>
To: jre@pengutronix.de
Cc: Matt Fleming <mfleming@cloudflare.com>,
	syzbot+c5b060ce82921a2fd500@syzkaller.appspotmail.com,
	Zi Yan <ziy@nvidia.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	Dev Jain <dev.jain@arm.com>,
	Kairui Song <ryncsn@gmail.com>,
	Lance Yang <lance.yang@linux.dev>,
	Liam Howlett <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Nico Pache <npache@redhat.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [[PATCH stable 6.12]] mm/huge_memory: initialise workingset state before folio split
Date: Tue, 20 Oct 2026 09:31:21 +0200
Message-ID: <20261020073121.190190-1-jre@pengutronix.de>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matt Fleming <mfleming@cloudflare.com>

[ Upstream commit aca1f2d5de17e138bc6c4859126b77e516b82541 ]

xas_try_split() adds __GFP_ACCOUNT for page-cache xa_nodes, but
__folio_split() leaves the xa_state's xa_lru unset.  That lets a live,
memcg-charged xa_node exist without being linked into the mapping's
shadow_nodes list_lru; when reclaim later walks the list_lru it trips
VM_WARN_ON(!css_is_dying()).

Use mapping_set_update() to install both the workingset update callback
and the shadow_nodes list_lru on the xa_state.

Link: https://lore.kernel.org/20260725101419.3938406-1-matt@readmodwrite.com
Fixes: 58729c04cf10 ("mm/huge_memory: add buddy allocator like (non-uniform) folio_split()")
Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
Reported-by: syzbot+c5b060ce82921a2fd500@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c5b060ce82921a2fd500
Reviewed-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Kairui Song <ryncsn@gmail.com>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Liam Howlett <liam@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Nico Pache <npache@redhat.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ Jonas Rebmann: move mapping_set_update to mm/internal.h as done in
commit 62e72d2cf702 ("mm, madvise: fix potential workingset node
list_lru leaks") upstream ]
Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 mm/filemap.c     | 9 ---------
 mm/huge_memory.c | 4 +++-
 mm/internal.h    | 6 ++++++
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index c2287a1d1c6b7..64c2325b92389 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -125,15 +125,6 @@
  *    ->private_lock		(zap_pte_range->block_dirty_folio)
  */
 
-static void mapping_set_update(struct xa_state *xas,
-		struct address_space *mapping)
-{
-	if (dax_mapping(mapping) || shmem_mapping(mapping))
-		return;
-	xas_set_update(xas, workingset_update_node);
-	xas_set_lru(xas, &shadow_nodes);
-}
-
 static void page_cache_delete(struct address_space *mapping,
 				   struct folio *folio, void *shadow)
 {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1a76a21724d40..54778d7d06b2a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3513,7 +3513,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		gfp_t gfp;
 
 		mapping = folio->mapping;
-		min_order = mapping_min_folio_order(folio->mapping);
+		min_order = mapping_min_folio_order(mapping);
 		if (new_order < min_order) {
 			VM_WARN_ONCE(1, "Cannot split mapped folio below min-order: %u",
 				     min_order);
@@ -3521,6 +3521,8 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 			goto out;
 		}
 
+		mapping_set_update(&xas, mapping);
+
 		gfp = current_gfp_context(mapping_gfp_mask(mapping) &
 							GFP_RECLAIM_MASK);
 
diff --git a/mm/internal.h b/mm/internal.h
index 9d277bc2c26e9..7aca909c54052 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1526,6 +1526,12 @@ static inline void shrinker_debugfs_remove(struct dentry *debugfs_entry,
 /* Only track the nodes of mappings with shadow entries */
 void workingset_update_node(struct xa_node *node);
 extern struct list_lru shadow_nodes;
+#define mapping_set_update(xas, mapping) do {			\
+	if (!dax_mapping(mapping) && !shmem_mapping(mapping)) {	\
+		xas_set_update(xas, workingset_update_node);	\
+		xas_set_lru(xas, &shadow_nodes);		\
+	}							\
+} while (0)
 
 /* mremap.c */
 unsigned long move_page_tables(struct vm_area_struct *vma,
-- 
2.56.0

