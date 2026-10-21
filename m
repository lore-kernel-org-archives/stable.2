Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792548225;
	b=g/ChgI2b+E/wkPjZ5G2RnQ160HsQrunUJ64J7Ik5Wxqdp67sMt9B77e3AxY7LzfV2M4B
	 00ur3qnaU1or1StGUkVvqKVX81ZxaNZEhfiy+mezRRsQ1q2kfijzCen00AkpvCUYKre0c
	 DtAlc00YrT0yZijEBC9W1ICqIrKfEtdcmgtSrRemyY0cQKeLVQsjyLBT7gd9Ywyg6obPI
	 oz+g+USJvsjj4FqiEZY5FhhO9xEfHLKV9tSmJ2w1G2PL0nEh2HNApkPekfamXlsyD9ylf
	 zj6tN4FvUt2c1wc+xTemgY9ak8wAa0SHC9aDx8jtX45JKMPtJAM1EBJ5ojRd2Mhttag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792548225;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=leSND+5gisN5Md9k6LWpzUNyWGXK/I4NhOs2RkfudTI=;
	b=Au0TLpWQElfa6TbQ5DIxDfepy/l2kwnipoWwm+zE1UDH7Of1axMc60XbD1lq56onT98f
	 SI3kU+3LFgs/V99c4eSqyKFVHrTL+ewyEL17/EiblQeb5T4T6iaZ7Q3fRuoBUAP2FRBwe
	 Vf8gpzlh1C8nQyixHheBIjDC6kLhWOom0Fd8vvt6nqzz4qAEJzoGqeknp1zTD2qEawMxv
	 30tJdfpxfBnxX27ncv9HGUqdwCNviJ8sl/2vx4hZyaM1lSourWTCTVlo+0qvG/KfxcF2a
	 tcUqVV6okrD3lSiIyRtfEtrxNpqNFrBzQhZYKaCSSUtWTl/ho5krGmESn7pWtYXiGkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gt.tech.gov.sg;
	spf=pass smtp.mailfrom=gt.tech.gov.sg;
	dkim=pass header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.a=rsa-sha256 header.s=google header.b=KyhcQuTT;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E35606A31B
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 02:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29E35606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.a=rsa-sha256 header.s=google header.b=KyhcQuTT
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3a4b3ac8fb7so132299a91.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 19:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gt.tech.gov.sg; s=google; t=1792548224; x=1793153024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=leSND+5gisN5Md9k6LWpzUNyWGXK/I4NhOs2RkfudTI=;
        b=KyhcQuTTzpKqbvaknksf7utJsW06DxxLx4QaDlffYH4qt+I/ETuSR2uThYMvmk1veb
         5oxIgT6jmJiE5b6tNj+sNcOQmBF9p0UT55GNErw3tlvsQVtD+txBcJA93+T/YT+HIhEP
         jkbyvCZGDqcw29GFSQD1rx3XkNXqwrdi4MJSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792548224; x=1793153024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=leSND+5gisN5Md9k6LWpzUNyWGXK/I4NhOs2RkfudTI=;
        b=SYtDfmKPGOJNcRlEH8V3PuWnzCyak88nF3X4atcvPpByrfZGYE4rGfG9IsySBlkvsK
         wGP6UUYOAPPbhWfrlkL0/9QiaB/vDkv0yvkIdEYcxm+EbgE4GKMRx1X2JipkZTnAUUHt
         8I0/EVZz5dAoFK9IHmA/Mj0juijtrVJJStMokDIhZssm9gwnHI/3MmVNcqAe359tHcGQ
         Ehms/MiA01dCyb9cejnNa1NNI1gr4HcTr78mMBGFBIJuFIBTymH1vcbf15uMnufO2jTt
         zJD3uR6FM9PYG1/Fb9vzvumT0ktSH1jZ6deQ7toinNOVojnyG3nqNcb2YFPwcxqA6Xix
         0wWQ==
X-Forwarded-Encrypted: i=1; AKwUvBwr6t8uo8ugP0ujYaIENzFrWE5xF0rCC9TDmt6buLR7JE63PwyNgEqHbatRq6V1Kx7BtwRSFdE=@vger.kernel.org
X-Gm-Message-State: AFq9FYK24WjIQaCq/kKY1KKBiQ93XMi3cfJYcTtsRSF6kslDGZdQNa3W
	HzxC7VzeXbOGq9BrJ4s230EBrsjHoPBdYWtJoYyE9I8M2+fNbnBR7CarZTPeVR3Fa/KYlfS1Ny4
	OFV29
X-Gm-Gg: AYBFou1QEw7TbuRP4OLNFiUeEVb5L6UUx73S9uslUbibeLbipSwFfwW7Bu3dS8Vi5td
	DomNP6CB6mo0cL+YtxEhRqcRuzO58MD7ByQjLFOIi/6EW6aLrF+g28fPqYwNLv0dfPh45zmUcgd
	YtFimFRv/1b6TkLFFJs9bqv57R5YXU2SAaQaHmR0hwrT1UC9feMQgx6o5Cp7+KDjgSQN+r5ugr4
	GQyFsYd/5gYOt0rg2msCzp4FyAaV2gnoJspgmG1eHqdxcccGyi4Nbsa4ilP8RTYlUhC06obk0p2
	ZW96Tt2XnnHt0UjGPICsQdYlD89mkmPJJ5ZipiXjcwOS/LpRluXgA6NcQrdyZfY7NhKM7Flu7oU
	ZgbRQ59RrjlL8HUyRZt1HhmttcRnfCIS0MP3D7mQ36KAnx40B/kczXABJvfXNSGX78PkJcLjxbo
	L4XBYyfVjOmGKS1OVcwORYaonETrsjbR+wrSONWOlucw/okX+PDKs9AWCEGgZ0GQlV2kaDtex97
	RHpHXK3N1nL0lAOdy5fKqV5dTrWiwirlE9/nMPBe0CtjhJgFW4zb1CdgXiTdBjHItfR+HizBDlk
	0ermuoDH8A==
