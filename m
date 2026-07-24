Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BFD363C6A
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 19:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784921100; cv=none; b=jnAQI95RIMIAIKpkAIGfSu8adDPM7qqiD25o52iJ/0/WysCZt/UJc1Kbog9+65abwaPaG6VLIKf4YyrYWX8MlreWSUEAd18Y/1vYy9Ohn5S3hJnhjD8H+kyrvnlkEUTqsxP2Lqux6BmlUzfDceULMSouzfnv7Z4ibbpFYdzODgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784921100; c=relaxed/simple;
	bh=rdE3W7CmF0f18Z8ujjgPp/L0n/nuyGNjv1rF5+exiCA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Uu9x+BqfCRnAEO43m6UHOXEy5XMASl9EeTQCwfCorYy9fPhYCxpL46HrNwVA4GyRxyMAUkA+FNiiebZn9JfEU9w2dbwwhb0L5fy1gpa1obme/nGcw2hmwjjmlAkuql+2WuBClglV1FOx33xQKiXcCrTXHYuDB3UshFmKpdbeaMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=R6dY8+jb; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="R6dY8+jb"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-9030f8ea3b3so8678166d6.1
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 12:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1784921097; x=1785525897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SU106wu4bG5wZ846X/g89puUx7TATUDGTIXfzQG0eEc=;
        b=R6dY8+jbmDEutZ5l5ACssETP9cMIJG2MDwAhRLqlnoUTXRPQpMeO4hlUD1w0lBZKAG
         fNVfNCPqSBuX/MO4WQD8xsSY7X54fLauV09VC9Yvc5O8wNO0UOWy/CdVFnZtj7qglDik
         LAv8QW03SMm3PY8tZhMiXyYqks2l7XGIy7M+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784921097; x=1785525897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SU106wu4bG5wZ846X/g89puUx7TATUDGTIXfzQG0eEc=;
        b=DJ5eE5YFEPVqPkAbGVSLEFGXNCLuQUAsSiN+NiJ3+qwDzq94UHxEK9/+mnmjb0g+vs
         sugpHQsb94pKbXmLGeY8msZtacjmEiwtirJy5RS4/owWzz225Ab5Ss8yRUeB7KWqqMqX
         21If5y+uGRJxbl/jgrV54iuutfKBYPmu6qPU8ZKO2Rv1/ohWenz/jOVLTxYYWfTEVEhU
         95USGecbXB8EzMFiwVHzjIszCeL2mHE/CKd+y8ugs1/sbdsLG9KrJ1Sx/xRhuJLBm2Df
         WBKok7ZmiOHLNN7dQuuOq3tanIWHYoxVrbi3z+7jdmUQZFq6KIPJGFato2rsf1a/2XTh
         mmTQ==
X-Forwarded-Encrypted: i=1; AHgh+RpWVkPuzeptXKNwaExrvX92ZXU0j2XZ+SuQC4AUQnNcLfJUZH+r0V4I1jTPelZglIUEoGJlzlo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb0JTkXSmSALtcz8HSkMKHVli1GED40xjAcyGnbP6f9vuydpAE
	9lFgCfS+fvvQT1K4TVmpCp6zEL4T958/b5XojGiLX94xU+86S0mrizlB4SvB96XZ+w==
X-Gm-Gg: AR+sD10jPIO5DjSumY7KBDgpHDaQcm3NVbGwiUo/yol0ZyO9nYvHJr8kPqN3R3jfgMx
	zQ/wwv+0UGOJDHMgikV8RETtgHutjlGLHZqJ9eh6ttaF1eQiyiJ88J4zGk9DmUkLlhEH9GncR9f
	DpW/VRS0CG0NUuV1z5FbqHdpaHRUn/bdvRB6wl/KgJARCgxfsAQCXAd4qml1V/zkCW/p2eXK4T+
	XT44sxbYAeiEuUSXOOuCg7sGAQSFHXKMIC0/Gp0HBrwhcsWR0KbKVZIVttcrm31dmtEq25uDBsh
	0XNLa/yusqQZX8zg6RkNgbvl8N59hwRqR1TZv3LNQoAeUaKt1sG737LUTc47ipN0Kd5WRavj/W5
	cW6NUqqS5J77CfiS49DoT38Ir1mKpn7hIzmoheVtXHkC/h1t+7DVf74ZIMk18Jw1d62I7YoU=
