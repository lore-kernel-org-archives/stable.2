Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792957916;
	b=tZJibxKqdplSEam1MDgm26JoPm98GdEMvjLkbJ0/42kzPe9o8reR4OiP3SIJqYc3rN7n
	 SrDzWZ8VIbjHMcQrp6vU1Z8eVxiFYn7AFMh+Yl8tYB0G7JjJ+M9L58K/OPJW9/BF4fazF
	 Po1Nt5Q0gAGLkWxotXYZaoJo4WuBBgtgOtLZl87nm+HwLPISodDliEIvaFT64+fQZsGK+
	 5IK+zp2ZIWIcVSfu47SzwDyJsQjqEISvEDKlOFebVLRtsYCkYmxiwAsJyC3R3CCsqTnNA
	 MGwOYyxXKokqSJLU17dN24TcgRDfloMJvtXZ67+IPYid7eTWfaEZUps6l6v8GszhlCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792957916;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=Ho4IWGIxp4cUSPCoVpsc39vieRM9IstPzNMqU1/dxaM=;
	b=ScEaHIVNuz9OV2rkr0bV27y0G/t1ZvJ7WyoF3qQxoeshD8foFIlGs29vUG1Y9/7H6hiD
	 qzqFXhIQhEQfIqU3pCAymapIS872k0I+rH8IRDAZCr0xqSj8QB5fg9uwRflGnjIJx+tmx
	 u6tsnG/yEvnjjpn/3hq35nBlCjZJmAbkhf6Ad9oKMtOgPBPf7Qa1OKQQMXS1RTSBFzJK5
	 aSrO8dOlx5rgb5E2j0yA1SZJTlUaahK41T775c4Cx41b9YB8z1cMxkkRmxqJHLrR9r1cB
	 Ov9/YKvr9goLkLk1xx409Wpu8jWif3eO0wOv3vKnMgl8hncbMbXhGJu6IEWq5kSc94A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=dDV7UIHi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53B6606A31D;
	Sun, 25 Oct 2026 19:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A53B6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=dDV7UIHi
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id EEF57201F35;
	Sun, 25 Oct 2026 20:51:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792957912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ho4IWGIxp4cUSPCoVpsc39vieRM9IstPzNMqU1/dxaM=;
	b=dDV7UIHi79QAmBstWzNFoS7a9+QXeUI0fP4oKgTDEOyTcICuJD5gg6W3ia6tNWAMF61wU6
	MElBp3jie+cwuVaCqH3Ed4kmV1MEX7jL2SMT0v+xHUbmpHLvXjR08tZ09IgbjXRkuuH/f1
	GViOXobtz7K+ZvwB+TYPYMp96WjMYzyKLIvBo7Bbxh2BH/DZW927xevbRULeQvqIBPonc5
	3ZhZzVm9GZw0iVRdA0LN8JzuD4hungEQCR3v+lyHDvRh595duB7jSH0vLkL/YwH/70wgcj
	NncsM+PmhETLpP1yvDlRSpLykQGnD5xeAhbOH4GLrTCGdxoYJIWaSL5khj+ouw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792957912; a=rsa-sha256;
	cv=none;
	b=NFg82yYjjNcWUvE83DDtiUEEy6tZDlI81owQNu5df7ezwg5tKgwXjt84LilcuCQKtHSIco
	X8975P6x8VoP+DyCC/sT7BKNwJ6/olDRVP5qDCSgh4MDnX98KZPB6y/0rm0wG24LmpqUI+
	URyvVt4aLIZkdgCsD0cnifr+da7wmDH7M0b8GiKV2p97Wev7QWwP+8GJAEin/UlxBzLDR0
	LQIiiHMjsZCmJ1VXw84orAwz43ys5+aU/c1jyXVDBgWBC8HGGdXl9CqiufNBo2ldi2wsk3
	9fNW8HrV7YTN+DTD1qTfUyNVqM/DAi/hIWLuucwGob9LSiumVVbaUTbEhTqePw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792957912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ho4IWGIxp4cUSPCoVpsc39vieRM9IstPzNMqU1/dxaM=;
	b=WJ42xSic2xl+eDy2Xa8INPBgGWxfxcoG/GxpASa9UmVIsRO6jZU3XCn0zuU28DOJhaoO9N
	c3AeUP3Pn3Yh54ZXHWQEfN5SC9dqhxcQMSHyIGMtof0PKv1Wck6SljgqLdqs0KucJwgkcU
	IvUd5xv8iiA1zX5Na6/hHrcIQeNeXPLyc/q8sA5v0mMGpX4dKXZzjj+8ovNwih/ORvMv1P
	qlDxnTdubRPncdBAUhMXADlSSjFjmbK+aKe4PlMPpqoUF3bZz05w2n93jPAgvvuuCQMSr7
	HYjt6rHsBKcS+8j2Uw5CGA+D12ZUA63x+PmHKnDrTGKMkJwjNFw6Di9S4o0ipw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xL4G0-001AwQ-2q;
	Sun, 25 Oct 2026 20:51:52 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 991335D41F6;
	Sun, 25 Oct 2026 19:51:52 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 25 Oct 2026 20:51:43 +0100
Subject: [PATCH v2 3/4] can: gs_usb: gs_usb_receive_bulk_callback(): check
 for overflow flag if SKB allocation fails
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
Message-Id: <20261025-gs_usb-fixes-v2-3-535d45097f72@pengutronix.de>
References: <20261025-gs_usb-fixes-v2-0-535d45097f72@pengutronix.de>
In-Reply-To: <20261025-gs_usb-fixes-v2-0-535d45097f72@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=1970; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=ynAG+Qxx+pAunR4gpF8HPqclCGHH5tSQnqcWeLT3OEE=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsi6F3t1YpmsmY286eGqtTaXeerVL74Sre+cKO2ocneJL
 s8SHqnejlIWBjEuBlkxRZalP04oCgQ6lPa+TJgEM4eVCWQIAxenAEzEMZqR4ZfXjPO3p26Z4d+w
 ab5KdfbNM7aizaocvjb9V5ruzuFMZGVkOG/tsDPBKDlPrmHZxy6hnWvjLT4UhJYXsjIey/6kM72
 SBQA=
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

If the allocation of an SKB fails in gs_usb_receive_bulk_callback(), the
function neither updates the statistics nor checks whether an overflow flag
is set in the host frame.

Instead of directly resubmitting the URB, first update the dropped RX
statistics then check if an overflow flag is set.

Closes: https://sashiko.dev/#/bug/linux-7b3fe6a0-4628-4d0e-aec0-69f4bf8ad5d4
Fixes: 68c5724ecd15 ("can: gs_usb: gs_usb_receive_bulk_callback(): resubmit URB on skb allocation failure")
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 2564c1672793..e3bf1c7cdd83 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -673,8 +673,11 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	if (hf->echo_id == GS_HOST_FRAME_ECHO_ID_RX) { /* normal rx */
 		if (hf->flags & GS_CAN_FLAG_FD) {
 			skb = alloc_canfd_skb(netdev, &cfd);
-			if (!skb)
-				goto resubmit_urb;
+			if (!skb) {
+				netdev->stats.rx_dropped++;
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
+				netdev->stats.rx_dropped++;
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

