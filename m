Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795566174;
	b=DJKpLr6CM9f7X7VSJg/Buyn+M6+29oyLAozlpXOBTdk4WHdxSLMkHf5hOILy2GILdgq2
	 C+j05kkpsxoxBKdy2ODZZog42oLozy0gruCHs3XXWMZgatQQpt/B+BUg59/Z9Z4FAt2Mj
	 DvGTMfGhtH6kMvKXCRXPqSJNaJDLojuVzLI/102GiMyrulRepIMVQxO1+KHpyIO5ZCQKp
	 B8R1WGGtJfLGlhTtLTXObTdHMuQSEcQTOFLHdil9wfv6O3DRiVSOYAmnV+69X5hfXCO/G
	 yYfXJ2wmQ3f0HGqclg7jtl7PSJaZl5cQZmtDgwEj+tLUyGkVm7DuoshzONzSo2I9Zmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795566174;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/rA7aFNfGC87qi/noxx/SboGnQSZ6l67j7aYWk1zxoo=;
	b=iwj5Ksx34ZqM2p1TV4PTI10oiEgjjljMnlwPLu4FTcvt7l7mTUzmoUdK9y42FKU8ozZx
	 dpW/of2aJifdtgnjq7Vs4dCJu2vgZiHYg60ERaSIXocwi3brmJ9EFu65rwMq62n139TBN
	 xJ/1X2MN5d8pvj3oKKPg48pjZsVLIj6SaNR0GRKaAHTVduKrINobvMNbQw2TaCP0epINo
	 4p6xXd37Ig/LJblM32cwacMpC6Wc9c/UcplfCSjaQ871CiNkEh7DIpxhsi8b246EZWfy4
	 7jErZJNUKx95QguEiiE1VdEzlBeenU7Hm3ohuYdTub5DnErtpCx7R9ZJ0T67tAwUBgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openvpn.net;
	spf=pass smtp.mailfrom=openvpn.com;
	dkim=pass header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=WAogHuIY;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB5B606A32E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 00:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEB5B606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=WAogHuIY
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so41343925e9.3
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1795566172; x=1796170972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/rA7aFNfGC87qi/noxx/SboGnQSZ6l67j7aYWk1zxoo=;
        b=WAogHuIYoaIEpDvI/k7EwUCr4euu1bosxzz/onesufSWV5s2hFunm7EfVz5NPwCMFk
         PpVl5HGHqEDmcWdiUgro1ThexEG/GjgD1le02hVYFCZCyCfw7KIqSyQeSxN+nKXlNKfo
         Go5euykViOOsty6jgnAV4VA0pzr6y1/AmF78B0xw1s0g34vDaiiHCEk61lmkZUSIqsK+
         UlMBVaT1YAVCigxUy6AwdFBvvZ97NyYxur1Y8kEOlSE4nUMej+WHMRW7tWJ8rkyiJ67/
         rW5F41WqiTEKVJ8eKs5yPllxS3GS8mJssQCuJBPXQqCv0aqws1RqNHpixO3dAtchmTpq
         nMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795566172; x=1796170972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/rA7aFNfGC87qi/noxx/SboGnQSZ6l67j7aYWk1zxoo=;
        b=FeCNP4Q/esCSvSBR83bM0a6VpyrS9gVSYm2pP7LSIiPZFDJgFc1GpL/pZw2vXX1VyJ
         txb++LRrXQDaL83vVd6kK+MQcwDtYFmp8P96Vp2dZQ3eHaeERVCNwuNP9b3A3LrPYKim
         L+1yyNUtlERSt3MxkAQnR4h7TOCWnC9NvNZ1QngAgBOsdzIr/vn1SPYXZngDJW+a1mwk
         znYuursARZUMZv13FQCCnHmtnRTxBMv/gZj457u1PZtbMqewgcvXuP7biNo9BHJdtlaX
         K0UyM+zJIBZCj8LM0ogbfPr4H2c8lKW0UZVGRY8CoFMWB471xAyEA4lJDuggXl0EBFIs
         NJ1Q==
X-Forwarded-Encrypted: i=1; AL+hErEMcDCByNMSCiVJnhT5ujQkSLAn6QYJ9u1r3z+KAmH35DUyPxG9T8cUAjSAXCySCJewTLZNPIg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8tAeaYhbixdr/pnuuTRStVB4RRO0Zc+kI8Fq7Jb+4o1I3WwO4a
	8al31lkDpsthzWdBfsTQfS6RbDrXwwyhiErB5V+oX9IM/vYlcvVEguoPWb3p613GslUcqZ9bhM4
	F5NiEakhOWoktgcGKy2FYLmhiJiYweGK44ulHECBHPVJ2ok0mj5I=
