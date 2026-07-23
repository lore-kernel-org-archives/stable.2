Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A933090D9
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 02:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784772224; cv=none; b=OWPlxZ3bW8k3abqZ7PeZu+Z4/nDHLFs/iKhyGchs2U28mSN63/t+BvhPVRrRSRgWAsuDSmda2xn3xYPnFgWXCr/pgURGhGHchwieHdWlmM5v/kS+RYzQJ5QRXdjttezd8AqDxQhGIlPmQtYuIr81DyDpHzsuYlGVyk7ABsf75sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784772224; c=relaxed/simple;
	bh=DTnsess464JCWX4Jjgs591uOfQLF3+fEsBGSVAKwjCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fMfI/4YpdTNz4HyvvLxEwrQH0SZLqnUT9D0GaLcols2I8zii+lAURHbV3eg5dNIymt5f0s9USdy8PpwWrEQM6wf9BqZgC1idk4ri33SHCe3XKL9QPayd4R6Xs834XJQli7U8DezwfkEAw2F5QYmxpRRRT/Oymo/x+VYZ8ccZxII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=RSu72PHI; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="RSu72PHI"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4728c12ba97so32810f8f.0
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 19:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784772220; x=1785377020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FvT/D4ZKp7hg3WVh9nH1OIb3s4RjytZax6FVHwGekWw=;
        b=RSu72PHIggrhfelExSOh7Yck1oPnI3d+y5rpzIZIU7KA4c8aCbEiH4L3rxESJdjI1N
         zTlr424MfPMl9bSdg3O0dPGg9+TKSEHxahm0/F09c+LoaH8tvvykeGipYzR3ZxrloKLh
         kLW5/9Oo2XHGK1yX/F8avb8meChYnaSqr3vSgmYMwDvXR1xJSR6f1L4QrZUqzuPJTiyC
         2Kercv52zku1+VpTG74Xw5hQnfyUwT/pYu4A+ulMjne5oFPdAbJFKdP5xr6sfDtjdncW
         N7USCV4YvP5ieWV+YcyoBAIR1unuk1l2aUneva8v4QV9iq5MnhSkixSy/Mb5C6AtcBi0
         igng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784772220; x=1785377020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FvT/D4ZKp7hg3WVh9nH1OIb3s4RjytZax6FVHwGekWw=;
        b=doNwXPhPs+3f9jlIRKNyjlWxIF0jMdeSyXDHXujzac+plhS35yfVZeKKFHrIwZSH7o
         YxEo+WCcvPkrWzjznVwm6s4SsxXYBasRJ0aitWolIpBi2MCVAmp3YL5hqSeqx+7jwQSx
         2GDKJ44QBlF+tcG4wrCz6BQzWxXmP8LkK2n/rV8lhs4G/dj1sgQWIz2v/dzv0JBhQ8Dg
         5Wsi2vSIRFW3jAGbkozHCDGILLv/TLkPM8yURgkT6Y4keSrbFlXBpwgjBxbEiDvqFKbM
         tD4vUzmGCsocm7LSWt0wg/cCdiPG0ZJEwfUyHPvnxRAtMkCfZn+0V1ZCVGviv45qQ4U9
         Dm7A==
X-Forwarded-Encrypted: i=1; AHgh+RoiYveTOIM8SBn7OASX1t5oFy+gt8it4jzPUtOWedohmJF8RaCq2QBBbfCByleG3/tDUjoG/ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoDaF0e4e/YOVVsBUJuamIMWgZlTyWvcGM45xftG1WAEIEkufd
	k4qoIE5ZTT0bm2JyHA1o5VL6FZqiEz5aV9loFFMefghdBZQy9UJ6e2g+dWJ79I9znM1e
X-Gm-Gg: AR+sD108I/0rvc4PqoBcC2AQu/L2aK2bpKY3wZEKB8TTyAqMmkX8Jh5ombByMAONqaN
	Ad4mCUnUWgPXrsNPrn+RdBThlOxX1a4vgg3DbEnEmy3GGzYUzqrIXV9Z/rilUpKJJPSXfG7dH/p
	Le1prziQPjFMKSelRX8UxidWvUZglJibPDmGfMBy2KNchN6USfxCiE5aL0sNgKppmYyxIV86TNh
	5qA72btlRSrL2uzjiUo27MtGR4laHoQtuKcRYegaaOImmvyLl5XHLlQUl6s2UqosEZMBD+vIGp9
	x3LSU57K94prWhmcVuzD6IvsFr8YuBZ54JrOxPxz4/DruT7CQwuUu69XQChvonJb/Xxy7w1KATR
	YwoymD4yQbLzfYS2bKbNqOWQx0Yx/r5zn9G+OAwRFeRe5Qq/4ml/Iv+K3IfdL1PPDV41R8MkJWb
	MjlXCaPH9/V5AtLuNoZ+tRFkRfGxVEuaB0aG21z4yOOoSNeDZQzjh4ssu3wJwE2xEOjGvA631fP
	fjixP9qVqCRvvyebjAx/8PE
