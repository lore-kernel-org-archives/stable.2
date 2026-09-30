Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2766448CF3
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 07:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752762; cv=none; b=fs2TLr4jeELVhFu19Dm1OXMUk/3hi0b1h25Xxbg6DaoJ2jnkVBrSI2pX5UPmsdSZxkNmY0cS72Kd/dgu5GcVv5uz+Kh/41RuJa4+AZvpkYortoof0WnqEE6f031fmznqyXZZfak8L3vdjTFc/fuTKcasuGH2F1bK3vLQF/3SCvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752762; c=relaxed/simple;
	bh=Mk3fSgu7F2inklm698FGg8xtY/UC1g+hSJQWE9hH+Ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sn8cRGIGlxiq3GSR7Q9wmpQwxrsPBpuQ4x+01y1f+9rKjRkTOwp142w8XOc4tTpb6aeHPtOAoMIn5afvYlll9R7vVMYdu5KQeaR4H5ee+XRqhBv1Jy89xN903bppBcSr0yCTl9D3qGOlZJ+WzK+OQEOYtnmqS8Q1LVnRVxvZiKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzbYtH1d; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzbYtH1d"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-39b2ad83dc6so3326646a91.0
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790752758; x=1791357558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WltmE4hNoTkSsXOgrdp6cz7c6fyzqTtuC0otv1UOPu0=;
        b=UzbYtH1dZCN/HkS5X3zoEr4N+uW/lLothGzegW2FQPc5f7qcZHPMJz0G51aO6viD6O
         Z6uO1/E33sCnV7o208ZZvrdx4zFkW+MX7dYryt4ehNESaWmsvYEqmVwk0TLdMPTos2XY
         U7KSrPPYJ23YOP8uG6UKGMQG6uO2WuIWWsKBySYbqahS4z0YrMfOWtdGWiPXuubl8EBR
         HsHO+VCCLnAyZUYx6PhCF3JD0NyOukqfn9URb/haP3NUDEksCD1GXVK7tJD5kyI0Rp1i
         hTs0au9z0QcZYRwSJ8QmyW/MzF7lprhFX9AuqWtaEV8L5h7yZlZq8qPGIuCbRbxqJKLH
         1efA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790752758; x=1791357558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WltmE4hNoTkSsXOgrdp6cz7c6fyzqTtuC0otv1UOPu0=;
        b=hu8JP59BQF5gHe9MxKWgPAmfeHpkkFVkNL1c4scz1gwcqH0jy1BnwJoaT2icphJetX
         aiIOQ8psZBheNV2JZD7WxkUYuzy0ZqrL7yJAxOEG+xz/qsJdLJ+43JQF9oj9ZeZjNUp7
         FY894j7IDpedaL/P5gLbHSu7AmZAjEau3bpZWhxodr37dmf6rA7KRL8yRfRvihab1Drp
         noB4KZlMiLdq3q2vrdc6OiLPdZ46uHEE0WYcwRSCSoi5lw3iVK032sRa6R3hmj7EFFMD
         FmzHo7ZUppjG8WWPKzVaAzN2siF5rSy4Jl39pVtLM5nf7oWK9/ykUmUquhm/D6Rb9Trz
         vF5A==
X-Forwarded-Encrypted: i=1; AKwUvBySEn953Rtjjab+GTL8zFNzdNnDGsqUEWLePNjcWqUGLOw5v/Jfx2mb8zOasPvDPXpZRMNqTl0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJt714+Y4wO+dLtX1i/AmZ/lvOE4JsVKmQ06sblZ3Aq8yXsX7P8
	y4TFtGQSDo75ELej2FfqlA8zozvJcS9JWRPzSIdBsc0EXojxO+ZqAn3b
X-Gm-Gg: AYBFou0Z8Z8rjoovix+KRJPc2P5kjcic5sgVtuJ/K/JR9ynMLwqy9+QO0hF48o0h3zT
	ig2rrcVX4hEhE3OXx0a3QmXRRa388b2YqijtoIqpMNP6UePkWhh8z4rh7ed0p4c8Z/Eo7OpTlp8
	U2knbYaiJmnQPbtnElELu9wHxV4ElJVP84vpwdZjvS/XyFx8YQq4fZ0UWO4DEYiwMf31rKlsZX8
	6HsqNFbKWsEt7PUgR7VdrRUVwB20we16RgvHRz1Vuukl+dBrot2RgZl5SJEW5+gtoy3zCWU+syF
	W93vdsIhaupoJR/5ffy7xQGvr9c5D5PNH1HckUCxg2W0/B1RBiJPXPmyiCWe+jXdCIzUXBIfLOs
	jaBD781TPT6GkisVjajKXcfVsCgcwkSkMiKvPz5NGCFLcZc8RHS+Ox4AtEbWFq8xwHdQUQXQGdD
	8VmNXS4NCxfEKh0lyjEPdT36M1Z6FrplW0Ovcei4Hpl0ZOwtbOSPZmoq0eip/G/oyKSkK989lro
	MpbXPWZVtZ778qpMpY4wZq8xQ0l2uPNrYW8vIQ2C0Y+JzaICQT4qxvIyPa+lXNt5u5+uWxOwrJz
	HH7BRljFvA==
X-Received: by 2002:a17:90b:2c88:b0:39d:f6a6:60d8 with SMTP id 98e67ed59e1d1-3a4d102d649mr439330a91.3.1790752758281;
        Wed, 30 Sep 2026 00:19:18 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4caec0f28sm2256687a91.17.2026.09.30.00.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:19:17 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Harry Morris <h.morris@cascoda.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH net v3 3/3] ieee802154: ca8210: validate data_ind length upfront in ca8210_skb_rx()
Date: Wed, 30 Sep 2026 07:19:14 +0000
Message-ID: <20260930071914.421586-4-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260930071914.421586-1-benquike@gmail.com>
References: <20260930071914.421586-1-benquike@gmail.com>
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
Changes in v3:
- No changes.

Changes in v2:
- Split out as patch 3/3.
- Consolidated all length checks in ca8210_skb_rx() into a single place
  at the beginning of the function before dev_alloc_skb() and dropped the
  unrelated hdr.seq assignment as requested by Miquel Raynal.

 drivers/net/ieee802154/ca8210.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 8aa7ffe..ab245ad 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -1758,19 +1758,15 @@ static int ca8210_skb_rx(
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
@@ -1778,9 +1774,25 @@ static int ca8210_skb_rx(
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
