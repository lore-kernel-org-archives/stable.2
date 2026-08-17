Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98A037CD53
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 19:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786993807; cv=none; b=TNK29YrTbEnE9W3VdnSrKpAWJp7/5+l77Uw/MXzx38GS8uNbxNrfm6B14t+FXyfxmWLX0o/109SaoeFl05aeU2Z4ktfJSSVuJzkRbCFsd35+JexVG9DW9clqFKD1KN3vlidvHzT2rucFa6L1HydeG3quE7D9Zev9pH7H8VkaKZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786993807; c=relaxed/simple;
	bh=MmTOyUrolNwdXixWEA61+iSEN1nJRaq75qaAf+1wVcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wh/kUSmkouKovpqFFKuI1E9zPMAjd23zGfIpSeaQhzxMocKhlksE5IVyD/DVvGVB1HZLGDFv80gLTIW5mhH8rWjman7y2tt+AgjC8DlbS4xFvSpeWO88ztr7RZfpoaZry3xt9A/2ZqTTxDBahzLam0p/l0rNMm2+jA8dqNig2uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=djoDY2FS; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="djoDY2FS"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso247588a91.1
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 12:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786993805; x=1787598605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c/2C+RYvjKIOLmlpG91ZI2qQFAEpzRihy5VcIrSXsdU=;
        b=djoDY2FSvFK7RnkZS5fyF5m4iaFcAqWvNOr02/AJLDNs0WzlvagJluBrwJ+5JZ6jKQ
         LWbw9KOvO63JslTr75enZib7ZwGuq3YOgIPhO2jT7qrQvF85Wxj8R7vb8fidE+Ddt80X
         peDzfqCaU3qFwhx+sPQWJA0yH1g18/XWz/8yAyYiiYMq81IFYAqTnsUdTrdRPvHbUj3K
         k9lYVx9aF3VsET7nW3zytnfvITDdzihg4QXHPBr2+DjBkm9WPq5grGQuNdMSDejKy/+C
         +YEM8eCH4NeQu7FpBi9mwmqGFB3JIlt7ukQaBmSHCYWrmptxRp/vzUi9hmwEwZedabK+
         SPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786993805; x=1787598605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c/2C+RYvjKIOLmlpG91ZI2qQFAEpzRihy5VcIrSXsdU=;
        b=g0NF4IS4uStUz4SmJA9RWS9e4MLholHpLyyUj1+K5r1calicmQ29PNmM3Is0FwG26M
         cNsj2kpatdGP8TvwWe5RCi4si9RTVQiropV8PinJLnGWkGZxB+4+amX88pzHOExgYTUn
         e4fqfFDIGtwT8CqVV0iZj9uLK37p0zJsT6VeIXObWTi7m/cTcBUId/3rEaOoezbyfMOe
         zxufioXeAIRCHMNHnV3xjqBtdwBLcggdv4aay3elTVjPKbYmiho6eHwpI3aV2HuFjzGv
         5k3kAXPatrk7kxRi0QNwQ2jUZh4FOWsqnB9BMBtbS26yncbmoz3jyN6UCJY2KYh/W0mc
         BjPw==
X-Forwarded-Encrypted: i=1; AHgh+RqAxkbVIRDw0MSia68mvA1PjGTAAWaMVFD4SgcU7WTEUyODAMEzEW1kZ14gePHaqpezjav2RqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfKGRJqq5M6Q1+/y/BRsIy6RzCMjoQZSCnrvhz6PnYppxUuC2K
	2wd2hrDBSIebYEsdyUNNvRUH7gVTi9eR7/wi+ybbzociGdjWR9TdygBBkv0PF4P9eMKy
