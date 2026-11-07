Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047515;
	b=z7dxdLmwZsynETP2nw4Qmxli6IzEwthSdm2Nb0Y2tW3qF0PQj7lF0SJeuUY/fD1cuace
	 xorK6K5jlHjkerFAfZbn6w+//gfx/l3Hi508vy75A3QikMzlIF/BS8/xMXoDi5qHYUA15
	 wFSk5LiCTWUzW5CeH8tBJ0XqOVBxYzRekqu3lzuRzkIgnyD5zGMciZIPx0vbDBhyzIRc/
	 rGNX8lNpkOCj12D1iQHtiOP+pD/7YsI9grwjJpxQkAQw2qKdL0fdHt8mMW8ExEiwBIz5Q
	 TDW3ZQgBqkiQQnIfmmCBj+vXcjRXjO3xwPf25TMVS9CDFwC1dCr4ue2goO76T9bi/rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047515;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ON3oTWPgbOJezT/1LLQX+rils+FzT+yYaBahvhzuctQ=;
	b=2jGoBGJwIwiNnIW+ABE4dycjvNNQwDSjkM9Y1+ingewdmorzO/GFphSBntYRdYGDEyFS
	 sf7a9TLq8pNP+AzbZhXS37FvtIZ8vic7hvoezmmQ+Wfh/RYBLkJIf75fj9DUsh6AqT7ZG
	 iW+/42sHiL27pv/tN+P/CDeV8XUbjyVnPfAOE8/lJ2pOykiqT9vjy5RlgQCMQQbQqREjG
	 RySSHuWK4dSngknUXbgPahIw7tnUhRxJZAWeOR1PzExo5NB/w4v3DQUxHOEMJIKhyiZtm
	 mChIF/pFkr9yeO9tmLnfg0Z5PzU0C88baS2Thmf6BezeQmp4ULdlnBKmvJUJAr8R9cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j1sgSsLW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DACC606D815
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j1sgSsLW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ABBA1F008A1;
	Sat,  7 Nov 2026 10:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047514;
	bh=ON3oTWPgbOJezT/1LLQX+rils+FzT+yYaBahvhzuctQ=;
	h=From:To:Cc:Subject:Date;
	b=j1sgSsLWLEABoBDr0vyFhkyTeC3JwmuR3B8F/+5J9JijQekfh59VuZB7x4qMrnEDi
	 hQepuRY9805UV/UGptVTyen9f8Z2X7itnkUaue8/cScEE2vwvmf3M7fZutNuSVZ+fe
	 harDJOWRVNy90N03scld2aGhPko8Jl+7Rp9yGtPYxUN0MMxAyViAZee7MnpxLPF+v9
	 RAML2oMKIGSasn1mbSoeZenaI3M7/cFgjOnG+Oxhfg672BunRx6Z8xQymjEKa921c4
	 fWaoOM44F7APKwTliRqxqPoIM40wsdiwBRAeQDtT4UT0WSC0GFIkZ4OMgd4Vzrg2go
	 mauOfo0ANqSiQ==
From: Sasha Levin <sashal@kernel.org>
To: nicoyip.dev@gmail.com,
	akpm@linux-foundation.org,
	xu.xin16@zte.com.cn,
	david@kernel.org,
	hughd@google.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/ksm: mark migration stores with WRITE_ONCE()" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:31:52 -0500
Message-ID: <20261107053152-failed-6.6-d3863210464f@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x d3863210464f69c18615cbe400d48a6e53e770d4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053152-failed-6.6-d3863210464f@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




