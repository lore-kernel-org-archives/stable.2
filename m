Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794495162;
	b=G6ZENJwdKEev0VIwYhSnNKAdkZx13mKtcv0ldPao+Q3co5PbyEXT1hVS/R8zVMy9NhqJ
	 zze+Tntf8n7lM76EuqGVAI4hIB94mcwoB1Ey4QclPQorjrfPI2P1aVSwD8UY9TobBKcAD
	 KbyhcDqf/4KbQW6FpDhoLZ7r7mDf1DWSERF4RESLd1xl6Mc8CnTtoRVWBQkWdecbRCAIi
	 l+smphvNy1t6xWG9LTTvSGEOxyEigwNtcWh7FrDMffamwH7imd2waQuNrK63mAZ0+itLg
	 wMq8o1h/lHGTO2KuIZSVyEsd8erGEplsCuzCuAnEWibuwp/SmOHq2J+kj73RyxQ6oLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794495162;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Q7Giv0YbZtbuh6pswUgbBS7Tjhq3TZVDrjjmxy0wKk8=;
	b=w9MJXbIO+Ghedf2REibTkY8DqIQD3cNa2h0j6zPrkIZrzK3PwYG9sJcYhAQE5o8/ssgM
	 SZSCtuk7j1fIXMYv7fYqQMZJ5bnXRWtrbZtQ4VLN1HNpmPZVbWT/4do/xspt8QvSRYJJa
	 ThA5QOkms+a/LTj7I/Klgo1/5gL//cIxok2caTYIrHX7kv2aeBGXBVtBfNMTAA1zdTCVL
	 KWaYyrMUEYHe4JsD1lnJ3z3m+o0/6Ceh5/Afy+QCKo6Dt0WnHbFpwxf3fPP+8vFUzH91J
	 L3Rlfako1ioEbAIAsnGe9K9PLFPRMfZ3fPUUITgPEA9CgTvoUk9Z1j+wyCW/9O5rUZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--atifashhar.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="XylA/s0o";
	arc=none smtp.remote-ip=209.85.215.198
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC8160A2606
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 14:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AC8160A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--atifashhar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XylA/s0o
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cdd9fa2a558so2072764a12.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 06:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794495160; x=1795099960; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q7Giv0YbZtbuh6pswUgbBS7Tjhq3TZVDrjjmxy0wKk8=;
        b=XylA/s0o/lm/yXiTzWdUkyKQ31nCiof9Ms5vJJZ8uKmBohwgsVRAmIirqxOWVkb6zB
         KzVWNIQjDfsOmZtKmblI9prPr1S3XIvZs947aBjSLP+mSu0ljJ3IOf2AlBDNAHKpUPSa
         jmGyHiqifPoTt+q0T/sFb3ff6X3pB0IfMRGgWpUXCyfoccoOnnvYLk0HneelkVoMRQ8Y
         1WU0FI5SFneA5xZ1WcWsCGzQXwJSegBJDYaakvYsr7Z+f6Avxs7nnPOdAAU4l+6F/znJ
         /liMfuW1AuAyp0vcfTZbQRTnCJDBx69T3vjDL6ac0PK+aToJBV0YLPNYnH84wSeZcImj
         QsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794495160; x=1795099960;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q7Giv0YbZtbuh6pswUgbBS7Tjhq3TZVDrjjmxy0wKk8=;
        b=d7sTETmp8U+PX1XVKPncMmaJG3pobgGeeuamuoFS6fh3cMwmiip7TubwntlfeplJxU
         /qoK544CVYt0L7Fd4x09/B5j2ATNYnnhtXLCMo/uxSOuDbKcCfuMG8VE1Pi37pgl+HTQ
         MWRuAfhOz5SZXdIuzhye6etGeXqjMTn5RS4NNavFEYxiwS2unPQHRHqSpzV+BOl2EzUn
         EMkRxzP8aP/jC96hSd7VhcMoYSH7iQMkYag8Od8pvU+QUTIsPrPpnJJhki/jLPfA9Zeh
         tHOIkL83yIt200nlt3OKFIXXxcb9Ez00JBr3BRzWpDmMMwUWiPcPBPPZcDLN7jmZNY5e
         5gjg==
