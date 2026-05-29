Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362A83A63F2
	for <stable@vger.kernel.org>; Fri, 29 May 2026 21:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780090956; cv=none; b=AagMTVBUwLkIXsq5uNadCkvkvKfmIKQHga3+GhR86bw8pg4BhLjjY+c6v4SfK5FLOVvplhSIWXC2J8TrYUvUJjpGiYDl3VH2dTuYuY1+HV/af3TryW5ibwP1BbThasPMy2v7wzhQSirNx2QDpFFOpPbKypdOVckkOCCucsSRFAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780090956; c=relaxed/simple;
	bh=3kNX89mOpEf98Gc7gSaH/KhvIm/G8louBayOEeCsihk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKruvHO5qDZ7wGfHZBEEar+iS7OHrRts5IjnlxQ57qGqjYc47AA8L8LUn8gJFwIbR8knwxR3dGPLGY+2U164M89Wi/gJmclJhwMU14Al5rVvqAMkp1WeUUlUOLARQLM57Z8dwB0X4nZyFHnRQXX8l8OHaBxWQvQvMstCZujjDhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLK0ydzh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLK0ydzh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516AF1F00893;
	Fri, 29 May 2026 21:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780090955;
	bh=f526ohzls8Bu7jsriXy6qakxGeiNZeWELigGz6coV/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TLK0ydzhPf7dBNOczY2tiiihuoR8EVjj+xAEnkgXYbfPt/ZTfnVPwkirlf7REJDgV
	 dYTqBX7azZP0YueP2BhVPmOYo02aDHHQLMFD1N5glqWEiH9JzbmDRCGOTe4ac07MIZ
	 vLuaB71Hgj/5WMKAvawE4hfeLer0/T8ZQVjtdsMWGsajSHkH9yg9Fq+Sx3H7jNwMrP
	 iqKZswpA6Ph0pRh+JmMwAPi7Z7T5v5QmzRAcmMz7lx2BtnBqvFDktpOBMUdZCm+Y+A
	 V7KRa96+8M6/HQylOeYQGWHXbns/nMFBrpNwCqUKQuIAdynxsyFslieUaMnhyXqlY8
	 +SSWVYJKC0LgA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shuai Zhang <shuai.zhang@oss.qualcomm.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] Bluetooth: hci_qca: Convert timeout from jiffies to ms
Date: Fri, 29 May 2026 17:42:32 -0400
Message-ID: <20260529214232.1794166-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052801-kangaroo-scrubber-70c6@gregkh>
References: <2026052801-kangaroo-scrubber-70c6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>

[ Upstream commit 375ba7484132662a4a8c7547d088fb6275c00282 ]

Since the timer uses jiffies as its unit rather than ms, the timeout value
must be converted from ms to jiffies when configuring the timer. Otherwise,
the intended 8s timeout is incorrectly set to approximately 33s.

To improve readability, embed msecs_to_jiffies() directly in the macro
definitions and drop the _MS suffix from macros that now yield jiffies
values: MEMDUMP_TIMEOUT, FW_DOWNLOAD_TIMEOUT, IBS_DISABLE_SSR_TIMEOUT,
CMD_TRANS_TIMEOUT, and IBS_BTSOC_TX_IDLE_TIMEOUT.

IBS_WAKE_RETRANS_TIMEOUT_MS and IBS_HOST_TX_IDLE_TIMEOUT_MS are
intentionally left unchanged. Their values are stored in the struct fields
wake_retrans and tx_idle_delay, which hold ms values at runtime and can be
modified via debugfs. The msecs_to_jiffies() conversion happens at each
call site against the field value, so it cannot be embedded in the macro.

Wake timer depends on commit c347ca17d62a

Cc: stable@vger.kernel.org
Fixes: d841502c79e3 ("Bluetooth: hci_qca: Collect controller memory dump during SSR")
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[ adapted to `vmalloc`-based memdump path and older `qca_serdev_shutdown(struct device *dev)` signature ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/hci_qca.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index fe50aa88d8316..0b3bf9ea1a472 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -46,13 +46,12 @@
 #define HCI_MAX_IBS_SIZE	10
 
 #define IBS_WAKE_RETRANS_TIMEOUT_MS	100
-#define IBS_BTSOC_TX_IDLE_TIMEOUT_MS	200
+#define IBS_BTSOC_TX_IDLE_TIMEOUT	msecs_to_jiffies(200)
 #define IBS_HOST_TX_IDLE_TIMEOUT_MS	2000
-#define CMD_TRANS_TIMEOUT_MS		100
-#define MEMDUMP_TIMEOUT_MS		8000
-#define IBS_DISABLE_SSR_TIMEOUT_MS \
-	(MEMDUMP_TIMEOUT_MS + FW_DOWNLOAD_TIMEOUT_MS)
-#define FW_DOWNLOAD_TIMEOUT_MS		3000
+#define CMD_TRANS_TIMEOUT		msecs_to_jiffies(100)
+#define MEMDUMP_TIMEOUT			msecs_to_jiffies(8000)
+#define FW_DOWNLOAD_TIMEOUT		msecs_to_jiffies(3000)
+#define IBS_DISABLE_SSR_TIMEOUT		(MEMDUMP_TIMEOUT + FW_DOWNLOAD_TIMEOUT)
 
 /* susclk rate */
 #define SUSCLK_RATE_32KHZ	32768
@@ -1059,7 +1058,7 @@ static void qca_controller_memdump(struct work_struct *work)
 				    dump_size);
 			queue_delayed_work(qca->workqueue,
 					   &qca->ctrl_memdump_timeout,
-					   msecs_to_jiffies(MEMDUMP_TIMEOUT_MS)
+					   MEMDUMP_TIMEOUT
 					  );
 
 			skb_pull(skb, sizeof(dump_size));
