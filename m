Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795541594;
	b=uKprtTDgHAX3vfFTSUJBPdQX/gpVOkavUWEfESjGcme6+4CQGbYgYyN8OHrK2uvpiJfX
	 5m0hwwC/0IUUZMfcleYyRzcwxrYd8sbhrTOA+rLmXwMUYzDBNDohNsN4fscSZc2X3fgNi
	 B/v0NljnQ+404Ria60EzXrjFa4xoApXJDVBhBn+BOyr3NJo1EKYHs3BhfZ3G5WPf+X8pn
	 29M9ghiwhltpSps6yHYrCgw49gRjQ0cfEAdUfh++2Ybq8z2vuvJISTsGw1ACETW6EuTNt
	 J11HHDZvKbfRhTjtzn7wUFTRswcoMeK+UK/bNk1Bb8EYxK9LPI+UoxjTiWdgNNNqEYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541594;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=btLf8DwtGC2+ScoNJ4jVSnhrEjvDT0vyo3gW2DWZJRg=;
	b=N+/o8qjaDyKUE90Okn2KTGwk+eZ1ATVItEl3Fxh/GCDY1EXtNPub9L40QtAI9nZt7VWg
	 4MoGSXl9cByciArYYID2lj79HVWkJXm9aIr+CYj56hnJ/spGBaD39h94ZHwY/lYbonXbS
	 a/rRApo5sAqS681qG0fjmVfaoHnTCot1eOKt8mVXe9E0rHylyp7LdP/sHb2D8lKGs6F/Z
	 +8gcgT8dRI03GkRoS6LqXPU/mMmYsBzr7lnHJ4r+fFrV5kE3BV16rQfwvRqJ/mMfCy9CQ
	 M5WWU/JgcvWXNtiW9Boa1mQ9rOaJXx41FVlP6KTj06PFIdyIk8GnG48kQEgxhvdCaDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HRF2nKf8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A1F606A33C
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HRF2nKf8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892D41F00ADE;
	Tue, 24 Nov 2026 17:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795541593;
	bh=btLf8DwtGC2+ScoNJ4jVSnhrEjvDT0vyo3gW2DWZJRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HRF2nKf8NdExQfXqPeEd7ievgJorP53uKGP32DjRcfd3VAyCuYmY/zSsctNl56Yqn
	 I1KAGdLzmrXpNbLL1F/s8NMP5vmtEWTTbiV0Kil/AzVvNoJOLwADv107SH9AcowrPD
	 KYa2ysm9JLVyzvr5dxKIfYacKWwZ/o6u7IIHs9b80fwKYl7cJ11nAjESCsmbhIHjfu
	 Fdzbj7mDQi+Q4849sw3h65AqNZE4SNab2EX8Wrjbi15VV4S3qj2zgRqRV7ZizcLcIZ
	 42lwtUey5WExmDVfqwwnxLfW90zmjXaHonYZopPXDhFjAF6CA61t7ZT+rwsJL9EOeC
	 ZNIysGtMSTI8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Ray <ian.ray@gehealthcare.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mmc: sdhci-esdhc-imx: map unsupported driver type to Type B
Date: Tue, 24 Nov 2026 12:33:11 -0500
Message-ID: <20261124173112.2014464-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112445-unviable-busload-101a@gregkh>
References: <2026112445-unviable-busload-101a@gregkh>
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
[ sashal: Hunks were placed by hand with different context: the new set_ios function goes before esdhc_reset_tuning() (no usdhc_init_card() here), and the probe hook goes after the probe_dt error check. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index b030f657e2534..d032f5d5aed20 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1137,6 +1137,20 @@ static void esdhc_set_strobe_dll(struct sdhci_host *host)
 		"warning! HS400 strobe DLL status REF/SLV not lock in 50us, STROBE DLL status is %x!\n", v);
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
 static void esdhc_reset_tuning(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -1623,6 +1637,9 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	if (err)
 		goto disable_ahb_clk;
 
+	/* No SDHCI driver type control */
+	host->mmc_host_ops.set_ios = sdhci_esdhc_imx_set_ios;
+
 	if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)
 		sdhci_esdhc_ops.platform_execute_tuning =
 					esdhc_executing_tuning;
-- 
2.53.0

