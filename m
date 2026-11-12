Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794452857;
	b=uoRz5D0IxeKLjQKYE1veyHc7bOEh6dazmcaKhtPh8OKBo41RQTgTKDGoO4EB993b/c8g
	 qnDNoVVSg7bWMSye+xMwSzlIsbsmpfVbmJiMATdWY4tF9DnnRm078BniDf+7XsS6NPY7j
	 zmilzIMjukeKqq7Tjh9K7BVh0VlsRFDZH9g/D94SxQoPkSSFKJhKaKEzPt69PnjFS8a9w
	 H1n+PsQ//7orULn0eNSDBrdD633SjUqygST8okj5czTkrldTEUCq9jaWMnTaHlr9tyKm+
	 6HuJ0O8sOgYC6u3Wo4JyTyDZbVqbxFcsgPbJ4UZjCbLJ0336+W0S1tEc4u0mySbfCEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794452857;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=W4w+LR0grSfC0O6TJwPlVRz1HHrBafoWQKAdK1CwzPg=;
	b=jbrFU/mNo6QdMqn6Maj+ANdamHaJ5JUzzmxpgG6wS3xfsDSVeb1OyDCgVv4vxP8W5HKj
	 7Didod+JzjcQmfF0UyDPCzNKvt2kx9qZtXX6iJWFCVXmPPi6ZAe/Uk25HHm7u0zm8Q2nU
	 /wJyw7jzMcqCnfae2eErzrs9bZpEYmfOW4dim19xI2VuXsirFMb8/kWbsTdchvqXIGz9w
	 YIPe0BerUAogCWLgxkvLymyFPmNASX46mwXVpHpgdGg3TF2py+u/bY3U1py2kS+Ra/wtf
	 Pw3Yq2HbUVpEKLa6m/BBHz2mCovxAOVVmb+qdRe8JpRr5d2jR33+xppFJjRJf0Xg8Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=fryer.io;
	spf=pass smtp.mailfrom=fryer.io;
	dkim=pass header.d=fryer.io header.i=@fryer.io header.a=rsa-sha256 header.s=fm2 header.b=NZ69qV2i;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Wzgwxjq+;
	arc=none smtp.remote-ip=103.168.172.137
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF20606A332
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BF20606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fryer.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fryer.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fryer.io header.i=@fryer.io header.a=rsa-sha256 header.s=fm2 header.b=NZ69qV2i;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Wzgwxjq+
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id E4C6E13810E3
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:07:35 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 11 Nov 2026 22:07:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fryer.io; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794452855; x=
	1794460055; bh=W4w+LR0grSfC0O6TJwPlVRz1HHrBafoWQKAdK1CwzPg=; b=N
	Z69qV2iBvajp6deZIzmDmrygTctOQ+PZaEm8XxAjWNW+Z5my/K+nbfRmfzN3dabe
	Qmb910svAoG8+Li+8P1QLX0iqPZuBuOzLtxwqhfvei1jqrzVmGnTdUY4xrkN9EWY
	ooqg39XKXxaIXPt/4kT1MxcxO2ncsX1w7iERYAAcEjzztQ4nVuCeJzVNEV+I7WCX
	gXSbC5dF2NTymyw0Ihi9/s3B1HYaV4+SFyYz67bZpcCH7P0f0syrH22ml3WHRRUB
	o1yoLyd0gT/tu3N1DlymIxAXl6CGhT9h3KaCHC3RwbEReJF/Zyx1FXGI0FqayF/G
	sGpEu4CmAREsltr7C1GSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794452855; x=1794460055; bh=W
	4w+LR0grSfC0O6TJwPlVRz1HHrBafoWQKAdK1CwzPg=; b=Wzgwxjq+ChCgZXSCY
	y4rnZNsh1BFCqrWGSBuertcLV3Ib8tk+Aj6HQg4N6simXNtIIx6aAuDv684NxKx4
	JzGINmYKC0AdKMDKkdri6S6GoIiKKihiIjqmDE/1U6Shspymz7SnEriodSAmDCrw
	qvfuKUgW0o57gQTqozieaYUGWj0s6TVRJA3vdH1XZ9HLUhngv2jtzHZ1u4zuQKwx
	uquMwXeAbURc3kS9/2H6LLH6bPaGWOtq/5KYwbvyRbi72GUAjDz9TYxrTC5nHZ0m
	6+29twJYA9kSp0NXuhS7vxpIsphxEFleVAuj7dC15+hPisReoqduFGZ1nPAuDcLk
	DuBeg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fryer.io a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794452855; d=fryer.io;
	mf=PGJyeW9uQGZyeWVyLmlvPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:nlLgvFnFYwcR/oJp/giX6aWZDcATYXQEIJOVBL8/R/S7j3V
	iRkq8v1w+59QM5WWrXGYW9yqzFjans5EGhYpQ219/wSm2RuBvk2qLM4arfJ6CUA/
	Jo7t4du/uazVfMsAc/jEiR9B3k/am4+hk+g1ITB9m3/el6O2QceHylp+unWCu6Oo
	PRiS7l4IP0JWyf9CVKP0CDRUep+/mOGZe5muZVUW7GtJDGNjF+0tLlkghlgiDAT/
	wQMMnQpMd9p3TyWlBqPe1L8MjUdZi5H5JWpAiYiz8qSD17KTl16Gal6g6THjVRbE
	3/ZLK4JaIKT8pHSXYhfPAucyoSYC1d/UEqdHpsA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:k7wPwrYvyvpzLNZ/0y5EIsU/XZqYq5/Nju5XaWsrbCM=:JBc6KQ6IxtrqHD9mNQnOsmUcoTqyjMBA085J5ndHNr8=;
