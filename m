Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540922;
	b=KlcuPMQAnpEbHXSc/rCSGHx5kHY+bXzBivCdcaC7MEcr9/5xogUbZ+dUqrlNOEUTLdOi
	 gqiC+RBng6AfAxnaMM8HKaZgqEk++CUk2VjULJQlRSxH57G08ThVzEljucv/pxaA4gAwv
	 r//MUDXn9GjfUiQ0dedF1ok1ZNEkKaMdkz8UcH2g0O7GJ5dD4N/qWhdESszwkEbfVGg2q
	 nfMnBkrmxeLHxL86D6nsVH0qPb4nkOQQCsBN5QFzVPd/S57TIhfdjgGHZOqhASiggfv/7
	 POfjM+giMFzvTBTDqZWQHomQgc60hqOBH2KcxSbkqgE0lJQlwzxQUkp95ZoidL4i1tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540922;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RhoE6ABhU1UsJqIZWJopjjssM7UJpQvdNNruj+7vgYM=;
	b=yO6cD/68040k3sHqnyjIiFzqaKVabfzc4hufGLEhkVL41Cn6J0FvdhFxkPaN3ngXajOZ
	 8xVrIBeSjqO7AM8wMYQqY6qMIG08dse18Yey4b9bYmUklm9cN9QHl7L6fuEBtwwc771Bv
	 Q2WGqtQRwdD+OKm2as/hxIIgIRIBvaksDzPn8d3XuK0QAXL7eaXjzQI5DY4exbzWlpmq9
	 djZvcBKAvyxe/yWrfsLG3G/eXJoAXNTJc2eG2R4VY9B59eE9k+DymX3tHHSMk3q4bFLCX
	 CzyQgPlgQ0Vh9gGc9W/Tjjama+yid8lSApAhfAi5+rBeACzBinZ4n1/G5GrR98MQNfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="WwD70/kG";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B46606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WwD70/kG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F71A1F000CA;
	Tue, 24 Nov 2026 17:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795540922;
	bh=RhoE6ABhU1UsJqIZWJopjjssM7UJpQvdNNruj+7vgYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WwD70/kGzhBfMN5cK9R8K2lkJpYjjDdGFOdBO6x7YI147m+JSq9th+uuvQUsxI/XC
	 i4SZ3MJzGrrAnxFFicp/d6a9/bShCfoxwW3lFYtAS22r7ZocTIuWPFwckMrvkp4joY
	 uJxdewEr3RrwblJR+8wW+0ardIEyHKq2SxtVmq7/gRmsV16q29HzP1VeKUyAIYvGwd
	 qIjr7VmtWqNdr0WVYPM4s4dRH+Y3rA/Vl3dZe4AwItVmO/zb0nHd9OpU9k7qTotuWk
	 GVttmUCtHcRGC0GXPbWupDiWh8BOMTI5Y3TX0YICwWHDYKAYdXE6xXfdigF9DoeXgX
	 HAIq1Gno7hQMw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Ray <ian.ray@gehealthcare.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] mmc: sdhci-esdhc-imx: map unsupported driver type to Type B
Date: Tue, 24 Nov 2026 12:21:58 -0500
Message-ID: <20261124172118.1820919-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124172118.1820919-1-sashal@kernel.org>
References: <2026112445-preoccupy-capped-e0f2@gregkh>
 <20261124172118.1820919-1-sashal@kernel.org>
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

From: Ian Ray <ian.ray@gehealthcare.com>

[ Upstream commit d35d93c2902592a84347a15deac4d67a323694c9 ]

Since commit 5a52c5701a67 ("mmc: core: Fix host controller programming
for fixed driver type"), the eMMC driver strength is passed directly to
mmc_set_driver_type(), which propagates the value through ios.drv_type
all the way to sdhci_set_ios().  For value 4, SDHCI correctly warns:

  mmc2: invalid driver type, default to driver type B

The host driver type has no effect on this controller: esdhc_writew_le()
never programs the driver-type field of SDHCI_HOST_CONTROL2.  Hook
set_ios() and force drv_type to the always-valid Type B, so that SDHCI
never sees an unsupported value.

Tested on i.MX8MP (usdhc3, eMMC in HS400) with
`fixed-emmc-driver-type = <4>`: the warning is gone and the HS_TIMING
register contains 0x43 as expected.

Fixes: 5a52c5701a67 ("mmc: core: Fix host controller programming for fixed driver type")
Link: https://lore.kernel.org/all/20260926122908.866-1-ian.ray@gehealthcare.com/
Cc: stable@vger.kernel.org
Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Ulf Hansson <ulfh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 8637ad6bd90a1..baac9ba84d83c 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1078,6 +1078,20 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
 	}
 }
 
+static void sdhci_esdhc_imx_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	/*
+	 * This controller has no driver-type control: esdhc_writew_le()
+	 * discards the driver-type field when writing SDHCI_HOST_CONTROL2.
+	 * The programmed value is therefore irrelevant, but SDHCI rejects
+	 * non-SD values such as 4 (eMMC 40 ohm, from fixed-emmc-driver-type).
+	 * Force an always-valid Type B.
+	 */
+	ios->drv_type = MMC_SET_DRIVER_TYPE_B;
+
+	sdhci_set_ios(mmc, ios);
+}
+
 static void usdhc_init_card(struct mmc_host *mmc, struct mmc_card *card)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
@@ -1721,6 +1735,9 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		host->mmc_host_ops.init_card = usdhc_init_card;
 	}
 
+	/* No SDHCI driver type control */
+	host->mmc_host_ops.set_ios = sdhci_esdhc_imx_set_ios;
+
 	if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)
 		sdhci_esdhc_ops.platform_execute_tuning =
 					esdhc_executing_tuning;
-- 
2.53.0

