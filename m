Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D64847DFA0;
	Thu, 10 Sep 2026 12:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789042757; cv=none; b=bk3OrxAp1n9g3OyfdGsjLGc31zbRq/ZzEnu3KM/0B9kPKd4rSs+hVbHIYI9HZPsWKdfqzk+a4vtefmRxSgn7CqbZQX4xf1CDVMg4oSzadj3ReWcTgJRfeDXXYyslyli7//BeVxCkZo8F2d3HkO3reQf0aQxBSKcDIXL1vIdwUqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789042757; c=relaxed/simple;
	bh=fKTOtmPUPP2FufuVHDtWL32druhZuLX+4RkIhmDA6VY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OPU6a9NSw0fvhjVFl3p7j0OIrALffnNkWvKt/l7Eqc7orYREY6mswbg3QKLsRXIJz65XW1jDS2zpXbq+jSGVOP1wZazWRIalmWi46I8Oj4a73SBpt+YL58PLaXlgwPanWUbV1b9AQXccLO42zdqZQ0fkeOB2omR7ZiATMgE/ES4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cbf+5fkD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cbf+5fkD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4531F00893;
	Thu, 10 Sep 2026 12:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789042754;
	bh=ciRO7qdgc6SP2XTdRh18i+0iJ9FE+yjAHMx1vxl8usY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cbf+5fkDJT78ez1yp5eh+bN7UcTSRDuFhD8bTm6VzZCYTyziuPwsciVNhZqsAu+sP
	 BIs8ez5U8bg21VzKbBYn7V7PP1di3f/rkqtuZKbDsWrJeyTuhRs4DZJiTxQFLkOWcq
	 7JcZnzEDcajXiqQFk7YtvQzdRAZvMBmdPKn4IIc2E2TfH8yAiap+UMdkAmWZSmz0X7
	 XE5nGIIi84HSHvcI2174SU0pnglB/xhifyAR2WEbR/A4s1OsB8Psr7PYqD6rYoVtM4
	 f2TmtRIdovIHmZFp5JtRu0ueMcKnuWmo7/MrNFh0YW95N3ydkYC2IB2POM3E6gyFvN
	 22VREX8BVsKFw==
From: Niklas Cassel <cassel@kernel.org>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lee Jones <lee@kernel.org>,
	Alexandre Torgue <alexandre.torgue@st.com>,
	Tejun Heo <tj@kernel.org>
Cc: Brian Norris <computersforpeace@gmail.com>,
	stable@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-ide@vger.kernel.org
Subject: [PATCH v3 1/3] ata: ahci_st: Assert the power down reset in the probe() error path
Date: Thu, 10 Sep 2026 14:19:01 +0200
Message-ID: <20260910121900.97676-6-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910121900.97676-5-cassel@kernel.org>
References: <20260910121900.97676-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3370; i=cassel@kernel.org; h=from:subject; bh=fKTOtmPUPP2FufuVHDtWL32druhZuLX+4RkIhmDA6VY=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLIWLTDhbFq+w5j9X7jUad8mt//vBX7FTrrVVST2N+PA0 mvvQw1udZSyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAiehkM/yxVir2vcCg0b9zD L3KkdN2BUH5md5O5L//+9E7yqr+Wp8DI8Pzhtg9BIWeu7Fqetqbgvua/fOu2rXItkbK8vRINO8X COQE=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

st_ahci_probe_resets() deasserts the "pwr-dwn" reset, but the probe()
error path of st_ahci_probe() only releases the host resources, so the
SATA IP is left powered up when probe() fails after
st_ahci_probe_resets() has succeeded, e.g. when
ahci_platform_enable_resources() fails.

The reset is asserted by st_ahci_host_stop(), however ->host_stop() is
only called through the ata_host_stop() devres action registered by
ata_host_start(), so it does not cover any failure happening before the
host has been started.

Factor the assert out into st_ahci_assert_pwrdwn() and call it from both
probe() error paths. The "pwr-dwn" reset control is an exclusive one, so
asserting it once more from st_ahci_host_stop() is harmless.

No functional change intended for ->host_stop() and st_ahci_suspend().

Fixes: 76884cb2f7da ("ahci: st: Add support for ST's SATA IP")
Cc: stable@vger.kernel.org
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/ahci_st.c | 51 +++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/drivers/ata/ahci_st.c b/drivers/ata/ahci_st.c
index 4336c8a6e208..39ebedf93344 100644
--- a/drivers/ata/ahci_st.c
+++ b/drivers/ata/ahci_st.c
@@ -83,18 +83,27 @@ static int st_ahci_deassert_resets(struct ahci_host_priv *hpriv,
 	return 0;
 }
 
-static void st_ahci_host_stop(struct ata_host *host)
+static int st_ahci_assert_pwrdwn(struct ahci_host_priv *hpriv,
+				 struct device *dev)
 {
-	struct ahci_host_priv *hpriv = host->private_data;
 	struct st_ahci_drv_data *drv_data = hpriv->plat_data;
-	struct device *dev = host->dev;
 	int err;
 
-	if (drv_data->pwr) {
-		err = reset_control_assert(drv_data->pwr);
-		if (err)
-			dev_err(dev, "unable to pwrdwn\n");
-	}
+	if (!drv_data->pwr)
+		return 0;
+
+	err = reset_control_assert(drv_data->pwr);
+	if (err)
+		dev_err(dev, "unable to pwrdwn\n");
+
+	return err;
+}
+
+static void st_ahci_host_stop(struct ata_host *host)
+{
+	struct ahci_host_priv *hpriv = host->private_data;
+
+	st_ahci_assert_pwrdwn(hpriv, host->dev);
 
 	ahci_platform_disable_resources(hpriv);
 }
@@ -162,38 +171,38 @@ static int st_ahci_probe(struct platform_device *pdev)
 
 	err = ahci_platform_enable_resources(hpriv);
 	if (err)
-		return err;
+		goto assert_pwrdwn;
 
 	st_ahci_configure_oob(hpriv->mmio);
 
 	err = ahci_platform_init_host(pdev, hpriv, &st_ahci_port_info,
 				      &ahci_platform_sht);
-	if (err) {
-		ahci_platform_disable_resources(hpriv);
-		return err;
-	}
+	if (err)
+		goto disable_resources;
 
 	return 0;
+
+disable_resources:
+	ahci_platform_disable_resources(hpriv);
+assert_pwrdwn:
+	st_ahci_assert_pwrdwn(hpriv, &pdev->dev);
+
+	return err;
 }
 
 static int st_ahci_suspend(struct device *dev)
 {
 	struct ata_host *host = dev_get_drvdata(dev);
 	struct ahci_host_priv *hpriv = host->private_data;
-	struct st_ahci_drv_data *drv_data = hpriv->plat_data;
 	int err;
 
 	err = ahci_platform_suspend_host(dev);
 	if (err)
 		return err;
 
-	if (drv_data->pwr) {
-		err = reset_control_assert(drv_data->pwr);
-		if (err) {
-			dev_err(dev, "unable to pwrdwn");
-			return err;
-		}
-	}
+	err = st_ahci_assert_pwrdwn(hpriv, dev);
+	if (err)
+		return err;
 
 	ahci_platform_disable_resources(hpriv);
 
-- 
2.55.0

