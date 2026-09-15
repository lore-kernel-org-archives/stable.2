Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92785480323;
	Tue, 15 Sep 2026 08:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461738; cv=none; b=OsjWC8mvRiIaPzNluRAaUdNTnkFbfLQRWRFD2Djnl3bRCHB6Wi/V3TOCwpmOjJtkXZApDV0gxsK6MqBLDpKnunXfB/pDQEemfTyNxYBs0MWbPY/BmY6DZDfkozz5rbYLMzaj6r8J5SgLqE247PXPbjaBEgaO1r7KiY9wQHAQlZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461738; c=relaxed/simple;
	bh=YZJR2tIT7pbBbYPsCeMhf5rqcC+ztQz0Wi1vqmrKYr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDbyjtKpXvWITcvA4yyRkqXuDvG7i0YFK6vWc8vcp/Kranzot3w45VXar3wbudeV5XcCgDHYTFjw0d7lZhLlGVsj5SM9f7uMKOrTP4u7Auv6m934wUxgZj+CE9DRsE6ER0FCpf1kBOAc/7dMGZpV1KyzOIMNppp95Cp0MdKqJeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlOLn+l+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlOLn+l+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C15E1F000FF;
	Tue, 15 Sep 2026 08:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789461735;
	bh=cOsw/m3GL9gXbzk7Znz3+GQLWlGq3cfffQGQYnG51zY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KlOLn+l+hrXwfrB9EmCz7cwc9EiQukPRjo9k4xAM3ErD9rtgC1KWptSh7Vp53L7A0
	 0TcLL/erNb0lFyeLHpMTls8D0nFv6jGDEKJC153m1svJvygP7i/emMPhRdJImB7zad
	 fYzQi126N3B/tIrTUPWzcZ7gbcUIsv66p3r3/P/swnStfOrzMU6k8SqGCpd0Y3l2U3
	 3WADA0NJQIOmrfDR8PkLGZgxlG787sdRbPne72a0WO7LsKaEOZJJfIz8H2wyX54Wfr
	 Fn56G4xQnHa4S/W7upN8CUOLCUJUx8hJ4XKl5bY9DrlNXbH9r/uNBeeVbnz/BqzKnk
	 j84qadiyN7KTg==
From: Niklas Cassel <cassel@kernel.org>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Alexandre Torgue <alexandre.torgue@st.com>,
	Tejun Heo <tj@kernel.org>,
	Lee Jones <lee@kernel.org>
Cc: Brian Norris <computersforpeace@gmail.com>,
	stable@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-ide@vger.kernel.org
Subject: [PATCH v5 2/6] ata: ahci_st: Assert the power down reset in the probe() error path
Date: Tue, 15 Sep 2026 10:41:28 +0200
Message-ID: <20260915084127.692494-10-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915084127.692494-8-cassel@kernel.org>
References: <20260915084127.692494-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3471; i=cassel@kernel.org; h=from:subject; bh=YZJR2tIT7pbBbYPsCeMhf5rqcC+ztQz0Wi1vqmrKYr0=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJWsuzdldhv/phZ4Vb906zuoumR/3YXyExwLw2Q2Sqc0 id16JJ5RykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACbCPJeRYe6mp86VPZ/7Xr5x +Oz9/sy7tBfvD3+x7ux3PL2Pcd3xv88YGbayFfVkaGouNs/Oulu0qOjOG9afvu3epXnK2y7PtJv oyAkA
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

Factor the assert out into st_ahci_assert_pwrdwn() and call it when
either ahci_platform_enable_resources() or ahci_platform_init_host()
fails. The "pwr-dwn" reset control is an exclusive one, so asserting it
once more from st_ahci_host_stop() is harmless.

No functional change intended for ->host_stop() and st_ahci_suspend().

Fixes: 76884cb2f7da ("ahci: st: Add support for ST's SATA IP")
Cc: stable@vger.kernel.org
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/ahci_st.c | 51 +++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/drivers/ata/ahci_st.c b/drivers/ata/ahci_st.c
index 819269a022ef..eea75961038c 100644
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
@@ -159,38 +168,38 @@ static int st_ahci_probe(struct platform_device *pdev)
 
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

