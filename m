Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF2953CA9F;
	Thu, 10 Sep 2026 17:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789060505; cv=none; b=Rpq0RkZBtu1TNcCN47kiwaHICvcxGeZTTwRV4g1i38d10ef7e8l7fAVnTw6a39sA+BQtOTre2kTe6T6yGjElOJyAPfhFXu2M1bWpJnd0RrGjWfJA2AmMWDDkOwuEl4QTzgb5UhGZHWtBpVostCyLy28KmB8hlhDqBz/ySLgVbqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789060505; c=relaxed/simple;
	bh=fKTOtmPUPP2FufuVHDtWL32druhZuLX+4RkIhmDA6VY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2hjoqfhHbGy+gAGLuqmo2LienlaA3ClrLnwug2BAuXy4pnk5S7H9P4aZ65Ik+BxpPaecuoFDGuWPEbSkvdsxm6qSsc1u2kBhLsM2gxVO19VSI4JxWEKGWzO2M45BZbF1Q094YoWmXips00G3qoZ+/4TdaYLZh6HpkKVGYCqeGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNTq1Rhn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNTq1Rhn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00EF81F00893;
	Thu, 10 Sep 2026 17:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789060489;
	bh=ciRO7qdgc6SP2XTdRh18i+0iJ9FE+yjAHMx1vxl8usY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UNTq1RhnIqHEQo0B4aHWFznXu75naAp4HXa9wkBR2PhQjLkYaXsPi9rAVGoiXbmO9
	 U61lDFHviNcBRlO2qR1/q5dakrayHWrB6mlYv2EIOR5kIRDmVzWT8B+CsgrLCZBaUG
	 pp++JqkC/sKArvE2cDDZ/MA8zxxf9gxnjtItbUdq+peUfWNCLls+n56UTD5tnOk3wJ
	 wTRzO6rdOhYLkynNYOz8/LjlWcbWDxQcUILGn5O2hsYpp1UhUixtwi2katgBHmSLjZ
	 RHt/tyIAfqhVzVElA7jfW4aAncDJToHiI3WGJMzIW8Nhq1bgEAxpTLQ0Yf/7wpZgmf
	 aQlafbeyamt0w==
From: Niklas Cassel <cassel@kernel.org>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Tejun Heo <tj@kernel.org>,
	Alexandre Torgue <alexandre.torgue@st.com>,
	Lee Jones <lee@kernel.org>
Cc: Brian Norris <computersforpeace@gmail.com>,
	stable@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-ide@vger.kernel.org
Subject: [PATCH v4 1/5] ata: ahci_st: Assert the power down reset in the probe() error path
Date: Thu, 10 Sep 2026 19:14:07 +0200
Message-ID: <20260910171406.131211-8-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910171406.131211-7-cassel@kernel.org>
References: <20260910171406.131211-7-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3370; i=cassel@kernel.org; h=from:subject; bh=fKTOtmPUPP2FufuVHDtWL32druhZuLX+4RkIhmDA6VY=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLIWPc3gbFq+w5j9X7jUad8mt//vBX7FTrrVVST2N+PA0 mvvQw1udZSyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAia14yMjw0v/Lz9FuXQH9t nb0nOies3f4vcuWzqfoRzR/c7/axnY5hZFgrbjmPs1Gy0UPjwZH3Ko+WeX3562nUZ37FyzJN6yd rJRsA
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

