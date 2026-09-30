Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202F443D4FD;
	Wed, 30 Sep 2026 07:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751822; cv=none; b=KSgunHzc1C2YnIvYb5leMmIneA5Y7U/XUNG5Ly/Ex3tgZ2exZfN1Ic5ihtH1DDiJo1kqnmNdWx35AKM2JtZiX/HVvQjKpDuckgdqz45WviC6yC6SoMUZmp0skTUJaXNIXowAFJZApX+JjXGNLEQ5ZjFsr94w4ltaKlHxQU+7Jjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751822; c=relaxed/simple;
	bh=2KtV+hdbb3/nONdckSDE8IUGHFeOztRpkxwtsIWQqR0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RXxb/Sa5+ISWEjxuJRDDa6GVI7sNCzxreADDhK5NE0ePoSiM4uElGZoPD6+BLt0RjtoRry5RlzZKLNSTQn3QDyIXm+BrtnlJcod+fpOaL/5d06xUh6JtGXsT6LA37zKt2MaysZpEwiSE6drSGsvmg7TQYMrE0ScjBZCZ+C7R6r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=KS55cMin; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="KS55cMin"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f9a97abb;
	Wed, 30 Sep 2026 15:03:24 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Karol Wrona <k.wrona@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH] iio: ssp: Serialize watchdog timer state changes
Date: Wed, 30 Sep 2026 15:03:19 +0800
Message-Id: <20260930070319.2933744-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0f1200a8e03a1kunmceb1311326dcd2
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDS0pCVksZSUNCHxhLSEJMHVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=KS55cMin4s9zsVUKgW+xusMLZeifqmrK9jd+78bOpmG22yUHwsK0uGkx7+B7Ewig6JiQBqM3ugKSbXumfXOqhc7iM+bW8eC2GJdqh+O6gK579AkuUd20QOH3oUXQtTzyA7WGqHS61Bx4/8Dj7uVuTWsDZu1kUG6wyt5AOKE1+cA=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=OIgJV/+gcDhRyQwURWHTp318sLO7LJpLE2v3fshAv9w=;
	h=date:mime-version:subject:message-id:from;

The SSP watchdog timer rearms itself from its callback, but the driver uses
timer_delete_sync() when the last sensor is disabled and during suspend.
Those operations do not prevent a concurrent enable or callback from
rearming the timer after the deletion has completed.  The final remove path
also used timer_delete_sync(), which does not provide the shutdown
guarantee needed before releasing the device state.

Protect the watchdog state and enable reference count with a mutex.  The
callback checks a state flag before rearming. Reusable stops clear the flag
before deleting the timer. Use timer_shutdown_sync() for the final remove
path so that any later rearm attempt is rejected permanently.

Cancel watchdog work after releasing wdt_lock because the reset work can
wait for the threaded IRQ handler, which may synchronously wait for refresh
work that re-enables sensors and takes wdt_lock. Remove the MFD children
before destroying the locks because IIO child teardown can disable an
active sensor.

