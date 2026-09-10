Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E33353FD44;
	Thu, 10 Sep 2026 17:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789060503; cv=none; b=SHFOCUnaMuvq5+0vs2shLmRtB9udkNgJaDCfEI6A6jwqMkuCvtCXPKh9Vai0IKOmP6q2HRiLeA0E94+wptBPi8S3S3Sn4RRVLXUfBZjKgB7TkE6PoPR3Q6BrndLP9KXifcNIK0+MH+Z8UWmH1Ase/9WV8wVtFCIPsHZ4b2XwrEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789060503; c=relaxed/simple;
	bh=JMC6MPA1oWN5baCwI5B/aIihLZfaV+zH4Vykb/mkMGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFaiD9sm0luxDs48FPWmD/o7p5cDX+qz5gfWbtBu71Lq8meC4G5BVJc6jmuCZLg8OmDMmBUQjz9k9FxdtXyikuxPSUgdBMlfAczQm3/9hFrcODJKV2OUBzLxKXh2UAi66pQFO2PFPNs6yT+vRd5zX/9m00KL5hMXrjRAqYDirkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wrl+SJC1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wrl+SJC1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425B71F00899;
	Thu, 10 Sep 2026 17:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789060492;
	bh=UlUbVhdQZn+O2KrOLNgw6YNZN5YE9yn3nqr4NVKynok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wrl+SJC1U0Q47G4hsTcjuVPZlqzB4ECeyHoWLy4VlJG69HGFQdE3UaazUmEHDPzbU
	 w0fqI0A3HOPHK7ifha+QBEQ3cpsJdiaCjQ/L8J8q+FkwptzcBxfzHJA8k4Dt4SNjlM
	 wuJa+q6cuhF+Sq5+Exmb+0OZG0ykRQphKRmeAVwkLdHcq6NbPiH+AeEpyVs3U5AsFL
	 68Vww9xBEscz0+02F3ssL45x1G69M81xkiy87BDpH4cStisxGLFyNVZcxIhb1CkZ10
	 Tj7d7qGp+1yBMqd1BKJcFPi+w+6UIYtRsJtewgfsY2fM9N9RCHbcXJjOgSMLKU8Zkd
	 aROdwD27lbmvA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Baokun Li <libaokun1@huawei.com>,
	Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc: Brian Norris <computersforpeace@gmail.com>,
	stable@vger.kernel.org,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH v4 2/5] ata: sata_fsl: Fix use-after-free of host_priv on probe() failure
Date: Thu, 10 Sep 2026 19:14:08 +0200
Message-ID: <20260910171406.131211-9-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910171406.131211-7-cassel@kernel.org>
References: <20260910171406.131211-7-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3716; i=cassel@kernel.org; h=from:subject; bh=JMC6MPA1oWN5baCwI5B/aIihLZfaV+zH4Vykb/mkMGg=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLIWPc3YOS008S+vmaHDZFunJwu5bS3DPkpLF1aaeD6yn ZFaVbW6o5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpABNxmsvIcPvqftPjx7e8klx4 OnxKqZ6Wct0eFr7NTO0aiZk2Wx4/nszwz+JZts6GnhyPGYtUYlfbrOFY+ftZ+I7o9lU+R+wKQyZ /4gUA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

sata_fsl_host_stop() releases hcr_base and host_priv:

	static void sata_fsl_host_stop(struct ata_host *host)
	{
		struct sata_fsl_host_priv *host_priv = host->private_data;

		iounmap(host_priv->hcr_base);
		kfree(host_priv);
	}

->host_stop() is called by the driver core through the ata_host_stop()
devres action which ata_host_start() registers, so it is called both
when the device is unbound and when probe() fails after
ata_host_activate() has started the host.

The error_exit_with_cleanup label in sata_fsl_probe() releases hcr_base
and host_priv as well, and it is reachable from the two
device_create_file() calls done after ata_host_activate(). In that case
sata_fsl_host_stop() runs on an already freed host_priv, resulting in a
use-after-free and a double iounmap()/kfree().

sata_fsl_probe() also ignores the return value of ata_host_activate(),
so probe() returns success even if activating the host failed.

Check the return value of ata_host_activate() and, once the host has
been activated, leave hcr_base and host_priv to sata_fsl_host_stop().

Note that if ata_host_activate() fails inside ata_host_start(), e.g. if
sata_fsl_port_start() fails, ->host_stop() is not registered and
hcr_base and host_priv are leaked. Leaking them is preferable to freeing
them twice, and this is addressed by a later patch in this series.

Fixes: 6c8ad7e8cf29 ("sata_fsl: fix UAF in sata_fsl_port_stop when rmmod sata_fsl")
Cc: stable@vger.kernel.org
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/sata_fsl.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 70b210afd291..2123da66dc3c 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1490,8 +1490,10 @@ static int sata_fsl_probe(struct platform_device *ofdev)
 	 * device discovery process, invoking our port_start() handler &
 	 * error_handler() to execute a dummy Softreset EH session
 	 */
-	ata_host_activate(host, irq, sata_fsl_interrupt, SATA_FSL_IRQ_FLAG,
-			  &sata_fsl_sht);
+	retval = ata_host_activate(host, irq, sata_fsl_interrupt,
+				   SATA_FSL_IRQ_FLAG, &sata_fsl_sht);
+	if (retval)
+		return retval;
 
 	host_priv->intr_coalescing.show = fsl_sata_intr_coalescing_show;
 	host_priv->intr_coalescing.store = fsl_sata_intr_coalescing_store;
@@ -1500,7 +1502,7 @@ static int sata_fsl_probe(struct platform_device *ofdev)
 	host_priv->intr_coalescing.attr.mode = S_IRUGO | S_IWUSR;
 	retval = device_create_file(host->dev, &host_priv->intr_coalescing);
 	if (retval)
-		goto error_exit_with_cleanup;
+		goto error_exit_detach;
 
 	host_priv->rx_watermark.show = fsl_sata_rx_watermark_show;
 	host_priv->rx_watermark.store = fsl_sata_rx_watermark_store;
@@ -1510,16 +1512,24 @@ static int sata_fsl_probe(struct platform_device *ofdev)
 	retval = device_create_file(host->dev, &host_priv->rx_watermark);
 	if (retval) {
 		device_remove_file(&ofdev->dev, &host_priv->intr_coalescing);
-		goto error_exit_with_cleanup;
+		goto error_exit_detach;
 	}
 
 	return 0;
 
-error_exit_with_cleanup:
+	/*
+	 * Once the host has been activated, hcr_base and host_priv are
+	 * released by sata_fsl_host_stop(), which is called by the driver core
+	 * through the ata_host_stop() devres action registered by
+	 * ata_host_start(). Releasing them here as well would result in a
+	 * double iounmap() and a use-after-free.
+	 */
+error_exit_detach:
+	ata_host_detach(host);
 
-	if (host)
-		ata_host_detach(host);
+	return retval;
 
+error_exit_with_cleanup:
 	if (hcr_base)
 		iounmap(hcr_base);
 	kfree(host_priv);
-- 
2.55.0

