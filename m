Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F419043901F
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 14:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784904025; cv=none; b=g2xMeFDQpFW/6fNsll1poDb2kbYgPwx/yjEVm9joDuXp/PBhiLcqsQk3JCuknniYffVoKUidffUxqnkUvpD41v1hZl1/JhGyjjXDuPidVlP9csKdWhnyoSX27NGyu2273kjnmNBxg+1Z/PGf9Z31LxOQaiQFqhCFPKuJDj7y4tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784904025; c=relaxed/simple;
	bh=mzAPWt8soLl40BP3UVn1bPfxB2aX0IzIYgTnaePaoH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LwV4quTW2X+cXbK1lFUDbp+KmV0u0j6Mi/PeVXSVQ+PQ9ryVodDh+2owQXVMgfr0ViJCNXOvJVs4tRtGnUGPZ2uOrLsUPUKQR0bw13s2w9to4+ZUIlFcAuUJPoRtTUDf9zWrpo5SyGZA0ikVIPMNKEZFXgx0AfDvTlpphZkYd6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=UyW9P6QD; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="UyW9P6QD"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4728c12ba97so384408f8f.0
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 07:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784904018; x=1785508818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UbbC2Y6GHLQJ7n62pK5uoFXAcOP/lzhNIQdsV3PuKPU=;
        b=UyW9P6QDnw+zUsVZiSoACZqHeyoVPUqW6o0nNoKkoG29Ps9mygtRcmR3b6sa5ul1Xd
         yC/kelHbWXO/2+SvKXPLXcgxYQCun+W2q72WpTsP45CQpsvSdEtuOfSF1XFxSho31scn
         qltrS3vI28A8wnAif9NR5ktJkuueET5BIpioHsNSPMwvoipXzaZh5TeI5xUDAEfQE16U
         XmTkDEw3/VuaKck0/Ki4t/zZ8XF+T+3ySG6qhwO8jo/+1EtcCNdR3jkonKTfVEMHBO2Q
         UX2XEysWlGOuizrmrfvYfj6u48k9jyFZl7QrQmB8doEB5J5XkVGRKXo6ayP9ZmFbGDdb
         fIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784904018; x=1785508818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UbbC2Y6GHLQJ7n62pK5uoFXAcOP/lzhNIQdsV3PuKPU=;
        b=Ak5gZMnEN1E58VBPQ4kOM+qJDMXz85P0X3B4RKXvzAquak8WpM7+zA9F5E4EB8gImk
         w5NYZtKsA9xRpC1mjptrIAqib9kETAz8opt8YmucKKBRqXSvpyWCvo9M+jivx2mDUq09
         Qdw+ILTYFHyXKZXS8xvBQQdbiYsg5g5N7jOpa0FsLBgUS2j4a6py2fQ7xZPuZWhjhegH
         H0uBEbcJPkEacJJxjmpqta0Lbw1oSQ4IoNQ0PVYl0MH2f4yBF6bNeS/44itZKlEHEu9l
         bgUS47WLn3QNax/AoerwMz4fbXPLP1AYBYEheYPGQ0sitVhrkUBUoCM1r/6/ZkNgXQXf
         BAwg==
X-Forwarded-Encrypted: i=1; AHgh+RrBXUYbN+amg1gVCR0NAh4fzO+hZJT81tKTSNblkWQO1Xz2jdaT9wCew6EYd7wUtALXEi0/3N4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBmO2bTNjUUdoglj/xCJCQOkYdC9VMko4IBFYLUKvXEa61iaED
	O6NYcwVTG+VUdyqtat3O5j1/NJ4wWIXi5trqtBVo/1Tm5ZWf0Op9dmF7TWBsrNRNi7V1
