Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE4F22157B
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 02:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790561918; cv=none; b=BlLteKIzECIgmbNWVF/+RiMZejS+IjyOSVEi+/JYyu6bSRt5LhLjwndyYr0zDFGgCKtF2w1pOuw46sH4yXpc2PMTVTKZ/GkMKou4xc+9AAVPqheQMr0B4XDapxFKxXCS5rnIzMN8E/S6YDk0L7n0+Ous8y6G2EEe7WXUJslgxMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790561918; c=relaxed/simple;
	bh=dpHqYiLpdGEhlWJ1NnGL2UjLzICJpNOUDte/rX3eCuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pXb3bNHlNs3QFSr22vDQeKP9+0T0G1ygBW4TLsmlNXa7wRBv8QvxqDwrOvHIYMB3hGMhCYzHesE3UTg9+Y59Q9j8YlOa8zQvTkbnNeu8iiJpjOBYRy8nXGHIn5QrVQELG8qdT56it3es7oqwSC+i71+Sp/XNiU3RB0KmPvDFpoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMO3tmzx; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMO3tmzx"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc78d59bb02so759775a12.1
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 19:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790561916; x=1791166716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zyPOBsQ95As/bAUQjJfBc5qcRWRX4ZcJs+UrgJwMK0U=;
        b=fMO3tmzx+wW4IzshcQyYXfRC1CPTZkuxMUOBQz8RrCfHOMr5H07YXdaMZvf4sS8fIc
         iFnSf7rWpXy/q9/s6mN6i3ndQD3T+8iEiNdAneK1/8d+5jbdT735W5f9bnd9NgaJS6Fn
         TUVxX6Scy+NB58uPpXqVrBH/YXD+gLfp+hTGDZggm8KoulvxaCDz5b873+zZTGWgLlId
         vf88xF96ZGyRRrWCs5vFW16lbV/zP7VmM31L/e4Sm5FnHyvskCvoGsuW2vxJEVDGinHy
         lBuiDJiUGt3W7T6jWtTKzsBKY0vcvY5JTrbiOL4gCmouyTaKEfC4JjE8czmg4AtvypPf
         8Zkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790561916; x=1791166716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zyPOBsQ95As/bAUQjJfBc5qcRWRX4ZcJs+UrgJwMK0U=;
        b=ZkQHwfLMfnXCrEFrRhMKDj0m49yUGBPCiJCg5lmpKFjGA5YYGsoy0Yaxh2OhWlV+pf
         7BXwV10N+v4YwxRRJFVtlvADnjyTdbUImvXkILYVwlVlFPC0hibXBL4JSLRV9zsEfZKM
         OmJ6AiHKEnNRfTj4UiNrI9eAxbasz6oR34dft+LCMunLXJZGQdR7Xmoz4joVcDLRQjK0
         whsfvqmpAPoqsqE285wyp0+arHPivYeVKt1rsZZRlwiTNwxfpsnb6FKs/3AlGI2TzhZ6
         EzzoBcAz4e/ErNzVoF+x1mfhPOZq9lTgiqG3TI9pLt2j1P6g0RQj0dFHCw6aUfP0Ma6o
         X2Zg==
X-Forwarded-Encrypted: i=1; AKwUvBz2pooNyfXK1cte/XjNYHlpVKYyfohpUxIbl1Uq2kLRnTkc7LpV6WFYFXRIIXTDOQ6D5d+wVVk=@vger.kernel.org
X-Gm-Message-State: AFq9FYILb1cfn1qaqKDb+MyLeGEm0fpkoO1uK2rKbpnMnbfXxOq6CkYn
	+oz/OVPMTKuah7qim893ktUPwb5HO+gWEIERJHhPXBZwkh7W65xgtna1
X-Gm-Gg: AYBFou0aa55YNkHXTw2lUaOz4BRhA6iZ+w9jxjvH/DPGsHHCyelx5ZqHsVLpwVCmUcK
	XzxmNn7XzEfcH6NgilKZPH0YJNw3t30oUZBvU8OAqC9cLRrCcIuL2ewmzMvNpA3ZBoUoM92sWI6
	MnG9T3SfjrOP5t7jLrvPCP5rxapQmj3CdaR+SlkTM/gNQ1gJG83fJGHoAJDylfQE76GWkMQBM6/
	7ejq3ooE7ew4Y1+Z7vSYQE2vEkKEvjzFWWoRUPuvq+iGnyCk2x1vwKpFiFTYSizrP5ncoEoR1fw
	yVL1XpZOYwscQgPkQP9HkLGnFQMWg2RCmfh9GooHkDAbfb5C+t4sC2o4pgclOYUh5yIzK8E3rAt
	rOHPe5LyU9usZ/TDtjvZcsnkrVWCIpOfuUVOdWAOJ4HRANGhu659rNSqU8rPprdnxoyzR8c8cXr
	h9d22v2+z6LtLZxOuZfuT+VN8W1gIEQ2YWzNT4+6rj6u1eHVyXV5qG7HgKpDQf7TVspRPe90Lpy
	cPlJ42133sZjcid6dxbgq54oZgQuDKKgmGAn6zNjq4j6TU=
