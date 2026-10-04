Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AEC3328FC;
	Sun,  4 Oct 2026 05:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791092689; cv=none; b=YnBQrDWgSudANldAaGTiFCQSYPGmBaRptCT/TFVvq6n2+OKEyGwJBziuzKqWFMa97CyupuxdRWm2a/kQKQKedvqBGzB1V+CzL7goFOUjWowp2FqusZg5xjuvyMYWjhfGL5Jalpte11WP0GxF3ficLLHPKIw9x6mn5Mp89S2K8fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791092689; c=relaxed/simple;
	bh=W3nLTDxfMp4BvC79yA+nwyiJKros1epZgzVjBMp3954=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sMIcDDGpGogQEU94+RlDlWyVheoi/vStG/9mfhptkQLAGB/0gWYkHbJnJeGZQQTzt76jWQ92UxYF6EEXZoMkunolxTSJ/L7y7C9+Y32jLd9zyhWr0aGdz23q/6iWtkOxKvpRdsoBH/94Yp8eOJwun7Ufu10Fqy6fn5u82lis5P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=ZCUAglnt; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="ZCUAglnt"
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4fe9481fe;
	Sun, 4 Oct 2026 13:39:33 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andriy Shevchenko <andriy.shevchenko@intel.com>,
	Karol Wrona <k.wrona@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH v2] iio: ssp: Serialize watchdog timer state changes
Date: Sun,  4 Oct 2026 13:39:27 +0800
Message-Id: <20261004053927.1139035-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <arzdLtzXQ4cvObrL@ashevche-desk.local>
References: <arzdLtzXQ4cvObrL@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1056cb81603a1kunmc74cd2ea32f27e
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSB9LVk1NT09MTEJJGUIeTVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUJCSU
	5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=ZCUAglntpdgu8yfWyGxr0INR/XruHochIPIuZc6MBEHP+O8L1fmDxFI17uW/xyeKn7JRb3Ru8tVlh95yh0cZg+0jHlC++YRJkNBKBcMU0UVnTMR5Mh9BCGh9U1Y/MoxxLBRh6Qzv3N7/mi7skDZPyIEDD/GDf1EqkkiQsJaozvg=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=h1fW06j9waUyuwSp4rrkw1Y9EA9SDGzrtUcS9A8qp24=;
	h=date:mime-version:subject:message-id:from;

The SSP watchdog timer rearms itself from its callback, but the driver uses
timer_delete_sync() when the last sensor is disabled and during suspend.
Those operations do not prevent a concurrent enable or callback from
rearming the timer after deletion. The final remove path also used
timer_delete_sync(), which does not permanently prevent rearming before the
device state is released.

Protect watchdog state and the enable reference count with wdt_lock. The
timer callback rearms only while the timer is enabled, and synchronous
deletion drains an in-flight callback. Use timer_shutdown_sync() for final
removal so later rearm attempts are rejected permanently.

A refresh work item can call ssp_sync_available_sensors() and
ssp_enable_sensor() during suspend. If the enable count is zero when
suspend checks it, that work can otherwise start the watchdog after the
suspend stop. Track the suspended state under wdt_lock. Sensor enables may
update the count without restarting the timer. Stop the watchdog before
sending the suspend command, and restart it only after resume succeeds or
suspend fails.

Cancel watchdog work after releasing wdt_lock because reset work can wait
for the threaded IRQ handler, which may synchronously wait for refresh work
that enables sensors. Remove MFD children before destroying the locks;
IIO child teardown can disable an active sensor.