X-ME-Sender: <xms:dy31agDhqpseTQQZ4tJSV05DPf0hyInPXoYt_pQypURfBOYm9DLK-Q>
    <xme:dy31ao5LUoyJau_BaZGvUHqYI0h767t98wPSKob7n1aNxmCm_wPqKCyyRM5xYPuxl
    fffOWZ0GWIsY_NrbxdP-UcS1M6VwLh--za_GYYZb7LAXIWJMy8SkRc>
X-ME-Received: <xmr:dy31av3gw_ZuL22XkhRo985Wdv0Yne_RxEVMd-ur0dsfol3pF80ZeyuNILZgr4uKq8JbJQ4XSPgh1GckgD_sbnxL_OTBAAoIIiClclFZxFb9pQ>
X-ME-Proxy-Cause: dmFkZTGn4y472hwTpe0VefQ9vF6vjRs+S6AXwSoOWMbjiC/uZXq2edNbyg2XuH2GbZoVEn
    Mfc3dHq/e16zcvkdgOotSr2vncmijHIlb5c/sbSEhrNX5JLVzUK1MiRHjeBC1RWX2P7BNt
    P0xzYOJOD7ntazzpmUzSnTj6raAPUGDWbljxtqbtDN8hq92xEvBPfJH3EQES5jyGjh6mqE
    2QjOLhd+/a5qWNQ17PxOpwiD14xyDv//jdxKoBFGf5YslEWcSqSzIJGYGVcVEyLS47SUWI
    8TJldhvRJM8LegqWRKxABWK47qwvdsIlpEUL32KXFNQUqi9qGq6bv4+q3Nd5faq1+QpWUA
    3fuIPW7oVrKrdwGx/6b93cQ11NmSeABuPUHsGv/9UTyofd3Y3KYhhRSXCHjsGPr+R732mT
    KJXL6h0/P5Lxh0Mn/dp4bLUgxV8ekMnoWjKuJreKLVRIbvj8oSltNTtD2ff82rb7xz047g
    px7DdGKmioasVPku3jXv897VcZBdYkgjeRgHcrETwBX/O87rXxL/V7A6cF/MbRp5Dhj2QM
    3AvjNIawgxlpKk2EhHeN3QwZY2ngeYlS4qgFlmH8ZZs/11YMhZE59Il+QjsyHtSYRMSbe1
    pT/CqMoULKWE4bUJEWnnNYrtUlEZZ3N0NwOQCMlGSy78ZYK/tOdspeRloBXQ
