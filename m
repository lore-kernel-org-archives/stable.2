Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795636667;
	b=W7BXxaY3Sd0IhzEawt7WsHbKNxbNU98Qg6N+tzpqXLXFxq0S8uA//J/tGCOayCrnGztM
	 QsCTer73J3fjqH+peX4Ng1kX6g2WIN4ovASXYkWg+eJN1xLSA1gMEtdBAkVcGRvdwRZUh
	 h1LoG2gPPmeu/hIuJnrXF4G1qmFWpLBIz+Y9gUw41mDFKKgRNRc+sb1Zo2LFlFGMnv2cS
	 lLnBab5UD3xaMyAKwYEyfgvJrWaKxKVNvhWrV3i10Ap3z8EkBFdNqVTKufQTxNYYaZg+n
	 HTYWWRtGKhjn+7/NL7ZbjTWmRb51uxzH3PMXVhSXiZf9zwR/DFdcj6j/wu6RUt3BVRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795636667;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=QSbicBCggixQqMOYfUZmOoYxybMhCFwsk9cNA7EU8U8=;
	b=zOPmCoZNPYo0lP2G2gQmvDv1VxwuwdPBKnY+D0zBgJRHr1hUr1Bq8mSJNIq1709YfTZ8
	 ocaV527+fKqnK0k7gjjMDXOTw8hOTiAisclIa3dFnwvlgzW/k8uuPqzp1t+Kxl6ZdJ5nw
	 8CwnP4CBnY1HntU0HIhHIEPr0g9FYXux4toMnit1li0llP5YhdHpw5JHQLFTKPdpH+pXb
	 kzoK0bVPNLX5woWkbDKKq494eLi767ZjhgOlPSt9Gk2FNuacZ27lPE/HZfw8Kdw3SvSIL
	 T1BGRpj2DlDaABTlgikU5bxzDO/xo7EhRnFLC8r0nuv1Nnuxg9/0f6w0Qhae8DSqEog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=trailofbits.com;
	spf=pass smtp.mailfrom=trailofbits.com;
	dkim=pass header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=VZuCcIsI;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC3D606A329
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EC3D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=VZuCcIsI
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso13164470eec.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1795636666; x=1796241466; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QSbicBCggixQqMOYfUZmOoYxybMhCFwsk9cNA7EU8U8=;
        b=VZuCcIsI4v/UvO/j5klw7nwU2vQvo3A7CRIJLhTZA1QqrHwqDuJP7AQmZDwLpa3SkX
         y6esPlcfk//pU1n6CL63aB4tB4ZqcN0q5icmwk6hcG0Dh0yqSztCPy6dWfnIIVmVuPRV
         WM52CWDLoBWbiNQpSISIcJRpVPZBVMb4gAQIK8wywlZmAb4V+/hNm3LNeh+ZXqpsJoG1
         /BZDYyRfU5lXCwqtAjTe45eQzOJLcTk9iDkKvq8vgxp3ZJcNbalU8vi3jHWCn7nZ1xik
         EB6Ny8m4pGxT2W6y2tFIe+G9RhEsVhck4J1V18OUlSL8XKQm2SYoQxLJsZasxdrWrFX1
         /ehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795636666; x=1796241466;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QSbicBCggixQqMOYfUZmOoYxybMhCFwsk9cNA7EU8U8=;
        b=D9qIAEM9NWrzhNVJp3ehK575aqtDf2FAaE1ou7+Canak0OOb3uWjVXeyh81wy7WSMJ
         dbEGHDvZ6WqYgXHn9Wj3nlV4VfFrrdmA3PvPCXt5I5DvqxMsPeLZTYHJM+tgRrMZwjjl
         qAKeSHIQ5vvvWm3Y6DjPPniq2PT+hplX3sNghrSf6WshToYAl5YYEcAfbph3IVLBltf6
         YYBV3pBLSGMmOdc48G8lDSOt2NqfX2BsD/Pp6LDB0EAfq758Dvp4LmZNeyiwRlj/Dn5I
         TAEbRRSbQRWzJ+QOvqNwOAOBdpcYU5Ebh3LohNFASAFt7LEHsl0o0UnY21E9e3p0bBF2
         NoDw==
