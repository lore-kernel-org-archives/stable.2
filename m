Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792962180;
	b=VFza5ZDOE/XIkdXJYMOprpVHwR0qpH43iC1HeuXxQ0syvsmWYrwDvDNE4aC0vTm3NpoH
	 sdja3RVuD6edfHIFgk/6Z+sLYo9ne/Dmn9BjaYY5YjwVE6Fvjn5OKTh/Y06zAVYeGsvZL
	 MJoa26NKU7/4ai6b2nRE7aw9XCQNxKd5Ih/EahJcbGXLWPcFbkRnbp45MgwKYudD+PxhB
	 ApA1yH2lVbkc/zko+6uvsAGLAaIxFpThpqEOctGEbiVABfKugnJQfkKenMEO4mXuQZndW
	 TGPyOfh5cGLigDyAti4gpiQbRp431dP3wO5/C65B554RBOCkJXzV1RrsoKBHFiSuQKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792962180;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZvdM/zwudCibbhvG92/DAjuffztDVUyeE/Q5y2G9nAA=;
	b=v3dMpeXSEpYn0Es1saAy0g19SfT9hySAaNkh+nTKQSQsbSC/3ULuS/VOzI0V+qZNqpBK
	 M8XH4pHfg8xChS9+uO/6Py54MR5BWVyrZS9KQPx5dn0U4L5dSZsP44+C0O/Bo0xW1iPcY
	 Zy5oZ+F04QC+XcVnSw127/BSQGTQFjrrnSokWvwJxh5wSboznkVAVZR6TeSoAIAy9CuyK
	 6Zxq6t0ZrQKdFTORoY27IHXpmSaP5k/xNNogJmWzLPPl1U9TGSU85qRgJ36bPjWefNdJz
	 nOcK1rpAPCkIuBuLDeAh4Bkm+u2YYjrClyJ+8VI2v6DL4+iUj6UWIcr5MRRQG5NTkLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C6kwohrd;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A20E606A31B
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 21:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A20E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C6kwohrd
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48e20edd106so2081827f8f.1
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 14:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792962178; x=1793566978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZvdM/zwudCibbhvG92/DAjuffztDVUyeE/Q5y2G9nAA=;
        b=C6kwohrdRBvofaSx1qmnvQje7E8iuZTJCsv53d4XxPyaSu4EcbbdgBCp9JFbmvFlhy
         YXNyoy9oAMVj5h5rDBeBAATHEMAbXMhftcsNERr5mCx5xsu0rrnPYIauxlazNmaaxEem
         xaLd+2K/zAOl5wGuoqf2lAuBdBOEt48a8AUcCNYFlI13TnS+Vfvay1nbvRIRgq6QAWm5
         KokiwBqbVbTd8q7lhrEwTLewDBLXNaUXIQm8UpDf6LYpUTv4LvZ0xMJ1MDvITkmUGegb
         4qeC+skOZmZm0phpdCvmjbjLf24Zdcn+aunV48yuwYoPDqZAsvgo07aNobvzsdTUnVdN
         DqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792962178; x=1793566978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZvdM/zwudCibbhvG92/DAjuffztDVUyeE/Q5y2G9nAA=;
        b=tKNMH+Q9D29DiXBBD0vJofQWlHDZCJrv4vdtckze2m6R9m/04wWt1ainz2RvYEFED3
         5JK8kkXG+tjODiKG9DITHnt+5deClVGpblzulSfiX7cHteSM5jCsDY4Uz6VujhU6PwZf
         uw3SI0zv8QNgSWC32OKYpUt8Gai1UC2xbqLfVkmv4P1mKRJBnP2wqdPvY0te/8MWFk1Y
         BXCeae59RxGNZ2ZaoqpRSZEWeBl9B2QuWSQW+bYx+0dodIslRmV2dZR25JsI2R15Po3G
         wH7V73g/lqM0bUzY+HI1OYbXbeh7TU8UD1vMACpKRG846GLk2bScrgl/L8nY+GMKegii
         wPnA==
X-Forwarded-Encrypted: i=1; AKwUvBxTYp3fTLZX4wt3wu9P4PhR1/k5eC4xSmC64dkVfoLAB6OUA2RJwVweB5IVWSdNH5fJuoIfJ1w=@vger.kernel.org
X-Gm-Message-State: AFq9FYI3ZWpgn4m52/YLQyqal+qjGXMgccoWV9BUQDmp2VKkH9l+n4W+
	cnJZHJ3eN1zJoziV/9ZiHW5/GqJqqg85oSWEvX24hjc68zklnIQqmlo=
