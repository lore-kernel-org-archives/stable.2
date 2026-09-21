Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17F743D503
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 07:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789976529; cv=none; b=sGk7l1W3xCB61cjwF8o9rOmwg7cn+ZWuAPnhFO3Oc7QbChaEAK0cYObB3AAG149C7ivlyNXoCowae97yfSXRXw17Nmw3NpHMYtWnJr3jhy35CvWShlywphkOr1heZPTBqzS0D6VeWS1smMUlkMMd4UMiy/6Dohg+r3Mu4SMc0Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789976529; c=relaxed/simple;
	bh=DRSbsEZlYqRU2ZFuKlgyDsGV2nz0JSOXB6TyqyEq7AI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A9hi7l3xQDJfsxrjOTyiRddpO1nShfiOU4jHAtrKALUUDVoiuyejmkojexpGaNZ+UmjQPQfXFHfR4HwdW+OZ4MUzSGOD6/jmlEiSRfck+PHRe0m6PUnexXOSWDZUyhVqNdKjx01SfcHRX6TAItPK5/0joj6N2og6TxuzrUrjn2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1yJiLDP; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1yJiLDP"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd5cf02so1870218a91.3
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 00:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789976527; x=1790581327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rN2uUWtJbumqwS4fCKzwEsvJLfsBmHBgpfyDhn5UNyE=;
        b=A1yJiLDP9PGZxGGRtHL1bUKeU11xKVtc7lAoDUBe85brLViJwITGIRezyfTB3uzO2M
         tdOTF8C5hx5Qe9BM+fVxm3WC1D72z8Z2KCWgxi1YOrXiyf/0n0wEbPIXNrIGCfd3ic38
         htyNEb38eJpD7j6dgWr9Re9d+/3TvZcs2YMm5S4t1igoR7hTjWphu318p98kJKCcad61
         gCEJcAP+sxC37v4w33e1/xviZ4NnRKKJPDTEi+vvHn/qcMXNFFt5WhyzdZ53Fmj/0F4Q
         8X6UCosu1Dy9dM1kbmpXYFVlAeQ6x3h1XnwVzWgQYuFyvLhzJM0k7MDUjL+MmmFQLB4u
         rnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789976527; x=1790581327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rN2uUWtJbumqwS4fCKzwEsvJLfsBmHBgpfyDhn5UNyE=;
        b=A2Jgtgd63dsi8gBOvMOTpaNGDjmtgqAf0hoEZkloBVdyUXPqwdOm3EWZm2RE/YcCXz
         lbuW7T6P+B9W9HUea4/eZC/dYxCRergPLObaOWaUkqIPFpLfW7vYy0m4RpnO5LZEVsup
         lFeaq5IVp8ZaqGiplsS1AisesdaWf3xMDaUjHnJG045yS87MQ0g8EOUDNWxe2hDK26ef
         fFE1fu5XbVX9hdt3QJ+tRky8gj8b+rvLUIL7SN9rlDXvEoOkw/zv1/bzk/CvpC/oZ06B
         zcpC3+TwG/S6R0bRL0a7QJ9j+Iabp4L4wAIkT79YYK0CU7xcnG0VJoFsvOhulUwmgYGb
         UX0A==
X-Forwarded-Encrypted: i=1; AKwUvBzg3tRfeRkb7Hq7TjdLwcy6c1Y9V8t4sqUy983tVJ4SNBHnoM5DIP8AkacNrXQgLYlvZRlWVwc=@vger.kernel.org
X-Gm-Message-State: AFuF++lLNezyv8JXpZ4RMmiW1wyxNRL0fI3527bL2Ndrd23IOK05OSnY
	RYpIdY0pB32BPzn8EgnOfNkqGtUAndwQw1x3xKi+MNztQ4Qo5Bcp6k4g
X-Gm-Gg: AYBFou3thFOeTOIduNGE/Uxk8zQDyOxk3AkqDubWk/R+kfYT4gU8s118UjGsXW7TIod
	coLf7ZjIfOffthacTXgwuIHLPGmb8W3z6OlzewoGyYd3V1eKJokPQZu1U1gFRHWxPncdkjF+2Xd
	J+2a1UtCbSJmgpCIQ4ZQJomByLW0WyReR0cWLhUAngS4mkNnMfBggxYZCHVrzyDgh8lvqojL7tv
	mL8y9Hwv2A4GYDVs9Yth+2Oxii4cKsS9n2Q9n2xLTABcW8uiG5pQjuGT5f6wEb31gEyMuI97EJV
	h3hd9HTKyvPI+YH0v+sPnsRvEp6tqTG9Uaed96K+9Khr24vwUzHbxwjernqKfytZLvKcJowJt9x
	Smv1Huyah7PjkD1v0Zdx6hwy01cilLxeOJ+ssNYZLOKL/wm8mnftPC8Qb9vfUB3yTWcAJ9w3Zf1
	ETHtkXS+wnd8eRQwSMYvG3tctf3gnl8RrQ5yUr3FRcCdTjjKpJCGbe+1iG/Z6sfab5lU7WUbxqH
	yCwNTOpVl1/kTU3BzwUc9FdDym36yINwxtE4PVgix3aodLN86BCPD9xCNqXGK89DGHCqM04rMau
	rOScG5Xs7g==
