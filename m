Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202625;
	b=5aW1XQqUqGouD+gVfvvF1Uk1ksf/wDsltJd7q9bOLgkmxepikfB1ehM/jDz1h/p3DALu
	 8R2bYSSmyvW0iVAjtigPobGSvgfIniZ+QSryyXE42EZ17997NRD/AXrhiCdbOow4X4JJ1
	 YuDJU2t7A8yNNyl15VW1+L8JKJYYGUf5uzzU08k2AgP+MPhwiKBSdxxEVicb3DEX32JGM
	 SDMS5I0kGQGggmEC9bF+H29PfJnJtdlcWye2kldO3CZJ1uwJONMiXbqHJ9/wYw8R4mmey
	 YMJvytfyee80RXnpQn/9WUD0c9urTFlGlYvKLFpAqC0lMXwr1Fj9BvcnC9fuBe7tp6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202625;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WA5kH6g2rHXaT3SqVp79TdqL6vsLj+rBSzEJqsx/Hwc=;
	b=lO/p4LHimnzgNpoHUI9H7jLSKnlmhsRBqfKpqaVKjePZuMdd4Qh/mWrGolIfmfao4Nqn
	 VIlDWzQlU8A78WrYsA5Yddi1EE/tMnCT+cXM41cOB1INllllXGy49OeS7mcHwFUhHeJaS
	 wZ9HibWRYzFQlX/FORtA/nmNH9k6mDDyyKogAUDKHOUbDgUDKIW0sLFufnL5uTlhlFsPx
	 MPQ87XdGKwa2nChNzlFCzM50aZxqtI2fTnTY0MBbnk2IC4zjH2iKjgRmlwj3LFTDDDl3a
	 fRAJgfaTM+z7FXVFHDG1zT1susFoEEKQ63gSal0A4thRXc58bLh6i46shrm4zBb8anw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=TIUK28Kr;
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C07606A6E2
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 19:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89C07606A6E2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=TIUK28Kr
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-862a5b64755so786929a34.2
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 11:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1795202618; x=1795807418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WA5kH6g2rHXaT3SqVp79TdqL6vsLj+rBSzEJqsx/Hwc=;
        b=TIUK28KrHHS/jEIHaRwd4V3J2bTkqF68AyeJA7kxAxFkCrDgrzR0UWEsPIpj2OLGnF
         wnMAFZO0ockNTR/JIsRZw23QC4Jqil0LamS8z1CgD8Sc04RBrwMS91VYsq0h6YV1zFHx
         uGq0Epykbl00jRMqwPJTZUoP7R6mG5B19s8fY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795202618; x=1795807418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WA5kH6g2rHXaT3SqVp79TdqL6vsLj+rBSzEJqsx/Hwc=;
        b=xaJ20lzpFdQsHL3dHSKH8FqbjR8S7CroSDaBJJkdnLJwD2+mPKvxZWcYyyg0zS7HOv
         nVTujALDQM1vp8oaTSXgtE+wXwta+F/lBAPfqKlUNnXUe+8Dkf1t4LQ9B4csAtpwagF+
         fov74z7+DMbXnR8ThJUC6T++xbT6VmvypmhKCLEuxzUj5zWJuM13/QHQXItdv8d8oojZ
         25dpbJ60ZaATwMNQfnpfxH8CCpNH7pXJCRcVbODwfTtKPyuyz7OUZlYDaw7Dey4T7v4r
         PEDt9XuIeyZ5053M+hQNbwCW1jPoMvPK+esWmmxCAfM2gjUfrPIXZECXpYWLpPh2l1FI
         nCgw==
X-Forwarded-Encrypted: i=1; AL+hErFNdmrxx9JITxwU6A/51nY0KyUHWJ1g0AmO/poS7V9KdJ1bbrJH9vcSfClI0eiqHsl44gkEr8I=@vger.kernel.org
X-Gm-Message-State: APuU4Z8uXAU/uPrLmFMZYlo5lrTHLGl2SyKuRGGn9x8dum0ZDfbnlZJ4
	+0vsgLWtYPO8SVcaOcFXFEfWGeevZvU9UvZN4+XTZxMV509p8k+0amFfdXzzvpQV5V4=
