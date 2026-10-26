Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057199;
	b=v5VHw7Kf97ECf36zfP/L8gUIcKEnabf3VKHk5qcVlFP734vEbv1a6CiQmWuETw4WbdUE
	 FKuf847DpsZYtEsC/L2HR01hcTIMuptJgkIOo2eAgtOZlThOQrRnGc4OPxoJ2k0Db8Pyo
	 B5i2mKUXJ/onASk+ojnXL4oltnUvtauKP+kHrxfgjXEuXhdM8jnvP308lHWM9AdpGn0W7
	 vRhTV+u30tL8b2NsCh+9SJVjCUSToiZs/r0rwwU/VoMd7MOp8gV5mLBqFs38PR1gAmWQD
	 fjUbiCsodxqZUQCGj0YRnInZGrY9ZgX0e7VcNiOkq6g7li3j2fZLa0Aa189+CtlMwBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057199;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=JD3h3UamRh59QcjyL8J1MuE/w/u1X5RZ3DOsE1wllXg=;
	b=NeQb2GcWBl5Inypx+1MhdXyhs1QJBavrKhzQAnVRw7fDgBWMtC61HFlGZRgWFOPyQZ4i
	 leMfK5UUStfpZfCbWGFR/gWnhiBJwxiWRxMs8FtSosQ/U+r671WiC1aUlFox3lMYd8/D5
	 9776zCmnWSMg9zcikAfDdpMxMH1k20RvdJQ3beErtpMTpF+EKpFIZxHHw6NtcKLMstYmX
	 Paf1qn3X3AtsxiTFqdu44V56FpUn3nstBCerh/DFpXUnVWwLYXbfChzbn8RIFhHxZR7Il
	 DOAVElna8z1VlEwQTfTW+Aa4p/CJJiwg/qmYBdicuamtLdj7Ik0/Vr9aO7Ij6PUU0Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NqxXcyZ5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73544606A31A;
	Mon, 26 Oct 2026 23:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NqxXcyZ5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A8C1F01825;
	Mon, 26 Oct 2026 23:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793057199;
	bh=JD3h3UamRh59QcjyL8J1MuE/w/u1X5RZ3DOsE1wllXg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NqxXcyZ5B7hNxVICB8D7ZuTu2KTFj1aY/wZHjWEHcrphKUZXEhErMydzk2Pzo1mLO
	 KXsakbOlKadHDvCpmoPg4VdpWYop82udMmVVbnJSsa/yNZfnIpnc7zXVJuFxKNqzsX
	 XXtyntURfV0Gyys700YmRUpcZNsNBwSVXZSPdu5SAf1AyhwNb3x1lfgitOWD3HGdQS
	 vWS7Cl3Pan8Rn7XnMFij0eGv/K6IbU4S0Jzeq3EhdCV3hZuhxaFbAcpEYOR+STaAHN
	 NiDWgUxmVXVvm5yitg/azM9C5yVHptICOOnN2qnAup6cV1VLBTsoFalfWOvsoe9Zzc
	 roonF+qboPgYw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 00:17:48 +0100
Subject: [PATCH 28/46] mm/mmu_notifier: set ->mm only after mmgrab()
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
Message-Id: <20261027-fixes_core-v1-28-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
In-Reply-To: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, 
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1928; i=david@kernel.org;
 h=from:subject:message-id; bh=x0mKttz+HwDvoeWV/WYBCh6ori+6WykC26zRhsHss7s=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLu358WvjBTPacmt4dPIdDk5tcpn+01cwTchGfUrDY2m
 /szsutzRykLgxgHg6yYIktQ8H2Dly/X1Va78THDzGFlAhnCwMUpABOZdZHhf0TH64MXTnQzGVbk
 qRb3zPUxmqEu+rl0VcOt4H8i+Tv3tjEyTI9WCD+789mjnlXPFlqk3zA4dezK72lrV9nE/lCeLr9
 WlhcA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Chris Mason <mason@kernel.org>

Radeon uses a non-NULL notifier->mm to decide whether to call
mmu_interval_notifier_remove() when freeing a buffer object.
__mmu_interval_notifier_insert() sets ->mm before validating the range,
so a wrapping userptr range can leave ->mm set after insertion fails.
Cleanup then tries to remove an unregistered notifier for which no mm
reference was acquired.

Set ->mm only after mmgrab(), once insertion can no longer fail. While
we could fix radeon's code instead, setting ->mm on success only makes
the code more robust.

Fix generated by an LLM and sent by Chris Mason in private.

Fixes: 3506ff69c3ec ("drm/radeon: use mmu_interval_notifier_insert")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[ david: simplify description ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/mmu_notifier.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 2e20f88e162d7..a7bae5de5fedc 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -947,7 +947,6 @@ static int __mmu_interval_notifier_insert(
 	struct mmu_notifier_subscriptions *subscriptions, unsigned long start,
 	unsigned long length, const struct mmu_interval_notifier_ops *ops)
 {
-	interval_sub->mm = mm;
 	interval_sub->ops = ops;
 	RB_CLEAR_NODE(&interval_sub->interval_tree.rb);
 	interval_sub->interval_tree.start = start;
@@ -964,8 +963,12 @@ static int __mmu_interval_notifier_insert(
 	if (WARN_ON(atomic_read(&mm->mm_users) <= 0))
 		return -EINVAL;
 
-	/* pairs with mmdrop in mmu_interval_notifier_remove() */
+	/*
+	 * Pairs with mmdrop in mmu_interval_notifier_remove(). Drivers take a
+	 * non-NULL ->mm for "registered", so set it only with the reference.
+	 */
 	mmgrab(mm);
+	interval_sub->mm = mm;
 
 	/*
 	 * If some invalidate_range_start/end region is going on in parallel

-- 
2.43.0

