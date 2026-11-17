Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794943685;
	b=tn4XE53E+mMlcnuSXTucSNR8fCLoCzSs9gjNiAiQC0JAynfz8hEQleaEEJidUlFsm4li
	 ovhxlmEzrcOl4d2wfxREv3h4V4u9xb+wtD9bmP20EYfLa/qxdnSMDu91bOzLAOZlE19qm
	 Ch3/SVcS/uwxDlo4S8ggXZC7K33jIRLCSpW23j/tz13cykmLjcF4l9DKD+VFuZb39mVbg
	 dshln0sbz6Kx5fkRn7SXWPTVfjkRKF3c17tnFZXj+yg7qrtq7VLfyL2JRby4ALCW7bXxj
	 zR9alKDUbAMnjuXPlw3z1pU90O2aEI94LMF0MSGOu2w2cgmgO4buafMxLom6T9ZGMsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943685;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version;
	bh=QQ/iT9XMRjvb+CJ/YdA/w+zP0SyApH3w0cvhQ8OnPdE=;
	b=GionMB0cJoquHWVpwgeli+ervXA829VC8+PwZ+nq+2BaAYQDQulV9cSB9coUGS+H2UQ8
	 Ve3A3YQhKZXPR1OEoUAggvjqgH814zTlDbeQha1zAr6nAd8xWXjhpfZ80al1Q5+Z3oDYt
	 cOiosgNknMAb6VCnWTRDoYRyOD08xzKwIBRccPAI+4LkTd7fyqURwtVt5MeUeNeYi48qW
	 etLER0ciKPCqoY0LppduwKUqs55u9wEQgo+Df3Qx8OI4UYWarGf8zdHvI2NrVefhnjRnf
	 97Xn1es31aSq4v7UiIitouA5DBK08YtWVymNAFKZNGyW2uEb5P36e0HLu6N9M3DeXrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=NaHmg8am;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4888E606A31C;
	Tue, 17 Nov 2026 19:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4888E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=NaHmg8am
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AHJ9rPc3914158;
	Tue, 17 Nov 2026 11:27:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=QQ/iT9XMRjvb+CJ/YdA/w+zP0SyApH3w0cvhQ
	8OnPdE=; b=NaHmg8amMGPnZqS58P55byRr87/6Tu9iPaP+ZDnLrzUfZ0qlAaJ4u
	UBvSAgRMxfWZTUNIIYE79JsODPn68UicIo3N8zQApzoWR2LtQCIzt5AVn0EOea6z
	gt0uw+9rrl4ckLiOH8IV1odjNr0OmZU5MClwf4CuTyNldvx7uAyYe/H6ISGO5L4Z
	n4YywghqD/J/7eQQrpmE/9JFiy12VRQd2Bv32HWJ1mMIZsyfhgsRcEpKyuO7Ktn8
	B6jo/TBMjJ3J7KRu3DcWKj7M8k7iw7PHhnrZNL2zWlSoMj1v5J0VvVJW6V4EJrDS
	R2+sml1a5BWqyS+dEGpqJ5q+saKMd7DrA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4j0p7y4cx9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 17 Nov 2026 11:27:24 -0800 (PST)
Received: from localhost (2620:10d:c085:108::4) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Tue, 17 Nov
 2026 19:24:21 +0000
From: Todd Freed <toddfreed@meta.com>
To: <netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Daniel Zahka
	<daniel.zahka@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Wei Wang <weiwan@google.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko
	<jiri@resnulli.us>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav
 Fomichev <sdf@fomichev.me>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Boris
 Pismenny <borisp@nvidia.com>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH net v2 2/3] bpf: don't redirect decrypted skbs from egress to ingress
Date: Tue, 17 Nov 2026 11:24:10 -0800
Message-ID: <20261117192411.247117-3-toddfreed@meta.com>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <20261117192411.247117-1-toddfreed@meta.com>
References: <20261117192411.247117-1-toddfreed@meta.com>
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
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA3NyBTYWx0ZWRfXxwU60u2yZ0ko
 UjsBYLZobfj6bQd5zqIbz0rtEPTUs8vBVqYpy/hZun+Q2OZZlAyDMCxUhgczjjU/DfRhTe8SvAO
 cR/toSEf8/zuFZEYQLyM6lhSxrh94ilD1OPQTzF4WrgR+UOeSg3kXl0VTT1lAj4HnxQu6MdWV50
 8sIYtp//mmMMgavG1EDqkAjrkA7UfLgCMGNAKVfLia13UZSIzlzmx4ThVfzqP/Nd5Nkattb/AI6
 GsC8PTYEXYIPvJrxNGVj0tDiEmM4xCiUf+eDLrmu+INXuzL7uerwP1hqKatlhWMSjGfXpBetlqe
 9Kd8RXOYsCFe3NvzJWyQGfZT0m+dKtYSRApEQlhsICwM0MjNdOwQkclSh7AToUTGBimCjlcO9SZ
 mHgBsE4sK9EtrHenLGdXct/uq2pd5b91oQTAihed/+yCyLCPIA9l9tooTlqaC0UMNqVHAZSRSS0
 K7KUF8KfbuPydh2A19w==