X-Gm-Gg: AYBFou2rrTx55sxK30oq9auWNSjDM6z4ZmYdCn4+JxoQ3s15HtCP6zMhgvR+8KmkMob
	BEVXojsCK4sNh+EXiX41K75xsOEVS4edq1CSPyjiokaMUZ6UOlhFSRTicXKWeu3MkkUZ1wf7mym
	bD1uI9Zb27yGRO2IEfCODfFICW8yedQkFn3GueZYS114NXXz2xRNARsvKI/TE6MOD3mtOoIWqG/
	eHUPQ3wjq0mK5CgRBbFHNtqzeag9ha6GPRFIbcpxAbUE80Lhj1xobv7al/vF/QtGKwfDEwCk+CB
	OsrhQGtyBYvUQA9TbYJRAJ+9S+pizvpZ+HbB8u2OmnyLZd6z+Es3o8Lu1Mtn6A9db6Tioswz6/e
	d2eT4OFC9/qAG+ts2ke0fZ+8UvcRtJHrID8+Ic72h2fCOaW94zldAvAqU2etg9MOP26AaYCURPA
	ScbSDnYlgvdLeKQlFjNXiY16sBCDNIx3+cw3CO5FplIaTSHG/jl7/mDPeauEeTptiwsNJOBZTjZ
	mFsylNOStbP/J/tZ07PkGF1RppIMx0acgnoF8Hx8vNLqSd04rjx6ynPLAPS+f0Ga1pNYCKdiPMs
	Ez9uWV6VSfuZ8REoeBqLI6kHT7DpPwozSgQmOaZmh3qQRrFDYxwBXxRIaz9YLVKmRjaibQZw804
	6vIxcu+EUk6yH6gvd8bCBW85oJjLTNQ==
X-Received: by 2002:a05:6830:640b:b0:862:a000:c45c with SMTP id 46e09a7af769-86315963a10mr5573204a34.25.1795202618333;
        Fri, 20 Nov 2026 11:23:38 -0800 (PST)
