Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296863B0AE7;
	Mon, 14 Sep 2026 09:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.143.206.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789378421; cv=none; b=RstC3j7mW3aBSZwLvVjCmYyfTYbfhFwQaqMqT9TRdoFbI/ogl1pCBzY4X4zFX2RBcXQBTL+W7nZFw/9m3OsPP3LD2hpVG4I4pw9gVt7IGJyiQymknn0mHfLmMrAZSgTzhUSs5FZdfy4BHnazQeO2B/+ERfOP7f3mVzPmwx+yDqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789378421; c=relaxed/simple;
	bh=V6y4KvqT3Ldy96jqHaUVM4MB2X0oTPPwyW7Us0budKE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uBfvWI3UgQw+2HDFriXeXUScnh3MzaX+H4gwkUfT+lffnFdzr+MeWppwN99gWw8hUObYoRiyit0WVqFw7S5+FbXonSvF55YBLG0K/Q0QzIrtE7hR4cgsuDDia3K2JhD2iEGfrL6jFayP+iXdnVIsiAi6qL41/xCiE4yC6q8+ar4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=118.143.206.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: Qc3q4jFGQ7y2DW8PmcmMNg==
X-CSE-MsgGUID: rwwjmufCQzm4aMbGEXdxvw==
X-IronPort-AV: E=Sophos;i="6.27,102,1786982400"; 
   d="scan'208";a="162550230"
From: Shaobo Huang <huangshaobo3@xiaomi.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <akpm@linux-foundation.org>,
	<david@kernel.org>, <kees@kernel.org>
CC: <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <kprateek.nayak@amd.com>,
	<ljs@kernel.org>, <liam@infradead.org>, <vbabka@kernel.org>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>,
	<ryabinin.a.a@gmail.com>, <glider@google.com>, <andreyknvl@gmail.com>,
	<dvyukov@google.com>, <vincenzo.frascino@arm.com>,
	<kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Shaobo Huang
	<huangshaobo3@xiaomi.com>
Subject: [PATCH v2] fork: reset pointer tag of vmapped thread stack before vfree
Date: Mon, 14 Sep 2026 17:33:00 +0800
Message-ID: <20260914093300.100495-1-huangshaobo3@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260806123020.90869-1-huangshaobo3@xiaomi.com>
References: <20260806123020.90869-1-huangshaobo3@xiaomi.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJ-MBX17.mioffice.cn (10.237.8.137) To BJ-MBX01.mioffice.cn
 (10.237.8.121)

thread_stack_free_rcu() frees the vmalloc'd thread stack via
vfree(vm_area->addr).  In RCU callback context, vfree() routes to
vfree_atomic(), which calls llist_add((struct llist_node *)addr, ...)
and writes 8 bytes to the base of the region being freed.

With KASAN_SW_TAGS, vm_area->addr carries a random tag.  If
kasan_unpoison_task_stack_below() has rewritten the shadow covering
[base, sp] to KASAN_TAG_KERNEL (0xff) -- which it does on every CPU
resume for the current task's stack -- the llist_add store checks
shadow[base] (0xff) against the pointer tag (random) and reports an
invalid-access, although writing to the base of a stack queued for
deferred free is legitimate.

Reset the pointer tag to KASAN_TAG_KERNEL before vfree() so that
kasan_check_range() short-circuits the check, the same way the task
accesses its own stack at runtime via sp.  The vmalloc lookup is safe:
__find_vmap_area() resets the tag before comparing against va_start.

Fixes: 9f7d416c3612 ("kprobes: Unpoison stack in jprobe_return() for KASAN")
Cc: stable@vger.kernel.org
Assisted-by: zhipuai:glm-5.2
Signed-off-by: Shaobo Huang <huangshaobo3@xiaomi.com>
---
Changes since v1:
- Drop the 12-line comment; keep just the one-line fix.
- Fix the Fixes: tag to point to the commit that introduced
  kasan_unpoison_task_stack_below (9f7d416c3612), which added
  both the function definition and the _cpu_resume call site, not
  the 2016 vfree_atomic commit.
- Add Assisted-by tag per Documentation/process/coding-assistants.rst.
- Use real name (Shaobo Huang) instead of "sparkhuang".
- Trim the commit message; remove the full KASAN dump.
v1:
  https://lore.kernel.org/all/20260806123020.90869-1-huangshaobo3@xiaomi.com/
---
 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 45300f59cf2c..9a66b10749de 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -238,7 +238,7 @@ static void thread_stack_free_rcu(struct rcu_head *rh)
 	if (try_release_thread_stack_to_cache(vm_stack->stack_vm_area))
 		return;
 
-	vfree(vm_area->addr);
+	vfree(kasan_reset_tag(vm_area->addr));
 }
 
 static void thread_stack_delayed_free(struct task_struct *tsk)
-- 
2.34.1

