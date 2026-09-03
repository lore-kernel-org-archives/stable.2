Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31514F55D1
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 17:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788457755; cv=none; b=jMotaeCZZMQ+t6vrh12omEPg1vvhhuBnMRBvUDR2nAchB3wnJn69Y1Y/enhsgKfc5L/wryLxpZnO+Kwop+Y49MOBxtypyQqenOWb4GU+4d1B6Gr5teWzg8MfBjtoUEAWQCW9npI/VBFm7f5n6D7JcTYMfkceigI+IopM86vxh78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788457755; c=relaxed/simple;
	bh=kfBoMBK+znh/ZONgx+wRUvYoTdZo9ludfC8gLBVotXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XWXAhArIcPsWhEoQn9wajZno//G5/AaR/HeIu7LERpyx2B+WvlyyQsg2HWJStO14I8ouYwMCcWm9te1wA0rLBAehJt8ZnpKHy+ZlwkM8yXL99q6GxzoUVQo4E8hnk9Aayti6eobbQ/+19lzz5I/CSr/VhmWnSSSEr9WXlYwGKpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJTCnIeq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJTCnIeq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7919C1F00A3D;
	Thu,  3 Sep 2026 17:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788457753;
	bh=YoGE/GZnm0huTJALyUQRn8iOJtkBLr0I6Vcvq/v7jYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dJTCnIeqrcRajZN/RbRKIroYxF+FtxDon+XwPQlregZ8t+uKBblwjeuttzsCqz5gB
	 oi2eZ5epi9gc+nal8v5yARVcOXZryX41fwYPyfGa+oTTPdlqumOmf/zaxnSIiYm9Hn
	 mPXlZBqN6f2q1FZvNF+o3sGB0GfXLaKlVpKqaZ/QVPRUCrDQC5IASQv25WDpiHXYM9
	 pyG1fU8LsQyIw1HSR9OciJZMXmcK/Rl61/5F+AwhMQtt5mUYpX1tu4SYxDailn3M7U
	 2bv2Hy0cM1tC/2NYAxyXnzfUN6DjNkxlA5Vxtz9AZsG8S7fMSjViBOhzMvL7L28lcJ
	 aRM509MN9SwvQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Lance Yang <lance.yang@linux.dev>,
	Qian Cai <cai@lca.pw>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/3] mm/kmemleak: stop the task stack scan early when interrupted
Date: Thu,  3 Sep 2026 13:49:07 -0400
Message-ID: <20260903174908.1268466-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903174908.1268466-1-sashal@kernel.org>
References: <2026090344-tightly-handiwork-36ab@gregkh>
 <20260903174908.1268466-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

[ Upstream commit eb11f56eeca56069613d00bf623607e305b271d9 ]

scan_block() already checks scan_should_stop() for every pointer and bails
out of the current block, but the task stack walk cannot tell and keeps
issuing a separate scan_should_stop() between every task.

Return that status from scan_block() and use it as the task stack loop
condition, so the walk stops as soon as a scan is interrupted.

Link: https://lore.kernel.org/20260615-kmemleak-stack-resched-v3-2-acecd7d7fd92@debian.org
Signed-off-by: Breno Leitao <leitao@debian.org>
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Qian Cai <cai@lca.pw>
Cc: SeongJae Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 3541a2b06ecd ("mm/kmemleak: report RCU-tasks quiescent states during the scan")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/kmemleak.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 16b72cead07d2..bc79e293531b7 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1525,22 +1525,25 @@ static int scan_should_stop(void)
 
 /*
  * Scan a memory block (exclusive range) for valid pointers and add those
- * found to the gray list.
+ * found to the gray list. Return non-zero if the scan was interrupted.
  */
-static void scan_block(void *_start, void *_end,
-		       struct kmemleak_object *scanned)
+static int scan_block(void *_start, void *_end,
+		      struct kmemleak_object *scanned)
 {
 	unsigned long *ptr;
 	unsigned long *start = PTR_ALIGN(_start, BYTES_PER_POINTER);
 	unsigned long *end = _end - (BYTES_PER_POINTER - 1);
 	unsigned long flags;
+	int stop = 0;
 
 	raw_spin_lock_irqsave(&kmemleak_lock, flags);
 	for (ptr = start; ptr < end; ptr++) {
 		unsigned long pointer;
 
-		if (scan_should_stop())
+		if (scan_should_stop()) {
+			stop = 1;
 			break;
+		}
 
 		kasan_disable_current();
 		pointer = *(unsigned long *)kasan_reset_tag((void *)ptr);
@@ -1550,6 +1553,8 @@ static void scan_block(void *_start, void *_end,
 		pointer_update_refs(scanned, pointer, OBJECT_PERCPU);
 	}
 	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
+
+	return stop;
 }
 
 /*
@@ -1705,6 +1710,7 @@ static void kmemleak_scan_task_stacks(void)
 {
 	struct pid *pid;
 	int nr = 1;
+	int stop = 0;
 
 	do {
 		struct task_struct *p = NULL;
@@ -1723,13 +1729,13 @@ static void kmemleak_scan_task_stacks(void)
 			void *stack = try_get_task_stack(p);
 
 			if (stack) {
-				scan_block(stack, stack + THREAD_SIZE, NULL);
+				stop = scan_block(stack, stack + THREAD_SIZE, NULL);
 				put_task_stack(p);
 			}
 			put_task_struct(p);
 		}
 		cond_resched();
-	} while (pid && !scan_should_stop());
+	} while (pid && !stop);
 }
 
 /*
-- 
2.53.0

