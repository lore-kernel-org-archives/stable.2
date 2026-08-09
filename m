Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366B14B04AC
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 00:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786236490; cv=none; b=UrH0/iKvWPzFHU+WF5q9KImocgdFuN2bofTJyiO8evqYb3vMJ0DEYc5nJ6Z2mAzmy4jfNh2Yv8eNrbcaw7gP2wj1qJfDCBkPxEBEukZPtARyEPlUEHcAFT51hGdDHrdb6tL3OOTnk+3aqcTnuCHfHM5UbdNqJug4dd79H+CzBMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786236490; c=relaxed/simple;
	bh=AjqNszwSLwvIaa1qbkypbZxijuNvRMie8ohfFz0DZdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pht+8WNTZo3wDTbYj9zfiMuJTNM/K1u/ST51V+QOtYjzAd4X3k+DfBZA+99Our/3laYiSo4ZjrFzwYfljsBNHg7uqUDVjx3s2qerHxBpcmZ+2uo/1AuiHfIuBtpjPlDVDztI9EgWHG8DwvMMc9IS8ePKnznLSoCeq/SMH0nXr+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmsGBD2j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmsGBD2j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353761F00A3A;
	Sun,  9 Aug 2026 00:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786236488;
	bh=qCvGGU8r3tQTpc6XG/ellFv6zHKsETBJxcXxzkWYffo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PmsGBD2jBTzlSKpfBXJuxrY15n6cpmtUnnkzH/RUt1p6haNlRmtnMHzGMQoP4IAJY
	 s9zCZXnsyz70VoQkB+iUBLqMSPhUE3UPw8YdLYZqZR1vQkpEsTP1wmzJKTqv7GMuPx
	 j0PxIwXL9/nMuW58s0WGzaNt3En3PydqHbp3RluiDgQ8FlXWqzoxHzJXuPOgyIFvUk
	 re1w2bvbflnz0n2NduIthlNvAJGcFRjhg5eUdzcbMp6fiXZYufbNUcRj7mcOE/mKLM
	 3UHUBpVyCXJYRy70eujes+RjFaLF8u4EKUEnkxNoW81SV6oQEUZTrwVrnmBYisbmNi
	 t4km/2dAQcw9w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shiming Cheng <shiming.cheng@mediatek.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] net: gro: fix double aggregation of flush-marked skbs
Date: Sat,  8 Aug 2026 20:48:06 -0400
Message-ID: <20260809004806.874246-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072948-essence-that-baf6@gregkh>
References: <2026072948-essence-that-baf6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shiming Cheng <shiming.cheng@mediatek.com>

[ Upstream commit e751256486d0ded20f5a9f9863467f1dce65142f ]

Commit 0ab03f353d36 ("net-gro: Fix GRO flush when receiving a GSO
packet.") added a flush check to skb_gro_receive(), but
skb_gro_receive_list() lacks the same validation.

As a result, packets marked with NAPI_GRO_CB(skb)->flush may still be
re-aggregated.

This allows already-GRO'd packets with existing frag_list to be
re-aggregated into a new GRO session, corrupting the frag_list chain
structure. When skb_segment() attempts to unpack these malformed packets,
it encounters invalid state and triggers a kernel panic.

Scenario (Tethering/Device forwarding):
  1. Driver: Generated aggregated packet P1 via LRO with frag_list
  2. Dev A: Receives aggregated fraglist packet and flush flag set
  3. Dev A: Re-enters GRO, skb_gro_receive_list() is called
  4. Missing flush check allows re-aggregation despite flush flag
  5. Frag_list chain becomes corrupted (loops or dangling refs)
  6. Dev B: TX path calls skb_segment(), crashes on corrupted frag_list

Root cause in skb_segment():
  The check at line ~4891:
    if (hsize <= 0 && i >= nfrags && skb_headlen(list_skb) &&
        (skb_headlen(list_skb) == len || sg)) {

  When frag_list is corrupted by double aggregation, when list_skb is
  a NULL pointer from skb->next, skb_headlen(list_skb) dereference
  NULL/corrupted pointers occurs.

Call Trace:
 skb_headlen(NULL skb)
 skb_segment
 tcp_gso_segment
 tcp4_gso_segment
 inet_gso_segment
 skb_mac_gso_segment
 __skb_gso_segment
 skb_gso_segment
 validate_xmit_skb
 validate_xmit_skb_list
 sch_direct_xmit
 qdisc_restart
 __qdisc_run
 qdisc_run
 net_tx_action

Fix: Add NAPI_GRO_CB(skb)->flush validation to the early-return check in
skb_gro_receive_list(), matching the defensive programming pattern of
skb_gro_receive().

Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
Cc: stable@vger.kernel.org
Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20260709014704.3625-1-shiming.cheng@mediatek.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/skbuff.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 90a63c356affb..47931360ab424 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3830,7 +3830,9 @@ EXPORT_SYMBOL_GPL(skb_segment_list);
 
 int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
 {
-	if (unlikely(p->len + skb->len >= 65536))
+	/* make sure to check flush flag and to not merge */
+	if (unlikely(p->len + skb->len >= 65536 ||
+		     NAPI_GRO_CB(skb)->flush))
 		return -E2BIG;
 
 	if (NAPI_GRO_CB(p)->last == p)
-- 
2.53.0

