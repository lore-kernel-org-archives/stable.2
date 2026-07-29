Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0D244683E;
	Wed, 29 Jul 2026 10:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785320975; cv=none; b=ubRF6ABIyIDx9bQc9moFK+X3SSsJR1sQuVpjnELWdCXZifYpoIXCnO/ZNNxKWuQEoqkDBoSX7nU88QJlO8lC0/NfteFPjkMr8KjtT/qxfNlEHnOeeCIdzkzp+mi3MotulUjf3HLBHv1TvysPD1lKrsCv/ui4ukgKUMGtZewjYFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785320975; c=relaxed/simple;
	bh=90IVm2phOA3ZtWQAczAo3ulVmLNxFvGMnRP/NJR8jvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ON5EwowbEcsgfUxbG6wO6yjU5uwnuRlreatZ6JFJnfdCE5jYiyaNr/N+uhhJBwSNXZTd+tgbReXoAft3vxq7VTyUL0UQwIjUL5/FrocoL7kFXDFkll0Iwun1wSR9ZSZnUjBJ9iOYd4T1qI0AWzQ4FrAs3wC1CCD97bxztrWpOCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 5386E202B5C;
	Wed, 29 Jul 2026 12:29:26 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wp1XR-001rn5-38;
	Wed, 29 Jul 2026 12:29:26 +0200
Received: from blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4B087575DD2;
	Wed, 29 Jul 2026 10:28:11 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 13/20] can: kvaser_usb: kvaser_usb_hydra_get_busparams(): fix memory leak in kvaser_usb_hydra_get_busparams()
Date: Wed, 29 Jul 2026 12:12:53 +0200
Message-ID: <20260729102802.505168-14-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729102802.505168-1-mkl@pengutronix.de>
References: <20260729102802.505168-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Abdun Nihaal <nihaal@cse.iitm.ac.in>

The memory allocated for cmd is not freed after the call to
kvaser_usb_send_cmd() in both the normal and error paths.
Fix that by adding a kfree() immediately after the call.

Fixes: 39d3df6b0ea8 ("can: kvaser_usb: Compare requested bittiming parameters with actual parameters in do_set_{,data}_bittiming")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Link: https://patch.msgid.link/20260722103906.108571-1-nihaal@cse.iitm.ac.in
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index e09d663e362f..efbb7bed34c9 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -1626,6 +1626,7 @@ static int kvaser_usb_hydra_get_busparams(struct kvaser_usb_net_priv *priv,
 	reinit_completion(&priv->get_busparams_comp);
 
 	err = kvaser_usb_send_cmd(dev, cmd, cmd_len);
+	kfree(cmd);
 	if (err)
 		return err;
 
-- 
2.53.0

