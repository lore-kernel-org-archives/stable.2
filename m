Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606350;
	b=EeBM0psj5CjcigiSnhmHeetKCL3NgHMEdROsKw2V7ErfrxTA3evEZiwA7Kgnukm/fA6P
	 9xsJ6LsG3ZoOHVC+8XdSRfgnHJMAjmfey1MqSUWljc0ljto0n3y161tCIzyqCF8RThbBS
	 +OHPEKhMGDNINk8gjqQ37mCvQSZ4RbORQXaHCRtqe4VljmRcZnPLXKFsI0hN5dIng71OS
	 2BTT2kOhPhX4v4RMh61cpe4y1Q5KTEJN7AXVc8IiNI4HIQ+Ivoq3Y7I4C5FsohgaE1ek1
	 F/3X4GzZLucZkKBUu9wjalhMiKL9UgqkexGfDBn0oDW1kiRfSesPiRxL/7o+9rCZpxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606350;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=tgUeD2OkgMqdlzQH1t0tTDMBPVlxaf4oY8m5ckbOO0M=;
	b=ptYZdFflG/JCY7JK99MEVPqE0RFsdHTGxhOpBAtQF+BGg9A7aQfWINbb3Kp10lUuCmys
	 Gg/hID8gZ2UMQ9kNsHeuFCCt3o8vDFGnqL0qlRPG1H6MoJTz1m9/kqGfd6FqhV6iDw7r/
	 KPszHNQFNd79r6P4gGnqTLDDC2GYrKXucx00HK11cFzFj+sdvvext+SqyUGBjHOTCZ9cj
	 Q+UVMe0z5tqaD6qwxeMpqY8jCSqIHL9viB7fs0ZaCGQIegD3tRayHCAe3wPIV04xV+t7L
	 Xu/xo6BHd70GMqvzeiwB9IPXVY5NVmcID3g5CXEbXCTAbM3gFZUqYUL7LO9f5KR0J4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WXIUP+Mb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F2F606A33F;
	Fri, 13 Nov 2026 21:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WXIUP+Mb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06DBB1F000C5;
	Fri, 13 Nov 2026 21:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794606350;
	bh=tgUeD2OkgMqdlzQH1t0tTDMBPVlxaf4oY8m5ckbOO0M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WXIUP+MbGYgY8WkluriT5V941F9mGcyzgyz4ZwegCQUOATBrCUVKn2eSGzyNlPh+S
	 6l/QDGlRcmALMqE2FjI3YH5S7NZLg2rncLUT2UKbzy+IizCywVssa7GBYEfTlSTYHO
	 sFdcXu/6zmXnVBxVqFIjx9bTzzwYZoZWWHx8+6yBzz1QxjlLa0u1b3EMEZ8o6Vk/jk
	 Gmg6VsktRQ6wUiaIyHTAdMixA6D4uy1cn6DXkJbf14ovFcfkaxpKcETrvTk/t9Bvlt
	 6TKBkda2q+wPFkRKbvcUkvt8nbA6UZ8ESZ8ZifoYJz3mzNf1jPtjfuDDKvp1y0mL2g
	 ch4XvYd92FBCQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Fri, 13 Nov 2026 21:45:19 +0000
Subject: [PATCH v2 01/13] mm/mmap: free gathered pages before MMF_OOM_SKIP
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
Message-Id: <20261113-mason-migrate-et-al-fixes-v2-1-50a2ed382b61@kernel.org>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
In-Reply-To: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
To: David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
 Kairui Song <kasong@tencent.com>, Balbir Singh <balbirs@nvidia.com>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_Glisse?= <jglisse@redhat.com>, 
 Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
 Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
 Chris Mason <mason@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>, 
 Mark Brown <broonie@kernel.org>, 
 "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4364; i=ljs@kernel.org;
 h=from:subject:message-id; bh=8x8meuO1qhGN77hxGuh4qyBOF3+aPhUYnTt1ixD9eZU=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK+t/zYcinW7iafSlX5pR+xumxp+75t+hv23bjTxTD/d
 XzO4dlNHaUsDGJcDLJiiizPv4jvDxIJm9d5wd8NZg4rE8gQBi5OAZgIRwYjww8OmfkMycor3xZZ
 2rCLHdwlWZE8a2XL0iafMuvLV3a94mRk2NiUummq+goDKdsPVf/vzTdicZt8MbhpzZeX0dyVqaG
 Z3AA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