X-Received: by 2002:a17:90a:e7c6:b0:39e:6a81:f34a with SMTP id 98e67ed59e1d1-39e6a81fcf8mr8609680a91.36.1789976527065;
        Mon, 21 Sep 2026 00:42:07 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cabb771sm13015876a91.9.2026.09.21.00.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 00:42:06 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Harry Morris <h.morris@cascoda.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui Peng <benquike@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 3/3] ieee802154: ca8210: validate data_ind length upfront in ca8210_skb_rx()
Date: Mon, 21 Sep 2026 07:42:05 +0000
Message-ID: <20260921074205.2289211-3-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260919213637.3316595-1-benquike@gmail.com>
References: <20260919213637.3316595-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ca8210_skb_rx(), data_ind is read at offsets 22 (msdulen), 23
(mpdulinkquality), 29 + msdulen (hdr.sec.level), 30..39 + msdulen
(security header), and 29 .. 29 + msdulen (payload) without verifying
that the received SPI frame length len covers those offsets, causing an
out-of-bounds read when msdulen exceeds len - 30:

  BUG: KASAN: slab-out-of-bounds in ca8210_skb_rx.constprop.0.isra.0+0x137/0x160
  Read of size 64 at addr ffff888006453ddd by task init/1
  Call Trace:
   <TASK>
   dump_stack_lvl+0x70/0xa0
   print_report+0x153/0x4c6
   kasan_report+0xf1/0x120
   kasan_check_range+0x125/0x200
   __asan_memcpy+0x23/0x60
   ca8210_skb_rx.constprop.0.isra.0+0x137/0x160
   ca8210_net_rx+0x96/0xc0
  ...
  The buggy address belongs to the object at ffff888006453dc0
   which belongs to the cache kmalloc-32 of size 32
  The buggy address is located 29 bytes inside of
   allocated 32-byte region [ffff888006453dc0, ffff888006453de0)

Consolidate all length and msdulen validations into a single upfront check
at the beginning of ca8210_skb_rx() before allocating the skb.

Tested in QEMU with KASAN enabled by passing a short data_ind buffer with
msdulen = 64 and len = 30 into ca8210_skb_rx().

Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Split out as patch 3/3.
- Consolidated all length checks in ca8210_skb_rx() into a single place
  at the beginning of the function before dev_alloc_skb() and dropped the
  unrelated hdr.seq assignment as requested by Miquel Raynal.

 drivers/net/ieee802154/ca8210.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 1de6314..2aa7d8c 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -1759,19 +1759,15 @@ static int ca8210_skb_rx(
 	u8                    *data_ind
 )
 {
-	struct ieee802154_hdr hdr;
+	struct ieee802154_hdr hdr = { };
 	int msdulen;
 	int hlen;
-	u8 mpdulinkquality = data_ind[23];
+	u8 mpdulinkquality;
 	struct sk_buff *skb;
 	struct ca8210_priv *priv = hw->priv;
 
-	/* Allocate mtu size buffer for every rx packet */
-	skb = dev_alloc_skb(IEEE802154_MTU + sizeof(hdr));
-	if (!skb)
-		return -ENOMEM;
-
-	skb_reserve(skb, sizeof(hdr));
+	if (len < 30)
+		return -EMSGSIZE;
 
 	msdulen = data_ind[22]; /* msdu_length */
 	if (msdulen > IEEE802154_MTU) {
@@ -1779,9 +1775,25 @@ static int ca8210_skb_rx(
 			&priv->spi->dev,
 			"received erroneously large msdu length!\n"
 		);
-		kfree_skb(skb);
 		return -EMSGSIZE;
 	}
+
+	if (len < 30 + msdulen ||
+	    (!priv->promiscuous && data_ind[29 + msdulen] > 0 &&
+	     len < 29 + msdulen + sizeof(struct secspec))) {
+		dev_err(&priv->spi->dev,
+			"received truncated data indication!\n");
+		return -EMSGSIZE;
+	}
+
+	mpdulinkquality = data_ind[23];
+
+	/* Allocate mtu size buffer for every rx packet */
+	skb = dev_alloc_skb(IEEE802154_MTU + sizeof(hdr));
+	if (!skb)
+		return -ENOMEM;
+
+	skb_reserve(skb, sizeof(hdr));
 	dev_dbg(&priv->spi->dev, "skb buffer length = %d\n", msdulen);
 
 	if (priv->promiscuous)
-- 
2.47.3
