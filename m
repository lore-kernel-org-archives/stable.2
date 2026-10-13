Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBA6471CF2
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 02:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791860280; cv=none; b=ML7Kmk3ihJsa6I3GWs8qR5DCAAWsAyGJcK1Ffyg9BmR9vvjgF7Vwwr9i7AccO3gJXoEWy+Kf/QAHiKA73aY+/P0OpPu3sM1LHDnQhJkoijlZI75FxIlQV4D6v4HjpN9vTYeXUA05evHvClV6zCwE8ya4mM0rL1AHs2XWi1qbAPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791860280; c=relaxed/simple;
	bh=VSJJkJiLisOd14jzU3NtN+1l4ORk3Rz7Onx0RA8eoDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PgqD7AcYclBXPndPmx+a50Kc8rJUodBmX0NJgjqgSOlkgyPUjnOqsRtZMR/nuC6IToPYp8xz8mQ3XrarYE+Rh/eJ9M4bdUw9fu/HfD2J44xvqcfxU/IXJ6sr8Fls9OvClMsQ+2rIrorlDC+Q+nKudYdsVJ+VQESxsyRZrbvk+YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=octane.security; spf=pass smtp.mailfrom=octane.security; dkim=pass (2048-bit key) header.d=octane.security header.i=@octane.security header.b=QKJZ48dz; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=octane.security
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=octane.security
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=octane.security header.i=@octane.security header.b="QKJZ48dz"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1517bda04a0so1236873c88.0
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 19:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=octane.security; s=google; t=1791860278; x=1792465078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+AztMa9ZkTcAA+tH8ZRmmfmqDCx4w5BgOfCE+Z46tQA=;
        b=QKJZ48dzlGZWIDcDiqTsVdi8A/TQnffGLLjgpO6Xxrx/eOB3P1Ln8K5qWNDSUAMDme
         1XnaBQbKrA94jqTyPEjUjK5cFKs5do/8j9/zuZTBzIidsGmgtzvMCndTYtE7wuBHLCUK
         DQx9ppZhi7GVEv/Oa/hrERop9k8GL7oedy76DsPMtihCUURP7mloUfaagOQXno7u9BUM
         MalJSSdz/ulXHLpLt/BlYk0eiwdF0DJkrmIAVoG3E2wuh3WSjuxVIWmLhhTdLwEST12y
         6cYL9+2NSjREafk4lEsRlR9TKn97D8JQJPJ41g/tlnI8nlw4AsUduPs4PzaMul7wpw/S
         MQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791860278; x=1792465078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+AztMa9ZkTcAA+tH8ZRmmfmqDCx4w5BgOfCE+Z46tQA=;
        b=tlLJwOTd2mark9B/it5Hsq2LwN8BxcteCdfSTzRDxhxu/KP2fqpSBQ3+oC38xVOfNz
         XC9rG/8MAUrKzabK84SxhVs1wkes3iAMnCL401pdLeRN1a7vHm89YNDXqyzHFhirIjDd
         G6hj+V0kOEYvtWt/MmDBqsM26noVbLpBKaiihVJohgwDhIj9pp6yTti3aYL3Z6X107BQ
         NmETjaCcuYYkm6yvDhRYqKrnQI0XnPVXMxKuV+jiRuBniHVtkhuVFSoMgJtfrMbZBw/9
         43ghhJZf1oFc3Eu0+qpe7oW3ylgvQ7Soz+ROjOgTPfJI4lkXhaAnoTX7TWr1M1AevVgM
         vGQg==
X-Forwarded-Encrypted: i=1; AKwUvBwI9iCql0df5VTs/yLyjCXdsC2pnQbccHdydGyFizcYU/3hDJpGPLFaWx91CsnZab5isbISDFI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ7pa+EsRLkn65/VgqgRQtiskmd3TNF10bTMVqlLHvGeK96Yp/n
	nLRoelXRI7yD3vH+Lle1YpWzZYvLeIAA5mB+5WO8G2eeT4io4W8HOZfj22VPUZ0nNQA=
