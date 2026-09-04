Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66E133A9CF;
	Fri,  4 Sep 2026 13:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527299; cv=none; b=spAzBtV0OVbW/bF6KpjI5Hl6DOCIHj7iovsHpeHmYem6KKzwFYTKfz674EO4rW3icD0GdMOZpycjQ6U8CMR3cJ3QAsvBKGYMm3sLVnWvDA0dbY1rwMzaPriV4xMNReNPuQI2uxRWLuF/3FkvAL7E2esK+PVB+lW9JH526E+aRvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527299; c=relaxed/simple;
	bh=oSQ1tgTxjQ/nAh6wKbjk9v6VA6GjgDtaHqqb9wNHM6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uuBRf+2z/AOGhqXGkeKV+tcTFsQRz+W0kTR2zrL0ICeAP+LIYChjidRHvl+sipm7Wek1QuqKeh3yfAYLculxISMR9EIEMRMKKrgXGTfXQVlnrlHfo7g2eHQXDnQcqkOMSuqqlCqx/TM7rJKZiSUpRl+PYhtBW99g1mzKfM8JGKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=tLw1L+fS; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=U07lkFxg; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="tLw1L+fS";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="U07lkFxg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788527287; bh=oSQ1tgTxjQ/nAh6wKbjk9v6VA6GjgDtaHqqb9wNHM6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tLw1L+fSwv9udcVuKcdA6HAheKhtKV0UzmHwGCf4NeLSgOZU8PcScs9diaMorPS7P
	 5EyvcWP8VfEi96Sp/Ud2j2wKs8OBmDvObHe+m3lCmDUjhVfJTI5vQQAGL5niepRChw
	 St+eJrdCfHeazxyNiD+VRwIIrsvb+Yfq5w4Nd2khCFeMzFjv9JOBVjDv5utRoCvU5G
	 PPEPP3kVpJJV2xikDoldOof2/4rHkfzdRORFFuBMdJXfSoCsFQ9G+IHbMg8mapqdAi
	 s9UwbRISnvRUYjfUH7nADq43Ata+6tnItN3F7n4/jLtMOjuWU0rwzLpwDiCY0aAHkD
	 90Cp0zbb7Wa/Q==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 4D8D54144C; Fri, 04 Sep 2026 14:08:07 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1788527284; bh=oSQ1tgTxjQ/nAh6wKbjk9v6VA6GjgDtaHqqb9wNHM6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U07lkFxgsmhJJNPxk20xKniDXHGBb+rinGojK6mKF7KdHia765FApiTRlxKukq4tw
	 mGqVWVxzzQaM09lZP9P4amvqjPYssds2oqjsySOvOrkrEmLluVRaP9VrjVNpIkohgt
	 3UwN7zrRNhUjaxRuAah/MonPM9UYJ08TcteJUc4KExd6tThtGgOtMxNch9Hievq4Hf
	 buYFymCbWnvIZ0jH+jdLWyaYIVQDY9fKUp5FEen5GZwazekzE1ouknuDSPHqVhJpe/
	 4jNQQqP42WLGaa0/V4oeembTcOTP1kI9x44+HpDQUvJLTTRdGg35VrPmnJusAHvA2v
	 RykoKzfrGyIAw==
Received: from maru.mess.org (hephaestus.mess.org [82.68.61.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id C90834145E;
	Fri, 04 Sep 2026 14:08:04 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Rik van Riel <riel@surriel.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 15/17] media: serial_ir: Fix race condition where timer can be re-armed
Date: Fri,  4 Sep 2026 14:07:43 +0100
Message-ID: <29986d0b254c38a154ba0683fe988d6412d5722e.1788526920.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788526920.git.sean@mess.org>
References: <cover.1788526920.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure the timer is deleted after the irq is freed, but before rcdev.

Fixes: 2940c7e49775 ("[media] serial_ir: generate timeout")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/serial_ir.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/media/rc/serial_ir.c b/drivers/media/rc/serial_ir.c
index 992fff82b524..35741a8da63a 100644
--- a/drivers/media/rc/serial_ir.c
+++ b/drivers/media/rc/serial_ir.c
@@ -481,6 +481,11 @@ static int serial_ir_tx_carrier(struct rc_dev *dev, u32 carrier);
 static int serial_ir_open(struct rc_dev *rcdev);
 static void serial_ir_close(struct rc_dev *rcdev);
 
+static void devm_timer_delete_sync(void *timer)
+{
+	timer_delete_sync(timer);
+}
+
 static int serial_ir_probe(struct platform_device *dev)
 {
 	struct rc_dev *rcdev;
@@ -535,6 +540,11 @@ static int serial_ir_probe(struct platform_device *dev)
 
 	timer_setup(&serial_ir.timeout_timer, serial_ir_timeout, 0);
 
+	result = devm_add_action_or_reset(&dev->dev, devm_timer_delete_sync,
+					  &serial_ir.timeout_timer);
+	if (result)
+		return result;
+
 	result = devm_request_irq(&dev->dev, irq, serial_ir_irq_handler,
 				  share_irq ? IRQF_SHARED : 0,
 				  KBUILD_MODNAME, &hardware);
@@ -798,7 +808,6 @@ static int __init serial_ir_init_module(void)
 
 static void __exit serial_ir_exit_module(void)
 {
-	timer_delete_sync(&serial_ir.timeout_timer);
 	serial_ir_exit();
 }
 
-- 
2.55.0

