Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA025013D3;
	Mon, 28 Sep 2026 19:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624009; cv=pass; b=g0NgQSahExj9nStBYed8Xao9LY1DwB+uzov59zKAaGd7ofeafphoaBhuYzQvy0x1DqgFU2ZjngVIIfadKNT/Kg240GAikk3AyHYoDh7vrnquvdJ40uEJJQHARcOt0C3X5s0r0Z1yUcU/WJAB9PDZnHhOS58uIy71XcoMtr1B3+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624009; c=relaxed/simple;
	bh=EmZCaCFpg9IeM1aa6/83UsYiwg0ssSVm2T3CTweNV+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tv9zxIHy275n7CE+aImPA8dLKiWNl663Qzrwxbm08U8VDuhNlh6GuYqOCUFqgc8EbjtAm2PYC7rVlJgiL1pRk3u6REo9zjhM3mreCghb0cjw/JJzkYqHEPdz2BlZTnTfb41Nqd7VBcEd5gKFCTtztT3XW30oKR8HnVf+oHiUlqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=bZdRstBA; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="bZdRstBA"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 46DF320206B;
	Mon, 28 Sep 2026 21:33:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o7ElqIm7mH1Wy8NGUPsDn22LfZ/7ltoWFLIeK891R3I=;
	b=bZdRstBAx+5LXzch1EOfR4oJ1mRzwgwXzZgq23/TD/kGewzo4D1UrH2FKUCtcGkaEGMaPc
	M2ZqMU4gr5NypGs3NcYBRhlcHTTzIPdmOv8a05vnVGsP0x/uCjRfTMYpuX38ffHJUyJxMR
	KI+WGUx7VNMQ8ttz1ntYGecJ/2Stv7MhqLw6mu1M1/WeMrQ6LdUFFUsBVIeEdv306cRJjz
	v29ryHuw+mDA45C8lb3xC7EB6CDEFnsV1Ol5FChLrANimps7dM9kW6bsDfu0vHByY9o2Ja
	x90aj9jh6TPfggREWEwSrIJGgNLuI+KjAJlkSvjcgZ5id5ARcA4X7MxWWCbb0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o7ElqIm7mH1Wy8NGUPsDn22LfZ/7ltoWFLIeK891R3I=;
	b=UGaIO1s1T/TmRJCnWL8sifWs4wkcancOmFt4/SXZJlbdx0jBSRjFURsUAq0zSNrYAZ4C9+
	uz5pcypjTnP47xaz8EYvTT0Bt5W6HsVpgcpAhx070VkCSPY6AGx/Zj9Z+CPs7p/MUgoOHg
	iUcf5qTpeDYQU9Muh+n487sWE+QBMCO8VXduL3k5pX2QRIDmNBP9Ccuo+POfN8gPaDq0qt
	jCFA/yuyX3+akNgWntq21ub4K8KbbMeOuPNhkSX981aeEAwm73l/wFwswLWM6+3mJTnuXZ
	3qErAos5ElifqKTw1A1iHysiPLiyI2e71ceEtb6nvbdOLMTlCfu6s9rqWlAcuQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790623996; a=rsa-sha256;
	cv=none;
	b=WfpRhNnwNZRkxdTzl8YcaXlj9yQLm8y13uwS+ofsUjUXxtjeBVt8fbT9hShnevSPgGihmP
	0RcrOUa039uWRVj504QMMJuUrB4dYwn3kgFTGuIsaqIE2FjEKe2M2JeGw3/LTuyovhEuVR
	LJrChRiOIDLwAvIVLXWs1Lb5vx7bJOP56NNZ2iIi965Wb7bY/fw0RfGsyRFYMVaGYGyAf6
	9IAS9vmop9rfSfgjrf3CIeapiyJGSravaIHLmP9GZX6qkVY7NC1lCeqTqjOaD0Icdlot3z
	4mlFr1CZ9cCD87D586kny9qW8nF0vI2NqPQbfeog9tRDNNiZpKZnh9JL6xEaew==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBH6C-003H6E-06;
	Mon, 28 Sep 2026 21:33:16 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C15DC5B1552;
	Mon, 28 Sep 2026 19:33:15 +0000 (UTC)
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
Subject: [PATCH net 11/22] can: m_can: pci: add missing pm_runtime_dont_use_autosuspend() call
Date: Mon, 28 Sep 2026 20:45:18 +0200
Message-ID: <20260928193312.553632-12-mkl@pengutronix.de>
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

