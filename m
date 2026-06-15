Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80922652AF;
	Mon, 15 Jun 2026 17:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781545770; cv=none; b=E9wFDIWdqguBp+FXcdtw6ZH3cIydLTVtNhLmAn0X0HG4697aYfpxK2+Dht00DBlekQUaehT7+1G4+Xc18KsdwVXTVSKux96sHyMHQpr1ZIm10IQcvRhPeg00CecYgWAzntz+aA79PGJTYqL3XHUY5EZhMizksGoIS0XzR4jPXA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781545770; c=relaxed/simple;
	bh=1rDnZh/h+MevWjImIeFxOVaRYkGkoiFTKCcwtkVbAdI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tUUCBJQhaFi78kdijvuO+H0KfVuHn4NVrgUWwVjUBo9rNvt547+w7+aW7M6MfI5h2Rc+d0OrzIWuSp2cl9sXRDGfmo07Ak7Uj5a/eoIrO3loTQCbNcJhgxwfzCD6VejdzdYCp81NU/C7ZMm8vJn0e7TncYl2ouV9USf3u6b4LV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=rE5pRpRU; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="rE5pRpRU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=dP6yI4gkMnZqD3xHZkcFYYf/yAEB+xge/DtRHnnHP30=; b=rE5pRpRU/ZsyizHiWz60GXl2LO
	fRlUZWbey5qjEs/16OMhFoRQufuXc4fb2cyxDdqkwYkHa9WvVFoC/VkLrsNuB6B2Yv5SATLr1ZAvC
	RD8R21bbB0gMmyvczDsHVYYoZhXABf5VxTq1c+wXBrgOWiKQZWQ92KbiOZEdPrXt3cFA75/SMakbv
	QFAIyg/cJMpHAzT0iZAynI4UvYFdYp6DhxV9AUWohp3wxEFg2Wfs/vg4ig1UC+M2f3F/ANikrZqtd
	78tYb8PUEPT6SZTJbTShsJhBuO9Vg3syF1q32vxZDkyjXO0jqLr06OeuuE8Wr3rWp3cArCY4gavMl
	LAv5c/og==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wZBR8-00DFK6-1z;
	Mon, 15 Jun 2026 17:49:26 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 15 Jun 2026 10:49:06 -0700
Subject: [PATCH v3 1/3] mm/kmemleak: avoid soft lockup when scanning task
 stacks
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-kmemleak-stack-resched-v3-1-acecd7d7fd92@debian.org>
References: <20260615-kmemleak-stack-resched-v3-0-acecd7d7fd92@debian.org>
In-Reply-To: <20260615-kmemleak-stack-resched-v3-0-acecd7d7fd92@debian.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, lance.yang@linux.dev, 
 Davidlohr Bueso <dave@stgolabs.net>, Oleg Nesterov <oleg@redhat.com>, 
 Qian Cai <cai@lca.pw>
Cc: oleg@redhat.com, sj@kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3005; i=leitao@debian.org;
 h=from:subject:message-id; bh=1rDnZh/h+MevWjImIeFxOVaRYkGkoiFTKCcwtkVbAdI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqMDsebnPbJ90uobD2PmSKxyzA0cwYhR7lk6ZGu
 G3cBzC9q96JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCajA7HgAKCRA1o5Of/Hh3
 bdNND/9l2WMi7/X+EIJgFyM71/LXAwgjvQABD/J0KX0fUPThz5pEfiNhwFS0CX31UZnbufrvV9b
 LTvxNkjncyQVjVzT+gHNUz8e5yRRZ/SQCqKVNQCIi7L7p/Mk9qBPujJPpAL8JnmlPnKEB9cEL9b
 N1zWIpho5HNC1tnKJ09xcoLY0kfsC/YWtgQRC2o6eFSl/SkqBXvM4ml2h9dFXawR8FHjqjYJE8D
 95S27K4qHCQyPicKOC3/4lzKwfX73QdRGcfne3f+jWaYy81XlL0n+ziJxTsx5cDPtkbef5/XqLT
 LUGZQ9P2SM8Tz2HyUW5uFmeKFZ6oNpfThxxreR2mRnpJS5zi6pPNU+K5+q2Vy2sMjF6oPXYDrnn
 MFTrVRDHinI3wcACayiTMCClfVV/fxK8Qu1Rlr2lzoyR071hMafSfHBhhzg62ArrteCLua5MHAs
 3UZ9h9QS03mmKik6zMel+GZX2V+ZimRvJeUHbc8Qv2vb6FDylL1DPTYOroLtYLL0I5ggJ2RqFVv
 mvydNUcBs5K7E5P5hfzUL2brnMIUBiVVsp0T+9zZ+iQBEHv18nBu+fh7nRx5mWTC4L9FkrbNgLz
 ItetEFxnWr2JiY+mWefH+ctz96xU7Q5kR1jA9kL3ZGt/+2BMCTQKaGVoCaKRDAqtebfLtAZIqbQ
 1YigND8OOqxNxHg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

