Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275DE37C91C
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 02:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781577150; cv=none; b=XnNK+TKGRxlV4GvVk+TwArhRrY5XtctH8Fgby4IMAMZXHtaebBiwrRxMzVrhmW/6Rnspe50kkcMPjTKBXo6xXd6ok30vPlBzKuEHw/RTuyJua59prvAILK2TiPcjykAtfB08bb/IyIdbwhdWyTpiHLBYNn56Avw+TJTe8FnLEYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781577150; c=relaxed/simple;
	bh=Sopc87+5q7eR7VJtTx+KVoE2M/UJom9Vu1PK0A1rLVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qNu226HVKIu76x8U3J/i+xxM6EDQberTztAIX7x2IJkewkpiuXPB2hVEuHKpaQEw1zYtj6bb0vluOjjRgoHTWe24pJ83z0SEylLhZlpp1P1u0Dho2YvBPexNb0sm2gvB9p9qBYbtH82oa60U+FWp7YaHLs2htq4wlz7PETDXDAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZRQmG+zF; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZRQmG+zF"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781577137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/oQp60CeS2OqPkQlb+GAaqqk2o9SM+Ljd8d+w6AQvZ0=;
	b=ZRQmG+zFarn/PCSzk9dhXskN9MMAgbLgLtc8e1+KicSk+DS/IClkIrjnBGq49lziVpg4if
	S50fUr+Q5BZ9Fzq5RvEtmUyjchStVLuDGSUhJzQJnKyvdiPiPzT+3iGLHrgHLrIq8quWTq
	/nCsbHdjZaTRpCbi60EfU7rvFudjzk4=
From: Lance Yang <lance.yang@linux.dev>
To: leitao@debian.org
Cc: catalin.marinas@arm.com,
	akpm@linux-foundation.org,
	lance.yang@linux.dev,
	dave@stgolabs.net,
	oleg@redhat.com,
	cai@lca.pw,
	sj@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/3] mm/kmemleak: avoid soft lockup when scanning task stacks
Date: Tue, 16 Jun 2026 10:31:53 +0800
Message-Id: <20260616023153.20399-1-lance.yang@linux.dev>
In-Reply-To: <20260615-kmemleak-stack-resched-v3-1-acecd7d7fd92@debian.org>
References: <20260615-kmemleak-stack-resched-v3-1-acecd7d7fd92@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Mon, Jun 15, 2026 at 10:49:06AM -0700, Breno Leitao wrote:
>kmemleak_scan() walks every thread and scans its kernel stack under a
>single rcu_read_lock() with no reschedule point. On a host with very
>many threads -- amplified by KASAN/lockdep in debug builds -- this loop
>can hog a CPU long enough to trip the soft lockup watchdog:
>
>  watchdog: BUG: soft lockup - CPU#35 stuck for 22s! [kmemleak:537]
>   scan_block
>   kmemleak_scan
>   kmemleak_scan_thread
>   kthread
>
>A cond_resched() cannot be added directly: the loop runs inside an RCU
>read-side critical section.
>
>Walk the tasks one PID at a time with find_ge_pid(), taking the RCU read
>lock only to look up and pin each task. The stack is then scanned with no
>lock held, so cond_resched() runs between tasks and the scan stops early
>on scan_should_stop(). This follows the next_tgid()/task_seq_get_next()
>iteration pattern and keeps each RCU critical section short.
>
>Fixes: c4b28963fd79 ("mm/kmemleak: rely on rcu for task stack scanning")
>Cc: stable@vger.kernel.org
>Signed-off-by: Breno Leitao <leitao@debian.org>
>---
> mm/kmemleak.c | 51 ++++++++++++++++++++++++++++++++++++++-------------
> 1 file changed, 38 insertions(+), 13 deletions(-)
>
>diff --git a/mm/kmemleak.c b/mm/kmemleak.c
>index 7c7ba17ce7af0..a7786b6bc174e 100644
>--- a/mm/kmemleak.c
>+++ b/mm/kmemleak.c
>@@ -1695,6 +1695,42 @@ static void kmemleak_cond_resched(struct kmemleak_object *object)
> 	put_object(object);
> }
> 
>+/*
>+ * Scan all task kernel stacks, rescheduling between tasks. Each task is looked
>+ * up and pinned within its own RCU read-side section, so no lock is held across
>+ * the scan and the walk cannot trip the soft lockup watchdog.
>+ */
>+static void kmemleak_scan_task_stacks(void)
>+{
>+	struct pid *pid;
>+	int nr = 1;
>+
>+	do {
>+		struct task_struct *p = NULL;
>+
>+		rcu_read_lock();
>+		pid = find_ge_pid(nr, &init_pid_ns);

I wasn't aware of find_ge_pid() before. It walks the pid IDR, not every
possible pid number :) LGTM.

Reviewed-by: Lance Yang <lance.yang@linux.dev>
