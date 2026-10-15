Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970F13876CC;
	Thu, 15 Oct 2026 01:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029234; cv=pass; b=JeOBgqDGkTNvD7r+99bCRh3PTv/JwRf0ao48z/BJ0zkmy5l2Y6Zeyff2acsFx5pHPA1aUDwd5BoZNIer1yJqZe8Ximgky8c/LHzZTPeTTJm34wArFsIqmTlGr/ImdtaPbw3fuujZGq9c/oWL4etAPvz1Bo54PRYF2p3QeHk8o+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029234; c=relaxed/simple;
	bh=B6MsowS/Hu8WaIsqrN0ZInLPr90Ep+8EERok4+wLTWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mqwGUPXeDFXZ6iNPllXnPuBMX1xNd6MDFlwuYHHiF6m0drLyy5OnxqTSG/DO71CWpGzJDe9TjNi9iOW/uwa9+2OzvP5IvwFWJ4hx4DxcncHwkzUur+OVSXlJqxTCMiFshKo9ZfXKuCuh2TO2pbincq3c9Gerte3mYkfAbZRxPCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=fXmVTl1S; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="fXmVTl1S"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 36A3C2027E1;
	Thu, 15 Oct 2026 03:53:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XVfaiHfN1z0sLsRST89F+gSzK1DVg/e0PZJQCFq2CAk=;
	b=fXmVTl1SLGZArqKqvbjIstcJsLvHAlnkpd+imp0/mvIYIzS/Upg2rW2TF7YNtj9wt4UdvL
	Qy9K6Eqa9F6Hzdba0iOR9Ap7vNTQNMh9kWuCuRd+9/SZo3SQXZ6YNNYA/yXJdVMJaJKvAj
	cQ56TcKFZqLhzOkrzavb8E55OLqsfNCQ/t5IX4JtEQhIXLiRsIdZM3zqmZ61+bmy71m1wL
	huTitu5wu1COMLqNihD6xlpf+VmQhBVjU2P6oN8617SqWwa1wWBJYhxsDUpL8baRqGIe4q
	9GBJ+9OLl1z2+z98qVuvBm143/eAJphCTxSydK1AEQxkF/70gf9A4MK6Hf4Lhg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792029222; a=rsa-sha256;
	cv=none;
	b=DgBVKkB9QirQPH29fnPnpHyGyWrYFPd3TNtR4hjCCkmVdZgBwQ2Q56mMrfrCq75mBXwcbk
	B/tZB52UHYw6w2vIJ9uil0uhcASSr0dEAJVbk3tjDvk6Su180HFKNdlAqU9FsJa5rceFPc
	NewM3wHzZYm5vG1SqbDvn7B5hKzCJPSBBlDtUJ4aAdJcrrRNgBsk4qxKCXBl7kuuM0n9Cd
	mx8/KkDM1NQhOnZWdsm06Ds3WkrPjIbtg/jNW94ZvC21StjigUgFjMUicfy+IGr78euBw9
	lHB+2UGg62UixUyXoFXMQ6e0hTaw93YYfDljstTh0q+aKhq1EaltcBxGwEfruw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XVfaiHfN1z0sLsRST89F+gSzK1DVg/e0PZJQCFq2CAk=;
	b=eCNUMg0durMaqKyyZX9RoRahVxHZ1GvkD3NsVVjNDlOsiuJbUHCGzU7ilB8kXU/7E1LAaY
	anQ1Eeq4pGkYOmk21jVfRgJdxDSRJc90ZzO9WOGnUuwIsTDJYkAt6Htua/0b8KHBEML/0t
	sKuLOFg67t2q50x1AU7OKHQ6QwqBbX6rT3z3zfhwpHQv+0u8GWW/XYoDq1uMpgE9eb/Xns
	J3pTbXAFPTEDB6FgJXbdtdnHAnOEqWude7CH2rxul2SSUbHiWoiYR7UqgY8RwtdOGsc2O2
	h/iqYFS9Tc3odNnOUkLxt9jTLD6QDsZXrqpWUWCkKBYr8i2vvtETFAxiKakcTQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHAf8-005wrV-0O;
	Thu, 15 Oct 2026 03:53:42 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A01595C47A1;
	Thu, 15 Oct 2026 01:53:41 +0000 (UTC)
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
Subject: [PATCH net-next 28/37] can: ems_usb: use usb_kill_urb() to stop the intr URB
Date: Thu, 15 Oct 2026 03:40:26 +0200
Message-ID: <20261015015336.816543-29-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015015336.816543-1-mkl@pengutronix.de>
References: <20261015015336.816543-1-mkl@pengutronix.de>
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