X-Gm-Gg: AR+sD10WqiDO2DOko6AzvAsBCeJRAWvPrrpkrzuhYfDMequOsX6U1EWICtQR03/JGeA
	ypWMyoA9HK+4yKXATGVmtmIJYINH4HFYy6pEfHgS32v4mEAMstVITPh3BfFOWBrC7h5gQDEUne8
	XiuTf269H57H0kjkABrAAIjiOmEKbFsJkY5EfXiWIRRO6oBbGHWYc8ruDHpZZtX2fCa1sQqPZXi
	+wq8Rd9ppRpwRVSdDuWVMjv1XnlP1GAg1hlWBNWXxlAOKII4HuQK0aBKE6xYA220SaFy/pWwZPi
	E6Q7qj8N87nleV1HB3Cdod1VqsuLRpecZ6EvNuoh+dxjB//JCiRwgGltg/oOJTKuAtOFymC0Pc/
	2Fsn+d5iZZaXkb3KY/m6k17okkBtyW4TuWsVFRSXnrsqNsQc11JyxUGT1EZpaogo8D2O1WR7WXg
	qD+cG8YrZNdEUvifFQm02vVzIUUlFRzpnXxQCg/8FuVwkeh3VVaMyEMg==
X-Received: by 2002:a17:90b:390c:b0:38f:1a29:7a82 with SMTP id 98e67ed59e1d1-395638840ccmr52847a91.6.1786993804800;
        Mon, 17 Aug 2026 12:10:04 -0700 (PDT)
Received: from gmail.com ([115.196.71.116])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531e8904dsm6145831a91.8.2026.08.17.12.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 12:10:04 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Zihan Xi <zihanx@nebusec.ai>,
	stable@vger.kernel.org,
	Eyal Birger <eyal.birger@gmail.com>,
	Vega <vega@nebusec.ai>
Subject: [PATCH ipsec v3 1/1] xfrm: bound nat keepalive state collection
Date: Mon, 17 Aug 2026 19:09:56 +0000
Message-ID: <4fadde7d28791a4e1196664cec692fdebce99bb5.1786987905.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1786987905.git.zihanx@nebusec.ai>
References: <cover.1786987905.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The v1 nat keepalive fix allocates a GFP_ATOMIC object for every state
while collecting references for phase two. This makes the worker's
temporary memory use depend on the number of states and lets -ENOMEM abort
the scan.

Replace the allocated list with a fixed-size batch. When the batch is full,
return a private walk status so xfrm_state_walk() leaves a cursor; drain
the references after the walk releases xfrm_state_lock and resume from
the cursor. This bounds temporary memory use and avoids the allocation
failure path.

The v1 fix also moved nat_keepalive_send() out of the walk callback. Keep
the phase-two drain BH-disabled, as required by local_lock_nested_bh()
used by the keepalive sockets.

Fixes: 763fe700b7c5 ("xfrm: avoid lock inversion in nat keepalive work")
Cc: stable@vger.kernel.org
Cc: Eyal Birger <eyal.birger@gmail.com>
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
Changes in v3:
  - send an incremental fix on top of ipsec/master as requested by
    Steffen Klassert instead of replacing the queued v1
  - replace v1's unbounded GFP_ATOMIC list with a bounded batch and
    xfrm_state_walk() cursor resume
  - keep the phase-two drain BH-disabled for local_lock_nested_bh()
  - distinguish the template-only userspace command from the actual
    in-kernel validation integration, configuration, build, and boot steps
  - validate 17 concurrent states so the v3 worker fills its 16-entry
    batch and resumes from its cursor
  - recapture the complete original lockdep report and add its full
    batch addr2line mapping from the matching unstripped vmlinux
  - record the validation-kernel user-namespace limitation and the
    separate NETLINK_XFRM EINVAL result instead of implying that the
    template userspace command reproduced the bug
  - identify the crash log as evidence from a separate earlier root-cause
    reproducer revision, not output from the 17-state v3 batch PoC
  - v2 Link: https://lore.kernel.org/all/cover.1785861392.git.zihanx@nebusec.ai/

