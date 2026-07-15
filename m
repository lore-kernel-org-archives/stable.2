Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA92B3EB810
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 09:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106254; cv=none; b=DtjT5eBMLJ9KmIo4zi7jo631KkElxc1JPRJku2aDafsOihuqLbFzrxId2PLcpHvqxxFvnTolz+k+3d9OkUNVau8acGG5FCxdje5jesgYSud3x/4yY/9u81CTqK0XTgbwEbuU0CExXAGYAJgp3/Ic+oC+ROSjqjBUD4OyPAhJcyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106254; c=relaxed/simple;
	bh=T132sxp6UaJ+WwsQy/GiXCN6xCpAzZ0KSvradejtUNI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XA53dbsZbYIO+zTFjVQACyE2zSTGQD7H+HGkIpZFVk9LDvS470IM5Z6+ePez7ULFdl3je7UuGbpS3x5pK3XPzpRSM08zV/17XLbMhPu5Iuo4z2cEzi49Wk4oTDTU71kZR4un9yHnK+HxHYBLp8vou2+RZW5Ggj1VUrobGhHfZmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ErZCpzGg; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ErZCpzGg"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-493c526df6bso16677575e9.3
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 02:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784106245; x=1784711045; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tAjEggZE5XRXoCbkcOS6/MLSgIQDuHRdiYiNvUA8HH0=;
        b=ErZCpzGgMGRZa9gNKYXx4yIMAVdYtEgDoNT1B0eNQDRZPo09BtN/32Wc6YLMTd8TKF
         7qiuo3KBS1aIdDufYifiliP1CIJzzrhqKlpD2+h13w4JkrIBxNZSYqHzg1fHXeREwSXc
         EbXhLiz6oVNxkdnu8H/hZ1zWyHOLmSYk984tnPFi88G2NloROxarRtz9/AlJvT1SgHaq
         Q7pfHJTrjWrpWker0/QIMpWMpK3NjEWuHJJ45WUrOYQ9+DKZ9+MqaLeKpI/RmQ+5wAyO
         rfRcRxJDzYsGfiTcnzxJ8qtr8MmPFaTJK1L8x5/FUuqNi/hzssROPAOkltOvgT8aKqOW
         AxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784106245; x=1784711045;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tAjEggZE5XRXoCbkcOS6/MLSgIQDuHRdiYiNvUA8HH0=;
        b=EKOQ1GLkBQ41WGpMlBn4vS8IHgj41WScvGz32N4o0DXVM0JoMHjtZGWCWlOqYhIRKA
         LgaaUYR+pY6ZiRWuiSbyfesZSHirAanVHSP/PQkFLZ4KVHfaWPQSQRk8utA+sTfoSwQC
         W+7otwwssZbtGrQjQe/nqLe98hjx0gzzpgWuQZVemLRokMTPgYcyWHmi9n/OAhEbf8Xe
         rO7LMXIlS3DcAJPt6ihkYSINz5xjAQ3mtg8HSe5sPc+2hncOhZNaUEiw0ndGoBZAhqBB
         6zGnGAML2gRkBdvtdEoM99bhq64pDDR6vAfM2D258jmhMhjgs2PpVwUSFiLBneFcBwxE
         snUg==
X-Forwarded-Encrypted: i=1; AHgh+Rq3hi82oGmd322SQXwRcNhAIEZs+osJ0NPI0Vk+IbVRqN5/oAyE+V+MhZEp2rw7OBFcfITPAbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgEuYIPpzN5qUXf2JuXQr8q2EE2tP2k+r5MONynziS0FzOD3ma
	HnardFXdCfn61ah9pasH1XcNHB8lwIwHsTlMJDAByGNO4drQpYNLdNlyPXmVm5IbFftgq//2PQE
	K2R26nMq8jVA4jA==
X-Received: from wmby15.prod.google.com ([2002:a05:600c:c04f:b0:493:bdba:620b])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8217:b0:495:3c6d:f294 with SMTP id 5b1f17b1804b1-4953cbdc7e6mr20439975e9.23.1784106244314;
 Wed, 15 Jul 2026 02:04:04 -0700 (PDT)
Date: Wed, 15 Jul 2026 09:03:59 +0000
In-Reply-To: <20260715-alloc-nolock-fixes-v1-0-fadc49952dda@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260715-alloc-nolock-fixes-v1-0-fadc49952dda@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260715-alloc-nolock-fixes-v1-2-fadc49952dda@google.com>
Subject: [PATCH 2/2] mm/page_alloc: don't spin_trylock() when disallowed in free_one_page()
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

__free_frozen_pages() checks can_spin_trylock() before entering into the
main free_frozen_page_commit()/free_one_page() path, but before this it
can get to free_one_page() via the !pcp_allowed_order() and
MIGRATE_ISOLATE paths.

The !pcp_allowed_order() path depends on usage by callers so might not
be possible in practice. The MIGRATE_ISOLATE path probably means kernel
crashes and privilege escalation if anyone ever did memory hotplug and
BPF tracing on a PREEMPT_RT or !SMP build.

Cc: stable@vger.kernel.org
Fixes: 8c57b687e8331 ("mm, bpf: Introduce free_pages_nolock()")
Reported-by: sashiko-bot@kernel.org
Link: https://sashiko.dev/#/patchset/20260710-spin-trylock-followup-v1-0-affb5fe5ed00%40google.com?part=2
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5f9873dfccc5a..46e5ea59c71df 100644
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

-- 
2.54.0

