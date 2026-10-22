Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792679277;
	b=kn/eO9CyUwdFu1l2xvfNW4sWq4xn72svrqaUwiOTrvp19JUQiV8HeDXvgf5H5fiJJzKp
	 4iJXmlvFd/ZxJL9AUpx9HJPfF+mUX0eUWCncAkCyN8g+/wNgpuZGZNjtMNbM7tD8oFCwO
	 s7koOOs0SZlDiEkDJ3DhHRciKyJ5ZUBytcv/SugCNJs6S+pXVqp7Iaw60cT5cVZymo3La
	 GI6P0t7qd7BCUBp4EhIWjiGW81/55A6YXAo12WxSp2QNKfxL0pDRq/u06xn6Looio3uiv
	 WoFjduRzl1R/F8keLZiAJpOPid01X5WVyXXoPnfvk2Ce5abvxL0qxGtIHNYD0u5eV7w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792679277;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=GV6DpcdLnN2Uvs6U1XAnhvBF2D3SpTvhLUcFYELrVn0=;
	b=vd74eX4pWUz4i610c3JCRoxQWgE7cgIQdQbvPwuyAGLuaYXQ3cftO5Z/4SuVAixI0/PZ
	 vVyYnG0EJbmk7YiXYR26IOcDxKdA7YAjNAlQoM7Ysepv/e9ajwDkjLeh1fVjKoRv7OIyf
	 klNKS3fKRsajOJVbZ1leCJiZpFNwYXdoGDSDMtDvDFygJ+Zp968BiB3ynf7rUdsAFrfZT
	 tLAcanhjfaF3cNt8m5rrg8IFC3+jnrSCzhuQvuU7nzAvVxxd2gA4EwttTrsGrwsSdf+IB
	 w7AOxYYm3RqVDoR0iKkHKYzLG94oU3mp7rePZbp/IkIF1pWyArn4tSn/v8QJPzOs6Jg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EX2GHJ30;
	arc=fail smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3FE606A326;
	Thu, 22 Oct 2026 14:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EX2GHJ30
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792679276;
	b=dSAw9Rh5NzVF+gnLdkyqK2p+2uEnDX2r5W+94bL3oDcr/QpJ9mGnOV03vJpgegyQvx0a
	 pDgKLRDhyoQmZ+O43TuHACbOHCNf03hVJhTz7vAAxt1T/GiLETQMqL9VMCfhx3loliGr/
	 4cS9RcP1HwHvxmDXuVWRxgRyKz1hLCcfxWfMG2no3rfal0i6BdhmL61DOOnzBhvyY7wvi
	 xMy3paLrnDAff1qa9sbZ+ifwDysS+pl03saXKTrmi9uO11tVQSZeUlhj3lvOUeloQIpt5
	 1Zp5W+gPxshMuyEMQbsewrbViuY1ECb7RGyh+/op4332FTjsMhjXHeaRp+U9wcZk5jA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792679276;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=GV6DpcdLnN2Uvs6U1XAnhvBF2D3SpTvhLUcFYELrVn0=;
	b=ZPrnEYUftRCBxZcXtraoGVuox1Vm1+aB3KTy6EkZ5C0rw4S/cI9h3cKdZKXZe3/pNEhM
	 nWA28SVx4Bs3cE/Eix/VEDVl4hGDU77qNE3+lHBK3Hlp4/SWKPcq4kz2qjqIvFf4zfSpa
	 WXeTWGqQJGoZGkyeiwsWVKFyeb/4JMWqfWODoc6Zs/9B6Zf0LkkA/I/IvUZvRDZtZf0RF
	 4XGhDwyzLa0eWZKdLnJEwLJsCiGluNdi0G/et0BXD5aS1chogtIRaKb9ZqNZ2n1KKgv3b
	 QIkTvw6jX4Q/ti4yxgLlPKndVjuagLNNxajX8jTsTKs8YLAtnb7Lr2AFnRf5zzfs6xA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 268701F000C2;
	Thu, 22 Oct 2026 14:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792679276;
	bh=GV6DpcdLnN2Uvs6U1XAnhvBF2D3SpTvhLUcFYELrVn0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=EX2GHJ30/8rEgz498r5UDh8enO+esC1rpbzJsAsLs1gK96nKsdpg5//qTdEa25GwS
	 9ezxvoPEg4fHAQpuWoCguPTCgWjBq9ssF1r5Zic0YcQVmtglrvECKGkJGRaJJz9CBF
	 JmanBynUQ0gLH9S3IaGNQ3btXtG9jLqZjq03cRhN+68SIG0xljqzJqA7y5m6A/nOrH
	 eR930WagQGAy3zqJMYM6+11ifpsY68RLdycgrBpXQOW3xZ2umKlbmI9WInkI1Yp0Lh
	 3fmrLmYLlisRqUHh0kbkCDCoc5TrV0DvNF/5F7WZssflVkZ4wSrcdREBzrgB+GNYKf
	 jHD2bzhKeXmYw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A0E41435BD;
	Thu, 22 Oct 2026 14:27:54 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Thu, 22 Oct 2026 16:27:49 +0200
