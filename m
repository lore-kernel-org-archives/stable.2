Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050026;
	b=dLss5MtsKrSZNW3wHfZg/rwzgFnTJGfrNOH4jSmxo3RIM3OssaRWMNUek+Ox3zVkLBPN
	 CzfFuG6cKOD/4K1qUCu63gL0EenzaC4q6e5v1pUn4e/VySvpGfgV+Cgasx6V9bHPG4RT4
	 YGGFalMVAvLxF4a9CyFytFECHOQASInJ5QudS3M4Dm4fCTF3U0UyddtIc/9X/v5oZo4fL
	 Kz6EBxdbAoLmAWeaF1KV5olHJoeesVZ7HmyxqQi5K5Gt/0WSKkNAvw/poVGPK8kEENBt/
	 95ZwyHjdDj/689tiwoZq9RqkObptcIH+nHxJDgAQYDDU8GuLzl/pilUjKeZqtzg5ovw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050026;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=tnIKuJY8i53Zchc494OMwbTY47hUu5Vu+QsUzww30b4=;
	b=alMw4hLcSfRgXMv67RaVo6WaS7A2W18ER3iqO+AsKp2NCL1nCviuo+RoOAxjfEirpcNZ
	 vNNaUODicJBbK9SqvcSfjxuAlDgiNBErvIhAroHUs9IHA73/49arYLOFS48/KXRig/UR+
	 a3laMBVRRIOdDOsa++pg7HKuaSdQ5ac56edhJUjOOVVqN4TC4AHi7M/L1cjwwknY2mJWQ
	 CglQqLONn40W4H+Fhfp7O9DldeNObhllAGb5vpZb3DlkTbM08IxvJurmspknUPfBzPZGf
	 +xsxewG205UYfZjmSR3y0AwTHdUAM5yDqdyxOqRzQmR28WhpletjEpLFgEG8LnKGUYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dGkSxQt4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35559606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dGkSxQt4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6348D1F0089F;
	Sat,  7 Nov 2026 11:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050026;
	bh=tnIKuJY8i53Zchc494OMwbTY47hUu5Vu+QsUzww30b4=;
	h=From:To:Cc:Subject:Date;
	b=dGkSxQt4w4+xaudE3NMEBMHNngJ9DdXW8YJRQkLM/KW0dJ9YKO+8rmLTMfizAMoJ4
	 FKeEa/OEQz5amKjxyRGFjKWqykenj6elwfmOERaI2ykheOCfe48/N17JqmFFFxK4IW
	 p2TC6JlGe4Q2SYsfiFkITvfH3Hxa08IW9CHepRV/7GPyDH05nhsS/oKzJEohM67dK4
	 Rsg5EsVjNri/6/hlGoSG34YpBCK/qQ8hyzL4v1fo4pOE/mrw7U9PKAOHzpG+xXz/D8
	 xp3dwO9yr2Yu6snz1Asa05OpsBydCSz7BT5sE1Ou3TP8xGoOezH9jvzUjypf86B90P
	 fwilhrD+KyTQg==
From: Sasha Levin <sashal@kernel.org>
To: kylebot@openai.com,
	willemdebruijn.kernel@gmail.com,
	edumazet@kernel.org,
	willemb@google.com,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] net/packet: check TX_RING fragments before memory accounting" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:13:44 -0500
Message-ID: <20261107061343-failed-5.15-dc4dd12f80e4@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x dc4dd12f80e499dc034710cd8195489abcf0b059
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061343-failed-5.15-dc4dd12f80e4@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




