Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645427;
	b=FSX1gsTMcubV4rvohXA0ZdntPWG0+L00eOCxyWz2cr/536hvjJmrAWgGu1qmkFKiJFDk
	 9aylzGlRVdEVbnZR3yjkgz3zouzfvOFgyQDbuEBTezhuhYNqMLEefhU/yaSW+NI6Y7dYS
	 h6v2be1eTKrrW1J2i+zIuEGeUwvk2xt28+kNNWca4ICUDabYzBJx0/vvmnyXV3olZMvk7
	 0LB25JdenqlZy+LsFnGWXPoPh+ZyVWwOLnFhs9ByNLpZcQOBt7twwuwV7iG0t9caCjgwB
	 VlNvlrNq2WrXFZQaUGAqOY+xjMsTyLT1RvG75RelRY1GT1E/IBGp/YieqbubtvXYmhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645427;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=/tS6CVqz0bwQhURF3f4/c8xLuOeYAnVMzoUdEwuEpSs=;
	b=cRLwwnTiUByFgzTnPpZc4d1ap0WojxeOkO4J63y2a29JgIY4Vwwl316MztfhTYOq3Abc
	 MaHjWjl+9Fut7V/q08i2tcO6Q/vWp1a0NQTtnXueB4OEiqMRIiwNkbL1uC+aMKqnZ2UKO
	 XmuBhNQCNP/eqsE0H8jiW8xTcMFI8Hi6pElUc9Wq+vQXUB3cAegVYN1EvlLMp/TbvajPR
	 8unjEw0X7bWMmy9frpQnzSqYO/7se5DWk96TIxRc8uaQgapS/DVysWoYwIgPd3ehBTXDv
	 Jaod6DSCrGJpu6+GFgqmTejTMx9HjbeZk2cgilnS5ncjMuLoMJ3hvvXZJxcch3dl9Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--elkin.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Iy8hw229;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0475606A32E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 22:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0475606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elkin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Iy8hw229
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-341eff9e381so9498700eec.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795645426; x=1796250226; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/tS6CVqz0bwQhURF3f4/c8xLuOeYAnVMzoUdEwuEpSs=;
        b=Iy8hw229ku1Pt2i8DNZ8z4ACKj9ceTTjsB/RkrJwphZxqX1Gk05MI4GZEltLYLxjDr
         dHgNgHkvOQOv6FmjKsY24FTbbCaIAqEfDatUdDETwuOJLTgow9BnkFE90+n0SRoMrH1T
         MWWfRENJGW5mEnhw3yvE0erz/TOPiWgD51MAZc+pWVeMObPGwjpuKPf0K4R+XFwG3W5T
         16YTBixHONgmC6xHfI7eo4L+IlgykD1TDcqio5LPiYYKXYOu05MpzBQ2ei62Yj594TcM
         qvx4KFuC/Qs1yVu8rcPt210X96u4cwLIZlfmX9iWZHWmUA3E8KTfYyC5Hf/4T5ROiuO3
         KDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645426; x=1796250226;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/tS6CVqz0bwQhURF3f4/c8xLuOeYAnVMzoUdEwuEpSs=;
        b=JVff+zbJnFTT+9crbGtcVRoNd4z5/lw3eQp6Qkt6W00r2Q27qwq+ygE4fNSTRatn46
         AQ2FBCSI3Y61Xf7mdWOHBGw+SBHvYQwU5F2O/jDBML7u/KE/KgajaqLFRnM+0Jzd37Rm
         8Ox/AY8RjfoBXJ2oWtNWr2yxn9a+Rrjr46CbkSjEWIZ1M2zR4Q8L7sDe+ZhchJe4ruKF
         8gSxOfqY2RwtypR+Omw7YU/JjKSLakBTVTBnugl1JjKYvESLz57TGlzJWP7gs5KGKgkj
         zJQR5isSeuEbF/HB8kPutIMJk5RSfxQhkv9WQPf6XFu9cwE3yhCM4Zm7KODRhdCBCWSM
         fRKQ==
X-Forwarded-Encrypted: i=1; AL+hErFJWtwAsYpgvd1XtQooV52dL2Or0F8L/K8pgu3/GiNJTIo89C8JE7Xcdj7/ZEXoVOpggtDjRnk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ZQaVO/ERFUsYP0oemG+ycflI8xVELz3V4i1VgsopkI1p6YjIM
	QDPrg6ZjIenSvMKCBYqq0h6KbFSApJWqwqzP79UmI3j2vt9bEFxnH/iDP122IyeRuQxtAG5zL31
	IaQ==
