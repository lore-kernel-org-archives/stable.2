Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE745381E95
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608452; cv=none; b=tDNEZBU5v1KbPTh8E5g8A25bD8EVXB57gGQR3EC7mXVWiqUa9nkYHt31NWBpU+jk45UI+sPrHT+u4tUUIVHTlH5zkWiK4nl9KW0o/xHgGgImYLa7iHQWj//TZrrys4YK3X3J2/9tcAkMGx+ApbRv+HSCm5Nv38/F92Y6udq3FAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608452; c=relaxed/simple;
	bh=oB2JJkbrOZkT+N27iXIwCK+Q5Z6H387Wts64+spzjys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fPRExnDaD5E5pspw5q5JYavcabPc18oPOaAR0goeFkKGt3RKbZJpoyUohMANYwMCy+N9swtIgo1wIQdSrCYCO7sFtq8+xAptzNvRynTcLEVU4jHIKXsCY/D1unnj34CLOZdJQdd2KuGee1tNgyEkDB+LorhgPDN+WfxmgvTPNcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QgUA++cw; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgUA++cw"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ca97d139d5fso45599a12.0
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 07:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783608450; x=1784213250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RW6vSA6mnZK5Lr/pJZ9dP1N7NRFIaPvsAxSMgjYokLM=;
        b=QgUA++cwjW+klElTjUOzD/j35hOBhGUYyM8rgW3jrR3bsc/2QtNvvafv6dA2TB6kIZ
         VzwPGi3ibivLHqt/nRFnIsdbj6ZShirGKyRouomzZNVvauSgohLeH/c1GXYBalGhCYQM
         nk3ibSJZh1AQzVR+yQm/xq1I5ObF7ss4ygQ1EldOsfz9QYPrbm6veAruvf+wQdAQgyOb
         snwEHSfzZaiAafMxsgHKJyocAEJJVukKMrgyc6gl2ue6w//C893m3u4DrSqi6TIDnjUP
         vf9DE9cQ72Utaxa9jz/b2NLU4qrDi5+S2HWQtlqIuv+h0IIupE690yWwMGqVqmrAZtvk
         uHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783608450; x=1784213250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RW6vSA6mnZK5Lr/pJZ9dP1N7NRFIaPvsAxSMgjYokLM=;
        b=gnrFlBcwQOK0UNKzShY8aMzNBU3ge8Ior26X465sWLw+zjFmMvlyFzWkClQbvemEG+
         ID4GeNgJpn+U+F1CadTrdNszN2eDY+mkdtp0KWCk2zKmqft9yx2YLo2s5sC0D0clvdFA
         yVmNBRYwRMm6p8WreL4so1Txdg12X3jhILF7+WFl9XcokxPxZvMVrAu7I+cafv/UiVgc
         KBw+zkWyxwiG+1nDJG0Of8sU45QqWcGYyLfQ2ajVtTAFrW3nzwdWLW5+lQ3tGT2Va73y
         AeTL4vPfKx1dLI5B+I+p9v6s24H/DcNt2fzkZG6Ij1ChW3BS1+zWe/Y5tVzlQYtoBz/d
         C9GA==
X-Forwarded-Encrypted: i=1; AHgh+RorrsBx6upuf8ty4BgBPfi7HoOTeEAO1aDLa6RD3Ay3GQ6X6t1wYtfL+Ew+EHqSPIT8ZiL0SZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdEWWbB8xL+ldYX3nuNjUFOY2/7Thl4C8ZdkbF+es2Ln6Ck0vi
	mSV0K2AyFRqibnQOJ2BWJ7az5b2qhA3LpUYLduXiIjjQ5Rim1U/FnLRW
X-Gm-Gg: AfdE7cmgjEOB4J8BhPxn+n9Ww+NrBzhgI6sZ8QvQCZvKnskv5TCIU5lFWir/62wfTlC
	dm7stEkyErXGlULOOqMpR8IIhlOQlnhSsKcfHiZhiZBrXeyiXD7BoGGVw4PnVTBTml/De5Rf2s2
	Fky4bW96jiM3t7fiTdb5BqI56sGaEdNgv4YR7E4mS4pLvnWYEn/qNzqX6J8rTyDW/mBxbAB46Vd
	7WB3KOiSjNp+jmw8I4KohFJGaLXKE9E4D27m6XXKpqvzfT47hP9Z+wGjv3uhYLKnm6dKSJHbPCa
	lmq5Mv6jsKaLoDl+5X3XA/GGWWvV56xZ++CnNEBiuCziRmwT4pJhv0jsLdzkVcAMW66xqPhbe+W
	Wzn3dn60RrAzh0mLNgOp/YjQ6k2BJkKMtCVr2awYfzul59gStjqwxlFhzCUW3LzqbpmmxdG2OeH
	tty+TQkMefOve15rxaADYY4x8e4WMcSF/eaX+yNh/rEzUV2IC1RRAvvE6L7Q==
