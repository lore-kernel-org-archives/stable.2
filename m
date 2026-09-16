Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C038F3E1D1D
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 20:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789590788; cv=none; b=FMsWKNcnUFkB5+hSMPTfcPSsUN4Pldo8w6XZAgjmwCMABRkEBpgYn+Lp/Xe9AV1S3dncxcuAPmjktSr6l132PgMVPcY/xbFZNqD2YqP6uyoBX9ETRpPMBqhgixkknrs8J5uQni3cvWiG+sQcYBc2v5NEU68j3dssVE7zl06gmvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789590788; c=relaxed/simple;
	bh=NxscD3Uc8RXrpxeJPI3Nt1NLauWvQnRAYIVqQ1S47dU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VHMrSD3HwpL7nRD8RMQH6xH9VqCX2b9Vv78kBAOdRZPjM7cWB1AdjdONMDFKeU79LB2oG6seTqadxDjDe/XW6OnpzkzyeGw2SmBHHQy5xFLMf+hsdj7BgPNwzpAUvcZf8WwRearG/N16dE0gB37acaSKhSl9TUqc88+/kZYUg/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLu180Wx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLu180Wx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949BF1F000FF;
	Wed, 16 Sep 2026 20:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789590776;
	bh=DGPHba78ED0p/InVvdy0h6HjQSWrwe6XoD54PB5l0j0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OLu180WxSBFe4tSElFGwPfL/ZYh6STDpoaDKp9DA8gH/kXY6ZE2hN1k8rQjuwVHyU
	 8u2m9jFFXXcAj1tCrvBEqpO2lalfL3MKHHTtxa/7xHANWsvoH0A+1HuoZEVrj8hoD5
	 jBfg+rPKo57TLCs3SIoCfoaPPy2iluOuOMZwO/fMVVoHi+uzhiQXb0VBrnib8c1KGh
	 8Age3gAiWQlwvPBpUJi4mtPOqchSpFYXAypiN3A3mfGjQ0hz5aiAmuDltI3cIQtfI4
	 9ky10Ec6aOqnD/Hag5jV7PdhG4tc0pUuynL2M6/OleNfhMfINalEp4cgMDdPdID9B7
	 Cfp8CMEUdItyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] EDAC: altera: merge ARCH_SOCFPGA and ARCH_STRATIX10
Date: Wed, 16 Sep 2026 16:32:52 -0400
Message-ID: <20260916203254.2573996-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091624-rethink-safeness-e66f@gregkh>
References: <2026091624-rethink-safeness-e66f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

[ Upstream commit 098da961d8b8c279d34a8f7cd26ff0317f718df6 ]

Simplify 32-bit and 64-bit Intel SoCFPGA Kconfig options by having only
one for both of them.  This the common practice for other platforms.
Additionally, the ARCH_SOCFPGA is too generic as SoCFPGA designs come
from multiple vendors.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Stable-dep-of: 9868f5c077df ("EDAC/altera: Use parent device for devres in altr_portb_setup()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/Kconfig       |  2 +-
 drivers/edac/altera_edac.c | 17 +++++++++++------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 7a47680d6f078..cb7629f73873f 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -395,7 +395,7 @@ config EDAC_THUNDERX
 
 config EDAC_ALTERA
 	bool "Altera SOCFPGA ECC"
-	depends on EDAC=y && (ARCH_SOCFPGA || ARCH_STRATIX10)
+	depends on EDAC=y && ARCH_INTEL_SOCFPGA
 	help
 	  Support for error detection and correction on the
 	  Altera SOCs. This is the global enable for the
diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 63fea769b99ac..53d1b1fc07a50 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1509,8 +1509,13 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 	dci->mod_name = ecc_name;
 	dci->dev_name = ecc_name;
 
-	/* Update the PortB IRQs - A10 has 4, S10 has 2, Index accordingly */
-#ifdef CONFIG_ARCH_STRATIX10
+	/*
+	 * Update the PortB IRQs - A10 has 4, S10 has 2, Index accordingly
+	 *
+	 * FIXME: Instead of ifdefs with different architectures the driver
+	 *        should properly use compatibles.
+	 */
+#ifdef CONFIG_64BIT
 	altdev->sb_irq = irq_of_parse_and_map(np, 1);
 #else
 	altdev->sb_irq = irq_of_parse_and_map(np, 2);
@@ -1528,7 +1533,7 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 		goto err_release_group_1;
 	}
 
-#ifdef CONFIG_ARCH_STRATIX10
+#ifdef CONFIG_64BIT
 	/* Use IRQ to determine SError origin instead of assigning IRQ */
 	rc = of_property_read_u32_index(np, "interrupts", 1, &altdev->db_irq);
 	if (rc) {
@@ -1936,7 +1941,7 @@ static int altr_edac_a10_device_add(struct altr_arria10_edac *edac,
 		goto err_release_group1;
 	}
 
-#ifdef CONFIG_ARCH_STRATIX10
+#ifdef CONFIG_64BIT
 	/* Use IRQ to determine SError origin instead of assigning IRQ */
 	rc = of_property_read_u32_index(np, "interrupts", 0, &altdev->db_irq);
 	if (rc) {
@@ -2021,7 +2026,7 @@ static const struct irq_domain_ops a10_eccmgr_ic_ops = {
 /************** Stratix 10 EDAC Double Bit Error Handler ************/
 #define to_a10edac(p, m) container_of(p, struct altr_arria10_edac, m)
 
-#ifdef CONFIG_ARCH_STRATIX10
+#ifdef CONFIG_64BIT
 /* panic routine issues reboot on non-zero panic_timeout */
 extern int panic_timeout;
 
@@ -2118,7 +2123,7 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 					 altr_edac_a10_irq_handler,
 					 edac);
 
-#ifdef CONFIG_ARCH_STRATIX10
+#ifdef CONFIG_64BIT
 	{
 		int dberror, err_addr;
 
-- 
2.53.0

