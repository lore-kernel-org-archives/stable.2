Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795776853;
	b=18PcH6NrWjCaCKtfiMhzMDsV+ozL6av3eZqFEh2LGsLM5Y728VOYo8p32bC8m5JcgtyC
	 2zztdBXSSpa7My7r9E8gIKJAhB8gwMX0uD9n3ZOsVLRZAYzm+TEWg60NI+PRW6ZSF1oZd
	 9HpwgSnCb4zuRRO0SCxGsraA7rvWc7Z5pU1ZfwPoLk3DHyFOpz7PDChY0XrB9Nq/jmtSS
	 QxFEfuIWzkJfA2axAo0xz/7uQxsY8UxkiIp8Mhs3Uw0ILZzQjeJQ7TqEucC4PkKIasLN9
	 rB5azP4Pigls704pMBI1h75YB37VHOtnPUligkHWM4LVvSebXyIy+aABnvo8fy5Cl8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795776853;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6o6wwpsf6OkL2ZSFH1Jv+ohkliUZZst2ain93hx+srU=;
	b=biPeU0GYl/DBY/C0UPdKyeFGL5X4j9GBH32FUgdnaKeu2gdtOEd2XlOQaMOvVFOlQxHa
	 dtlyG+SA6LyaoiAgK5kMB8u7dFUVzi42tmvm/pMTZWjzt4yijy3MS7QaeU2WZXycKrZ1l
	 /qnszPmoffiS1DVa0LBNj6Ad5pjaCqOBO6Ne+vUsgwluje8ndKO4CKVWknjNt9tOV8EIx
	 XIafpi9RpERU7v9ajVTsJslULYawfEckv001hMk4FiYQFNW4EzSPXfmCoZiko9jBCaGLC
	 xJPueWAqbB6A4KnNgUJag9zCWns7LC8aDEqW2LEtRTLTO41ZgMuMrLTn+xSjCyIaRnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L0Z7gmyW;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1789C606A31E
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 10:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1789C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L0Z7gmyW
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-18818daa3e7so4363308c88.0
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 02:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795776851; x=1796381651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6o6wwpsf6OkL2ZSFH1Jv+ohkliUZZst2ain93hx+srU=;
        b=L0Z7gmyWDD1NV0Rl0P5B5KEd730ZW3wJm61yeKjW2ZS6lcj0yg9gXasllzaa5OaXBH
         kQCRbmMazReS0eCAnld9Omnj3RA8Cr+q1QZgKdEwSVp291EoejBacQ3Ml/I2SQREA3PT
         ZmFbl6NF6QYBkFnR31lmaY9EjhDile36nYboZC+tM9Jz5tILRXbv8CYr4igILI/4IVOc
         ux+B37VoEia0Nybv2HEG/KgDjXMF0d4+7Hrwf6HGykRrJt+X0mS/H+p5KE1BPmmZyweC
         u31llk0wNY5vi/hg4ZMcDkZlQslu/wh/mspzJkdMn/XmxdGNxoGvp9PjDd/DdZruwEr5
         zjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795776851; x=1796381651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6o6wwpsf6OkL2ZSFH1Jv+ohkliUZZst2ain93hx+srU=;
        b=OwCMQuoTigHZ0VR0aRSB9Nxs+crWTZZ5e3KgeeDtlkybpt3uMipceEI9gtdgeuA5Aw
         1BGiGi6mM6PeSXnuhVA43oFAocxElt6O/2lIvrNzeXJbYTuPXMyo5BKMiwMChHw7PkP9
         S2fp28mOX3CsVc/uoBnXY+jdisxyQb5vxQ9hZm+fpZr/cssex3LE//jaOADmdyndFeyu
         8NwZDtuTPHO/pQMsRqnQ36mzq+deSjTxLokJXT1ffXui5u/i5KiVJuDsAZ3DZwM9Ug8r
         bCS+l3AtwS3n7bJutJZpwAUmQcMG6WbQxoG21lLMnRE6TcbN1y7qZjuy7um0GQkX/7Ss
         O3GQ==
X-Forwarded-Encrypted: i=1; AL+hErHY4PllLIRbY/0y9lp7o0EfQfzpSCgg8UkA8s+k5rBd5a/AM8ZI9Wp12o1bo7OV6lVOVwHiwk4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8KHLzezCb8J91VQ+dVZOdxonQn9olpY0Sjs71Xtd7DXBix9VzB
	nOp6IAndEsRWGXCfl7GgZxQR/i7U4NHO144A7EOl/XBG0P1wehxNRFaX
