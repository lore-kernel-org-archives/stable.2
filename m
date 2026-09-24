Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6392DF138
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 08:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790238785; cv=none; b=pEMz1IaKRLu6OqnZkLrWkbRynAGaGv2a8mNTQ1cuuoKiwRTsknNXrSVXpKWfqgXhqRGtx5qnpum4UVJVJdWqWbshE3MBxWQPj8PuCxCbhQ8ZUYvBHzFEeHamkXEvu9qbNhB+VmUFqo491uyh2/iCNvd5sOveEH4G5b+VfZxU+u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790238785; c=relaxed/simple;
	bh=TH17rxqUphQnvtWKdbekKc99InWQeXnXfBbQcZS9e9A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sfLsNklliWZh7f15hV78B5wi/HJlVYTbDxvtafG/w/H/Qc275I4tUJ3aIz80Y1tLaZyae1+bauVnsUgQaJgbafLQh4b70fvtAw5kwwhmdUUStxS8+ibcs4E1hbc8AtGr2dMqzbqLV5M67AZeZcralzTlxPUFk4/rY/ZR09WZR9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=jo/thCNB; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="jo/thCNB"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910ad20d4so183559385a.3
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 01:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790238783; x=1790843583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l7eSqpIJMRsWjDjp/oD+vMlCDPCfoeB6wnXpdjOOxbc=;
        b=jo/thCNBZFEeMsLv4HmduAAFG86OrPC9UYo/VIazofRirNDz+73ZENqqdI9ERIvFaF
         4nkMnjV+D7zUXHR01sWu9ncShqmC8SEq13wI6jb7qEAzTSbtD1NSr6RiTOWuy4X16qsc
         hIeYM0qpq7EMahz5aLvcxi7Olot1tVk318yvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790238783; x=1790843583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l7eSqpIJMRsWjDjp/oD+vMlCDPCfoeB6wnXpdjOOxbc=;
        b=Ofd4RI9yeMDRHuK+JwGJvrhgivL3PU8OSL4WmSW8HeSqK6q/vp3Aex8KhHHyQfFLbl
         iRaER/ZB/8Tw3KLWGcaojjGtg4OQwXFxokeyBbn6NGT8T55nVzYBUgrmiBUktn8/+KEQ
         T0E9WnS0IpgUCSm/AdcsdvP3JaxLdmBJu7pjWYnWhA3/qQG/MrFX8pRxjUC/XIXl0wQt
         22rrjpQ431GjU4mf4N2bT2YWV3jdMKM6FcQiIyBY39znE+6nVtYwsTeiAXoO7nxkEFE2
         Y6aOXri12URpSYYm/tuZ8eTk+leg/usljbos4s+qHTH6Zwto2MIHSVjJOGrxkffx6maf
         Hmwg==
X-Forwarded-Encrypted: i=1; AKwUvBydpwsevgLV+ANDB5VaCgTKKDZ5ydYAOueVtQxE4NmwDVOZgXQv3qqiAk1CIKFNb1L7hffWpvk=@vger.kernel.org
X-Gm-Message-State: AFuF++lonSbZF5ALQc+IuWITJgAO+u3dI5ccPaPJgZb3WTvAqEoTJyKi
	NZYfj6DYfmo0f2OHxEpMg9Iy45+OTTc5ExbepuGMJyXqh6xNd5iKp2nGNwLGc3WBIQ==
X-Gm-Gg: AYBFou0LLt6syySqprN/8RdqcBZal5Og3eqyyufbPagEK4HSFKtolr5Qlif195r8kPh
	0q4tgAJx/q8YZC9y5waKrDnCQP8HPlq00vEy0W6vE9CVy3SVpKRqjExMFSv1A0G3GmkMZZiBoFQ
	kzurh6M9z5oWBbuqxRhbPZIW+Y5hHaj7ALvkRwlzcuoZNAi9V1WQvxoUOn+cHxfC3Xe1wNqlU+O
	t6oSYaPCaUXrBZ79WwXR4kO8EiZE6MgAIHJDFtRYuHnpv+nHqcF3API18oDZiLX5+HX4DG8fYny
	F++WxK5pizcRme3aBn2J0en8r1YFg/eAsc/vFpDFjKvPlqG1U4Znb5AAWbgPjotmtGXWUqhTwPV
	G7LEqLQpLXjWaNuwQL+v6a00qwEMdkzjf60wsGOYQn1wn/WRW3zq8uu/8f4qKkKUYUtAC/UaILO
	KReZDjV1DYh5vi30yiwCSGmhjC3ekyhLVgf4ehpdNtAD400l3G2b+a6NbQZqVwGW3gOsGquYj5Q
	PV5TbsGla6q1lgCVkK9iSnsXaZj5hkt4HEbG2DQyGYoa8bwx8Jl5i+JZ4tf
