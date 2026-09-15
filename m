Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B3548095B;
	Tue, 15 Sep 2026 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461740; cv=none; b=pDIetub63AjeoayJoXAC8ZM23zDbkLwjF7hBz14kEXfMMsGi8PnkM+iZ0u1eEQ/TSFwNfLNCc+R3+jYYIWgCWvkLNSaxuIK/XWHNbQ6o9iPDXU/CXJ2DOxGEg59jn9z3Blnv9Sxu/Caw4JI1A5E0WkQsB6DjxiyJ36xj8LANB7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461740; c=relaxed/simple;
	bh=8EJ68XPeVuYFp1C8oU4jQJaTpagNyLdBOct1BN5hd4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2uSNDiCmvCYmOqC7Yudgdkjxw3QchzF0590dhUWkruZI+LQkAPhVleKk74gjhJ+SAPVzyxTE6iPE0bGtrra64RipgIqoTVKcAatckEgPtcXLycsXHe/+CzvT1YzmzJ6Flf+D7x8PZq6HJGs/38s1ERcfuzeoAvaaiShfHL4WlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AblIf0o/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AblIf0o/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A521A1F008A7;
	Tue, 15 Sep 2026 08:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789461738;
	bh=YLzTTSKqcUGI5YoRs66MDTCcZ6UV130NH8vDO7DaOrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AblIf0o/gnNCCRA1xWIISgtF5uBZy2TjI+UMwTFBJ6YH93WA9rnzCOND1Nh0TG5Ln
	 bcGtBocqr2+UbUPCXqome6W/pINimZY0eOefGP3oqwCUQtVENM8GNGTIk08b8boNop
	 zErQO6IbGRPTK6MineBP0kRKeX2jTDCGV5FordkCiM8Y9qQ/Pgk+rGj3OeV6Sbu9Y7
	 kh484t0ZriNdQxW8BrM3y8ey2S1QfvlJTUUufvtycfurzk+bVcFrgsa1vRVeDtxwFu
	 9KjXJWdLBo+EwQ8yBSaw0X0NavjXPtVhlvf2z3wDjZ8K/m0wDx1lJzLsLp3PbYueTQ
	 /8MSXB3gngVxQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Baokun Li <libaokun1@huawei.com>,
	Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc: Brian Norris <computersforpeace@gmail.com>,
	stable@vger.kernel.org,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH v5 3/6] ata: sata_fsl: Fix use-after-free of host_priv on probe() failure
Date: Tue, 15 Sep 2026 10:41:29 +0200
Message-ID: <20260915084127.692494-11-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915084127.692494-8-cassel@kernel.org>
References: <20260915084127.692494-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2874; i=cassel@kernel.org; h=from:subject; bh=8EJ68XPeVuYFp1C8oU4jQJaTpagNyLdBOct1BN5hd4g=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJWsuzNsuUXlnw0+fL8k085GqV0e0qahZl4jtvGCOUsn 8y1vrmjo5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpABNpXszwh6+ueBXzs4o3C3Pm rs/hOy0h9Porv9EBJvZpj9TmZGkvD2f4K328UIhdr45vilPA37nt3dfmPbtwT+pz0baHqie4uIr EOQA=
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
devres action which ata_host_start() registers, so it is called both when
the device is unbound and when probe() fails after the host has been
started.

The error_exit_with_cleanup label of sata_fsl_probe() releases hcr_base
and host_priv as well, and it is reachable from the two
device_create_file() calls which are done after the host has been
activated. In that case sata_fsl_host_stop() runs on an already freed
host_priv, resulting in a use-after-free and a double iounmap()/kfree().

Add a separate error label for the failures happening after the host has
been activated, which only detaches the host and leaves hcr_base and
host_priv to sata_fsl_host_stop().

Note that ata_host_detach() is dropped from error_exit_with_cleanup, as
that label is now only reachable while host is still NULL.

Fixes: 6c8ad7e8cf29 ("sata_fsl: fix UAF in sata_fsl_port_stop when rmmod sata_fsl")
Cc: stable@vger.kernel.org
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/sata_fsl.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 70b210afd291..4037dd758f87 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1500,7 +1500,7 @@ static int sata_fsl_probe(struct platform_device *ofdev)
 	host_priv->intr_coalescing.attr.mode = S_IRUGO | S_IWUSR;
 	retval = device_create_file(host->dev, &host_priv->intr_coalescing);
 	if (retval)
-		goto error_exit_with_cleanup;
+		goto error_exit_detach;
 
 	host_priv->rx_watermark.show = fsl_sata_rx_watermark_show;
 	host_priv->rx_watermark.store = fsl_sata_rx_watermark_store;
@@ -1510,16 +1510,24 @@ static int sata_fsl_probe(struct platform_device *ofdev)
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

