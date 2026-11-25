Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795640515;
	b=LZpxwQJzgscdXnHvA/zGdU+35tvE6eMqcZ5KqM8G64A5UGRbKAhC+2tDvmsgotvbcCf3
	 vw/8rncB3+iKLDdbQqESYKt4rHPSSi/LxTXBIEuLxWiUR0SbpIdf/e5O4RAGtO7PrjQ3r
	 huvfd1oSmuz2ZeGp38z5MCALGbNE+dtb+/c42zGOqiAY+r52+GZBigqX3V7BRIU2FBxIV
	 dyWGF3DBhkldReAQfdlvR3Lu8ON0vhtHpfSp1iKhdS266v/ZboROwLppqek3oWGGw5DAq
	 lugZx+bOVWADJbldpTrUboVyI3zgqbbBjkhuSE3rUkAZJPEPEIs/CWcy/GBpJY4jMCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795640515;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=0XXWYJBR6k87H5cikH0sP2tdrFWPZl3Z6YSh/gr4s90=;
	b=kom0EDDP1F/dH/JZmfed/f2zHQYkG/Yc5JhZwcJg3fqrfMN6xXnnRFvVTzWV8mkRqKkB
	 A5ZfLUtPIeE0rByRipZPWEGd9aaPTbTKjePW5ZIvsqWxQ1lcG4Km0f9JYj+ZGh3CDamc8
	 mjgf7d9BqOyLioeQrFb6D6sply2RIiplyNSQOCGbe1HSvkb8+z508ebG19hLbcuk/TIx2
	 60omIO7hAL1xgU7IhP41LyqR/Beo1DBIbQOb4xTfKLVqtoQJfgYt79ZeC40ZJCllzPSD5
	 5+7eTADeaaKnT2k/dnwzUPYe8WRvFhfUfsBOhcMfL3hpCpccEad1OqqL6UGyOP1JKIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--elkin.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZjgrQBFO;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE14606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 21:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EE14606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elkin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZjgrQBFO
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-14373747468so6008299c88.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 13:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795640514; x=1796245314; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0XXWYJBR6k87H5cikH0sP2tdrFWPZl3Z6YSh/gr4s90=;
        b=ZjgrQBFOqFqPbNIdl6RnJl/EBSHkorvsi6ww+mywK3uzDxNVRR6TQhRFQoQOBB6amF
         cS4Ip2KKMLFtdjAGv2erqlXspedo4FRUuLZiIwGOKrLXdh2WVvQ6BZEyDe+hu4RVZHs7
         8tB99CPjMIKJfdq0kZjb5eJeAckogRm010oQE3sbeBNWp8+UJKTnhbvZUUThHlNDEs7z
         JMtJuGB/YAil7KFsyYox73vy9nNqef2ubSPPVT/Sz9shTpo0Ohp+GmAa9HnCz3dJwpwX
         ssjOvm8n16sz8esNujKWrED3aXiNoYq2Bju2Yf8bnSXfARpYeK7hcE0POt8h/lE3Rrj0
         AmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795640514; x=1796245314;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0XXWYJBR6k87H5cikH0sP2tdrFWPZl3Z6YSh/gr4s90=;
        b=tQ0108heo58BehLyv1A7p3vgh6zhYItBRKrIyp0dpVYLo0Zq+x7+XD3h7pLVl7cwjh
         NTjPJvtQ47NhHXDrAkqhTvCYxpVfFY72HQvO53H6OONW7QG1TfJkZkt+MO5HN4OUHkrm
         qazfoN1J/zev5DdwrPKvSzFdfuv85MCXoBq9DB/96XzRvvIJ6HzVbrCFySB5N5Yodep9
         S0f2VVPVjt8m1wt7h5pKT+NhWGpyJxpV8Bya3pT8uPFMlSEnpXJQr/8G48QAYRWkSAXb
         CRGqiWG/K5kxU8HUe1xc0mcXwcD4NPzkdS61NK40iSrFNNef8oLgckR0xlSVG0zCCs0k
         E8tQ==
X-Forwarded-Encrypted: i=1; AL+hErH0WNcXB4qcTAlzTTKWeJuzxocElA93dO4ZOAVG7F4jmnvPhv2Ch0I/p7sE8A5ibVJrgGCbvyg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8X509X6WlmJOTwbVheMqCaCV56DJUzRKPNQJ0JWRZnnArtC9FU
	mkrrqiHvy2460hnqcTiN9R5zFF+e0zOWianEp+wQ6cBG3/pVdTqFvXTUA5KoODwUab0SNJSATjj
	+VA==