X-Authority-Analysis: v=2.4 cv=bJyDs/+Z c=1 sm=1 tr=0 ts=6afcaa9e cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=855S8uPTkML1Oy45N9_h:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=P5U4b8cfyem6Y1jgc2cA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: rxdXGiyJ2yFCWB3pvXeQiboehAGVUE95
X-Proofpoint-ORIG-GUID: rxdXGiyJ2yFCWB3pvXeQiboehAGVUE95
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA3NyBTYWx0ZWRfX5JCi0q5WeCDw
 XOVKr0U38Ixzr6uToz00lerrhABHwHOm12QfZDCMfqxZOWTeJvbYj7GZe+RaFxokXtDDZDmJwSV
 YRS57iogxryZ5Sc8MRWdyRLSW9kDDlg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_04,2026-11-16_01,2025-10-01_01

On transmit, skb->decrypted means that the device must encrypt the
packet, e.g. a packet of a kTLS or PSP device offload socket.

On receive, skb->decrypted means that the device decrypted the packet,
and kTLS device offload trusts it as such (tls_device_decrypted()).

bpf_redirect() and bpf_clone_redirect() with BPF_F_INGRESS send the
packet to a device's receive path with the bit still set, where it claims
to have been decrypted by the device, although it was never encrypted.

Drop decrypted skbs which bpf redirects from egress to ingress, as mirred
does since the previous patch.

__bpf_redirect() tells egress from ingress by tc_at_ingress, which is
only kept up to date in tc. It is also reached from LWT xmit programs
(ip route ... encap bpf xmit), which run in ip_finish_output2(), before
__dev_queue_xmit() clears the bit. A forwarded packet can still have it
set there by the tc ingress hook of the device it came in on, and would
pass the check: whether the packet is dropped would depend on unrelated
tc configuration of its input device.

Clear the bit before running an LWT xmit program, as __dev_queue_xmit()
would right after. This also gives the program's other uses of the bit,
in the redirect helpers and in its __sk_buff->tstamp access, the egress
view, which matches where it runs.

Sashiko found the LWT case when reviewing this patch as patch 7 of v1
of the net-next series "psp: introduce socket-less associations", which
it was split out of.

Fixes: 414776621d10 ("net/tls: prevent skb_orphan() from leaking TLS plain text with offload")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/netdev/179471270091.2199510.4320994626979041884@kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Todd Freed <toddfreed@meta.com>
---
 net/core/filter.c  | 10 ++++++++++
 net/core/lwt_bpf.c |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 946b07a17fce..defbef3a9f75 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2226,6 +2226,16 @@ static int __bpf_redirect_common(struct sk_buff *skb, struct net_device *dev,
 static int __bpf_redirect(struct sk_buff *skb, struct net_device *dev,
 			  u32 flags)
 {
+	/*
+	 * On transmit, decrypted asks the device to encrypt the packet. Sent
+	 * to ingress, the packet would read as decrypted by the device.
+	 */
+	if (unlikely((flags & BPF_F_INGRESS) && !skb_at_tc_ingress(skb) &&
+		     skb_is_decrypted(skb))) {
+		kfree_skb(skb);
+		return -EINVAL;
+	}
+
 	if (dev_is_mac_header_xmit(dev))
 		return __bpf_redirect_common(skb, dev, flags);
 	else
diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index 72c86ff2a847..4861fe2b4959 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -13,6 +13,7 @@
 #include <net/gre.h>
 #include <net/ip.h>
 #include <net/ip6_route.h>
+#include <net/tcx.h>
 
 struct bpf_lwt_prog {
 	struct bpf_prog *prog;
@@ -327,6 +328,13 @@ static int bpf_xmit(struct sk_buff *skb)
 		__be16 proto = skb->protocol;
 		int ret;
 
+		/* The packet is on egress, but a forwarded one can still have
+		 * tc_at_ingress set by the tc ingress hook of the device it
+		 * came in on, until __dev_queue_xmit() clears it. Clear it
+		 * now, so that the redirect helpers see the direction of this
+		 * hook.
+		 */
+		tcx_set_ingress(skb, false);
 		ret = run_lwt_bpf(skb, &bpf->xmit, dst, CAN_REDIRECT);
 		switch (ret) {
 		case BPF_OK:
-- 
2.53.1-Meta