X-Received: by 2002:a05:6000:2387:b0:47f:6fbd:89eb with SMTP id ffacd0b85a97d-47f8dc936b1mr1300336f8f.57.1784772220232;
        Wed, 22 Jul 2026 19:03:40 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb5a46sm10925157f8f.9.2026.07.22.19.03.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Jul 2026 19:03:39 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Vladimir Oltean <olteanv@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>
Subject: [PATCH net] net/packet: reset the MAC header on the packet-socket transmit path
Date: Thu, 23 Jul 2026 04:03:37 +0200
Message-ID: <20260723020337.19040-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

packet_parse_headers() resets the MAC header only for a SOCK_RAW frame
whose socket did not bind a protocol:

	if ((!skb->protocol || skb->protocol == htons(ETH_P_ALL)) &&
	    sock->type == SOCK_RAW) {
		skb_reset_mac_header(skb);
		skb->protocol = dev_parse_header_protocol(skb);
	}

Every other outgoing packet-socket frame therefore reaches
ndo_start_xmit() with the MAC header unset: a SOCK_RAW socket bound to a
specific protocol (for example socket(AF_PACKET, SOCK_RAW,
htons(ETH_P_IP))), any SOCK_DGRAM frame (its header is built by
dev_hard_header(), which does not set mac_header), and the legacy
SOCK_PACKET path. A driver that reads eth_hdr(skb) on transmit then
dereferences skb->head + (u16)~0, an out-of-bounds access about 64 KiB
past the head.

This is the same class fixed for one consumer in commit f5089008f90c
("macsec: do not read an unset MAC header in macsec_encrypt()"); other
TX .xmit paths that read eth_hdr(skb)->h_dest (several DSA taggers,
ibmveth, sja1105, the atlantic PTP path) have the same problem.

packet_parse_headers() runs only on the transmit path
(packet_sendmsg_spkt(), tpacket_fill_skb(), packet_snd()), and there
skb->data is the start of the L2 header for every packet-socket type.
Reset the MAC header unconditionally so it is anchored for all of them,
fixing the class at the source rather than hardening each consumer.

The protocol probe is unchanged. A CONFIG_DEBUG_NET build stops warning
about an unset mac header in skb_mac_header() on these paths, and the
out-of-bounds eth_hdr() read no longer occurs.

Found by 0sec (https://0sec.ai) using automated source analysis;
verified against source and matched to the macsec KASAN report in
f5089008f90c. Compile-tested.

Fixes: 75c65772c3d1 ("net/packet: Ask driver for protocol if not provided by user")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:multi-model
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
This supersedes the per-consumer series "[PATCH net 0/3] net: dont read
an unset MAC header on the raw/qdisc-bypass TX path"
(https://lore.kernel.org/netdev/20260713194010.54642-1-doruk@0sec.ai/),
per Jakubs suggestion to fix the problem at the source rather than
hardening each driver.  Vladimir Oltean had reviewed 2/3 of that series;
this is a different (source) fix, so I have not carried the tags.
 net/packet/af_packet.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index e75d2932475a..adfb9c19a3ca 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1924,11 +1924,21 @@ static void packet_parse_headers(struct sk_buff *skb, struct socket *sock)
 {
 	int depth;
 
+	/*
+	 * packet_parse_headers() runs only on the transmit path
+	 * (packet_sendmsg_spkt(), tpacket_fill_skb(), packet_snd()), where
+	 * skb->data is the start of the L2 header for every packet-socket
+	 * type: SOCK_RAW and SOCK_PACKET carry a user-supplied header and
+	 * SOCK_DGRAM has one built by dev_hard_header(). Anchor the MAC
+	 * header for all of them so a frame does not reach ndo_start_xmit()
+	 * with the MAC header unset, where a driver reading eth_hdr(skb) on
+	 * TX would dereference an out-of-bounds offset (skb->head + (u16)~0).
+	 */
+	skb_reset_mac_header(skb);
+
 	if ((!skb->protocol || skb->protocol == htons(ETH_P_ALL)) &&
-	    sock->type == SOCK_RAW) {
-		skb_reset_mac_header(skb);
+	    sock->type == SOCK_RAW)
 		skb->protocol = dev_parse_header_protocol(skb);
-	}
 
 	/* Move network header to the right position for VLAN tagged packets */
 	if (likely(skb->dev->type == ARPHRD_ETHER) &&
-- 
2.43.0