X-Gm-Gg: AYBFou3UPEq7VZ8iGDoj6TDsQDJCooPrP/nNS1eLOV3Dc4oEvyhOl1/qD1/1y2WYlF3
	aXdSO1vnwBWXSFT8AIqHlmrxKoH+eyqzaCFWs/237G3Q4K4priFNyd4j0bJWKe+GFJ2MuVm9aqp
	2ynXUsXeSiiZDDtjcsBAsJT777Ove0OT8p4akYOiOYAUaYzz97VdmqGSEodziPK9RTB1EEqY8tl
	e6elqi8TQ6udNxuoL0iu4X/AN1T/CvnLYs37MZVkiBcfdoVlLvZqVzpsOBLEc7uvjlL369urseC
	QaIJwZouLJ33sZijSGANqeGdFEE3sCVqYYFkrw2Jlq991OerI4JbQWPHlFjY9NwkUqhERR5urJA
	/nKNUeKm6frBu1IxgZExcgkmE/Og0mG1LWl8DYjGPgYgxyXO8qfRx19kabRVvAjaRLvRKuyLcUU
	sjchlZW1799vHEZHPHY8vTr1jgLdnVMP9N2lWFNqIsZiomgAjI63fXRWkMHGwUE2VED1PnBln74
	mrrqrQvuXxIsIzcmtjTWqwvRGT7Zcxg1/pqlE0V9K7fnI96hgUsDGVqGooV/AP5IdzY+Y5dNqXI
	p6RaLOsEVW1yww==
X-Received: by 2002:a05:701b:2309:b0:151:f0c5:7a09 with SMTP id a92af1059eb24-16a5f01db04mr18014428c88.43.1791860278186;
        Mon, 12 Oct 2026 19:57:58 -0700 (PDT)
Received: from localhost.localdomain ([103.207.175.177])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a1becefdsm34223721c88.7.2026.10.12.19.57.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 12 Oct 2026 19:57:57 -0700 (PDT)
From: Shubham Antil <shubham@octane.security>
To: netdev@vger.kernel.org
Cc: david@ixit.cz,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	cuissard@marvell.com,
	sameo@linux.intel.com,
	oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	gio@octane.security,
	Shubham Antil <shubham@octane.security>,
	stable@vger.kernel.org
Subject: [PATCH net v5 1/2] nfc: nfcmrvl: publish UART state before registration
Date: Tue, 13 Oct 2026 08:27:45 +0530
Message-ID: <20261013025746.41292-2-shubham@octane.security>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261013025746.41292-1-shubham@octane.security>
References: <20261013025746.41292-1-shubham@octane.security>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfcmrvl_nci_uart_open() does not publish nu->drv_data and nu->ndev until
nfcmrvl_nci_register_dev() returns.  The registration call exposes the NCI
device first, so an early transmit can reach the UART callbacks while those
back-pointers are not initialized.

Add callbacks which publish the UART back-pointers before
nci_register_device() and withdraw them if registration fails.  Halt the
controller before exposing the device as well.

The ordering issue was found during an LLM-assisted source audit and
reproduced using a pty-backed NCI UART under KASAN.

