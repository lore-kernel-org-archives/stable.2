Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F65373BE7
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490291; cv=none; b=tgd/7nNhBbc/IKJJG2YyE2Yxz3s6Y6G5nZelACnWe8jbg7KnwS0kbDEJ/4A/BcOlNxFhzKTWqlV4XDszAt1yuZYKovzxK4FibGA3PwZkeKVwXpn6CGQbvnMC8fOlOOBggdtNXi0SOgH1hmTiLYlSrVukOXsHC2k4PAwCW9zGxM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490291; c=relaxed/simple;
	bh=7c5E6DzIQwWpu6cle/M4g0iOx36Uds7JjpR6APOIAlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KR251cX+xCEjL3hk3xPdVH99DuZTFzHZ6TQAaUvZ21ydU6Dp+DLkvwEPxYQyOBdrs9xheHny99eLqvoDW9vy+kFQQeuYnZhZB2rNKgdGvEtSi8vx7Y+hWKMs7vS+1+oEnVmxv8pECkXoJxy9FrfCV37MWG25n6Iojrcu6+nw/yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=J+8Un0e+; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="J+8Un0e+"
Received: by dvalin.narfation.org (Postfix) id BC267203E0;
	Fri, 26 Jun 2026 16:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o2d9yd0Exil7l2Y1p/mwRhBRrX5nxIQ3AzhZ2J+Jrvc=;
	b=J+8Un0e+9K0XeAKiK6LXLbuBJNb9MJqDoCDj9OO4LJOwpCKtu3zMu6GmCiXw9X3m7FsUWV
	oLPpfCAG/6qZT83AH0T6rSSU/PCZs+JwPYaqjCLKPk5OL/E6QUaTQNUqtWJYPFCNds722w
	C8YggiKO0DAE2IdKg2IZMx+zdvTgEVo=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.1 10/25] batman-adv: prevent ELP transmission interval underflow
Date: Fri, 26 Jun 2026 18:11:08 +0200
Message-ID: <20260626161123.124273-11-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161123.124273-1-sven@narfation.org>
References: <20260626161123.124273-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 5e50d4b8ae3ea622122d3c6a38d7f6fe68dfddca upstream.

batadv_v_elp_start_timer() enqeues a delayed work. The time when it starts
is randomly chosen between (elp_interval - BATADV_JITTER) and
(elp_interval + BATADV_JITTER). The configured elp_interval must therefore
be larger or equal to BATADV_JITTER to avoid that it causes an underflow of
the unsigned integer. If this would happen, then a "fast" ELP interval
would turn into a "day long" delay.

At the same time, it must not be larger than the maximum value the variable
can store.

Cc: stable@kernel.org
Fixes: a10800829040 ("batman-adv: Add elp_interval hardif genl configuration")
[ Context ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/netlink.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 86e0664e0511b..6ad7dc916947a 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -941,7 +941,13 @@ static int batadv_netlink_set_hardif(struct sk_buff *skb,
 #ifdef CONFIG_BATMAN_ADV_BATMAN_V
 
 	if (info->attrs[BATADV_ATTR_ELP_INTERVAL]) {
+		u32 elp_interval;
+
 		attr = info->attrs[BATADV_ATTR_ELP_INTERVAL];
+		elp_interval = nla_get_u32(attr);
+
+		elp_interval = min_t(u32, elp_interval, INT_MAX);
+		elp_interval = max_t(u32, elp_interval, BATADV_JITTER);
 
 		atomic_set(&hard_iface->bat_v.elp_interval, nla_get_u32(attr));
 	}
-- 
2.47.3

