Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A5842980D;
	Wed, 29 Jul 2026 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338594; cv=none; b=Zlkshp/6KIDlAy90C2zMkrN8FToE5efT3BXFRXiVFZi7ildOllruqbkfTo68ks4w2nkc5BDshlTeNupDovN3DZRl9HCqNbuI5AtyaEE3zANV+nDJavmj31hZMYApDVMPs7sYoYf7oMwUmEJ5HQTxwrw74COeeFBsDkEXb8wzGJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338594; c=relaxed/simple;
	bh=Vqnoc/HG6KBIH/2BotzWGk/HYm00jme5eSftcFPtvgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nSOLaqyRKsMdKtd16wjTJoSgfe54+Vxv7zX38hE5fg1XWvaX+A8CWA9tAmutB54t7y7H7md+IxtD+l9ewROwoDaFwyF90wqx70uWO9OQ7yOv+Jsyc73UNEOcbbSsM6pakniJIG/Z2I2NUSOHQPMD3qYvhCAHALYFoerOXTSL1mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=QkPs+Yst; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=Y+lrRDKB; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="QkPs+Yst";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="Y+lrRDKB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785338591; bh=Vqnoc/HG6KBIH/2BotzWGk/HYm00jme5eSftcFPtvgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QkPs+YstqLURZ8DFFrNQ35KytbUqOD2mbxg/UNzxFsvyblkU9/fJLyMQ6cl+7BS5e
	 VUZhDoHntezK9geyITeRAYHpm2KaF410g7Ygz5eDBHJ6ziHwF0/E6NGYQroecPxOrs
	 fGqAl+gdMxQtDJp3v4ohYOxvglbZuBEGA2OxjbfCaJ42lL3jixH6G3112eIM4Wn398
	 SUelToW67kcn+2cVL+NICanRzMwlYYY7MDk86fbGeyiUopR/5DjTacCb4BITQknjP4
	 D1YFRCMFuVBaEgv40o98D898hIrDXkzOCicP01Rp0/VK3782G8HrK03hiUV00nw2IM
	 KemkJYvXe7kWA==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 45E8342538; Wed, 29 Jul 2026 16:23:11 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785338590; bh=Vqnoc/HG6KBIH/2BotzWGk/HYm00jme5eSftcFPtvgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y+lrRDKB6J5SE9Dh2Bz/GG03qgS/mKf7ilMsw3c7M6MTGm7/HOQUwkdoNGjgcjzK2
	 Ss9tkK0CIvwNAPFEcU3oiG4vN8UZgrxgAWXG4zScW2r6z5Gntvxwnm/qVwxKdeGn5G
	 9Dg2/v3HZttnI1uh5OYTTZQrEHw5YdbCZsLdIulvylhsfUDRBysskpL73fw2+h8uN9
	 7IebxXIEAOPD4UyXtMzUNtlbQoKRwiJLNaMPyOSMZllablbryhztdfoufE0RB6LrjS
	 T0yClYBA1QNwc6TaV5P+SHU3SLbYaEHWvGPmudJBxa7NXcTMNxmb8WACSwfTQdal7p
	 0VLTWEwQMKGJQ==
Received: from maru.local (unknown [62.232.99.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id B705C41567;
	Wed, 29 Jul 2026 16:23:10 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jarod Wilson <jarod@redhat.com>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 03/15] media: redrat3: Ensure we don't read beyond the end of the packet
Date: Wed, 29 Jul 2026 16:22:41 +0100
Message-ID: <02a645b403ea4b066e363c42abc9aa23646c5fe1.1785338381.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785338381.git.sean@mess.org>
References: <cover.1785338381.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The length and offset is provided by the usb device, so it should be
validated.

Fixes: 2154be651b90 ("[media] redrat3: new rc-core IR transceiver device driver")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/redrat3.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/media/rc/redrat3.c b/drivers/media/rc/redrat3.c
index 2b639fe59923..f86efcb74e6e 100644
--- a/drivers/media/rc/redrat3.c
+++ b/drivers/media/rc/redrat3.c
@@ -358,8 +358,24 @@ static void redrat3_process_ir_data(struct redrat3_dev *rr3)
 
 	/* process each rr3 encoded byte into an int */
 	sig_size = be16_to_cpu(rr3->irdata.sig_size);
+
+	/*
+	 * Note we are not checking if we are reading beyond the end of the
+	 * packet which was sent, and reading stale data. If the device
+	 * sends a packet which is short then we get garbage IR, but no
+	 * out of bounds read.
+	 */
+	if (sig_size > RR3_MAX_SIG_SIZE) {
+		dev_err(dev, "length %u is incorrect\n", sig_size);
+		return;
+	}
+
 	for (i = 0; i < sig_size; i++) {
 		offset = rr3->irdata.sigdata[i];
+		if (offset >= RR3_DRIVER_MAXLENS) {
+			dev_err(dev, "offset %u is incorrect\n", offset);
+			return;
+		}
 		val = get_unaligned_be16(&rr3->irdata.lens[offset]);
 
 		/* we should always get pulse/space/pulse/space samples */
-- 
2.55.0

