Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D83440A2D
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784803975; cv=none; b=sT9cS6YVQ3GyHypBqFI8BJPbZ5z3MHKD/a4iOP8NflvlLM72I1gkA+9t9+OmJlnzkNwxcZXv7uuKrbWQaB5OVjqcz5IqogVVaOlsOQX2AXP7jjoEN+wXqL5bXqiRQCx5LIRpUfxuBAF+yaJAqR/DrpreOufolSO1kcsIXAjHfBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784803975; c=relaxed/simple;
	bh=2GjEekfhsKHZU2DhsV5Bo35uprF/sY8GoPIsoM20T48=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FvMl3jjV+zBP6CpT3wPpRbpmTTDAuJLiNUz+xeJIlexXJCwILrNDpj7JNyUKFuJTJtlpxVivnirCFazLYEtBzOz90K1Y8bJcTrjYWwC9XmOQl3mknmyrwQtBeepbP8JZj2LMcQ/2D+uO13QqCwIElpM+zuVhSOpTlfDNDKu5t1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=cFAn7Ath; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="cFAn7Ath"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-966d70b9e1cso281255241.2
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 03:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1784803970; x=1785408770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hNsDmqf0L2DQ923uqfgdUFWg8JI20GGO2Glmu9J3hdA=;
        b=cFAn7Ath6rFWrmGsm91NKjYqAGCL7LaIZSJokgoV6WGm4Kbxw5tMIi5pJy9n14b9Et
         ZzjlQG0Nsv6dA7IltByQWRfPCcJv5OSvYSwuy1YEhTwIPQgfp5aGGXyK9el/E6Qj5IlN
         9POGxCvNvKWpMRMY8CILYiWtXUIhIq5J4qHXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784803970; x=1785408770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hNsDmqf0L2DQ923uqfgdUFWg8JI20GGO2Glmu9J3hdA=;
        b=WDiKIBkjF7HfFKXbuaNom3I2gzr8P4jHYR5zL62fGA7XGOfr5REesyVCT63X36bchg
         4XdwGdVD55MYe9yywuL3sFnNqthDtQc/yuwHAEk+UaySOD7IvhMKvYlzR7ZpYZwJy89j
         7Ucm4rpZunjs3sRFZgxxFgiy2EvnJBgZ0vi1RezgAOpmvSRr27prec44WkBgik+duXCJ
         Zuuf7CIu08nGqgpYtM5Ql0HlbwZD0cRBPTZxU6/g+ol9QUkkFlHJWjoX3tfzrfAcmQh3
         3XDvEC0kZh6AVsVuy33EVyFv+/oz7MH8JLOBmNtTM4FjpKFrBiWvlGOL4iBW4Hvbks7m
         viZw==
X-Forwarded-Encrypted: i=1; AHgh+Ro4imHWDegZQzsc+DOUBkRJI/6hISy1aru8RQWuC2sRq8kyVn/Mn6Owf5IcyIKXP3cNW2pyO8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyagcWQz1s0GvFL1U57Mva3E+6R35B65S4EZ06oDeXk5RWMz96F
	dfG1pTF7CaAuqxPfVCnrP/K8DLQ3Q6A0QD2+/HYWD7d1ydwqkAMCDwdaGqWi9ilaxQ==
X-Gm-Gg: AR+sD139YFnMMW3napVKH4RfzYKjm1pYaoZaF9Ldfq/vjqYHJtrgXM6WklpqVsp3PZN
	Fxqfg3sOsKWmpwqpNkefTMwojFJqd/GoCkJHi/qtUJOuttprDti4HhIywjnrHCsleGwY03xafJ6
	oZyf6g50kmOxk+mqobSbthgFwP+u0eHXOPfXljcZdLkwpRUBc6ZWh0ShI9oe6mRmsS85iqU7vtf
	zaOTHjnb1YGbrqiGaJNVXn/WLOPWHdJ3Jm/5hpEk/EbKsjsoDD8QfCXh4sTg7wSviIo4Z6VaoX2
	9q1zZAElwzu2flKbEp3dO5WEyRFTDZJdpHEyYkXPpHSR6X4i6FUfRy4bNDZ63FnuE/uRZSl+/gY
	oJgMZ6RfC/hq6U139lO2pmtFsu21IYznO/lRZ+D26QUrzLQP41kDY2ZdPUCq20c/eUUxIaEmRjQ
	jZ75+0VA==
X-Received: by 2002:a05:6102:3f11:b0:738:472f:2cb3 with SMTP id ada2fe7eead31-74d5e3ce9a1mr1066069137.8.1784803970546;
        Thu, 23 Jul 2026 03:52:50 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-74ad31c1fa4sm4675225137.1.2026.07.23.03.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 03:52:49 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	john.fastabend@gmail.com,
	jiri@resnulli.us,
	zdi-disclosures@trendmicro.com,
	sh.kalluri129@gmail.com,
	victor@mojatatu.com,
	security@kernel.org,
	stable@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Santosh Kalluri <santosh.kalluri129@gmail.com>
