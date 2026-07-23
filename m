Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812202253EE;
	Thu, 23 Jul 2026 02:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784775146; cv=none; b=ILQ2LxCnCdtuhbt8xXt208iHEYFNTQwcA+NKrEspTfXyYr12ygaz1PY9bA0pw2nC/Mh1c7Llb8sJ2dg6Uk2vfQ0AQW8iV6fJeV6YMA8UMSrpwuCDt6X/hiAGDwc0tGj4DopkkeTOy9X4K93L6lToBm9xdyY/eE07GNq4hAaRRjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784775146; c=relaxed/simple;
	bh=OyohcimY9crCKWjIenAfvX0y/NE0xeldxEQsrjJkPPg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ADTAAMVplCh+eNDNkxyXKqyQvoRZOfyyuTHBI1N/hQaCgWQiWJHCdaXDn4/68mOncQ1f075zt3eod3fdTxEa61I1ivW3dlN+oNiw/CiZke75MRv6anWejD1GPxIqfB1lAZ3UMwPKkYx2olGQ70cJUFV+4xhWQCWs+Bc1TwIfVI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=42zTn6uN reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="42zTn6uN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=H5AulesY1R
	y14oNwCTwrJFa5X6fd404ztNxj835D8hc=; b=42zTn6uNOFDWPux2ZTjbzpU8KY
	P1PnQ6fz6AsssXi2SFZrX9ys2qSZgbyndEYQxKrdu2iMCjW1b0lwmNJJTMfihha3
	tQMGar+BhE1NqxNGFlvGDNVQapDkviV/nTF+scVNpqi7g+uuSmqJEkiFpRmYg5Gu
	SD2ErhFymqNaUvxeQ=
Received: from wmy.localdomain (unknown [115.53.182.54])
	by hzbj-edu-front-2.icoremail.net (Coremail) with SMTP id BLQMCkCW3DHQgWFqmz1aAQ--.24408S2;
	Thu, 23 Jul 2026 10:52:05 +0800 (CST)
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
Subject: [PATCH] i2c: i801: Clamp adapter timeout to prevent system lockup
Date: Thu, 23 Jul 2026 10:51:57 +0800
Message-Id: <20260723025157.115897-1-25181214217@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BLQMCkCW3DHQgWFqmz1aAQ--.24408S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCFWDXrW8XFW5Ar4xuF13CFg_yoWrCr4UpF
	4jkw1Dt3Wqqr45KFn7Aa1DX39I9w4rJFW7KFn7K3ykC3ZIyF1kAF1rt34qqF48ZrykXF43
	XaykWr4DCr4UZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
	W8Jr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUQvtAUUUUU=
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAQUCEWpg3usg1gABsf

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
to a sensible maximum (HZ, i.e., 1 second). A 1-second timeout is more
than sufficient for typical SMBus block transactions while strictly
bounding the maximum blocking time under hardware failure or excessive
userspace injection.

Fixes: 1de93d5d5217 ("i2c: i801: Replace waitqueue with completion API")
Cc: stable@vger.kernel.org
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
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

