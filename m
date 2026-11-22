Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795351359;
	b=rONarDplDYfpUA9GtGhug8FF0HdSO7x8Rc2I6LqS4f6jKoi+icHPJf5zHnDhdsxXhcQg
	 sq/1E/MaSw8RfhV5iGK1vitoYT1NLEp2bv4L+KoL/HvJCcnlo12tj2B3t39zBWsw96CG0
	 wK39s1p2AUMOu5eRbsLMAMCdMgrRW23K6ZXmc8pXlq6unZf+ARWu6PKpVFYqiv8uaFdMn
	 dsM9Ketf6C+Gw0O16G26UhUDDoGKvdXEhefkNLFTzbH1W4HvxAuh8exMRc7r4nMStvgSR
	 hiQ02JZxQHXlVJ67zrkxK3fi+ojOfFN2mwBp4C6EfWKlxiHqaAh5Xxg0/gpStAa2ulw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795351359;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=VocNkS/2cBGTqC/iQ+yEVdcXEbMXCrY7zeEC95RbIoU=;
	b=ibFL9gxeVDUdvoDnN0mrVIkHeyhi4+2/3A1NzYLYTIpAhNqr6o9l0HCzVhUTGfuoyh69
	 H99cz0hb1ytrHQ7RiUI7lj18q7kqXsOp+DuG4afcPmy8KHB+tmfJleMWj99JEcIUs/lv4
	 0rEXG8HUBuKvN0Jd5tpe0I3+/w7hovDzkldodAOuu78LmVFGTOorVEIg7LQ5mZ+Q4h66G
	 MSWyhduVfkwOR/5uuFnlAHS/TCoHXIeQ5INFBQWMYHIUzZA6lWILBD8j6gb1rKdrWFS2z
	 dEKIH91o65PF/rUFRBqTzPW/0xB5kPjE9X3WJK4RirANTS0Ks8RThQPFcg5VFXou9wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ui1TIecL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF02606A320;
	Sun, 22 Nov 2026 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ui1TIecL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61DB1F000D4;
	Sun, 22 Nov 2026 12:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795351359;
	bh=VocNkS/2cBGTqC/iQ+yEVdcXEbMXCrY7zeEC95RbIoU=;
	h=From:Subject:Date:To:Cc;
	b=Ui1TIecLzRfZvfuZEq3oVQVO168omOXqtg/+Obb8kscYYVhga71dOJoyd3yF5d8tD
	 VIhPRl9yFR2eNKo+S2XB0VQ3BBm9aLMfZPW2oMutfD8gBOPs+ghhND5zvUFO/BAAxZ
	 p+tkDyFjnj6eEyiTQY+bqTvBgcFpDqakl3Q5nr9PkZOrYZSQ9zSPLEl2XwA9r9/JG7
	 W/7uLVrdAWW6Kvn//5faO9dCi1pB6qYvqTP1KShYslpZr09ApQEZ1GOYcjqePDcKwD
	 RxivDXDqZCANZXw/JrGYZjxmapcGYZepAw3e4sV9L83JbcoTnQ3LqbdJWL8G6yG8XR
	 XWaDBLuuN+tZQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH 0/2] mm: fix deadlock on the folio lock due to inode
 eviction
Date: Sun, 22 Nov 2026 13:42:16 +0100
Message-Id: <20261122-migrate_reclaim_deadlock-v1-0-83c56185b0fb@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMTQrCMBAG0KsMs27ADKVoriJS0uSzjvZHJq0Ip
 XcXdfk2b+MCUxQOtLHhpUXniQP5ijjd4tTDaeZALAdpvBfvRu0tLmgNaYg6thkxD3N6uLqGHCH
 SdKfMFfHTcNX3rz5f/i5rd0davh/v+weun7c5fAAAAA==
X-Change-ID: 20261121-migrate_reclaim_deadlock-44e28e226b9d
To: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 William Kucharski <william.kucharski@oracle.com>, 
 Heiko Carstens <hca@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Miklos Szeredi <miklos@szeredi.hu>, Joanne Koong <joannelkoong@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>, 
 stable@vger.kernel.org, Chris Mason <mason@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2395; i=david@kernel.org;
 h=from:subject:message-id; bh=EVf3IUvbYA/h7bHadHrnyZL6o9BArIID6FP5pA54HGY=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLKZHuu89Sg1TAtgl6hLsJKeGJF87WPwHr493CfKH8bti
 dmyIdGso5SFQYyDQVZMkSUo+L7By5fraqvd+Jhh5rAygQxh4OIUgIkcyGBkuJryZkPgurlvTi44
 3K1j35XTk3fuc+BFNv6gE4p6lTK/NzMy3Dlz2TvkyJPPE78FT5XMl6vkkzdTPnbbwbM45u267G8
 HmAE=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Whenever we allocate memory with folio locks held and trigger direct
reclaim, we might end up trying to evict an unused inode. Evicting
inodes with a populated page cache takes folio locks, and if we happen
to need one of the folio locks we already hold, we'll deadlock.

This can, in general, not happen if we also pin the folio's inode: for
example, through a VMA that cannot go away concurrently. However, we
have some scenarios where we hold folio locks without pinning inodes.
Examples include page migration and some folio split users.

FUSE makes this easier to trigger, because it evicts inodes on the last
reference. A similar deadlock with FUSE was recently fixed in FUSE [1].

Let's handle folio splitting by simply running in NOFS context. We only
perform small allocations, so it doesn't really make a difference.
Interestingly, this also fixes one of a handful of possible memcg v1
deadlocks.

For page migration, change the code to allocate destination folios
without holding folio locks, which is in any case the right thing to do
to reduce folio lock holding times.

Some of this might also be fixable using Jan's work on deferred inode
reclaim [2]. However, that is not stable material, and not allocating
folios while holding other folio locks is an improvement on its own.

Unprivileged users can trigger this deadlock with FUSE and
mbind()/migrate_pages(), however, it requires multiple NUMA nodes and
quite some luck.

I reproduced the original deadlocks with FUSE and made sure they can no
longer be triggered with these fixes. Further, I ran the usual migration
and folio splitting selftests.

[1] https://lore.kernel.org/all/20250925224404.2058035-1-joannelkoong@gmail.com/
[2] https://lore.kernel.org/all/20261009133253.20102-1-jack@suse.cz/

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
David Hildenbrand (Arm) (2):
      mm/huge_memory: use NOFS when allocating while splitting folios
      mm/migrate: allocate destination folios before locking a batch

 mm/huge_memory.c |  10 +++++
 mm/migrate.c     | 134 ++++++++++++++++++++++++++++++++++++++++---------------
 2 files changed, 107 insertions(+), 37 deletions(-)
---
base-commit: eb01811cc3713af1f78dfe18fa89c5270ebfc767
change-id: 20261121-migrate_reclaim_deadlock-44e28e226b9d

Best regards,
--  
David Hildenbrand (Arm) <david@kernel.org>

