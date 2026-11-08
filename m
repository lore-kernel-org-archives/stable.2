Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794171226;
	b=CV5NUVMON1zEC/yTf6RGZe5/wz2heySZ1jAoUgH3URdLFud2iMdsoYRFYScx4YTRVaZE
	 sS6dCNvNZObmPk9IkKUuGplXTEagTDGEFonm8RZx4ek73lL7wE5rUuVenia0S7hbnZLn4
	 LCKK4wpXUNJX5oRu5TaeePNLOByhNvBWT6rnMog3JzNANP4zegON2mNinH1wUEWerri6T
	 4GuHkhMl1b2m87hum16w35c7m5nzknjCz214f6Su6QHnbhj203QtchGRoFH8b9Y6AKFPc
	 3E+6NP3Y0vPY6wMKU0QkiRwvmeyDANdtGLrNjRX7fqljnKO4+ZXhgulFBU5BhPtbgdA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794171226;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=i5HDg/CFXsBlwdhC2HztgZaTS7W3/FOOnLOcAl13fDI=;
	b=t2v0LXatRjdWGrhiPBLmggyPZ8VJbqn0n6K5CiHt5pYfELYTEP7wSD7WbV/NkJ4Npesu
	 +BMSweTw9Uvu7IXf9jOguhfv5jIuZNHGpMDtmi9YtFcVxp9XAkCnpzWWa5xy9fL9Y79ax
	 6rWtD4ojCdCmYogpKH7nk0JjUpAH9U11pYq/df4D0GN7f8RY/dPPK+gxk8IQyr0NgrSSW
	 SScXVUzST2PfrJhJjcjQR03HhfJVUAQ1YKVahqggx4o5YPDDfItD7aX2vX9XiCnUhFOim
	 ++cmvOEXtfy+bLQz6vvYdJqjbxCfQBoJiqJCyEKxQqQtZQrSgb025N7Dw+O5n3NCUMw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=V5BALTeJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4BD606A32A;
	Sun,  8 Nov 2026 20:53:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC4BD606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=V5BALTeJ
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E3A6D2018FE;
	Sun, 08 Nov 2026 21:53:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794171219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i5HDg/CFXsBlwdhC2HztgZaTS7W3/FOOnLOcAl13fDI=;
	b=V5BALTeJENP1YESVLx1Gcp7W+mqsXwBYJ2g4H9tYntdi/t2TWVSWD1ZUbEzG9Ad3s2oAAs
	9kBbVGkIb8UPt4cpfueJioDweACCIK1mAMsefhcjJDYtXtMVRbSxnY/doigwfjvvwz3xBg
	uLSdtVYcx6HHwDeDvcE0RT6kK/JG7TEgucP1qpqbQXk/rOA+tUgfAxuz5elFVeWy2dJyaW
	DkHbQWV66/h97tRke/1MuJG90DcvvWIhvTj8Z6ZAvPEaGEHAne7naA5Lu56E5jFXlXrUFs
	x97gazaF/rD9cqMiFFZ0VnLBfinKADEvXCmMmbp5LUbvQaTYScuKkH1RysJcpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794171219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i5HDg/CFXsBlwdhC2HztgZaTS7W3/FOOnLOcAl13fDI=;
	b=Q7ZrjeXkpXiNrL4JWBL3fdB5IOXw+uWTFeEPAQrO3rx6tzwUt3Azn5Mdka7FLTC8A048Mp
	RHmIN3pbcze1SsRNqldbZGYawVcKLC3KgaHTh2RQVmIbz73TR6Q836zotD/IAwh1yzO43C
	KzDOOlkpshj9ragHaHC5kpJrbtE+ydkIpeG7rFDlmKqOWICy3RKCRb1eQFemisyQHRnQ8Y
	tgOl/mva8UW7f9J3tgfVT2hCNOBngVxsWqeyyFihi/IQ0MJo4IqUjz2hOT6lxaleO/nIe2
	X1VsRTNGCVhTsTzbQ1b/EeaxFPLIf3XefV6sKEbgc+kU0UnZU9OiOaQs/HJruQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794171219; a=rsa-sha256;
	cv=none;
	b=ZbChf1Sh6/twsuXtKEeEDK73VGsuwq3KMNewBv54/TL2ElXAZhwrgLo3TOofP0FtLai6qL
	6LM9YWcl2BvqO9TsxSYc9GhOOmRgn1xSd+X49O1GYuYV3gWvM/8zn6M6tSPu9mzrq6oX/s
	bzlUF0/Mt5Q7jEOHA+5PV+PxcQvUsAYlrg0zUvE5B1ucV9GjJCL+/JtnLGeiD0+quLC0Ai
	5ppWmy+20MmhX9+DIyxl+8tCJ2tRsrOPUXD5QBumeXm1aZmlDcWPgtwe/E/K24pwX4CHYj
	UleFGp7ueAeDNIuNQT/nBxPr6ilyZmm0xcqfIqlc1xXFvPpistx+2PI1WxUAHQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xQ9tT-003EmL-2Z;
	Sun, 08 Nov 2026 21:53:39 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7DC075E3E77;
	Sun, 08 Nov 2026 20:47:37 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 08 Nov 2026 21:47:25 +0100
