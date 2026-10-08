Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9A838D018;
	Thu,  8 Oct 2026 13:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791464511; cv=none; b=eNhUY9u+5YUGZ2zEZ1y7JvbqzX2po/n1yJ3+Dx45oxd4omH5+kGK9VLDTsUPzSfj/wKHNnHWvokYe3x+QbtT7sqScrxyAiLa1DbXOINRMjKL6U2q8FXRxnYCO2RARjHYz7NH5vZR50levl+gqTJnPC3UCRCDuVg4sPb4xDbLjJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791464511; c=relaxed/simple;
	bh=pQXgvySZ4SftRLNh7hbaGp27IwCJx7wRA/j3migIGPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rObmrJ6HlyYuRjSq/WeJO3a8/qeWX9CuVxy/uiQY2CUQnqU6+o1cUV9XKtObWzE+KD+y1ZqZia9i+g/K2+o512J8a2JoBkd6Q+kDXC8qLR9YwuDOnX64FT+yPhXInZivsKKxhGL7VbUN2/eGXc3RQ6udAqgKclu2gHi6s3J9NG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=anWftESa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="anWftESa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC021F000FF;
	Thu,  8 Oct 2026 13:01:48 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=anWftESa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1791464503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PViysCj3TS3/bb0+VlDNRrWk/TVuL8mGUTONJgYwkOk=;
	b=anWftESa5D2HHokp4HhaNxwJ39Mjk1H+N9aKLcJ3ARbezPDCn2rsaK6507LyMpmKjS5S2m
	foWHvnLzCXwqSWU5qrSqfg9bT98fUfR86kjzUNIx0kXE1vA8SqS43E2GW44kgq/+EMX0qF
	5/46qg5lsBnHEhIUnJ137CJfrjuVvIw=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id 888186a6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Oct 2026 13:01:43 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Ramses de Norre <ramses@well-founded.dev>,
	stable@vger.kernel.org,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net 2/3] wireguard: queueing: preserve tstamp_type when encapsulating packet
Date: Thu,  8 Oct 2026 14:59:15 +0200
Message-ID: <20261008130124.724119-3-Jason@zx2c4.com>
In-Reply-To: <20261008130124.724119-1-Jason@zx2c4.com>
References: <20261008130124.724119-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ramses de Norre <ramses@well-founded.dev>

Sending traffic through a wireguard tunnel on a host using the fq
qdisc fills the log with:

  fq: likely mono tstamp with tstamp_type 0

An skb carries a timestamp in skb->tstamp and, separately, a
skb->tstamp_type field recording which clock that timestamp came from.
The two have to agree.

When wireguard encapsulates a packet it calls wg_reset_packet(), which
clears the fields that must not leak from the inner packet into the
tunnel packet. It does so in two steps:

  skb_scrub_packet(skb, true);
  memset(&skb->headers, 0, sizeof(skb->headers));

skb_scrub_packet() deliberately keeps skb->tstamp when it holds a
monotonic timestamp: that value is the time the packet is scheduled to
be sent, and the qdisc still needs it. The memset then zeroes
skb->tstamp_type, because that field sits inside the headers group
while skb->tstamp does not. The packet therefore leaves wireguard
carrying a monotonic timestamp labelled as a realtime one.

Nothing noticed until commit c4f796c4f16b ("net_sched: sch_fq: convert
skb->tstamp if not monotonic"): fq used to assume every timestamp was
monotonic. It now consults tstamp_type, spots the mismatch, warns, and
falls back to treating the value as monotonic. Pacing still ends up
correct, so the log spam is the actual problem.

Save tstamp_type before the memset and restore it when encapsulating,
next to the hash fields that are already carried over this way. When
decapsulating it stays zeroed, which is right: an incoming packet's
timestamp is a realtime receive timestamp.

Fixes: d98d58a00261 ("net: Set skb->mono_delivery_time and clear it after sch_handle_ingress()")
Signed-off-by: Ramses de Norre <ramses@well-founded.dev>
Reviewed-by: Toke Høiland-Jørgensen <toke@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/net/wireguard/queueing.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireguard/queueing.h b/drivers/net/wireguard/queueing.h
index 79b6d70de236..663b19b78395 100644
--- a/drivers/net/wireguard/queueing.h
+++ b/drivers/net/wireguard/queueing.h
@@ -78,12 +78,14 @@ static inline void wg_reset_packet(struct sk_buff *skb, bool encapsulating)
 	u8 l4_hash = skb->l4_hash;
 	u8 sw_hash = skb->sw_hash;
 	u32 hash = skb->hash;
+	u8 tstamp_type = skb->tstamp_type;
 	skb_scrub_packet(skb, true);
 	memset(&skb->headers, 0, sizeof(skb->headers));
 	if (encapsulating) {
 		skb->l4_hash = l4_hash;
 		skb->sw_hash = sw_hash;
 		skb->hash = hash;
+		skb->tstamp_type = tstamp_type;
 	}
 	skb->queue_mapping = 0;
 	skb->nohdr = 0;
-- 
2.56.0

