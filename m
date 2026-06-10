Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D727242DFF4;
	Wed, 10 Jun 2026 16:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.188.205.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781107915; cv=none; b=ANv9t5QiAxL3dJNQK8GDXMABf0g45g3D33IjxAbnGLYcLszxPRYV3SENLrEwR1ZnY49Y7Rol+sTk0RdEmLPydl2O6QAvAUwtFE/OU1OkD/DpAzqkHbe1fdxTfXGnBhDmwMvbIYrUp4jsyrv009/wwstvQFlm1GYd/l0B3Kej67c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781107915; c=relaxed/simple;
	bh=g7BZo8ONelciFNcARnK87kA3zf9NSxNSUp1iCmZQtVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M91cxJr+1Y1V+/AbNSMybwx6Ytsx5d/d3+pBEWJxOIiuBZPsZa3EE6ownzXhK4KCIZuHxwOU2lS/Dgi8PDNKYXYlP2naQNqfZzoyLkAI0XGkMUczmVCWWa2TFPN9zqX3mzqkZIu/BnuzhVb/g/ql9J8Yzbs9PmAGsrIK4MUU6Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=ma44tvA+; arc=none smtp.client-ip=93.188.205.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="ma44tvA+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1781107905;
	bh=g7BZo8ONelciFNcARnK87kA3zf9NSxNSUp1iCmZQtVQ=;
	h=From:To:Cc:Subject:Date:From;
	b=ma44tvA+NM5cHhIt1pBHaxRO88MNmtYScqat8SnVdYCUN1ymXX9lHpB7m5JDfSsLT
	 +ixHyDKbZnI/KZCc2Sto77QTaMVMRMz9WrHYgkBEisTyPtBFKxydnn6iA1qvOr41X1
	 BfhT/GyI8gthjohkokqof5CdmD5ehOmTb1Ezl/qjtatZgxtjrth/NQQ0qywKmJzuch
	 zDZpi7fnqJXHCIY7bNB1aiso57JTkXRHN4QsnOjpOgD7wfFwFavGZqEcl+/UkmvLlf
	 OVuF90C/UDzlR4lua1Dz5bO3OU+l8/qxLIDFn0RWhykHe0UjWDP4NpCPGDaLT7OFUC
	 FLkLqXBe2YVUQ==
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id 059541FA2D;
	Wed, 10 Jun 2026 19:11:45 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Wed, 10 Jun 2026 19:11:41 +0300 (MSK)
Received: from rbta-msk-lt-156703.astralinux.ru (unknown [10.198.54.246])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4gb9l06wmyzZd74;
	Wed, 10 Jun 2026 19:11:40 +0300 (MSK)
From: Alexey Panov <apanov@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Panov <apanov@astralinux.ru>,
	Mark Brown <broonie@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Neil Armstrong <narmstrong@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Dongliang Mu <mudongliangabcd@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	lvc-project@linuxtesting.org,
	Felix Gu <ustc.gu@gmail.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.10] spi: meson-spicc: Fix double-put in remove path
Date: Wed, 10 Jun 2026 19:11:29 +0300
Message-Id: <20260610161129.7612-1-apanov@astralinux.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2026/06/10 14:25:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: apanov@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 107 0.3.107 575e75fe8e3b9d45c142d144823c5de38605099e, {Tracking_one_susp_tld}, {Tracking_uf_ne_domains}, {Tracking_internal2}, {Tracking_from_domain_doesnt_match_to}, patch.msgid.link:7.1.1;new-mail.astralinux.ru:7.1.1;astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 203793 [Jun 10 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/06/10 13:12:00 #28226830
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/06/10 14:25:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Felix Gu <ustc.gu@gmail.com>

commit 63542bb402b7013171c9f621c28b609eda4dbf1f upstream.

meson_spicc_probe() registers the controller with
devm_spi_register_controller(), so teardown already drops the
controller reference via devm cleanup.

Calling spi_controller_put() again in meson_spicc_remove()
causes a double-put.

Fixes: 8311ee2164c5 ("spi: meson-spicc: fix memory leak in meson_spicc_remove")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Reviewed-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260322-rockchip-v1-1-fac3f0c6dad8@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
[ Alexey: Remove the equivalent legacy spi_master_put() call used in
  linux-5.10.y. ]
Signed-off-by: Alexey Panov <apanov@astralinux.ru>
---
Backport fix for CVE-2026-31489
 drivers/spi/spi-meson-spicc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index 6974a1c947aa..ae818e7df791 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -863,8 +863,6 @@ static int meson_spicc_remove(struct platform_device *pdev)
 	clk_disable_unprepare(spicc->core);
 	clk_disable_unprepare(spicc->pclk);
 
-	spi_master_put(spicc->master);
-
 	return 0;
 }
 
-- 
2.47.3