X-Gm-Message-State: APuU4Z8uwBsI2UDnzpvf91jfDPuh4gE6GN89UEQaZZjjz1u6syCCaQNy
	1+xosJba9ywfgXT10CrItlS+QRRLpPlRiCz9jdRNh68LHviduwXKVcCabjjgwcJRw/f63a82uvX
	VA7IT5tE=
X-Gm-Gg: AZFdTZdP5uCrcge5mKKFK7j7dfpGXed9CQQ6QRHYYkRZ0xT85ycG7bHxY5dO0vdgJTO
	4Vel5xYy/I4cIu2rl/FoekI6k8Zi48dh1WnCyLUYr9z01u54bdxteqFiYgX0x8u2oti+eKgAr3e
	Y2mJf1GMnGlQB4JwiDqkAg1w/VvAf6+UtO3KRaYESHVxnC+WYGQcoBNN13tnNsXLDgieLGbzvB4
	EhjjpmAQD/lSmhDfZCJ8mk1ImWz910lhBM4Js+/eBfcl4tRDXA0QVr+7VUPdGNA6sigfZMC7w5Y
	rQZAslAlw5yuglH8BtRlbaibzUjPOKcHSI3qUBzZHQFgeq8BAtd9DkIcuJ6TcSUVOW/5RA9n+D1
	SxSRLfaJ/nxgI7D1RPt0OksXlnwbY2b5UXKAOcPk2RpCxdKMxaEwQ11XavR5uhQVcZgc0UxcpfF
	MIe5TgmtnxIPa0000ZvR8cum60hC63BglbK4ZQMfdetR63SJSRdXnCPPl54UwWl+EDJXFaiNYhh
	Z4NrF1WcHV1TOeMaZJ3y3FMQAiJL228/aos2wWZBcyH13d7SqxVXGS1SzqX6W1Wnih2AIJI1BQw
	ZuRI9ZewdxZTTpnQxpuMd+MW99WHbs+T3woUwgmPrKc9BtP5sxsZfc4435+iVfN59AEZ0TYtlxu
	O+KPM1UVYYaDP65qlpSiPlAG3tA==
X-Received: by 2002:a05:693c:69d4:b0:382:90fb:4cad with SMTP id 5a478bee46e88-3856ca9db95mr17568429eec.2.1795636664223;
        Wed, 25 Nov 2026 11:57:44 -0800 (PST)