@@ -1327,7 +1326,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 
 	if (hu->serdev)
 		serdev_device_wait_until_sent(hu->serdev,
-		      msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS));
+		      CMD_TRANS_TIMEOUT);
 
 	/* Give the controller time to process the request */
 	switch (qca_soc_type(hu)) {
@@ -1358,8 +1357,8 @@ static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
 
 static int qca_send_power_pulse(struct hci_uart *hu, bool on)
 {
+	int timeout = CMD_TRANS_TIMEOUT;
 	int ret;
-	int timeout = msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS);
 	u8 cmd = on ? QCA_WCN3990_POWERON_PULSE : QCA_WCN3990_POWEROFF_PULSE;
 
 	/* These power pulses are single byte command which are sent
@@ -1561,7 +1560,7 @@ static void qca_wait_for_dump_collection(struct hci_dev *hdev)
 	struct qca_data *qca = hu->priv;
 
 	wait_on_bit_timeout(&qca->flags, QCA_MEMDUMP_COLLECTION,
-			    TASK_UNINTERRUPTIBLE, MEMDUMP_TIMEOUT_MS);
+			    TASK_UNINTERRUPTIBLE, MEMDUMP_TIMEOUT);
 
 	clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
 }
@@ -2390,7 +2389,7 @@ static void qca_serdev_remove(struct serdev_device *serdev)
 static void qca_serdev_shutdown(struct device *dev)
 {
 	int ret;
-	int timeout = msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS);
+	int timeout = CMD_TRANS_TIMEOUT;
 	struct serdev_device *serdev = to_serdev_device(dev);
 	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
 	struct hci_uart *hu = &qcadev->serdev_hu;
@@ -2448,7 +2447,7 @@ static int __maybe_unused qca_suspend(struct device *dev)
 	bool tx_pending = false;
 	int ret = 0;
 	u8 cmd;
-	u32 wait_timeout = 0;
+	unsigned long wait_timeout = 0;
 
 	set_bit(QCA_SUSPENDING, &qca->flags);
 
@@ -2469,15 +2468,15 @@ static int __maybe_unused qca_suspend(struct device *dev)
 	if (test_bit(QCA_IBS_DISABLED, &qca->flags) ||
 	    test_bit(QCA_SSR_TRIGGERED, &qca->flags)) {
 		wait_timeout = test_bit(QCA_SSR_TRIGGERED, &qca->flags) ?
-					IBS_DISABLE_SSR_TIMEOUT_MS :
-					FW_DOWNLOAD_TIMEOUT_MS;
+					IBS_DISABLE_SSR_TIMEOUT :
+					FW_DOWNLOAD_TIMEOUT;
 
 		/* QCA_IBS_DISABLED flag is set to true, During FW download
 		 * and during memory dump collection. It is reset to false,
 		 * After FW download complete.
 		 */
 		wait_on_bit_timeout(&qca->flags, QCA_IBS_DISABLED,
-			    TASK_UNINTERRUPTIBLE, msecs_to_jiffies(wait_timeout));
+			    TASK_UNINTERRUPTIBLE, wait_timeout);
 
 		if (test_bit(QCA_IBS_DISABLED, &qca->flags)) {
 			bt_dev_err(hu->hdev, "SSR or FW download time out");
@@ -2529,7 +2528,7 @@ static int __maybe_unused qca_suspend(struct device *dev)
 
 	if (tx_pending) {
 		serdev_device_wait_until_sent(hu->serdev,
-					      msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS));
+					      CMD_TRANS_TIMEOUT);
 		serial_clock_vote(HCI_IBS_TX_VOTE_CLOCK_OFF, hu);
 	}
 
@@ -2538,7 +2537,7 @@ static int __maybe_unused qca_suspend(struct device *dev)
 	 */
 	ret = wait_event_interruptible_timeout(qca->suspend_wait_q,
 			qca->rx_ibs_state == HCI_IBS_RX_ASLEEP,
-			msecs_to_jiffies(IBS_BTSOC_TX_IDLE_TIMEOUT_MS));
+			IBS_BTSOC_TX_IDLE_TIMEOUT);
 	if (ret == 0) {
 		ret = -ETIMEDOUT;
 		goto error;
-- 
2.53.0

