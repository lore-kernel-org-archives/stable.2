Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61D831A555;
	Thu, 23 Jul 2026 03:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784778231; cv=none; b=iQhXeW2OhVb84vDVw5OlkgkRynFxqceaoYAVTCyFSO9ADO7Lg4FHtcXmrZJmxjBOgcwAi642nf/M/PqzW5m/kJwmfyhNO/wpF+zT1np1d1X+2ppB3lkpEQGxvMlUK9UqxnuNeQ2A5joziS4a799BR8QsSKFMlp1vtKdGaOuRim4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784778231; c=relaxed/simple;
	bh=tT/bg259Pi9m3cgjy7ZCkj3qpCLMJawwz6v9HhYs4lg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YVKXCuRUutUa8WGBlmw8P1J36qEhzVdA3gAeCm9V5TL/r6qdmIsdQ1SuzPDKk403rGInelhB0TcedPllVFWMDfqO65DVXIMXDhv49baIWXJ4KuyKd8sL5HO55NFFpdCr5yjVzkglV+3SPPWG35flygpxYm3c66lEaxaDaETnNGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=Ur+pOIi1 reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="Ur+pOIi1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=SAWLPvqPc/
	fT14wBaGjv0qhETCc7VLisGwmGxOUeQOg=; b=Ur+pOIi10hWnHFRoAB5DlUYMae
	nVK6bOrY/Ch1BHUxQ9JGhv37ebgfu08dbdGBpSM50d3HamtRGsiqfjVRcllasCO2
	n3tvFUkjW78/cU2nnygQ2t6isHBD/RdLZL90lmpesiGAXQRrftOZyaZdcTsCNR78
	9muVIdmtozIANkR9M=
Received: from wmy.localdomain (unknown [115.53.185.16])
	by hzbj-edu-front-2.icoremail.net (Coremail) with SMTP id BLQMCkB2vDHkjWFq_6BaAQ--.34775S2;
	Thu, 23 Jul 2026 11:43:35 +0800 (CST)
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
To: jdelvare@suse.com,
	andi.shyti@kernel.org
Cc: djkurtz@chromium.org,
	hkallweit1@gmail.com,
	wsa@kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH v2] i2c: i801: Clamp adapter timeout to prevent system lockup
Date: Thu, 23 Jul 2026 11:43:31 +0800
Message-Id: <20260723034331.116690-1-25181214217@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BLQMCkB2vDHkjWFq_6BaAQ--.34775S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCFWDXrW8XFW5Ar4xuF13CFg_yoW7Jw4fpF
	4Ykws8t3Wqqr4YgF97Aw4DX39Igw4rJFW7KFn7t3sYk3ZIyF1kAa4Fk34qvFW8Zr95XF43
	Xayvqr1UCr4UZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9C14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW8GwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU3kucUUUUU=
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAQUDEWpg3utk2AAAsV

Userspace applications with access to /dev/i2c-* can use the I2C_TIMEOUT
ioctl to manipulate the adap->timeout value. In the i2c-i801 driver,
this user-controlled timeout is used directly in both the interrupt
waiting paths (wait_for_completion_timeout) and the polling loops
(time_after(jiffies, timeout)).

If a malicious or arbitrarily large timeout value is injected from
userspace, and the hardware (or an emulated device in a fuzzing/VM
environment) fails to respond, the driver will block for the entirety
of that requested timeout while holding the i2c adapter's rt_mutex.

In IRQ mode, the task sleeps in wait_for_completion_timeout() in the
TASK_UNINTERRUPTIBLE (D) state for the entire duration, directly triggering
the khungtaskd watchdog if the timeout exceeds 120 seconds. In polling
mode, the endless usleep_range() loop keeps the rt_mutex locked permanently.
Consequently, any other processes attempting to acquire the i2c adapter
lock will be starved in TASK_UNINTERRUPTIBLE, which inevitably triggers
Hung Task panics as well.

Fix this by introducing i801_get_timeout(), which clamps the timeout
to a maximum of HZ (1 second). This is safe and strictly necessary:
1. Normal operations complete in milliseconds and are unaffected by
   this ceiling. The timeout is only consumed during hardware failures.
