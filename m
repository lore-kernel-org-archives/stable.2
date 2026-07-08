Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240D93438A2
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783532016; cv=none; b=qHBI11eLZXiwPu6LrQf4QpjSM0UK3oUcYDn4+3G7+hqq+G0BklnnvGQauW7shU2OGI/snudTM4vBU4H2eTdJAzogFLkPXxC1na4PIPYXQKJ1nA3TDFWfJJf2ucQKtQ6ja/x962lvm2fqcxYkmchK1yPf52bMLza0OlIKdReIocc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783532016; c=relaxed/simple;
	bh=2TMhGFAcZdr+dnyC+i9/GTenfE85ePdYEmpPlVabXk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JekH/YzqABdbRNXwKBQHFwTN7soY3nVE1VBkEqWuAVUBP4yV9aFCHBNY7b++lhzG/4eqAcjrJ/C1Ajv1bY8Ai2xgREaOhlKaXg4HvbNSBNy0fgnsfTlk+232QjGsOkPxwXXfROKi6P/peP0D+rzgjpjXQvtxmcErOYW3FMX2DzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/l0A+Q2; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/l0A+Q2"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-ca2fad0ae38so658765a12.3
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 10:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783532014; x=1784136814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bc5YeSbJRmHy6yiZUOFHLCE8fvktQKlisrn95zQ65go=;
        b=X/l0A+Q2tODhJwqT/nXoBfB6QDugd1RViFDqMuNmRxTVhgy3s+FrWonIepJlH77qkE
         /siiceBHQFiamTIO0+s9BAGXN9sL40M/kMQ9Txw1BXJURpoTubgPPRrnVxNjsZ9rpGjN
         FCUj6MF82zOC6936To0Q2zwymfGJtTUHp+QNhwZpS0sFivawIE0QXxja1ENq4F34PQYb
         OZNKmsvHHiDaxAFMCUhXBsEpua0uXYjjk2LCKQpBqpHWMlrnSkkVZhRoBPaMYpicvDAB
         QhsMJdQv1PzSVgeyAg6KWflgGiYqxuXLnI88fIRUKRcVlm7m//bAmcJhZu0oxJ6FOvak
         LKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783532014; x=1784136814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bc5YeSbJRmHy6yiZUOFHLCE8fvktQKlisrn95zQ65go=;
        b=BscYQYO00LkOJuBUEfRycbrW6VJdmQtTeZ0vnQ7lsDCJgVFEHd/m2B2n3VYJmbHLPR
         0v6yUY6bPYjWGmKUmHhjEAMSjzqqeExnsgymuOElpAbfVhaspH5/HWjBC3sp1QMQvFJr
         k1Gac6c4Hw+gzOC+82asVL1ZzPM7TG8bmBI0mCitLBSxTlnfIkAKbiHnbnbaBcU5+nAM
         qK9RpuAZcGRgieNK2n3wlU/34XTdv7YuCSxN2IoezcKgqySPhccRHdxvfrXSsk79FnJ0
         i9c1owvmtvnob+kkzg7ZR/cast0g5FzoO2BEgzLvpVsRy23GglI15gOpxDoV2qLGKW24
         7jfQ==
X-Forwarded-Encrypted: i=1; AHgh+Roe2PoWh4dK3bMVF1+5M1JjuDctU8i010i7lV+mB5RCkHfdodc7o6MECXZXeKhA3yqYm/lLqHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzt4cNenNrQnSJW7PESvSADhAVQ9jzN+AFl7uW8Dmv3qHdeAbL
	6mld0lmks3BIV5II3dDXNH1GTP2w4CY4bTkE0NCr6jikigFQ2kifgLKT
