Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D0429BD91;
	Sat, 27 Jun 2026 11:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782559087; cv=none; b=ML8ylzIV26iFzXjod6v8ybAqLiKq2ql6RrzN+IurfHS4ln37opnFxA9zx8N0dl3h2eU7mnxTDSzK8m913QK4RvqFbHPT+8kheZ1Uqnn4AtudvsMRjOTklPB1GwerCennUlekW6Dws7ktz4Gw7jxJbgwRbvzXp/7ZfE/Z0wN7+9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782559087; c=relaxed/simple;
	bh=3bIsUhwary1MnhDUguZeAmgFGRXDhS6tbmorYQN4XkM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cB9y2eDW+xti91jnJFaNBUzgVygDnb68SmC47BuFyD3PPgRlusbDGrt4PUJk2GncExI5RHXjbhLuw43dTOzBSkBfvXFWjbNc0YLOdZ4OhNjnmFnDZHYg3GO40vreogHZZpcBup3J+l3yTyqmMFpLz/cMsgWrcajJit88cGzfCmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=4AufVSPT reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="4AufVSPT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=7L/0ht5SSW
	jab3/h55lZ1197QJFY7w7tW0N5P6EhLb4=; b=4AufVSPTPjhdwOhwM/N/mn/wSC
	IE06qnnV9D5ItTeIIHo9bwtrYgYyyNk94PKVnonyi82OQmCEnI0qC7m897Q2zHl/
	FCXvBfiHPU5Iry3VSseeaJZRTU/kzRvrs7q9nab0CvONqnN2tLl07aUDQnSVZbDX
	zV0GJDSM8CatlkhTw=
Received: from wmy.localdomain (unknown [113.200.174.100])
	by hzbj-edu-front-2.icoremail.net (Coremail) with SMTP id BLQMCkCm6zBesT9qx7UfAA--.57131S2;
	Sat, 27 Jun 2026 19:17:54 +0800 (CST)
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
To: jdelvare@suse.com,
	andi.shyti@kernel.org
Cc: wsa@kernel.org,
	hkallweit1@gmail.com,
	djkurtz@chromium.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH v3] i2c: i801: Fix hardware state machine corruption and stack-out-of-bounds
Date: Sat, 27 Jun 2026 19:17:49 +0800
Message-Id: <20260627111749.482415-1-25181214217@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BLQMCkCm6zBesT9qx7UfAA--.57131S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuw4fur18uw43KF43Zw4xJFb_yoW7Xr18p3
	yjk3s09w4DJF4akFn8Ja1rZFyF9an5Kay5GFnrtw1DZa1akw1rA348tFyY9F4vy34vvay3
	Za4jvF17uF4DA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9K14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr
	0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_Gw4l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU0eHDDUUUU
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAgUREWo+l3Nq+AABsk

Under extreme conditions (e.g., fault injection or transaction timeouts),
the i801 SMBus controller driver exhibits two error handling issues:

1. When i801_check_pre() fails, the driver jumps to the 'out' label
   and clears the INUSE_STS and status flags without holding hardware
   ownership, corrupting the hardware state machine.

2. When a transaction aborts and returns from i801_access(), the
   stack-allocated union i2c_smbus_data is destroyed. However,
   priv->data is not cleared. A spurious interrupt can then trigger a
   stack-out-of-bounds read in i801_isr_byte_done(), caught by KASAN:

  BUG: KASAN: stack-out-of-bounds in i801_isr_byte_done drivers/i2c/busses/i2c-i801.c:592 [inline]
  BUG: KASAN: stack-out-of-bounds in i801_isr drivers/i2c/busses/i2c-i801.c:648 [inline]
  Read of size 1 at addr ffff8881026dfd91 by task in:imklog/218

  CPU: 2 UID: 0 PID: 218 Comm: in:imklog Tainted: G        W        N  7.1.0+ #1
  Call Trace:
   <IRQ>
   ...
   kasan_report+0xca/0x100 mm/kasan/report.c:595
   i801_isr_byte_done drivers/i2c/busses/i2c-i801.c:592 [inline]
   i801_isr drivers/i2c/busses/i2c-i801.c:648 [inline]
   __handle_irq_event_percpu+0x222/0x830 kernel/irq/handle.c:209
   ...
   </IRQ>

