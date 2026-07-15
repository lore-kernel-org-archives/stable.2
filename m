Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1903E44E4
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 09:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106251; cv=none; b=laLShByDVlpOH74ICL/P7dghoo6eOw/ek6DjCB7UlvpE9glnFXWce8AagBhsLtO7bNWaifih+TiD6Zx0aDiOUN3zA4u+BLCPTAZlfqXHlLUYhX+DLrsZQ0NZnjPLlx4lBxH62/2lhuWgm0qTdPQTS1CSaP5WWfdDBxSClT5DTxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106251; c=relaxed/simple;
	bh=7eoePbvSqh0YaMS9xWVd9GuaJ5G8xU8vZn5SQIU+NqI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y0Sx1ySoSbXf+z1kDdgz24TZ7MXGR88p6wOJQ9Ooicb5PgNjaWWkFzy5vwUWhVn4RSAItUqQsxviy8+ny1YUTM8r+m9IdQD+bFN3ABoNKSMenxzTBqSxKjbLat60odtV65J+0klVkZ1R1z1engBdQ69C+sQ/I88Apf/IoCyC7o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dEndOrBD; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dEndOrBD"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-493ae2a6a72so19893095e9.0
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 02:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784106243; x=1784711043; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JV1FEY2WoHNNRK+gCNUw7lvhLp/1mE5IHJqYJCHXcJw=;
        b=dEndOrBDjXdDQDuY4c2uOy8vgPtDVHtDVoA5i3Lqpe3B9B9br3fbUzSGuGVurJDl8a
         Lou8ssTpV4ZMwe4Dz79hn9dqxkrzU0NEwacgKmhNfRgMA72Sgn9/bKh81KjlCW8D4PZY
         L3XObJK87lQ1lPly1EJHTlSNiWpfxlzmBSXl+NwPjI3RMjtD3vnG0wTXTOuvKlOseoaM
         KH9MaLUzFLlDIKnMGqTnW9j2WyXJnIOvGDEbgxN9+eMvRvYWNgFiNMTGL5b+ApWsMyGp
         t/T1xsxHCvS1zEABOOrr5Ed03xWMiOcZ3JuacetNXBX8Znd+8tT5vJN50I8Ihya/vx9t
         HQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784106243; x=1784711043;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JV1FEY2WoHNNRK+gCNUw7lvhLp/1mE5IHJqYJCHXcJw=;
        b=k8ks84a0MqPw7GNo8pti3yjWsWFiAN2Mi9mSUyfX9+GLyNPgISsgWSgBb35B8HbACE
         iLajHeSK6Xcta1H1c7kAlDu9J6Rj+03L72HaU/xO/J7HYA6KeuCQ9xr7RnU36IIhL4CC
         LDTpkZ0Bqy5uS2rWtdfTsP/5kKFJInRxvwAw6p3jhTQXT3J/KtnO0JTTBOGGhqYJhE/6
         QZBPW3sk4IIjexPvvh/9XGxZAg68fxHhy2KynWLNWeLX1JTUOW5TXMLoqeSu1PQcqDff
         kdGMhF5BJQnjL61pKH5Y6R6rHrpK5m5SWzbOttH+vVB+gxW2JKQ5LMyDAboZhb85OEZN
         9bNA==
X-Forwarded-Encrypted: i=1; AHgh+RrR0nWFnW6khMUt/6VSURn3b35Tgq74vAdEJSusL/XGezba4OvMiQ3XuLEeBQo1t269t25PFu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvanA86KCAVWpx/z+eJjyJJdXILknQ1j+8EE3FIvpitpoKtKUe
	lER/cUP2Ja1q8RV5o5Zo8O5djUi2bAvLPza+DIQn2RyM4R1DAuODn8KbDinl4dMN2T/GKvrAzzk
	b13PDHeZsEtYxkg==
X-Received: from wmqe20.prod.google.com ([2002:a05:600c:4e54:b0:493:b719:1145])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d15:b0:493:ee2b:c8c7 with SMTP id 5b1f17b1804b1-493f87d5819mr160649475e9.4.1784106242700;
 Wed, 15 Jul 2026 02:04:02 -0700 (PDT)
Date: Wed, 15 Jul 2026 09:03:58 +0000
In-Reply-To: <20260715-alloc-nolock-fixes-v1-0-fadc49952dda@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260715-alloc-nolock-fixes-v1-0-fadc49952dda@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260715-alloc-nolock-fixes-v1-1-fadc49952dda@google.com>
Subject: [PATCH 1/2] mm/page_alloc: don't spin_trylock() in NMI on UP
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov <ast@kernel.org>, Harry Yoo <harry@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Brendan Jackman <jackmanb@google.com>, sashiko-bot@kernel.org
Content-Type: text/plain; charset="utf-8"

As noted in can_spin_trylock(), using this is unsafe in this context.
commit 620b46ed6ae17 ("mm/page_alloc: return NULL early from
alloc_frozen_pages_nolock() in NMI on UP") fixed this on the alloc side
but missed the free side.

Impact: If BPF programs using these features in NMI (probably tracing)
are present on non-SMP builds this might crash the kernel and is
probably exploitable by local attackers for privilege escalation.

Reported-by: sashiko-bot@kernel.org
Link: https://sashiko.dev/#/patchset/20260703-alloc-trylock-v5-0-c87b714e19d3%40google.com?part=18
Cc: stable@vger.kernel.org
Fixes: 8c57b687e8331 ("mm, bpf: Introduce free_pages_nolock()")
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/page_alloc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index af63558391345..5f9873dfccc5a 100644
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

-- 
2.54.0

