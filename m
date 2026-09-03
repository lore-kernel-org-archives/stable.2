Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379384AE8AB
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439681; cv=none; b=iQDEWG0gquLILqBSPxvWqqKnk8QCBcglWRYQK99elc23jnGYDVilmFSqak+Hx8or1UShGn6dIrO5VRAwafA042HzyNWmRwF2/rhppoCe215r1gbwoMysvMoBlADh2F/dXJJgRmBzb3MxhlILrWVfoJcDOHmO8nioPG0kTBmRNxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439681; c=relaxed/simple;
	bh=VFBFzLTkGZS7Wbb9Ho9fEq16h7yOOIQZVl1/KexlS5c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cQVkSpAVTxt0ZC7XnleXYNmIojOQjd6bEG5tbcUKq/TrvXk/rOLjvl+1yxQ71EYMIEwMoZqCX9Cn07cSw8YfsLORDJW8EKkZuRFvxKC95HUdGdaRQAhs/VjBrWA+kgHP0SchHkQbL/y0yVQPaupBCdTXD6K3dBWoeyi/8ASjhyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h7gKP34X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h7gKP34X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926A21F000E9;
	Thu,  3 Sep 2026 12:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788439680;
	bh=S7ToerS1fCZjGBnhIjj1m30AXx1+5ah0j9cZOc8XzmM=;
	h=Subject:To:Cc:From:Date;
	b=h7gKP34XJDA5AxGcvwcZn7gVzEgcH8AYEFsoEh/yWv4K7u5oDlSdZ/sNghEMwE/41
	 k2J8f3gmCFX/SoBnU1WWNkCUEiQKkfxz4gAXl3mD8YwM5EkvzXXSNsiRwxrfDReAy2
	 KgJOSnn3Pgl3UhM6lFtOAPUI3XNIQovOyxN5sR8E=
Subject: FAILED: patch "[PATCH] mm/page_alloc: don't spin_trylock() in NMI on UP" failed to apply to 6.18-stable tree
To: brendan.jackman@linux.dev,akpm@linux-foundation.org,ast@kernel.org,bigeasy@linutronix.de,hannes@cmpxchg.org,harry@kernel.org,jackmanb@google.com,mhocko@suse.com,rostedt@goodmis.org,shakeel.butt@linux.dev,stable@vger.kernel.org,surenb@google.com,vbabka@kernel.org,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 13:12:31 +0200
Message-ID: <2026090331-gooey-backup-bb1d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 3105ae628fb785d48b49256468be4f21a7b3cfc0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090331-gooey-backup-bb1d@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3105ae628fb785d48b49256468be4f21a7b3cfc0 Mon Sep 17 00:00:00 2001
From: Brendan Jackman <brendan.jackman@linux.dev>
Date: Wed, 15 Jul 2026 09:03:58 +0000
Subject: [PATCH] mm/page_alloc: don't spin_trylock() in NMI on UP

Patch series "mm/page_alloc: fixes for free_pages_nolock() on RT/UP".

Pre-existing bugs found by Sashiko during review of this other series:
https://lore.kernel.org/all/20260703-alloc-trylock-v5-0-c87b714e19d3@google.com/

I have not reproduced these bugs, and I suspect there is no real-world
user that is affected by them.


This patch (of 2):

As noted in can_spin_trylock(), using this is unsafe in this context.
commit 620b46ed6ae17 ("mm/page_alloc: return NULL early from
alloc_frozen_pages_nolock() in NMI on UP") fixed this on the alloc side
but missed the free side.

Impact: If BPF programs using these features in NMI (probably tracing) are
present on non-SMP builds this might crash the kernel and is probably
exploitable by local attackers for privilege escalation.

Link: https://lore.kernel.org/20260715-alloc-nolock-fixes-v1-0-fadc49952dda@google.com
Link: https://lore.kernel.org/20260715-alloc-nolock-fixes-v1-1-fadc49952dda@google.com
Fixes: 8c57b687e833 ("mm, bpf: Introduce free_pages_nolock()")
Signed-off-by: Brendan Jackman <jackmanb@google.com>
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260703-alloc-trylock-v5-0-c87b714e19d3%40google.com?part=18
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>
Cc: Brendan Jackman <brendan.jackman@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 520ebd2fa40b..b3487c00971e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2979,8 +2979,7 @@ static void __free_frozen_pages(struct page *page, unsigned int order,
 		migratetype = MIGRATE_MOVABLE;
 	}
 
-	if (unlikely((fpi_flags & FPI_TRYLOCK) && IS_ENABLED(CONFIG_PREEMPT_RT)
-		     && (in_nmi() || in_hardirq()))) {
+	if (unlikely((fpi_flags & FPI_TRYLOCK) && !can_spin_trylock())) {
 		add_page_to_zone_llist(zone, page, order);
 		return;
 	}

