Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792671376;
	b=a7Vhn5eiNXUcW3iNBpRX0QknbDTK5vd/vtxWWhfhlDD7whu8AVCs4dGgSAY1tYvlhSRz
	 VpMTXqwwY6jxtZvwDjmKaRX31DkYmaioLLCVOBcRkppU/PLqFW9DPKmu6bdmaXXiUbJhh
	 Ggs98vMEurJIIXAt8zyIpp375tEz6X0dm7Scl9OMboH67vibUVsYE86blRQng8Kv6Fy57
	 eS2JxLdQGpX5JBJtDpFOUzFEEWVyyLA/WqWT7cMDmiUPdCRmhBhJ8/O16E0ZaKgy7GcaI
	 I28JifrnLNVznPLiSW38wOZSY+87GMSdqJSyRAlWBLm2pX9ox/VfxOSeg7zFJFaVIag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792671376;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QghGPR/3/DIEb8GdekTUB3M7O4FFtkChEXbGiR5SBcc=;
	b=wvaGOf5r4ZNHYnn2iIbmUYxxEnU1wLYQZfy5+BfkjVe0FE0VL6Ei7swmOgGX14gTD8K0
	 MIKSWCO3qb46nofjRmkYMGr1P7BSrMRUwZfa4+I4+f0R+oJisqef1kZTUMxl0fnd7mwWu
	 +2DWKvlvexxLGaYS5wF3BlSBn66ZgKv/nFZPJZpRIi0fJQ3js/ldWm1mHLALzX5GZWnoj
	 ia86SFwFoXzqXmvSiz8FFIa8d/rEbkJTrZkQestJVyybB+ZIpX6LOBqafEyX0UJPuA48L
	 RbI9MjeQ4TivzlEx9/Un3Ud//Yi7HlOWJxALSm5/Z4qWxruwJmvH6i6+eoORkwAbLDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openvpn.net;
	spf=pass smtp.mailfrom=openvpn.com;
	dkim=pass header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=WZRsGfJU;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B93606A32D
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 12:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58B93606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=WZRsGfJU
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a1d75f2f11so13520055e9.3
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 05:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1792671375; x=1793276175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QghGPR/3/DIEb8GdekTUB3M7O4FFtkChEXbGiR5SBcc=;
        b=WZRsGfJUpVNXBGMQWbCXdQKadk3+tpNPppya8zsIk99jHrr9mSbpsUhQO25vbasO0f
         j/zIXXS2ds1QiQ+atXOOVWa+gCYakhWCtmCz/bT7NBTqDXiuq69+rVkjMtxAFxR9+ft1
         LDc9C0WH8XPVXxXL1bLagY8vq8ZEla/Ol8wJJW3A36RcjnbVAa9nSkMcR9j/VyeC8MXf
         xjqz9Maz8lbmMDW/b3zxHpV1tZHBNSzf+F5eBTh2U1cxMLJKEy9eu4bZ6UqCpLw5nfq4
         mtO4Ko9R7nnS45bDqOFtXSullXx2dv1Sp9BJIAd7OYK2ir3HxGERszYa2/kK037RXRpS
         uJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792671375; x=1793276175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QghGPR/3/DIEb8GdekTUB3M7O4FFtkChEXbGiR5SBcc=;
        b=A9jCfdRtKg3OE247+GOxTtsNvLVTeEDy2eyKG+YVKRpuF8eI+VNqSj01Au+fJmenmp
         2nPIRnOWwK5wqmrGZsqRBLZjI+3Op4brs8iwlHM3fXC7kNyeAGQKRWy+IN2vSfRvilze
         9p2J86aMFbwQpVWDECa3ZBI6hNQIAhyTxzQHFyM3FsD9lGb+8GSZCRBOtYVulWM36guQ
         v1iK0nfQtvKlw3PZ9ceIMihBBAY+C1odjzPmn86S9giVPpdPVW6R5SpJNMWt32ikNEXh
         UBeEgj6Ng4hsrOwwvE915o0x1Wser81rrmrVNQMqUiku/NS01hEXvtSKnhFHY42a7Zto
         UB7Q==
