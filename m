Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A3B4AE11B
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439684; cv=none; b=fdCYXw6OPP8WoNtFsqz0GTfp+zMyHJfj3IPkD9kqdxTqUrhv6zsgm4KYxTgShVWtri0kwhBR8+xe1pGg2sqZ5AQAvFtZLJ/e2e560oQuQbosrDKtoGOX+kiSF9hL1ioN1Pz8GVurNYBWZNNPmBerSnanSssQyi56RGrn3ySJ1UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439684; c=relaxed/simple;
	bh=nddkFYY8jZTmaMkPeATx6vb0NR0AWvjIVPFvURXnnOw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=l0f1nxIp1+amvB7BvhvETlxCMAaWpIDkSx4eu7+aMvFkkfodph/CztlUwgE63+B8+9fzxZKn/+nKRYwGmfhBa8EsJJwhaH1gr9a7j56Y/Y8UriVfj5jPbS27HaroF7bhMjlc7qkGO0uZfIjdyPxBiU8xUvjirEtCtNC8nNSxsaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T49H0ZM4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T49H0ZM4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785121F000E9;
	Thu,  3 Sep 2026 12:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788439682;
	bh=14ueOEkuGU9RXE73Z/8fE20fFNyMEM/WMTXOEZmWhng=;
	h=Subject:To:Cc:From:Date;
	b=T49H0ZM4oaZQ5ajAYqUdFgci12rqhTmZiQeSnk9oxGvlXftw5EcR1mHJZWpeblvYp
	 WnIRkDueZ9m4Xt6pWnvHdBT+/USXHw/kqT++ko5HgbRfdqu98lLP2U0UjGu+dFvkCx
	 KP8WOGrSBMnCwrTYMZa25fAZk17TMgGGXUxz+4Vs=
Subject: FAILED: patch "[PATCH] mm/page_alloc: don't spin_trylock() when disallowed in" failed to apply to 6.18-stable tree
To: brendan.jackman@linux.dev,akpm@linux-foundation.org,ast@kernel.org,bigeasy@linutronix.de,hannes@cmpxchg.org,harry@kernel.org,jackmanb@google.com,mhocko@suse.com,rostedt@goodmis.org,shakeel.butt@linux.dev,stable@vger.kernel.org,surenb@google.com,vbabka@kernel.org,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 13:12:57 +0200
Message-ID: <2026090357-enjoying-caption-48e1@gregkh>
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
git cherry-pick -x 52dcc33881e55189650404f833c0e6b7913d6c16
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090357-enjoying-caption-48e1@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 52dcc33881e55189650404f833c0e6b7913d6c16 Mon Sep 17 00:00:00 2001
From: Brendan Jackman <brendan.jackman@linux.dev>
Date: Wed, 15 Jul 2026 09:03:59 +0000
Subject: [PATCH] mm/page_alloc: don't spin_trylock() when disallowed in
 free_one_page()

__free_frozen_pages() checks can_spin_trylock() before entering into the
main free_frozen_page_commit()/free_one_page() path, but before this it
can get to free_one_page() via the !pcp_allowed_order() and
MIGRATE_ISOLATE paths.

The !pcp_allowed_order() path depends on usage by callers so might not be
possible in practice.  The MIGRATE_ISOLATE path probably means kernel
crashes and privilege escalation if anyone ever did memory hotplug and BPF
tracing on a PREEMPT_RT or !SMP build.

Link: https://lore.kernel.org/20260715-alloc-nolock-fixes-v1-2-fadc49952dda@google.com
Signed-off-by: Brendan Jackman <jackmanb@google.com>
Fixes: 8c57b687e833 ("mm, bpf: Introduce free_pages_nolock()")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260710-spin-trylock-followup-v1-0-affb5fe5ed00%40google.com?part=2
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
index b3487c00971e..891f687e622c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1559,7 +1559,7 @@ static void free_one_page(struct zone *zone, struct page *page,
 	unsigned long flags;
 
 	if (unlikely(fpi_flags & FPI_TRYLOCK)) {
-		if (!spin_trylock_irqsave(&zone->lock, flags)) {
+		if (!can_spin_trylock() || !spin_trylock_irqsave(&zone->lock, flags)) {
 			add_page_to_zone_llist(zone, page, order);
 			return;
 		}