Fixes: 50dd64d57eee ("iio: common: ssp_sensors: Add sensorhub driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/iio/common/ssp_sensors/ssp.h     |  4 ++
 drivers/iio/common/ssp_sensors/ssp_dev.c | 56 ++++++++++++++++++++----
 2 files changed, 51 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp.h b/drivers/iio/common/ssp_sensors/ssp.h
index f649cdecc2774..2aa70eff06fc4 100644
--- a/drivers/iio/common/ssp_sensors/ssp.h
+++ b/drivers/iio/common/ssp_sensors/ssp.h
@@ -143,6 +143,8 @@ struct ssp_sensorhub_info {
  * @spi:		spi device
  * @sensorhub_info:	info about sensorhub board specific features
  * @wdt_timer:		watchdog timer
+ * @wdt_lock:		lock protecting watchdog timer state
+ * @wdt_enabled:		watchdog timer is allowed to rearm
  * @work_wdt:		watchdog work
  * @work_firmware:	firmware upgrade work queue
  * @work_refresh:	refresh work queue for reset request from MCU
@@ -180,6 +182,8 @@ struct ssp_data {
 	struct spi_device *spi;
 	const struct ssp_sensorhub_info *sensorhub_info;
 	struct timer_list wdt_timer;
+	struct mutex wdt_lock; /* protects watchdog timer state */
+	bool wdt_enabled;
 	struct work_struct work_wdt;
 	struct delayed_work work_refresh;
 
diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index 828fcfe1d4f10..44dfafcaeff71 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -179,17 +179,46 @@ static void ssp_wdt_timer_func(struct timer_list *t)
 	    data->com_fail_cnt > SSP_LIMIT_RESET_CNT)
 		queue_work(system_power_efficient_wq, &data->work_wdt);
 _mod:
+	if (READ_ONCE(data->wdt_enabled))
+		mod_timer(&data->wdt_timer,
+			  jiffies + msecs_to_jiffies(SSP_WDT_TIME));
+}
+
+static void __ssp_enable_wdt_timer(struct ssp_data *data)
+{
+	WRITE_ONCE(data->wdt_enabled, true);
 	mod_timer(&data->wdt_timer, jiffies + msecs_to_jiffies(SSP_WDT_TIME));
 }
 
+static void __ssp_stop_wdt_timer(struct ssp_data *data, bool shutdown)
+{
+	WRITE_ONCE(data->wdt_enabled, false);
+	if (shutdown)
+		timer_shutdown_sync(&data->wdt_timer);
+	else
+		timer_delete_sync(&data->wdt_timer);
+}
+
 static void ssp_enable_wdt_timer(struct ssp_data *data)
 {
-	mod_timer(&data->wdt_timer, jiffies + msecs_to_jiffies(SSP_WDT_TIME));
+	mutex_lock(&data->wdt_lock);
+	__ssp_enable_wdt_timer(data);
+	mutex_unlock(&data->wdt_lock);
 }
 
 static void ssp_disable_wdt_timer(struct ssp_data *data)
 {
-	timer_delete_sync(&data->wdt_timer);
+	mutex_lock(&data->wdt_lock);
+	__ssp_stop_wdt_timer(data, false);
+	mutex_unlock(&data->wdt_lock);
+	cancel_work_sync(&data->work_wdt);
+}
+
+static void ssp_shutdown_wdt_timer(struct ssp_data *data)
+{
+	mutex_lock(&data->wdt_lock);
+	__ssp_stop_wdt_timer(data, true);
+	mutex_unlock(&data->wdt_lock);
 	cancel_work_sync(&data->work_wdt);
 }
 
@@ -258,8 +287,10 @@ int ssp_enable_sensor(struct ssp_data *data, enum ssp_sensor_type type,
 
 	data->delay_buf[type] = delay;
 
+	mutex_lock(&data->wdt_lock);
 	if (atomic_inc_return(&data->enable_refcount) == 1)
-		ssp_enable_wdt_timer(data);
+		__ssp_enable_wdt_timer(data);
+	mutex_unlock(&data->wdt_lock);
 
 	return 0;
 
@@ -310,6 +341,7 @@ EXPORT_SYMBOL_NS(ssp_change_delay, "IIO_SSP_SENSORS");
 int ssp_disable_sensor(struct ssp_data *data, enum ssp_sensor_type type)
 {
 	int ret;
+	bool stop_wdt = false;
 	__le32 command;
 
 	if (data->sensor_enable & BIT(type)) {
@@ -329,8 +361,14 @@ int ssp_disable_sensor(struct ssp_data *data, enum ssp_sensor_type type)
 
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
@@ -510,6 +548,7 @@ static int ssp_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, data);
 
 	mutex_init(&data->comm_lock);
+	mutex_init(&data->wdt_lock);
 
 	for (i = 0; i < SSP_SENSOR_MAX; ++i) {
 		data->delay_buf[i] = SSP_DEFAULT_POLLING_DELAY;
@@ -566,6 +605,7 @@ static int ssp_probe(struct spi_device *spi)
 	free_irq(data->spi->irq, data);
 err_setup_irq:
 	mutex_destroy(&data->pending_lock);
+	mutex_destroy(&data->wdt_lock);
 	mutex_destroy(&data->comm_lock);
 err_setup_spi:
 	mfd_remove_devices(&spi->dev);
@@ -584,20 +624,18 @@ static void ssp_remove(struct spi_device *spi)
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
-- 
2.34.1

