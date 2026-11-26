Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795707104;
	b=BjHd1XVOihDH+HIZNY4PuxV9OkWz9xIgEO7THFrMIYcitcVuqcz1bAIUPyYhmnh/LPl+
	 Zxbz1xbtWYVefNREA7uQPpq9Ksy6RLpxXibtcjrKrTH66DD6uXL07qFPipKt19S+2jT7t
	 GzzKr2dMgtNltOAjEdBqMij7qyIjiiUt2m9OlhO/0fkmpVVdPUHbkIrnCaS8lOlI6rFhE
	 3eM/MRqyIRPsV2mKSvukba37n9/kWFGgpLbw99YLneH20QGOQDrKu59IUsj/j7UZdpgC3
	 7Ght/PsYmpNTxLYXGX1FDTYd31/QBx/qy++rKjMXxWdL1DTlCixXtdL/5iNuwtGLuGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707104;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=gfBgWheG6vl1HDB8ocd5JKqGy4XbQhflCvVqhmAKrN4=;
	b=IH1kdupkL3cByZHQ3VBwJVOzFhYd7tk+VwVLv453SeQoEMq9CixDncZXpZRAnAjnvYvJ
	 VjrYIyYtemF8vrHHDVP8j/nWnSptCMQ0rwpu3Iq8W9MyLlD+94pyLI2Nb0iddo1NZZDc4
	 CKm/GwgdqfalfkLPRWTmvhtLMxgwxN3UXWHP8539mr1ASK8HnxC/u6aGofMHY96OAWoGi
	 Xel9cllrUoEydLhK+7tze6/BSyL+1z73dzCYxZHW2RCJhNJmFpzJafF+xj2b4KCQ3+MD4
	 1dAo5nYzSIptlX4fo17Pxzkw+WvQSFVgsQi3D6I/FGl09C+DbUaTn3Q4zlj9ddJweMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A89kHXbr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87F0606A332
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A89kHXbr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8831F000C0;
	Thu, 26 Nov 2026 15:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795707104;
	bh=gfBgWheG6vl1HDB8ocd5JKqGy4XbQhflCvVqhmAKrN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A89kHXbrDBP8irsPfovyuzyIMeqQ0hXvqBZmezOjy0tqTmo3+60/qVDu2Mi4zTXZP
	 y6F/yb/4R348STJzZTLGkWn5tZNhDb1D9I9+xp2aZzM3gS/nAVXmiJfbicEnT2in2X
	 ZNxNnll6yulXVqoc9CJq3BP277VMvD4bAXJR6/eiWacgxLrjtGE+WY4Nq4RT5ehT5n
	 YiZcDllSm21s8tdylnsD5z+MglrtpOA9dhpLjnYQ5jC5dB9XzMrCE8hOFspF73w24l
	 9Ko6nzBrqeicEQuAaf5MOhTEzFT+asxVXxsAUOZlZDT8k1poKiyP8xw+ZrzIZEM/16
	 F9tU3jJmhC7zA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
	Brooke Basile <brookebasile@gmail.com>,
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
	Felipe Balbi <balbi@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Colitti <lorenzo@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] usb: gadget: f_ncm: remove timer_force_tx field
Date: Thu, 26 Nov 2026 10:31:39 -0500
Message-ID: <20261126153132.2453772-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112552-crinkle-hurling-1987@gregkh>
References: <2026112552-crinkle-hurling-1987@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Maciej Żenczykowski <maze@google.com>

[ Upstream commit dbaaca9aa5ce36c07a01a157d203071f6332a2af ]

It is simply not needed.  This field is equivalent to skb being NULL.

Currently with the boolean set to true we call:
  ncm->netdev->netdev_ops->ndo_start_xmit(NULL, ncm->netdev);
which calls u_ether's:
  eth_start_xmit(NULL, ...)
which then calls:
  skb = dev->wrap(dev->port_usb, NULL);
which calls back into f_ncm's:
  ncm_wrap_ntb(..., NULL)

Cc: Brooke Basile <brookebasile@gmail.com>
Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: Maciej Żenczykowski <maze@google.com>
Link: https://lore.kernel.org/r/20210701114834.884597-1-zenczykowski@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 78585f90feb3 ("usb: gadget: f_ncm: restart the TX timer if the TX freelist is empty")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_ncm.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index 609034f51fab4..558ecd0331a80 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -72,7 +72,6 @@ struct f_ncm {
 	struct sk_buff			*skb_tx_data;
 	struct sk_buff			*skb_tx_ndp;
 	u16				ndp_dgram_count;
-	bool				timer_force_tx;
 	struct hrtimer			task_timer;
 	bool				timer_stopping;
 };
@@ -1128,8 +1127,11 @@ static struct sk_buff *ncm_wrap_ntb(struct gether *port,
 		dev_consume_skb_any(skb);
 		skb = NULL;
 
-	} else if (ncm->skb_tx_data && ncm->timer_force_tx) {
-		/* If the tx was requested because of a timeout then send */
+	} else if (ncm->skb_tx_data) {
+		/* If we get here ncm_wrap_ntb() was called with NULL skb,
+		 * because eth_start_xmit() was called with NULL skb by
+		 * ncm_tx_timeout() - hence, this is our signal to flush/send.
+		 */
 		skb2 = package_for_tx(ncm);
 		if (!skb2)
 			goto err;
@@ -1160,8 +1162,6 @@ static enum hrtimer_restart ncm_tx_timeout(struct hrtimer *data)
 
 	/* Only send if data is available. */
 	if (!ncm->timer_stopping && ncm->skb_tx_data) {
-		ncm->timer_force_tx = true;
-
 		/* XXX This allowance of a NULL skb argument to ndo_start_xmit
 		 * XXX is not sane.  The gadget layer should be redesigned so
 		 * XXX that the dev->wrap() invocations to build SKBs is transparent
@@ -1169,8 +1169,6 @@ static enum hrtimer_restart ncm_tx_timeout(struct hrtimer *data)
 		 * XXX interface.
 		 */
 		ncm->netdev->netdev_ops->ndo_start_xmit(NULL, ncm->netdev);
-
-		ncm->timer_force_tx = false;
 	}
 	return HRTIMER_NORESTART;
 }
-- 
2.53.0

