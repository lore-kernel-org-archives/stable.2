Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794564537;
	b=m+Cg7AtrftBfmGRxCDAx/hznIY934n+QwnhCbtvjNMfZaz1UpuvPrzGDzXzxEElQEe5q
	 m282fqhcsRXTsh/Z3I7PKyfzqW9uPrrfBpaVlgfmfLbNI6+DJvYtalKZ0bnzAc56q2clE
	 vHF9ZWO7g7cOHXvi/6oaRpo+FmPPq8C6JCV8z8/J1N//kJNVtvgY9BnlLehozM5sV/P6K
	 MbF00Mv8EOtutSozwS2XZLkqCMFrnvQTCrb/Tk2JISYlhPRtoCxpzAHSJ9IWZzScJv9lr
	 sx36FqIlledSlDFmzrG/7jkM8tO+wyBHdiqfvckJKyeA5+jpdqo9+mwWqcNQKoMhX4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564537;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=i5HDg/CFXsBlwdhC2HztgZaTS7W3/FOOnLOcAl13fDI=;
	b=Sf5qNSsyPEiVTyhvkATs1H6Vy6e7vUY3N0b2FidbOHcGg3m/TP6ZzKdDC9n5YarZA3LI
	 h23BgMcqxBQec+CPCF2hZN2ZMe4vc7OsNjNatyawqdKzFwFdz/+YcOh5/7mBORz99lpRF
	 yvbTtHaPh8aWd+WbHfieNO5CTxzhGMAT7mbMpH4Ct1Iqd28HzrEJhUHGYCejNUOy+g4Tg
	 XzOdYpes0haIWTjj4Vh8kjvPxKq8Cn0ABdRicAtiuLHGiOoNYp0AIL/A4p7wnMcqC9r5y
	 my9nhSC3Y3hbgWk589oWj86rTfv37fb2FsP9+N74vqTVNK0WoYFd1xQX3BDoxL6O8Wg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=QkeE9b5S;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0E8606B11E;
	Fri, 13 Nov 2026 10:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE0E8606B11E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=QkeE9b5S
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A019A2020ED;
	Fri, 13 Nov 2026 11:08:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794564534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i5HDg/CFXsBlwdhC2HztgZaTS7W3/FOOnLOcAl13fDI=;
	b=QkeE9b5ST2G81B8vcybDRm+01loub3yvT9klhBww+ttm4DWb7cFSxNNhp1VraJEVIfymXB
	eiinGMcdSU9TRCRMh+qVVa1VOd3mJ3SId50tJyOHiuUAlzw6avIFmy+8BOUlpXAYNTr5ln
	fB8YQkAKgyEpDJR3gf8SwG/6aOw4nxL1OaZNybAABQqrdkIQzksnGknb/+wF4iwUsFSYcy
	5/rrq5dfHV7salzD9v6w51tb448N4pmhEJvSecqa8wTnzQBKA1dBGnBYsh50WmVEvDAimO
	xcmPyaZ8TqTt6TFxDtBFWuUxjCgum23jYOJ6IFRCndUmeX3krqnlv1e6yn5V3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794564534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i5HDg/CFXsBlwdhC2HztgZaTS7W3/FOOnLOcAl13fDI=;
	b=OkxCMJGyFdBdRnLUpnIhmn9rtcafyOgbzEBekqdS776/AWoROHCLJdc0Boe6mPf/UV52Cv
	i7H96sLetmzepUA8aGcm1+4RM5wcOKHov866ogZYJHa/uvcF4qbGrJzQvhaRbN14OVBVMA
	Kl5XQuYtqh6rMOpni2aBXAyWsy6qgmvAK6N7GhSMLOVYE2qQ+U34qVk/prfOxdESCWnLLZ
	Fb8Zq5miaKUIjduAEFq4odmRwnblBnWT862dkg2hbpSH5tDbU5l99AeLbBl1LUzBfzvAuT
	RvZ85vL1oLGsFfggjoRPP+lIO8BzNUD2d0foY/UkpAOY8V4JrAWDrL1bdtD1rw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794564534; a=rsa-sha256;
	cv=none;
	b=CzTBdE3ZJ8iTi+qlkjZSGTWTIprbh9YF7AcbR8GJWyzBo5jdLNVBA+ZzYebeuwo7teuDyO
	o3qzbemIzUFDEPCkSXQT6VjNDIU8u8EY5Jo/W4Vx08dwMg5UIbzJjVWrthUr9PIKeRbQJn
	/Tv1Yb7Vqecet0NvkoqytL/4/Y9c7BFm8Idp59ZrQXXG5ulgkdjUm/81BJYMIc4W/i991O
	pzh1uv56qWefFqvwLH6SN/46SwXteGuJOrWxleeF2tny+GLFmSoNrffZsJW8wJvfmrDq8H
	YYBRvEqMeys5bPHSA3S0PNxA/pGWfCvtsCyxGF0M2I8bWCFF3jGA475ZxQxWSw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xRoDG-003ySJ-1m;
	Fri, 13 Nov 2026 11:08:54 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4472A5EA850;
	Fri, 13 Nov 2026 10:08:54 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 13 Nov 2026 11:08:41 +0100
Subject: [PATCH can-next v6 4/6] can: gs_usb:
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
Message-Id: <20261113-gs_usb-fixes-v6-4-0c039e1bfd74@pengutronix.de>
References: <20261113-gs_usb-fixes-v6-0-0c039e1bfd74@pengutronix.de>
In-Reply-To: <20261113-gs_usb-fixes-v6-0-0c039e1bfd74@pengutronix.de>
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
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsj69nBjw6d7RecX6GjOvGWyTvRsjc2Rnf095d8Fj3FFH
 JI/8FlsckcpC4MYF4OsmCLL0h8nFAUCHUp7XyZMgpnDygQyhIGLUwAm8kuB4X+GqUBdxMkn27VV
 Kx1L4ss/yivrP5z76Hv1qfoNQUnRzAIM/3OeCrjNYTz24XEIe6ZqyIOdbpcfzzv2JOWB1eXyj1c
 XNDACAA==
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

