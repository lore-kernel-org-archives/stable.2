Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794423958;
	b=KZuig7DbIvsasDIDEfaDNXy6tJZD3MvaGInExkjrXqJ6a5tNSzgCVg6E2flUEq2OOtmK
	 x4M8fKg7ytQlYDV60BdygK5YPwGi+8Vt3JhVHgIfg9rid/Gk7gA2TMZXklc32sj2ZmhY8
	 VG96HO3VgeZkten26gUy+YD0apM6tPeHrpw24qE3p5LOhy01ejZ5FG2VDy3DDsWUnQQiU
	 25bmaQ9NJl7pquF55uHoEslrfRGQsh4e+g9Rp+4lS+YZSNpGutQWKajRgwfTuCZCsquMx
	 sUdWsXZ/q6Zati+wbYbD6wTT5XTo6uFD/35NpBTS/0ZhVrYNUXOt7s0cu848unEUV4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794423958;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DUUjes8FkiTvF0NFZ8yTqJmg1imvTJUu2+IAJvkIhLs=;
	b=yhJabH1YV6LotkfAUOxaO2Gmjh+k4dyEfMjGfvLrjoGbf0a0AQDOWHrJ/4ujzdHLaGHr
	 etsmL/L3+2ei3X98g9iTOKAOKXjOHIu5SHusniHQLbbHu31ms6ra5txEXBS3nmdObOwZC
	 yMeAGMpRbzdwMffVKAF5tHIm6cxqQ9Ny11Woazvm7fs2gVfkpCPwninyli8/LmbhjX0fC
	 XXBUga5TXoOCkL//Lf4xjqkFB38nUM+3MVJAXS3x/RtwtSWXYABPQL3dSaJyRiU/W0jnu
	 T2XnyehhYqB6bGTzcfOqDrtdTY8UKV+IEjJfgxkJL5ZAw6bLpXEDQI4cOg8vQqkIefA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gBbnuiJr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C55A606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 19:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gBbnuiJr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5565F1F00A05;
	Wed, 11 Nov 2026 19:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794423958;
	bh=DUUjes8FkiTvF0NFZ8yTqJmg1imvTJUu2+IAJvkIhLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gBbnuiJr5gShTCGKyBLAQvcZ/rADCsjm7ygW3baPMPPytTdqV3eeHUrMXtkljcOUr
	 naC3cSndS3FAx9OeXPOB08W499S29yBLCb9meSxQ1QPdjtDFXDgUV4oXBerf4XFsKc
	 CGY22VGUfPBEjkWARvxfT96iw5khiDDBt8sTqwa5hOtNDFaykaCFc48/ID1620kRk1
	 qc7/zLtsAWPDA/8E8bN9pNLTZOHqIKnIKWC9pAtjUNGMRwXMPhCNUr75fpXDveMXi+
	 fCxGxA0JNJAT4OSRUdyYk+khNZymCaw9K1aQdTaJCuJR4la0Zr7oJl4AL5f4krmWdi
	 Cngg/TV4zmbeQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chengfeng Ye <nicoyip.dev@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Xu Xin <xu.xin16@zte.com.cn>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm/ksm: mark migration stores with WRITE_ONCE()
Date: Wed, 11 Nov 2026 14:05:56 -0500
Message-ID: <20261111190539.3925929-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051928-failed-6.12-d3863210464f@kernel.org>
References: <20261107051928-failed-6.12-d3863210464f@kernel.org>
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
[ sashal: Replaced FOLIO_MAPPING_KSM with the equivalent PAGE_MAPPING_KSM flag. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/ksm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 8ce4cd5a382ce..8422cc6e8af7a 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1067,7 +1067,8 @@ static inline void folio_set_stable_node(struct folio *folio,
 					 struct ksm_stable_node *stable_node)
 {
 	VM_WARN_ON_FOLIO(folio_test_anon(folio) && PageAnonExclusive(&folio->page), folio);
-	folio->mapping = (void *)((unsigned long)stable_node | PAGE_MAPPING_KSM);
+	WRITE_ONCE(folio->mapping,
+		   (void *)((unsigned long)stable_node | PAGE_MAPPING_KSM));
 }
 
 #ifdef CONFIG_SYSFS
@@ -3233,7 +3234,7 @@ void folio_migrate_ksm(struct folio *newfolio, struct folio *folio)
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

