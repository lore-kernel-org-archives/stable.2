Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794051049;
	b=pNiryfq7xWmuIFOnt5FGAUs+b7A2SQNDElCC05ktElyiKkzcYtCc8YJGCtArqaxTMn+F
	 jj1Kcc70PxblKEL9EZMZ0YGY4suD5BZFxcZOkiTL4XfrHApHJ7nzqcoNASvOAdDkI7t11
	 KlBgXxl1Z4P95nRCC9XRR4Qq971FO0pyxC0opQiQ4LrmXMxHuO2h505rC8b5rIjuznUVA
	 kdSsvWqr27d1Y78dcHONZc3rpP2ExLHyth0g9cs+WfAR8DUF6XF5j7XpKlJDVpa7d2SzX
	 xAUN56/nXkQvJRE9rx6DXGeRzd00MPDUQlctepJInd1/N7y4Ovx5Um6woGqqdl1EX8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794051049;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pW4F9PU1+q9Vbfbk66Z3n6Due4zYm5mR+ipCdchNWe4=;
	b=e0fansaYpOHTl4LfMly3lRTYrtApeHBKo+f6Y4fDOwLsojvJaemC8q54A6EJ8ocNex1v
	 rGdeJIOFi48SNVSusVEwpDmIJiPoB+EKVBgGWcrp61Xx8PDOsSRNI3RxzcN1I9gzKaejA
	 KiYh/i3Yxs5e91e26UFUziA0SSx5L2w0qwccGdcwdxHwqasOFukxgEJSvqORsr43sLgjf
	 Gnl18EQhO2bHMjYSp268doWjMYlK1en1k9wU8ATQUXkokvQGY3s7U7ewQ9EQodSAgAaAC
	 bUtJnUz/OahEsgSnW5fd6f+AOySJEXLk5eM1vbr5EZFevbgJ+cRPGWxkZ7Jy3M0j4jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ADCJTWoC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39940606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ADCJTWoC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205341F0089F;
	Sat,  7 Nov 2026 11:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794051048;
	bh=pW4F9PU1+q9Vbfbk66Z3n6Due4zYm5mR+ipCdchNWe4=;
	h=From:To:Cc:Subject:Date;
	b=ADCJTWoCI0hC6OMDIdIGQIgW8nRJEwGvOfi4ubF0VvD6hLsomoUMe3lLwX7xCCxP/
	 pjZ/OmOV+sIlxrgiGiE351Vetr8TuqxkpWucelKhAyBZq4ItgRhY/HzF91aj4VkM+g
	 m5p1FSg3YPDaShZGrOwwKr9ZRSv1Ih1DeVAsK0v9RQ3GGmzfDL5FwycLsgCTtRG1VY
	 rX+wQ7RWH3RepodM5odqQcIYkbgRt1MvOpfxb6JCkitd9bSnLNnTBrJf2ICYPiCJo9
	 1SV92O7PP68vZfL0Uq+nJolOgB2MsFuMpNn/oTXBdQLE11MSqRA0KHBH+8S9U8B7e7
	 6jGy1oqGaKBZw==
From: Sasha Levin <sashal@kernel.org>
To: kylebot@openai.com,
	willemdebruijn.kernel@gmail.com,
	edumazet@kernel.org,
	willemb@google.com,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] net/packet: check TX_RING fragments before memory accounting" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:30:46 -0500
Message-ID: <20261107063046-failed-5.10-dc4dd12f80e4@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x dc4dd12f80e499dc034710cd8195489abcf0b059
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107063046-failed-5.10-dc4dd12f80e4@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From dc4dd12f80e499dc034710cd8195489abcf0b059 Mon Sep 17 00:00:00 2001
From: Kyle Zeng <kylebot@openai.com>
Date: Wed, 28 Oct 2026 19:14:50 +0100
Subject: [PATCH] net/packet: check TX_RING fragments before memory accounting

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
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20261028181450.2221013-1-edumazet@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/packet/af_packet.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 823e0911c910f..cf6429f094772 100644
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




