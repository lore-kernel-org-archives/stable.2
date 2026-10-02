Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40AF3B8948;
	Fri,  2 Oct 2026 08:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790928915; cv=pass; b=aIV1v0Lns2M8OBk19B1DP9UBcSN4qT4+sD6beqPpMU1gqzdx4cavjw841BNGDFfy+zB3q30N9AVFml7qQ36H6J8+jcJhCdVB2awBwal6qaWb2ZMMYScdiitOT0HanBSRtkTTHfAVM5xNpP6zbPJ+YBlpFAGMfr5l+F2k2/tRl2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790928915; c=relaxed/simple;
	bh=fBbRmFAYB/NxTIZ3ycFIOuPJeZJ2J3FRaVle6IV6m5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pSmZiJqk66PLu0M0qBvQr7rtQi4r/Ms1EMa/C7Sutk1SfEamPKBtRMwfAIQM5eVN7xuIUAcML1+dSrfK0tWlJGD1VQyimpt5gj9YzLwd2J1L9CTwjvjonsGp4jED5CUwqfnPd1F4QgFvC97xe6Xp9t1uryu2g8x1QhbtRZ+nVYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Fu41+yYm; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Fu41+yYm"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B3C5820040F;
	Fri, 02 Oct 2026 10:15:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790928910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PchrU+Va3DZaNKNckQ858GV5JoQCVK375UKKXHl3JXA=;
	b=Fu41+yYmyN7Ke/WzBEbIDXx4fmvdS6dGkHOLPIDZ8kCkQq5HvaFHaYbdUMx21WcVyt0b91
	Eq7i8+0FZo6o5IVj7jjwET/ZaZhoi3d/ftfySIpd/anZEIiBvHo2Pes0eXpKk2fgxbZeHl
	14E5o9OB5q1j/guZwnHfwWCfDPZun3abLW7WUzanWY44RgtEjGGdwtEfoklp0Vw6AxuzEJ
	0YTV+VDloeYXI97M6iKV8X2DkkT7ubX2SsoR7gV/6wixIdVNy533Hy+zlEFW9Eln8msQs6
	o+qAnSpYjneEvHYs65Cl586t+qn2iphjs6QxtNh6VlSjgQ1ak3rJ34l7dDT+Ww==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790928910; a=rsa-sha256;
	cv=none;
	b=a4+fs3zHCYLKy3Wl368ozgk3/Jwug+TW28OI2/hdPEXSStE/4hIJGS4X9E7YokLckR7lrI
	CN0dnNdkwDncDec/YoBq8wyNC9/PKu+a7ooL/9Yiw+fK7MuweVyY297U3Azscr4LCOmiL3
	++pyvcwThU6LCh17lfxB9LYSUsDzMZUpUo+U+5G7fat7lnG0GXOsO8yU+yhj31nMpW0BgC
	XmFKuATG/hhtO+PfY8DssuvMdEAF2JAmir1M4dMPsylFVMNevEAbkUBs+ut4P1v5EFOwCM
	htd0RHfi1ymkNSYe/5j04ToBRXHGS+Etd1lwXBXCj9BiFkLJcZMX6ajRQugagw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790928910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PchrU+Va3DZaNKNckQ858GV5JoQCVK375UKKXHl3JXA=;
	b=E6BOpPzu8tGpAj+LtjfRPmOzexSeOKqZpp7eiH4/LwgNqQ2jl9EO8sz30dgSGKozKKSBwK
	oPgP47ZoZj095F4n/CsqRUFTPnjtTHQq8EbI0FglGXYodOf6DmLLufBrqtI7XPv8zUsmG6
	Bnkzivwb3vYQq4Bu95kEPMxKKIFs6MwO2n9WBFHkuaal+0+Ex2lO2hc3GHDa6b6UfNVu82
	KK7rBnWfLJIYX85YAee9a9xpeQ/9/e7jmYJIYU9xtkJit8IMXKoo19vij5xIyuTuQviNYU
	6f0ZBqBpumo5Is8evBbGuwVRbVxz25ywrWcAnIwTYkcx3K2sit9JR0M2IQNUCA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xCYQA-003rVH-23;
	Fri, 02 Oct 2026 10:15:10 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 460FA5B8285;
	Fri, 02 Oct 2026 07:55:39 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 02 Oct 2026 09:55:08 +0200
Subject: [PATCH can-next 1/7] can: peak_usb: fix missing CAN_ERR_FLAG when
 reporting error counters
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261002-peak_usb_enhancements-v1-1-50e965755c06@pengutronix.de>
References: <20261002-peak_usb_enhancements-v1-0-50e965755c06@pengutronix.de>
In-Reply-To: <20261002-peak_usb_enhancements-v1-0-50e965755c06@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 =?utf-8?q?Stefan_G=C3=BCnther?= <stefangun@pm.me>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1235; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=yJYGMmDCA5H1YtV9p82vQMvFYiAXoP2GMFxyPs3vVf0=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjan5zGq7HGlP/lp2299ctTvidek/1e1JdRVm4bMPdR7
 NWc/2o/O0pZGMS4GGTFFFmW/jihKBDoUNr7MmESzBxWJpAhDFycAjCRj28ZGT7OudWfaPtlwhmT
 rq7Xlu2lgTrPrfo2u7y+IpntplJ77xQjw+0Jq09dqZZQtr9SbppSuFmkvNzu76N9hxSiGe7Lvus
 S5wcA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

From: Stefan Günther <stefangun@pm.me>

When the device reports error counters, the driver incorrectly uses an
assignment (=) instead of a bitwise OR (|=) for CAN_ERR_CNT. This wipes
out the CAN_ERR_FLAG and CAN_ERR_CRTL flags, causing the error frame to
be sent to userspace as a regular CAN frame with ID 0x200.

Fix this by using a bitwise OR to preserve the flags.

Signed-off-by: Stefan Günther <stefangun@pm.me>
Cc: stable@vger.kernel.org
Fixes: 3e5c291c7942 ("can: add CAN_ERR_CNT flag to notify availability of error counter")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 8fd058c32856..785224e00c4e 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -526,7 +526,7 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
 			/* Supply TX/RX error counters in case of
 			 * controller error.
 			 */
-			cf->can_id = CAN_ERR_CNT;
+			cf->can_id |= CAN_ERR_CNT;
 			cf->data[6] = mc->pdev->bec.txerr;
 			cf->data[7] = mc->pdev->bec.rxerr;
 		}

-- 
2.53.0

