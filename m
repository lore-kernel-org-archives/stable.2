Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794953405;
	b=ClDkQUgEB2Kb0MR8234n5xOIPkOUXOo/XkxUbZZzVe56Tc7DNY+qqOZ1jqCNy6VT1Pwm
	 sdixOqgDffFtDvUw8A6DZU4QmSogEkBhEM6R20BJGd8aqmlgTev3+a2G50uHqWJGGbOVS
	 tDDeK4ccZ2P76VB86rgcU8SeaPraX/POwfsTOEHxOmyuCo7myhevt18JZTOywiRVh6B2O
	 VdL6g0a74GurfJ+qtJSRuckChwJhWnCUiVSwrBFwixeQTJXZ3zAF9J1RjWFPTcbDelnR9
	 u1W3fUeSktQQ3ezYxXGKUAwHmvyZnuLnOPey5Y9BrvdKYrRzUwtBYYH2qyur0IpoOSA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794953405;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=C49EECvLZwCl7V5GCqD8qYPZ7qMVtfKZ1xxHXpyazrQ=;
	b=QOEYVS7Tb68jFirycywSfsB6Ii06uAE43Pjt0ty1T7p9CcGeaBcE2OtlMH1OSESX7mjC
	 u53pgYsXRTJrzlCfJWYkYplvmPMh+9bfHqvsXIYiocY/mVbW/dwHXulAbdfDcCZ5pMCdR
	 V0pErQKJiSarvglz2RjI0o8u3So1mjz9QKqHtY7w3zLDyldZpn97BKDCRm/MhlpOeIXB0
	 R+XPr9luxVLGKTWz+gXDHtRo8vwQLrDc89H0sY3V1+7ToRtE54D2djHmjuG+q1WIpja9g
	 oJ3EE6yUdDAn3xM+go0yqPstMBWxz1WpYBICyyaq6CCgCzq9SC+yI8qgtGdB7awXaeQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=SEb0wpe4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E113606A32A;
	Tue, 17 Nov 2026 22:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E113606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=SEb0wpe4
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 8D74D201CD2;
	Tue, 17 Nov 2026 23:09:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794953399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C49EECvLZwCl7V5GCqD8qYPZ7qMVtfKZ1xxHXpyazrQ=;
	b=SEb0wpe4cHsk23NIReeglA/IpUXuC5I7Dw8XsJmkBQ/LiRD2hldiWn4LVkKhTIUKX38vN+
	YiqAGkk2NNMRXS1SFuphHY30TMW/Gj2/SvD8SKmr9I0mMqWfagXo3XnancqByNg0cNaOkh
	032haslUZdf/H6hVC7Z9LkTb7rokVidA5Pc/3c2sTQ5P1Wlc/iyoe5WJ5X8DP3K+kNFPPJ
	D0hF2QNT5yM3YMpQLyJxDfJ6fL3K4dx7Zo3ymE3LcZ9BgtsBQ1bf1F5dk72MQelx/bseyR
	ldgrsiIECbyTOCCCuuVu4zSf8ejMYFMqJ8dAWR7HaGeN4TiaGU9Ojyn1B/+5MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794953399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C49EECvLZwCl7V5GCqD8qYPZ7qMVtfKZ1xxHXpyazrQ=;
	b=Nbse151aUI11aqcJy5/MRS6EqqN4HtgIk2kprYNoS5E7+pp5yOS1oyNlMzkvB54nyHSMO9
	MqCp5BMGpJg+ge0CmlEioLQv4A9vNd/T9ouI2NMhGhoZrahLm7Pxur1dtgcKhka+2Xo7CW
	h7vhCRUYzxEa0iLVMVEJCd+REWCVwtboW4BrD5PE553xgOT+wCbdQ0aw2Oe6P43sWasdgN
	XOaB05KEhpCt3mwDLAQjMh6vc1QCWVQ2K66Bv50jhGsjgt2yYvSY9vcCQoahQ6GOV5SD4g
	I9eur1DCcRUrO7nD+MYOBb5jOZU2XD9+RaW2X8bqs3IBPywJv741L+/CvnKtPA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794953399; a=rsa-sha256;
	cv=none;
	b=Mn0qdzG5sJvmIXoy7biFbUyihSAyEdABzlPvg/PrbbEB9tMjTk87nyhwBWmMBwgEHjglAv
	st+CyzgkRSFIfk0Xp44CCpX535aoU4Cwsrc1bmKZt2LUPkNgyKgv0nKQu2oFZ/1vtyKFhu
	QzTS22Kqb22+iHIVqEt8ZDxKKQp7LayRYtN6bZkyiDOw4T3y/Ri6rKPcyivRyt+e0DaJXw
	cQx9Prwek5jl0FvKtoLgVc28qBfosp2pVgxxTchMwxolkl8ylVFA8w6tbxhG2gQdc8SRFF
	ch8rTwaVIA5n5Oe4Eywk65SonqhFYRpoG3p4NacGHYaxjmzra1XZ1WsiQo9o/Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xTRNG-000Fmv-37;
	Tue, 17 Nov 2026 23:09:59 +0100
