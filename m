Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B264E50A4;
	Fri,  9 Oct 2026 13:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553427; cv=pass; b=UahPagH7eTh8RG6d/8iRCDdIsawptASDYYKKpbmPy7tTOjfWr2sF5Ovdt2iacj2cxnvLTBeDBnhsfzyxlspjHRDBvFJBDc0zn/Z4FlIpzySx02s7g0Gqmdp03h8W7UPxi39b3egU6HISozLwxq0+ADbJED6sNhv6xRIt7YkHE9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553427; c=relaxed/simple;
	bh=pCvkEoLFkbqIKhTVTrG4IkVlekysPQ3Td5eIHxJJUvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s46FPBHm9lREvOF+NLFlMeV1d9sOnvgzqoqilzI1kWcLJFdmEVcPJaRfscn+x6Vq+SKWjGHUt2Jzob+CZd7vNgQu32bsKrI2cnDWn+gqNevTzd5I9x1cR2sA9Y09xIlmzC2oX0B53AnP7CUaUZNRCwDbaoEEna0L/1jq7qeI0x8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=giU5Bnmz; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="giU5Bnmz"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 67F7C202603;
	Fri, 09 Oct 2026 15:43:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UY6/PBTu/e0Zb9SwngmL/6NQDZDNEGA5tfaEEthL7Ww=;
	b=giU5BnmzleYmZsRzj6CsLr0GXGNU7Ahj9HACWqA45lRwWiRLrHlofFIC0ySzCxzvDsB/UO
	rBlsFCZ+Swc2IHldgGKgnetNySWeoRIHCBCP30hk4bP1LpTZQdlhkf84QvoHxEg6b7FyrQ
	2rWBUcvc8K5/S2ptKQxk7LU5FRVNl8GW8XMpQawTMcDc5HfrxlsLh1kP263rvRGTZrvgZY
	l/zKIgaHA9KdBP9WptLttAmwQT8jNslQ5SjKtbPBsRjq6WacO0QovAzoU3MMYD+2DKa/Wd
	5ZI4GmSfKqOdku+fUAtfMH4iu0yYjHF6hCF+jUWIlztjo0GLHXjzSD5oe2tjKA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791553421; a=rsa-sha256;
	cv=none;
	b=NKUUCVJ1K/TSvnd9SyxZFC4YLvLo2w9V5VTTX5kFxtnq/hP03XKp0seB/9tS678yH8noUj
	Wlh1ibi8OWiT8S9IYV2d3Tc7aL+n1KMpyB1jtqZF8yqDH9Rd43Lm0qFHYFQGFF5M86f3ez
	87oVaKHPBGHirIX+H450doA3x0/q8Ua5R1e49PvD7bkqiFYgAP4E2c5x5SpSr2e+MD112C
	sG97zFUorZd4Z1TU79YhzFESgXmIqrKnJRtqrTaR+S78wsTUtfov1e6Q9b2GVd2AitqML7
	F6Ckt6ZWtJ/yAmMDW3b8VJO98wmw3JEnZ9vliIuHkm2P8kEDanWoBy9SuQ4KUQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UY6/PBTu/e0Zb9SwngmL/6NQDZDNEGA5tfaEEthL7Ww=;
	b=AHWBoKAEtgBbCe2/hlht1+D0uGkE/hZmWb0PfLzbLt/Pi1yvimyxb+GqtuIknb+BGLLBFR
	G/Tz9nO26rebIWZQtdilNVTR9W5cyM79ONKAWAuQmSS22ODkicX162a3DgXKI8Lua2XP3o
	OZSBdIvpKOW1Q5YUVz3s+sNg6bOMgdtyWI4f2MUvHhSJgbTZwSb5boBi701EWKVcy8ldpq
	I6cUpQ+BxctyX0iKHas2F4/+Teodi6tkPONGFuHyZOyQ51oUracPVLPFXD/TwUMeX4uFgJ
	YiPO4RF/Td1aLXgqaZTUET53LCC2KWLu5cJrEhYOmxMGOqP3++zbzeY+6E8oTQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xFAsv-0053Tc-13;
	Fri, 09 Oct 2026 15:43:41 +0200
Received: from blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E15C55BD8F4;
	Fri, 09 Oct 2026 13:43:40 +0000 (UTC)
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
Date: Fri,  9 Oct 2026 15:28:05 +0200
Message-ID: <20261009134323.64064-34-mkl@pengutronix.de>
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

