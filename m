Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.123])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0DD1A6838;
	Thu,  6 Aug 2026 12:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.226.244.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786019517; cv=none; b=IyphusbmbhoBHs/0MMNFhKiniCjgDXvx/wWbXY+BPWjgQCTjkvxECnhdv/o7c+Fi5TDbbuTxgnUmXjsOGSVV4AdnE7naaCGZRXEq9Z02nbzYpcB2t7MqvTA3xPlunPSLba+cZRy7gYns260/3IsCoshwlxNhSFgKPKRaLOmbbKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786019517; c=relaxed/simple;
	bh=/txxxsSEbxIozCVKJtU8hALR/O2SSbwlL8/oNOygjIw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PQ5PpwEbdGWLNdU7nQZyEuLCHypMcQmhQBaeLqMBdTtPZh0raowgH/6zF1JWNdrGeEzGF1B/Hbr/aq/NYCmPFDwJ58tOOJxtabVbxPkMUXuS4o6plBmvXiKmB+RaYBVphS5WxeTMFT+yB6bFaR7pwndwPgAPoiB3NrNZ4aW1QSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=207.226.244.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: 0qp+6OErTomAYQ1cdvuP2g==
X-CSE-MsgGUID: UDbl5xJOSaSwGJUIb8TeLw==
X-IronPort-AV: E=Sophos;i="6.25,208,1779120000"; 
   d="scan'208";a="184784700"
From: sparkhuang <huangshaobo3@xiaomi.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>, Kees Cook <kees@kernel.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R .
 Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, "Mike
 Rapoport" <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, "Michal
 Hocko" <mhocko@suse.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, sparkhuang
	<huangshaobo3@xiaomi.com>, <stable@vger.kernel.org>
Subject: [PATCH] fork: reset pointer tag of vmapped thread stack before vfree
Date: Thu, 6 Aug 2026 20:30:20 +0800
Message-ID: <20260806123020.90869-1-huangshaobo3@xiaomi.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: bj-mbx09.mioffice.cn (10.237.8.129) To BJ-MBX01.mioffice.cn
 (10.237.8.121)

When a thread stack is freed via RCU callback,
thread_stack_free_rcu() calls vfree(vm_area->addr).  In RCU callback
context (e.g. from rcu_nocb_cb_kthread with BH disabled, or from
RCU_SOFTIRQ), in_interrupt() returns true, so vfree() routes to
vfree_atomic().

vfree_atomic() uses the freed memory as llist storage by calling
llist_add((struct llist_node *)addr, &p->list), which writes 8 bytes
to the address being freed.  With KASAN SW_TAGS enabled,
vm_area->addr carries a random tag assigned during allocation by
kasan_unpoison_vmalloc().  If the shadow memory covering this region
has been set to KASAN_TAG_KERNEL (0xFF) — e.g. by
kasan_unpoison_task_stack() using task->stack, which was already
reset to 0xFF by kasan_reset_tag() at allocation time — the shadow
byte (0xFF) no longer matches the pointer tag on vm_area->addr,
and the write in llist_add triggers a KASAN invalid-access report:

  ==================================================================
  BUG: KASAN: invalid-access in vfree_atomic+0x90/0x150
  Write of size 8 at addr c2ffffc0a8f70000 by task rcuop/7/75
  Pointer tag: [c2], memory tag: [ff]

  CPU: 5 UID: 0 PID: 75 Comm: rcuop/7 Tainted: G S      W  OE
  Hardware name: XiaoMi Xring_o1 UDP PHONE (DT)
  Call trace:
   show_stack+0x18/0x28
   __dump_stack+0x28/0x3c
   dump_stack_lvl+0xac/0xf0
   print_address_description+0x7c/0x25c
   print_report+0x70/0x8c
   kasan_report+0xdc/0x13c
   __hwasan_store8_noabort+0xe8/0xf8
   vfree_atomic+0x90/0x150
   vfree+0x220/0x298
   thread_stack_free_rcu+0x3c/0x4c
   rcu_do_batch+0x308/0xaf0
   rcu_nocb_cb_kthread+0x33c/0x708
   kthread+0x364/0x3cc
   ret_from_fork+0x10/0x20

  The buggy address belongs to a 8-page vmalloc region starting at
  0xc2ffffc0a8f70000 allocated at copy_process+0x1ac/0x12e4

  Memory state around the buggy address:
   ffffffc0a8f6ff00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
  >ffffffc0a8f70000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                      ^
   ffffffc0a8f70100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ==================================================================

The tag on tsk->stack was already reset to KASAN_TAG_KERNEL (0xFF) by
commit c08e6a1206e6 ("kasan, fork: reset pointer tags of vmapped
stacks"), but vm_area->addr still carries the original random tag.
This is the same class of bug that was fixed for shadow call stacks
in scs_free() by commit 528a4ab45300 ("scs: Release kasan vmalloc
poison in scs_free process").

Fix it by resetting the pointer tag before calling vfree(), so that
vfree_atomic()'s llist_add write uses KASAN_TAG_KERNEL (0xFF), which
makes KASAN bypass tag checks for that write in all modes (SW_TAGS,
HW_TAGS, and Generic).

kasan_unpoison_vmalloc() is not needed alongside kasan_reset_tag():
in HW_TAGS, __kasan_unpoison_vmalloc() is a no-op without
KASAN_VMALLOC_VM_ALLOC (only KASAN_VMALLOC_PROT_NORMAL is passed);
in SW_TAGS and Generic, the 0xFF-tagged pointer already bypasses
shadow checks, so the shadow state is irrelevant.

Fixes: 0f110a9b956c ("kernel/fork: use vfree_atomic() to free thread stack")
Cc: stable@vger.kernel.org
Signed-off-by: sparkhuang <huangshaobo3@xiaomi.com>
---
 kernel/fork.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index f0e2e131a..2fd6fd25c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -280,7 +280,19 @@ static void thread_stack_free_rcu(struct rcu_head *rh)
 	if (try_release_thread_stack_to_cache(vm_stack->stack_vm_area))
 		return;
 
-	vfree(vm_area->addr);
+	/*
+	 * Reset the pointer tag before vfree(): in RCU callback context
+	 * vfree() routes to vfree_atomic(), which writes to the freed
+	 * memory as llist storage.  Resetting the tag to KASAN_TAG_KERNEL
+	 * (0xFF) makes KASAN bypass tag checks for that write in all modes
+	 * (HW_TAGS, SW_TAGS, Generic), avoiding a false tag-mismatch report.
+	 *
+	 * kasan_unpoison_vmalloc() is not needed here: in HW_TAGS it is a
+	 * no-op without KASAN_VMALLOC_VM_ALLOC, and in SW_TAGS/Generic the
+	 * 0xFF pointer already bypasses shadow checks.  This mirrors the
+	 * intent of the fix in scs_free() (commit 528a4ab45300).
+	 */
+	vfree(kasan_reset_tag(vm_area->addr));
 }
 
 static void thread_stack_delayed_free(struct task_struct *tsk)
-- 
2.34.1

