Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795150060;
	b=wL4NaR44xG64SIRGYRe0rA8b+piVDTdozrzzu1w5BEU/0DLyhPEdAGcGmTKp5t4Qv0dE
	 4/7j51hZD8Hghqe4HbyUNUKcSJ6jjnHg0ejfHaFIi+22rUiE5jJqIDXQ8XFvhR26Sezow
	 hBEBWvLmXk4Odni7gnU5pfr9ZU1yvk2CH0FpBxHlFgY8PETQGGeN7O7GX5OfRok9tsXv6
	 wPxxahBeno9RXcuezRlreQTbA0xbT2fN1UY5eDiWWovkuIrzXD7LMxAeDHa2P3Hdhk9Hh
	 n3vOSrQkSzEK3OKUpfqjklRkhXHfq9ZEBrkD9+T+AkkOAl8y6AE8mVz8rBipjrfdAmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795150060;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=drpsCDXaiHLhj4RcEkagcNMp+O/zmGu9fZ7pDo0rNgg=;
	b=cHifJwVOeMOHJyEQuVb3MlsWwqR5jDVzGg2mAjacqIFcmgkPUO3bexOWKv+GVFzeLbns
	 AhW5CEh8R3o5QUGnGn//W4lQhH7kOQZn8VZ77qUXG5NCwq3XcZLNNreHQicl+47fXknUv
	 Bj7rbDsA5eq2G+g33Tv1qv+8sbpaAzd47bjdbhYVgifYNV4+cXLl6bltYQI4pe4FG02Jj
	 U0/xd7s98SM/DuKtvp2/MkaK3wTWgto7689Zw26z+LDSTPWLX6SoEApZAEnquQyvyiHMS
	 UPmDJgyDDN/JizKmVhqrw5d3Y/7Ulj8nvVfSjzAItmVEtIR+NQc8sjChniKlTOQ251Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="lRVV+iJ/";
	arc=none smtp.remote-ip=209.85.217.44
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B5F60A2600
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 04:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4B5F60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lRVV+iJ/
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-7d2ee9e7093so142441137.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 20:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795150058; x=1795754858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=drpsCDXaiHLhj4RcEkagcNMp+O/zmGu9fZ7pDo0rNgg=;
        b=lRVV+iJ/ygJWZUf8Z4JT+/tpCZXBL3G0Z4EtpecZ5MJMSA+Ew0gmdRcSO0AJ0UDBj3
         3ILy6ZUifzg+C2O/bAz4mJcSujYNx5l5vuG6tFWEk+Dw9QcKGOCmb4/GmgDWgcW4u7gQ
         7Qge9KK/wDvtF+K9FWvOUurXXQarDPwAo1wB0THnfNveoU7oFSB576lEyKhKK9jy1QlO
         1yU6OX52wVtY7nQB3+RgcZqZuK80Nu0w9IYkvF5RTvCmWv5eC9al1Q6AYpzXybRYWBR1
         Zx2YpOuPo16YHygjZPiYWtqhQ/uDxbqFffAHGuEfXNBNePQ2T6JyRP9jCRbjwb5kKmK9
         4rSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795150058; x=1795754858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=drpsCDXaiHLhj4RcEkagcNMp+O/zmGu9fZ7pDo0rNgg=;
        b=l/c0qGD3aa1l2uEKsYq6ZH+z+vcvonYvTn5aOLnmgkaQiz3Iplrqpm9/dvETxx2y+/
         zArbEi8bwesYJgwE6sl5IZBL83+HrhXn0MY/KVXUom/ijWhYXDAuLzvi+EGq/VQA2muy
         uLRICiNAaW/DDof66RQeCm28voZve6GTDvRHnuD64RjuXoPaezkF7RoE56xhbC8+/r43
         PJyf9JudjFYpvSXJLokQYKwdAENTNAeWc1OewNG3dLzbhVRiYptLGTs2Dn8BUjai2WRM
         Ne4nMvOCtsHCSip9/1rIWXRlCAqAsFO5LYSeuCrTE2OEpW7+z8DAtzoFPplnnknUkNm9
         nGWA==
X-Forwarded-Encrypted: i=1; AL+hErF0MjC5HNs1MqwA0NeMtMTFHzFDVuV/Km8N+A5jhvNO9oB8O8kIQ9MG2V39cJXV7RCLO/CVsIY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9X+t84NzWBbeMqsoqiElAX+imeOOslaCe8MNVEUKRDx/iDDbdB
	fXpGdnyVmAhegpur2sBaM8jOFhjl1kIy1JdiUKhdo+39V/VqD8l1NgTj