X-Gm-Gg: AZFdTZdXgaZBXaKlFUTybR6EJxaQu9AKvIL2luHbN6spsbYsGyiKKE1oEvvFLkQlb6n
	I5boMz0vVjJEoUx6JU3QVbsEaxAHrEXv0uRkhUli15BZzaXL8Hk3gzsy3CuNIabBShQm3mwgU26
	7qtSUTSbemjqPTN2uuoFBhWhlY+11W5eqxtf+usxLd3EyQydYvEW4i7X4jXO7xtgyyhDPhCjpMr
	6b1hMnUDbDOsKIHI/bG1amEpMHw8CoFqxhBhoa3dmYmIzS8x0YL3OMlwbuhbptVpKpUNKtFrQqp
	Ze8LkHlZ/m1wO4ZrNxDujgPihLRbOM9irWyFzaWKrAatLbyat/Y6P8HG4isIqWyKmtvhrf5OVgv
	PsiJTkw/g2I9KpRisxUw+64PTC77l8gIsyStwFF4y4+zWLV8YMMPs6J5ywa3i4z5GwhiaFlaHaC
	yog69oLWbUHBBSkWIdMfMXvHWXiOS/8Vz+PpynDqwXMeUaOJb96zSSp1VNgn41hCPtrxKn6p8N1
	uwEZ2hvwGudSSdBY295/cRTa7Kvdm46MJRNdV5/d6ox9GPz/q3Rs7tIi+vdrmHVd/KVYHwYe4ct
	iF19vmonbgh9NsbT+EtmvfDvIbHOzQTc4z5klP74KZKcVfAGMO51XD3n28h4b7/GmULFSsbebUw
	6dEo2CS3o3dg//l6dhh+OwNZooTTN+tCrojA9dQ2oaLyZ6nJC5wvDGiTrZWSBB2NWjUxwXtwBIg
	==
X-Received: by 2002:a05:701a:8459:20b0:1ab:90a8:87a2 with SMTP id a92af1059eb24-1b5524b0f73mr23088055c88.11.1795776851201;
        Fri, 27 Nov 2026 02:54:11 -0800 (PST)
Received: from localhost.localdomain ([38.114.108.154])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5566c1142sm54992326c88.2.2026.11.27.02.54.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 27 Nov 2026 02:54:10 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: willemb@google.com,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	bjorn@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>,
	stable@vger.kernel.org,
	Petr Oros <poros@redhat.com>
Subject: [PATCH net v2 1/2] net: reset the mac header in __dev_direct_xmit()
Date: Fri, 27 Nov 2026 18:53:46 +0800
Message-ID: <20261127105347.72997-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261127105347.72997-1-kerneljasonxing@gmail.com>
References: <20261127105347.72997-1-kerneljasonxing@gmail.com>
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

Compared to __dev_queue_xmit(), __dev_direct_xmit() is the only open
gate for skbs whose mac_header might not be initialized. A few months
ago commit c2707480cfbf ("net/packet: reset the MAC header on the
packet-socket transmit path") solves the case where AF_PACKET skb can
miss resetting mac header if a few conditions in packet_parse_headers()
are not satisified and it will cause out-of-bounds access.

Similarly, Petr reported an issue about AF_XDP path where copy mode
can also trigger the uninitialized mac header problem.

In reply to Petr's patch, Eric suggested to add the reset logic in a
general layer to stop future issues like this happening instead of
dealing with scattered cases one by one[1]. So anchor the mac header in
__dev_direct_xmit() exactly as __dev_queue_xmit() does, before
validate_xmit_skb_list() so that ndo_features_check() and the vlan helpers
see it too.

For callers that already reset the header the operation is idempotent.

[1]: https://lore.kernel.org/all/CANn89i+aacS2PfaMXnimzGgbCLz-JSnqo6QyoS122Gf+kxya3w@mail.gmail.com/

Fixes: 35fcde7f8deb ("xsk: support for Tx")
Cc: stable@vger.kernel.org
Reported-by: Petr Oros <poros@redhat.com>
Closes: https://lore.kernel.org/all/20260817153957.3177627-1-poros@redhat.com/
Suggested-by: Eric Dumazet <edumazet@kernel.org>
Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
1. this patch will be backported to stable branches to fix the xsk problem
   and will also be merged in net-next. In the -next branch, I'm going to
   follow Eric's thoughts to handle the mac_header 'issues' from the driver
   side, and then finally remove the guarantee (reseting mac header in the
   core stack layer) like this patch and that af_packet case.
2. this patch is also a prep for the second patch in the series.
---
 net/core/dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 3c58db732761..6ea2fd3506f7 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5149,6 +5149,8 @@ int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id)
 		     !netif_carrier_ok(dev)))
 		goto drop;
 
+	skb_reset_mac_header(skb);
+
 	skb = validate_xmit_skb_list(skb, dev, &again);
 	if (skb != orig_skb)
 		goto drop;
-- 
2.43.7

