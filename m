Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E221D47253C
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 19:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785266778; cv=none; b=iE0ZvQnvLlyXd2CDnUUjnUKj6g3q0cMLqLyRhxNy21qDkBxMu72QGANIXvwvjxDB+5m02g77gyo4l4X4+qULWyMcz+lpngyDCOqDy4bKVq+SpPyxeq8Bc7VyEH+6/fGPMYTigKZWxHU34cgGqNwSuxDkOSfV386TJ+vu634dTw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785266778; c=relaxed/simple;
	bh=EcHGE4bv3/8f684uJyKg5YK5taQ5B8iQcN0YfquQ28c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hi78bAHd4/4tL8quFRMVW94JqZHNqXpIr8fopn97MddCuHvKxK4CQMjmAWu10X86ssRTUber8cGDXOWQwGrbpuEvnUPMZdjXWsdJGp8ufmzk2Ad0zbaV9xKIFWNyb8RE1OIq4WWZqK3OGLABL1peWEUK63NbmmbCT1/MnhtdAlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/OCuWfl; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/OCuWfl"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5bfaa014978so63646e0c.3
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 12:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785266775; x=1785871575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ePC1Y0ne7UyI/z8ccYsuTaBWGOHMZQF21As30zRm9nQ=;
        b=h/OCuWflAK4dOqPk2+VxB04I4c5BpKVOcK0dHpuwQFXJMhs6gEIre2d+GJX4bFyVBX
         S8ROP7GX3RXCVW3UPRhwyuCsZutFI/L/iuutI/pFKfOIdI9PdT6gwS+EyrEiO4eNpVEM
         2FnuENm3xYJZYV+8hRwyl9sraDzzRH24DyJNDCfJedg1LOG7D1XNKwuzyO1UhaqlPM1i
         ZUNZbEhBGqjFa5Hjbrby1qoKuhWmddvG/bq1BmMuV/b2pRfal1PudfVlXDgjUnJ/NNuI
         pi0416h9aoPZJB6PLrC20/LA+IWMyxK/z+HHfrX/YXFs80lepK2WthMAzNGyYNLgYZ62
         Ae7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785266775; x=1785871575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ePC1Y0ne7UyI/z8ccYsuTaBWGOHMZQF21As30zRm9nQ=;
        b=D4/XAw2LFbmJ2hLCR5VUJAzHp7alqM3varBMHPnc9WtdlXIEgjAAV5gDJiZw91l1t/
         5T4TPEp+ACJkWd6c7oo7Kgy7RXIXS9eGRYUERKkFbfKowbXOjqfKqmFIfrW3NUz8WSD7
         yjK3zXVl+b+dKaah/pWdXERz57fla9x9X+NyEMBDkZhf2IhxiT9DEcOQ+pGuYQuPqhA/
         9fjWhIEdxKoRnfHLCqhnHUikSrCeltIyecR2L7spDskdDKeCfId8T0keX+vIo3ecxgUr
         riDOn/s/NsSsHhReNsoHXo/HbPZvPNlJJVRO5XMVP6iNkjS4qK9YPoiltJkjZNmyGYvM
         xVYA==
X-Forwarded-Encrypted: i=1; AHgh+Rpan2OzBJZoK7WcG+w1sxmt9JBx00yfJqaYxWxXasBJyDojYEMjEpdVdk/AK6eYUYHtNfa/GS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY0hwqnZ2oiS0zxQZXsG+QrptiGz2EYBle6SpIkDFy0Tk0yTWM
	fFmVqvaXsTTKaw6XRk6+8ttY1ehICLz3M8RslQR7p4RrsdaiU9/Z9lCu
X-Gm-Gg: AR+sD106zp3BV8qHOtUv4LTSGbW39JSicvfzK7ud7SY275qLl+Ai7clJWpX/vtXbg9n
	LSWAfqusbw/VAhRATRhM8KeL1Z/AaO/Y1juJ1r3U0t2lxUk1ssrbg8sQMhduxceMaQvdy/mrEmv
	mhtD6HDs3MwDYC9j4Ou62XrjNwjvaRo5e9xXk31lnQoGLaAe9Y6S+Bw6Q8IwWaO1LwJAN+oNSYl
	ALfbmOkbd7x/wQwZwJi6L/1NbTChFtASwflPg9y44ISSRW9gjv+Oi9l8OwkvmX5U1BPe7n0ilqn
	S402zeQOh9qai89P1MwTlb1iFCnVApHbCNEISD20FpcDuaBVd8i7u5AKfKKGkdxV/MjNzGmUjHy
	3cpBJQ0x1kUtaPgvchl3E1Ua0dqNiNdh+9bY+AB/I+LvoG4Xhrkuw2sfPC6s0fOXbKA81cUUSKH
	fQ0DVKP4kFU9vKxLU4