Changes in v2:
  - reroll on top of net cf6f8b29befb
  - replace the unbounded GFP_ATOMIC state list with a bounded batch
  - keep phase-two processing in BH-disabled context
  - clarify the validation permission model and reproducer scope
  - v1 Link: https://lore.kernel.org/all/cover.1784645321.git.xizh2024@lzu.edu.cn/

 net/xfrm/xfrm_nat_keepalive.c | 46 ++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/net/xfrm/xfrm_nat_keepalive.c b/net/xfrm/xfrm_nat_keepalive.c
index 8679c68c10a1..5cd6d43164db 100644
--- a/net/xfrm/xfrm_nat_keepalive.c
+++ b/net/xfrm/xfrm_nat_keepalive.c
@@ -155,32 +155,30 @@ static void nat_keepalive_send(struct nat_keepalive *ka)
 	}
 }
 
+enum {
+	NAT_KEEPALIVE_BATCH_SIZE = 16,
+	NAT_KEEPALIVE_BATCH_FULL = 1,
+};
+
 struct nat_keepalive_work_ctx {
-	struct list_head states;
+	struct xfrm_state *batch[NAT_KEEPALIVE_BATCH_SIZE];
+	unsigned int nr;
 	time64_t next_run;
 	time64_t now;
 };
 
-struct nat_keepalive_state {
-	struct list_head list;
-	struct xfrm_state *x;
-};
-
 static int nat_keepalive_work_collect(struct xfrm_state *x, int count, void *ptr)
 {
 	struct nat_keepalive_work_ctx *ctx = ptr;
-	struct nat_keepalive_state *state;
 
 	if (!READ_ONCE(x->nat_keepalive_interval))
 		return 0;
 
-	state = kmalloc_obj(*state, GFP_ATOMIC);
-	if (!state)
-		return -ENOMEM;
+	if (ctx->nr == ARRAY_SIZE(ctx->batch))
+		return NAT_KEEPALIVE_BATCH_FULL;
 
 	xfrm_state_hold(x);
-	state->x = x;
-	list_add_tail(&state->list, &ctx->states);
+	ctx->batch[ctx->nr++] = x;
 	return 0;
 }
 
@@ -226,29 +224,27 @@ static void nat_keepalive_work_single(struct xfrm_state *x,
 
 static void nat_keepalive_work(struct work_struct *work)
 {
-	struct nat_keepalive_state *state, *tmp;
 	struct nat_keepalive_work_ctx ctx;
 	struct xfrm_state_walk walk;
 	struct net *net;
-	int err;
+	int err, i;
 
-	INIT_LIST_HEAD(&ctx.states);
 	ctx.next_run = 0;
 	ctx.now = ktime_get_real_seconds();
 
 	net = container_of(work, struct net, xfrm.nat_keepalive_work.work);
 	xfrm_state_walk_init(&walk, IPPROTO_ESP, NULL);
-	err = xfrm_state_walk(net, &walk, nat_keepalive_work_collect, &ctx);
+	do {
+		ctx.nr = 0;
+		err = xfrm_state_walk(net, &walk, nat_keepalive_work_collect, &ctx);
+		local_bh_disable();
+		for (i = 0; i < ctx.nr; i++) {
+			nat_keepalive_work_single(ctx.batch[i], &ctx);
+			xfrm_state_put(ctx.batch[i]);
+		}
+		local_bh_enable();
+	} while (err == NAT_KEEPALIVE_BATCH_FULL);
 	xfrm_state_walk_done(&walk, net);
-	list_for_each_entry_safe(state, tmp, &ctx.states, list) {
-		nat_keepalive_work_single(state->x, &ctx);
-		xfrm_state_put(state->x);
-		kfree(state);
-	}
-	if (err == -ENOMEM) {
-		schedule_delayed_work(&net->xfrm.nat_keepalive_work, 0);
-		return;
-	}
 	if (ctx.next_run)
 		schedule_delayed_work(&net->xfrm.nat_keepalive_work,
 				      (ctx.next_run - ctx.now) * HZ);
-- 
2.43.0

