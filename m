Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39663F928B;
	Wed, 26 Aug 2026 12:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787746255; cv=none; b=OEVzuSwA+C6oc2FwyB3f2nCszxdlklm9uiO9XgDKdNb4WP3FS0yWXxWPUsR9USRTnQcDdoP9zWCidNU9bpG/Wkd6B2QqzK4xnVDxiAeE6d9MjcJw66K5JE7gXSv8wu3iJeoHj8g3RFmYtsYYlID8pZajqpO04scSsxgS5afr8Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787746255; c=relaxed/simple;
	bh=GzsTedIp/U7bLZDchwdlS8BV7pxZDQ/KvGK8jj6Qw8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ytt+apvYB0qejBxEXs3KhT2cXX/n8m+0d9Rn5w6M2TQex54L1aTnxLWuWI/EyyTK+bKi3xaKMh8qge1FguxcS+ZwCRmyOCTPA3OgfelC83aO6gXfQRgvsyfc2vVYbl6yq0r4t5BiR0hMII+FUi/PWn4WazRl+WF7MSSUcRZvfaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 6A917202411;
	Wed, 26 Aug 2026 14:10:39 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wzCSl-003R9a-16;
	Wed, 26 Aug 2026 14:10:39 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1B01558CD05;
	Wed, 26 Aug 2026 12:10:39 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 14/14] can: hi311x: drop hi3110_lock before free_irq() on open failure
Date: Wed, 26 Aug 2026 14:02:24 +0200
Message-ID: <20260826121036.2706424-15-mkl@pengutronix.de>
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

From: Runyu Xiao <runyu.xiao@seu.edu.cn>

hi3110_open() requests a threaded IRQ and then performs hardware
setup while holding priv->hi3110_lock. If reset, setup, or
normal-mode entry fails, the error path calls free_irq() while still
holding that mutex.

The threaded handler takes priv->hi3110_lock before checking
force_quit, while free_irq() waits for the threaded handler to finish.
That can deadlock the open() rollback path against a pending IRQ
thread.

Set force_quit, drop hi3110_lock before free_irq(), and take the
mutex again for the remaining hardware cleanup.

Fixes: 57e83fb9b746 ("can: hi311x: Add Holt HI-311x CAN driver")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Link: https://patch.msgid.link/20260820020631.316418-1-runyu.xiao@seu.edu.cn
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/hi311x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index ae90e6716de5..2be851e8907d 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -787,7 +787,10 @@ static int hi3110_open(struct net_device *net)
 	return 0;
 
  out_free_irq:
+	priv->force_quit = 1;
+	mutex_unlock(&priv->hi3110_lock);
 	free_irq(spi->irq, priv);
+	mutex_lock(&priv->hi3110_lock);
 	hi3110_hw_sleep(spi);
  out_close:
 	hi3110_power_enable(priv->transceiver, 0);
-- 
2.53.0

