Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794613826;
	b=jaqLvipNrZVWfTyGR0vd9MJZf6dERZ3dDUPkH8Qr2VdECvAnKL4e2QHDEAdREVm/zcam
	 X5/X/cLSPuxEW5eSbiHrRX3MFncK/1PWS7OZZZH1EsAP7gLFZ4PpKIPxQPIMXxLdYlyqg
	 i5uX3nm1IM2XivOepMw9i6VH5srfZ2+pGZNvn2CMhX3K5TDpDtAiiYVWQI1HZW+v02t8f
	 BTT+f8XgLpLkn4V5JwjkDt+IVjIabaeX8J7/HbWzxy78J85iU5BJ683IKyt5rk5qcc0eK
	 XlKynUfAqEpuOO4o14l3hhImMiXahsPn+Um0CVtpNO219YAPTGKnHZxZGwQvqlIGQdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794613826;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4HL/6fjzrUsWBibeS1duDHduZd1C6ZMH5RyDDt56/lU=;
	b=l8tFs2ZF3nD8jCnbgHhtI6SuiBptbRRD8lHJ4tZLcWzTu6LddHY0YlZu2cA7IDFSUL64
	 Oghs5chqs816RmO/Jm3kz6U2UN1/VmC5LtundLuEYrqHRMjE7uhPMAlVjlp0YsvtXgbno
	 15fOArksqpxTUQxBB1jObCpRVkUoJKOrsnT2B6d1uUZGuWQ4edkPOsNY3zofxIArtzUyV
	 eUv7GcZpUWlOWWiZtUxQ90bSL4Q8+4eYlXfk16FEiIC/xv8TMDz2Qr8MDE+1lbxeK374D
	 roKwjTNJhQ/lw0zJPTN1kAmIcsZkzlhyr+VKPJF0Sf4VmbK8A6OabZpo5TPqrPcnaIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=bHQU3Plx;
	arc=none smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A86B606A338
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 23:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A86B606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=bHQU3Plx
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-8629ef8613aso175656a34.3
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 15:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1794613824; x=1795218624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4HL/6fjzrUsWBibeS1duDHduZd1C6ZMH5RyDDt56/lU=;
        b=bHQU3Plx6fdlleLg+CaZMIjjgEv5lRh9lWi9ZMj8aC21xF5P+1KPcEilrAPKD+MLcY
         DXEbN005ILLqpc7oTLMgbyCT4i/3L/Mzm6dy76ATMv12sQE3kqSwbMc32wDfYgNkoKDg
         7feIYX6DyB0poHjiWrASzm8BnyZeMH36U15cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794613824; x=1795218624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4HL/6fjzrUsWBibeS1duDHduZd1C6ZMH5RyDDt56/lU=;
        b=NmNDEBd9EQjG/WVm+7T8acXTGVXDeRANWaCkh7G1v6iK5eMA3oPXPabIGkiJqrMptm
         zEtiR3WIfJU071+U2x1/NFtpYMzzGrVlDiaSG7UWPbhDQ3kVBfF52mVpZ3A5Jt/iBgy+
         6a7XcC6wzvbzP8EgCGa6CcgEUuw+NARK2+rNHJXuOkuwVJR86GVmkwii7al/Iqx6bz83
         bcBbpn70YkKthec9bQR5ZBoR7rkcMWnWfhRgyseuoN3NZcmQV5mX03Kvv9OrXPSICEU0
         Fiq6QPYt8WlWoX8GtIBSWJU3Csk1twJcnPMcYD830Ks0AuI3L6z9nQ4l4BiuZ2XG44vc
         8M9Q==
X-Forwarded-Encrypted: i=1; AL+hErE8sspIWFZEAd0mAfLxxd1g2gmxVqIM8dAAIFlralgQFwojyTD+1D/VvMw0o7iBDMFnkn+Ep90=@vger.kernel.org
X-Gm-Message-State: APuU4Z9MySznjhbsXjjjeJWcPR9UG2fERtEp284rDOE1WVWhw3vNJFeT
	MOBUws6+zQauKwiHkbeuZMf1roUpzihtetouejdFEyzjMZtEB671tMF0f3FFE3br2nY=
X-Gm-Gg: AYBFou1e5rFvjgXX5ic92fHePyZ8pHSxvZzakW24QWvkH5/8j5vGCMuRIbX/H4k2mcl
	iMq7S6e6QglWkllnXYOihmpl1JqLw2a4qw4taRQGAsYxoZ9GCp567xZIT3z/NykioTulr2kNG15
	cYcu8iPBPu8PnllMo/I6UHBtRlONld37v8BfbAOGWPkQoSFzhVTaAERx2LteOBfMpbggEHGSr8r
	zVUPi+SIUzbg/mNZbJYRUGlBkGdp9UD3Jxewq8nm8+m5L/2Sr+zB6nB32pPVM6E+NeH71uzINsM
	SiDQbLMJvinq4WPc2TLvKGyq3+A0qE7krMplJTS4pK1rp+kXaT7WeKh6VQ+9tvzsSWV67N/kZHg
	vIQjieZuf3S2HrJxszbrQ+8KBq8NyFFCQ+O6dc0loVFaCkcmMuw2KRRx/k/TS+cFs+zaBGuaXZd
	nk++uK9yZ8fb1IuLVd5GRIJ7mQOf00uES1C0wj9pNB9T7NwvGYs/mFWUL7ZirEV8I1W8AQ7PR4R
	6MqNVVxY9CUZheax/Pco4qxewqNJzxk0/GSwZYrLDFepT+71SI+uociRzSq7sP0uoxT2GeYy/Ua
	D73IB1Y3oJuC78VO5j1X2oTRNv/SI8Z0g0DhhyQANyY3WmCD5+JFV8EFMRNUccpeuyi6+0Wl9eF
	TCB2RPdwS75p0++pQPviS8cUo/TXdBUw9Se/Zid91wksOsKQMQ54=
X-Received: by 2002:a05:6830:2b10:b0:861:5c3d:4a97 with SMTP id 46e09a7af769-8628989da76mr3407103a34.19.1794613824291;
        Fri, 13 Nov 2026 15:50:24 -0800 (PST)
Received: from com-75606.corp.openai.org ([199.47.143.1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8628818de94sm3562068a34.23.2026.11.13.15.50.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 15:50:23 -0800 (PST)
From: Kyle Zeng <kylebot@openai.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3] net: preserve skb header offsets during headroom changes
Date: Fri, 13 Nov 2026 15:50:19 -0800
Message-ID: <20261113235019.74384-1-kylebot@openai.com>
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
post-pop positions in skb_mpls_pop(), bound the native MPLS label pop,
and reject excessive LWT headroom before reading the IP header.

The issue was found by an LLM.

Fixes: 1a37e412a022 ("net: Use 16bits for *_headers fields of struct skbuff")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
Changes in v3:
- Check the actual post-pop MAC/network positions and reject the MAC
  unset value in skb_mpls_pop().
- Check a set outer MAC header and a recorded inner network header
  during positive relocation.
- Move the MPLS LWT entry check before reading the IP header.

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
index ad4ad6f2001a..18c9654a6b36 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -419,6 +419,9 @@ static int mpls_forward(struct sk_buff *skb, struct net_device *dev,
 	if (!nh)
 		goto err;
 
+	if (unlikely(skb_headroom(skb) > U16_MAX - sizeof(*hdr)))
+		goto err;
+
 	/* Pop the label */
 	skb_pull(skb, sizeof(*hdr));
 	skb_reset_network_header(skb);
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