X-ME-Proxy: <xmx:dy31akm5M0LEPuEMBfeGeRl0sHzej-ZHDWqOYw_IPWfzFYCy3m4p-Q>
    <xmx:dy31at6Es15GGqymxiKOTbkr-gB4C4szpq4jwFnwwihXbJOjUzxRKA>
    <xmx:dy31anlSIaohm9LES8gpP51W_4XeDrrO6Ty2TTmC3m2adb-Mg4Z74A>
    <xmx:dy31aoW2ws_iz-WCBqOxU3oW6mbfFndboyA-4W7z_LDdcQWN-Nm4MA>
    <xmx:dy31akTBETxIuSBeHK-u7GAn4l_LXDUburmxZk3aSRkwRuRez-9iXaM5>
Feedback-ID: if1c946a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 22:07:35 -0500 (EST)
From: Bryon Fryer <bryon@fryer.io>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	horms@kernel.org,
	jasowangio@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] udp: restore outer transport header after tunnel GRO
Date: Wed, 11 Nov 2026 22:07:07 -0500
Message-ID: <20261112030708.1915665-2-bryon@fryer.io>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261112030708.1915665-1-bryon@fryer.io>
References: <20261112030708.1915665-1-bryon@fryer.io>
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

UDP tunnel GRO can produce invalid virtio tunnel headers, causing
virtio-net to drop whole aggregates. Losing several TCP segments at
once causes retransmissions and can collapse throughput.

Observed as slow VXLAN TCP traffic with kernel logs reporting dropped
packets. Reproduced with ordinary tunnel traffic in disposable VMs. The
unpatched reproductions required no kernel modifications or error
injection.

Inner GRO processing moves skb->transport_header to inner TCP or
UDP. The inner completion callback saves it in inner_transport_header,
but udp_gro_complete() leaves the main transport header there too.
The virtio tunnel exporter added by commit a2fb4bc4e2a6 ("net: implement
virtio helpers to handle UDP GSO tunneling.") treats that field as the
outer UDP location. The exported outer header then appears after
the inner network header, so the receiver rejects the descriptor.

Restore skb->transport_header from nhoff after successful inner
completion. This parsed outer UDP offset retains the inner transport
and checksum offsets without assuming fixed header lengths.

Tested under virtme-ng with socat sending bulk TCP over IPv4 VXLAN
and Geneve between network namespaces. A raw sender TAP supplies
wire-sized packets to a TAP/bridge path with ingress GRO. Exported
virtio headers are relayed unchanged to a receiving TAP using the
shared virtio decoder. Kernels used the same base, config and toolchain
under KVM. For 32 MiB, median transfer times and rejected aggregates
across three paired runs were:

                       Before patch          After patch
  VXLAN, GRO on        69.8s, 1418 rejects    0.15s, 0 rejects
  Geneve, GRO on       70.8s, 1414 rejects    0.16s, 0 rejects
  VXLAN, GRO off       0.22s,    0 rejects    0.23s, 0 rejects
  Geneve, GRO off      0.23s,    0 rejects    0.21s, 0 rejects

Rejections are receiving TAP writes returning -EINVAL. Median TCP
retransmissions fell from 2852 (VXLAN) and 2854 (Geneve) to zero.
Every transfer verified all payload bytes; no TAP queue drops occurred.

Separate eight-packet tests measured these outer UDP offsets, in
bytes from the Ethernet frame start:

                                      TAP-exported outer_th_offset
                       Actual UDP     Before patch    After patch
  VXLAN over IPv4          34              84              34
  VXLAN-GPE over IPv4      34              70              34
  Geneve over IPv4         34              84              34

The inner network and checksum-start offsets were unchanged. The
accompanying TUN regression fails only its outer-offset assertion
before patching and passes afterward. Selected existing TUN and UDP
GSO selftests also passed before and after patching.

VXLAN-GPE raw-TAP/GRO-on software segmentation still returns -EINVAL
before and after this patch. This is a separate issue.

Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tunneling.")
Cc: stable@vger.kernel.org
Signed-off-by: Bryon Fryer <bryon@fryer.io>
---
 net/ipv4/udp_offload.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index b77ae2f00c..1a1d1a125d 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -948,6 +948,8 @@ int udp_gro_complete(struct sk_buff *skb, int nhoff,
 		skb->encapsulation = 1;
 		err = udp_sk(sk)->gro_complete(sk, skb,
 				nhoff + sizeof(struct udphdr));
+		if (!err)
+			skb_set_transport_header(skb, nhoff);
 	} else {
 		err = udp_gro_complete_segment(skb);
 	}
-- 
2.47.3