X-Received: from dyblz33.prod.google.com ([2002:a05:7301:1621:b0:34c:9660:9612])
 (user=elkin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d205:b0:36a:1f8:a56e
 with SMTP id 5a478bee46e88-3856fe564a1mr19200647eec.23.1795645425499; Wed, 25
 Nov 2026 14:23:45 -0800 (PST)
Date: Wed, 25 Nov 2026 22:22:56 +0000
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
Message-ID: <20261125222300.1438398-2-elkin@google.com>
Subject: [PATCH net 1/4] nfc: st95hf: bound SPI receive length in st95hf_spi_recv_response()
From: Elkin Cruz <elkin@google.com>
To: David Heidelberg <david@ixit.cz>, Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, oe-linux-nfc@lists.linux.dev, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, irogers@google.com, 
	Elkin Cruz <elkin@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

st95hf_spi_recv_response() computes up to 1025 bytes of response length
from the 2-byte SPI header and reads the payload directly into
receivebuff without checking the destination buffer capacity. A
malformed or unexpected response overflows the 2-byte stack buffer in
st95hf_send_recv_cmd() or the 280-byte skb buffer in
st95hf_irq_thread_handler().

Pass the destination buffer capacity max_len to
st95hf_spi_recv_response() and reject lengths exceeding max_len with
-EMSGSIZE after deasserting chip-select via an empty trailing transfer.

This issue was found while trying out new Clang static analysis checks for
kernel bug classes. The finding was triaged and fixed, and this commit
description was drafted with the help of AI, then verified by code
inspection and compile-tested against linux-next (not reproduced and not
runtime-tested on hardware).

Fixes: cab47333f0f7 ("NFC: Add STMicroelectronics ST95HF driver")
Cc: stable@vger.kernel.org
Signed-off-by: Elkin Cruz <elkin@google.com>
---
 drivers/nfc/st95hf/core.c |  6 ++++--
 drivers/nfc/st95hf/spi.c  | 31 ++++++++++++++++++++++---------
 drivers/nfc/st95hf/spi.h  |  3 ++-
 3 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/nfc/st95hf/core.c b/drivers/nfc/st95hf/core.c
index dcc9e53815ca..d7ac7ede1259 100644
--- a/drivers/nfc/st95hf/core.c
+++ b/drivers/nfc/st95hf/core.c
@@ -283,7 +283,8 @@ static int st95hf_send_recv_cmd(struct st95hf_context *st95context,
 		unsigned char st95hf_response_arr[2];
 
 		ret = st95hf_spi_recv_response(&st95context->spicontext,
-					       st95hf_response_arr);
+					       st95hf_response_arr,
+					       sizeof(st95hf_response_arr));
 		if (ret < 0) {
 			dev_err(dev, "spi error from st95hf_spi_recv_response(), err = 0x%x\n",
 				ret);
@@ -800,7 +801,8 @@ static irqreturn_t st95hf_irq_thread_handler(int irq, void  *st95hfcontext)
 
 	mutex_lock(&stcontext->rm_lock);
 	res_len = st95hf_spi_recv_response(&stcontext->spicontext,
-					   skb_resp->data);
+					   skb_resp->data,
+					   MAX_RESPONSE_BUFFER_SIZE);
 	if (res_len < 0) {
 		dev_err(spidevice, "TISR spi response err = 0x%x\n", res_len);
 		result = res_len;
diff --git a/drivers/nfc/st95hf/spi.c b/drivers/nfc/st95hf/spi.c
index ffaf2789c406..a6599d65a3bf 100644
--- a/drivers/nfc/st95hf/spi.c
+++ b/drivers/nfc/st95hf/spi.c
@@ -66,21 +66,22 @@ EXPORT_SYMBOL_GPL(st95hf_spi_send);
 
 /* Function to Receive command Response */
 int st95hf_spi_recv_response(struct st95hf_spi_context *spicontext,
-			     unsigned char *receivebuff)
+			     unsigned char *receivebuff,
+			     size_t max_len)
 {
-	int len = 0;
-	struct spi_transfer tx_takedata;
-	struct spi_message m;
-	struct spi_device *spidev = spicontext->spidev;
 	unsigned char readdata_cmd = ST95HF_COMMAND_RECEIVE;
+	struct spi_device *spidev = spicontext->spidev;
+	struct spi_transfer tx_takedata;
 	struct spi_transfer t[2] = {
-		{.tx_buf = &readdata_cmd, .len = 1,},
-		{.rx_buf = receivebuff, .len = 2, .cs_change = 1,},
+		{ .tx_buf = &readdata_cmd, .len = 1 },
+		{ .rx_buf = receivebuff, .len = 2, .cs_change = 1 },
 	};
-
+	struct spi_message m;
+	int len = 0;
 	int ret = 0;
 
-	memset(&tx_takedata, 0x0, sizeof(struct spi_transfer));
+	if (max_len < 2)
+		return -EINVAL;
 
 	mutex_lock(&spicontext->spi_lock);
 
@@ -106,7 +107,19 @@ int st95hf_spi_recv_response(struct st95hf_spi_context *spicontext,
 	else
 		len += receivebuff[1];
 
+	if (len > max_len) {
+		dev_err(&spidev->dev, "spi_recv_resp, invalid response len = %d\n",
+			len);
+		memset(&tx_takedata, 0x0, sizeof(struct spi_transfer));
+		spi_message_init(&m);
+		spi_message_add_tail(&tx_takedata, &m);
+		spi_sync(spidev, &m);
+		mutex_unlock(&spicontext->spi_lock);
+		return -EMSGSIZE;
+	}
+
 	/* Now make a transfer to read only relevant bytes */
+	memset(&tx_takedata, 0x0, sizeof(struct spi_transfer));
 	tx_takedata.rx_buf = &receivebuff[2];
 	tx_takedata.len = len - 2;
 
diff --git a/drivers/nfc/st95hf/spi.h b/drivers/nfc/st95hf/spi.h
index 3ab678734c17..840f55f82899 100644
--- a/drivers/nfc/st95hf/spi.h
+++ b/drivers/nfc/st95hf/spi.h
@@ -45,7 +45,8 @@ int st95hf_spi_send(struct st95hf_spi_context *spicontext,
 		    enum req_type reqtype);
 
 int st95hf_spi_recv_response(struct st95hf_spi_context *spicontext,
-			     unsigned char *receivebuff);
+			     unsigned char *receivebuff,
+			     size_t max_len);
 
 int st95hf_spi_recv_echo_res(struct st95hf_spi_context *spicontext,
 			     unsigned char *receivebuff);
-- 
2.56.1.839.g22a8290db9-goog

