Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794424579;
	b=jgW/Ts2U/eBXgXT2lHG7DuwaoEVj3snqWP/cDfcKI21GhNmlfZ4OfbnnLHOuCC34zohw
	 uAxJ0boAvGHjqoMfAXtDnyaD08a+Lc7RIFs0ksy1tuVZvJiwOxPynSDVaD1Aos2lHW0oS
	 8eU0ckqQWjC5ifacxj6jRG4tS2+x5mIjhRdfnjedlU1ZLyMONahIDh5V/6BCBpbXMZwge
	 twySI9fER9L7FBLKFcKpeQCbV+hRhCmgkCKoaZagE949vyOVGCFS2sKpcTnWKsJ2HO/RO
	 OKBSfJNcIjX2pBRUz+l9S4KqhjhAkgaj253l8VxupjmV7zP6IXP9MGBnPLmxQR+wyJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794424579;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2/3Ici1P2EQdNMayHjl3He1Ix6eyzOkvOy5K7S9aobI=;
	b=y/vUEexnPsw50n59TLTBNOSfgPAFeaCCP8OqzCL9il04AEvq/QKdf0c7Z3iOCy33PN7w
	 KDFbRYR15q0P6lcwiZrjH6ZWpX0jT2gxLxsDffCgd0lA4C5EDl48acMS+Kqvo4UtW0OtG
	 vBrInFxtVLCIzvHkhBc0EiuFW+59CSY0xxbyppjdoOabT+OjmkISdQ+Qsh53i7EA6813I
	 YO7rmYuRqHUEc0hSMiyqv5LQuHH3I4ezHmjBX1CgvqpFyFUEc6jN/B3h/qTB15di6N8wk
	 iloNA8/T2a8EpTwHdfNwvwedg+uMfLZaY7p8ecJgY5dsOQSJJVzTozr+RcCs/O5cVhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bET+8Et0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A59606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 19:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bET+8Et0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A9B1F00A05;
	Wed, 11 Nov 2026 19:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794424579;
	bh=2/3Ici1P2EQdNMayHjl3He1Ix6eyzOkvOy5K7S9aobI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bET+8Et0/RfCYgAiL30m1mh3X3jJLVKtLQG6gD3kFBhzv36aI6K+d24Ovjjd2JlxB
	 JpVbIYR4/zFLTqhMvFYlhZMyPbIhwkS3MXfVqEXSl0SRvbKsKdPxAOFm2SYKlH7Egw
	 VeLBQC4Q96g/8Tru28xF/kv8Qf3iN+io4XfMHIwg2Hsq/x+Z4izxjKA0axesPKedeY
	 38je2TEYovSp9AIKz5+St/zgTK0nRN6/Qzdr0YyQQYiC8gC7Mfl3jXLdYfBm2GktZo
	 iMwoYHNRDAxy1HZaDsmYpXIohIuw7CYW3dk0fLCk1d8hX0nP54oIv6VLckG8dP548+
	 yo+Qu6WLFS6iw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chengfeng Ye <nicoyip.dev@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Xu Xin <xu.xin16@zte.com.cn>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm/ksm: mark migration stores with WRITE_ONCE()
Date: Wed, 11 Nov 2026 14:16:17 -0500
Message-ID: <20261111191555.3977471-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054441-failed-6.1-d3863210464f@kernel.org>
References: <20261107054441-failed-6.1-d3863210464f@kernel.org>
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

From: Chengfeng Ye <nicoyip.dev@gmail.com>

[ Upstream commit d3863210464f69c18615cbe400d48a6e53e770d4 ]

ksm_get_folio() deliberately samples stable_node->kpfn and folio->mapping
without taking the folio lock because the KSM folio may be migrated
concurrently.  folio_migrate_ksm() updates the same state using plain
assignments.

The reader can load the old kpfn, then the migrator can store the new
kpfn, execute smp_wmb(), and clear the old folio's mapping before the
reader checks that mapping.  Thus the initial kpfn load can overlap its
update and the subsequent mapping load can overlap the clear, with no
common lock.  This leaves marked READ_ONCE() accesses racing with plain
stores.

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

Link: https://lore.kernel.org/20260824112433.191301-1-nicoyip.dev@gmail.com
Fixes: c8d6553b9580 ("ksm: make KSM page migration possible")
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Xu Xin <xu.xin16@zte.com.cn>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>
[ sashal: adapted folio->mapping and FOLIO_MAPPING_KSM to page->mapping and PAGE_MAPPING_KSM in set_page_stable_node() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/ksm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 99eb19860fd59..165112806ed83 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -846,7 +846,8 @@ static inline void set_page_stable_node(struct page *page,
 					struct ksm_stable_node *stable_node)
 {
 	VM_BUG_ON_PAGE(PageAnon(page) && PageAnonExclusive(page), page);
-	page->mapping = (void *)((unsigned long)stable_node | PAGE_MAPPING_KSM);
+	WRITE_ONCE(page->mapping,
+		   (void *)((unsigned long)stable_node | PAGE_MAPPING_KSM));
 }
 
 #ifdef CONFIG_SYSFS
@@ -2805,7 +2806,7 @@ void folio_migrate_ksm(struct folio *newfolio, struct folio *folio)
 	stable_node = folio_stable_node(folio);
 	if (stable_node) {
 		VM_BUG_ON_FOLIO(stable_node->kpfn != folio_pfn(folio), folio);
-		stable_node->kpfn = folio_pfn(newfolio);
+		WRITE_ONCE(stable_node->kpfn, folio_pfn(newfolio));
 		/*
 		 * newfolio->mapping was set in advance; now we need smp_wmb()
 		 * to make sure that the new stable_node->kpfn is visible
-- 
2.53.0