The OOM killer can quickly trigger again after having selected a
victim. That victim might not have freed its memory yet, but its mm will
be marked MMF_OOM_SKIP by this point, so the OOM killer will ignore it.

This can cause the OOM killer to kill an innocent process when the first
might have freed enough memory to relieve the memory pressure.

exit_mmap() marks the mm MMF_OOM_SKIP once unmap_vmas() returns.
However unmap_vmas() does not free the last batch of pages it
gathered. That is left to tlb_finish_mmu(), which runs after
MMF_OOM_SKIP is set, and the batch can be large.

Fix the issue by freeing the gathered pages of an OOM victim before
marking the mm MMF_OOM_SKIP.

Note that the task which calls mmput() might not be the victim - if it
took a reference on the mm (e.g. ptrace), it may hold the last reference
and release it when it calls mmput().

Therefore we cannot rely on current to tell whether the mm belongs to an
OOM victim. Instead, partially revert commit b3541d912a84 ("mm: delete
unused MMF_OOM_VICTIM flag") to reinstate MMF_OOM_VICTIM, which
mark_oom_victim() sets on the victim's mm, and check that.

Reported-by: Chris Mason <mason@kernel.org>
Fixes: bf3980c85212 ("mm: drop oom code from exit_mmap")
Cc: stable@vger.kernel.org
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Acked-by: Usama Arif <usama.arif@linux.dev>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 include/linux/mm_types.h | 2 ++
 include/linux/oom.h      | 9 +++++++++
 mm/mmap.c                | 9 ++++++++-
 mm/oom_kill.c            | 4 +++-
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 1ed35d258d2e..09e63ff12b04 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -2030,6 +2030,8 @@ enum {
 #define MMF_TOPDOWN		31	/* mm searches top down by default */
 #define MMF_TOPDOWN_MASK	BIT(MMF_TOPDOWN)
 
+#define MMF_OOM_VICTIM		32	/* mm is the oom victim */
+
 #define MMF_INIT_LEGACY_MASK	(MMF_DUMP_FILTER_MASK |\
 				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK |\
 				 MMF_VM_MERGE_ANY_MASK | MMF_TOPDOWN_MASK)
diff --git a/include/linux/oom.h b/include/linux/oom.h
index 00da05d227e6..a9390cb70541 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -76,6 +76,15 @@ static inline bool tsk_is_oom_victim(struct task_struct * tsk)
 	return tsk->signal->oom_mm;
 }
 
+/*
+ * Use this helper if tsk->mm != mm and the victim mm needs a special
+ * handling. This is guaranteed to stay true after once set.
+ */
+static inline bool mm_is_oom_victim(struct mm_struct *mm)
+{
+	return mm_flags_test(MMF_OOM_VICTIM, mm);
+}
+
 /*
  * Checks whether a page fault on the given mm is still reliable.
  * This is no longer true if the oom reaper started to reap the
diff --git a/mm/mmap.c b/mm/mmap.c
index 7618e72766a5..4cb18b217048 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1313,11 +1313,18 @@ void exit_mmap(struct mm_struct *mm)
 	/* update_hiwater_rss(mm) here? but nobody should be looking */
 	/* Use ULONG_MAX here to ensure all VMAs in the mm are unmapped */
 	unmap_vmas(&tlb, &unmap);
+
+	/*
+	 * Free the memory before marking MMF_OOM_SKIP so a re-triggered OOM
+	 * killer will only skip this mm if it's already freed all it can.
+	 */
+	if (mm_is_oom_victim(mm))
+		tlb_flush_mmu(&tlb);
 	mmap_read_unlock(mm);
 
 	/*
 	 * Set MMF_OOM_SKIP to hide this task from the oom killer/reaper
-	 * because the memory has been already freed.
+	 * because the memory has been already unmapped.
 	 */
 	mm_flags_set(MMF_OOM_SKIP, mm);
 	mmap_write_lock(mm);
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 5d48bd862c27..9de57a23893c 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -752,8 +752,10 @@ static void mark_oom_victim(struct task_struct *tsk)
 		return;
 
 	/* oom_mm is bound to the signal struct life time. */
-	if (!cmpxchg(&tsk->signal->oom_mm, NULL, mm))
+	if (!cmpxchg(&tsk->signal->oom_mm, NULL, mm)) {
 		mmgrab(tsk->signal->oom_mm);
+		mm_flags_set(MMF_OOM_VICTIM, mm);
+	}
 
 	/*
 	 * Make sure that the process is woken up from uninterruptible sleep

-- 
2.56.0

