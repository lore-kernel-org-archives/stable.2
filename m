Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794424433;
	b=5BLfP2NbH6yamxmET76YQ7MWxUCLm88jDJzS+cPql1Vo20wpXLGIte3z49kWl5o8dIjc
	 1Gibapyoqx271Smo9pjwiWmTlIuK/lqjNUpbU74VNWIqykP/lmD6+Y8qhgaJd6j6ptg6+
	 PtLv9gn8KPHMydQ931xo+0Kn6lEfetfDqJTfvzvhloKpQa1U9SwKCJmIXNo2D/L/bANmx
	 WhI0r6xfJbb420o9xLJhULku9/TpgKDMLMn6XLdkQ5akowIy/RLRFoUkhDQearB+23X6u
	 +mNuJsCW1MEb06nEkhem5HZWcMEMxlhwLGYIIoOS6cHgMzgxU91L/tqvR7yLAvtozTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794424433;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2B3besPZA71mAbj8ksEVmeM3RSoTUvUOJQH78TzUjD4=;
	b=5kb75mdEXsTfcFlGjXrO1c4W/6QoejtlQ5/7UbqAukIger57mepj1GehhkbFApxidwSl
	 mrNKOsuVnefVlJAW+YJ3pQxtnT4wWwv+c5UoQjryFCB/CSxWB0rz6VHyD5CN67ZLMaY8a
	 veEMTXEwTZ8/+iy2G33ianUJP1EcdWFh1hGa32PGpZQjWZERnC0lFsws5szB0vXO+JvFF
	 HTxUio1HQIalMy9bKGSNYounWklrgHTU1l+JNPxzlPpXWbfePjKlGzqEBKl8d0lPY0bIQ
	 4CTlbzerygvGa+3iyeYkEN9xmIOru3l7YFeZPnBmRWiTuNgGnNzmVW8075dMccsXgyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rom0bMUY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8C1606A330
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 19:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rom0bMUY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D081F00A06;
	Wed, 11 Nov 2026 19:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794424432;
	bh=2B3besPZA71mAbj8ksEVmeM3RSoTUvUOJQH78TzUjD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rom0bMUYU74zrXCslkfIfzq2kvv1rC6obKeJA8arKZzN9eczSfJyHBGWjQrl0dWzp
	 N6xZKXt895sciCOPNUJDVFhR3foB5ElO4BALM449BH3KkgBCCOytrWfgYXCaFW0OUH
	 7aDQXaXL4wwOHQ6fQTRg/+NlHIL5+GApHxsfM06f1PquST2chzg/0VsZgnu4aACx14
	 F88VmBBJlLo2pPu7wUj1i8GdK2Rmv8+ItPhkqFXSpXm6bZrPhCukHwflvD16X2EOCA
	 gofHyFYhEGpYUid44Wd5Zu7hPaRlwCsOu+8m0Zg/KcqSfA8Yzx6A7nUQkXJ75XjsuM
	 bdjUMaQ36ALlg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chengfeng Ye <nicoyip.dev@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Xu Xin <xu.xin16@zte.com.cn>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/ksm: mark migration stores with WRITE_ONCE()
Date: Wed, 11 Nov 2026 14:13:50 -0500
Message-ID: <20261111191332.3939168-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053152-failed-6.6-d3863210464f@kernel.org>
References: <20261107053152-failed-6.6-d3863210464f@kernel.org>
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
[ sashal: Adapted folio_set_stable_node() to set_page_stable_node() with page->mapping and PAGE_MAPPING_KSM. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/ksm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index fa4229a224060..a79a2d8b24abd 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -916,7 +916,8 @@ static inline void set_page_stable_node(struct page *page,
 					struct ksm_stable_node *stable_node)
 {
 	VM_BUG_ON_PAGE(PageAnon(page) && PageAnonExclusive(page), page);
-	page->mapping = (void *)((unsigned long)stable_node | PAGE_MAPPING_KSM);
+	WRITE_ONCE(page->mapping,
+		   (void *)((unsigned long)stable_node | PAGE_MAPPING_KSM));
 }
 
 #ifdef CONFIG_SYSFS
@@ -3078,7 +3079,7 @@ void folio_migrate_ksm(struct folio *newfolio, struct folio *folio)
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