Received: from com-75606.corp.openai.org ([199.47.143.1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168f6d33sm2639106a34.18.2026.11.20.11.23.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 20 Nov 2026 11:23:38 -0800 (PST)
From: Kyle Zeng <kylebot@openai.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org
Subject: [PATCH net v4] net: preserve skb header offsets during headroom changes
Date: Fri, 20 Nov 2026 11:23:30 -0800
Message-ID: <20261120192330.48965-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
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

An MPLS LWT route over a netkit device configured with large headroom
can make aligned skb expansion wrap the 16-bit network_header.
Neighbour output interprets the resulting negative skb_network_offset()
as a large unsigned pull length, causing eth_header() to write outside
the skb allocation.

Reject growth that cannot preserve the network, set MAC and transport,
recorded inner-network, or partial-checksum offsets. Do not relocate a
set MAC or transport header onto its unset value. Check the actual
post-pop positions in skb_mpls_pop(). In native MPLS, bound the post-pop
offset before decoding labels; reject excessive LWT headroom before
reading the IP header.

The issue was found by an LLM.

Fixes: 1a37e412a022 ("net: Use 16bits for *_headers fields of struct skbuff")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
Changes in v4:
- Move the native MPLS headroom check before label decoding and
  multipath selection.
Changes in v3:
- Check the actual post-pop MAC/network positions and reject the MAC
  unset value in skb_mpls_pop().
- Check a set outer MAC header and a recorded inner network header
  during positive relocation.
- Move the MPLS LWT entry check before reading the IP header.

v3: https://lore.kernel.org/netdev/20261113235019.74384-1-kylebot@openai.com/
v2: https://lore.kernel.org/netdev/20261110051258.64350-1-kylebot@openai.com/
v1: https://lore.kernel.org/netdev/20261030042246.74144-1-kylebot@openai.com/

I have a reproducer for this issue and can share via DM.

 net/core/skbuff.c        | 35 +++++++++++++++++++++++++++++++++++
 net/mpls/af_mpls.c       |  3 +++
 net/mpls/mpls_iptunnel.c |  3 +++
 3 files changed, 41 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 1ac1e327ac4c..bc836adafecd 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2130,6 +2130,28 @@ struct sk_buff *skb_clone(struct sk_buff *skb, gfp_t gfp_mask)
 }
 EXPORT_SYMBOL(skb_clone);
 
+static bool skb_header_offsets_fit(const struct sk_buff *skb,
+				   unsigned int nhead)
+{
+	if (!nhead)
+		return true;
+	if (nhead > U16_MAX - skb->network_header)
+		return false;
+	if (skb_transport_header_was_set(skb) &&
+	    nhead >= U16_MAX - skb->transport_header)
+		return false;
+	if (skb_mac_header_was_set(skb) &&
+	    nhead >= U16_MAX - skb->mac_header)
+		return false;
+	if (skb->ip_summed == CHECKSUM_PARTIAL &&
+	    nhead > U16_MAX - skb->csum_start)
+		return false;
+	if (skb_inner_network_header_was_set(skb) &&
+	    nhead > U16_MAX - skb->inner_network_header)
+		return false;
+	return true;
+}
+
 void skb_headers_offset_update(struct sk_buff *skb, int off)
 {
 	/* Only adjust this if it actually is csum_start rather than csum */
@@ -2317,6 +2339,9 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 		return -EINVAL;
 	}
 
+	if (unlikely(!skb_header_offsets_fit(skb, nhead)))
+		return -EINVAL;
+
 	if (unlikely(skb_shared(skb))) {
 		DEBUG_NET_WARN_ON_ONCE(1);
 		return -EINVAL;
@@ -2535,6 +2560,11 @@ struct sk_buff *skb_copy_expand(const struct sk_buff *skb,
 		return NULL;
 
 	oldheadroom = skb_headroom(skb);
+	if (unlikely(newheadroom > oldheadroom &&
+		     !skb_header_offsets_fit(skb, (unsigned int)newheadroom -
+						  oldheadroom)))
+		return NULL;
+
 	n = __alloc_skb(newheadroom + skb->len + newtailroom,
 			gfp_mask, skb_alloc_rx_flag(skb),
 			NUMA_NO_NODE);
@@ -6804,11 +6834,16 @@ EXPORT_SYMBOL_GPL(skb_mpls_push);
 int skb_mpls_pop(struct sk_buff *skb, __be16 next_proto, int mac_len,
 		 bool ethernet)
 {
+	unsigned int headroom = skb_headroom(skb);
 	int err;
 
 	if (unlikely(!eth_p_mpls(skb->protocol)))
 		return 0;
 
+	if (unlikely(headroom >= U16_MAX - MPLS_HLEN ||
+		     (unsigned int)mac_len > U16_MAX - MPLS_HLEN - headroom))
+		return -EINVAL;
+
 	err = skb_ensure_writable(skb, mac_len + MPLS_HLEN);
 	if (unlikely(err))
 		return err;
diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index ad4ad6f2001a..f6b77570ca48 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -403,6 +403,9 @@ static int mpls_forward(struct sk_buff *skb, struct net_device *dev,
 	if (!pskb_may_pull(skb, sizeof(*hdr)))
 		goto err;
 
+	if (unlikely(skb_headroom(skb) > U16_MAX - sizeof(*hdr)))
+		goto err;
+
 	skb_dst_drop(skb);
 
 	/* Read and decode the label */
diff --git a/net/mpls/mpls_iptunnel.c b/net/mpls/mpls_iptunnel.c
index 1a1a0eb5b787..5123394234cc 100644
--- a/net/mpls/mpls_iptunnel.c
+++ b/net/mpls/mpls_iptunnel.c
@@ -59,6 +59,9 @@ static int mpls_xmit(struct sk_buff *skb)
 	    !dst->lwtstate || skb_warn_if_lro(skb))
 		goto drop;
 
+	if (unlikely(skb_headroom(skb) > U16_MAX))
+		goto drop;
+
 	skb_forward_csum(skb);
 
 	tun_encap_info = mpls_lwtunnel_encap(dst->lwtstate);

base-commit: 2800868f63227c8237d70c41e70d441c919620d6
-- 
2.55.0.openai.911.g06873a30d2f3

