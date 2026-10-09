Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E404E2F2B;
	Fri,  9 Oct 2026 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553420; cv=pass; b=Zujh0uz5326/ebDuasiHXFAsqLHMQ51VHcEPSZ4zSfO+G6wDMhLUsLZblnqXrFw4jgLNKiP/vjUp/n/QD5qxiX9Jjm20aZ1i6s3pjkMOnHGNC5JgF+ZUOADhCNtb5cKlrVRodiJsI/pqWGtAaPB2c9JuCOarj2QYnqFN84JpOsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553420; c=relaxed/simple;
	bh=lN+w9Hb50Sosh/5aDDQ9VPpOvAOfZv4llV6ijMEIaow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rHakiOg0OVm0sHzeLEhzqhCDs488YtdJrTUGNbB2hyRnkxy4lX8fZi2jz8yIYe+qBT32CRQwRc+67pVdIAPTw4YNcp4qsRpMIm/WF2Lrf9es/CRMzG8RmRqm+W+8m1srMc1e0Lvz/LXETTf2BvR5jk0luYxreenyNMdgcW3cSNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=ZfeU5uHz; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="ZfeU5uHz"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 70822202615;
	Fri, 09 Oct 2026 15:43:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VDV5MA7YZtqhfRoQgg1SF3NmmVl5fJKMmfmIpU00WlM=;
	b=ZfeU5uHzIgJbRCNeOaI9WW0yi/qrabGbmUvdO9i773IPRplqw2Cnkbja3MEEOy7Jksb6iE
	ztBoths77rr5D8EYv0ZXh1tOa43TfWgdZp67Bk1V//WIAQHdEdO2sQWJW5NfkJrFlpQ0+n
	Dc1R1rQ4ip111qmJXrmY1e3OBbzTr/mRY14LX3fIOJ1/skE1591N2nkJrFDqCqlPCSACLE
	dJqZCf4el517dJI9DoshGDo0b1c5GdXjsq4kftg9GXD2J1Xim5grjA7Y5O30dfZzIdLP2I
	CLMfPFtFTb6JGxkzlevvh47cgNCHkWACsNnBE3XdgBgcU0Z7AN/YtdaaKsi9nQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791553413; a=rsa-sha256;
	cv=none;
	b=WI2tcY+AilgYz84DzKsuSz+UjfjymQmWO8KTLg6HbFiYwHHhhLAz9Okl5tkmP2LVRG34f8
	4hgEZ7H1rDTaO+1FoYpkMD9IaGhGSq+lJbZWq5pgXqkhFUPQUASUXcG2d14pRXPA7dDq6T
	++6IOitkLbtmatZogVSMdh4RD836ttpwV76N4CSM7j9AhheZcTLpvpWTkjdNo5OIISE+i/
	EtmPgze9WuLC9z4IEJiCmXKpl/En1SrKIBKGDrv96v3vmgmhRCxcP1XLaDqtPkzBN8MIjq
	/QHKLvGLoYj587kyq0f6WaQfUEdGo/2zuL69H45RFh6jNjqOEtI+JfhS8luA5Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VDV5MA7YZtqhfRoQgg1SF3NmmVl5fJKMmfmIpU00WlM=;
	b=WX9riP054uvYErIke5/AX5DqirEy3doXmjihROziMpCaaS/5+GjTXuLmMxMSJiKp81HolH
	3n8kiqje0leDX7aL7g+upk+ieIqz01H5XAV4i2eCqF8gPvZUTl1gzf19FHEPwZIIHq8DYn
	2/Id6U0dUNFLoCj8cWG/Eb4uTSoOEzVmnBIJW2thZQzAH7ZczpgVI9BTOCLmZw7rvyRwX7
	P7sO1IkNuzn/qQ28ZLyJ+99178PhVySukMghcUKANUJqCd+Zh9YxQJP8NBN4bGXOJ2UNbo
	t5QpiqE3uPdUGqwRAtMK6RKruvIQNeIcNrM6XTPt6rg8Yny9Im5QhAZ/Qd6AXA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xFAsn-0053Rw-16;
	Fri, 09 Oct 2026 15:43:33 +0200
Received: from blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E3B905BD8A5;
	Fri, 09 Oct 2026 13:43:32 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Kaixuan Li <kaixuanli0131@gmail.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Quchaosheng <quchaosheng000406@163.com>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 07/37] can: isotp: check the frame type, not just the length
Date: Fri,  9 Oct 2026 15:27:39 +0200
Message-ID: <20261009134323.64064-8-mkl@pengutronix.de>
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

From: Kaixuan Li <kaixuanli0131@gmail.com>

isotp_rcv() separates Classic CAN from CAN FD by skb->len alone:

	if (skb->len != so->ll.mtu)
		return;

	cf = (struct canfd_frame *)skb->data;

A CAN XL frame with cxl->len 4 is CAN_MTU bytes, so it passes, and is then
read as a canfd_frame whose len comes out of canxl_frame.flags: at least
0x80.

Of the paths that follow, only the flow control one uses that length
without bounding it first, so check_pad() walks to 255 over a 16-byte
frame and the caller reports EBADMSG on an unrelated socket.

bcm_rx_handler(), j1939_can_recv(), can_can_gw_rcv() and raw_rcv() check
the frame type here, and can_dropped_invalid_skb() switches on
skb->protocol on the transmit side. isotp_rcv() is the gap.

Fixes: fb08cba12b52 ("can: canxl: update CAN infrastructure for CAN XL frames")
Signed-off-by: Kaixuan Li <kaixuanli0131@gmail.com>
Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Reviewed-by: Quchaosheng <quchaosheng000406@163.com>
Link: https://patch.msgid.link/20260920035626.2581040-1-kaixuanli0131@gmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/isotp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 1a272ce6a2bd..5e1c3971ebfc 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -756,6 +756,14 @@ static void isotp_rcv(struct sk_buff *skb, void *data)
 	if (skb->len != so->ll.mtu)
 		return;
 
+	/* check for correct CAN CC/FD frame content */
+	if (so->ll.mtu == CAN_MTU) {
+		if (!can_is_can_skb(skb))
+			return;
+	} else if (!can_is_canfd_skb(skb)) {
+		return;
+	}
+
 	cf = (struct canfd_frame *)skb->data;
 
 	/* if enabled: check reception of my configured extended address */
-- 
2.53.0

