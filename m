Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4622137882A;
	Thu, 15 Oct 2026 01:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029227; cv=pass; b=EQAX/LQq1ZSAdlXDF5dGfKI+8rA31sCfov50f2TtXJGmviD/qvg4b9m+VuJkrNwbKXHb6fRZowz3raaPl3rG1P2524yWZ2nW+3LCjkvjq4y8ag0u8vXXpA9+tWXsmYIixT7OGpbX7GE4m8gi8mp/BHtc5ctkC8Nwe2iqmdoqFYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029227; c=relaxed/simple;
	bh=lN+w9Hb50Sosh/5aDDQ9VPpOvAOfZv4llV6ijMEIaow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q3+Wv06M3UYyGkRbjpFEmCQheFXeAN5ZdDDDZL2EnStoL6Rx3SxYUAZ6w7CqGuPqJmPeS4h1HeAu/3BZ0cMnM0AAnWbqY4JSf6lpHxeZ9tPioBGPDGrIwk2c0dxZOl2AzU0LDlCYqqsMESTKto4Co2mRRNkAJYdKDYvhhiFbcMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=JOmjlDHO; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="JOmjlDHO"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 00216202381;
	Thu, 15 Oct 2026 03:53:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VDV5MA7YZtqhfRoQgg1SF3NmmVl5fJKMmfmIpU00WlM=;
	b=JOmjlDHO6gcd8rlelKe+VBzJvnMCPPITrGmDU66oQULRu5li4glSUriiwb5QZWafZj4/lT
	ThAFPsMqkg5bvBH24fpRH2MdA+CNciKG5KYZTToTlkFV+tDudI5yCLD3qRtFVDw6T9EA8K
	hUmHP0ROGGY/vA9MhtvSremVUBDBPgYQjGDBmNYZA/PA5Q7BlYgYPVw5z7cYPhoHSMi4n6
	fZKCLbQnwp3wXFKJfgMhXmSByN4uH5RndlhklIah316FcH/X+P/tjr7spSR/sW/Obi2gOW
	YcVmp6pNGZU+AowGzGrTO0tIZNxu0U4imx1vyj3EewzDxOrR3atkWaiNf/AqRg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792029220; a=rsa-sha256;
	cv=none;
	b=EEIf+4sXqgsUuC1zahqhmholjd2o23xxoLN+78o5uPJZq5ZhXj9DUINHoD5wjH6UwnZRru
	IxXAvZ+t1AoUKqW4OHisobgHJCnKV+UgG7Mvm9So58I0W5E5aJg8E8TsbzRCWQI0lHAiGT
	QxzVAG3qozX0nwFx29dLH6Q0OPAAv3uvz5MAdxTYhxLMGMesTaH4OEO3txBdxbHjAKfweR
	VbPV9p0V/RrwUcZM6va6eIrG/YJOmDdBbYJ7MtDLPjnvkDR8PNR6BWJmUKczxwuy7/JmDB
	b3UP6FgTZ0PrIvRCsXSeQdWIGhHfmnecwLfZbHmQibdFt/0IhFK8Br1ceSweyQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VDV5MA7YZtqhfRoQgg1SF3NmmVl5fJKMmfmIpU00WlM=;
	b=NNFilGi3ds70ukwEaiwPyhkwEzN1dgfvuNH+HxmdoOM6u9lVIbZBtdBJfNH37cBYz/Dhhb
	prxiy3wKJ6kAWbBxi/EZL77NqEcoC39a2XAvq2DSHVuhJLXyuFaH8ah5mBBjZ8WUrB1k9p
	zf5z0lHX4SXV/sU1rxwcL1GALYzwjalRGdDIytGshNHJx3KDzJ8ClU+Iw4sBZy/w/VZlqf
	vuEvrq3wI4knQEz+M5DvUYDKFSX7JIiP9s9Bb9TJjS6EMCxDq5vpei+Bcg9TB/w+0JCE/o
	NUGbqL+Gjgx1Ke8wUkXSo6Qjd8aPI9MIIhOGVHN1+mxLIp2HNVrejOXBSpGdVA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHAf5-005wpu-2s;
	Thu, 15 Oct 2026 03:53:39 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 990625C4779;
	Thu, 15 Oct 2026 01:53:39 +0000 (UTC)
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
Subject: [PATCH net-next 06/37] can: isotp: check the frame type, not just the length
Date: Thu, 15 Oct 2026 03:40:04 +0200
Message-ID: <20261015015336.816543-7-mkl@pengutronix.de>
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