Fixes: 50dd64d57eee ("iio: common: ssp_sensors: Add sensorhub driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
Changes in v2:
- Keep the watchdog stopped while refresh work can re-enable sensors during
  suspend.
- Restart it only after resume succeeds or suspend fails.

 drivers/iio/common/ssp_sensors/ssp.h     |  6 ++
 drivers/iio/common/ssp_sensors/ssp_dev.c | 78 ++++++++++++++++++------
 2 files changed, 66 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp.h b/drivers/iio/common/ssp_sensors/ssp.h
index f649cdecc..2e356a6bb 100644
--- a/drivers/iio/common/ssp_sensors/ssp.h
+++ b/drivers/iio/common/ssp_sensors/ssp.h
@@ -143,6 +143,9 @@ struct ssp_sensorhub_info {
  * @spi:		spi device
  * @sensorhub_info:	info about sensorhub board specific features
  * @wdt_timer:		watchdog timer
+ * @wdt_lock:		lock protecting watchdog timer state
+ * @wdt_enabled:		watchdog timer is allowed to rearm
+ * @wdt_suspended:	watchdog timer is stopped for system suspend
  * @work_wdt:		watchdog work
  * @work_firmware:	firmware upgrade work queue
  * @work_refresh:	refresh work queue for reset request from MCU
@@ -180,6 +183,9 @@ struct ssp_data {
 	struct spi_device *spi;
 	const struct ssp_sensorhub_info *sensorhub_info;
 	struct timer_list wdt_timer;
+	struct mutex wdt_lock; /* protects watchdog timer state */
+	bool wdt_enabled;
+	bool wdt_suspended;
 	struct work_struct work_wdt;
 	struct delayed_work work_refresh;
 
diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index 828fcfe1d..94d0dc2d3 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -179,17 +179,53 @@ static void ssp_wdt_timer_func(struct timer_list *t)
 	    data->com_fail_cnt > SSP_LIMIT_RESET_CNT)
 		queue_work(system_power_efficient_wq, &data->work_wdt);
 _mod:
-	mod_timer(&data->wdt_timer, jiffies + msecs_to_jiffies(SSP_WDT_TIME));
+	if (READ_ONCE(data->wdt_enabled))
+		mod_timer(&data->wdt_timer,
+			  jiffies + msecs_to_jiffies(SSP_WDT_TIME));
 }
 
-static void ssp_enable_wdt_timer(struct ssp_data *data)
+static void __ssp_enable_wdt_timer(struct ssp_data *data)
 {
+	if (data->wdt_suspended)
+		return;
+
+	WRITE_ONCE(data->wdt_enabled, true);
 	mod_timer(&data->wdt_timer, jiffies + msecs_to_jiffies(SSP_WDT_TIME));
 }
 
-static void ssp_disable_wdt_timer(struct ssp_data *data)
+static void __ssp_stop_wdt_timer(struct ssp_data *data, bool shutdown)
+{
+	WRITE_ONCE(data->wdt_enabled, false);
+	if (shutdown)
+		timer_shutdown_sync(&data->wdt_timer);
+	else
+		timer_delete_sync(&data->wdt_timer);
+}
+
+static void ssp_suspend_wdt_timer(struct ssp_data *data)
 {
-	timer_delete_sync(&data->wdt_timer);
+	mutex_lock(&data->wdt_lock);
+	data->wdt_suspended = true;
+	__ssp_stop_wdt_timer(data, false);
+	mutex_unlock(&data->wdt_lock);
+	cancel_work_sync(&data->work_wdt);
+}
+
+static void ssp_resume_wdt_timer(struct ssp_data *data)
+{
+	mutex_lock(&data->wdt_lock);
+	data->wdt_suspended = false;
+	if (atomic_read(&data->enable_refcount) > 0)
+		__ssp_enable_wdt_timer(data);
+	mutex_unlock(&data->wdt_lock);
+}
+
+static void ssp_shutdown_wdt_timer(struct ssp_data *data)
+{
+	mutex_lock(&data->wdt_lock);
+	data->wdt_suspended = true;
+	__ssp_stop_wdt_timer(data, true);
+	mutex_unlock(&data->wdt_lock);
 	cancel_work_sync(&data->work_wdt);
 }
 
@@ -258,8 +294,10 @@ int ssp_enable_sensor(struct ssp_data *data, enum ssp_sensor_type type,
 
 	data->delay_buf[type] = delay;
 
+	mutex_lock(&data->wdt_lock);
 	if (atomic_inc_return(&data->enable_refcount) == 1)
-		ssp_enable_wdt_timer(data);
+		__ssp_enable_wdt_timer(data);
+	mutex_unlock(&data->wdt_lock);
 
 	return 0;
 
@@ -310,6 +348,7 @@ EXPORT_SYMBOL_NS(ssp_change_delay, "IIO_SSP_SENSORS");
 int ssp_disable_sensor(struct ssp_data *data, enum ssp_sensor_type type)
 {
 	int ret;
+	bool stop_wdt = false;
 	__le32 command;
 
 	if (data->sensor_enable & BIT(type)) {
@@ -329,8 +368,14 @@ int ssp_disable_sensor(struct ssp_data *data, enum ssp_sensor_type type)
 
 	data->check_status[type] = SSP_ADD_SENSOR_STATE;
 
+	mutex_lock(&data->wdt_lock);
 	if (atomic_dec_and_test(&data->enable_refcount))
-		ssp_disable_wdt_timer(data);
+		stop_wdt = true;
+	if (stop_wdt)
+		__ssp_stop_wdt_timer(data, false);
+	mutex_unlock(&data->wdt_lock);
+	if (stop_wdt)
+		cancel_work_sync(&data->work_wdt);
 
 	return 0;
 }
@@ -510,6 +555,7 @@ static int ssp_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, data);
 
 	mutex_init(&data->comm_lock);
+	mutex_init(&data->wdt_lock);
 
 	for (i = 0; i < SSP_SENSOR_MAX; ++i) {
 		data->delay_buf[i] = SSP_DEFAULT_POLLING_DELAY;
@@ -566,6 +612,7 @@ static int ssp_probe(struct spi_device *spi)
 	free_irq(data->spi->irq, data);
 err_setup_irq:
 	mutex_destroy(&data->pending_lock);
+	mutex_destroy(&data->wdt_lock);
 	mutex_destroy(&data->comm_lock);
 err_setup_spi:
 	mfd_remove_devices(&spi->dev);
@@ -584,20 +631,18 @@ static void ssp_remove(struct spi_device *spi)
 			"SSP_MSG2SSP_AP_STATUS_SHUTDOWN failed\n");
 
 	ssp_enable_mcu(data, false);
-	ssp_disable_wdt_timer(data);
+	ssp_shutdown_wdt_timer(data);
 
 	ssp_clean_pending_list(data);
 
 	free_irq(data->spi->irq, data);
 	cancel_delayed_work_sync(&data->work_refresh);
 
-	timer_delete_sync(&data->wdt_timer);
-	cancel_work_sync(&data->work_wdt);
+	mfd_remove_devices(&spi->dev);
 
 	mutex_destroy(&data->comm_lock);
+	mutex_destroy(&data->wdt_lock);
 	mutex_destroy(&data->pending_lock);
-
-	mfd_remove_devices(&spi->dev);
 }
 
 static int ssp_suspend(struct device *dev)
@@ -607,15 +652,14 @@ static int ssp_suspend(struct device *dev)
 
 	data->last_resume_state = SSP_MSG2SSP_AP_STATUS_SUSPEND;
 
-	if (atomic_read(&data->enable_refcount) > 0)
-		ssp_disable_wdt_timer(data);
+	ssp_suspend_wdt_timer(data);
 
 	ret = ssp_command(data, SSP_MSG2SSP_AP_STATUS_SUSPEND, 0);
 	if (ret < 0) {
 		dev_err(&data->spi->dev,
 			"%s SSP_MSG2SSP_AP_STATUS_SUSPEND failed\n", __func__);
 
-		ssp_enable_wdt_timer(data);
+		ssp_resume_wdt_timer(data);
 		return ret;
 	}
 
@@ -632,17 +676,15 @@ static int ssp_resume(struct device *dev)
 
 	enable_irq(data->spi->irq);
 
-	if (atomic_read(&data->enable_refcount) > 0)
-		ssp_enable_wdt_timer(data);
-
 	ret = ssp_command(data, SSP_MSG2SSP_AP_STATUS_RESUME, 0);
 	if (ret < 0) {
 		dev_err(&data->spi->dev,
 			"%s SSP_MSG2SSP_AP_STATUS_RESUME failed\n", __func__);
-		ssp_disable_wdt_timer(data);
 		return ret;
 	}
 
+	ssp_resume_wdt_timer(data);
+
 	/* timesyncing is set by MCU */
 	data->last_resume_state = SSP_MSG2SSP_AP_STATUS_RESUME;
 
