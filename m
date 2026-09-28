Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A9C5013B8;
	Mon, 28 Sep 2026 19:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624008; cv=pass; b=JF9XLyODNzwjXS532oGhDtFYK6k/RUX8A2BMJVppvVDj0tAbyA2nptTg10MLGyYVQMYJuawdq49hPVbYhLwNVF9G10qFKNWGHqUc/qHGAL7GowTnv7XCS70m3549AweKLTSbQ+OSWTTs4Vxei/FlI5+7pbikQMLPq6EzgKu/TBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624008; c=relaxed/simple;
	bh=pCvkEoLFkbqIKhTVTrG4IkVlekysPQ3Td5eIHxJJUvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QueaqUh00ARDhsTITrGHZTxYInOavrnpddp3O+xox3nyNdgpCOmiQi/en/0rJsai5PLCUZu3+iyfIMvbUntbAFAwCxJwYVO1ZCytVyKA4+w87WjM57+pV1VdHrpAjU4uZ8d9OJgq7CQLa8VfGlg/kKyOoVQuqifHEgnd8ck5xvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=W8RGS+r5; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="W8RGS+r5"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3340B202007;
	Mon, 28 Sep 2026 21:33:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UY6/PBTu/e0Zb9SwngmL/6NQDZDNEGA5tfaEEthL7Ww=;
	b=W8RGS+r58xuVk9GwfMesXmf2W7Kosr5sxn7ulMpB4BJX+txo3CNdp3bX6B+849jrF+MK4b
	jEXyzai4OnJlOP42yNbfg68aniFio0NNU8LncH1fOmUPdGbXRA5tOz1aP4zYp73uOd2zSI
	SfjIOKars30RyZCOgAvmRZbzgbVV7+g5UYKsk0/sFznJzahLuGLwPkh2qH4ogt/0S5ij5C
	NZaiO3xh0ttKZsPOIiB9M0AqLLEd9HO/sm+1efdq1PSAFtT2vE5VWPIzW4MA0LArvYOGY+
	S+haX3g1F2vw2eFVqFPLeeGTTRot8PHPCRwhYedvz5/7kMFfG658NH7AUtMyKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UY6/PBTu/e0Zb9SwngmL/6NQDZDNEGA5tfaEEthL7Ww=;
	b=SdtEn380W6tRZgQpayBoWLi/6DHR/IRXQS/0F0olkTqhgv0CxVTBYULeAVDQCH0PKGaqoC
	AkGkop8T1HDYtOPpTCgcnI13BmMDxECVRFzU72pqvIKMlVf46n5ZtPJ9wAoZWk6WFw/qYZ
	lTUt4tDP7nDjLJRFpEkY6eQM9xdzb4uwuovXAOf3gyt7tP7xxrlSy5cROvJUMnZ9i2Jzjb
	jVVg8LCLVWjMJzZ9NdIWJFWvyv0shpy/kwETr/NEP6RdPTl0WlTR9Z4NKmg0wz3JvjjJzn
	v0haDIhWHI46fm0I6tr0Fu/t/m3SM3g6yo+H+A+EFNJQUiuDme5Wf0A1r/RYuQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790623996; a=rsa-sha256;
	cv=none;
	b=epZNK/pC1VD3AZUQow31bvgOfnAP6OXRnCtiTfndsJoDS+nvZFo53Y5HFQKUkBG7Kf2XTW
	LJLmP/Xkc3GXoGNHc6GGHS3Mh1APiiGiL3RmUHJyIY4SG7USF5jkZg69jvKjn24ZmnJjDw
	IzfXkvk/KMLX7KcvWuPL7qR7uPdQddf1q+nw1URLbyYR4S7qS+V8xPtL2WydDWL4n3RKwH
	iz+3SN8LUZ7EWTwLsXV3y6sWIT2oZbvdlOaPnWaKj5qZoCJ8Mnk1Fx4wd2NkyQHBjXZDOM
	kB+YB+tiJWkpLoVhRqiyNmKf1BAM6yy/S523Piohz43nwrwQvdMUNj+gbmAA0Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBH6B-003H6D-39;
	Mon, 28 Sep 2026 21:33:16 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A8FE75B1551;
	Mon, 28 Sep 2026 19:33:15 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Fan Wu <fanwu01@zju.edu.cn>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 10/22] can: kvaser_pciefd: fix use-after-free in bec poll timer
Date: Mon, 28 Sep 2026 20:45:17 +0200
Message-ID: <20260928193312.553632-11-mkl@pengutronix.de>
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

The bec poll timer is rearmed from the interrupt handler, so the
timer_delete() call in kvaser_pciefd_remove() neither waits for a
callback that is already running nor stops the handler from rearming
the timer until the interrupt is freed later in the same function.
The timer can therefore still be pending or running when free_candev()
frees the CAN device, causing a use-after-free in
kvaser_pciefd_bec_poll_timer().

Use timer_shutdown_sync() instead, which waits for a running callback
and makes a later rearm a no-op.  Also drain the timer in
kvaser_pciefd_teardown_can_ctrls(), which frees the CAN devices on the
probe error paths.

This issue was found by an in-house static analysis tool.

Fixes: 26ad340e582d ("can: kvaser_pciefd: Add driver for Kvaser PCIEcan devices")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Link: https://patch.msgid.link/20260818063832.383829-1-fanwu01@zju.edu.cn
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
index d8c9bfb20230..a0597db72086 100644
--- a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
+++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
@@ -1739,6 +1739,7 @@ static void kvaser_pciefd_teardown_can_ctrls(struct kvaser_pciefd *pcie)
 			iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
 			kvaser_pciefd_pwm_stop(can);
 			kvaser_pciefd_devlink_port_unregister(can);
+			timer_shutdown_sync(&can->bec_poll_timer);
 			free_candev(can->can.dev);
 		}
 	}
@@ -1879,7 +1880,7 @@ static void kvaser_pciefd_remove(struct pci_dev *pdev)
 		struct kvaser_pciefd_can *can = pcie->can[i];
 
 		unregister_candev(can->can.dev);
-		timer_delete(&can->bec_poll_timer);
+		timer_shutdown_sync(&can->bec_poll_timer);
 		kvaser_pciefd_pwm_stop(can);
 		kvaser_pciefd_devlink_port_unregister(can);
 	}
-- 
2.53.0

