Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420863;
	b=ZxitOrggm4lxnPAICl1m0azgm5ZFnFFk7r/o2PYLk2UPe8cqgutdUXIJ38JB4LUyHAYO
	 Q6ncQIHYQrQ5fWRX7qNPRzXTjBgTicidysuVCRS9opsCutgTRwfPrkDfoYry9JxMzOAj3
	 +gay6324SSuEUIFuv6yxh1mKNXCTMygD6WvB/cIJziXPFE+caY1BEIEyIhCEUKe5BRDBy
	 NlJSc2QgPuiNiZMEGmIDF3kcYhv8z65TTBiPhS4GAgLrCD5/y4KW0c8ULkJeBdxNm4ppw
	 vnipEI6ToOsSUdTLuY1TYkNs4zwrHb47hddWp7KkzEylM+n8GuNS+rRMMfvYInmJUPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420863;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=srFqpP6ZDnZa1ayDvcvXf1T4HKZiEcS8ufIpxBUhNHg=;
	b=G6THet1KKH87+y/GCzlXVIsqSKf/j1t1sCWpcBCMq4hAIlNhSAA6yV5hOuVdbtoP5q0S
	 zacVR5R9WiV764uoFq7WMNSMDWd8co93ZOZhs0HH9rcb5rLGf84EOl7xOkZ/41PI53yNM
	 78f8UUza+eOINmxavJEEd/OGnbGgnwryFxHSayiZxbw0qhjN8SJZ2aLAecVG9goOaTRhh
	 6+bPeWTBjVeyzplyogbUGbuYRRtshE+Yi7ZVsVKXoldKKhyh5vnbfKkvgYieJU8KSUkoz
	 0cer0nayUP3PtXxtEGNdgEvpYUOZ6VSp5gea5DKp3b6vIG4EQDsFVSYlSYol9uQZ04g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ip+MeyH0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997D4606A89A;
	Wed, 11 Nov 2026 18:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ip+MeyH0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869881F00A06;
	Wed, 11 Nov 2026 18:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794420863;
	bh=srFqpP6ZDnZa1ayDvcvXf1T4HKZiEcS8ufIpxBUhNHg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Ip+MeyH0mnXVSjSEn12CmZeAEvgFsGWlr2WxmKNYL4sDxR1G3qt6hIEeCNLwGRFSp
	 hRz3BFLnK1H3vdJVAQ+gzq1wyNwNKgnhHaIcFgsYPryXM7b3smmdxggP5pI+D7b5nk
	 WzSd/KZbK58N22J/u4fo9F/KGqgsa6bwTbAR6aSXLzmUl4RlWxpsCtsXTKKsB58gzr
	 HDhTg4lpizdWNz3Q2pqvL1tOvYOgZwIMv0JLX+IIB+76j2VkMilI+DCxCJY7fztCkY
	 lH1zl8oVWWKAAjqvSwMw1ntCa2zfNJ9rCfQIB2m3ydcDzywt951PY2hpzcZOXtAiUm
	 1o903NslRCmfQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Wed, 11 Nov 2026 18:13:15 +0000
Subject: [PATCH 01/13] mm/mmap: free gathered pages before MMF_OOM_SKIP
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
Message-Id: <20261111-mason-migrate-et-al-fixes-v1-1-3d2454362e8d@kernel.org>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3855; i=ljs@kernel.org;
 h=from:subject:message-id; bh=ogD4hL7hm3MRJZQvw+1xlLAOQuORFeu7Ul+kQhgYJJ0=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK+bMjquVNbGPnR7VVQQfTClY2bbHxy97cnzl+ofuT2p
 4n1djG7OkpZGMS4GGTFFFmefxHfHyQSNq/zgr8bzBxWJpAhDFycAjARpU6G/9We2ln6sZLPOtNn
 9MyQ3OUqbf6TZ4n09+4XuTM3tE3rOMTI0POkclbizHgPx6lNj9mv2cX1nZP00XfPEmTfv8dM738
 gGwA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

The OOM killer can quickly trigger again after having selected a
victim. That victim might not have freed its memory yet, but its mm will
be marked MMF_OOM_SKIP by this point, so the OOM killer will ignore it.

This can cause the OOM killer to kill an innocent process when the first
might have freed enough memory to relieve the memory pressure.

Fix the issue by freeing the memory before marking the mm MMF_OOM_SKIP.

Note that the task which calls mmput() might not be the victim - if it
took a reference on the mm (e.g. ptrace), it may hold the last reference
and release it when it calls mmput().

Therefore we cannot rely on current to tell whether the mm belongs to an
OOM victim. Instead, partially revert commit b3541d912a84 ("mm: delete
unused MMF_OOM_VICTIM flag") to reinstate MMF_OOM_VICTIM, which
mark_oom_victim() sets on the victim's mm, and check that.

Reported-by: Chris Mason <mason@kernel.org>
Fixes: bf3980c85212 ("mm: drop oom code from exit_mmap")
Cc: <stable@vger.kernel.org>
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

