Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841F750279B;
	Mon, 28 Sep 2026 19:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624013; cv=pass; b=ukKjpXlFMxW09DHKSzJHr6dyW9TVYiK891PvUqb9yOsNrdvmcAjbLemNImOq6OZ01TShBlkf0bbUqFQu57RJel7BuMhm+0Pg+QPXhol8M3h2cdt+lWbF0SuYTCXRl6O4PYxp6KnUACmM9d86SBKS0uq6Qy8dBMzuCcQvyWLDTng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624013; c=relaxed/simple;
	bh=B6MsowS/Hu8WaIsqrN0ZInLPr90Ep+8EERok4+wLTWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d0YAVmOHOcNwNgTXIJDsqyNBV0J0AnGxH7rncySIoXs7IkwFpR5KWtIXvvUTq04MRuscOAPv3LWl4cIu72LziTzMUbRrOkpsYbI33j4M3Bsj19Vs6RohzXQMH7tK7GOuBcl37+P0qiCYNWmhGHA6xLjnIkhBfJpTq6uf6w/Fsso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=DIMuGU82; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="DIMuGU82"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A9D842022C5;
	Mon, 28 Sep 2026 21:33:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XVfaiHfN1z0sLsRST89F+gSzK1DVg/e0PZJQCFq2CAk=;
	b=DIMuGU82qsqkaeIt9WFJGli1KsTQSoaZLiVZRibGcQHhqz7nyfPHYDnydrLs0VYplVjmv3
	1lHTxufTxhnHgePy7HzV3/SFdNGSramWnwswg/Yu+3RpL/4JCytt+ufIKhGtbnGDzwxMv+
	phUZ2WS4tOAri5NkMWw+/Sc2294AENmV0BqHfFTHKwwSkDJJdAwFPrXqgJBiM8Y1xsEUBt
	C/YA6/c4UEWk+RebcwHzsv8Lqueh6H5X9rrJtdzKEB9ICCCtnzhhsw0RTpElkG0WHHEiRs
	+lTpljsXutr61Y20vtD4a2xTEJh97U1NjQt9HIgi2wR+PYn/Z5/+AtnEo1x9OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XVfaiHfN1z0sLsRST89F+gSzK1DVg/e0PZJQCFq2CAk=;
	b=QdrO0t8APkEI4YXVFcRCoksf+JQG808H0HFFbM5TmWhcBe3kxn04X5CtGD3bUipiuxlJzf
	VAkf+IVBRcpysVN98lHgF9PrjTXCLYY+KUU14+iMMESGdVDnkcwFqTOihv17/D1x7czWUo
	DmXj7JV3EHtMCSYtO9Fe8lqGmcIjRifuHOnVNegl4SgHin5yKGHhgm4drv4fnowfpS0gIg
	2u1fViBuTys5/i6E0t37AKJNNX1QahFwnOlWuVoZwRcg7FgDv+fGnHxltal7nvwHQSQnr1
	59hvFbewnNR9TODvRqxuyaeOhXWi9Fi46UsH9d0xmW9AGE3QnSpCY/B01EcpRQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790623996; a=rsa-sha256;
	cv=none;
	b=HNRsQGfNk84t/kjeGkCkaBpm7cJ5UQ83e20MRNUW9IXW2Mygr2Fx6pxLNMR6rde9W513ff
	z9CPYiHwrHWNmo7IwX5DYDBO4p9FQxPSSeFM4QiaNRTSXmBaAaA3xJCNVsfoXDkNLbqZuy
	8FvfYe1jZqO4Fmsa6GoFnc7o9Mu/jnfLh0QBuAev300PpHTYMgvMjr559qoml0DU1KAOKK
	rR5PFqW9n9kJJz/p0mR0m/KHOm69JFbDRkBQJCpTd3dfRckCNAR1NqGCGb8ascI0lUumCW
	IY5LAug/dq21HyNNMwtWcDH+wUU65nec1ik5ZkvSwTRE7ZDZ/K/lBGtMfFe4Bw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBH6C-003H6X-1d;
	Mon, 28 Sep 2026 21:33:16 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 352C15B1558;
	Mon, 28 Sep 2026 19:33:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Fan Wu <fanwu01@zju.edu.cn>,
	stable@vger.kernel.org,
	Song Li <songl@zju.edu.cn>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 17/22] can: ems_usb: use usb_kill_urb() to stop the intr URB
Date: Mon, 28 Sep 2026 20:45:24 +0200
Message-ID: <20260928193312.553632-18-mkl@pengutronix.de>
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

From: Fan Wu <fanwu01@zju.edu.cn>

The intr URB submitted in ems_usb_start() is not anchored, and its
completion handler ems_usb_read_interrupt_callback() resubmits it, so
it stays in flight as long as the interface is up. But unlink_all_urbs()
stops this URB with usb_unlink_urb(), which only initiates an
asynchronous unlink and returns without waiting for the handler.

The handler can therefore still be running while ems_usb_disconnect()
frees its data: it reads the transfer buffer dev->intr_in_buffer, which
is kfree()d there, and dereferences the private context, which is
released via free_candev() together with the network device.

Fix this by stopping the intr URB with usb_kill_urb(), which waits
until the handler has returned, so the frees in ems_usb_disconnect()
happen strictly after the last callback.

The handler treats the -ENOENT completion of a killed URB as terminal and
does not take RTNL or any sleeping lock, so the resubmit loop is cut and
no RTNL deadlock occurs.

This issue was found by an in-house static analysis tool.

Fixes: 702171adeed3 ("ems_usb: Added support for EMS CPC-USB/ARM7 CAN/USB interface")
Cc: stable@vger.kernel.org
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Link: https://patch.msgid.link/20260923030522.409344-1-fanwu01@zju.edu.cn
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/ems_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index 24cf8f651f8f..2d31f0b86859 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -748,7 +748,7 @@ static void unlink_all_urbs(struct ems_usb *dev)
 {
 	int i;
 
-	usb_unlink_urb(dev->intr_urb);
+	usb_kill_urb(dev->intr_urb);
 
 	usb_kill_anchored_urbs(&dev->rx_submitted);
 
-- 
2.53.0

