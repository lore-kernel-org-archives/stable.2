Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9194A4FE2C8;
	Mon, 28 Sep 2026 19:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624004; cv=pass; b=fjtMP1f5jjtAQMhf90U2Cf/RZ2La6VehcVExOdNP37KrpndFfc79L1mi65EpaV4lCgHeij6y7aFzPklOtjvxRDDwB569JEGi0XRjKIx8qUhk4Zm+WVW3KS8RzlULvZgy3jylfI5Nc5UaX0yzksU4zGCjbaR6RTPZloTM0toY1Sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624004; c=relaxed/simple;
	bh=IoH5i5QUyA5AA3RgJ0zTX2Y7wqM5ceenjaQl8JVmDic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iNnNzJG3TVzN1vlBONMzadpg2oKtwOJ8jMeHqwwQOGjKu6t4I7mbUtGw1O5pAvhRa9Hr668L3u+lyTZ6zeku2bi7lVL6DOUvspswrzNmH78bGWoTifRMMKSDrPV/F/BEOPpoaZf93ven56qxj8NZDlRUqUrxJDwPj+t44dzee4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=W58ryEKo; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="W58ryEKo"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 823A8201F10;
	Mon, 28 Sep 2026 21:33:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MK9IliJJC91G/0ecIQzW4NeptX5TibK46PlhasqNMF4=;
	b=W58ryEKo75NS+orPvMtZtfxsr464dyVh3FKsq3/K5yeUNFGBlUDQoESmszn8r0S2KyP8aH
	T37HidjZQBVRpy0xm85YgrLGgvWyYRsyC7Jo6ZeYkr8maSTSoemDF6I8uvYXyucCmxATLd
	lRlMX3Wp2FAqY+fjmFmezCnnC5S8AZ5gIKFkRsyJahqhzmmGsQ991VoWnxQ587CG7JNQCB
	jnbscBiM4eDcd9yQUw4y6kY44mxY7gmUwaZguGZDgykeQEWLFiR+SvXmQ/B4eVrAEeQ4Ja
	TKyF7Qnm/XP5A7V+qDEIfKiJNhTqyelEcA+C/U70mwXE7oYKJPN629Hwv/W7AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MK9IliJJC91G/0ecIQzW4NeptX5TibK46PlhasqNMF4=;
	b=fHxiJBOFb2AY9V7bEM4fboigZxYC9VShDG1lZunh0IG1IiJavyf0LAfrxcI79C1LIwvP2L
	e0gFCRQnYrVDClJGqfeO0aroT0LVPMYcu3ovu+jlI6dolyXUH/YQKPf1xuDTZkvc8iSmZY
	JZfQAbADxPw8JScZllY7fHT1IptBvuK0QhG2SX9il5ISqtlgfkUkcLrGdiPSZEn4oRmkFY
	/AcYCMHh4kyyTkC5qMc+noJU6W2o1JMULXU1NC76BTj9LtSKAzKLThbIXApo5pJ65YWKeR
	c7KGR1JNSoMtb2o8KO55TyXX1py7bJ3tddgEleUKEkyMObBnMRVtu9sEUxPpsA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790623995; a=rsa-sha256;
	cv=none;
	b=c23waLEwN7puoj1IU4wtn5lMGukPPMgHYHDDS3OXp/RUBek8rIxVjZ2+vOJXBapxhXTPRD
	hhYewXuvKKmu6pzZFjfxWQv4k1wviQyGRJUtRqPj2NfngaPfyRnAvJjb4cde0SLGhv3aaL
	+7mfPV197VmEIq+b31zYA9x11Se7kobBIm90yDYAe1uspZUWLxzPpJiDbBOqDYMIvPzxS9
	ni7+2+6Wi7bjW1kcN3PV4fPgFU4rjqR0SqehYriD5p4wbMP83RmwQy5yNiTraaL5sZGdv8
	hW3Mh/+QPevWWcN2BisN3UFcFDDHQGyBrmTElocLSGfsjKUWcdhKX/aFmFUDug==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBH6B-003H5s-1F;
	Mon, 28 Sep 2026 21:33:15 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0C0585B1549;
	Mon, 28 Sep 2026 19:33:15 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Cunhao Lu <1579567540@qq.com>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 02/22] can: skb: make echo skb freeing safe in any IRQ context
Date: Mon, 28 Sep 2026 20:45:09 +0200
Message-ID: <20260928193312.553632-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928193312.553632-1-mkl@pengutronix.de>
References: <20260928193312.553632-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cunhao Lu <1579567540@qq.com>

can_put_echo_skb() can be called with hardware interrupts disabled. Its
direct drop paths use kfree_skb(), while can_create_echo_skb() uses
kfree_skb() when cloning fails and consume_skb() after a successful clone.
None of these helpers is safe in every IRQ context.

Use dev_kfree_skb_any() for all drop paths and dev_consume_skb_any() when
consuming a successfully cloned skb. This preserves the respective skb drop
and consumed semantics regardless of the caller IRQ context.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
Link: https://patch.msgid.link/tencent_E84809CF236D0137885E7E4E4D58340B3208@qq.com
[mkl: also convert can_dropped_invalid_skb(), can_dev_dropped_skb()]
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/skb.c | 6 +++---
 include/linux/can/dev.h   | 2 +-
 include/linux/can/skb.h   | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 4f7a189de265..e0eac3678a77 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -63,7 +63,7 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 	    (skb->protocol != htons(ETH_P_CAN) &&
 	     skb->protocol != htons(ETH_P_CANFD) &&
 	     skb->protocol != htons(ETH_P_CANXL))) {
-		kfree_skb(skb);
+		dev_kfree_skb_any(skb);
 		return 0;
 	}
 
@@ -91,7 +91,7 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 	} else {
 		/* locking problem with netif_stop_queue() ?? */
 		netdev_err(dev, "%s: BUG! echo_skb %d is occupied!\n", __func__, idx);
-		kfree_skb(skb);
+		dev_kfree_skb_any(skb);
 		return -EBUSY;
 	}
 
@@ -399,7 +399,7 @@ bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb)
 	return false;
 
 inval_skb:
-	kfree_skb(skb);
+	dev_kfree_skb_any(skb);
 	dev->stats.tx_dropped++;
 	return true;
 }
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 6d0710d6f571..346faddee02e 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -176,7 +176,7 @@ static inline bool can_dev_dropped_skb(struct net_device *dev, struct sk_buff *s
 	return can_dropped_invalid_skb(dev, skb);
 
 invalid_skb:
-	kfree_skb(skb);
+	dev_kfree_skb_any(skb);
 	dev->stats.tx_dropped++;
 	return true;
 }
diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
index a70a02967071..78c5870e2f9a 100644
--- a/include/linux/can/skb.h
+++ b/include/linux/can/skb.h
@@ -76,12 +76,12 @@ static inline struct sk_buff *can_create_echo_skb(struct sk_buff *skb)
 
 	nskb = skb_clone(skb, GFP_ATOMIC);
 	if (unlikely(!nskb)) {
-		kfree_skb(skb);
+		dev_kfree_skb_any(skb);
 		return NULL;
 	}
 
 	can_skb_set_owner(nskb, skb->sk);
-	consume_skb(skb);
+	dev_consume_skb_any(skb);
 	return nskb;
 }
 
-- 
2.53.0