Received: from localhost.localdomain ([2603:8003:6d40:6669:75a7:83bd:63db:baa9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566fdce48sm59596522eec.14.2026.11.25.11.57.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 11:57:43 -0800 (PST)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: cratiu@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	herbert@gondor.apana.org.au,
	horms@kernel.org,
	ipsec@lists.linux.dev,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	steffen.klassert@secunet.com
Subject: [PATCH 6.18.y 3/5] xfrm: Don't clobber inner headers when already set
Date: Wed, 25 Nov 2026 14:57:33 -0500
Message-ID: <20261125195735.57472-4-artem@trailofbits.com>
In-Reply-To: <20261125195735.57472-1-artem@trailofbits.com>
References: <20261125195735.57472-1-artem@trailofbits.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

From: Cosmin Ratiu <cratiu@nvidia.com>
Date: Wed, 22 Apr 2026 17:06:48 +0300

[ Upstream commit fa90a3145c0340c3f624206a81637c542254ea1d ]

On VXLAN over IPsec egress, xfrm{4,6}_transport_output() blindly
overwrite inner_transport_header (== the inner TCP header saved in VXLAN
iptunnel_handle_offloads() -> skb_reset_inner_headers()) with the
current transport_header (== the VXLAN outer UDP header set by
udp_tunnel_xmit_skb()).

This was a latent bug, harmless until commit [1] added a doff validation
check in qdisc_pkt_len_segs_init() for encapsulated GSO packets. With
the wrong inner_transport_header set by xfrm, qdisc_pkt_len_segs_init()
interprets inner_transport_header as a TCP header, reads doff=0 from the
upper byte of the VNI and drops the packet with DROP_REASON_SKB_BAD_GSO.

Besides the use in GSO to determine the header size of segmented
packets, inner_transport_header might be used by drivers to set up
inner checksum offloading by pointing the HW to the inner transport
header. A quick browse through available drivers shows that mlx5 uses
skb->csum_start specifically for this scenario, while others either
don't support VXLAN over IPsec crypto offload (ixgbe) or the HW is
capable of parsing the packets itself (nfp, Chelsio).

But in all cases, it is more correct to let the inner_transport_header
point to the innermost header instead of overwriting it in xfrm.

So fix this by guarding all four inner header save sites in
xfrm_output.c (xfrm{4,6}_transport_output, xfrm{4,6}_tunnel_encap_add)
with a check for skb->inner_protocol. When inner_protocol is set, a
tunnel layer (VXLAN, Geneve, GRE, etc.) has already saved the correct
inner header offsets and they must not be overwritten. When
inner_protocol is zero, no prior tunnel encapsulation exists and xfrm
must save the inner headers itself. The tunnel mode checks are only
added for completion, since they aren't strictly required, as
xfrm_output() forces software GSO in tunnel mode before encap.

This makes the previously added test pass:
 # ./tools/testing/selftests/drivers/net/hw/ipsec_vxlan.py
 TAP version 13
 1..4
 ok 1 ipsec_vxlan.test_vxlan_ipsec_crypto_offload.outer_v4_inner_v4
 ok 2 ipsec_vxlan.test_vxlan_ipsec_crypto_offload.outer_v4_inner_v6
 ok 3 ipsec_vxlan.test_vxlan_ipsec_crypto_offload.outer_v6_inner_v4
 ok 4 ipsec_vxlan.test_vxlan_ipsec_crypto_offload.outer_v6_inner_v6
 # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0

[1] commit 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()")
Fixes: f1bd7d659ef0 ("xfrm: Add encapsulation header offsets while SKB is not encrypted")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
 net/xfrm/xfrm_output.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index 262eea7bdea3..433ce19c2900 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -67,7 +67,9 @@ static int xfrm4_transport_output(struct xfrm_state *x, struct sk_buff *skb)
 	struct iphdr *iph = ip_hdr(skb);
 	int ihl = iph->ihl * 4;
 
-	skb_set_inner_transport_header(skb, skb_transport_offset(skb));
+	if (!skb->inner_protocol)
+		skb_set_inner_transport_header(skb,
+					       skb_transport_offset(skb));
 
 	skb_set_network_header(skb, -x->props.header_len);
 	skb->mac_header = skb->network_header +
@@ -168,7 +170,9 @@ static int xfrm6_transport_output(struct xfrm_state *x, struct sk_buff *skb)
 	int hdr_len;
 
 	iph = ipv6_hdr(skb);
-	skb_set_inner_transport_header(skb, skb_transport_offset(skb));
+	if (!skb->inner_protocol)
+		skb_set_inner_transport_header(skb,
+					       skb_transport_offset(skb));
 
 	hdr_len = xfrm6_hdr_offset(x, skb, &prevhdr);
 	if (hdr_len < 0)
@@ -277,8 +281,10 @@ static int xfrm4_tunnel_encap_add(struct xfrm_state *x, struct sk_buff *skb)
 	struct iphdr *top_iph;
 	int flags;
 
-	skb_set_inner_network_header(skb, skb_network_offset(skb));
-	skb_set_inner_transport_header(skb, skb_transport_offset(skb));
+	if (!skb->inner_protocol) {
+		skb_set_inner_network_header(skb, skb_network_offset(skb));
+		skb_set_inner_transport_header(skb, skb_transport_offset(skb));
+	}
 
 	skb_set_network_header(skb, -x->props.header_len);
 	skb->mac_header = skb->network_header +
@@ -322,8 +328,10 @@ static int xfrm6_tunnel_encap_add(struct xfrm_state *x, struct sk_buff *skb)
 	struct ipv6hdr *top_iph;
 	int dsfield;
 
-	skb_set_inner_network_header(skb, skb_network_offset(skb));
-	skb_set_inner_transport_header(skb, skb_transport_offset(skb));
+	if (!skb->inner_protocol) {
+		skb_set_inner_network_header(skb, skb_network_offset(skb));
+		skb_set_inner_transport_header(skb, skb_transport_offset(skb));
+	}
 
 	skb_set_network_header(skb, -x->props.header_len);
 	skb->mac_header = skb->network_header +