X-Gm-Gg: AYBFou08bt1k0fqBz5w60MBT0QxyK9zyMTsDb+xTldjdyb40E0sptYH+8yQSd7VjnV9
	xKbAg7gGzV/+4k0Ps8AnVEdKVru45QMPJDDV2MpCaFTHNcHBahJvqhBKuEfzb0qIBqdoOGdwyd6
	t9hDgNNjRtadWKfcIu6xa0n+Fpu90/L88QzpJGHfcxOwEdobfimQMXf4K5GkFfVK+LN4tpQG3tU
	SUR5roK24EvAMXP5nXAoWznSBwTCEiCI2hpav1JBrud1N1e/r/QvBVmFp7WAPYOBxh85coSiYMR
	N77KPB6rC2vPvGjYZClfHFtS2M3PFBItJtpziOA6TVuHJX7BEmVAwUYYak713Zet+kEX1lbma/6
	mtIBZ3M0r3q4/LsNRR5H/xOK/v5+osEXNrpirGU0ZYLiy9uEcmcC+dn3Ng+FHlVVLruFandqFaX
	spvpxLTE3mvFmeVaijrEnTWMa8WJQzkwn1uv5G83jrpm/f6185T4mxigWxBd06qiQdj3teqonVR
	m0FLLkO8r5plULCTyz1W1PPxZ8ZkuiEoWNJ1w==
X-Received: by 2002:a5d:4743:0:b0:48d:f249:82c3 with SMTP id ffacd0b85a97d-48e3eb8b816mr5791876f8f.30.1792962177683;
        Sun, 25 Oct 2026 14:02:57 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb8f36asm12289177f8f.1.2026.10.25.14.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 14:02:56 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org,
	mkl@pengutronix.de,
	socketcan@hartkopp.net,
	s.grosjean@peak-system.com,
	stable@vger.kernel.org
Subject: [PATCH v2 net] can: peak_usb: fix use-after-free on PCAN-USB disconnect and init failure
Date: Sun, 25 Oct 2026 21:02:56 +0000
Message-ID: <20261025210256.629830-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023195400.3531721-1-tristan@talencesecurity.com>
References: <20261023195400.3531721-1-tristan@talencesecurity.com>
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

The PCAN-USB adapter uses a restart_timer for bus error recovery
but does not define a dev_free callback.  When the device is
unplugged, peak_usb_disconnect() frees the candev without cancelling
the timer.  If a bus error armed the timer and USB disconnect races
with the timer callback, the timer fires on freed memory.

The same timer is initialized in pcan_usb_init() via timer_setup(),
but on error (e.g. failed USB command to read the serial number) the
function returns without cancelling it.  Because dev_init failure in
peak_usb_create_dev() jumps to lbl_unregister_candev and skips the
adap_dev_free label, the dev_free callback is never invoked either.

Add a pcan_usb_free() callback that calls timer_shutdown_sync() on
the restart_timer, register it as the adapter dev_free handler, and
also cancel the timer directly in pcan_usb_init() on error before
returning.

Fixes: 46be265d3388 ("can: usb: PEAK-System Technik PCAN-USB specific part")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 8fd058c328564e..440d8e2cfb6fe6 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -882,6 +882,14 @@ static int pcan_usb_start(struct peak_usb_device *dev)
 	return pcan_usb_set_ext_vcc(dev, 0);
 }
 
+static void pcan_usb_free(struct peak_usb_device *dev)
+{
+	struct pcan_usb *pdev =
+		container_of(dev, struct pcan_usb, dev);
+
+	timer_shutdown_sync(&pdev->restart_timer);
+}
+
 static int pcan_usb_init(struct peak_usb_device *dev)
 {
 	struct pcan_usb *pdev = container_of(dev, struct pcan_usb, dev);
@@ -901,6 +909,7 @@ static int pcan_usb_init(struct peak_usb_device *dev)
 		dev_err(dev->netdev->dev.parent,
 			"unable to read %s serial number (err %d)\n",
 			pcan_usb.name, err);
+		timer_shutdown_sync(&pdev->restart_timer);
 		return err;
 	}
 
@@ -1051,6 +1060,7 @@ const struct peak_usb_adapter pcan_usb = {
 	.dev_decode_buf = pcan_usb_decode_buf,
 	.dev_encode_msg = pcan_usb_encode_msg,
 	.dev_start = pcan_usb_start,
+	.dev_free = pcan_usb_free,
 	.dev_restart_async = pcan_usb_restart_async,
 	.do_get_berr_counter = pcan_usb_get_berr_counter,
 };
-- 
2.47.3

