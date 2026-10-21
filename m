Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792553104;
	b=elZ8z9z3XoBFU2zue0Hd6MajyiE/jnMPEdc3soFEVh+ctsviA9C43U55GKvcEIfjVup8
	 Ze40RSk0taXtRj2HxKPaB89aYiU2l1KcJyR1EhfbIctet9o0xV45wTd3FzClSCY0IFEZr
	 aWggTbwgK1T5f48hv+pyjmm01KOVKXPT+IIXVPfGOhFUogmeVylyVVI5MzU5N0bAPJDnP
	 TcGS3zXG2ZCvMPJsl3KpxwnNsSNY/Rn3W2OSplc6ykwdb3uDxYLo89fSFhFiLnUW4oObE
	 dtABHSvn4RSc5G9IiBqP32CjI5uQVw1fX7Col8BtKyJ/wuLRhuAkoQqC9NXfgSSSNoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792553104;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6rj9QUbsFJOA4qpafrOsme0S3/Ei7bet+9iObpPybeA=;
	b=UIIaXMg46N8YchrjtdQoFBNu1FBFdRN1PznQaOGCBnFdqJka5Uk/idCLuSIrCr80eWVy
	 r4qs6n/EiRshHO5lP6RoMEaI9RlxgFfqBy2ma2eDulAHZs+8kw+GSNHI4oWXskANexdgJ
	 EsHYO/Wjxr9Oz6Gz17YqO9VSN4HeZybgysJthIpi78qMfuoKFk7uJzFzFpuc5hpHmD05U
	 4LyQMvoelVR5ZCJhy7pMUHgOEzJ9N6PZ9mgMgWwe9h+wCi62KXn82N1lQQ3aX+2q/uNv6
	 yQe11Zb0/uDlPUNjnGS7j5V0JHzYV/ilkdeLsjXSR/xIFGt/1JBLWH2nkrRsgDknPEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=octane.security;
	spf=pass smtp.mailfrom=octane.security;
	dkim=pass header.d=octane.security header.i=@octane.security header.a=rsa-sha256 header.s=google header.b="M8Rg+d/V";
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD7A606E861
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 03:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACD7A606E861
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=octane.security
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=octane.security
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=octane.security header.i=@octane.security header.a=rsa-sha256 header.s=google header.b=M8Rg+d/V
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so155101a91.2
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 20:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=octane.security; s=google; t=1792553103; x=1793157903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6rj9QUbsFJOA4qpafrOsme0S3/Ei7bet+9iObpPybeA=;
        b=M8Rg+d/VBawbUZ0HoRivCr1nPxgmn11XW7v+6bKGO2yryMZD5+kXkq1zHUy8Nnp0Nu
         THIiJ6I+rH++EGYJRgVPwMtXJ1kRtzoeg/h+jltqffSHrCNh3nMk3pO0rW9u3+D8ELIM
         /gbWrwr6z32I8eO5ES3yPjDZ2iH0UtThWAABm78rle1JR183AQhsHzDxVMDDSMuUHGQn
         d1QrUIQlerCgoC+/ZtDHz54cKduSG5f3Kq/j5RuXMJjyPQ51AhvLHF3yHAMhzt+ozLAK
         KVrPY68955VWdLeM7g6qgWCktCIsNRl0kGfpcKxAnJOv3t+gPG8KG3vRFq2ycNAX00Dt
         dOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792553103; x=1793157903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6rj9QUbsFJOA4qpafrOsme0S3/Ei7bet+9iObpPybeA=;
        b=22j0qwc4GW964ZVDGHI6Nr15sXpQVaQcU0p9Lt9coGXJxXWftmZzWw44dhnExazdY0
         SMmMCEzcXXiowsHmg/oEo6IeEo3mf88bnnX8H5mOBqUx7QL0a9F9DdGC6tKvl7HB4813
         7II1SLN9bGy8UE9GrCNd62XrhgoxM8YIdpLnya69O88qhoUlKf2q7KZkNTYw7sXjSSnW
         IdcVoILbQZygs7qEe+hXF+U+021eZiAX9EdpCoPSXpBjzAlc133p4e3FGbdpv+N6h8XJ
         yu3+FaQiZkTE0XLFFuyOb67fevgqoVH9kZThZoGzTDeoIGYteojP9UVWdUb5zgDpMnS2
         yesg==
