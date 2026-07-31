Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CB23B1EFC;
	Fri, 31 Jul 2026 16:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515397; cv=none; b=nA49fNshF5Q+S2aLw9OhF+4tdu3C/GnFORjkGfW2G9ve45XCI65VrSx5iflGTWpHn9Hms4VpsYSu33EYhS9L5ogy5VGJgEy79w+tewd9DmhZhK/42Md70qGl2LOJQsZU1Kiqz0JyS+Z9DzjR12T+ZzpDgUcsRdn+x/NMUj8AvPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515397; c=relaxed/simple;
	bh=E3F9VDMfc1pRas4Cr9rU7U1Lw0YUs0JbekjfrqgAa5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BUdWKzuYnaJksM8bI3AzysVhQx+aXfR74j+GX1Pjb80H0jU5islotI/s+RoDp/iQgcU0ZZCI8/F0o76WBNu/iSbyJEAmF2LG870fUdP46mjoL2mZ4D9a8QxnEmiYwaxuG8ffNrV6VOCObKMDO8nx3ESNZl4m351+DcmyZrhFXHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgHAV6X0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgHAV6X0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD211F00AC4;
	Fri, 31 Jul 2026 16:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785515395;
	bh=CNBmabwjNApgUaNhGfzXexiRDwAzor0Dbi4MKjetMd4=;
	h=From:Date:Subject:To:Cc;
	b=NgHAV6X0byLxO3CQqD1LMDUpLOB6YXT6jIxk+FXxK+1isg1cGwDtRqHmlFoan7ulH
	 luXPAtOY308tpd1D+p31pQbusOcKWfNC67wH9+qxJ1kv6F5IyIg3vRYlDNjQuGZkq8
	 Eiusr7s6y0S3QXj7QPFtFxCZRlBXq/4OAi2Cwp0S78Cr80B6M/epKOwAq0et1QbpQ1
	 ESSh9rVshby0feY5rFVh08vKjBalDZnweYG0TVjacWKq6coHP8zcn/n9LY3aSku+jv
	 7tEeneaYaFeR08G7JEo7oEezSUYOXs6+tBhRH7BL+Qh12CUQbjqbw4676x6SAEkJjw
	 +rMJ3g5T55WNQ==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Fri, 31 Jul 2026 18:29:44 +0200
Subject: [PATCH] can: dev: can_dropped_invalid_skb: drop CAN XL frames on
 non-CAN XL devices
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-drop_canxl_frames-v1-1-7387b70353b3@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQqDMBBA4avIrBtIItSfq5QSYhx1xEaZ0SKId
 2+qy2/x3gGCTChQZwcwfklojgnmkUEYfOxRUZsMVtunLnKjWp4XF3zcJ9ex/6AoU1ZlYbXRvgm
 QuoWxo/16vt63ZWtGDOt/BOf5A7X/9VV1AAAA
X-Change-ID: 20260731-drop_canxl_frames-189872010abc
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2312; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=E3F9VDMfc1pRas4Cr9rU7U1Lw0YUs0JbekjfrqgAa5M=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDFk5Z+uLrZqXcQXWTN2Xr3WlaJ/8bk2n3WvztHRO9heu+
 n296Exbx0QWBjEuBksxRZZl5ZzcCh2F3mGH/lrCzGFlAhkiLdLAAAQsDHy5iXmlRjpGeqbahnqG
 QIaOEQMXpwBMddN5RoabP6WTlqtfP7xBf0rFny6939v5DJ0X+vgqCXisD8yZFvOP4Z/OooKASss
 QoY9ywhNYLsX+r1j2cJ7Twl9+d8X0eFf5SXMBAA==
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Sending a PF_PACKET bypasses the CAN framework logic and can directly
reach a CAN driver's xmit() function. The PF_PACKET framework only
checks that skb->len does not exceed the net_device MTU.

For a CAN device that is not CAN XL capable, anything above CANFD_MTU
(72 bytes) is therefore dropped before it reaches the driver. However,
CAN XL frames are variable length. can_is_canxl_skb() accepts lengths in
the range CANXL_HDR_SIZE + CANXL_MIN_DLEN up to CANXL_MTU, i.e. 13 to
2060 bytes.

As a result, an ETH_P_CANXL skb with a length between 13 and 72 bytes
can pass both the MTU and the can_dropped_invalid_skb() checks.

A driver that does not support CAN XL will interpret canxl_frame->flags
as a length because of the overlap with can_frame->len. And because
CANXL_XLF is set, the resulting length is between 128 and 255. For
drivers that do not check can_frame->len before copying can_frame->data,
as most drivers do, this results in a buffer overflow of up to 247
bytes.

Drop ETH_P_CANXL skbs if the device does not have the CAN_CAP_XL
capability. Keep can_is_canxl_skb() for the validation of CAN XL skbs.

Closes: https://sashiko.dev/#/patchset/20260731-master-v5-0-5b27029dee20@qq.com?part=1
Fixes: fb08cba12b52 ("can: canxl: update CAN infrastructure for CAN XL frames")
Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Cc: stable@vger.kernel.org
---
 drivers/net/can/dev/skb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 95fcdc1026f8..4f7a189de265 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2008-2009 Wolfgang Grandegger <wg@grandegger.com>
  */
 
+#include <linux/can/can-ml.h>
 #include <linux/can/dev.h>
 #include <linux/module.h>
 #include <net/can.h>
@@ -384,7 +385,7 @@ bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb)
 		break;
 
 	case ETH_P_CANXL:
-		if (!can_is_canxl_skb(skb))
+		if (!can_cap_enabled(dev, CAN_CAP_XL) || !can_is_canxl_skb(skb))
 			goto inval_skb;
 		break;
 

---
base-commit: 8ba098e6b6ff0db8edf28528d1552be261af30d4
change-id: 20260731-drop_canxl_frames-189872010abc

Best regards,
--  
Vincent Mailhol <mailhol@kernel.org>