X-Received: by 2002:ad4:5e8c:0:b0:8ff:650d:2b99 with SMTP id 6a1803df08f44-907ca135787mr104414936d6.0.1784921097042;
        Fri, 24 Jul 2026 12:24:57 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907e854e3a2sm4859996d6.17.2026.07.24.12.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:24:55 -0700 (PDT)
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
	santosh.kalluri129@gmail.com,
	victor@mojatatu.com,
	security@kernel.org,
	stable@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net v2 1/1] net/sched: cls_route: fix fastmap use-after-free and preserve netns teardown ordering
Date: Fri, 24 Jul 2026 15:24:41 -0400
Message-Id: <20260724192441.892133-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The route4 classifier maintains a 16-slot fastmap cache that stores raw
struct route4_filter pointers indexed by (id, iif). The reader
(route4_classify) populates this cache via route4_set_fastmap() for every
classified packet that hits a filter. The writer (route4_delete,
route4_change) clears the cache via route4_reset_fastmap() before
RCU-deferred kfree of the filter.

This creates a UAF race:
 1. Reader walks the RCU-protected bucket chain, finds filter f
 2. Writer unlinks f, calls route4_reset_fastmap(), then tcf_queue_work()
 3. Reader calls route4_set_fastmap() and writes f into the cache
    *after* the writer's reset, caching a pointer about to be freed
 4. After the RCU grace period, kfree(f) executes
 5. Next classified packet on the same (id, iif) tuple hits the stale
    fastmap entry and reads f->res from freed memory

Reproduced with an mdelay(100) accelerator in route4_set_fastmap() and a
concurrent add/delete stress test (provided by both zdi and Santosh).
Both triggered KASAN slab-use-after-free reports in the route4 fastmap
paths.

Fix:
Move the fastmap flush to the writer side under RTNL, ordered after
synchronize_rcu(). This ensures stale fastmap entries written by
in-flight readers are visible (readers have finished) and no new readers
can find the unlinked filter, so the subsequent route4_reset_fastmap(head)
flushes them safely while head is valid under RTNL.

In route4_destroy() the synchronous __route4_delete_filter() fallback is
retained for the case where tcf_exts_get_net() returns false (netns is
being torn down in cleanup_net()). The trailing synchronize_rcu() before
kfree_rcu(head) drains any in-flight readers first, so the synchronous
free is safe. Removing the fallback and unconditionally deferring via
route4_queue_work() would race with tc_action_net_exit(): cleanup_net()
does not flush the tc_filter_wq workqueue, so the deferred work could run
after the action idrinfo has been freed, causing a use-after-free on
idrinfo->lock in __tcf_action_put().

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
V1->V2
1. Fix based on feedback from the Sashikos
https://sashiko.dev/#/patchset/20260723105210.817079-1-jhs%40mojatatu.com
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260723105210.817079-1-jhs%40mojatatu.com

Restore the "if (tcf_exts_get_net(&f->exts)) route4_queue_work(f);
else __route4_delete_filter(f);"
preserving the tcf_exts_get_net() contract for netns teardown.
---
 net/sched/cls_route.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
index bd6f945bd388..c7d0164c1e9f 100644
--- a/net/sched/cls_route.c
+++ b/net/sched/cls_route.c
@@ -307,6 +307,19 @@ static void route4_destroy(struct tcf_proto *tp, bool rtnl_held,
 			kfree_rcu(b, rcu);
 		}
 	}
+
+	/* All filters are unlinked; no new reader can find them on the
+	 * chain.  Wait for in-flight readers that may still hold a filter
+	 * pointer and have published it into the fastmap after we unlinked.
+	 * Then flush the stale entries while head is still valid under
+	 * RTNL, matching the route4_delete() pattern.  This also protects
+	 * the synchronous __route4_delete_filter() path above: when the
+	 * netns is dying, tcf_exts_get_net() returns false and the filter
+	 * is freed directly, but only after all readers have drained.
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