Subject: [PATCH can-next v5 4/6] can: gs_usb:
 gs_usb_receive_bulk_callback(): check for overflow flag if SKB allocation
 fails
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261108-gs_usb-fixes-v5-4-d52dd4940d46@pengutronix.de>
References: <20261108-gs_usb-fixes-v5-0-d52dd4940d46@pengutronix.de>
In-Reply-To: <20261108-gs_usb-fixes-v5-0-d52dd4940d46@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=1983; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=gkhuiVcqrJlOGPMm9/NnRTfd01cTxBDmpdwQfK7dDZA=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsj6cP+Zj9j/ug9nOE9H2/9wOBNzzfoUX+muj6Em3+99N
 Him1ce8uqOUhUGMi0FWTJFl6Y8TigKBDqW9LxMmwcxhZQIZwsDFKQATWV/AyNDq95Thd8eibvem
 E/qRa2WlsyST7VrZQqdlPV3ieH5+zxmG/9W/P14tyGZyltu58ozT7RnVyW+YfA4+9Lr+X/+QZUU
 PGyMA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

If the allocation of an SKB fails in gs_usb_receive_bulk_callback(), the
function neither updates the statistics nor checks whether an overflow flag
is set in the host frame.

Instead of directly resubmitting the URB, first update the dropped RX
statistics then check if an overflow flag is set.

Closes: https://sashiko.dev/#/bug/linux-7b3fe6a0-4628-4d0e-aec0-69f4bf8ad5d4
Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
Fixes: 26949ac935e3 ("can: gs_usb: add CAN-FD support")
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 1527163e8c35..a42dba9d158e 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -673,8 +673,11 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	if (hf->echo_id == GS_HOST_FRAME_ECHO_ID_RX) { /* normal rx */
 		if (hf->flags & GS_CAN_FLAG_FD) {
 			skb = alloc_canfd_skb(netdev, &cfd);
-			if (!skb)
-				goto resubmit_urb;
+			if (!skb) {
+				stats->rx_dropped++;
+
+				goto check_overflow;
+			}
 
 			cfd->can_id = le32_to_cpu(hf->can_id);
 			cfd->len = data_length;
@@ -686,8 +689,11 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 			memcpy(cfd->data, hf->canfd->data, data_length);
 		} else {
 			skb = alloc_can_skb(netdev, &cf);
-			if (!skb)
-				goto resubmit_urb;
+			if (!skb) {
+				stats->rx_dropped++;
+
+				goto check_overflow;
+			}
 
 			cf->can_id = le32_to_cpu(hf->can_id);
 			can_frame_set_cc_len(cf, hf->can_dlc, dev->can.ctrlmode);
@@ -728,6 +734,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 		netif_wake_queue(netdev);
 	}
 
+check_overflow:
 	if (hf->flags & GS_CAN_FLAG_OVERFLOW) {
 		stats->rx_over_errors++;
 		stats->rx_errors++;

-- 
2.53.0

