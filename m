Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425363;
	b=48brV4jLayDndP9pUqEOv9pliQ6XR5bZL8IYNaCJJ1df76u55IG5SfrSrLZmlxwUfqO9
	 yXXok99UNYdEmvzNOi0WyGpDQqKNWbMGzf9DCRPpt1ao3yH2VFc8BQbzqmGqz+ctzirRx
	 s4QH/g74AZl10D+EH5ZUdFaPIAiOSnYg3rLJUEyH6RgDAdEyo3O6BYlH9H+/TtofLOu8I
	 p2sub+SD4maNr0EtMY+doxHwmVt2ojk0M6Ohdz9pEoFNTAqQXBS6yUSHKltH/XkOwFa5S
	 PYisu9TItiwAYz68De1MHqYGIUUxp+xztsNySpOMWJtT1s/1YnZ8hlawMw3jSPEEsAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425363;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3CJKnJUUEQqc9D7/K2DZ4cq+Vui+GbNmW2tFxDU+shI=;
	b=gon6nwBGsyFPkNaUjALNMrNIGsjg2y7S5xvQeM8jQBgiDuTpR8zet7HbEOQb4YuNvjHg
	 I2yW9xGQygaFKBr+Wmwk916xTTerJiyb/R9NQuNfCX8assZbf+KJ8dwcyzCabUfkaVdW8
	 uSnI70f5bqKsU1dtmw5/g+DA/wiVRmFTYw4d4X0qkA6je5nExg21ZGLrssE/YwpbIibMY
	 pVCEXXDTUqU+JatIFOL3J4fbqcNYhgALCc7E8NJqkWjD0WGH3/v0Of5w1BjzL2QcoXX1W
	 wy8505b+GR7pYNou0zcqjQJDsHprp0SnK4AAcgjesWtCyYoTRaaymAppuzA0zrnSIGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="nIp/ughy";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE52606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 19:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nIp/ughy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AEC41F00A05;
	Wed, 11 Nov 2026 19:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794425363;
	bh=3CJKnJUUEQqc9D7/K2DZ4cq+Vui+GbNmW2tFxDU+shI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nIp/ughyU8vhcWxAQp6ln2NC50ZtzJoLieAsuhPzh8lAS4V5w/1X8VslHlvnomh04
	 YSPwviXeISnhDJl9sBe4QQ71tUJTT15IyJhk/xs86t1wctL4meGEPCyRBpZNyZocYF
	 E1qJZzRBeyrbx86Q3Q5Zd3AJmMjkry1SKpaqaC4L9kAzD4uB6XmvHn9ssPiVMkCINX
	 Dl3etiGrDKOomfQlBNzIq0l2EDcRXyR8dRhxlt8jU3PImmER6uhZUoatiiI5E8+4o/
	 TOrakC22cQey3Z9YF9ttuNMltu5v7eMa+6Ihle807dC5GUe+kg3RaWfDEym2yU/yqV
	 TcKbXO7dXpgXQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chengfeng Ye <nicoyip.dev@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Xu Xin <xu.xin16@zte.com.cn>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mm/ksm: mark migration stores with WRITE_ONCE()
Date: Wed, 11 Nov 2026 14:29:21 -0500
Message-ID: <20261111192903.3987292-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061908-failed-5.10-d3863210464f@kernel.org>
References: <20261107061908-failed-5.10-d3863210464f@kernel.org>
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
[ sashal: adapted folio-based KSM operations to page-based equivalents ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/ksm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 466ca19997551..f9bb12cb8cec5 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -869,7 +869,8 @@ static inline struct stable_node *page_stable_node(struct page *page)
 static inline void set_page_stable_node(struct page *page,
 					struct stable_node *stable_node)
 {
-	page->mapping = (void *)((unsigned long)stable_node | PAGE_MAPPING_KSM);
+	WRITE_ONCE(page->mapping,
+		   (void *)((unsigned long)stable_node | PAGE_MAPPING_KSM));
 }
 
 #ifdef CONFIG_SYSFS
@@ -2774,7 +2775,7 @@ void ksm_migrate_page(struct page *newpage, struct page *oldpage)
 	stable_node = page_stable_node(newpage);
 	if (stable_node) {
 		VM_BUG_ON_PAGE(stable_node->kpfn != page_to_pfn(oldpage), oldpage);
-		stable_node->kpfn = page_to_pfn(newpage);
+		WRITE_ONCE(stable_node->kpfn, page_to_pfn(newpage));
 		/*
 		 * newpage->mapping was set in advance; now we need smp_wmb()
 		 * to make sure that the new stable_node->kpfn is visible
-- 
2.53.0