X-Gm-Gg: AR+sD13dPK7Bm3akJ+8TW+pmPcPr6wpWJXL1ezv9AU7ihGgIrmD97cDIU0u352GM8tO
	l1fyczDthGpW7Y1kdOp6xQcFrLqdM3ueKEcbWFLZY2CqJY2IX5vNFdaPhNzq5apc38vyaFV9QUs
	xMiiW2Qz2CpNM3dQJciH5UVchEqSMHivjVuqd6MmU19OgtqG+o4wgOsN3q4zUznKNfc2XIOZ3U+
	TPXKKQnDNfRzdvt9IgSCXiNafHA/g9nMRJJYE1aUNwmCjA/1BaRB3QGZkF4R6KWQUurDpO3QBBk
	9CnFvd4b0ezJGdlCtDKlkaPB2+gIdm2wmeV1m5MNwNeUSlhQCEekH7R0e/C/l2jZbUtnEyqMBtH
	BxsQ/b9XpR4WSto5ahp0rzJ1TwIykEAhkVPLAb+6vlYUBYUapLEmYsHheJQEqMj28QQw/7vlUsB
	2uykH9oEI3nP6zbBE8qGu4Oqocl9dimKb5I5DTjQwrywZSsYpbnI+uEMLDn05KGWOLGpePsDDgs
	JFXf1Q7r2Q3nJNMhFuBU3k33QEaeDpHebBc
X-Received: by 2002:a5d:64c8:0:b0:47f:91f0:983 with SMTP id ffacd0b85a97d-47f91f00a4emr8582170f8f.41.1784904017859;
        Fri, 24 Jul 2026 07:40:17 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.219.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c6f076sm25276279f8f.34.2026.07.24.07.40.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Jul 2026 07:40:17 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	sd@queasysnail.net,
	Vladimir Oltean <olteanv@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] net/packet: reset the MAC header on the packet-socket transmit path
Date: Fri, 24 Jul 2026 16:40:15 +0200
Message-ID: <20260724144015.63219-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

packet_parse_headers() resets the MAC header only for a SOCK_RAW frame
whose socket did not bind a protocol. A protocol-bound SOCK_RAW socket,
any SOCK_DGRAM frame, and the legacy SOCK_PACKET path therefore leave
skb->mac_header unset here.

For frames sent via __dev_queue_xmit() this is harmless: it resets the
MAC header unconditionally. But the packet-socket PACKET_QDISC_BYPASS
path uses dev_direct_xmit(), which does not, so the frame reaches
ndo_start_xmit() with the MAC header unset. A driver that reads
eth_hdr(skb) on transmit then dereferences skb->head + (u16)~0, an
out-of-bounds access ~64 KiB past the head -- the same class fixed for
one consumer in commit f5089008f90c ("macsec: do not read an unset MAC
header in macsec_encrypt()").

packet_parse_headers() runs only on the transmit path, where skb->data
points at the start of the L2 header for every packet-socket type
regardless of its length: SOCK_RAW and SOCK_PACKET carry a user-supplied
header and SOCK_DGRAM has one built by dev_hard_header(). Reset the MAC
header unconditionally, mirroring __dev_queue_xmit(), so the frame is
anchored on the bypass path too.

Found by 0sec (https://0sec.ai) using automated source analysis;
verified against source and matched to the macsec KASAN report in
f5089008f90c. Compile-tested.

Fixes: 75c65772c3d1 ("net/packet: Ask driver for protocol if not provided by user")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:multi-model
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
v2: address Willem de Bruijn's review -- clarify that __dev_queue_xmit()
    already resets so only the dev_direct_xmit()/PACKET_QDISC_BYPASS path
    is affected; note skb->data is the L2 start for all packet-socket TX
    types regardless of L2 length; move the explanatory comment out of the
    code into the commit log (kept one terse line).
 net/packet/af_packet.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index e75d2932475a..5ae0511e89e3 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1924,11 +1924,12 @@ static void packet_parse_headers(struct sk_buff *skb, struct socket *sock)
 {
 	int depth;
 
+	/* On TX skb->data is the L2 header; anchor it for all socket types. */
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

