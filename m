Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048283;
	b=zhEJv1sxfbGAE5Y40JFfuiEMRok6bKBKLbXbs+UT3yoOm5fqd4VRAArmJNC2lR51XU3n
	 Se1y13DQZDnI4xXsQeQFnN76/smWKBQ/eQgNBoIRxbdMTsPis3ewP7xbEBDKyxoU4Ifqg
	 +4zBRzseq720p/AIpKLLRNJzMCiZiOuRiRnwXIMpXYvXoFH5tS0m6Glvw+f33LwFw46zH
	 RQ2dXIBzlz1H8A25/4QG/XOzR3dNuMM9ivhphLyAEFpBYUZpBboTykm9BIE4pC7V/g9gs
	 MUTxvAN9Gn56tmQssnJ2xj873VJWY49B1sMXT1HQ8NGFQnvpEWF5yy2PFWro5tnLUMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048283;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1pMCpcU5RpfwqtGWAx0IoJWyaDb1BUF8y69IWpN2XwU=;
	b=zKjL6/jpHuQ1M/qQcaWDKJtVoBAmW3jw/cJ2V3EAoDFo29BBkl4F5M0pVtN3Kdx1KeVs
	 a4KtCxJchun2A3ibwVP0RADhnVEiLka+wbLVPrm8BqzwgT6bbId+LMxV97c9/N1ostnSB
	 ZAD7lFFTlu9kLT2gJIL5kPTB1NnipevoWvgrgXXGuGMfTKRDtDcgHut1/arJqL5QwQZXq
	 HfxZw/+NdGF95Xfdi6EUZtr1bGLcrJ9PnYCWKs/9nRSq0niTDaeN7T/j0Co5xQBklJWMR
	 twUaUf5SWunn/Jtfn0Y3mn3iYM2i08lARMUKomgZ7YtiQp8/uL9jJ8MiwQAhUfYJ7XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RXD3Io0s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E65606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RXD3Io0s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833471F0089F;
	Sat,  7 Nov 2026 10:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048283;
	bh=1pMCpcU5RpfwqtGWAx0IoJWyaDb1BUF8y69IWpN2XwU=;
	h=From:To:Cc:Subject:Date;
	b=RXD3Io0skQ4DWH7PcqkE9wScbdzqyAu31kOQJmnZf+jDQz900+vYWaRM9zUL0193X
	 dvGUdZsYgKNRj8vHELMOV5CNrX4XYPI1mjDYDosNNcp48l1ZXtLx8kjOZcjWFRbxCX
	 4XVWLbSlv48x9RzaBkQ7jbWNPFnXOfQHo6e8hXA0atn1WkmcztK9gsZJiTul/ayYdk
	 5ATV89PIJd/APIjmVtV6FjXroS9BiD40Y3f14M8fVm9evjDSQpNURGuFJUE6JWdIzK
	 g1ZXOkPMDw0J/s6pP8wCjo9PgZY39/raTo2ePNp8x+bKns8uuhGqViFHdOuEtA+Dh+
	 2CZIVFXKyy/fQ==
From: Sasha Levin <sashal@kernel.org>
To: nicoyip.dev@gmail.com,
	akpm@linux-foundation.org,
	xu.xin16@zte.com.cn,
	david@kernel.org,
	hughd@google.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/ksm: mark migration stores with WRITE_ONCE()" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:44:41 -0500
Message-ID: <20261107054441-failed-6.1-d3863210464f@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x d3863210464f69c18615cbe400d48a6e53e770d4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054441-failed-6.1-d3863210464f@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d3863210464f69c18615cbe400d48a6e53e770d4 Mon Sep 17 00:00:00 2001
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Mon, 24 Aug 2026 19:24:33 +0800
Subject: [PATCH] mm/ksm: mark migration stores with WRITE_ONCE()

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
---
 mm/ksm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 49d48d1e09980..fe42c17490b89 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1115,7 +1115,8 @@ static inline void folio_set_stable_node(struct folio *folio,
 					 struct ksm_stable_node *stable_node)
 {
 	VM_WARN_ON_FOLIO(folio_test_anon(folio) && PageAnonExclusive(&folio->page), folio);
-	folio->mapping = (void *)((unsigned long)stable_node | FOLIO_MAPPING_KSM);
+	WRITE_ONCE(folio->mapping,
+		   (void *)((unsigned long)stable_node | FOLIO_MAPPING_KSM));
 }
 
 #ifdef CONFIG_SYSFS
@@ -3316,7 +3317,7 @@ void folio_migrate_ksm(struct folio *newfolio, struct folio *folio)
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




