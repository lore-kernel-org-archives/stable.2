Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB293C10BD
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 21:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784150891; cv=none; b=uEpPujGqZs4jKsOEY7FK92YlbgxrQg/rQE4FIoh5txewjYppC+hzLyq8/5/p7JX7lKwYdS1nWa6nydklWYGobBl4guxe2gmso15rwhrG2A7e1/OOUwhk65TVGv++fv7cvdSCOyVsZSmaMVVOIi5EMCmKQwivhgEvmRCYTJ4gt9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784150891; c=relaxed/simple;
	bh=AiZhVAcYLSdW+rJNJc5TFpf6V7GhJxiLwFpJvxrozG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4efbB6kP8jfDJestsjl8ZF97CFIl0k0Q3CPoDYQq24pikUtFUn0BzXM55Ukaf1i4/b7flIog8E9BmTsuZlOGuqpbgUL5PYenOemt2HsTIRahzXTrANAW3RooWM1kCpKR1mM0oUYbeuPw5nm4EhJvJlYwjZrgy5U7rm4yqJImdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlwijbHv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlwijbHv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1D11F00A3D;
	Wed, 15 Jul 2026 21:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784150889;
	bh=4dhwPAbTuQsKCTJFJsOTcQhhjZFv906Ivl++fc2cECI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LlwijbHvRPD3bYUSfhs/jFyEUWe+lz1aCQ0GUil1ZW7QxoZsGzAHteJ0yJlkxJNI5
	 Biy7Uw5ZfFezL6gk+3zM9DublLBVlUfjldBX8AIQuVhBSHyQo0ovR+rdkuu0bWJ25q
	 DYwhpxYLeqX2nP168OyfKVLi8f7fEpTsrxntb9uKih9pLISKFbVqddl6jZ+oSgxPP/
	 49s+rZlvC+ys6Flx3g7YlaeBvLMTE1Fyizj+Ysx0OqcN6q3ym6Sxtpv0WW2ylnbbyQ
	 Y823ICoNfI+5MGjEfJOZUGJ4ibPc9HCjCKsb3y6OQJu2N2GcPT7iC53EuJW/fBUEqT
	 qhBNGuPgiLKsQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>,
	syzbot+e12bd9ca48157add237a@syzkaller.appspotmail.com,
	Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kairui Song <ryncsn@gmail.com>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm: swap_cgroup: fix NULL deref in lookup_swap_cgroup_id on swapless host
Date: Wed, 15 Jul 2026 17:28:07 -0400
Message-ID: <20260715212807.292409-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071302-lethargy-obedient-3108@gregkh>
References: <2026071302-lethargy-obedient-3108@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>

[ Upstream commit 63b02a9409cb5180398491b093e48bcb5315f5fb ]

lookup_swap_cgroup_id() passes swap_cgroup_ctrl[type].map to
__swap_cgroup_id_lookup() without checking that the type was ever
registered via swap_cgroup_swapon().  On a swapless host every ctrl->map
is NULL, so __swap_cgroup_id_lookup() dereferences NULL + a scaled
swp_offset().

Since commit bea67dcc5eea ("mm: attempt to batch free swap entries for
zap_pte_range()"), zap_pte_range() -> swap_pte_batch() calls
lookup_swap_cgroup_id() on any non-present, non-none PTE that decodes as a
real swap entry, without first validating it against swap_info[].  A
single PTE corrupted into a type-0 swap entry takes the host down at
process exit.

We hit this in production on a swapless 6.12.58 host: ~1s of
"get_swap_device: Bad swap file entry 3f800204222bb" (do_swap_page() being
correctly defensive about the same entry) followed by

  BUG: unable to handle page fault for address: 000003f800204220
  RIP: 0010:lookup_swap_cgroup_id+0x2b/0x60
  Call Trace:
   swap_pte_batch+0xbf/0x230
   zap_pte_range+0x4c8/0x780
   unmap_page_range+0x190/0x3e0
   exit_mmap+0xd9/0x3c0
   do_exit+0x20c/0x4b0

syzbot has reported the identical stack.

The source of the PTE corruption is a separate bug; this change makes the
teardown path as robust as the fault path already is.  Every other caller
of lookup_swap_cgroup_id() is downstream of a get_swap_device() that has
already validated the entry, so the new branch is cold.

Link: https://lore.kernel.org/20260504-swap-cgroup-fix-7-0-v1-1-f53ff41ee553@linux.dev
Fixes: bea67dcc5eea ("mm: attempt to batch free swap entries for zap_pte_range()")
Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
Reported-by: syzbot+e12bd9ca48157add237a@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/69859728.050a0220.3b3015.0033.GAE@google.com
Assisted-by: Claude:unspecified
Cc: Barry Song <baohua@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kairui Song <ryncsn@gmail.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/swap_cgroup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
index da1278f0563bc1..d6f6ae0ef2b379 100644
--- a/mm/swap_cgroup.c
+++ b/mm/swap_cgroup.c
@@ -161,8 +161,14 @@ unsigned short swap_cgroup_record(swp_entry_t ent, unsigned short id,
  */
 unsigned short lookup_swap_cgroup_id(swp_entry_t ent)
 {
+	struct swap_cgroup_ctrl *ctrl;
+
 	if (mem_cgroup_disabled())
 		return 0;
+
+	ctrl = &swap_cgroup_ctrl[swp_type(ent)];
+	if (unlikely(!ctrl->map))
+		return 0;
 	return lookup_swap_cgroup(ent, NULL)->id;
 }
 
-- 
2.53.0

