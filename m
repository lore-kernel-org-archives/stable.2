Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50DC4AE139
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439679; cv=none; b=RIaf5NGoW1tGkL5jWhj+ilZznPMxRHAoO7PBmUyUIVnFUmnhmNxZpJsNIVUmlly+EdhTMYbcdVQhIfa/fPDZSPj46yqs0NbFs7klQMNFoFrg9+B0mJAGOpBy0B6qGnWSDIikQjV9MNCtjwLrSn/kjixyVx0+5LAQrJ33i3Y1msI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439679; c=relaxed/simple;
	bh=/+PVyCxt+B012jrtj1ua5kdAyIIdjK40UtEUQbNH198=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=G6kMTTaTBuW6X+NvnS8ZO4mbTC/EYMMUSzas4vfDvREwQygj7rWpX6uceUBTDNQgWxYwjdePs5f5PHuR6z160mSrz1GukcDrJ9T0hgblOLyRValLIveaZ3Gg6k6A0H3ZphLENetPVTMNzzZvOLVhBagdaWMc5Nf7T82m50w8o+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gb4G5JfC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gb4G5JfC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63CC1F000E9;
	Thu,  3 Sep 2026 12:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788439677;
	bh=XNPGYmY1Pz/CWInF4pPZuHzIeD9EIvnhoh9MuJWkSiA=;
	h=Subject:To:Cc:From:Date;
	b=gb4G5JfC6net1Fx98RWgYFCY5yYyay+5iOhL+PD9A8AmBTcY2nRoO/BqG0L9xRm9O
	 LrzpnslCaJmjpp0Q7b7W3MKS7Nevrc980dLA8YY470DqUKbnhuEurpvUd7UuBSqU+p
	 7LA8fgN5ILMLOE4Oi003pyt20pVOa5spuoqNokyA=
Subject: FAILED: patch "[PATCH] mm/page_alloc: don't spin_trylock() in NMI on UP" failed to apply to 7.2-stable tree
To: brendan.jackman@linux.dev,akpm@linux-foundation.org,ast@kernel.org,bigeasy@linutronix.de,hannes@cmpxchg.org,harry@kernel.org,jackmanb@google.com,mhocko@suse.com,rostedt@goodmis.org,shakeel.butt@linux.dev,stable@vger.kernel.org,surenb@google.com,vbabka@kernel.org,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 13:12:30 +0200
Message-ID: <2026090330-pupil-glancing-ae3a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x 3105ae628fb785d48b49256468be4f21a7b3cfc0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090330-pupil-glancing-ae3a@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

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