X-Forwarded-Encrypted: i=1; AL+hErFlt6Kc5EmnAFQMyJXVck1Md3My3cHBj96QGhvZUHmVrjs329DRe1s+89hCmjW8zKqtveLUBII=@vger.kernel.org
X-Gm-Message-State: APuU4Z/YLX9kKMfxBItclCorqvxUYIaeZK3RiQWviJjnNEEEe1GiYRYz
	00Kx0tZxXackPXFa5ALHLXPwg8Nhk0tedmNz33tR2T0QqFLjVFxuaRuyXv6et7+Kz0mb5E+3RNC
	1kL9brl8X5X0FtJvQEd0YVw==
X-Received: from pgtl16.prod.google.com ([2002:a65:6810:0:b0:cdd:aaa7:beae])
 (user=atifashhar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:138c:b0:3ed:bdfd:23a8 with SMTP id adf61e73a8af0-3f2fedddad3mr6395544637.61.1794495159901;
 Thu, 12 Nov 2026 06:52:39 -0800 (PST)
Date: Thu, 12 Nov 2026 14:52:38 +0000
In-Reply-To: <20261104133745.1432212-1-atifashhar@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261104133745.1432212-1-atifashhar@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261112145238.3736264-1-atifashhar@google.com>
Subject: [PATCH v2] i2c: designware: Release slave SCL hold in __i2c_dw_disable()
From: Atif Ashhar <atifashhar@google.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@kernel.org>, 
	Luis Oliveira <Luis.Oliveira@synopsys.com>, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Atif Ashhar <atifashhar@google.com>
Content-Type: text/plain; charset="UTF-8"

When an external I2C master initiates a read to the Synopsys DW_apb_i2c
adapter in slave mode during kexec teardown, runtime suspend, or driver
unbind, the slave hardware stretches SCL low (0V) waiting for TX data,
setting DW_IC_STATUS_SLAVE_HOLD_TX_FIFO_EMPTY.

In master mode, __i2c_dw_disable() issues DW_IC_ENABLE_ABORT to release
the bus. However, according to the Synopsys DW_apb_i2c Databook, the
ABORT bit applies only to master transfers and has no effect in slave
mode. Because the slave cannot disable while stretching SCL,
__i2c_dw_disable() times out, leaving DW_IC_ENABLE_STATUS[0] = 1 across
kexec or rebind. Subsequent writes to DW_IC_SAR are write-protected and
silently dropped by hardware, wedging the slave and blocking any other
devices sharing the physical bus.

Fix this by:

1. In __i2c_dw_disable(), if DW_IC_STATUS_SLAVE_HOLD_TX_FIFO_EMPTY is
   set while disabling, temporarily re-enable the controller so the APB
   interface accepts data commands without racing with the slave ISR,
   clear pending RD_REQ/TX_ABRT interrupts, write a dummy 0xff byte to
   DW_IC_DATA_CMD to release the SCL stretch, and immediately request
   disable via __i2c_dw_disable_nowait(). Also drain the RX FIFO if RFNE
   is set during SLAVE_ACTIVITY.

2. In i2c_dw_reg_slave(), replace __i2c_dw_disable_nowait() with
   __i2c_dw_disable() to ensure the controller is fully disabled before
   calling i2c_dw_set_mode(), which programs DW_IC_SAR and DW_IC_CON.

Fixes: 9f3e065c54b0 ("i2c: designware: add SLAVE mode functions")
Cc: stable@vger.kernel.org
Signed-off-by: Atif Ashhar <atifashhar@google.com>
---
Changes since v1:
- Use lowercase 0xff instead of 0xFF in regmap_write(), comments, and commit
  message (Mika Westerberg).
- Explained on the v1 thread why writing a dummy 0xff byte to DW_IC_DATA_CMD
  does not generate unintended bus traffic when immediately followed by
  __i2c_dw_disable_nowait().

Link: https://lore.kernel.org/linux-i2c/20261104133745.1432212-1-atifashhar@google.com/ [v1]
 drivers/i2c/busses/i2c-designware-common.c | 46 ++++++++++++++++++++++
 drivers/i2c/busses/i2c-designware-slave.c  |  2 +-
 include/linux/designware_i2c.h             |  1 +
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index a1eca6cd4b75..46866baa9d9c 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -619,6 +619,50 @@ static int i2c_dw_set_sda_hold(struct dw_i2c_dev *dev)
 	return ret;
 }
 
