Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330F83A6B67
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 06:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627097; cv=none; b=btU6MhXzaDCgd5UXZC68SWJmA64Ux0e20aWRnNAa3k0dMybVY8DKjyeS+gn9wfTkWpIvRl4HbPv9+Hu5IMA90qyyszh5xVgo24F9Oc6K5iAt5RcogXaAYu4WoYy2/uWrMqc9MAalOzwywfj0L0dIB2j0CG4m3M0CwqjBLvX4UCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627097; c=relaxed/simple;
	bh=pQ1cuyLwF9ucohzStcBd7rIvjlJrqHx5XQf1oTYM7Fw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ePxizslKE1o0NavofhkSWB5XzNpfbWUNuWWfOlI4EjHRSs+q3ma+qQl5CfbC+YBG1zVU4MXaUtTcJj9el7hccHvRJf3/irKXTrM9wI/CFCnEVzXgc0JXJWyQDAC/r/OzlLk/evTfJbkoujNza1t/uNhyi6gabmVo9OowOA3IAiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9dzSq8e; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9dzSq8e"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1ceb47d55so70720a12.1
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 23:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789627095; x=1790231895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ljq0YRxfw748SwjQjHbEH46n8Tbz0ivqp3DEh5ByqSM=;
        b=h9dzSq8e/hsUEEOXeHvyk4TZo+ahYMNUjp/bWiJyGA69O31H2i1fkVtVgoU2WuLZzY
         U+sag4N/kp37xZ3tHpmpRF9a21xxuaenhVJLgMnVHcdbZW6gbUV0qIRU/FNdaKEWgA7H
         s2HGVKt1Tre13TPvLdMwkdjyZs5RzVIvJI/rtEsW58wWeVVy5I6VAtWjZzxswlqnLFey
         x/5ix7QeLCafggBsYKK0ul1gwWb72i/Hbdl9xZ4S6Nh7n9iN6sziKT8IVHfvODjwDwmr
         J4NoBV+QneTyb85kFqangn7e4PzCrGaDt1m/OocKWMXcy7WuRGgwbLUihh6y2wqa+708
         cCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789627095; x=1790231895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ljq0YRxfw748SwjQjHbEH46n8Tbz0ivqp3DEh5ByqSM=;
        b=Y9c3nf5IoIZA5RJNPO+FuMyghu+aOSnhu1K/MMtSC6w7wyjVDESAbRnstnv4HBzueF
         QJmFhpju3nkuUc5gMqotV5uZBwqC7otUf/NMTpyBfUL5XSKP7bqJ7lhD7y/ZlLnvHBeC
         SFmZu+vnzUi4tjBLQf+FClUbx5oxu5xJ2pRuSXqX/kohtByem+GqdXuC3b6+WzrJ4NNw
         3gz9PO4ZCCUi0fo8FchQ6EyYfn/wsCNdqb5pZBc525BiRMKb+itCmq+8jLQBaV2HiViI
         T0LsspBaf8w1hxopU/BJ6EDvNqGqOG9qEJGRft8D57AFEOE5psdD7/PMke05eIaIsB+b
         xc2Q==
X-Forwarded-Encrypted: i=1; AKwUvBxif9GQ2pSpP/J84WW80vyvKud2h0M7TBNLGC5K/rB8pPUcIUkLRGRTi9pqBrloIbojMoq9h0w=@vger.kernel.org
X-Gm-Message-State: AFuF++nX280nsnJW4uPIQcL4VZSWB5Pn0wsaeU0g6PBc4CwcQvA1GJy4
	jK5pqN9+lCA4LE01ByIUWsW38uCKaraytPRCOOlfQGyLJNl7fZVM+8dq
X-Gm-Gg: AYBFou0Yh1kGzL1afY0C8vdEkDO+Ez4ZQKzRxBwIHskvNQsE8nSkDh6K2IULm1qxSmr
	j0X1gnt0PIEMO2QsF/o9TeDQuZF7pWyJADGI9AHR7XMHgDJJPGW33p5NIRc7npv8WZmXAMqcPgw
	UF8VgQ0wd6Rv0sjn3zjTkc+wYgt4mfwbjkx3LAw2Irhau3A0Jf8CfyH/RwzYmELByKpwb9qJwtg
	PCv+6AVpx1bCXewE+Bi622RJuwUkiwQOkQNOZNI5MkWywhcMkOfl1vCvwRJvmtYXXpbkr8YxYxq
	j2YQgHlUpNad6XXz+Mr2sYyfKSvLausyIHZLOUCDZd6iNXnHFZvbN7/YLRMDu2AmGC8Ll++fAGI
	tsTdrZS9ZjKJI5qpbAqA26frktXy9FvKPVY4NuviDzbid78F6ajgN91R4GwigxJgso6JAVVqJbk
	SAFGtyXfk6dl/VL/oQdSsdvj7i7e3F2TZXOgZyHR2l2MQ+xgPpei0cARPKCz9vC2C8WLzBLyQlN
	H9yQG4T8/BxaE1xIY/UjWRsY2Id
X-Received: by 2002:a17:90a:d446:b0:39d:feca:f48d with SMTP id 98e67ed59e1d1-39e35daaa88mr3024844a91.3.1789627095341;
        Wed, 16 Sep 2026 23:38:15 -0700 (PDT)
Received: from localhost.localdomain ([183.194.144.114])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e35e532e4sm3211453a91.10.2026.09.16.23.38.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Sep 2026 23:38:14 -0700 (PDT)
From: zjamg <ndaugoing@gmail.com>
To: mkl@pengutronix.de,
	mailhol@kernel.org,
	linux-can@vger.kernel.org
Cc: socketcan@hartkopp.net,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	zjamg <ndaugoing@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] can: restore skb header initialisations in init_can_skb()
Date: Thu, 17 Sep 2026 14:37:44 +0800
Message-ID: <20260917063744.591-1-ndaugoing@gmail.com>
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
Signed-off-by: zjamg <ndaugoing@gmail.com>
---
 drivers/net/can/dev/skb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 95fcdc1026f8..a0712e607b28 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -210,6 +210,14 @@ static void init_can_skb(struct sk_buff *skb)
 {
 	skb->pkt_type = PACKET_BROADCAST;
 	skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+	/* Restore the initialisations that were present before
+	 * 9f10374bb024 to prevent skb_under_panic in packet_rcv_spkt
+	 * and similar consumers.
+	 */
+	skb_reset_mac_header(skb);
+	skb_reset_network_header(skb);
+	skb_reset_transport_header(skb);
 }
 
 struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
-- 
2.53.0

