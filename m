Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793211298;
	b=snhADt2RhF12Wjn1IAWGpF1MeBLS1QQIXErdQyDkeN0teoCsctcFVKImW4kdROy1KC5S
	 9hhbnnTuFubQPLfo4cm3MW2SxjvjtP+xaqsKFtyj2wa27TJAnxjfvuAk5ZbpoNTcIZ3dl
	 bmZGo/p6LZuCqyZt28GKf6MOc80sxLTzIfwGloefbyE0uW98taTMjs8Ah7Sf+9hMWwcWm
	 sgS8aGF0gZItXKGm6E1IfPuq8QwQDfVuwNWDXZMWk6EEMs7UBT3YXBskvomoi2cJDQLwo
	 4ISQ+QRzWpz8KR0sAC5Q7HMftzIAL8IUAbkjSUeJQHiTNyCf2u053QbkF97j5Etznlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793211298;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ORByZDQUFgn0JJEnKfTmOTXNubEmxRahmOuQvTF/0L0=;
	b=q5ZlgIw3lIfzKFfdAlw1Ik00LuBSmLJzvXC7X9UcJs0fg2RDhovdyA7IJY7Y4SxR5rrp
	 b80QVnWZqUeZgXE2jq+OTjHb43ZMKb++t6/paD4X2bcGfTPq7fd3t95JJviDwNAHoHo3/
	 OtruKyplJkHQs1Xe5rbxHoM78K9zDUd45ciyZEu1odCnxGUgpBTr9B3Z2zyJ9AXl7OMxl
	 3mpzROhcmC2fzC+C8ZvKn3xChqpQfO12mvQOvBbkVvwCBtwJ1AqCav3cqD70jNAP/8M9b
	 Vu+YY41h6EtS/E1UYS+u4eAjjOMaiS7UWofwK+qHvo+Ym0rEXs8VXPDSk3UzCBTcPoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e6jEoKv5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10A760A5BDE;
	Wed, 28 Oct 2026 18:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e6jEoKv5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6871F01828;
	Wed, 28 Oct 2026 18:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793211297;
	bh=ORByZDQUFgn0JJEnKfTmOTXNubEmxRahmOuQvTF/0L0=;
	h=From:To:Cc:Subject:Date;
	b=e6jEoKv5aihwlkTjfD/G9eavbW9A8L1euwv8Uc0zriHawl8aZ+coOF9wVDkyD8liK
	 YdRCERmtCBeu1U40bs604IkmoGzeG/ex3tDTSFkOubog3PzY5PIwKb+B6sR/v657dN
	 nFy2+WhGWxk8yqDe+7RDKrm1mHppJZUpn2B7GWMLeHop4+pFvp9yf0Evz5aP84o+ya
	 8SOBQMfXLFJivNwccIHZY5UFpUZkyKLIqqAldiUbb1+5Fs0odqFpspL7xYxbkyWmnJ
	 Un59KKuAdwHL/sJtvyvJOjjK75VPwMGGoeekEa50p1oFYwsYCyRhQR4x7SkgNXreRO
	 G7j7iLZfX5Dfg==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	netdev@vger.kernel.org,
	edumazet@kernel.org,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH net] net/packet: check TX_RING fragments before memory accounting
Date: Wed, 28 Oct 2026 19:14:50 +0100
Message-ID: <20261028181450.2221013-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Zeng <kylebot@openai.com>

tpacket_fill_skb() adds the full non-linear payload length to
skb->truesize and sk_wmem_alloc before checking MAX_SKB_FRAGS. With
PACKET_VNET_HDR, userspace can submit a ring-sized frame even when it
greatly exceeds the device MTU.

A near-INT_MAX frame can saturate sk_wmem_alloc before the fragment
loop rejects it. A subsequent refcount_add(0x40000001) can temporarily
turn REFCOUNT_SATURATED into 1. A concurrent TX completion can then
drop that apparent last reference and free the still-live packet
socket before refcount_warn_saturate() restores the counter.

Check that the remaining payload fits in MAX_SKB_FRAGS pages before
accounting it. Include the initial page offset in the calculation,
and move the existing -EFAULT handling out of the fragment loop.
This preserves the accepted packet sizes and error code while
preventing an invalid frame from injecting an oversized byte charge.

Fixes: 69e3c75f4d54 ("net: TX_RING and packet mmap")
Cc: stable@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Signed-off-by: Kyle Zeng <kylebot@openai.com>
[edumazet: use net_warn_ratelimited() instead of pr_err(), add a Fixes: tag]
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 net/packet/af_packet.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 823e0911c910fa95d85bdf187eddef802cf65726..cf6429f09477263534b631199aae85c30de2fffe 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2655,6 +2655,12 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 	}
 
 	offset = offset_in_page(data);
+	if (unlikely(to_write > MAX_SKB_FRAGS * PAGE_SIZE - offset)) {
+		net_warn_ratelimited("Packet exceed the number of skb frags(%u)\n",
+				     (unsigned int)MAX_SKB_FRAGS);
+		return -EFAULT;
+	}
+
 	len_max = PAGE_SIZE - offset;
 	len = ((to_write > len_max) ? len_max : to_write);
 
@@ -2666,12 +2672,6 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 	while (likely(to_write)) {
 		nr_frags = skb_shinfo(skb)->nr_frags;
 
-		if (unlikely(nr_frags >= MAX_SKB_FRAGS)) {
-			pr_err("Packet exceed the number of skb frags(%u)\n",
-			       (unsigned int)MAX_SKB_FRAGS);
-			return -EFAULT;
-		}
-
 		page = pgv_to_page(data);
 		data += len;
 		flush_dcache_page(page);
-- 
2.53.0