X-Received: from dlbuu1.prod.google.com ([2002:a05:7022:7e81:b0:1b2:6c20:7e86])
 (user=elkin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:45a7:b0:1b5:4eec:14e5
 with SMTP id a92af1059eb24-1b55687f18fmr26708145c88.6.1795640514079; Wed, 25
 Nov 2026 13:01:54 -0800 (PST)
Date: Wed, 25 Nov 2026 21:00:36 +0000
In-Reply-To: <20261125210038.1277960-1-elkin@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125210038.1277960-1-elkin@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125210038.1277960-2-elkin@google.com>
Subject: [PATCH wireless 1/3] wifi: mwifiex: fix UAF after skb_realloc_headroom()
 in bridged RX
From: Elkin Cruz <elkin@google.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Francesco Dolcini <francesco@dolcini.it>, linux-wireless@vger.kernel.org, 
	Johannes Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, irogers@google.com, Elkin Cruz <elkin@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In mwifiex_uap_queue_bridged_pkt(), uap_rx_pd and rx_pkt_hdr point into
the initial skb->data buffer. When skb_headroom(skb) is smaller than
MWIFIEX_MIN_DATA_HEADER_LEN, skb_realloc_headroom() allocates a new skb,
kfree_skb() frees the original skb, and skb is updated to new_skb,
leaving uap_rx_pd and rx_pkt_hdr dangling. Subsequent reads of
rx_pkt_hdr->eth803_hdr.h_source, uap_rx_pd->rx_rate, uap_rx_pd->ht_info,
and rx_pkt_hdr->eth803_hdr.h_dest dereference the freed skb (and in the
RFC1042/SNAP conversion branch, rx_pkt_hdr->eth803_hdr.h_source was also
partially overwritten in-place when constructing the Ethernet II header).

Save rx_rate and ht_info from uap_rx_pd after the packet length check
and re-derive p_ethhdr from the live skb->data after any headroom
reallocation, since skb_pull() already positioned skb->data at the
Ethernet header in both header-conversion branches.

Fixes: f7b598532f3d ("mwifiex: update statistics for bridged packets on AP interface")
Fixes: 442f6f9b49c8 ("mwifiex: maintain station statistic in uap mode")
Cc: stable@vger.kernel.org
Signed-off-by: Elkin Cruz <elkin@google.com>
---
 drivers/net/wireless/marvell/mwifiex/uap_txrx.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
index 318bd4ed8399..d2512b985014 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
@@ -89,6 +89,7 @@ static void mwifiex_uap_queue_bridged_pkt(struct mwifiex_private *priv,
 	int hdr_chop;
 	struct ethhdr *p_ethhdr;
 	struct mwifiex_sta_node *src_node;
+	u8 rx_rate, ht_info;
 	int index;
 
 	uap_rx_pd = (struct uap_rxpd *)(skb->data);
@@ -113,6 +114,9 @@ static void mwifiex_uap_queue_bridged_pkt(struct mwifiex_private *priv,
 		return;
 	}
 
+	rx_rate = uap_rx_pd->rx_rate;
+	ht_info = uap_rx_pd->ht_info;
+
 	if ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
 		     sizeof(bridge_tunnel_header))) ||
 	    (!memcmp(&rx_pkt_hdr->rfc1042_hdr, rfc1042_header,
@@ -183,16 +187,17 @@ static void mwifiex_uap_queue_bridged_pkt(struct mwifiex_private *priv,
 	tx_info->bss_type = priv->bss_type;
 	tx_info->flags |= MWIFIEX_BUF_FLAG_BRIDGED_PKT;
 
-	src_node = mwifiex_get_sta_entry(priv, rx_pkt_hdr->eth803_hdr.h_source);
+	p_ethhdr = (void *)skb->data;
+	src_node = mwifiex_get_sta_entry(priv, p_ethhdr->h_source);
 	if (src_node) {
 		src_node->stats.last_rx = jiffies;
 		src_node->stats.rx_bytes += skb->len;
 		src_node->stats.rx_packets++;
-		src_node->stats.last_tx_rate = uap_rx_pd->rx_rate;
-		src_node->stats.last_tx_htinfo = uap_rx_pd->ht_info;
+		src_node->stats.last_tx_rate = rx_rate;
+		src_node->stats.last_tx_htinfo = ht_info;
 	}
 
-	if (is_unicast_ether_addr(rx_pkt_hdr->eth803_hdr.h_dest)) {
+	if (is_unicast_ether_addr(p_ethhdr->h_dest)) {
 		/* Update bridge packet statistics as the
 		 * packet is not going to kernel/upper layer.
 		 */
-- 
2.56.1.839.g22a8290db9-goog

