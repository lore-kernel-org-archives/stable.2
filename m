Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EC035AC3B
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 19:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971625; cv=none; b=VRoZ59kZxEwQ/YvPCTE2ifByAFIlP/BEcvH656Ik03hl6giS+Yi3axeuooL2eM+4/BXS6LAkxz+/TtNLxl/VzhkhuT7+1PVhKCXAGTKP+x72fY3KWhv+byUWKot/myYXMTClL1Rc8T5wD9YbZH6O6Sr7il3KfnlO3a3mFrt5xYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971625; c=relaxed/simple;
	bh=Qb2HIoMSqWqjQCWpGfmBQN/eCpG6jcj8qiqVtJGiIdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pUCMLV8rXabt+u4AWjE8zMxe259C7WcX4Ds9PUEIsy6xHv49iWYTn8lAS27on3NdgxgipuSsISA7itoRYex/ssPw3KwBXFfRJw4hvNSGSSQ0O+OZ/SW9wnS8JFqNQwREVYcJBClsiE6xtAXw6qjXPCwZhV8j6+pZkjRS72GnbWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=Rt0Okg/R; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="Rt0Okg/R"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4703bc0a99aso2006684f8f.3
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 12:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783971620; x=1784576420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8SE6mH/eebwrYuJdjdXRg/YfI81pgkyA3KxLJxVspBM=;
        b=Rt0Okg/R7m2LYzMem/ylCjKCEzz69c8dLbMOcZti5wRcXsg1ktmSA7lar8vT1POltc
         eA/DCf7sMTam6DmzQZ/uEG2ycSY6mvUcI4pFSQ0BCat8nNIZKSEZDAYqO29MgEKL7meO
         1jCh+8ortx6Q5Z4RMUuxOsoyX4yl5iHU+ST0bVip6L2s+VseD+vroJwrM0SVba7N1hlP
         Y2g6GRcfneRw45jJH8hU29kg2YDHdPXmIqHdMnSCLSZlvXHPuhDbTWFG33wlqeLNGhUI
         fmt9B2yuuAk74yNuvkCKFGFWNVYwvqsoQTr098cRgvM8Ilcb9jQsQCXblbI6Bj2EnJm9
         grrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971620; x=1784576420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8SE6mH/eebwrYuJdjdXRg/YfI81pgkyA3KxLJxVspBM=;
        b=mFe8nXMQrCiceCoLxyVjNLB1pkbVjTAZY4BA/c8ZbSSHKQ8wPqO6ysw2uiIUDai1OX
         XFYkKKF8SF+lQTLq2XdI3YS6H5I88JZCuHUW56iZ4Br+qQwGJ/Z3OZsdh0rqrZFrnyQD
         Y1IuyS0KmZFsRukzWBU/aBfkKTcQKfkIJpH4EETkNUxxVvpshX2YMv4bzWbkqO+QbdYy
         V+UxgtD1RtHyTYB1bRuTPynv1Ce+sr3wDRNZWrmJ2QAmNGVlCiW11c9UmX3pvipmCutO
         iz/klwP5fpYWUuLGOMtbu3ZtssR0ABHxn9TioKDQZh0RDPPEn+Tq5fIwLUiZHFVY5IGy
         6Gig==
X-Forwarded-Encrypted: i=1; AHgh+RpCpQR6AEKQUm2H9kayP+fBRiFycyAFD753/Z2A2oYFqzvgkGQB2WPHeRI+JSSS58OcO6SIjNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YywX8XoVxi+WiYvU12PanDrDQHZgsZTvCF+WFjBxqQ2WZZ4Ue0N
	TBTgb+4Ff9Gx30KfM54NvQV/a3ILhxcPOe4A98kHMKEVJ30fSMUOIVExZv7BpfC5W9/v
X-Gm-Gg: AfdE7clWMzrZUPp/5FDjujuPKzs6x+NgElBuPex1zig+dpdD4JmKoZvDc5JV9cGBWpr
	qKnUVX1JXE/wCloFtZ0E8f93OIXOG2cNjz9Jt80+rClXllHjJ6hjfGHgMha6N8cg4tuwizWlyG8
	ZlONNRVasgKvZi/9zb5X8BGHK9xjwyRJP6tDaEal6nV1VM7xPAhhIitLNir/Cxydi5QoRFSXu8a
	tz4UaW0Wp6clXik7dao5VDazFkmCamfIP5jrw7yXFIaSJFOjWVj/co96JN0hIoYjZpnhQZ5wfdq
	ZFu9356mcoErL73EdOA39W/rfyJ505ivRg9qf2fzBoz1afpout2b09C3HvvCCeLxlr8u653k06i
	urP7wC35Q6Jy5C0LxsZt+NYeFZ5pgbihj4rQdUnATbw3ktpO9+NWgqwn1g0nCILN/4w7Hzh7VtV
	mi3Z4ItCkB8Q306CwtcTFAi8yp3yz7gst0mUheIdFjDXkd8Sr6Yq7z72JzS79IFv2hAtNiEb5TS
	AxLZE5SWZgR6p+puVibKLsMKxiUKUKLaAk=
X-Received: by 2002:a5d:5846:0:b0:474:9002:c74a with SMTP id ffacd0b85a97d-47f2dced169mr11560342f8f.35.1783971619960;
        Mon, 13 Jul 2026 12:40:19 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c4320sm1648928f8f.32.2026.07.13.12.40.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 12:40:19 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Nick Child <nnac123@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Sabrina Dubroca <sd@queasysnail.net>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Michael Ellerman <mpe@ellerman.id.au>,
	Doruk Tan Ozturk <doruk@0sec.ai>,
	stable@vger.kernel.org
Subject: [PATCH net 3/3] ibmveth: don't read an unset MAC header on transmit
Date: Mon, 13 Jul 2026 21:40:10 +0200
Message-ID: <20260713194010.54642-4-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713194010.54642-1-doruk@0sec.ai>
References: <20260713194010.54642-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ibmveth_is_packet_unsupported(), called from ibmveth_start_xmit(), reads
the Ethernet header via eth_hdr(skb) to test the destination address.

On the AF_PACKET SOCK_RAW + PACKET_QDISC_BYPASS transmit path the skb
reaches ndo_start_xmit() with the MAC header unset, so eth_hdr(skb)
resolves to skb->head + (u16)~0 and the read is out of bounds.

On the TX path the L2 header is at skb->data, so use skb_eth_hdr(), as
done for the same class by
commit f5089008f90c ("macsec: don't read an unset MAC header in macsec_encrypt()")
and commit 96cc4b69581d ("macvlan: do not assume mac_header is set in macvlan_broadcast()").

Fixes: 6f2275433a2f ("ibmveth: Detect unsupported packets before sending to the hypervisor")
Cc: stable@vger.kernel.org
Found by 0sec automated security-research tooling (https://0sec.ai).
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/net/ethernet/ibm/ibmveth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 73e051d26b9d..88e8bdfbcd11 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1218,7 +1218,7 @@ static int ibmveth_is_packet_unsupported(struct sk_buff *skb,
 	struct ethhdr *ether_header;
 	int ret = 0;
 
-	ether_header = eth_hdr(skb);
+	ether_header = skb_eth_hdr(skb);
 
 	if (ether_addr_equal(ether_header->h_dest, netdev->dev_addr)) {
 		netdev_dbg(netdev, "veth doesn't support loopback packets, dropping packet.\n");
-- 
2.43.0

