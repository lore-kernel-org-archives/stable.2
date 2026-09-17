Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521394E06EB
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 12:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789648656; cv=none; b=t0AOszGrdc8EgA+uzu/DxlQHTHRiah0/+PPF44DReGiLM80sC+LTa9EH+yR+rvrU0YobLRCkCZVw6k4oYKf+iyy7E1mKyH/QwQkxXJZPMKsZ3eLWcMghqwF+ZUNSCdomrFHslQWiE/mzdU1gsZRurU95b8oY5bXefXD1L4oU04I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789648656; c=relaxed/simple;
	bh=UjrMYB1SJaVixFfmpvISBt1Okp74qLFloaIEp+D4dWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QO81nF+QT+WelY6gi2M1GtoXMptBGt+4857NhlG7b8WiO4OQp36QJxFmqhKUyExBCG6aXECVIoeM0Y3plzTWNJq0EgIr/lpvSeylY3WP7eGHkWlLuQ3Ym2+baHrCz/V1EX2YjnL6aXUdd6oMxo8h8AHimFlYhKGVB2Dg2JPMUlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pdp2Dl2I; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pdp2Dl2I"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2db18fe433fso6491735ad.2
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 05:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789648645; x=1790253445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+wQAdV32Fk3OyDL+A25ZncHwDoalpqgqwEDF4cMme34=;
        b=Pdp2Dl2I9K8jYceUeoTqYt1lNhldV6eEbuM9/H7su8YgfKBXEM0t3VFObJaJzgQWFQ
         /Hbba4wEMfjrPWrpW5YO3t2bTxS9r10d81Zj1s1Vw2hZ/FO/WffYSICsSzqRZ0mOt0fv
         cwsXnYIKRx2gwujHOTuGNAYfizGAhpyXkYlZa18ruJ1DCRukd530swSOJZZtGjI/Q1DV
         bdd47bmR89GobBGrp/7csp4RyRJtUlzTpg9sBoifJ9rLc944IHGoFKdg+bRCKg2xLlTt
         +J6XmLZ3VfjuvEg41LIDHYznVT78HCL0z2T+6kZCzd+quIpi4CLHl55+8thcLnQ4vDLU
         1z5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789648645; x=1790253445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+wQAdV32Fk3OyDL+A25ZncHwDoalpqgqwEDF4cMme34=;
        b=lvdbuTGGpBm/AdCG4OZP9tXicpG2KUmeuZ4S2lVq81WjUiZHZ+Hboe0eAa8zabUe8d
         IFUcm9DYifGuCQWxCSu5BdE6tYvBKi0yRpVKuh1IMG9+osEJBRJBWXJ6GzRUb3SIVY3T
         4VdQzK7omWRr0Lzx14C3+VrlkO3/Ug1Y3Ksb0yExwOFElWnyq3UofOvrkwajx0e8Kct9
         Eu41CgEVjtTLhWCtOaoBYXR6G3WoVRAWDr/8T8KNdFzMZ1DUxZIVY4fEko0oTNZoCGa5
         7+MXj3yk51cN7GK5lNlgtyKM6GarzpFwrpPDLw0vnz0LkqEvxM5aOzNUoYF6kPXHKZUY
         z7wQ==
X-Forwarded-Encrypted: i=1; AKwUvBzW1L7rB9yAmdMfe03ECPCA77gcEbJHoJi46spv8kpb8LHFYMRFcT/Yc1Z27OkhIjI2Hyh2ce0=@vger.kernel.org
X-Gm-Message-State: AFuF++nomRqTPLhEOwGy+7s9ElYfXGhKohehfG0T8AJyhW/IRh6elvr1
	lzKJ963GaDGTrvfMYhW8B0ELR8b61i8L8S93Tyu7KjyMQZcWCprb94WW
X-Gm-Gg: AYBFou3JVog+i/0PKvB5FJC0TADR4Rh01EhRxp9by2NIy/LpvI3jc4um1d0kxaY0mgZ
	fibmq6MfWKDOWy4nEtpmIcg3CpJbssl2rwLXDM2Y+PaaYiR6rg+czvyYqbshxvuXdweXv8bbT7l
	tMl5VKuBUnh8y5v8AsCQpL/hCynCsMPYLgeDJa57AMHWJwP1O2fHdRYD00cP7K+7qw24tqduGL6
	6tNGADFKjh33dh3rFKPyeg/wwd+aGAtzuAumx4xh79/V8ZOVVJYLS82MRAhfD12/NB/o2ChecQn
	pJReqR896YEaTOpAulzTjutWRgFbphuMh5UZqOf5SdrMjY9kCuvEFqu7+314gjqwh9iv1V9PYXY
	JpYBfByo/WfDBcVdgzMbE7wY4YfZT6gN0pEwUV4P7epTMof+pPGtw7qETzsXmX40IfejbUES4Og
	la8ENd4vHwVc6BSUbKZrGRqU4vT7Op6pyig7L8x1rJ86LzTFgkFZbseQeN4u3n8ZCGSjBSkaoUH
	DJzuqjOGZyizdJx+0Pth2RNbVIzGQuqBxN+kdM=
X-Received: by 2002:a17:90b:314c:b0:39d:f4fd:8075 with SMTP id 98e67ed59e1d1-39e1e4e3559mr13681823a91.19.1789648645405;
        Thu, 17 Sep 2026 05:37:25 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a1e:2e81:7320:9190:e5c6:16a4:8428])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e362f0f07sm6057546a91.17.2026.09.17.05.37.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 05:37:24 -0700 (PDT)
From: zjamg <ndaugoing@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Paolo Abeni <pabeni@redhat.com>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zjamg <ndaugoing@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] can: restore skb header initialisations in init_can_skb()
Date: Thu, 17 Sep 2026 20:37:16 +0800
Message-ID: <20260917123716.63116-1-ndaugoing@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 9f10374bb024 ("can: remove private CAN skb headroom infrastructure")
removed the skb_reset_mac_header()/skb_reset_network_header()/
skb_reset_transport_header() calls from init_can_skb(). As a result, RX
skbs from alloc_can_skb() and friends again carry mac_header = 0xFFFF.
When such an skb reaches packet_rcv_spkt() (SOCK_PACKET), the push length
calculation overflows and triggers skb_under_panic -> kernel BUG -> full
machine panic.

The same issue was originally reported in 2014 on linux-can and fixed by
commit 969439016d2c ("can: add missing initialisations in CAN related
skbuffs"). packet_rcv_spkt() itself has never been hardened: only
packet_rcv() and tpacket_rcv() gained dev_has_header() checks in
commit d549699048b4 ("net/packet: fix packet receive on L3 devices
without visible hard header").

Fixes: 9f10374bb024 ("can: remove private CAN skb headroom infrastructure")
Cc: stable@vger.kernel.org
Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: zjamg <ndaugoing@gmail.com>
---
v2:
 - Remove in-code comment per Oliver's feedback.
 - Pick up Reviewed-by and Acked-by tags from Oliver Hartkopp.

 drivers/net/can/dev/skb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 95fcdc1026f8..14edec5afb57 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -210,6 +210,10 @@ static void init_can_skb(struct sk_buff *skb)
 {
 	skb->pkt_type = PACKET_BROADCAST;
 	skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+	skb_reset_mac_header(skb);
+	skb_reset_network_header(skb);
+	skb_reset_transport_header(skb);
 }
 
 struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
-- 
2.53.0