kmemleak_scan() walks every thread and scans its kernel stack under a
single rcu_read_lock() with no reschedule point. On a host with very
many threads -- amplified by KASAN/lockdep in debug builds -- this loop
can hog a CPU long enough to trip the soft lockup watchdog:

  watchdog: BUG: soft lockup - CPU#35 stuck for 22s! [kmemleak:537]
   scan_block
   kmemleak_scan
   kmemleak_scan_thread
   kthread

A cond_resched() cannot be added directly: the loop runs inside an RCU
read-side critical section.

Walk the tasks one PID at a time with find_ge_pid(), taking the RCU read
lock only to look up and pin each task. The stack is then scanned with no
lock held, so cond_resched() runs between tasks and the scan stops early
on scan_should_stop(). This follows the next_tgid()/task_seq_get_next()
iteration pattern and keeps each RCU critical section short.

Fixes: c4b28963fd79 ("mm/kmemleak: rely on rcu for task stack scanning")
Cc: stable@vger.kernel.org
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 mm/kmemleak.c | 51 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 7c7ba17ce7af0..a7786b6bc174e 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1695,6 +1695,42 @@ static void kmemleak_cond_resched(struct kmemleak_object *object)
 	put_object(object);
 }
 
+/*
+ * Scan all task kernel stacks, rescheduling between tasks. Each task is looked
+ * up and pinned within its own RCU read-side section, so no lock is held across
+ * the scan and the walk cannot trip the soft lockup watchdog.
+ */
+static void kmemleak_scan_task_stacks(void)
+{
+	struct pid *pid;
+	int nr = 1;
+
+	do {
+		struct task_struct *p = NULL;
+
+		rcu_read_lock();
+		pid = find_ge_pid(nr, &init_pid_ns);
+		if (pid) {
+			nr = pid_nr(pid) + 1;
+			p = pid_task(pid, PIDTYPE_PID);
+			if (p)
+				get_task_struct(p);
+		}
+		rcu_read_unlock();
+
+		if (p) {
+			void *stack = try_get_task_stack(p);
+
+			if (stack) {
+				scan_block(stack, stack + THREAD_SIZE, NULL);
+				put_task_stack(p);
+			}
+			put_task_struct(p);
+		}
+		cond_resched();
+	} while (pid && !scan_should_stop());
+}
+
 /*
  * Print one leak inline. The hex dump is gated on OBJECT_ALLOCATED so it
  * does not touch user memory that was freed concurrently; the rest of the
@@ -1884,19 +1920,8 @@ static void kmemleak_scan(void)
 	/*
 	 * Scanning the task stacks (may introduce false negatives).
 	 */
-	if (kmemleak_stack_scan) {
-		struct task_struct *p, *g;
-
-		rcu_read_lock();
-		for_each_process_thread(g, p) {
-			void *stack = try_get_task_stack(p);
-			if (stack) {
-				scan_block(stack, stack + THREAD_SIZE, NULL);
-				put_task_stack(p);
-			}
-		}
-		rcu_read_unlock();
-	}
+	if (kmemleak_stack_scan)
+		kmemleak_scan_task_stacks();
 
 	/*
 	 * Scan the objects already referenced from the sections scanned

-- 
2.53.0-Meta

