Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC3A3101A6;
	Wed, 17 Jun 2026 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781709268; cv=none; b=pu1yu+RXASsJ4NBTIhg69XprIY412fZno1nk/ak+AC8ptHjt6PdK+TT2p/bARQCZ9VRnyUa/xM+wGpnxPVE1vcAAK9925CyQh3M1bJzMCwDalNxUoz8D5W+Rr/U5iMiKaj/aviC+SPpIlA7uhUUD+dvgvhRm3uxueCRY+VFsbOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781709268; c=relaxed/simple;
	bh=GMSkdwKwwvN36qMoWsVT2yLCvb+VwQ5Tnb7iL6tpNpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TzutdzX7KOvqXCtvkYVDWYR+wHTjQSZgzKOr4WfoYco0+SHKtYBawPTQz6Y4Wmhy8CsHfchq8Pwr/dtQbYZfVGyfmNtx4BtdN4O94nGFEt6nAVqbur08eDbM1FnCph1UcsEFonfn2fQ9cCM2Kn/FZdA3IJf+XGvHpmWj9NYtMDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Iv7D5zQQ; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Iv7D5zQQ"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 42c703c95;
	Wed, 17 Jun 2026 23:09:13 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Eddie James <eajames@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	runyu.xiao@seu.edu.cn,
	stable@vger.kernel.org
Subject: [PATCH] hwmon: (occ) unregister hwmon device outside occ lock
Date: Wed, 17 Jun 2026 23:08:59 +0800
Message-Id: <20260617150859.741453-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ed621159103a1kunm16e6a07772443
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTUwdVk1DHxhNSUIYTEoYGFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Iv7D5zQQ71MG0Dhb+gC9gE89+Gyrsv1HzTj7mA7/KUVqjLd/btbiYm2qxDBHBG+ws7HsaICdeFqeg9aJ9dvBcfzWdmeDXqQiH4WFNnmpbHL8m/Of1ibIEbeNMOAZJSWahuQX0KSRaQXR09inW1+rYW+aM4DxLCE7eygqdlTJH+s=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=ZWA+6aQnuueaEeg7IzTAGsIcPfG41MO3NK5SCC3HElg=;
	h=date:mime-version:subject:message-id:from;

occ_active(false) and occ_shutdown() call hwmon_device_unregister() while
occ->lock is held.  hwmon_device_unregister() waits for sysfs callbacks to
drain, and those callbacks can enter the OCC update path and try to take
occ->lock again.  That gives the unregister paths the lock ordering
occ->lock -> sysfs callback drain, while a callback has the opposite edge
sysfs callback -> occ->lock.

This issue was found by our static analysis tool and then manually
reviewed against the current tree.

The grounded PoC kept the real unregister and callback carrier:

  occ_shutdown()
  hwmon_device_unregister()
  occ_show_temp_1()
  occ_update_response()

Lockdep reported the circular dependency with occ_shutdown() already
holding the OCC mutex and hwmon_device_unregister() waiting on the sysfs
side:

  WARNING: possible circular locking dependency detected
  ... (sysfs_lock) ... at: hwmon_device_unregister+0x12/0x30 [vuln_msv]
  ... (&test_occ.lock) ... at: occ_shutdown.constprop.0+0xe/0x40 [vuln_msv]
  occ_update_response.isra.0+0xb/0x20 [vuln_msv]
  occ_show_temp_1.constprop.0.isra.0+0x23/0x40 [vuln_msv]
  *** DEADLOCK ***

Serialize hwmon registration and removal with a separate hwmon_lock.
Under that lock, detach occ->hwmon and update occ->active while occ->lock
is held so concurrent OCC state changes still see a stable state, then
drop occ->lock before calling hwmon_device_unregister().  This keeps the
double-unregister protection while avoiding the unregister-versus-callback
lock inversion.

Fixes: 849b0156d996 ("hwmon: (occ) Delay hwmon registration until user request")
Fixes: ac6888ac5a11 ("hwmon: (occ) Lock mutex in shutdown to prevent race with occ_active")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/hwmon/occ/common.c | 28 ++++++++++++++++++++++------
 drivers/hwmon/occ/common.h |  1 +
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
index 89928d38831b..43dfea14d2ef 100644
--- a/drivers/hwmon/occ/common.c
+++ b/drivers/hwmon/occ/common.c
@@ -1106,11 +1106,16 @@ static void occ_parse_poll_response(struct occ *occ)
 
 int occ_active(struct occ *occ, bool active)
 {
-	int rc = mutex_lock_interruptible(&occ->lock);
+	struct device *hwmon = NULL;
+	int rc = mutex_lock_interruptible(&occ->hwmon_lock);
 
 	if (rc)
 		return rc;
 
+	rc = mutex_lock_interruptible(&occ->lock);
+	if (rc)
+		goto unlock_hwmon;
+
 	if (active) {
 		if (occ->active) {
 			rc = -EALREADY;
@@ -1155,14 +1160,17 @@ int occ_active(struct occ *occ, bool active)
 			goto unlock;
 		}
 
-		if (occ->hwmon)
-			hwmon_device_unregister(occ->hwmon);
+		hwmon = occ->hwmon;
 		occ->active = false;
 		occ->hwmon = NULL;
 	}
 
 unlock:
 	mutex_unlock(&occ->lock);
+	if (hwmon)
+		hwmon_device_unregister(hwmon);
+unlock_hwmon:
+	mutex_unlock(&occ->hwmon_lock);
 	return rc;
 }
 
@@ -1171,6 +1179,7 @@ int occ_setup(struct occ *occ)
 	int rc;
 
 	mutex_init(&occ->lock);
+	mutex_init(&occ->hwmon_lock);
 	occ->groups[0] = &occ->group;
 
 	rc = occ_setup_sysfs(occ);
@@ -1191,15 +1200,22 @@ EXPORT_SYMBOL_GPL(occ_setup);
 
 void occ_shutdown(struct occ *occ)
 {
-	mutex_lock(&occ->lock);
+	struct device *hwmon;
 
+	mutex_lock(&occ->hwmon_lock);
+	mutex_lock(&occ->lock);
+
 	occ_shutdown_sysfs(occ);
 
-	if (occ->hwmon)
-		hwmon_device_unregister(occ->hwmon);
+	hwmon = occ->hwmon;
+	occ->active = false;
 	occ->hwmon = NULL;
 
 	mutex_unlock(&occ->lock);
+
+	if (hwmon)
+		hwmon_device_unregister(hwmon);
+	mutex_unlock(&occ->hwmon_lock);
 }
 EXPORT_SYMBOL_GPL(occ_shutdown);
 
diff --git a/drivers/hwmon/occ/common.h b/drivers/hwmon/occ/common.h
index 7ac4b2febce6..82f600093c7f 100644
--- a/drivers/hwmon/occ/common.h
+++ b/drivers/hwmon/occ/common.h
@@ -101,6 +101,7 @@ struct occ {
 
 	unsigned long next_update;
 	struct mutex lock;		/* lock OCC access */
+	struct mutex hwmon_lock;		/* serialize hwmon registration/removal */
 
 	struct device *hwmon;
 	struct occ_attribute *attrs;
-- 
2.34.1