X-Forwarded-Encrypted: i=1; AKwUvBzwSvioPgdQf9/RBA/eqlPDUU7IXLcjCKSige1XTC+wiZBMDbWKoHYoG5idIgyvZNB9uabdxtA=@vger.kernel.org
X-Gm-Message-State: AFq9FYL07TWylC0OBQ+wdswetV2zabe+9L+gm132f1K6Gx5evb7ccIED
	zRY9pTWOWBN4KmBr9yXIA2oQ0BUTcABPoafRgbevuaDZdvgqoio9SyD7wB2+gTPzQesFMfI137+
	6QRR2
X-Gm-Gg: AYBFou2VS42rZJUOEu14MZWjsMobd/VQf4GqA+5i6pqRxxmMv7PthlytwOWNUKdLbxJ
	sfJEIBJ7UVjLKALpcfmPqev0hqVq8TyMQ/b4ZVYhwmuw7DafWL2ukJxQzdYdlRIJNjfb2fy/jC4
	tMWbTsJfq6TWZ/CGZgQjRUHr5ozyHLP8KkZv7bYmluuFUtKdg52HrJWCHO+L7v+Rh457CVbWWr0
	J7Pn382wP7OMjNeQoJVnpWeAel8OEtds9MyyIv0dmVnpbi9Ga+xg2pRDBUZeNs7orb84spQ0uQA
	O962g1mfoKD4CiRPIRK7ePiG62egYHns6dDRoyRSQqmGuAUUZ/44ZJVROHzy7WkZWz4cIGKC7Z2
	bb65tFBr2bYVdHO14bihaoOMKabbCnw7NhOOWWGKie+XWKkhPfLT7JUf5ZLF7yDuNi2UsKY3Ql+
	ytuREiJcWgYwqPPCv7WbjJT4pGgf9GBiX4lXaUzrqQkt2SfkGhMvL8t5faI6y4JvnRHCASorNFQ
	S9TCi/GPp1wAzGHam2jJrSyA2Op9TrkvgqJmcA2a8ZZondWPXVo4rl55VoPo6hh7hOY7myKlFrr
	VpgdlnBTk3rfRqGsqcCbVrIz4UasrZIhER2rv/J28MLsYynf++gJ73pwKk3xASs/0oXFnnSCKhR
	j
X-Received: by 2002:a17:90a:c107:b0:3a8:495b:d64b with SMTP id 98e67ed59e1d1-3ad86c2e6dfmr718797a91.4.1792553102953;
        Tue, 20 Oct 2026 20:25:02 -0700 (PDT)