X-Received: by 2002:a17:90b:4e86:b0:39e:4c7f:7306 with SMTP id 98e67ed59e1d1-3a098b8addcmr9157354a91.29.1790561915972;
        Sun, 27 Sep 2026 19:18:35 -0700 (PDT)
Received: from JUNVYYANG-MC1.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b94936ddsm17588500a91.7.2026.09.27.19.18.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 27 Sep 2026 19:18:35 -0700 (PDT)
From: Jun Yang <juny24602@gmail.com>
To: tung.quang.nguyen@est.tech
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	jmaloy@redhat.com,
	Jun Yang <junvyyang@tencent.com>,
	stable@vger.kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>
Subject: [PATCH net v2] tipc: reject name table updates with invalid origin node
Date: Mon, 28 Sep 2026 10:17:54 +0800
Message-ID: <20260928021807.7945-1-juny24602@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jun Yang <junvyyang@tencent.com>

tipc_rcv() locates the sending peer using msg_prevnode(), while
tipc_named_rcv() takes the node address for NAME_DISTRIBUTOR updates
from msg_orignode(). These are separate fields in the message header,
so finding a valid peer does not validate the origin node.

For a WITHDRAWAL with origin node 0, tipc_nametbl_remove_publ() treats
the node as a wildcard and can remove a matching peer publication from
the name table. tipc_node_unsubscribe() then returns without unlinking
binding_node because in_own_node() treats node 0 as local.
tipc_update_nametbl() subsequently calls kfree_rcu(), leaving its
binding_node linked on the peer's publ_list.

Once the publication has been freed, withdrawing an adjacent publication
from the same peer can access the stale list entry in list_del_init().
The following KASAN report shows this access in the list validation code:

  BUG: KASAN: slab-use-after-free in __list_del_entry_valid_or_report
  Read of size 8 at addr ffff8880249c7120 by task a.out/9456

  CPU: 0 UID: 0 PID: 9456 Comm: a.out Not tainted
  7.3.0-rc4-00385-ga7bfaba4823e #81 PREEMPT(full)

  Call Trace:
   <IRQ>
   dump_stack_lvl lib/dump_stack.c:122
   print_address_description mm/kasan/report.c:379 [inline]
   print_report mm/kasan/report.c:482
   kasan_report mm/kasan/report.c:597
   __list_del_entry_valid_or_report lib/list_debug.c:62
   __list_del_entry include/linux/list.h:261 [inline]
   list_del_init include/linux/list.h:333 [inline]
   tipc_node_unsubscribe net/tipc/node.c:687
   tipc_update_nametbl net/tipc/name_distr.c:311 [inline]
   tipc_named_rcv net/tipc/name_distr.c:389
   tipc_rcv net/tipc/node.c:2202
   tipc_udp_recv net/tipc/udp_media.c:390
   udp_queue_rcv_one_skb net/ipv4/udp.c:2433
   udp_queue_rcv_skb net/ipv4/udp.c:2472
   udp_unicast_rcv_skb net/ipv4/udp.c:2625
   udp_rcv net/ipv4/udp.c:2697

Reject zero and own-node origin addresses at the start of
tipc_update_nametbl(), before inserting or removing any publication.
Neither value is a valid origin for a peer name-table update, and
in_own_node() covers both cases.

Fixes: 218527fe27ad ("tipc: replace name table service range array with rb tree")
Cc: stable@vger.kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Assisted-by: tencentos-corvus-ai:hy4-preview
Signed-off-by: Jun Yang <junvyyang@tencent.com>
---
v2:
- Explain the distinction between the sending peer and the origin node.
- Correct the Fixes tag to the commit introducing the node-zero wildcard.
- Link to v1: https://lore.kernel.org/netdev/20260731101657.29119-1-juny24602@gmail.com/
- Review: https://lore.kernel.org/netdev/GV1P189MB19887144315DA4A6AF16FE02C6D52@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM/

 net/tipc/name_distr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
index ba4f4906e13b..a496e2e9ef62 100644
--- a/net/tipc/name_distr.c
+++ b/net/tipc/name_distr.c
@@ -286,6 +286,9 @@ static bool tipc_update_nametbl(struct net *net, struct distr_item *i,
 	u32 key = ntohl(i->key);
 	struct tipc_uaddr ua;
 
+	if (in_own_node(net, node))
+		return false;
+
 	/* A peer-advertised binding with lower > upper can never be matched
 	 * or withdrawn and would leak the publication; the local bind path
 	 * rejects such ranges, so reject ranges learned from the network too.
-- 
2.54.0 (Apple Git-157)