+/*
+ * DW_IC_ENABLE_ABORT only aborts master transfers. If the adapter is acting
+ * as a slave and holding SCL low waiting for TX data (SLAVE_HOLD_TX_FIFO_EMPTY),
+ * hardware refuses to disable (IC_ENABLE_STATUS[0] stays 1) until a byte is
+ * written to DW_IC_DATA_CMD.
+ *
+ * Mask interrupts and temporarily set DW_IC_ENABLE_ENABLE so the APB interface
+ * accepts writes to the TX/RX FIFOs without racing with the slave ISR, clear
+ * pending RD_REQ/TX_ABRT interrupts, feed a dummy 0xff byte to release SCL
+ * (or drain any pending RX byte), and immediately request disable again via
+ * __i2c_dw_disable_nowait() so the controller initiates disable upon
+ * completing the current byte.
+ */
+static void i2c_dw_release_slave_hold(struct dw_i2c_dev *dev)
+{
+	unsigned int status, dummy;
+	bool tx_hold, rx_pending;
+
+	if (!IS_ENABLED(CONFIG_I2C_DESIGNWARE_SLAVE) || dev->mode != DW_IC_SLAVE)
+		return;
+
+	regmap_read(dev->map, DW_IC_STATUS, &status);
+
+	tx_hold = status & DW_IC_STATUS_SLAVE_HOLD_TX_FIFO_EMPTY;
+	rx_pending = (status & DW_IC_STATUS_SLAVE_ACTIVITY) &&
+		     (status & DW_IC_STATUS_RFNE);
+
+	if (!tx_hold && !rx_pending)
+		return;
+
+	regmap_write(dev->map, DW_IC_INTR_MASK, 0);
+	regmap_write(dev->map, DW_IC_ENABLE, DW_IC_ENABLE_ENABLE);
+
+	if (tx_hold) {
+		regmap_read(dev->map, DW_IC_CLR_RD_REQ, &dummy);
+		regmap_read(dev->map, DW_IC_CLR_TX_ABRT, &dummy);
+		regmap_write(dev->map, DW_IC_DATA_CMD, 0xff);
+	}
+	if (rx_pending)
+		regmap_read(dev->map, DW_IC_DATA_CMD, &dummy);
+
+	__i2c_dw_disable_nowait(dev);
+}
+
 void __i2c_dw_disable(struct dw_i2c_dev *dev)
 {
 	struct i2c_timings *t = &dev->timings;
@@ -676,6 +720,8 @@ void __i2c_dw_disable(struct dw_i2c_dev *dev)
 		if (!(status & 1))
 			return;
 
+		i2c_dw_release_slave_hold(dev);
+
 		/*
 		 * Wait 10 times the signaling period of the highest I2C
 		 * transfer supported by the driver (for 400kHz this is
diff --git a/drivers/i2c/busses/i2c-designware-slave.c b/drivers/i2c/busses/i2c-designware-slave.c
index 0abcc7757b23..e51a6b60292a 100644
--- a/drivers/i2c/busses/i2c-designware-slave.c
+++ b/drivers/i2c/busses/i2c-designware-slave.c
@@ -40,7 +40,7 @@ int i2c_dw_reg_slave(struct i2c_client *slave)
 		return ret;
 
 	pm_runtime_get_sync(dev->dev);
-	__i2c_dw_disable_nowait(dev);
+	__i2c_dw_disable(dev);
 	dev->slave = slave;
 	i2c_dw_set_mode(dev, DW_IC_SLAVE);
 
diff --git a/include/linux/designware_i2c.h b/include/linux/designware_i2c.h
index 53f37f18a722..113a9d84e34d 100644
--- a/include/linux/designware_i2c.h
+++ b/include/linux/designware_i2c.h
@@ -100,6 +100,7 @@
 #define DW_IC_STATUS_MASTER_ACTIVITY		BIT(5)
 #define DW_IC_STATUS_SLAVE_ACTIVITY		BIT(6)
 #define DW_IC_STATUS_MASTER_HOLD_TX_FIFO_EMPTY	BIT(7)
+#define DW_IC_STATUS_SLAVE_HOLD_TX_FIFO_EMPTY	BIT(9)
 
 /* DW_IC_SMBUS_INTR_* bits */
 #define DW_IC_SMBUS_INTR_ALERT			BIT(10)
-- 
2.56.0.567.gdb80ae8cd5-goog

