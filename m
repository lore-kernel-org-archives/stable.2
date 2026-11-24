Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795510690;
	b=FmdGUuWUXlgiZdKRO1jhehjHLCk5vk2EokK/kA/Pt9OuX7/x6tAPkVzHhANinq3isfiS
	 E4Ag7hCJ6f/vSzi8B5cTpoZnAjH7jcXFbbwvDEHUnyemWYd+Izv9onmTaDzTYQJ0ofrc0
	 +MWAQHbTng3gfphxyF4m9fUCJr0F57m1GtIVVZFF4YOoPmuTfT+eqAAiJ5gJDXmDU2jz9
	 Fk7v/0Qvvzh82JDSCWORASL9SBqJQOEROSwgdUvM+09xa8p3C0hRRVzn3sHkgK8VgftVT
	 lkRU710vU58z9Dr0gRzP//P5mIeb+dk9Bsm8TwLgxGQdsk5kHz/2WcpNM3+ASNgp8cA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795510690;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eHTCv6HQRiUw26+HCYaGvaVvXgKEk1d9i0EJSX4z98k=;
	b=3vjDpVjuyxOchvgWwZKV9ymOiACg7KjxSxAXNXoo9BLUIahsvblHDrMERGm1uf+0KQg0
	 T0PQE12PDieaGwjgdJNmI0e4vVK5X8jwasW7TBLNGPWuxydngy13PBkgWmnodrJVuEbr/
	 +qwYEfdI4mhO9zbu4Ne1UkIQDB1YhcOB3ZhQm1DmHM2/EAyCK8xWRege7+wCV0E0hck+g
	 SqCRueWeNF4uzzXEidrVgf0jR23q8ylnsayRxT1ywBTlXdeq9fXd+kAqcLxRkgrIZ+vB8
	 RKrLJsDBnDerzrJUfj4IojuDxuptLIHab/VkI0BdA7eEIsr95yL3kCSw8Pa/QGINcBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=G31urPFj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8211606A687;
	Tue, 24 Nov 2026 08:58:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8211606A687
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=G31urPFj
Received: from pengutronix.de (p20030102af17cb00d2e697ee776c6466.dip0.t-ipconnect.de [IPv6:2003:102:af17:cb00:d2e6:97ee:776c:6466])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D7D7E205A26;
	Tue, 24 Nov 2026 09:58:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795510687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eHTCv6HQRiUw26+HCYaGvaVvXgKEk1d9i0EJSX4z98k=;
	b=G31urPFjXMW4DDGkPtyN3bKJ1b6S5w7WF1+j2KvrQ2pLVyC57gT++4TzPl8D3OdiB2wx8X
	C5UvKLkPzS1GqG1LChpEFaUPuRslHWk9vXjRiIi6lF9qZ9p0mPBPVIks0WpiFUYEjI6PSX
	ocbZRCPjyV+QfEfCKIHeLrXsrBqDSWIz6clXKZsWVt3lXO894VzrtM4SKqrexMAlGMSbgz
	vlzdOi0gvnzvHFTRwR2LHwn+k4AJL+BvbeihgyXf9edVTBQrNC6PZtZYBkLHuVfe4nlDPC
	sSBxA3FyhzuP8FxxdHsu29qqFv63a8jX0H4IUtDNIzuyzwPkRHI+KJmyr/ZXKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795510687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eHTCv6HQRiUw26+HCYaGvaVvXgKEk1d9i0EJSX4z98k=;
	b=M1wbOrVY0KYXKHY8vSZa6XMJasMKBCogPgdmxfRqyhn4d1ulthRxsNNCB2zPqcrAas9kaH
	lcA1dEjBLwTwsT+dkNPNDBaX0Uoe10swHOzRoaclyfrGLci+4v9qHVuWkG5G85gKcjVa5X
	Kp+hS88+UVZke0kG/IfraXZNpYhJbzt0YK4pNBGYzNblFjvlLGuLVMtYM7qSOMvrgUH9gq
	fC+lvdsJyRFdK+Qk0DSO6G1dWDkge5nJK88706AEOwL9h5TNlrGddAedjlOqMbuJCm/NvG
	COS8OLf2fkcq3yvw4reROb2KBHdJJM+BVvfN9Rkky/zHx8MBYk7DoWntbmpuTw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795510687; a=rsa-sha256;
	cv=none;
	b=RAAbULMa3e6K1O2Gi0FwhBnnneJwqk7lNyNwIJzboTS9qy4nqC3u6Rad8GqqLcZTgt6f/6
	tnqpY0lMCrR9vuo1T7PlsITrgtissGmnFN0yFKPa1hcQHSmeT6UgeeUi0VOpdw5ucLHqH3
	L0D/UjqkzaislfvOgRRR0uc0YCOm15OalhUGVpgZDTQHb+2gqCd0oA7IVQE4sxRHedV0oj
	y4CVnkoCKsOsm2ahsQ8kCEtq85ytQC0moRZdOcHeGdlxrpNlLvvy/CjAGmvE5LZodf3NVY
	SEYsZI2dlHkvjsZ+GWT43WwY8hksmBszMDoFsE6x5DTAgIUdYLJmF72YeHjkEQ==
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Zhu Ling <zhuling0805@qq.com>,
	stable@vger.kernel.org,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 08/12] can: netlink: fix static FD-NON-ISO mode validation
Date: Tue, 24 Nov 2026 09:51:35 +0100
Message-ID: <20261124085757.1093632-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124085757.1093632-1-mkl@pengutronix.de>
References: <20261124085757.1093632-1-mkl@pengutronix.de>
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

Older kernels without the above mentioned commit do not need this fix.
They can lose the static FD-NON-ISO mode by an explicit 'fd-non-iso off'
too, but this only changes the reported control mode while the hardware
keeps using non-ISO CAN FD.

[Hartkopp: reject switching off static control modes instead of restoring
 them, extend the commit message (Sashiko review)]

Fixes: 6742ca18cb41 ("can: netlink: add userland error messages")
Cc: stable@vger.kernel.org
Signed-off-by: Zhu Ling <zhuling0805@qq.com>
Link: https://lore.kernel.org/all/tencent_3A964832542399A780E646D6A6246335C409@qq.com/
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261115095746.709371-1-mkl%40pengutronix.de
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20261120-can-bcmlock-memcg-v7-8-f6b84f5257b1@hartkopp.net
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