2. Per the SMBus 2.0 specification, the maximum clock low timeout
   (tTIMEOUT) is 25-35 ms. A 1-second clamp provides immense headroom
   (orders of magnitude) for legitimate transactions while decisively
   preventing prolonged rt_mutex lock contention and D-state lockups.

Fixes: 1de93d5d5217 ("i2c: i801: Replace waitqueue with completion API")
Cc: stable@vger.kernel.org
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
Changes in v2:
 - Kept the 1-second (HZ) clamp but completely rewrote the commit message 
   to provide a bulletproof justification based on the SMBus 2.0 hardware 
   specification. This addresses the automated review concerns about 
   potentially breaking legitimate slow devices, proving that HZ is actually 
   orders of magnitude larger than the strictly required 35ms tTIMEOUT.
 - Removed the unused 'adap' variable to prevent [-Wunused-variable] warnings.

 drivers/i2c/busses/i2c-i801.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index b29c99ed3883..f60ecf1071ff 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -345,10 +345,19 @@ MODULE_PARM_DESC(disable_features, "Disable selected driver features:\n"
 	"\t\t  0x10  don't use interrupts\n"
 	"\t\t  0x20  disable SMBus Host Notify ");
 
+/*
+ * Bound the maximum wait time to prevent system lockup if the
+ * userspace passes an arbitrarily large timeout via ioctl.
+ */
+static inline unsigned long i801_get_timeout(struct i801_priv *priv)
+{
+	return min_t(unsigned long, priv->adapter.timeout, HZ);
+}
+
 /* Wait for BUSY being cleared and either INTR or an error flag being set */
 static int i801_wait_intr(struct i801_priv *priv)
 {
-	unsigned long timeout = jiffies + priv->adapter.timeout;
+	unsigned long timeout = jiffies + i801_get_timeout(priv);
 	int status, busy;
 
 	do {
@@ -366,7 +375,7 @@ static int i801_wait_intr(struct i801_priv *priv)
 /* Wait for either BYTE_DONE or an error flag being set */
 static int i801_wait_byte_done(struct i801_priv *priv)
 {
-	unsigned long timeout = jiffies + priv->adapter.timeout;
+	unsigned long timeout = jiffies + i801_get_timeout(priv);
 	int status;
 
 	do {
@@ -497,13 +506,12 @@ static int i801_check_post(struct i801_priv *priv, int status)
 static int i801_transaction(struct i801_priv *priv, int xact)
 {
 	unsigned long result;
-	const struct i2c_adapter *adap = &priv->adapter;
 
 	if (priv->features & FEATURE_IRQ) {
 		reinit_completion(&priv->done);
 		iowrite8(xact | SMBHSTCNT_INTREN | SMBHSTCNT_START,
 		       SMBHSTCNT(priv));
-		result = wait_for_completion_timeout(&priv->done, adap->timeout);
+		result = wait_for_completion_timeout(&priv->done, i801_get_timeout(priv));
 		return result ? priv->status : -ETIMEDOUT;
 	}
 
@@ -677,7 +685,6 @@ static int i801_block_transaction_byte_by_byte(struct i801_priv *priv,
 	int smbcmd;
 	int status;
 	unsigned long result;
-	const struct i2c_adapter *adap = &priv->adapter;
 
 	if (command == I2C_SMBUS_BLOCK_PROC_CALL)
 		return -EOPNOTSUPP;
@@ -706,7 +713,7 @@ static int i801_block_transaction_byte_by_byte(struct i801_priv *priv,
 
 		reinit_completion(&priv->done);
 		iowrite8(priv->cmd | SMBHSTCNT_START, SMBHSTCNT(priv));
-		result = wait_for_completion_timeout(&priv->done, adap->timeout);
+		result = wait_for_completion_timeout(&priv->done, i801_get_timeout(priv));
 		return result ? priv->status : -ETIMEDOUT;
 	}
 
-- 
2.34.1

