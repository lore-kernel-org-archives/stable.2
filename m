Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1623783B5;
	Thu, 15 Oct 2026 01:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029233; cv=pass; b=Iugsy8u1d8lbs/kA5ZIUNxa3ho7NGO5OB6wUYHFaGOMHxLxxgViyH1vzEk+5ftvf3AagfIPQC7CHeOOmG4SD4th2zX23IIt/RKl5ah4ZK5T4TNfS+YOmBzTl6jQKgAKeDb8pOKv+S1ZS/dmhlzwpg7O0v6Q+Mq1y+Q4zdn1l9Yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029233; c=relaxed/simple;
	bh=pCvkEoLFkbqIKhTVTrG4IkVlekysPQ3Td5eIHxJJUvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MBQ3FJUEhwKDyjFgtR2S9GepEjglDLzXtitRcu/iBR6ytsFI/FSpX0xSCAmIEP6UaEL0z9jS8Ken2gtTVKqc9TLTdiSFJIg6HYr3dTaFa7/spGLt/F8aFUHAIu0DGCztudvyb3CAxDNcYq6vATHE+Ji1MNMPFyCU4dzfvBaKyXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=guj9/al0; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="guj9/al0"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 98B4D2027EB;
	Thu, 15 Oct 2026 03:53:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UY6/PBTu/e0Zb9SwngmL/6NQDZDNEGA5tfaEEthL7Ww=;
	b=guj9/al0m77/SP7W9pJCvnicVfxnltq/VoIl0QNRx8lNcAFaX1/QWKz09E460gSUhZmhBV
	DDpwxb9eH4avZGmgYCZahiMxFd520DGxtqToP5ZmMC/SOvCAvsrjPF5sHYdNQAhoOi7OL6
	66ubpwxrbVjnMeZAu2jAE9nQuVa3xbhhVJbcwEJwVtj4cbHriJfcuM63gV1+7GdrE+zfXp
	nk2eViULfFp0TXQm5h3ORYETxvm0XrG5FIylwM5R/FXRdJiJsCEGJ4JW3PI2Glckkwj9jv
	uAI+ztU0oqaRGD7s8oeclpI+quIAPmq6PgwapHIRaFYekt43WT9pQEFQYFo4FQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792029222; a=rsa-sha256;
	cv=none;
	b=W5MvTXkCBePfO8Jc8TDRAMg/VMB2TXYwn/xhNJtTIWj81QFpNMY6RyU/+EVtpWwh8mf/Ba
	ugnLt8arPdptXHKgdy0S1WI0MR3YUqp3vw7GyFmCXBgVrL4j3DNpSI/Sr9T88AzgoNCMpZ
	nht7tznAFmP6yCm6Qybv9e6bvq/bA/wraSRwTTR+3K+0rE7zGVbtahlYnvq7FbKLzUlmNI
	dg1OO9g+7y1OpRc1U6Vbu16AfTUVnNuy3SUYcZIpljM8fSO9Rc2xos5wfdQ1qwudP8XHka
	2gXabcPyGmif5X8C1r+Ak31EIBcgTjNurjh1oReRpITiBjUg6Zt/jHDg3lQeig==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UY6/PBTu/e0Zb9SwngmL/6NQDZDNEGA5tfaEEthL7Ww=;
	b=CdETWR/RlhzwQ4l5yAjlQeymG1g9zFcyCrDnWifINuZplvjE63+A77nV3DkieVykwpb9gp
	MKHpaRoh9SDHCeQ2DeXamkYaolME1I0nblkyXKa7M9yGYN6XWDjzTgcCla4DAIvJQtDaE9
	zaQ1pe1vlnOzKQBqcjXzu1bDMJuYo3NFzJ2t1EHKvyvoLS9OK/jSIxpVz+uVB4Acst13UX
	yggtSE/cZHVPHA2Uyl1fsq16G/ssszHSbwysLFJ7X/CbQV0Pt4bRGDMDBamVn1dxSTU6v2
	o9D0X8aR7wFwEw3DqCTXAcgj6lGrn/R4Ld4KdFRo4HB7QUW0HTR3Ez1DtR9+8Q==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHAf8-005wrh-1g;
	Thu, 15 Oct 2026 03:53:42 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4B0F65C47BA;
	Thu, 15 Oct 2026 01:53:42 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Fan Wu <fanwu01@zju.edu.cn>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 33/37] can: kvaser_pciefd: fix use-after-free in bec poll timer
Date: Thu, 15 Oct 2026 03:40:31 +0200
Message-ID: <20261015015336.816543-34-mkl@pengutronix.de>
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

