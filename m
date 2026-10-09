Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E994E432C;
	Fri,  9 Oct 2026 13:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553425; cv=pass; b=WiTlXzV+qfY6OODZnWj4UjCDfkJdScz6Mh+hEGrwZPJJsgx1ZNtS0Zde9M3u+rhZgZMl6tMEO438wnqikGTK4AIzd/JnNeYHIIfrswCGb/izRnjGNTNcDpCebP4DUhAoC3KG35s3bEltXR0Np5gsQTSaPOlEX0hVGZNakGmTDbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553425; c=relaxed/simple;
	bh=B6MsowS/Hu8WaIsqrN0ZInLPr90Ep+8EERok4+wLTWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UPaTmize1RNUCDprwKeG5A2gAWxsp/2zCdJg4kQK4zfsf1oNbnS4LaZvHnSKogD3x8IWpI20j0Q7JcCDnzSEIeQ/X8FYLU/hfDp6yU/qVdKw0My1L0SM59WEh/AEnwjtP9qlOC17zPD1dKqzU7J7su69q1C4S0MeYuJ/8SNQVvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=feYUPtKd; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="feYUPtKd"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 00427202667;
	Fri, 09 Oct 2026 15:43:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XVfaiHfN1z0sLsRST89F+gSzK1DVg/e0PZJQCFq2CAk=;
	b=feYUPtKdOdEZX1l65pkYHdwN91TXBXypHKZQB2BEzR1J0rZI5lNUgmKcM1q1nhq5lmwbuS
	fl8y4ilDu20YA2lUoMlnWPUfVPZfBYjh4jxxVHstXL54cr3Cyq2v/j6JHX7Ij51f2sb3Fp
	cWSyP3rGs33BhaHa1N57y6vDW1sxhUPfCUXZE7STwUpn1lWJsjxql23AUIE1Z1HmrcLX2r
	Sx6Vux2uY1QMEUW2bU0nGgTzB8GWdWybXx58Oc4R/Ykklb+WCWFtqQ5cOIlZz7iVqbvmpo
	zz1ijPIJTwkcPaSw7jYjhU/E+IL9hxOhAjv2M9iHndQdBjJx0JRYSjdU6R14EQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791553419; a=rsa-sha256;
	cv=none;
	b=JRvy5F0aplkR9W6OiDrsYh5Ve4oKVOc26JjpCaQKy++XqGobEWXlHC+7u3ROGvlDYEMvkj
	+s5hmum8iXIGDDaaPQX6l9wNIQ7hks3jm/zXF8Ov5WX/U1y9ID7JevTb56KC3DDzanWa1/
	bhziMCUfXaDKAM5kwTEQZHbW4to5MJ10xKpUXOzFZhY8zNaZrFhy+jH03Eb6cgoO5rmOHY
	h8VYUnx0lgxvojw+cuolkWPbkB3Kmnjn5H6c5mQdMdc0tMjStgDL+KizIqksVJz/goDgrX
	RA99ApI6tWAkRFCR7YPsCUZHTcPfS1eJt8KgvmdvnoK9+bCKvbThTjmGN1IoBQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XVfaiHfN1z0sLsRST89F+gSzK1DVg/e0PZJQCFq2CAk=;
	b=cR0kJ+QRTWDgwf6XA0mAwu0VQRzyZI1li5KEUSX3JEWZCGccvPgiremjjqqlq2UmDZTv7c
	GA7RQld+YDSKhGZY4y2whDMPihwQ6nY2+UpeUK4o10hoA7eBuCoCfnxd2aar7tEqszDeA0
	RHO2EiMmqKAIDHG8JfBvuGp6kNZ385QjSf7CmRkDalKyHpi1nqtvsgnhBSFnaqXth7sHW/
	YeM8rmyYrUtxwbmmox+JuMapXzwnkRYY/p/rhT/3LfUPjLE8Lhq+8vmdCmLaELljiPWHfF
	BQ2zQ+NiJ9jlAMAOUvdVIMYcjtOAqluH7gkD+Cx5Z/rm8WQC3yyAGOyjt3ueQA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xFAss-0053TA-2u;
	Fri, 09 Oct 2026 15:43:38 +0200
Received: from blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 772235BD8D5;
	Fri, 09 Oct 2026 13:43:38 +0000 (UTC)
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
Subject: [PATCH net-next 26/37] can: ems_usb: use usb_kill_urb() to stop the intr URB
Date: Fri,  9 Oct 2026 15:27:58 +0200
Message-ID: <20261009134323.64064-27-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009134323.64064-1-mkl@pengutronix.de>
References: <20261009134323.64064-1-mkl@pengutronix.de>
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