X-Gm-Gg: AZFdTZdR4vtx5kR1sii7odKng4+mnhIua6wMnIeH+mFmB6PGXPBPlHomO7kJ9m7KVCd
	SLNw6bOeZRuseFcBtA2K/D1DohJ9gttxkY6iEEsLvQipnPvrod+i22obHtPpf81sNqnHb4HzpkK
	24KiCoZmZ/CqT7BtNvrC1mDqVWPETZ1JRj+Qy6LdMh7mnHl0RMeshLO0JtRFN5Kwy1CZWx38D5Y
	NGIp+vwgz4tpvZo/npVSTXm9Zfj7dDOjJvntkiBJ3mfS441x7UlCK0TVSvoLdUKPepD/hY7QweW
	4APnPNY/UQvzT/phzQuLS2ACk++neQVVHE/bOOydLkrOLX3tUhP8RGK995ZFRX6xPSyA8/OLtu4
	muGFZXDhf4hA3B4yUZoxDkb7UeeZUl2AUlkmDLNwo+Vb7Vhzly8vgcxdx/3Xnq/De1WPce9hdsh
	VpyXqLMhHIgnXdexO97gcToSS0X0Jh+I+LS1iRi+3irBhDSHjQDtdHBCIzZhFyUYgbFCrKY5o8g
	7yh+o9Vxaka75ZCf1VCHGJw6Ws7FSl6kNRRXe7XFAPTjtZg+qkvsTWQRrHlGjqWyjlwTSv9uiTj
	BlXmtLYGLh4QFyRz8ANfrGSmmWOvG943Wj3OKepGTaH47WEid3dQ
X-Received: by 2002:a05:6000:1a8f:b0:4ae:43e9:da61 with SMTP id ffacd0b85a97d-4ae43e9daa2mr25718020f8f.4.1795566172340;
        Tue, 24 Nov 2026 16:22:52 -0800 (PST)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:5c82:5cd3:7bc5:2809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf630esm31518448f8f.16.2026.11.24.16.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 16:22:51 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Ralf Lici <ralf@mandelbit.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	stable@vger.kernel.org
Subject: [PATCH net 5/7] ovpn: account TX bytes like RX
Date: Wed, 25 Nov 2026 01:22:36 +0100
Message-ID: <20261125002239.1191542-6-antonio@openvpn.net>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125002239.1191542-1-antonio@openvpn.net>
References: <20261125002239.1191542-1-antonio@openvpn.net>
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

On RX the netdev byte counter accounts the decrypted payload, but TX
does not follow the same rule.

For UDP, the tunnel helpers compute the packet length from the inner
network header, which ovpn never sets: the value is inherited from the
plaintext skb and may point anywhere, leading to random counts. For TCP,
the whole encrypted packet, including the length prefix, is accounted.

Mark the payload with the inner network header before encryption and
account it on TX for both transports, as done on RX and by wireguard.
Userspace messages sent over TCP are not encrypted and are still
accounted entirely.

Fixes: 08857b5ec5d9 ("ovpn: implement basic TX path (UDP)")
Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
Cc: stable@vger.kernel.org
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c  | 2 ++
 drivers/net/ovpn/tcp.c | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 402a74a2a27b..a11ad979e9f3 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -328,6 +328,8 @@ static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
 	}
 
 	memset(ovpn_skb_cb(skb), 0, sizeof(struct ovpn_cb));
+	/* TX stats account the payload only, like RX */
+	skb_reset_inner_network_header(skb);
 	ovpn_encrypt_post(skb, ovpn_aead_encrypt(peer, ks, skb));
 	return true;
 }
diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index 5340860c0b82..00cab8d2aa6a 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -294,7 +294,8 @@ static void ovpn_tcp_send_sock(struct ovpn_peer *peer, struct sock *sk)
 
 	if (!peer->tcp.out_msg.len) {
 		local_bh_disable();
-		dev_dstats_tx_add(peer->ovpn->dev, skb->len);
+		dev_dstats_tx_add(peer->ovpn->dev,
+				  skb->len - skb_inner_network_offset(skb));
 		local_bh_enable();
 	}
 
@@ -446,6 +447,8 @@ static int ovpn_tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 		goto peer_free;
 	}
 
+	/* userspace messages are not encrypted: account them entirely */
+	skb_reset_inner_network_header(skb);
 	ovpn_skb_cb(skb)->nosignal = msg->msg_flags & MSG_NOSIGNAL;
 	ovpn_tcp_send_sock_skb(peer, sk, skb);
 	ret = size;