Received: from localhost.localdomain ([103.207.175.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad8030226csm2155285a91.12.2026.10.20.20.25.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Oct 2026 20:25:02 -0700 (PDT)
From: Shubham Antil <shubham@octane.security>
To: netdev@vger.kernel.org
Cc: David Heidelberg <david@ixit.cz>,
	oe-linux-nfc@lists.linux.dev,
	gio@octane.security,
	stable@vger.kernel.org
Subject: [PATCH net v6 5/6] nfc: serialize firmware download state
Date: Wed, 21 Oct 2026 08:54:42 +0530
Message-ID: <20261021032443.44412-6-shubham@octane.security>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261021032443.44412-1-shubham@octane.security>
References: <20261021032443.44412-1-shubham@octane.security>
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

nfc_fw_download() marks a firmware download in progress but does not reject
a second request.  An overlapping request can replace driver-owned download
state, and an error from that request clears the shared in-progress flag
while the first download is still running.

Make the in-progress state atomic and claim it before invoking the driver.
An overlapping request then leaves the first download's state unchanged.
Copy the firmware name before releasing that claim, then send the
completion notification after the release so userspace can immediately
start its next operation.  Use release/acquire ordering so the next
operation observes the completed download cleanup.

OpenAI Codex, gpt-5.6-sol assisted a source audit of NFC firmware teardown.

Fixes: 9674da8759df ("NFC: Add firmware upload netlink command")
Cc: stable@vger.kernel.org
Assisted-by: LLM KASAN
Signed-off-by: Shubham Antil <shubham@octane.security>
---
 drivers/nfc/nfcmrvl/main.c       |  4 ++--
 drivers/nfc/nfcmrvl/uart.c       |  4 ++--
 drivers/nfc/st-nci/vendor_cmds.c |  8 ++++----
 include/net/nfc/nfc.h            |  3 ++-
 net/nfc/core.c                   | 19 ++++++++++++++-----
 5 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/nfc/nfcmrvl/main.c b/drivers/nfc/nfcmrvl/main.c
index b6f47cce0f1f..27fadd64155e 100644
--- a/drivers/nfc/nfcmrvl/main.c
+++ b/drivers/nfc/nfcmrvl/main.c
@@ -189,7 +189,7 @@ void nfcmrvl_nci_unregister_dev(struct nfcmrvl_private *priv)
 	if (priv->if_ops->nci_quiesce)
 		priv->if_ops->nci_quiesce(priv);
 
-	if (priv->ndev->nfc_dev->fw_download_in_progress)
+	if (atomic_read(&priv->ndev->nfc_dev->fw_download_in_progress))
 		nfcmrvl_fw_dnld_abort(priv);
 
 	nfcmrvl_fw_dnld_deinit(priv);
@@ -213,7 +213,7 @@ int nfcmrvl_nci_recv_frame(struct nfcmrvl_private *priv, struct sk_buff *skb)
 		}
 	}
 
