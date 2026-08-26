Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984873FC5AF;
	Wed, 26 Aug 2026 12:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787746254; cv=none; b=oII9nWJ8ZOvhrYhpGIxsexOhJsNPA2bL63nGyxVVnUc9YeSiYsWmwePhgvmWAw8kRfzB+PhkEq/8O2ed0V1JL1itF6Srhp8QKdT7sV9/udFuVdJkp4vuqUJ6zKxdE3KFyiitn+kZCpnn3Ktcdh5TeoeIVTwv4WRmGQvWPBvRJ2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787746254; c=relaxed/simple;
	bh=pCvkEoLFkbqIKhTVTrG4IkVlekysPQ3Td5eIHxJJUvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YmYHWbkMlYNyjpPExQdBob5TlhVBsQPFnxiK8V9ik8lhyNefUVrwPpuxhyj0CWuYe1HK7B9RwgUkSPzQYV8LwanFCtdEMLHTHkn8W6y9L9Ta9WcQJoiEGOb53skHzBPVhSln3XDy6GojuigJudSeakIa9yk44dWHPh0vfxIOdZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 30FE52023E0;
	Wed, 26 Aug 2026 14:10:39 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wzCSl-003R9K-0J;
	Wed, 26 Aug 2026 14:10:39 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id CE9D958CD02;
	Wed, 26 Aug 2026 12:10:38 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Fan Wu <fanwu01@zju.edu.cn>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 11/14] can: kvaser_pciefd: fix use-after-free in bec poll timer
Date: Wed, 26 Aug 2026 14:02:21 +0200
Message-ID: <20260826121036.2706424-12-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826121036.2706424-1-mkl@pengutronix.de>
References: <20260826121036.2706424-1-mkl@pengutronix.de>
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