X-Gm-Gg: AfdE7cmwpofOtcAeXITl2p4VB7KiO6jfnw3PjKMJrfu2wNMeyjs1lVi4Kc4pBbSjU5A
	WH7EDZbly6mZfoEdN346rztXNhFFFtdKW2ScY/BhZP52CwoY/KoLF31fD3LbiaDUFxzbh/EALHt
	FI6ifRyz0ds7hcJkQdYATZtuCOgbKkO9AbIRfuEk8zH94lDrNhJHz4aNVQol0u9hsRbq3zr8hIo
	5y3nCrSdk3X5Q9lze7212/sMW2Fwhjhxve7TlCdzKLiuCWnikuF0MN54kZYESlk0+H0r343oKOj
	Fvxg+roLkx7LXJmCKfrRzcGfxoyYByvtpso4WskfvnsbOHgbxV7HhcXzIkRVBnfr/iKgCagB6Fq
	KQMD1EEUe82//azpmJjgEEit+u7Vwd5DtGIlCEmxuj6XVS0u5NrJrTg9GnQMUULHs40xSrjZQqx
	aJLvBaKFVQkR7CBLqDw80mWosLFxNz1H62N1QwYAclJ2qZnraZi+Tizb4YGw==
X-Received: by 2002:a05:6a20:d491:b0:3b4:81b4:9b79 with SMTP id adf61e73a8af0-3c0bd219f9dmr4323068637.40.1783532014366;
        Wed, 08 Jul 2026 10:33:34 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b65960d88sm19063773c88.6.2026.07.08.10.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 10:33:33 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
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
Subject: [PATCH net] tipc: fix NULL deref in tipc_lxc_xmit() on node up
Date: Wed,  8 Jul 2026 10:30:54 -0700
Message-ID: <20260708173052.2973990-3-bestswngs@gmail.com>
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
When cluster_scope is empty the bulk is an empty skb chain, and both
consumers dereference the head unconditionally: named_distribute() reads
buf_msg(skb_peek_tail(list)) to tag the last message, and for a same-host
peer tipc_node_xmit() routes into tipc_lxc_xmit(), which reads
buf_msg(skb_peek(list)). skb_peek*() returns NULL on an empty chain, so
buf_msg(NULL) faults.

cluster_scope is legitimately empty during the window in
tipc_net_finalize() between setting the node address, after which peers
can link up and trigger tipc_named_node_up(), and tipc_nametbl_publish()
inserting the first self-binding. A peer linking in that window crashes
the node. It is reachable by an unprivileged user, who can gain
CAP_NET_ADMIN in a private net namespace and drive TIPC there.

 Oops: general protection fault, probably for non-canonical address
 KASAN: null-ptr-deref in range [0x00000000000000d8-0x00000000000000df]
 RIP: 0010:tipc_lxc_xmit (net/tipc/node.c:1629 net/tipc/msg.h:202)
  tipc_node_xmit (net/tipc/node.c:1718)
  tipc_named_node_up (net/tipc/name_distr.c:222)
  tipc_node_write_unlock (net/tipc/node.c:428)
  tipc_rcv (net/tipc/node.c:2185)
  tipc_l2_rcv_msg (net/tipc/bearer.c:669)

Skip the distribution when cluster_scope is empty; an empty bulk carries
no bindings, so not sending it changes nothing.

Fixes: cad2929dc432 ("tipc: update a binding service via broadcast")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8
Cc: stable@vger.kernel.org
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/tipc/name_distr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
index ba4f4906e13b..495e46defddb 100644
--- a/net/tipc/name_distr.c
+++ b/net/tipc/name_distr.c
@@ -218,8 +218,10 @@ void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
 	spin_unlock_bh(&tn->nametbl_lock);
 
 	read_lock_bh(&nt->cluster_scope_lock);
-	named_distribute(net, &head, dnode, &nt->cluster_scope, seqno);
-	tipc_node_xmit(net, &head, dnode, 0);
+	if (!list_empty(&nt->cluster_scope)) {
+		named_distribute(net, &head, dnode, &nt->cluster_scope, seqno);
+		tipc_node_xmit(net, &head, dnode, 0);
+	}
 	read_unlock_bh(&nt->cluster_scope_lock);
 }
 
-- 
2.43.0

