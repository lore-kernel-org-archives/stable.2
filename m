Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B295403135;
	Tue, 29 Sep 2026 21:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790716051; cv=pass; b=gWhb071yWN0LQSmZDR/5cgNIppLlmWQvs7xiBlzsm5SfXgMXx9Phh7h4mL3E5lfhcacrEd+MDfsYwvMS+0CVgGlsT4tzLWlF5Izb2IJXriKpmiPvVYUTXQkzTf12RUZmkNl22kK/ynHnOx26jdcKDfsbiciWxZ7sBr1O1uq3yrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790716051; c=relaxed/simple;
	bh=EmZCaCFpg9IeM1aa6/83UsYiwg0ssSVm2T3CTweNV+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/sJpALGKKyKgFdp/TURUife0S543Ybcp0y4F54I4jgS3Vb0F+ro3EfaJg/6sr5hcVD5XhFV05aX5xNcgFycpNog8Gxse+epM6s8ybey70hdwoWHytRTCrXZJsjB6RdmtBRNbG+ox9qXImgGSj5rfjcJ5L3wKPCCzAbbarYuOgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=en/sRfFY; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="en/sRfFY"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id BA66A200C22;
	Tue, 29 Sep 2026 23:07:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790716023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o7ElqIm7mH1Wy8NGUPsDn22LfZ/7ltoWFLIeK891R3I=;
	b=en/sRfFYLZIqodR0mrrEcMW262fL9c/WW1QNMabrGg5FLRvAVMtJg3BKJPz7gbbdIpTdn8
	opQt94nNXd0LoW5cVjy7gVu+I2YJyKw8itd9gTUnieRt8JIt0nrEHrK34R0fxjm+sNIRw2
	cjA03fsaq9yTUW+NL4c/GSPURAa0U0EuF4Zr6doMcP9WlhJyECo56pAlqGPhpQZ6RWZAJO
	94IfXZlH4h7kk9X3X83h0dbkdVskdJH/d7jJgnACorm9G3s867yjo5dAix33bBknbyvIDt
	EgC2ChHri35XGcCISgmwBWpur9z2QQoxavg9DjwZGdKddn6xQQUbvagC0y1Y+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790716023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o7ElqIm7mH1Wy8NGUPsDn22LfZ/7ltoWFLIeK891R3I=;
	b=GaLTSkxmiNTy1Ul+VkJur5YQG5Pdr8ITSM83lQDPheeAkHZzNavwfnmTcZqPWZFrdiKcv2
	GKwOJN/PcSdZRg5aFuBSKZF/8Vj4kqJxGoFsnrP36eUaOnePIm+UKyLiXHN+/OlP39rV1H
	ZCkxWuwATu4Fke9SV8FWMjpk8L6FxuJ+SEz1C5fIHmONbEIVBtVLGtTzdZHEoZoBF4CuRN
	or0PxYtdkY4+9HV3rf5N2fTtUhD4l2pB+JEkZz31a7k1fMM4xpE0+SJQBR32GQbSJHkXxO
	tyOqFzx0lFfmwISsiAZ5YtfXw9CWHuLgmKlefam1m3kwum41/Bp210Rz4ya4ig==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790716023; a=rsa-sha256;
	cv=none;
	b=TqK1v5MITusVovWhOiz4qF5AMgZbJgYuzzK9baQsRZZkg/+6YB0/wYv53DvLt/o8VniRDX
	J21qPBr41gG1QWp7TvepyelCD0ukfOL9IK1+H/r4ZKUGMqtJHNhP9DFY3rzVjlxvS0daXj
	F/V6CQhwfrTQDelebH2nGvz6SWeWE/MxuA/vj0Qiwku2JB2L4rtFTJw/AARRsjCVVRFVJ5
	YsuFk4lKEI4a/gW7CDAuieMM0fWce3b5CNbCK7RoCAANuTET5HObNHoOClKAEVidqP/gqK
	dtN3Wx9Hi584ZHvVIfJHt4TTF+eTI0uLqaWrNXfhV8Wa6TgscaHybpF/wYvCzA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBf2V-003S3m-1z;
	Tue, 29 Sep 2026 23:07:03 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 57F545B4CD7;
	Tue, 29 Sep 2026 21:07:03 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 07/16] can: m_can: pci: add missing pm_runtime_dont_use_autosuspend() call
Date: Tue, 29 Sep 2026 22:43:57 +0200
Message-ID: <20260929210700.1183036-8-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929210700.1183036-1-mkl@pengutronix.de>
References: <20260929210700.1183036-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Crofts <joshua.crofts1@gmail.com>

m_can_pci_remove() forgets to call pm_runtime_dont_use_autosuspend() on
teardown, even though autosuspend is enabled in m_can_pci_probe().

Add the missing function call.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
Acked-by: Markus Schneider-Pargmann <msp@baylibre.com>
Fixes: cab7ffc0324f ("can: m_can: add PCI glue driver for Intel Elkhart Lake")
Link: https://patch.msgid.link/20260916124236.1389-1-joshua.crofts1@gmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/m_can/m_can_pci.c b/drivers/net/can/m_can/m_can_pci.c
index d11a7c88fc32..3c595749b5c7 100644
--- a/drivers/net/can/m_can/m_can_pci.c
+++ b/drivers/net/can/m_can/m_can_pci.c
@@ -159,6 +159,7 @@ static void m_can_pci_remove(struct pci_dev *pci)
 	struct m_can_pci_priv *priv = cdev_to_priv(mcan_class);
 
 	pm_runtime_forbid(&pci->dev);
+	pm_runtime_dont_use_autosuspend(&pci->dev);
 	pm_runtime_get_noresume(&pci->dev);
 
 	/* Disable interrupt control at CAN wrapper IP */
-- 
2.53.0