X-Gm-Gg: AZFdTZfVDZ82kPMDlrpw6yEbmp9u+vgC1elwFO1S39rcvJd86JFJFMn0Ue8e7jyMUyg
	FP+C2nmJFU2Fr+iJ34vHB5m7bzUteCfhk3/xcLhdXgk1+EFv26USbdUWd+MxazTeZT1YbqSgma9
	CMKf7hMMOH4RN07cDDLjaDwF3UiCbfUCwBfW4z5p90BGqJ7L7LXHwPeHpKtEbiuRA8dAaYRPbuZ
	tLCmtBcmj0IlHnHJwPjQabRzPSbDfuinHDavnD9HcMgvUKlea1J5Rz1V72J3GYrYkM9PreSXk8i
	d3koP1wMsHLzDdEyMRrH+Ldjk+nQXA0+hA76ZTXa29EGUMPfEzgm7jzYKSmFyj7DhglnV2F+1LG
	i/PZ/P7sYoeqfF2/x+5ikcSZYe6XkWKVbFpIqoYixqkvlbpsftOpnUBsJ4tTr9NBAwOF+i7xh69
	ijhVAMTFjv6VP0+wpc327EvpByh/PF+1MNAlmLM0PTO4Mlz29ddW71oU41c8jehvl8N3M2f6U7X
	QOFx2UUrf4raGD7CjPeV/Tneyf01zJckYMm6kRfRpDgxiUEB94v/hyfuoFvNr+kuorjukiC33w6
	YRKDQU+sR53JtIukCtIuxYavdHTxlDoU5soJKybfpPpuzH+bHWGKqGJKpextJplSdbOmkMyo8x6
	wHYCys/7ih/3uO0Ws5Jbp7LmsRbm+1F/c9OvurvEHx67a5tBVLIqXQvLUl3rWcs0PMeH9HJbrYm
	9PkUsyWQVkNg==
X-Received: by 2002:a05:6102:4485:b0:7a6:cd7e:72db with SMTP id ada2fe7eead31-7d73962b3c7mr669077137.26.1795150057730;
        Thu, 19 Nov 2026 20:47:37 -0800 (PST)
Received: from willemb.c.googlers.com.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e7f92680sm1966811137.5.2026.11.19.20.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 20:47:37 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Willem de Bruijn <willemb@google.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/2] net: gso: cow head on tcp fraglist fallback to skb_segment
Date: Thu, 19 Nov 2026 23:46:39 -0500
Message-ID: <20261120044733.222627-2-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261120044733.222627-1-willemdebruijn.kernel@gmail.com>
References: <20261120044733.222627-1-willemdebruijn.kernel@gmail.com>
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

From: Willem de Bruijn <willemb@google.com>

When tcp4_gso_segment() or tcp6_gso_segment() cannot use
skb_segment_list(), they fall back to tcp_gso_segment(), first resetting
th->check to the pseudo-header sum. This writes to skb->head without
unsharing it. If the skb is cloned, e.g., by a packet socket on a bridge
port, the other holders see the rewritten checksum.

Call skb_cow_head(), like skb_segment_list() and the UDP fallback
already unshare the head with skb_unclone() and __skb_linearize().
skb_header_cloned() is equivalent to skb_cloned() here, as GRO does not
set nohdr on the head of fraglist skbs.

Discovered by an AI code review agent. Reproduced on an unmodified
kernel with bridged veth devices and an AF_PACKET socket, and verified
in virtme-ng.

Fixes: 17bd3bd82f9f ("net: gso: fix tcp fraglist segmentation after pull from frag_list")
Cc: stable@vger.kernel.org
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv4/tcp_offload.c   | 5 +++++
 net/ipv6/tcpv6_offload.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index b84fcd07c723..520778c5ca7f 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -106,11 +106,16 @@ static struct sk_buff *tcp4_gso_segment(struct sk_buff *skb,
 
 	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) {
 		struct tcphdr *th = tcp_hdr(skb);
+		int err;
 
 		if ((skb_pagelen(skb) - th->doff * 4 == skb_shinfo(skb)->gso_size) &&
 		    !(skb_shinfo(skb)->gso_type & SKB_GSO_DODGY))
 			return __tcp4_gso_segment_list(skb, features);
 
+		err = skb_cow_head(skb, 0);
+		if (err < 0)
+			return ERR_PTR(err);
+
 		skb->ip_summed = CHECKSUM_NONE;
 	}
 
diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
index eec3778855eb..0914f95f100c 100644
--- a/net/ipv6/tcpv6_offload.c
+++ b/net/ipv6/tcpv6_offload.c
@@ -178,11 +178,16 @@ static struct sk_buff *tcp6_gso_segment(struct sk_buff *skb,
 
 	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) {
 		struct tcphdr *th = tcp_hdr(skb);
+		int err;
 
 		if ((skb_pagelen(skb) - th->doff * 4 == skb_shinfo(skb)->gso_size) &&
 		    !(skb_shinfo(skb)->gso_type & SKB_GSO_DODGY))
 			return __tcp6_gso_segment_list(skb, features);
 
+		err = skb_cow_head(skb, 0);
+		if (err < 0)
+			return ERR_PTR(err);
+
 		skb->ip_summed = CHECKSUM_NONE;
 	}
 
-- 
2.56.1.750.gf70dc682cf-goog

