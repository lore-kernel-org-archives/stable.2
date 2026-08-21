Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A88731194C
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 14:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787323784; cv=none; b=LfSpyVI5oD2/5arN4nS3bwwYJ6NgReSFG4TQ/bVUZv0qbdY21qjGCgJjnGq0LX5zecz1yFQ74sE62bRZ3RU3kBQdELVjLQxtLi9gW9Cbxsb9LrecltMPvtlJdm63rXZhRPzouqPwixkD0Sx8U6jOZ/gZiGzhhNIan/K24yC75JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787323784; c=relaxed/simple;
	bh=Nv6f7fsOIcWSaNDeZrXF87r+eyttkgIxD8Nr7ZgtlN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UVY4+svJ/6p3bf9l7uTEfIKr3Zoiey4boA9rcWCuLfp9WbkzkUdyxDnFHuXnwjNYQ04WsxphuRioKeEui53vEGgeqjwOm468HOm98lw66UOURtOp9ACbXwvt5R/XGbr7PaoWRZGF370EznfxXjGfFI5fut2k9olHEkioOb/X1Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMwsVcB8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMwsVcB8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB231F000E9;
	Fri, 21 Aug 2026 14:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787323782;
	bh=bCGKdP37AhNVRXqOALnTvU4ODq08BbJag5Ayphdqi0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PMwsVcB8rIRmE15d1c2bVcQtxFLCIcKncp92w+nzJtVKKBCTnTpuoiSuW/xLpHZ++
	 dc23pFQKMSv7mQCQW5CxludMJk1PTypG2+ePgvyO/r+xxDNyJS/XJrCtWbkIGCntYM
	 s6Z6pCceUp4Bc063oZ3Rv/D7Cd+aVrHfnzGLoWvI9GEIh0/h575iZzQHjxYeQPrOsT
	 v5yplwS/4qAWUJIsWtDt8GTxMWGn/YeQrDkWbqGIegNBdDxZHbEWxcTBTbtk80XNHm
	 WzZEwB/ogaB475ZwD7bUJEy8oZL+4xg/XH7d3M8phPqD4zN/1Z8hTBNUhDpfXrOHjb
	 NBjkJVrLBnLiA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] net/packet: convert po->pressure to an atomic flag
Date: Fri, 21 Aug 2026 10:49:39 -0400
Message-ID: <20260821144940.3429010-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081734-marrow-captive-bde1@gregkh>
References: <2026081734-marrow-captive-bde1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 791a3e9f1a86fe8eb09173c9788493b8b5c957f4 ]

Not only this removes some READ_ONCE()/WRITE_ONCE(),
this also removes one integer.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 1a35da325cac ("packet: synchronize pressure clearing with ring reconfiguration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/packet/af_packet.c | 14 ++++++++------
 net/packet/internal.h  |  2 +-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 64843368bf10a..0738fef357350 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1358,22 +1358,23 @@ static int __packet_rcv_has_room(const struct packet_sock *po,
 
 static int packet_rcv_has_room(struct packet_sock *po, struct sk_buff *skb)
 {
-	int pressure, ret;
+	bool pressure;
+	int ret;
 
 	ret = __packet_rcv_has_room(po, skb);
 	pressure = ret != ROOM_NORMAL;
 
-	if (READ_ONCE(po->pressure) != pressure)
-		WRITE_ONCE(po->pressure, pressure);
+	if (packet_sock_flag(po, PACKET_SOCK_PRESSURE) != pressure)
+		packet_sock_flag_set(po, PACKET_SOCK_PRESSURE, pressure);
 
 	return ret;
 }
 
 static void packet_rcv_try_clear_pressure(struct packet_sock *po)
 {
-	if (READ_ONCE(po->pressure) &&
+	if (packet_sock_flag(po, PACKET_SOCK_PRESSURE) &&
 	    __packet_rcv_has_room(po, NULL) == ROOM_NORMAL)
-		WRITE_ONCE(po->pressure,  0);
+		packet_sock_flag_set(po, PACKET_SOCK_PRESSURE, false);
 }
 
 static void packet_sock_destruct(struct sock *sk)
@@ -1462,7 +1463,8 @@ static unsigned int fanout_demux_rollover(struct packet_fanout *f,
 	i = j = min_t(int, po->rollover->sock, num - 1);
 	do {
 		po_next = pkt_sk(rcu_dereference(f->arr[i]));
-		if (po_next != po_skip && !READ_ONCE(po_next->pressure) &&
+		if (po_next != po_skip &&
+		    !packet_sock_flag(po_next, PACKET_SOCK_PRESSURE) &&
 		    packet_rcv_has_room(po_next, skb) == ROOM_NORMAL) {
 			if (i != j)
 				po->rollover->sock = i;
diff --git a/net/packet/internal.h b/net/packet/internal.h
index 9e50bf06131f2..9097fb5d7f2e2 100644
--- a/net/packet/internal.h
+++ b/net/packet/internal.h
@@ -117,7 +117,6 @@ struct packet_sock {
 	spinlock_t		bind_lock;
 	struct mutex		pg_vec_lock;
 	unsigned long		flags;
-	int			pressure;
 	int			ifindex;	/* bound device		*/
 	__be16			num;
 	struct packet_rollover	*rollover;
@@ -146,6 +145,7 @@ enum packet_sock_flags {
 	PACKET_SOCK_TP_LOSS,
 	PACKET_SOCK_HAS_VNET_HDR,
 	PACKET_SOCK_RUNNING,
+	PACKET_SOCK_PRESSURE,
 };
 
 static inline void packet_sock_flag_set(struct packet_sock *po,
-- 
2.53.0

