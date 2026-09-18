Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8DC34C98C;
	Fri, 18 Sep 2026 05:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789709072; cv=none; b=JseRUVGagzyiCs1Bnif4QTTEWR0xVnaDUeO/kNskaxMduKwJtrqdGIKYvhMXpR568RW3vbme+YGUEPsNibNGw6CbAW3jbmVpeb59ZPk7SXesBdUnnEaW8gR5+3+zI4aRENtkvEm30wLFma6VbfY0amUDUUW6Yq3cLHYrZXo8ZeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789709072; c=relaxed/simple;
	bh=rgkyznFMODm6GSSmtqomy/AB4AsOg95QgYN/VyBoFy4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l2zecqZgDdcFPwHqmE1fjOl9lvSQqW4ogR/1ogXDJzmBZ+Uv902qqIIhH3Ocdv3+onMv7mzFhe/4vL30Vj3UfcpwbnRyXiNUzB0j28tSHaJGi56+BNW9VMDo3lWhhjMpjveoNhMkfbIUUEov1hhhfArP4eTeYgppGfrfx0wgaVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q9oWSxz+; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q9oWSxz+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789709070; x=1821245070;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rgkyznFMODm6GSSmtqomy/AB4AsOg95QgYN/VyBoFy4=;
  b=Q9oWSxz+B2YiD++t7wHv9DySvzgY5szmPKEIr8ecKaWX7locXBueSyL5
   FThzFrpyI/75vGmmexUzHHM62e8AiIgaQZbwXP9yn1LeZ2Bsh8GEpWIgx
   +h/WVwEVbrmmGtP7xAmIxmaz9A492uOYwy26fcDJJOpx8IYXRDHX0pPBa
   r5RMvlP6pMbV97KQBpO/2XjdCKpo575T9fWvl4/+fQ0YyOYtm0cLQIo6S
   yg2brPJUEBC9x+JW9QCiunRSSVfYaBCWT6ysrRheZtaLkCnUnSxrTnfp8
   p9PwPTNI7tY6UW0lsVQWXIN14ibQEnCDD9QdR0Uqm7cmMvn6DR7aJLfAo
   A==;
X-CSE-ConnectionGUID: fiFKVt5wTHeB8HxWU3VNaQ==
X-CSE-MsgGUID: j8iy82OcSoiYbTCzH+cpng==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="94023264"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="94023264"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 22:24:29 -0700
X-CSE-ConnectionGUID: JwgrUJrMTD6tktGJeKnPZg==
X-CSE-MsgGUID: 2EgAyj9uQQCRDkvMC/3iKA==
X-ExtLoop1: 1
Received: from gaojianf-dev.sh.intel.com ([10.112.106.68])
  by fmviesa003.fm.intel.com with ESMTP; 17 Sep 2026 22:24:27 -0700
From: jianfeng.gao@intel.com
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Yifan <yifan2.li@intel.com>,
	Munirah Izyani Mohammad Amin <munirah.izyani.mohammad.amin@intel.com>,
	Gao Jianfeng <jianfeng.gao@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: typec: tipd: mask interrupt across suspend to fix IRQ storm
Date: Fri, 18 Sep 2026 13:18:59 +0800
Message-Id: <20260918051859.825873-1-jianfeng.gao@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gao Jianfeng <jianfeng.gao@intel.com>

When tps->wakeup is false, tps6598x_suspend() left the IRQ enabled
because disable_irq() was gated inside the "if (tps->wakeup)" branch.
During hibernation the parent I2C (designware) adapter suspends right
after the child's freeze callback, so with the IRQ still enabled and the
type-C line still asserted, tps6598x_interrupt() keeps re-firing. Its
register reads now fail with -ESHUTDOWN, the handler bails with
event1/event2 == 0 and returns IRQ_NONE, so the line is never acked and
the handler loops, flooding the log with "failed to read ..." errors
until the noirq phase finally masks interrupts.

Mask the interrupt unconditionally in suspend and re-enable it in
resume, keeping enable_irq()/disable_irq() balanced. The wake-source
arming stays conditional on tps->wakeup.

The resume error paths jump to a common exit so the IRQ is re-enabled
(and the wake source disarmed) even when the controller fails to come
back. The line is requested with IRQF_SHARED, so a leaked disable_irq()
would mask it for every other device sharing it, and the imbalance would
never be recovered by a later resume.

Fixes: 481735d64794 ("usb: typec: tipd: Support wakeup")
Cc: stable@vger.kernel.org
Co-developed-by: Li Yifan <yifan2.li@intel.com>
Signed-off-by: Li Yifan <yifan2.li@intel.com>
Signed-off-by: Gao Jianfeng <jianfeng.gao@intel.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Tested-by: Munirah Izyani Mohammad Amin <munirah.izyani.mohammad.amin@intel.com>
---
 drivers/usb/typec/tipd/core.c | 38 ++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 9248f0dd3f49..5ed573e30479 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -1972,12 +1972,19 @@ static int __maybe_unused tps6598x_suspend(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct tps6598x *tps = i2c_get_clientdata(client);
 
-	if (tps->wakeup) {
+	/*
+	 * Mask the interrupt before the parent I2C controller is suspended:
+	 * otherwise a still-asserted level IRQ keeps re-entering the handler,
+	 * whose register reads then fail with -ESHUTDOWN, producing an
+	 * interrupt storm until the noirq phase globally disables interrupts.
+	 */
+	if (client->irq)
 		disable_irq(client->irq);
+
+	if (tps->wakeup)
 		enable_irq_wake(client->irq);
-	} else if (tps->reset) {
+	else if (tps->reset)
 		gpiod_set_value_cansleep(tps->reset, 1);
-	}
 
 	if (!client->irq)
 		cancel_delayed_work_sync(&tps->wq_poll);
@@ -1993,18 +2000,16 @@ static int __maybe_unused tps6598x_resume(struct device *dev)
 
 	ret = tps6598x_check_mode(tps);
 	if (ret < 0)
-		return ret;
+		goto out_enable_irq;
 
 	if (ret == TPS_MODE_PTCH) {
 		ret = tps->data->init(tps);
 		if (ret)
-			return ret;
+			goto out_enable_irq;
 	}
+	ret = 0;
 
-	if (tps->wakeup) {
-		disable_irq_wake(client->irq);
-		enable_irq(client->irq);
-	} else if (tps->reset) {
+	if (!tps->wakeup && tps->reset) {
 		gpiod_set_value_cansleep(tps->reset, 0);
 		msleep(TPS_SETUP_MS);
 	}
@@ -2013,7 +2018,20 @@ static int __maybe_unused tps6598x_resume(struct device *dev)
 		queue_delayed_work(system_power_efficient_wq, &tps->wq_poll,
 				   msecs_to_jiffies(POLL_INTERVAL));
 
-	return 0;
+out_enable_irq:
+	/*
+	 * Unwind suspend unconditionally, including on the error paths above:
+	 * the line is requested with IRQF_SHARED, so a leaked disable_irq()
+	 * would mask it for every other device on it, and the imbalance would
+	 * never be recovered by a later resume.
+	 */
+	if (tps->wakeup)
+		disable_irq_wake(client->irq);
+
+	if (client->irq)
+		enable_irq(client->irq);
+
+	return ret;
 }
 
 static const struct dev_pm_ops tps6598x_pm_ops = {
-- 
2.34.1

