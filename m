Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0718D359A66
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 19:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971620; cv=none; b=IP5eXATmDQA1lj12WtXpQ9owKmL5JZPIIRexOfsM0mdIGY9tLrWUVoeMLbSiXU723u3V1LPrrwv71k3HmkwRmkfz77770uFH7rRh/66XVu2KDha0+jqq2143dzGwoVRU73/cKx/eo8iz66FCEg9c13h7igk5gBlac+cc1PhjF88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971620; c=relaxed/simple;
	bh=cBBAAXVfz2OnPP835VfCEgjtcsAJ50plKAqlklYzeK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FyTVPOnDXv20qhNVBaLvNv60C++acsgGOTXTdOKcqR1Y2yg6sTv2oowT6Zc+iB2TJIIAC4ZsDRXgazscIfpr/NkfA5YA//PjLC4kdN2UMGYWWiiBos2WXPNRASFy2qMe0M/9b3Zek664WNBUsb6Y3TveSplnZlRZwBouYFx9Ffc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=opSmBt1X; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="opSmBt1X"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47f3b39f2a1so124897f8f.2
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 12:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783971616; x=1784576416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W7xWVihr3+KHFM8BLDbVBGdvZbVrj2tho5cLk2/xNCU=;
        b=opSmBt1Xu67tnrgXx4jSRAZ8V/f84TSLZnBd+blsRbLHN7Ou9g3lDzDCj5TZUvX9l1
         6ljneaAw+WN/RJ+VvBzT4JJNAB59PhzqXhF5jP/O7ZZBSi7jZr82DdwZWEdoNQxOSkzD
         FROF1/tRenpwUClBPQmXlhNRT1WblHAkw7tPz95LjqshEykIkktGuhlVJcxKvt7vTppb
         IHZeoVD/DVLeSdQoLdWsOc7vh+R59UelE3+veBuvL70ozgNC3C5jQKkZuHzhyVqYVqmC
         H7ItH46lNAThPG0+3yhK7QYHEwPAnZAA/ONf58lG4ETGD03pkkZvy2yT/7E5pEmDvaYw
         W4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971616; x=1784576416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W7xWVihr3+KHFM8BLDbVBGdvZbVrj2tho5cLk2/xNCU=;
        b=WhWSq13b30g48FyUZ9gAfebO4CArXzd8fKzw66/8SYkhjN7IybgFCADcGA/XOepPjL
         Lw0cjbFq/z6mYVnqisp099XcqsPEuyWp6nzlJ4Mzj0nkcrAMpC51bePvesS5Iixco5td
         L7kfJuwG2yI9rqXBFidnmX3T7GqKePIB0GyaBGTVCfoPhwGpRwv1i3InSElCWhdwJI/+
         dKlEKA0Gu3SK4bcAg8lt9bECLJ1dOhHausVpbYYnN6/GnXsdWLHUAIV6tBg6SeKCetyS
         +CcW648RfZQF8Qu7xFs4FbLF0IzDWgfUdkuh44TiTNvrs6ng0erMCv8r5xxGdvtAqtip
         333A==
X-Forwarded-Encrypted: i=1; AHgh+Ro8G2V+rlypq90EEBHkx4Drw0SyxRZ/4VZdavAAyFd7FPSNk9rWwAwNqKHU7sRGfdxRHa1ay/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdprrGjj0BxbujkCuMSd8YTG393t4a5uvOgzCbHiIBINtMhZ23
	fHmsBaWE4nj43t3dQ0PpMcgQ33Dr6MkBw9QXCFxf7OYoXcvuyrvs5fLYSBeKUecInW6/
X-Gm-Gg: AfdE7cmD8dK1Uytc4P1ix7ofd9USnNn/gyKHfiTv49J56JR2rGR4hA4LleAADbtlk9g
	/X/qSMSpXF9KV8uccYu0ZQSICjSLpSwXju/3lDq3x3vfIY3s2TClfVMvxBUIyGj+0EBJWLZzLNH
	hz/FMXzsMIAvDm4C6UhAxnBK3RXRZ11+DZTrZXiv0+DOJuwyDXwdFZSWgf7+NgocEb5E+vo9Ml3
	FEzxwaia3Dy8TT/9maChN771NOtL64BzG3XxmGrAuBZ0R3eLyRxJbPEOSc1scek4BH8RUSrZVqk
	4ltn07foNJVhJShDeTVQ3IUyIAd4euFP7PIkGkuSdwimISwhesm32d39Ve09w/TJNPgFVsNXus+
	m1Re/nmxQQtPd2eGuYFJot0f9TTf+VUPQEnua/6nBZ9AISYouD2ZpUv8fSm2Bag3eY0GFmRYzvA
	iL5qRxKlKJ7D1IM3wLBNHWIObR6gFAcQgbxz9fnqp8xpwyJUX/WRrb9vAjin2pn+X9zila7tcY3
	w1wl0EZPIVmfUpXP+e0RPa7H1U7jNfFlFo=
X-Received: by 2002:a05:6000:24c2:b0:477:6da:1b83 with SMTP id ffacd0b85a97d-47f2dcc8ab8mr11941321f8f.24.1783971616139;
        Mon, 13 Jul 2026 12:40:16 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c4320sm1648928f8f.32.2026.07.13.12.40.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 12:40:15 -0700 (PDT)
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
Subject: [PATCH net 1/3] net: dsa: tag_ocelot_8021q: don't read an unset MAC header on transmit
Date: Mon, 13 Jul 2026 21:40:08 +0200
Message-ID: <20260713194010.54642-2-doruk@0sec.ai>
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

ocelot_xmit() reads the Ethernet header via eth_hdr(skb) to test the
destination address against the link-local range.

On the AF_PACKET SOCK_RAW + PACKET_QDISC_BYPASS transmit path the skb
reaches ndo_start_xmit() with the MAC header unset, so eth_hdr(skb)
resolves to skb->head + (u16)~0 and the read is out of bounds.

On the TX path the L2 header is at skb->data, so use skb_eth_hdr(), as
done for the same class by
commit f5089008f90c ("macsec: don't read an unset MAC header in macsec_encrypt()")
and commit 96cc4b69581d ("macvlan: do not assume mac_header is set in macvlan_broadcast()").

Fixes: 43ba33b4f143 ("net: dsa: tag_ocelot_8021q: fix inability to inject STP BPDUs into BLOCKING ports")
Cc: stable@vger.kernel.org
Found by 0sec automated security-research tooling (https://0sec.ai).
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 net/dsa/tag_ocelot_8021q.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/dsa/tag_ocelot_8021q.c b/net/dsa/tag_ocelot_8021q.c
index f50f1cd83f16..4514026897d1 100644
--- a/net/dsa/tag_ocelot_8021q.c
+++ b/net/dsa/tag_ocelot_8021q.c
@@ -71,7 +71,7 @@ static struct sk_buff *ocelot_xmit(struct sk_buff *skb,
 	u16 queue_mapping = skb_get_queue_mapping(skb);
 	u8 pcp = netdev_txq_to_tc(netdev, queue_mapping);
 	u16 tx_vid = dsa_tag_8021q_standalone_vid(dp);
-	struct ethhdr *hdr = eth_hdr(skb);
+	struct ethhdr *hdr = skb_eth_hdr(skb);
 
 	if (ocelot_ptp_rew_op(skb) || is_link_local_ether_addr(hdr->h_dest))
 		return ocelot_defer_xmit(dp, skb);
-- 
2.43.0