Fix these issues by:
- Bypassing hardware register cleanup if i801_check_pre() fails.
- Fetching priv->data via READ_ONCE() into a local variable in the ISR
  to prevent compiler reloading across I/O barriers, paired with
  WRITE_ONCE() in the exit path.
- Calling synchronize_irq() conditionally on the error path (only if
  a transaction was actually initiated) before returning to ensure any
  in-flight ISR finishes before stack memory is reclaimed.

Fixes: 1f760b87e54c ("i2c: i801: Call i801_check_pre() from i801_access()")
Fixes: d3ff6ce40031 ("i2c-i801: Enable IRQ for byte_by_byte transactions")
Cc: stable@vger.kernel.org
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
Changes in v3:
 - Fetched priv->data into a local variable using READ_ONCE() in the ISR
   to prevent compiler reloading across I/O barriers, addressing a
   potential NULL pointer dereference on the success path.
 - Wrapped the error path cleanup in `if (priv->data)` to safely bypass
   synchronize_irq() when i801_check_pre() fails.

Changes in v2:
 - Split error paths to bypass hardware register cleanup on pre-check
   failure.
 - Added READ_ONCE() check in ISR to prevent OOB access.
 - Conditionally use WRITE_ONCE() and synchronize_irq() on the error
   path to prevent race condition without performance regression.

 drivers/i2c/busses/i2c-i801.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 32a3cef02c7b..0275e828646d 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -562,6 +562,16 @@ static int i801_block_transaction_by_block(struct i801_priv *priv,
 
 static void i801_isr_byte_done(struct i801_priv *priv)
 {
+	u8 *data;
+
+	/*
+	 * Fetch the pointer once into a local variable to prevent compiler
+	 * reloading across I/O barriers, which could cause a NULL dereference.
+	 */
+	data = READ_ONCE(priv->data);
+	if (unlikely(!data))
+		return;
+
 	if (priv->is_read) {
 		/*
 		 * At transfer start i801_smbus_block_transaction() marks
@@ -574,12 +584,12 @@ static void i801_isr_byte_done(struct i801_priv *priv)
 				/* FIXME: Recover */
 				priv->len = I2C_SMBUS_BLOCK_MAX;
 
-			priv->data[-1] = priv->len;
+			data[-1] = priv->len;
 		}
 
 		/* Read next byte */
 		if (priv->count < priv->len)
-			priv->data[priv->count++] = ioread8(SMBBLKDAT(priv));
+			data[priv->count++] = ioread8(SMBBLKDAT(priv));
 		else
 			pci_dbg(priv->pci_dev, "Discarding extra byte on block read\n");
 
@@ -589,7 +599,7 @@ static void i801_isr_byte_done(struct i801_priv *priv)
 			       SMBHSTCNT(priv));
 	} else if (priv->count < priv->len - 1) {
 		/* Write next byte, except for IRQ after last byte */
-		iowrite8(priv->data[++priv->count], SMBBLKDAT(priv));
+		iowrite8(data[++priv->count], SMBBLKDAT(priv));
 	}
 }
 
@@ -905,7 +915,7 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 
 	ret = i801_check_pre(priv);
 	if (ret)
-		goto out;
+		goto out_err;
 
 	hwpec = (priv->features & FEATURE_SMBUS_PEC) && (flags & I2C_CLIENT_PEC)
 		&& size != I2C_SMBUS_QUICK
@@ -938,6 +948,19 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 	 */
 	iowrite8(SMBHSTSTS_INUSE_STS | STATUS_FLAGS, SMBHSTSTS(priv));
 
+out_err:
+	/*
+	 * Prevent UAF/OOB in the ISR.
+	 * If priv->data is non-NULL, a transaction was initiated.
+	 * For timed-out or aborted transactions (ret != 0), flush any
+	 * in-flight interrupts before destroying the stack-allocated data.
+	 */
+	if (priv->data) {
+		WRITE_ONCE(priv->data, NULL);
+		if (unlikely(ret != 0 && (priv->features & FEATURE_IRQ)))
+			synchronize_irq(priv->pci_dev->irq);
+	}
+
 	pm_runtime_put_autosuspend(&priv->pci_dev->dev);
 	mutex_unlock(&priv->acpi_lock);
 	return ret;
-- 
2.34.1