X-Received: by 2002:a17:90b:4b11:b0:3ac:83c1:2c0 with SMTP id 98e67ed59e1d1-3ad86cdda5cmr529688a91.64.1792548224392;
        Tue, 20 Oct 2026 19:03:44 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain ([203.125.131.137])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad8035a117sm1934124a91.16.2026.10.20.19.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:03:44 -0700 (PDT)
From: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
To: Petko Manolov <petkan@nucleusys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wei Jie Law <98lawweijie@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/2] net: usb: pegasus: do not advance rx_skb->data on dropped frames
Date: Wed, 21 Oct 2026 10:03:09 +0800
Message-ID: <20261021020310.34045-2-law.wei.jie@gt.tech.gov.sg>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021020310.34045-1-law.wei.jie@gt.tech.gov.sg>
References: <20261021020310.34045-1-law.wei.jie@gt.tech.gov.sg>
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

For the 0x8513 chip, read_bulk_callback() skips the 2-byte receive
header by advancing pegasus->rx_skb->data in place. This is done before
the pkt_len > PEGASUS_MTU check, and when that check drops the frame
the goon path resubmits the same skb with the advanced rx_skb->data as
the transfer buffer, still PEGASUS_MTU bytes long.

Every frame with an oversized length field therefore moves the receive
buffer two more bytes towards the end of the skb data area. A device
that keeps sending such frames makes the host controller write received
data over skb_shared_info and past the end of the allocation, and the
corrupted skb_shared_info is used when the skb is eventually freed.
With an emulated device sending frames filled with 0x5a on a KASAN
kernel:

  BUG: KASAN: slab-out-of-bounds in dummy_timer+0xade/0x3f00 [dummy_hcd]
  Write of size 1536 at addr ffff888105821202 by task swapper/1/0
  ...
  Oops: general protection fault, probably for non-canonical address 0xeb4b474b4b4b4b4c: 0000 [#1] PREEMPT SMP KASAN NOPTI
  KASAN: maybe wild-memory-access in range [0x5a5a5a5a5a5a5a60-0x5a5a5a5a5a5a5a67]
  RIP: 0010:skb_release_data+0x36f/0x800

Only skip the header with skb_reserve() once the frame is going to be
passed up, so the receive buffer always starts at the beginning of the
skb data area. Unlike the old pointer adjustment, skb_reserve() also
moves skb->tail, so the two header bytes now count against the buffer
size: lower the length limit for the 0x8513 accordingly, otherwise a
pkt_len of PEGASUS_MTU - 1 or PEGASUS_MTU would trip skb_over_panic().

Found by code review with LLM assistance and reproduced with an
emulated USB device (raw-gadget + dummy_hcd).

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
---
 drivers/net/usb/pegasus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/pegasus.c b/drivers/net/usb/pegasus.c
index aba1a640fc26..7c7d6b69998f 100644
--- a/drivers/net/usb/pegasus.c
+++ b/drivers/net/usb/pegasus.c
@@ -461,6 +461,7 @@ static void read_bulk_callback(struct urb *urb)
 	u8 *buf = urb->transfer_buffer;
 	int rx_status, count = urb->actual_length;
 	int status = urb->status;
+	int rx_offset = 0;
 	__u16 pkt_len;
 
 	if (!pegasus)
@@ -510,7 +511,7 @@ static void read_bulk_callback(struct urb *urb)
 	if (pegasus->chip == 0x8513) {
 		pkt_len = le32_to_cpu(*(__le32 *)urb->transfer_buffer);
 		pkt_len &= 0x0fff;
-		pegasus->rx_skb->data += 2;
+		rx_offset = 2;
 	} else {
 		pkt_len = buf[count - 3] << 8;
 		pkt_len += buf[count - 4];
@@ -522,13 +523,14 @@ static void read_bulk_callback(struct urb *urb)
 	 * If the packet is unreasonably long, quietly drop it rather than
 	 * kernel panicing by calling skb_put.
 	 */
-	if (pkt_len > PEGASUS_MTU)
+	if (pkt_len > PEGASUS_MTU - rx_offset)
 		goto goon;
 
 	/*
 	 * at this point we are sure pegasus->rx_skb != NULL
 	 * so we go ahead and pass up the packet.
 	 */
+	skb_reserve(pegasus->rx_skb, rx_offset);
 	skb_put(pegasus->rx_skb, pkt_len);
 	pegasus->rx_skb->protocol = eth_type_trans(pegasus->rx_skb, net);
 	netif_rx(pegasus->rx_skb);
-- 
2.43.0