Subject: [PATCH net 1/1] net/sched: cls_route: fix fastmap use-after-free on filter
Date: Thu, 23 Jul 2026 06:52:10 -0400
Message-Id: <20260723105210.817079-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A case of partially rcu'ed structs.
The route4 classifier maintains a 16-slot fastmap cache that stores raw
struct route4_filter pointers indexed by (id, iif). The reader
(route4_classify) populates this cache via route4_set_fastmap() for
every classified packet that hits a filter. The writer
(route4_delete, route4_change) clears the cache via
route4_reset_fastmap() before RCU-deferred kfree of the filter.

This creates a UAF race:
 1. Reader walks the RCU-protected bucket chain, finds filter f
 2. Writer unlinks f, calls route4_reset_fastmap(), then tcf_queue_work()
 3. Reader calls route4_set_fastmap() and writes f into the cache
    *after* the writer's reset, caching a pointer about to be freed
 4. After the RCU grace period, kfree(f) executes
 5. Next classified packet on the same (id, iif) tuple hits the stale
    fastmap entry and reads f->res from freed memory

Reproduced with an mdelay(100) accelerator in route4_set_fastmap() and a
concurrent add/delete stress test (provided by both zdi and Santosh) deletes
the last filter on a tp. Both triggered KASAN slab-use-after-free reports
in the route4 fastmap paths.

Fix:
Move the fastmap flush to the writer side under RTNL, ordered after
synchronize_rcu(). This ensures stale fastmap entries written by in-flight
readers are visible (readers have finished) and no new readers can find the
unlinked filter, so the subsequent route4_reset_fastmap(head) flushes them
safely while head is valid under RTNL.

Note: This fix will slow down deletes and filter add/replace, since
synchronize_rcu() is called under RTNL in route4_delete() and
route4_change(). An alternative fix would have been to introduce refcnt
to the head struct but that is a much bigger patch. We justify this as
a reasonable fix.

Fixes: 1109c00547fc ("net: sched: RCU cls_route")
Reported-by: zdi-disclosures@trendmicro.com
Reported-by: Santosh Kalluri <santosh.kalluri129@gmail.com>
Suggested-by: Santosh Kalluri <santosh.kalluri129@gmail.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Tested-by: Santosh Kalluri <santosh.kalluri129@gmail.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/cls_route.c | 42 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
index bd6f945bd388..700f878fc3cd 100644
--- a/net/sched/cls_route.c
+++ b/net/sched/cls_route.c
@@ -297,16 +297,29 @@ static void route4_destroy(struct tcf_proto *tp, bool rtnl_held,
 					next = rtnl_dereference(f->next);
 					RCU_INIT_POINTER(b->ht[h2], next);
 					tcf_unbind_filter(tp, &f->res);
-					if (tcf_exts_get_net(&f->exts))
-						route4_queue_work(f);
-					else
-						__route4_delete_filter(f);
+					/* Always defer the free.  The direct
+					 * __route4_delete_filter() path has no
+					 * grace period and races with readers
+					 * that cached f in the fastmap.
+					 */
+					tcf_exts_get_net(&f->exts);
+					route4_queue_work(f);
 				}
 			}
 			RCU_INIT_POINTER(head->table[h1], NULL);
 			kfree_rcu(b, rcu);
 		}
 	}
+
+	/* All filters are unlinked; no new reader can find them on the
+	 * chain.  Wait for in-flight readers that may still hold a filter
+	 * pointer and have published it into the fastmap after we unlinked.
+	 * Then flush the stale entries while head is still valid under
+	 * RTNL, matching the route4_delete() pattern.
+	 */
+	synchronize_rcu();
+	route4_reset_fastmap(head);
+
 	kfree_rcu(head, rcu);
 }
 
@@ -334,10 +347,16 @@ static int route4_delete(struct tcf_proto *tp, void *arg, bool *last,
 			/* unlink it */
 			RCU_INIT_POINTER(*fp, rtnl_dereference(f->next));
 
-			/* Remove any fastmap lookups that might ref filter
-			 * notice we unlink'd the filter so we can't get it
-			 * back in the fastmap.
+			/* This code path assumes we have the RTNL lock.
+			 * We wait for in-flight readers that may still hold
+			 * the filter pointer and publish it into the fastmap
+			 * after we unlinked it.
+			 * Once done, no new reader can find the filter on the
+			 * chain, so the only stale fastmap entries are the
+			 * ones those readers just wrote. Flush them now
+			 * while head is still valid.
 			 */
+			synchronize_rcu();
 			route4_reset_fastmap(head);
 
 			/* Delete it */
@@ -558,6 +577,15 @@ static int route4_change(struct net *net, struct sk_buff *in_skb,
 		}
 	}
 
+	/* Assuming RTNL lock. Wait for in-flight readers that may still
+	 * hold a filter pointer and publish it into the fastmap after we
+	 * inserted the new filter (or unlinked fold when replacing).
+	 * Once they are done, flush the stale entries while head is still
+	 * valid.  Needed on both the creation and replace paths: on
+	 * creation, readers may have cached a ROUTE4_FAILURE entry for the
+	 * (id, iif) tuple that the new filter now matches.
+	 */
+	synchronize_rcu();
 	route4_reset_fastmap(head);
 	*arg = f;
 	if (fold) {
-- 
2.34.1