X-Forwarded-Encrypted: i=1; AKwUvBzwsE0S6bUbpJAbmAAZ4UCzEJw1+i7G4QNtQDHA+qOICHnnlgw4VUor1cdEsYJOgJPLOUbso7Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYKQrue/3aA0IA2Ch5XFUlZeOf0bX6Tf/Ro4vjJn+PRJ4wOFCklA
	c59NMxyT7lAcre+MYUhQVCXCx/UA1ZWGh5d6MkSqgKskGu3O5pUP9CEY9GA52VlAWsQzZF+u9cB
	Fr9+cIUs6Mfh70vfUSDdtaH8gDo3uMuslu7CCqX5j0+rLP7Ug7nc=
X-Gm-Gg: AYBFou0xbOff/R0hXhFz/X23/MIAU9XajnC/9zQJ7QE7SYrHYzLZR+lgR1gpDtB7rRq
	gaPGgQivWHq/ESi1jztZkGrBTGdDo/3JrKTgGHweocK4V6ztAPtIsqr90qLhi2VUPFoAQEeHkGT
	ufqg8a/jOQO1oFixSf/yD7FsU84xz8/4melVwnFoPZ0PW/BRIJMsWFX5kCdRTcA0PgkWkJQHeBn
	i0QQHS1AF0CXAk0KcKlxYjRzqav1AB6zGWHsuPlfK0vX6lxBJ0a6bKARj9WxklCcKJPLBO9XdHc
	XHrFY4uPLUnG8cFIEnBRpGX4bA5fR6Nj2AXUrlebkem6FwCC6iC0IlI0b7n17HFacOmiqIw2B47
	IjATkQgWJ40Lru7sGSgdLR5y7rcei987wFpnJ0jiDpFIG8ZRqA0sPh+AFDcbnT/iIt3TZzHvCSM
	IVhXEsCvoSQ02yLFBYifv7Mz68lYzSMhBcS7P91841pK1hoD4qOl/7TD6sZzrulO2YDtKbfcSpw
	28skBBnXK1Gn8py44wNzWpMczw0GQ3iGMcD202b1mZbnxDdcZ+5qfT3z0YlBTSb38I=
X-Received: by 2002:a05:600c:1d1e:b0:4a2:677:ad8e with SMTP id 5b1f17b1804b1-4a20677bb15mr39679045e9.34.1792671374680;
        Thu, 22 Oct 2026 05:16:14 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:8826:77b9:4cd:7631])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fd0f4427sm112485135e9.3.2026.10.22.05.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 05:16:14 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	stable@vger.kernel.org,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 5/7] ovpn: fix UDP TX byte accounting
Date: Thu, 22 Oct 2026 14:15:48 +0200
Message-ID: <20261022121606.732029-6-antonio@openvpn.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022121606.732029-1-antonio@openvpn.net>
References: <20261022121606.732029-1-antonio@openvpn.net>
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

From: Ralf Lici <ralf@mandelbit.com>

ovpn hands encrypted data packets to udp_tunnel_xmit_skb for UDP
transport transmission. At that point skb->data points at the encrypted
OpenVPN packet, but the skb may still carry inner-header metadata
inherited from the plaintext packet.

The UDP tunnel output path uses skb_inner_network_offset to compute the
packet length passed to iptunnel_xmit_stats. If the inner network header
still points at the pre-encryption payload, the ovpn netdev TX byte
counter does not account the OpenVPN data-channel header and
authentication tag.

Reset the inner network header before handing the skb to the UDP tunnel
helpers, so the encrypted OpenVPN packet is accounted as the UDP tunnel
payload.

Fixes: 08857b5ec5d9 ("ovpn: implement basic TX path (UDP)")
Cc: stable@vger.kernel.org
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/udp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 7672094a6766..05e10a2ed179 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -495,6 +495,9 @@ int ovpn_udp_send_skb(struct ovpn_peer *peer, struct sock *sk,
 		return -EADDRNOTAVAIL;
 	}
 
+	/* the encrypted openvpn packet is the UDP tunnel payload */
+	skb_reset_inner_network_header(skb);
+
 	skb->dev = peer->ovpn->dev;
 	skb->mark = key.mark;
 	/* no checksum performed at this layer */