Subject: [PATCH v6 04/13] can: peak_usb: harden PCAN-USB message validation
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261022-canfd_check_channel_idx-v6-4-197704231551@peak-system.fr>
References: <20261022-canfd_check_channel_idx-v6-0-197704231551@peak-system.fr>
In-Reply-To: <20261022-canfd_check_channel_idx-v6-0-197704231551@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 Dan Carpenter <error27@gmail.com>, Lukas Magel <lukas.magel@posteo.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792679273; l=2405;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=LNJxjD40OicVTQ7mrQyRKIhh12W70qmFLHehYVIxU8g=;
 b=Dd+5yFi+hbn26Xx79kd1lHonRVOMTQ13JTbeUMjopcNABfeNMQwTBymx5lRgCUPNiHlBazD9t
 +vtwvrqCjy8AxFi13s32QS+3UhZHYu62eINRn1doyvio6glejook5ek
X-Developer-Key: i=s.grosjean@peak-system.fr; a=ed25519;
 pk=bP7QV2zvvAKAfConZlUOGKGEcXL64SNUpVUm++Ai+/c=
X-Endpoint-Received: by B4 Relay for s.grosjean@peak-system.fr/20261020
 with auth_id=1250
X-Original-From: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
Reply-To: s.grosjean@peak-system.fr
Content-Transfer-Encoding: 8bit

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

Add boundary checks when parsing PCAN-USB messages and reject
malformed buffers whose contents would otherwise lead to accesses
outside the received USB data area.

This prevents potential out-of-bounds memory accesses caused by
corrupted or malicious device messages.

Fixes: 46be265d3388 ("can: usb: PEAK-System Technik PCAN-USB specific part")
Cc: stable@vger.kernel.org
Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 169c00d93463..5da91d5dc67a 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -558,6 +558,8 @@ static int pcan_usb_handle_bus_evt(struct pcan_usb_msg_context *mc, u8 ir)
 	switch (ir) {
 	case PCAN_USB_ERR_CNT_DEC:
 	case PCAN_USB_ERR_CNT_INC:
+		if ((mc->ptr + 3) > mc->end)
+			return -EINVAL;
 
 		/* save rx/tx error counters from in the device context */
 		pdev->bec.rxerr = mc->ptr[1];
@@ -696,8 +698,11 @@ static int pcan_usb_decode_data(struct pcan_usb_msg_context *mc, u8 status_len)
 		mc->ptr += rec_len;
 
 		/* Ignore next byte (client private id) if SRR bit is set */
-		if (can_id_flags & PCAN_USB_TX_SRR)
+		if (can_id_flags & PCAN_USB_TX_SRR) {
+			if ((mc->ptr + 1) > mc->end)
+				goto decode_failed;
 			mc->ptr++;
+		}
 
 		/* update statistics */
 		mc->netdev->stats.rx_bytes += cf->len;
@@ -733,14 +738,19 @@ static int pcan_usb_decode_msg(struct peak_usb_device *dev, u8 *ibuf, u32 lbuf)
 	int err;
 
 	for (err = 0; mc.rec_idx < mc.rec_cnt && !err; mc.rec_idx++) {
-		u8 sl = *mc.ptr++;
-
-		/* handle status and error frames here */
-		if (sl & PCAN_USB_STATUSLEN_INTERNAL) {
-			err = pcan_usb_decode_status(&mc, sl);
-		/* handle normal can frames here */
+		/* check if status_len byte can be read next */
+		if (mc.ptr >= mc.end) {
+			err = -EINVAL;
 		} else {
-			err = pcan_usb_decode_data(&mc, sl);
+			u8 sl = *mc.ptr++;
+
+			/* handle status and error frames here */
+			if (sl & PCAN_USB_STATUSLEN_INTERNAL) {
+				err = pcan_usb_decode_status(&mc, sl);
+			/* handle normal can frames here */
+			} else {
+				err = pcan_usb_decode_data(&mc, sl);
+			}
 		}
 	}
 

-- 
2.53.0