X-Received: by 2002:a05:620a:8393:b0:93b:f083:b269 with SMTP id af79cd13be357-93c3642fe19mr164875985a.64.1790238782503;
        Thu, 24 Sep 2026 01:33:02 -0700 (PDT)
Received: from majuu.waya ([184.147.180.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c37bb7450sm69933485a.12.2026.09.24.01.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 01:33:02 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	hybris <hybris@mojatatu.ai>
Subject: [PATCH net] net/sched: cls_api: reclaim an empty proto on the error path
Date: Thu, 24 Sep 2026 04:32:49 -0400
Message-Id: <QDISC-JCOT.v1.20260910090924@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two racing tc filter add requests on the same chain/prio of an
unlocked classifier both run change() on the shared proto and both
can fail: the winner's tcf_chain_tp_delete_empty() attempt gives up
because the loser's handle is still in the idr, and the loser's
error path drops only its own reference without a second reclamation
attempt. The empty proto stays linked in the chain, holding the
chain reference, a block reference and the classifier module
reference until the chain or block is torn down.

Reclaim the proto on the error path of any failed request that holds
a proto reference. The reclamation is emptiness-gated:
tcf_chain_tp_delete_empty() unlinks the proto only when
delete_empty() admits it is empty, so a live shared proto is never
unlinked. A proto the request created is reclaimed unconditionally -
it is the only owner, so marking it for deletion is safe even without
a delete_empty callback. Classifiers without one (the check marks the
proto unconditionally) are rtnl-serialized, so the raced window this
guard closes cannot arise for them.

This is a follow-up to commit d4e359b3608a ("net/sched: cls_api: fix
teardown of an adopted proto on insert-race loss"), which stopped the
loser of the insert race from unlinking the winner's live proto but
left the empty-proto residual in place.

Conditions to recreate:
- CONFIG_NET_CLS_FLOWER=y; veth pair
- tc qdisc add dev veth0 ingress
- two concurrent `tc filter add dev veth0 ingress protocol ip pref 1
  flower skip_sw ... action drop` (both fail in fl_hw_replace_filter
  after publishing their handle in the idr); repeat in a loop
- an empty flower tp stays linked after both requests fail; visible
  as a bare `filter protocol ip pref 1 flower chain 0` header in
  `tc filter show` with no filter entries
- CAP_NET_ADMIN (namespace-local via unshare -Urn suffices)

Fixes: 8b64678e0af8 ("net: sched: refactor tp insert/delete for concurrent execution")
Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260805134049.927864-1-victor@mojatatu.com
Tested-by: hybris <hybris@mojatatu.ai>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/cls_api.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index c47d2ee13641..a9f54988561f 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -2463,7 +2463,20 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 	}
 
 errout:
-	if (err && tp_state == TP_CREATED)
+	if (err && !IS_ERR_OR_NULL(tp) &&
+	    (tp_state == TP_CREATED || tp->ops->delete_empty))
+		/*
+		 * The request is dropping its reference to tp. If it was
+		 * the last user (the idr is empty now), reclaim the proto.
+		 * A tp this request created is reclaimed unconditionally:
+		 * it is the only owner, so marking it for deletion is
+		 * safe. Otherwise only classifiers with a delete_empty
+		 * callback are reclaimed -- the callback admits an empty
+		 * proto only, so a live shared proto is never unlinked.
+		 * Classifiers without one (deleting is set
+		 * unconditionally) are rtnl-serialized, so the raced
+		 * window this guard closes cannot arise for them.
+		 */
 		tcf_chain_tp_delete_empty(chain, tp, rtnl_held, NULL);
 errout_tp:
 	if (chain) {
-- 
2.43.0

