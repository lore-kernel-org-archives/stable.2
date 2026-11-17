Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794943797;
	b=A/QrtbYt0CPFToXF9DMpxW86iCqjHkPbWc5EJm8j3YSc8Fyn8TlMD61td4QhlgNilVp4
	 e95gD0KgnxvN33R0lw6kXs0PBczGbs2l26OY1Xa53NA0tl++VlLCgeVgjvRPPsPZrEhOt
	 GofvUY53UceoZlDplMHq+fr7eK2oCE+GkFaoY/48QYGk+cI8QjEVRaegXHMBogOx+kTiJ
	 F0QQsPWfc0+sgXxmOXVr5EKlrIOm30h8ImJk0aNIZyMC1vi29DvCFdzt21przMby+i0JY
	 6QpZxn8PBuyyQcY8y3ukofGr5JAYCyB2DT/fa8yU70fufRfttUs5xEOo1Qd8x6r3Oag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943797;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=OWqH00++mg9kkwn2r1Ks4wuWW+kQ0mHIAqRr+Y1JNmY=;
	b=B0FRA3ESD7PtsqMSCycdQBvQu1lVdfShXq3Ku+jr+dZyi70CFnHfr6PObOKq3n7ZWdJz
	 xmXdd1O70FkxHcHCP/bQvtRgS+d/D6QJy+TpsoJ/hcpEzaxVpfgKrsl5S4GBrnncUPrkX
	 He65qB2bhtBuxY6223D9jcxRPS98RlGVDzz5gH7AdRm8+Ls0s0z99ax27OVfj40QciKFR
	 1zceJoGYkZTPfrexVg88wZO/nrb0bRxwcR8sQldizHiz2juDwUyBArTofL02lJYoF8YuI
	 L5Z0pQJornuo5Peyyr8ld2KRNWOCa4EGhVMvx2ODsSrZI1f3aflll6a/wLP30t5HDMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=GsQd7bgO;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF699606A32C;
	Tue, 17 Nov 2026 19:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF699606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=GsQd7bgO
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHJ9R8t1553199;
	Tue, 17 Nov 2026 11:29:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=OWqH00++mg9kkwn2r1Ks4wuWW+kQ0mHIAqRr+
	Y1JNmY=; b=GsQd7bgOaUnqRtITDliJAEm/ATxEV8kQ0RdD5qaD564IlAYnH+xOk
	woFL4S2NOVdkbqdNegALdcm326GPAjlpJEnC3gaQkTXg4fn4gPF9MxF80X257kpW
	qbMjU7AavkkUjWkMRgvJaQcr+ZkLl7RAizgRUqfKQ3ZEVSFjqz2CixuedIzxn2hx
	J4YGFmd4iIQQ3OooCHjXcHMLr8ZIQyZoEMSD0QQh25S2uopYH3HQlLfQEM6X6Mse
	L/hvZmUvqkJohIjhiaAP8amMz2N03cVPZ8YgMNgKCp7/A/SrrGrMyr7DwJf9Vhlx
	OS/h6/ExR1nG75C0fl4TwQg/34uZvSheg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j0px5m30v-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 17 Nov 2026 11:29:19 -0800 (PST)
Received: from localhost (2620:10d:c085:108::150d) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
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
Subject: [PATCH net v2 1/3] net/sched: act_mirred: don't send decrypted skbs from egress to ingress
Date: Tue, 17 Nov 2026 11:24:09 -0800
Message-ID: <20261117192411.247117-2-toddfreed@meta.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA3NyBTYWx0ZWRfX5uTgEzDd1ITt
 n3ScVxOA0XTAwYcAHPxTse8UsSTVQy+qqcJclB4Gy2/KFH1MNQqh5D3ho6GpeTnb4Ylcjg6r/CQ
 jz0ArvvrjNqrHA2ABc3olYY5NRuHPww=
X-Proofpoint-GUID: 0_5-0tuWtdIcgBQ07Bp8PTztKq5mZKzu
X-Proofpoint-ORIG-GUID: 0_5-0tuWtdIcgBQ07Bp8PTztKq5mZKzu
X-Authority-Analysis: v=2.4 cv=adD0Dhot c=1 sm=1 tr=0 ts=6afcab12 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=wpfVPzegXHpEFt3DAXn9:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=A7XncKjpAAAA:8
 a=OYNTlRyxvniuHvjL9cQA:9 a=gKebqoRLp9LExxC7YDUY:22 a=R9rPLQDAdC6-Ub70kJmZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA3NyBTYWx0ZWRfX9g9zbFmNPjDD
 q6h1tmqh7J2UcQXhe4V75zWqCfc6E/PMlkPklnWbko+dprxQVDSfkpp6E6ef7ze5ucvEFL59h4f
 FlUWyVtHKXzvYbbzYwNyXitIDsQPCUzPFNRFgMsJB5zkzzmJSfEB4iqki4f9OMnqEbkPBEoFsqO
 IQpKMVuxW16J0BKyx3zx2QCXPpjhotLa3qZimBN7Mf33Igb79bvi6EURaYVNOzMl78LtUmvEMDq
 99SElCUOkccrVw5G3bXtz1I4QCMKACw7akR/59fZVBDKL6F23sNxg4LmjPRjaz2mKOBFZWfaHU8
 0Ex8nIm1crtp3bdlfK3TbMq8Q0cjERgGg99H1Vs9TJx2iHjKxPYjxs6xT2Eex9JVkSD42MwRj9R
 tTA6d0cOwixgg8i1clrFlTDzJS37syUoTNG+OVXLJTDmF3/XZTW5FlVQEo0JU3I0B7cWwSAb97n
 Cx/rb2IXnYQiMi6PQSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_04,2026-11-16_01,2025-10-01_01

On transmit, skb->decrypted means that the device must encrypt the
packet, e.g. a packet of a kTLS or PSP device offload socket.

On receive, skb->decrypted means that the device decrypted the packet,
and kTLS device offload trusts it as such (tls_device_decrypted()).

A packet which mirred redirects or mirrors from egress to ingress keeps
the bit. On ingress, it then claims to have been decrypted by the device,
although it was never encrypted, and its payload, which was to be
encrypted before leaving the host, could then be forwarded in cleartext.

Clearing skb->decrypted would not work, because that is what indicates
intent to encrypt the packet.

Don't send decrypted skbs from egress to ingress: a redirected one is
dropped, a mirrored one isn't copied.

Fixes: 414776621d10 ("net/tls: prevent skb_orphan() from leaking TLS plain text with offload")
Cc: stable@vger.kernel.org
Signed-off-by: Todd Freed <toddfreed@meta.com>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/act_mirred.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 1c98e4d81ebe..52c3eeab381a 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -285,6 +285,12 @@ static int tcf_mirred_to_dev(struct sk_buff *skb, struct tcf_mirred *m,
 		goto err_cant_do;
 	}
 
+	/* On transmit, decrypted asks the device to encrypt the packet. Sent
+	 * to ingress, the packet would read as decrypted by the device.
+	 */
+	if (unlikely(want_ingress && !at_ingress && skb_is_decrypted(skb)))
+		goto err_cant_do;
+
 	/* we could easily avoid the clone only if called by ingress and clsact;
 	 * since we can't easily detect the clsact caller, skip clone only for
 	 * ingress - that covers the TC S/W datapath.
-- 
2.53.1-Meta