X-Received: by 2002:a05:6122:1815:b0:5c1:706d:aec3 with SMTP id 71dfb90a1353d-5c33fa9be2cmr1713248e0c.11.1785266774672;
        Tue, 28 Jul 2026 12:26:14 -0700 (PDT)
Received: from fedora.fibertel.com.ar ([200.55.79.212])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c34eefcfaesm373461e0c.2.2026.07.28.12.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:26:14 -0700 (PDT)
Sender: TheySaidThisWouldntFit <mariano.ignacio.baragiola@gmail.com>
From: Mariano Baragiola <mbaragiola@linux.com>
To: Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Mariano Baragiola <mbaragiola@linux.com>
Subject: [PATCH] wifi: wilc1000: validate monitor transmit frame headers
Date: Tue, 28 Jul 2026 16:26:10 -0300
Message-ID: <20260728192610.2236361-1-mbaragiola@linux.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wilc_wfi_mon_xmit() reads the radiotap length before ensuring that the
fixed header is present. After stripping that header, it reads the frame
type and all three 802.11 addresses without checking how much frame data
remains.

A truncated monitor injection can therefore cause out-of-bounds reads.
Validate the radiotap header first, use the common 802.11 helper to check
the variable header length, and require a complete three-address header
before using the addresses. This covers QoS and four-address data headers
while rejecting short control headers that this path cannot classify.

Fixes: c5c77ba18ea6 ("staging: wilc1000: Add SDIO/SPI 802.11 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Mariano Baragiola <mbaragiola@linux.com>
---
 drivers/net/wireless/microchip/wilc1000/mon.c | 30 +++++++++++++++----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/mon.c b/drivers/net/wireless/microchip/wilc1000/mon.c
index b5cf6fa7a851..9b8c083b403d 100644
--- a/drivers/net/wireless/microchip/wilc1000/mon.c
+++ b/drivers/net/wireless/microchip/wilc1000/mon.c
@@ -142,6 +142,9 @@ static int mon_mgmt_tx(struct net_device *dev, const u8 *buf, size_t len)
 static netdev_tx_t wilc_wfi_mon_xmit(struct sk_buff *skb,
 				     struct net_device *dev)
 {
+	struct ieee80211_radiotap_header_fixed *rtap_hdr;
+	struct ieee80211_hdr_3addr *hdr;
+	unsigned int hdr_len;
 	u32 rtap_len, ret = 0;
 	struct wilc_wfi_mon_priv  *mon_priv;
 	struct sk_buff *skb2;
@@ -153,13 +156,26 @@ static netdev_tx_t wilc_wfi_mon_xmit(struct sk_buff *skb,
 	if (!mon_priv)
 		return -EFAULT;
 
+	if (skb->len < sizeof(*rtap_hdr))
+		goto drop;
+
+	rtap_hdr = (void *)skb->data;
+	if (rtap_hdr->it_version)
+		goto drop;
+
 	rtap_len = ieee80211_get_radiotap_len(skb->data);
-	if (skb->len < rtap_len)
-		return -1;
+	if (rtap_len < sizeof(*rtap_hdr) || skb->len < rtap_len)
+		goto drop;
 
 	skb_pull(skb, rtap_len);
+	hdr_len = ieee80211_get_hdrlen_from_skb(skb);
+	if (hdr_len < sizeof(*hdr))
+		goto drop;
 
-	if (skb->data[0] == 0xc0 && is_broadcast_ether_addr(&skb->data[4])) {
+	hdr = (void *)skb->data;
+
+	if (ieee80211_is_deauth(hdr->frame_control) &&
+	    is_broadcast_ether_addr(hdr->addr1)) {
 		skb2 = dev_alloc_skb(skb->len + sizeof(*cb_hdr));
 		if (!skb2)
 			return -ENOMEM;
@@ -191,8 +207,8 @@ static netdev_tx_t wilc_wfi_mon_xmit(struct sk_buff *skb,
 	}
 	skb->dev = mon_priv->real_ndev;
 
-	ether_addr_copy(srcadd, &skb->data[10]);
-	ether_addr_copy(bssid, &skb->data[16]);
+	ether_addr_copy(srcadd, hdr->addr2);
+	ether_addr_copy(bssid, hdr->addr3);
 	/*
 	 * Identify if data or mgmt packet, if source address and bssid
 	 * fields are equal send it to mgmt frames handler
@@ -207,6 +223,10 @@ static netdev_tx_t wilc_wfi_mon_xmit(struct sk_buff *skb,
 	}
 
 	return ret;
+
+drop:
+	dev_kfree_skb(skb);
+	return NETDEV_TX_OK;
 }
 
 static const struct net_device_ops wilc_wfi_netdev_ops = {
-- 
2.55.0

