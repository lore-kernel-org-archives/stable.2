Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8087448AE28;
	Wed, 17 Jun 2026 15:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781710130; cv=none; b=r8QKZQ+0/32XSflyTt2hTFttGGwXi0VMpaOwGKHXbfydQcYih9lOtVA9BFCA+yOIZmNSfrD9yH3vZaUHdqQa62o4Gr6B/l7k9C3SVfHHcquMc0AmB461xPdGLFKdBxrUBsfk/Gqo6lAYX74IeYsDBUcrJj91YWZTCoi7OzkyEvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781710130; c=relaxed/simple;
	bh=V8wvjVu0OPYzDI6Bh14Bz+Sa6Ci/1Zmany8gLvzkqGw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Tw6tx30eaHlPWA4dOAZ8Gc1U7zHEX3Jj4NDA6UHeArk2saewR9NyrD1Zy2F5O2CxgGueDfGZTBFwCeF/1xF8NQ/FRuPDjhKF+iaIqCOpfURwlXfYPUjfWSt0FsHqVUSeU8XqHiSJycnbSLIRpLldV61aqi4waOIHBGfXm2zb904=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=cH00U2Mn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="cH00U2Mn"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 42c703e96;
	Wed, 17 Jun 2026 23:23:28 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Tony Olech <tony.olech@elandigitalsystems.com>,
	Chris Ball <cjb@laptop.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	runyu.xiao@seu.edu.cn,
	stable@vger.kernel.org
Subject: [PATCH] mmc: vub300: defer reset until cmd_mutex is unlocked
Date: Wed, 17 Jun 2026 23:23:19 +0800
Message-Id: <20260617152319.957866-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ed62e214f03a1kunm222d957772c36
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGk9PVk9OTBlIHx9DS0weQ1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=cH00U2Mnc0DuQ4U4Sj1/OlcYm1vT9j+5GUtWLVYVW93SWTnQoCl4j/VIkJupYYiyZaM0GquJYVzYtIPriqpw8RP6323F2xTpQ36SRzWhlxGXmadxuHAPAGy26Z1qiZDfCOdcaLRBxAFJoEDg+0GLRf2VzuveKzUZilxaeDW9i0Q=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=1YgrcLHM640hkK4bIkBzBou0RBgMdqEUSX0MpgCbLUg=;
	h=date:mime-version:subject:message-id:from;

vub300_cmndwork_thread() holds cmd_mutex while it sends a command and
waits for the command response.  If the response wait times out,
__vub300_command_response() kills the command URBs and then synchronously
resets the USB device through usb_reset_device().

That reset path re-enters the driver through vub300_pre_reset(), which
also takes cmd_mutex.  The worker therefore tries to acquire the same
mutex recursively while it is still holding it from the command path.

This issue was found by our static analysis tool and then manually
reviewed against the current tree.

The grounded PoC kept the real worker and timeout/reset carrier:

  vub300_cmndwork_thread()
  __vub300_command_response()
  usb_lock_device_for_reset()
  usb_reset_device()
  vub300_pre_reset()

Lockdep reported the same-task recursive acquisition on cmd_mutex:

  WARNING: possible recursive locking detected
  ... (&test_vub300.cmd_mutex) ... at: usb_reset_device... [vuln_msv]
  ... (&test_vub300.cmd_mutex) ... at: vub300_cmndwork_thread+0x12/0x20 [vuln_msv]
  Workqueue: vub300_cmd_wq vub300_cmndwork_thread [vuln_msv]
  *** DEADLOCK ***

Return a flag from __vub300_command_response() when the timeout path needs
a device reset, then perform the reset after vub300_cmndwork_thread() has
cleared the in-flight command state and dropped cmd_mutex.  The reset is
still attempted before mmc_request_done(), preserving the existing request
completion ordering while avoiding the recursive lock.

Fixes: 88095e7b473a ("mmc: Add new VUB300 USB-to-SD/SDIO/MMC driver")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/mmc/host/vub300.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index ff49d0770506..1c335e070741 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -1583,7 +1583,7 @@ static int __command_write_data(struct vub300_mmc_host *vub300,
 	return linear_length;
 }
 
-static void __vub300_command_response(struct vub300_mmc_host *vub300,
+static bool __vub300_command_response(struct vub300_mmc_host *vub300,
 				      struct mmc_command *cmd,
 				      struct mmc_data *data, int data_length)
 {
@@ -1595,17 +1595,11 @@ static void __vub300_command_response(struct vub300_mmc_host *vub300,
 					    msecs_to_jiffies(msec_timeout));
 	if (respretval == 0) { /* TIMED OUT */
 		/* we don't know which of "out" and "res" if any failed */
-		int result;
 		vub300->usb_timed_out = 1;
 		usb_kill_urb(vub300->command_out_urb);
 		usb_kill_urb(vub300->command_res_urb);
 		cmd->error = -ETIMEDOUT;
-		result = usb_lock_device_for_reset(vub300->udev,
-						   vub300->interface);
-		if (result == 0) {
-			result = usb_reset_device(vub300->udev);
-			usb_unlock_device(vub300->udev);
-		}
+		return true;
 	} else if (respretval < 0) {
 		/* we don't know which of "out" and "res" if any failed */
 		usb_kill_urb(vub300->command_out_urb);
@@ -1701,6 +1695,8 @@ static void __vub300_command_response(struct vub300_mmc_host *vub300,
 	} else {
 		cmd->error = -EINVAL;
 	}
+
+	return false;
 }
 
 static void construct_request_response(struct vub300_mmc_host *vub300,
@@ -1746,6 +1742,7 @@ static void vub300_cmndwork_thread(struct work_struct *work)
 		struct mmc_request *req = vub300->req;
 		struct mmc_command *cmd = vub300->cmd;
 		struct mmc_data *data = vub300->data;
+		bool reset_device;
 		int data_length;
 		mutex_lock(&vub300->cmd_mutex);
 		init_completion(&vub300->command_complete);
@@ -1768,7 +1765,8 @@ static void vub300_cmndwork_thread(struct work_struct *work)
 			data_length = __command_read_data(vub300, cmd, data);
 		else
 			data_length = __command_write_data(vub300, cmd, data);
-		__vub300_command_response(vub300, cmd, data, data_length);
+		reset_device = __vub300_command_response(vub300, cmd,
+							 data, data_length);
 		vub300->req = NULL;
 		vub300->cmd = NULL;
 		vub300->data = NULL;
@@ -1776,6 +1774,16 @@ static void vub300_cmndwork_thread(struct work_struct *work)
 			if (cmd->error == -ENOMEDIUM)
 				check_vub300_port_status(vub300);
 			mutex_unlock(&vub300->cmd_mutex);
+			if (reset_device) {
+				int result;
+
+				result = usb_lock_device_for_reset(vub300->udev,
+								   vub300->interface);
+				if (result == 0) {
+					result = usb_reset_device(vub300->udev);
+					usb_unlock_device(vub300->udev);
+				}
+			}
 			mmc_request_done(vub300->mmc, req);
 			kref_put(&vub300->kref, vub300_delete);
 			return;
-- 
2.34.1

