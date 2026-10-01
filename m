Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EB9472F8A
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 18:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790879038; cv=none; b=nPYZ0RA3HqbQj26lurFrV5eH4YfoM6o4vr31L9zVTtHnNvo532Ny8LmXsoeZzTl6/MBZgFmuaMTDPZwvbZ5dOJrumIsQSO7sAVCEqDZe3pjfS18yX1rQ2p6ia6yKhgAbPBA8bh6S7YngEP0y/2y1CJBQw2mZSYu/Dc24kXgKrYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790879038; c=relaxed/simple;
	bh=ApPsSddcz34krnPCoImgDAAUnXelxvxjJ/VafXgbhUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j8QgQvljWZFENk1x725VY2gHHSVFYBCMKuJVcZcyTL760hvorqCjBpnPodV00I9dsQ25xGce1RcqlYHeSljgJOsQSNJqL82gEbEgZzwFFwcDn4CoZ3Y8JNwDywYGSG7htnwQVkMnapUhVcELzYZUtqQFZfBXrbiBJduW/wdfK7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oR4nYzGe; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oR4nYzGe"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34b590a5b5eso3628450eec.2
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 11:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790879023; x=1791483823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dNFa4jlYFw2EffEHYX+/aDUCOKTNBmwQOlvs+e8ofc8=;
        b=oR4nYzGeEMBrRreVr/WDdjuzM80CdQf/jbOJiKZ/2R2qeqzHMkCbHxtSsgVunzwRxg
         zCmUvglH8A1yYe35tkVy2qdc+gp+UeixqgnmK+sxgBaDxV09/WEnwseV+8o2yASxT3gX
         0Jn0t+J9o84y45Ratk9RpwquvWkDDZq30IvdY1Rhpl8GMdL1HSP0X0iXrUR6wODRHHkO
         aFr8kFYAyFQD3vE97LMTabS6BhMdYCv1teGZFysMPIBQuSM1iz2AL39F0Dgfo3zDNVC3
         oQ2beHX0H7SoR5sPZ2qNCUYNk0pwPITrVYFL7qRgbxa3n1zabatzl7HrsgJk1h1uXAam
         +ERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790879023; x=1791483823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dNFa4jlYFw2EffEHYX+/aDUCOKTNBmwQOlvs+e8ofc8=;
        b=MqyJZAcaxlts7P5DJF43T8UbmSm+aDsbFMYqUpZYJT7j87eHTAk3eQ543Q2VeP/Dx6
         wxAis8tfu4TKNMiK/xKsXCDp93vA2i0vWGJe+FEWAkO27DhBNeJvTOVb+bQBAvUS2XCE
         MMnD156LokhSimg5PyWQysCOejBjJbUIZrD9IJXHgsBWVoZqb3SyijafQSz4ys/g0cx5
         wxoe/8k/O1x8xdXxwQMv8dIhyyPG5M3zDyusN+ZVZAw/Ks7hUElsxxzSsa7Y94wvw1ql
         WGDzuDC+fzhcUOydCovn4T7avw6Y1jEFkZMpacO3hHWmk4RiV5/aNmW0bFR6wHb/VPcT
         HSGA==
X-Forwarded-Encrypted: i=1; AKwUvBzHSOKUaWaV4jDjsGgnShZaeN15URb1P7rGZQlL8P2d4zaYOY065nkWPOVAqzDtuPsSjczfe6A=@vger.kernel.org
X-Gm-Message-State: AFq9FYKN56V8UkdkzAxnt12CGtCtnmJTjtRmf7Dl8hN8tKVMPXutQ29k
	hywwLb/XCFJu/811OGarIUvd8kc3Z5g+wWLEDTwOcXWdf0SC1SLvPeJE
X-Gm-Gg: AYBFou20cYsVPZ8VkOSEThMMVN/1z4HxAXYGjyZ/6h3FMqIVQHgRVsDpAoOA/FcJVAf
	fFdohq1Gm3y9i4g+OJgloAZK1XV7E+IuzAWvaIiFrNCQL3H5lBdHlzq29Ehtht2azEYuGHn6Dl2
	XeuKrepNuRZRl7OzKIDabBKvGGzYSUoCjybvL5ozcb5rR/k7t8VshpDHyKjjbRG/kkl+NVI3fHv
	OX6D20qKj2akGB1Zxxgfr33ck78/epk8T6e80QDDbSAu7E3O0Hv9RGjcuKO+RA5e0dMWUYwjDPe
	l5m12xvJ+d6LvvXFBE/Ka9RCebdQSOptXkJjzjo3E+Ua80MoBgHL/g4CPdx7P7FPo/KEy1kHfpv
	YoRfrI/yEZLu1aLeOHP7DMM2PlzY1BjerD7PmCzfUcc0TSZ9k2GqFt57CgiUsJo+t2tiy56lggI
	vm67e5XQ40g0rg+s7j9NTWMbSMOvvaHvBC1uF0FKhWkwtp3uMnkx3IJ/85au+JRU+qAYjUap5bF
	DYD5aqssR913gq+Uq/DtBjPFUIZO1lCRQ==
X-Received: by 2002:a05:693c:3881:b0:34c:1f07:2d5 with SMTP id 5a478bee46e88-34f1508567fmr105771eec.6.1790879022862;
        Thu, 01 Oct 2026 11:23:42 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14f303e3sm189671eec.5.2026.10.01.11.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 11:23:42 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	co+2cf741c3005abc20@bugs.sh,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 2/2] net: team: free skb when broadcast has no txable port
Date: Fri,  2 Oct 2026 02:23:26 +0800
Message-ID: <20261001182326.572045-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001182326.572045-1-bestswngs@gmail.com>
References: <20260926090039.1714460-1-bestswngs@gmail.com>
 <20261001182326.572045-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bc_transmit() sends the original skb through the last txable port.
When no port is txable, it returns false without consuming the skb, but
team_xmit() still returns NETDEV_TX_OK. AF_PACKET sends then retain the
skb and its socket write-memory charge.

A TX-enabled, link-down port keeps the broadcast transmit op installed.
Carrier can stay up through a second link-up, TX-disabled port or be
forced on by userspace. Free the original skb on the no-port path while
leaving the existing drop accounting intact.

Cc: stable@vger.kernel.org
Fixes: 5fc889911a99 ("team: add broadcast mode")
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/net/team/team_mode_broadcast.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/team/team_mode_broadcast.c b/drivers/net/team/team_mode_broadcast.c
index 61d7d79f0c363..69dc25a5847a1 100644
--- a/drivers/net/team/team_mode_broadcast.c
+++ b/drivers/net/team/team_mode_broadcast.c
@@ -37,6 +37,8 @@ static bool bc_transmit(struct team *team, struct sk_buff *skb)
 		ret = !team_dev_queue_xmit(team, last, skb);
 		if (!sum_ret)
 			sum_ret = ret;
+	} else {
+		dev_kfree_skb_any(skb);
 	}
 	return sum_ret;
 }
-- 
2.55.0

