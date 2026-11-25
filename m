Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645471;
	b=IIQvLqGfXVsmESoy+KnkPDOc2Vi725jAq2wH3EI9M6HEDw2qoCSOyc1R679rFp95cmb8
	 SycnmN4IKb/OI/9qyFjK3oZompXmhmGXzSyK78CJRrICL4FTus/kodg45uj1CG8S1Znr9
	 FQuINJNNirK7eVT3jF6puEHvFEV5Tv+zR0xHXdDTGH2bDTbBaNsU0wtucM9UQJTCNjDBs
	 Qq/SQyEDC8S1c8WIJy8YPlJKjsZ3g92VjaA8J23sXemVYovcHanmoWRIWVV6wZ2SZJ26h
	 Zl7AhY/aDQOwSPLjJ6NEjGmA1A5g3kWWAjlLbNZhw5m9QGZOfMtn2pZsaqiSfAs4lhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645471;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=YDYS9n9lT5gSkIV69W1btVTMHd2XxfQrN36gTu5mxFk=;
	b=KlyhWTNjqy+VMJT2QifGMAXHIr0HU8We0Rq3MdL9KkRroJwbCRM9DCfE0GgDQf/8CReJ
	 RNE/21GEFa6kJvQr+nBeLbgdisQsnfG508UiZiih/ooYw4QINL3huacWOXS99p0SFxm3i
	 vxjFbvrH3StChsvDTrdwRqY4vtJY4lk12UgHWc8jvnKmYj2GqfN5g170PHXCBD+ysKSzM
	 g+Oe+JTJWoME5Fagqpn/kGnEuycCBEESU/z+lDFefXlc93NnTEz7Nni9VhDl16OmLFK2D
	 FZ5MzQ36RXTcK6xSqTWFR56jYvTPqMXxWDjPGHgT0rge8dR78RtLVtyR3Rr5rp1gmmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--elkin.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="AQi/BAGm";
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5394E606A32A
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 22:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5394E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elkin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AQi/BAGm
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-386177b0516so15913579eec.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795645469; x=1796250269; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YDYS9n9lT5gSkIV69W1btVTMHd2XxfQrN36gTu5mxFk=;
        b=AQi/BAGm/FBDxK1JuvZwHCN9jd6iLLvy7R4f3LaQFVdqk2JorHdSzDL4/s4KXOtnIN
         Mh/30a2fPOp6L3s/Gip2ij41HL/nUqQRWpt4ZSHY/tfeNO7X+d7tTHCKIUYZyRZ6/MMP
         Voo1U7V3PcK05+f1jU19/P85Cy9DaKY6MJu0ZORkqeuHykTbkLy+U91bEeSPBs5ckBjY
         xDqEuMQTXH87E+skTO0Qyns5fCg+G9aVepRWHsImdJcWI8yHKIvFw+fTjROD5uJVCPO4
         QlSJne0VEJcciDIlp1BT5kBNcaHze4yXxncbM6WbhBX+O1NpVTmTFoCYINq4RHGTBic0
         m1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645469; x=1796250269;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YDYS9n9lT5gSkIV69W1btVTMHd2XxfQrN36gTu5mxFk=;
        b=hbB2zeTtX1lm/uVifLgshvZqP69lQWjyZWkalkvRrGJ7CIn2BTeQ8j4eYHaJ3rbHp5
         e6Thw5pT0nzpUrlkPT46iTrp0bCA47Ld3Hlvuw0wi9WSYevIKuck9rz4H/Gw6OPL11Wy
         w02cCenF2k1yxy0KYqA9mO3OJhLTKKHIN2/mpCZ4W1x2F0GorPVUGBjJQb+ZJVXWgfzV
         JQQ+bs1OaFZ08JeffPmWpDjZMja38E9yjGaFRgH8UZVeNP2Tbp7AeimiBBRrBh7PwXYY
         q4iedwv8e1NzVETWB5oZVVrW5JuWKDe6gMrb7x0LgyAVfSjM6MWPluHsvtMTo4C7N6Uq
         ZKag==
X-Forwarded-Encrypted: i=1; AL+hErEj8z+ufTmQ9/oBlfOS57Gnre3XhQcdAf+QxNnMTTprD4JIajwPK7FiTUBkLxIPA2GpUQYjhBI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8r7/FA6jIlxKVA4ud5bddqHPDo7KA8F/Yb9hIncKFBjeuZFBmS
	H6BioHA3DQCHdL+LBR0qh9BSp7mHlt5XSA2BJI0fsZMJkgLPoizG1vkPAsJA5VlEb/zpwQsdeTc
	Zdg==
