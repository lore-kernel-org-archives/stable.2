Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D86A4A0144
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 13:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788529439; cv=none; b=nER9HGDZDe7rhCAYlAk9VWIiiZWTzHCEoAJyqms9h+WAa4KgeZzANOq0arrIxsm2Cy4QW919jqga5Rb2sWqgvbAHP4dyPBvEcCSNDQIdA2GMdAm7CT+MlEZPlRW9YjSypXXM/mLFOWTHtS7+iYP7G0rLovMFgBTqoy7fXmFsgDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788529439; c=relaxed/simple;
	bh=bYXJfulgtX+PnYDfpEB2M/jmuXZZ+6DLN38BgVZO7pI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UlaEAkEEqCnE+GQ3nmMTg5wSja5cFKYaJBq2DobmMy93IXBINHRjVvr6gylH+QSmk86aT1C27mUCCLVFsh6EieWnps3fphk0sY9F28MElrtPtWxHEdJEvQ4oeRYakJM9Yu2e2KuXn4Z5IB9rRFpHn1UYwhx4yK5m2PzN7nuo0TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VH7VobCz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VH7VobCz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19ADE1F00A3D;
	Fri,  4 Sep 2026 13:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788529437;
	bh=fOkHuaPpTNeza5DDP1nED3h7KY4sHEMdMiro7zyvi1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VH7VobCz6nyr14m6YwstGYuy+aVmlpibr2xfm6C5j0K6LQlcuKwejJfRLeXA1Ix/f
	 fGB9u/j1EiRPB5zlNnYsrrVKqfAHz2VEQJevMm8pPMVRnplV6r7VV0GsRRdzKFMN7E
	 Q49I1Q5d0lUa3ZWKmFQozmTMorVf6rETbMMPuzU9evvuMwwNQnVibpxn3I/VJjHBYf
	 scEK5Q729troJ+ltIJAsfGQDntPZn20N062W6j/95bdxhOPCmGXRLgYxF67u6+eDg7
	 TVxyHY+uBY7fGiKdKQzw/cj6uEGbvYiLUP7kcZp5SKEmxA8JAd4CA/0J9PL7XJlVyE
	 Zia/Vn53AHwGw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Brendan Jackman <jackmanb@google.com>,
	sashiko-bot@kernel.org,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	"Harry Yoo (Oracle)" <harry@kernel.org>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y] mm/page_alloc: don't spin_trylock() in NMI on UP
Date: Fri,  4 Sep 2026 09:43:54 -0400
Message-ID: <20260904134354.567829-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090330-pupil-glancing-ae3a@gregkh>
References: <2026090330-pupil-glancing-ae3a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Brendan Jackman <jackmanb@google.com>

[ Upstream commit 3105ae628fb785d48b49256468be4f21a7b3cfc0 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ee902a468c2f5..db5a060fe022a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2967,8 +2967,10 @@ static void __free_frozen_pages(struct page *page, unsigned int order,
 		migratetype = MIGRATE_MOVABLE;
 	}
 
-	if (unlikely((fpi_flags & FPI_TRYLOCK) && IS_ENABLED(CONFIG_PREEMPT_RT)
-		     && (in_nmi() || in_hardirq()))) {
+	if (unlikely((fpi_flags & FPI_TRYLOCK) &&
+		     ((IS_ENABLED(CONFIG_PREEMPT_RT) &&
+		       (in_nmi() || in_hardirq())) ||
+		      (!IS_ENABLED(CONFIG_SMP) && in_nmi())))) {
 		add_page_to_zone_llist(zone, page, order);
 		return;
 	}
-- 
2.53.0

