Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.131.191.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792635697;
	b=nK5eGhnKDACVxWtQAMXFUJMr55xcj/tQ1Vtp1WVVfsFETKgQz2VedpVG8x9afKtaUCIi
	 mdo41Se+cW5xE/UUI0VgZlSd7JnaXyofMC90Z6FVBbxSmcNfiQFYJBOnCU+84/RWhbMy6
	 yydQYk8CNTm6OttNp+BX6RR8t+X9tWmVTVxfW7LQ4ILXMrSjPeXYz2kVqyAbCpN/Qtyzv
	 9LKbjVkmKy2M/+r8qwJz6Ubc5A7CH5qq+yvbrv/hUv/NQcIPOyYbcL/wrsXFV0agEUhmV
	 V92SLvzZnuEuBfqWiZYFgBA2A/Ce8zA44LxUEA4PGw4CaWbP9kTirdOd7Bl3SZt5d4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792635697;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:DKIM-Signature;
	bh=rTtOEHpuUdG1ZN7wpfmh79f1UZoM9LFVHJpiq1FULQo=;
	b=cCDn95bKz81VzlMDEPa6Vspiuc9TOkD4Ps8aB39FbTi+Oc0dYBEW/v//vRqQKlA878E8
	 qRMsBzaaxayN2gFGbdm6stZXNPkwx9ccABLOISuqu2VB4rMDj90RZdghFeb/KunZy4BHb
	 jx/dplpk98rKSESWEfrD5i29mgK2fxFZ1ApJI347/RrdOV4tvL2JL8lilNz7I59oGLLGT
	 NfLHu8w/2+eHh00FHcPVSsAy8dDZKEGfjuAbuKdXLKTGrN6rfdbGerOAw4NWz///XdcEa
	 vt7YPwNm4cbb2X2vqpdwwfk2qeYwOxH7TPyuyD55l/iI231btSU5/AVltPc3kjThZ2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b="SQsWjO/B";
	arc=none smtp.remote-ip=103.131.191.46
Received: from mail-m10313119146.xmail.ntesmail.com (mail-m10313119146.xmail.ntesmail.com [103.131.191.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27485606A319;
	Thu, 22 Oct 2026 02:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27485606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=SQsWjO/B
Received: from xf.. (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 51ed1a686;
	Thu, 22 Oct 2026 10:21:21 +0800 (GMT+08:00)
From: Finley Xiao <finley.xiao@rock-chips.com>
To: finley.xiao@rock-chips.com,
	heiko@sntech.de,
	linux-pm@vger.kernel.org
Cc: cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	kant@allwinnertech.com,
	kyungmin.park@samsung.com,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	tony.xie@rock-chips.com,
	huangtao@rock-chips.com,
	stable@vger.kernel.org
Subject: [PATCH v2] PM / devfreq: governor_userspace: Guard against NULL governor_data during switch
Date: Thu, 22 Oct 2026 10:21:09 +0800
Message-ID: <20261022022109.642339-1-finley.xiao@rock-chips.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa16169bbfa03a8kunm107f5dafdcf40
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCGkNMVktIGh4aSR5PGUhKTVYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
	b=SQsWjO/BBQxHRkBsgnOgPcYakFTvOHyIRj2GImr8AO68bBY89hVXHoLa6TNZu3KXBhhUd81Q+Ribz86i2eUFntrPEMtZHVgnMh5vImDK3OYzXDhNouRqu3OqVlHl2Zspg1EK0I+0QzZRqyi52cDbqSf7FKScBLfaDFvv0wkp4KU=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=rTtOEHpuUdG1ZN7wpfmh79f1UZoM9LFVHJpiq1FULQo=;
	h=date:mime-version:subject:message-id:from;

The userspace governor is the only one that uses devfreq->governor_data,
allocated in its DEVFREQ_GOV_START handler (userspace_init()) and freed
in its DEVFREQ_GOV_STOP handler (userspace_exit()).

When switching governors via sysfs (governor_store in devfreq.c), the
sequence is:

STOP(old) -> df->governor = userspace -> START(userspace) -> userspace_init

Between the df->governor assignment and userspace_init() completing,
governor_data is still NULL (the previous governor never touched it,
and the core does not clear or pre-allocate it). During that window,
asynchronous paths that call update_devfreq() outside of the driver's
control -- the OPP notifier (devfreq.c:686) and the pm_qos notifier
(devfreq.c:707) -- run devfreq_update_target() under df->lock and reach
devfreq_userspace_func(), which dereferences governor_data without a
NULL check, causing:

  Unable to handle kernel access to user memory outside uaccess routines
  pc : devfreq_userspace_func+0xc/0x28
  lr : devfreq_update_target+0x58/0x158

Add a NULL check in devfreq_userspace_func() and fall back to
previous_freq, which is the same behaviour as the existing "no user
frequency specified yet" branch. This closes the race for all callers
since every path ultimately goes through get_target_freq.

Additionally, take devfreq->lock around the kfree()/NULL assignment in
userspace_exit(). Without it, a concurrent OPP/pm_qos notifier running
under devfreq->lock could read governor_data after it is freed but
before it is set to NULL, constituting a use-after-free.

Fixes: 5fdded844892 ("PM/devfreq: governor: Add a private governor_data for governor")
Cc: stable@vger.kernel.org
Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>

Link: https://lore.kernel.org/linux-pm/20260723080806.1451-1-finley.xiao@rock-chips.com/
---
Changes in v2:
- Add Fixes: tag and Cc: stable@vger.kernel.org

 drivers/devfreq/governor_userspace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
index 3906ebedbae8..f7a485c43fd7 100644
--- a/drivers/devfreq/governor_userspace.c
+++ b/drivers/devfreq/governor_userspace.c
@@ -24,7 +24,7 @@ static int devfreq_userspace_func(struct devfreq *df, unsigned long *freq)
 {
 	struct userspace_data *data = df->governor_data;
 
-	if (data->valid)
+	if (data && data->valid)
 		*freq = data->user_frequency;
 	else
 		*freq = df->previous_freq; /* No user freq specified yet */
@@ -110,8 +110,10 @@ static void userspace_exit(struct devfreq *devfreq)
 	if (devfreq->dev.kobj.sd)
 		sysfs_remove_group(&devfreq->dev.kobj, &dev_attr_group);
 
+	mutex_lock(&devfreq->lock);
 	kfree(devfreq->governor_data);
 	devfreq->governor_data = NULL;
+	mutex_unlock(&devfreq->lock);
 }
 
 static int devfreq_userspace_handler(struct devfreq *devfreq,
-- 
2.43.0