X-Received: from dybsl8.prod.google.com ([2002:a05:7301:7308:b0:379:1aaf:7a27])
 (user=elkin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:460f:b0:386:c850:1f25
 with SMTP id 5a478bee46e88-386c8502211mr5715418eec.21.1795645468936; Wed, 25
 Nov 2026 14:24:28 -0800 (PST)
Date: Wed, 25 Nov 2026 22:22:57 +0000
In-Reply-To: <20261125222300.1438398-1-elkin@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125222300.1438398-1-elkin@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125222300.1438398-3-elkin@google.com>
Subject: [PATCH net 2/4] nfc: st95hf: use DMA-safe buffers for SPI transfers
From: Elkin Cruz <elkin@google.com>
To: David Heidelberg <david@ixit.cz>, Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, oe-linux-nfc@lists.linux.dev, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, irogers@google.com, 
	Elkin Cruz <elkin@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

st95hf_spi_send(), st95hf_spi_recv_response(), and
st95hf_spi_recv_echo_res() pass stack-allocated buffers from core.c and
spi.c directly to spi_sync(), violating kernel DMA safety requirements
on DMA-capable SPI controllers and CONFIG_VMAP_STACK kernels.

Use kmemdup() in st95hf_spi_send(), spi_write_then_read() in
st95hf_spi_recv_echo_res(), and DMA-cacheline-isolated cmd_buf and
rx_buf members (via __dma_from_device_group_begin/end) in
struct st95hf_spi_context for st95hf_spi_recv_response().

This issue was found while trying out new Clang static analysis checks for
kernel bug classes. The finding was triaged and fixed, and this commit
description was drafted with the help of AI, then verified by code
inspection and compile-tested against linux-next (not reproduced and not
runtime-tested on hardware).

Fixes: cab47333f0f7 ("NFC: Add STMicroelectronics ST95HF driver")
Cc: stable@vger.kernel.org
Signed-off-by: Elkin Cruz <elkin@google.com>
---
 drivers/nfc/st95hf/spi.c | 52 +++++++++++++++++++++-------------------
 drivers/nfc/st95hf/spi.h | 10 ++++++++
 2 files changed, 37 insertions(+), 25 deletions(-)

diff --git a/drivers/nfc/st95hf/spi.c b/drivers/nfc/st95hf/spi.c
index a6599d65a3bf..8bd7eccc34d3 100644
--- a/drivers/nfc/st95hf/spi.c
+++ b/drivers/nfc/st95hf/spi.c
@@ -14,13 +14,18 @@ int st95hf_spi_send(struct st95hf_spi_context *spicontext,
 		    int datalen,
 		    enum req_type reqtype)
 {
-	struct spi_message m;
-	int result = 0;
 	struct spi_device *spidev = spicontext->spidev;
 	struct spi_transfer tx_transfer = {
-		.tx_buf = buffertx,
 		.len = datalen,
 	};
+	unsigned char *tx_buf;
+	struct spi_message m;
+	int result = 0;
+
+	tx_buf = kmemdup(buffertx, datalen, GFP_KERNEL);
+	if (!tx_buf)
+		return -ENOMEM;
+	tx_transfer.tx_buf = tx_buf;
 
 	mutex_lock(&spicontext->spi_lock);
 
@@ -35,6 +40,7 @@ int st95hf_spi_send(struct st95hf_spi_context *spicontext,
 	spi_message_add_tail(&tx_transfer, &m);
 
 	result = spi_sync(spidev, &m);
+	kfree(tx_buf);
 	if (result) {
 		dev_err(&spidev->dev, "error: sending cmd to st95hf using SPI = %d\n",
 			result);
@@ -69,12 +75,11 @@ int st95hf_spi_recv_response(struct st95hf_spi_context *spicontext,
 			     unsigned char *receivebuff,
 			     size_t max_len)
 {
-	unsigned char readdata_cmd = ST95HF_COMMAND_RECEIVE;
 	struct spi_device *spidev = spicontext->spidev;
 	struct spi_transfer tx_takedata;
 	struct spi_transfer t[2] = {
-		{ .tx_buf = &readdata_cmd, .len = 1 },
-		{ .rx_buf = receivebuff, .len = 2, .cs_change = 1 },
+		{ .len = 1 },
+		{ .len = 2, .cs_change = 1 },
 	};
 	struct spi_message m;
 	int len = 0;
@@ -85,6 +90,10 @@ int st95hf_spi_recv_response(struct st95hf_spi_context *spicontext,
 
 	mutex_lock(&spicontext->spi_lock);
 
+	spicontext->cmd_buf = ST95HF_COMMAND_RECEIVE;
+	t[0].tx_buf = &spicontext->cmd_buf;
+	t[1].rx_buf = spicontext->rx_buf;
+
 	/* First spi transfer to know the length of valid data */
 	spi_message_init(&m);
 	spi_message_add_tail(&t[0], &m);
@@ -102,12 +111,13 @@ int st95hf_spi_recv_response(struct st95hf_spi_context *spicontext,
 	len = 2;
 
 	/* Support of long frame */
-	if (receivebuff[0] & 0x60)
-		len += (((receivebuff[0] & 0x60) >> 5) << 8) | receivebuff[1];
+	if (spicontext->rx_buf[0] & 0x60)
+		len += (((spicontext->rx_buf[0] & 0x60) >> 5) << 8) |
+		       spicontext->rx_buf[1];
 	else
-		len += receivebuff[1];
+		len += spicontext->rx_buf[1];
 
-	if (len > max_len) {
+	if (len > max_len || len > ST95HF_MAX_RESPONSE_BUFFER_SIZE) {
 		dev_err(&spidev->dev, "spi_recv_resp, invalid response len = %d\n",
 			len);
 		memset(&tx_takedata, 0x0, sizeof(struct spi_transfer));
@@ -120,21 +130,23 @@ int st95hf_spi_recv_response(struct st95hf_spi_context *spicontext,
 
 	/* Now make a transfer to read only relevant bytes */
 	memset(&tx_takedata, 0x0, sizeof(struct spi_transfer));
-	tx_takedata.rx_buf = &receivebuff[2];
+	tx_takedata.rx_buf = &spicontext->rx_buf[2];
 	tx_takedata.len = len - 2;
 
 	spi_message_init(&m);
 	spi_message_add_tail(&tx_takedata, &m);
 
 	ret = spi_sync(spidev, &m);
-
-	mutex_unlock(&spicontext->spi_lock);
 	if (ret) {
 		dev_err(&spidev->dev, "spi_recv_resp, data read error = %d\n",
 			ret);
+		mutex_unlock(&spicontext->spi_lock);
 		return ret;
 	}
 
+	memcpy(receivebuff, spicontext->rx_buf, len);
+	mutex_unlock(&spicontext->spi_lock);
+
 	return len;
 }
 EXPORT_SYMBOL_GPL(st95hf_spi_recv_response);
@@ -143,21 +155,11 @@ int st95hf_spi_recv_echo_res(struct st95hf_spi_context *spicontext,
 			     unsigned char *receivebuff)
 {
 	unsigned char readdata_cmd = ST95HF_COMMAND_RECEIVE;
-	struct spi_transfer t[2] = {
-		{.tx_buf = &readdata_cmd, .len = 1,},
-		{.rx_buf = receivebuff, .len = 1,},
-	};
-	struct spi_message m;
 	struct spi_device *spidev = spicontext->spidev;
-	int ret = 0;
+	int ret;
 
 	mutex_lock(&spicontext->spi_lock);
-
-	spi_message_init(&m);
-	spi_message_add_tail(&t[0], &m);
-	spi_message_add_tail(&t[1], &m);
-	ret = spi_sync(spidev, &m);
-
+	ret = spi_write_then_read(spidev, &readdata_cmd, 1, receivebuff, 1);
 	mutex_unlock(&spicontext->spi_lock);
 
 	if (ret)
diff --git a/drivers/nfc/st95hf/spi.h b/drivers/nfc/st95hf/spi.h
index 840f55f82899..6fbace4412d9 100644
--- a/drivers/nfc/st95hf/spi.h
+++ b/drivers/nfc/st95hf/spi.h
@@ -9,6 +9,7 @@
 #ifndef __LINUX_ST95HF_SPI_H
 #define __LINUX_ST95HF_SPI_H
 
+#include <linux/dma-mapping.h>
 #include <linux/spi/spi.h>
 
 /* Basic ST95HF SPI CMDs */
@@ -17,6 +18,7 @@
 #define ST95HF_COMMAND_RECEIVE	0x2
 
 #define ST95HF_RESET_CMD_LEN	0x1
+#define ST95HF_MAX_RESPONSE_BUFFER_SIZE	280
 
 /*
  * structure to contain st95hf spi communication specific information.
@@ -25,12 +27,20 @@
  * @done: completion structure to wait for st95hf response
  *	for synchronous calls.
  * @spi_lock: mutex to allow only one spi transfer at a time.
+ * @cmd_buf: DMA-safe buffer for command byte.
+ * @rx_buf: DMA-safe buffer for response transfers.
  */
 struct st95hf_spi_context {
 	bool req_issync;
 	struct spi_device *spidev;
 	struct completion done;
 	struct mutex spi_lock;
+	__dma_from_device_group_begin(cmd);
+	u8 cmd_buf;
+	__dma_from_device_group_end(cmd);
+	__dma_from_device_group_begin(rx);
+	u8 rx_buf[ST95HF_MAX_RESPONSE_BUFFER_SIZE];
+	__dma_from_device_group_end(rx);
 };
 
 /* flag to differentiate synchronous & asynchronous spi request */
-- 
2.56.1.839.g22a8290db9-goog