Fixes: e097dc624f78 ("NFC: nfcmrvl: add UART driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM (OpenAI Codex, gpt-5.6-sol)
Signed-off-by: Shubham Antil <shubham@octane.security>
---
 drivers/nfc/nfcmrvl/main.c    | 11 ++++++++---
 drivers/nfc/nfcmrvl/nfcmrvl.h |  2 ++
 drivers/nfc/nfcmrvl/uart.c    | 24 +++++++++++++++++++-----
 3 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/nfc/nfcmrvl/main.c b/drivers/nfc/nfcmrvl/main.c
index 6efa83219117..3d26a54ef51b 100644
--- a/drivers/nfc/nfcmrvl/main.c
+++ b/drivers/nfc/nfcmrvl/main.c
@@ -154,20 +154,25 @@ struct nfcmrvl_private *nfcmrvl_nci_register_dev(enum nfcmrvl_phy phy,
 
 	nci_set_drvdata(priv->ndev, priv);
 
+	/* Ensure that controller is powered off before exposing the device. */
+	nfcmrvl_chip_halt(priv);
+
+	if (priv->if_ops->nci_ready)
+		priv->if_ops->nci_ready(priv);
+
 	rc = nci_register_device(priv->ndev);
 	if (rc) {
 		nfc_err(dev, "nci_register_device failed %d\n", rc);
 		goto error_fw_dnld_deinit;
 	}
 
-	/* Ensure that controller is powered off */
-	nfcmrvl_chip_halt(priv);
-
 	nfc_info(dev, "registered with nci successfully\n");
 	return priv;
 
 error_fw_dnld_deinit:
 	nfcmrvl_fw_dnld_deinit(priv);
+	if (priv->if_ops->nci_unready)
+		priv->if_ops->nci_unready(priv);
 error_free_dev:
 	nci_free_device(priv->ndev);
 error_free:
diff --git a/drivers/nfc/nfcmrvl/nfcmrvl.h b/drivers/nfc/nfcmrvl/nfcmrvl.h
index 62fa77d587b2..66f8cc06e2d5 100644
--- a/drivers/nfc/nfcmrvl/nfcmrvl.h
+++ b/drivers/nfc/nfcmrvl/nfcmrvl.h
@@ -112,6 +112,8 @@ struct nfcmrvl_if_ops {
 	int (*nci_open) (struct nfcmrvl_private *priv);
 	int (*nci_close) (struct nfcmrvl_private *priv);
 	int (*nci_send) (struct nfcmrvl_private *priv, struct sk_buff *skb);
+	void (*nci_ready)(struct nfcmrvl_private *priv);
+	void (*nci_unready)(struct nfcmrvl_private *priv);
 	void (*nci_update_config)(struct nfcmrvl_private *priv,
 				  const void *param);
 };
diff --git a/drivers/nfc/nfcmrvl/uart.c b/drivers/nfc/nfcmrvl/uart.c
index 9aedd168759c..d688071f4b26 100644
--- a/drivers/nfc/nfcmrvl/uart.c
+++ b/drivers/nfc/nfcmrvl/uart.c
@@ -44,6 +44,23 @@ static int nfcmrvl_uart_nci_send(struct nfcmrvl_private *priv,
 	return nu->ops.send(nu, skb);
 }
 
+static void nfcmrvl_uart_nci_ready(struct nfcmrvl_private *priv)
+{
+	struct nci_uart *nu = priv->drv_data;
+
+	priv->support_fw_dnld = true;
+	nu->drv_data = priv;
+	nu->ndev = priv->ndev;
+}
+
+static void nfcmrvl_uart_nci_unready(struct nfcmrvl_private *priv)
+{
+	struct nci_uart *nu = priv->drv_data;
+
+	nu->drv_data = NULL;
+	nu->ndev = NULL;
+}
+
 static void nfcmrvl_uart_nci_update_config(struct nfcmrvl_private *priv,
 					   const void *param)
 {
@@ -58,6 +75,8 @@ static const struct nfcmrvl_if_ops uart_ops = {
 	.nci_open = nfcmrvl_uart_nci_open,
 	.nci_close = nfcmrvl_uart_nci_close,
 	.nci_send = nfcmrvl_uart_nci_send,
+	.nci_ready = nfcmrvl_uart_nci_ready,
+	.nci_unready = nfcmrvl_uart_nci_unready,
 	.nci_update_config = nfcmrvl_uart_nci_update_config
 };
 
@@ -136,11 +155,6 @@ static int nfcmrvl_nci_uart_open(struct nci_uart *nu)
 	if (IS_ERR(priv))
 		return PTR_ERR(priv);
 
-	priv->support_fw_dnld = true;
-
-	nu->drv_data = priv;
-	nu->ndev = priv->ndev;
-
 	return 0;
 }
 
-- 
2.43.0