X-Received: by 2002:a05:6a21:a95:b0:3bf:6c08:fb9d with SMTP id adf61e73a8af0-3c0bcead1b1mr9885193637.49.1783608450224;
        Thu, 09 Jul 2026 07:47:30 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118ee6080dsm18376697eec.17.2026.07.09.07.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 07:47:29 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Xiang Mei <xmei5@asu.edu>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net v3] tipc: fix NULL deref in tipc_lxc_xmit() on node up
Date: Thu,  9 Jul 2026 07:47:19 -0700
Message-ID: <20260709144718.64535-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tipc_named_node_up() builds a bulk of this node's cluster-scope service
bindings for a peer that just came up and sends it with tipc_node_xmit().
Neither step tolerates an empty skb chain: named_distribute() finishes
with buf_msg(skb_peek_tail(list)) to tag the last message, and for a
same-host peer tipc_node_xmit() routes into tipc_lxc_xmit(), which reads
buf_msg(skb_peek(list)). skb_peek*() returns NULL on an empty chain, so
buf_msg(NULL) faults.

The chain is empty in two cases: when cluster_scope itself is empty, and
when named_distribute() bails out on an allocation failure without
queueing any buffer. cluster_scope is legitimately empty during the
window in tipc_net_finalize() between setting the node address, after
which peers can link up and trigger tipc_named_node_up(), and
tipc_nametbl_publish() inserting the first self-binding. A peer linking
in that window crashes the node. It is reachable by an unprivileged
user, who can gain CAP_NET_ADMIN in a private net namespace and drive
TIPC there.

 Oops: general protection fault, probably for non-canonical address
 KASAN: null-ptr-deref in range [0x00000000000000d8-0x00000000000000df]
 RIP: 0010:tipc_lxc_xmit (net/tipc/node.c:1629 net/tipc/msg.h:202)
  tipc_node_xmit (net/tipc/node.c:1718)
  tipc_named_node_up (net/tipc/name_distr.c:222)
  tipc_node_write_unlock (net/tipc/node.c:428)
  tipc_rcv (net/tipc/node.c:2185)
  tipc_l2_rcv_msg (net/tipc/bearer.c:669)

Distribute only when cluster_scope is non-empty, and send only when
named_distribute() actually produced a buffer. An empty bulk carries no
bindings, so not sending it changes nothing. tipc_node_xmit() does not
touch cluster_scope, so move it out of cluster_scope_lock.

Fixes: cad2929dc432 ("tipc: update a binding service via broadcast")
Reported-by: Xiang Mei <xmei5@asu.edu>
Suggested-by: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Assisted-by: Claude:claude-opus-4-8
Cc: stable@vger.kernel.org
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
v3:
 - Guard tipc_node_xmit() with skb_queue_empty(&head) so an empty chain
   from a named_distribute() allocation failure is not sent either, and
   move it out of cluster_scope_lock since it does not use cluster_scope
   (Tung Quang Nguyen).
v2:
 - Guard in tipc_named_node_up() instead of inside named_distribute().
 net/tipc/name_distr.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
index ba4f4906e13b..888a87d769e7 100644
--- a/net/tipc/name_distr.c
+++ b/net/tipc/name_distr.c
@@ -218,9 +218,12 @@ void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
 	spin_unlock_bh(&tn->nametbl_lock);
 
 	read_lock_bh(&nt->cluster_scope_lock);
-	named_distribute(net, &head, dnode, &nt->cluster_scope, seqno);
-	tipc_node_xmit(net, &head, dnode, 0);
+	if (!list_empty(&nt->cluster_scope))
+		named_distribute(net, &head, dnode, &nt->cluster_scope, seqno);
 	read_unlock_bh(&nt->cluster_scope_lock);
+
+	if (!skb_queue_empty(&head))
+		tipc_node_xmit(net, &head, dnode, 0);
 }
 
 /**
-- 
2.43.0

