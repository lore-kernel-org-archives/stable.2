Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFC1359A6F
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 19:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971623; cv=none; b=U4nefG6bZqQCeHLdfj6/4McyRvWAyJez9N6puCb+FKeimNqt2aaA6kx9g1sO4xoNpgpCmgbJK5LgaNsQQBY8++xalAq1RAQLrGpSgVL/c4IIEcGxwzVgsbj8apQAJqnBXX7zugakKK3fFzqFfaPSzHkW/3cQ4Nc5ieK2Ng/bLq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971623; c=relaxed/simple;
	bh=ZElYX+gf59pRPgluKzpGvx9WiCEsZq+Swc8cluTkDzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=li4jwEahM5uUuLxRu1maCaKdpid2sw9IZ37wWPedDwz0rKzNt+39l1Qx9hYbJ8ccMqoo5EoPCYmnBaPHLbG00nbLG55vGcVbkXZkGlJ69/Y719K5+e8RvYNtDcM/1rXfv/dhJBoH4uQ7IdDg4JhASljuYj8Y9kvmV6e22VMVn2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=ZEka/sdd; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="ZEka/sdd"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4798bea72f9so1916343f8f.1
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 12:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783971618; x=1784576418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Anq+ZgEfX5t6X9Q7TePAbPIwtsyngsq62Z1m8/YM/k=;
        b=ZEka/sddEpto7RUMFCIQb5azkrkfoCdYr8etYSkVMWZO4ISCu/iad8n56x1S3UkYt7
         XpNtEycCBk0zqhZUN8/F4j8Q+gleArHpn8qeMlXD6G55tv73Yt7JZcg5Y+4AiJ5Imydu
         yhTc0xH4X0s4HZK7NOph4LgugRFZ0eCK2hk2cR5qA8yqzVNwpJ2VTgDpWswdoC4DwrZe
         7Jvn4MuqaMmjuqwveOJiuZbv1MTGRHm4iiAuIttR9wVV4gx1DveX7VerssR79FE7USfT
         ivHn4PH/Yt4RQGEf0GdB/hQ/jDHWNfL3EOfCX9HaWKEp4tvffW2fmOxelNeZA+EV+Gjj
         OQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971618; x=1784576418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2Anq+ZgEfX5t6X9Q7TePAbPIwtsyngsq62Z1m8/YM/k=;
        b=lc8MHTdfMv136sMfqAJ5Tciki/74ZbFUaZlSaiANlitge0/inZNwbtIkae5Z6BYMKy
         X5k0jKZGQGbFusZkLTbYkMn50ojER6AsIAf6pypgzRDV9FGuwEv+7SPFctSyBERyBVH3
         PA22m9vQ8Bnt7q7U52din7MBVRKasYb54xuftTdnetfJWQnrFo+4PoxiTNyohb+JAWwH
         /whV6o/N9OMIEbb4vxdiz9hSQ/WG7rkV0hiFeMHsWZufqIrKI9GMpbqxWEEkdu7D8YQS
         ZZ4F5hwvyFBkOotbUHMdT2brs/WQ2BsftNoi7+2HBftpmkwu0HXVcdQelzIR4nqsXYxe
         3tww==
X-Forwarded-Encrypted: i=1; AHgh+RpZhehYS4tBCWHp3O922RNZ5tohMCrE/gGXxC+r7VEo0o7UcuWUjLJQLvJVJMwbv5B9QDN6+yg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJIjoMuQsN3F1V8K7onFxGygmOs4hYeLRdTLUoeaP/wa4rkSLn
	As13YOYQh7Gx7/pWL6KY3HlsWdN8dXPxvRRAfYitq/roOfpnaViOAMbErekLpkRG1Seh
X-Gm-Gg: AfdE7cnThs7Pr6On8ldKJBN7bM3SVmmqL+IUlkInnbTi48a1Wdydy1A3SOWrzN1Iylp
	drKUXgh/ZxGmPpR+xjAFkhm5Qoaw0Ezi6JgOmNcnxI5af/QMdaUgV2K7VQ22g8aEP35aoLuI2Ca
	U9U82eepHvVtA0TCpEaRjN4xyO7ii50J8duM/ef1eXijdT5GileJFUVqT6RjgClMieYzxU1Q3ij
	lECQPiCjR3yuoXknHPAY/AYjV0i55GBegM3kwuG2KvjXlEKqIc9uttXEflgtmtIuOrTKiGA1wUK
	9udfEqXV3B1tMO/DVPoLOm2/6HoMaAdkxWk4i3igZ8ROc9n6vGMFbzk92M+naNUBkPwh6SSmQYR
	58ZI1d6cAG/AqytxfCayS0Fy91n9oDh9LNbFpghzYg9pkYOqo3PjyiUzNxPklisnQaLTD0R12yG
	opMUIK87BWqgRFxf9YFz9h3smSxhYq3DEzJ1aEV0QPDNBX8s3+OIKlfPVXsECUYYGR8upqT+TGn
	Bik5ejy3jv1Yo/dlwYQX/hp651u4mX4Qltvs550TFGexw==
X-Received: by 2002:a05:6000:2908:b0:46d:9871:1a44 with SMTP id ffacd0b85a97d-47f2dcc5c1amr11070214f8f.32.1783971617968;
        Mon, 13 Jul 2026 12:40:17 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c4320sm1648928f8f.32.2026.07.13.12.40.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 12:40:17 -0700 (PDT)
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
Subject: [PATCH net 2/3] net: dsa: tag_ksz: don't read an unset MAC header in lan937x_xmit()
Date: Mon, 13 Jul 2026 21:40:09 +0200
Message-ID: <20260713194010.54642-3-doruk@0sec.ai>
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

lan937x_xmit() reads the Ethernet header via eth_hdr(skb) to test the
destination address. The sibling xmit paths in this file (ksz8795_xmit,
ksz9477_xmit, ksz9893_xmit) already use skb_eth_hdr(); lan937x_xmit() is
the lone hold-out.

On the AF_PACKET SOCK_RAW + PACKET_QDISC_BYPASS transmit path the skb
reaches ndo_start_xmit() with the MAC header unset, so eth_hdr(skb)
resolves to skb->head + (u16)~0 and the read is out of bounds.

On the TX path the L2 header is at skb->data, so use skb_eth_hdr(), as
done for the same class by
commit f5089008f90c ("macsec: don't read an unset MAC header in macsec_encrypt()")
and commit 96cc4b69581d ("macvlan: do not assume mac_header is set in macvlan_broadcast()").

Fixes: 092f875131dc ("net: dsa: tag_ksz: add tag handling for Microchip LAN937x")
Cc: stable@vger.kernel.org
Found by 0sec automated security-research tooling (https://0sec.ai).
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 net/dsa/tag_ksz.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
index 67fa89f102e0..4f74336ae396 100644
--- a/net/dsa/tag_ksz.c
+++ b/net/dsa/tag_ksz.c
@@ -430,7 +430,7 @@ static struct sk_buff *lan937x_xmit(struct sk_buff *skb,
 	u16 queue_mapping = skb_get_queue_mapping(skb);
 	u8 prio = netdev_txq_to_tc(dev, queue_mapping);
 	struct dsa_port *dp = dsa_user_to_port(dev);
-	const struct ethhdr *hdr = eth_hdr(skb);
+	const struct ethhdr *hdr = skb_eth_hdr(skb);
 	__be16 *tag;
 	u16 val;
 
-- 
2.43.0