Received: from blackshift.org (unknown [192.145.8.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D10D25EDA2B;
	Tue, 17 Nov 2026 22:09:06 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Zhu Ling <zhuling0805@qq.com>,
	stable@vger.kernel.org,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH net 08/11] can: netlink: fix static FD-NON-ISO mode validation
Date: Tue, 17 Nov 2026 23:03:13 +0100
Message-ID: <20261117220818.1142581-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117220818.1142581-1-mkl@pengutronix.de>
References: <20261117220818.1142581-1-mkl@pengutronix.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhu Ling <zhuling0805@qq.com>

Controllers with a static CAN_CTRLMODE_FD_NON_ISO mode (M_CAN v3.0.x and
v3.1.x, PEAK pcan_usb_fd with firmware < 2.x) do not require the
'fd-non-iso' option to be provided when CAN FD is not switched on by the
IFLA_CAN_CTRLMODE request.

Since commit 6742ca18cb41 ("can: netlink: add userland error messages")
ctrlstatic_missing is calculated before this exception is applied to
ctrlstatic, which is not evaluated afterwards. As a result every
IFLA_CAN_CTRLMODE request on such controllers that does not contain
'fd-non-iso on' is rejected with -EOPNOTSUPP and "missing required
FD-NON-ISO static control mode", e.g. 'fd off', 'loopback on' or
'one-shot on', regardless of the current CAN FD state.

Apply the exception to ctrlstatic_missing instead.

The exception must only relax the requirement to *provide* the static
FD-NON-ISO mode. It must not allow to *switch off* a static mode: before
the above mentioned commit a request like 'fd-non-iso off' passed the
check and removed the static CAN_CTRLMODE_FD_NON_ISO bit from
priv->ctrlmode. As can_get_static_ctrlmode() derives the static modes
from priv->ctrlmode, this information was lost permanently. Therefore
reject any request that explicitly switches off a static control mode
with a dedicated error message. With this check in place a static mode
can never be cleared by the 'priv->ctrlmode &= ~cm->mask' operation as
every static bit in cm->mask is also set in maskedflags.

The request is rejected independent of the resulting CAN FD state, as
accepting it while CAN FD is switched off would remove the static mode
from priv->ctrlmode as well.

[Hartkopp: reject switching off static control modes instead of restoring
 them, extend the commit message (Sashiko review)]

Fixes: 6742ca18cb41 ("can: netlink: add userland error messages")
Cc: stable@vger.kernel.org
Signed-off-by: Zhu Ling <zhuling0805@qq.com>
Link: https://lore.kernel.org/all/tencent_3A964832542399A780E646D6A6246335C409@qq.com/
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261115095746.709371-1-mkl%40pengutronix.de
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20261117-can-bcmlock-memcg-v6-8-6826a6227d36@hartkopp.net
Cc: Vincent Mailhol <mailhol@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: linux-can@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/netlink.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 081dfddda000..521e2496e2cc 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -330,9 +330,17 @@ static int can_ctrlmode_changelink(struct net_device *dev,
 		return -EOPNOTSUPP;
 	}
 
+	/* static control modes can not be switched off */
+	if (deactivated & ctrlstatic) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "static control mode %s can not be switched off",
+				   can_get_ctrlmode_str(deactivated & ctrlstatic));
+		return -EOPNOTSUPP;
+	}
+
 	/* do not check for static fd-non-iso if 'fd' is disabled */
 	if (!(maskedflags & CAN_CTRLMODE_FD))
-		ctrlstatic &= ~CAN_CTRLMODE_FD_NON_ISO;
+		ctrlstatic_missing &= ~CAN_CTRLMODE_FD_NON_ISO;
 
 	if (ctrlstatic_missing) {
 		NL_SET_ERR_MSG_FMT(extack,
-- 
2.53.0

