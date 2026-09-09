Received: from fraori-sdnproxy-3.icoremail.net (fraori-sdnproxy-3.icoremail.net [132.226.202.154])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45ED6563FD3;
	Wed,  9 Sep 2026 15:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=132.226.202.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788967573; cv=none; b=gtRy8vsWgBbLu+894oXHWEpP+Zgvu/ALdNRUa9CdGSkxFJpemJNo93Cxd88i8C8MGWzUgFYmvchY01KHlGUQMkOCVlyG0ldmb8T2rQg0MRz+2zZIhOLqIWgZAs3IZK4kXRxYLo1QK2mYZpsJoE4DmlapTPkoGcsLfvvLBZx8BAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788967573; c=relaxed/simple;
	bh=xPL7AjMTW5ysI0hU75iVCQp3xo40vpjuzJxdmX8g3MA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R3HWeBqfiveoDy1jOIYTRY7h4S7SVOEeOIp58BEtjKGud1dqaznlky3FolgbtPnolpbpFs4SkhGxcCCSGTVJYlcxk7wEuKm1GUD7vcRvbtCmSCHAmpbyx07dyvr9FxX51uy/VHKpgi4XFNMcJJP+CDWd7SkDdHnrPKxsbGm2Jfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=132.226.202.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wCHnnyJeqFqjaQDAQ--.3421S3;
	Wed, 09 Sep 2026 23:26:02 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app3 (Coremail) with SMTP id zS_KCgCnkneIeqFqcfYLBQ--.38970S2;
	Wed, 09 Sep 2026 23:26:00 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	linux-pm@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>,
	Song Li <songl@zju.edu.cn>
Subject: [PATCH] thermal: tegra-bpmp: fix use-after-free in trip update work
Date: Wed,  9 Sep 2026 15:25:05 +0000
Message-Id: <20260909152505.712508-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgCnkneIeqFqcfYLBQ--.38970S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?WYunTQXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnZPoDCNGYdHSfuFmYJL54WMeomO68wCyTClL9ugqs3ryCR4MWpwO+2pnmC1Sf6MKhmp0
	+Zb+bKyYPwfRpBzSy9ap9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW7KFW5Kr4fGr1rJr47JFyDXFc_yoW8urWfpr
	s8JFyYk395GF4Yya47Aw1UZFs8Kw1Iva47W3yfC3Z5Aws8AF9IkryrJFZ8AayUAr95KF12
	kFyUtr45Ar4DZrgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxU2EoXUUUUU

Each thermal zone carries a work_struct that the BPMP thermal message
handler queues on the system workqueue whenever the firmware reports
a trip point crossing. The work handler tz_device_update_work_fn()
recovers the zone with container_of() and calls
thermal_zone_device_update() on its thermal zone device.

tegra_bpmp_thermal_remove() only unregisters the mrq handler with
tegra_bpmp_free_mrq(). That stops new trip messages from being
dispatched, but it does not drain work that was already queued. After
the remove callback returns, devm releases the zones, and a pending
trip update work can then run and dereference the freed zone.

Cancel the per-zone works after tegra_bpmp_free_mrq(), which
guarantees no new instance can be queued: mrq handlers are dispatched
under the same bpmp->lock that tegra_bpmp_free_mrq() holds.

This issue was found by an in-house static analysis tool.

Fixes: 7afebede62be ("thermal: Add Tegra BPMP thermal sensor driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/thermal/tegra/tegra-bpmp-thermal.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/tegra/tegra-bpmp-thermal.c b/drivers/thermal/tegra/tegra-bpmp-thermal.c
index 997d77ce30d..7ad46b34e17 100644
--- a/drivers/thermal/tegra/tegra-bpmp-thermal.c
+++ b/drivers/thermal/tegra/tegra-bpmp-thermal.c
@@ -303,8 +303,12 @@ static int tegra_bpmp_thermal_probe(struct platform_device *pdev)
 static void tegra_bpmp_thermal_remove(struct platform_device *pdev)
 {
 	struct tegra_bpmp_thermal *tegra = platform_get_drvdata(pdev);
+	unsigned int i;
 
 	tegra_bpmp_free_mrq(tegra->bpmp, MRQ_THERMAL, tegra);
+
+	for (i = 0; i < tegra->num_zones; ++i)
+		cancel_work_sync(&tegra->zones[i]->tz_device_update_work);
 }
 
 static const struct of_device_id tegra_bpmp_thermal_of_match[] = {