-	if (priv->ndev->nfc_dev->fw_download_in_progress) {
+	if (atomic_read(&priv->ndev->nfc_dev->fw_download_in_progress)) {
 		nfcmrvl_fw_dnld_recv_frame(priv, skb);
 		return 0;
 	}
diff --git a/drivers/nfc/nfcmrvl/uart.c b/drivers/nfc/nfcmrvl/uart.c
index 95223c20d50f..d87f6497baf2 100644
--- a/drivers/nfc/nfcmrvl/uart.c
+++ b/drivers/nfc/nfcmrvl/uart.c
@@ -176,7 +176,7 @@ static void nfcmrvl_nci_uart_tx_start(struct nci_uart *nu)
 {
 	struct nfcmrvl_private *priv = (struct nfcmrvl_private *)nu->drv_data;
 
-	if (priv->ndev->nfc_dev->fw_download_in_progress)
+	if (atomic_read(&priv->ndev->nfc_dev->fw_download_in_progress))
 		return;
 
 	/* Remove BREAK to wake up the NFCC */
@@ -190,7 +190,7 @@ static void nfcmrvl_nci_uart_tx_done(struct nci_uart *nu)
 {
 	struct nfcmrvl_private *priv = (struct nfcmrvl_private *)nu->drv_data;
 
-	if (priv->ndev->nfc_dev->fw_download_in_progress)
+	if (atomic_read(&priv->ndev->nfc_dev->fw_download_in_progress))
 		return;
 
 	/*
diff --git a/drivers/nfc/st-nci/vendor_cmds.c b/drivers/nfc/st-nci/vendor_cmds.c
index 6335d7afca24..ec577d497500 100644
--- a/drivers/nfc/st-nci/vendor_cmds.c
+++ b/drivers/nfc/st-nci/vendor_cmds.c
@@ -158,11 +158,12 @@ static int st_nci_hci_dm_fwupd_start(struct nfc_dev *dev, void *data,
 	int r;
 	struct nci_dev *ndev = nfc_get_drvdata(dev);
 
-	dev->fw_download_in_progress = true;
+	if (atomic_cmpxchg_acquire(&dev->fw_download_in_progress, 0, 1))
+		return -EBUSY;
 	r = nci_hci_send_cmd(ndev, ST_NCI_DEVICE_MGNT_GATE,
 			ST_NCI_HCI_DM_FWUPD_START, data, data_len, NULL);
 	if (r)
-		dev->fw_download_in_progress = false;
+		atomic_set_release(&dev->fw_download_in_progress, 0);
 
 	return r;
 }
@@ -181,8 +182,7 @@ static int st_nci_hci_dm_direct_load(struct nfc_dev *dev, void *data,
 {
 	struct nci_dev *ndev = nfc_get_drvdata(dev);
 
-	if (dev->fw_download_in_progress) {
-		dev->fw_download_in_progress = false;
+	if (atomic_xchg(&dev->fw_download_in_progress, 0)) {
 		return nci_hci_send_cmd(ndev, ST_NCI_DEVICE_MGNT_GATE,
 				ST_NCI_HCI_DM_LOAD, data, data_len, NULL);
 	}
diff --git a/include/net/nfc/nfc.h b/include/net/nfc/nfc.h
index bcafab5c53e5..f6cb17f46ca7 100644
--- a/include/net/nfc/nfc.h
+++ b/include/net/nfc/nfc.h
@@ -11,6 +11,7 @@
 #ifndef __NET_NFC_H
 #define __NET_NFC_H
 
+#include <linux/atomic.h>
 #include <linux/nfc.h>
 #include <linux/device.h>
 #include <linux/skbuff.h>
@@ -172,7 +173,7 @@ struct nfc_dev {
 	int targets_generation;
 	struct device dev;
 	bool dev_up;
-	bool fw_download_in_progress;
+	atomic_t fw_download_in_progress;
 	u8 rf_mode;
 	bool polling;
 	struct nfc_target *active_target;
diff --git a/net/nfc/core.c b/net/nfc/core.c
index f521669293f0..1f335fa7f6f0 100644
--- a/net/nfc/core.c
+++ b/net/nfc/core.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/rfkill.h>
 #include <linux/nfc.h>
+#include <linux/string.h>
 
 #include <net/genetlink.h>
 
@@ -53,10 +54,14 @@ int nfc_fw_download(struct nfc_dev *dev, const char *firmware_name)
 		goto error;
 	}
 
-	dev->fw_download_in_progress = true;
+	if (atomic_cmpxchg_acquire(&dev->fw_download_in_progress, 0, 1)) {
+		rc = -EBUSY;
+		goto error;
+	}
+
 	rc = dev->ops->fw_download(dev, firmware_name);
 	if (rc)
-		dev->fw_download_in_progress = false;
+		atomic_set_release(&dev->fw_download_in_progress, 0);
 
 error:
 	device_unlock(&dev->dev);
@@ -73,9 +78,12 @@ error:
 int nfc_fw_download_done(struct nfc_dev *dev, const char *firmware_name,
 			 u32 result)
 {
-	dev->fw_download_in_progress = false;
+	char name[NFC_FIRMWARE_NAME_MAXSIZE + 1];
+
+	strscpy(name, firmware_name, sizeof(name));
+	atomic_set_release(&dev->fw_download_in_progress, 0);
 
-	return nfc_genl_fw_download_done(dev, firmware_name, result);
+	return nfc_genl_fw_download_done(dev, name, result);
 }
 EXPORT_SYMBOL(nfc_fw_download_done);
 
@@ -104,7 +112,7 @@ int nfc_dev_up(struct nfc_dev *dev)
 		goto error;
 	}
 
-	if (dev->fw_download_in_progress) {
+	if (atomic_read_acquire(&dev->fw_download_in_progress)) {
 		rc = -EBUSY;
 		goto error;
 	}
@@ -1073,6 +1081,7 @@ struct nfc_dev *nfc_allocate_device(const struct nfc_ops *ops,
 	dev->dev.class = &nfc_class;
 	dev_set_name(&dev->dev, "nfc%d", dev->idx);
 	device_initialize(&dev->dev);
+	atomic_set(&dev->fw_download_in_progress, 0);
 
 	dev->ops = ops;
 	dev->supported_protocols = supported_protocols;
-- 
2.43.0

