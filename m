Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEA2517BAB
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872338; cv=none; b=pgQEsKeExIvY6ohbVg6t6wgLIaIMRq7VIBFrF35zawVKAqfy6ThmLbVZuQG+ikE+z5yEBjvseMHlJaor06uaPZKA92ImQfV4OirQPidDomcFBJJJoYW3Y90TmAyRIjvOPxezybYBoyOZyaXe3KcLt1KkCy7a5fabQPrZa1yCEnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872338; c=relaxed/simple;
	bh=4UQgB7+0+JEhVXz8ALEjW3N1sX2IARIbQKvTQaRirJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mx9Tpo3d7oLzcQviv8W+NWB+OpfQ0HdrRctjsu91QNb0SrcCHeEABFhbeVmJ5Cd/lJr98gD70wqsczEphcghTj5JXPNWNR3HAgelfbDCBmHHqp5OFUgVi2oxqnbLWXKElV4Gabq3ardnFcgytSyJAif4F+uOGsLnh2h3A3DMbfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpLP5TaB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpLP5TaB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C227A1F00A3A;
	Tue,  8 Sep 2026 12:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788872335;
	bh=TnUzjB/BVUox34Inim8ZJg7LkRmxK7GnfALHInGkieg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RpLP5TaBRgzF3EJxA8+CtI6mxFs1u5wtAu8Ny0mhs8NFf76awTcT51Zxf0Khcn/zB
	 xhzzHhLSsDyS8FKshTCDckxHWyA5aVmvua3VNBRd3U8dyMHqcIX4L64tqAzLVjo9Ap
	 6wgRKbeKJ+eEjtSRn+gWKKi05Hdh33anL+mL5Le9gsPXB5+x/wFCe7vnzHqawcv2UO
	 xRIq3fx9FFantSQF6Fda6QFV9dTEqn/tIWaUgY2Z3FXjQ9AB+SK6SD0/RXd9/C9QU8
	 PdmE4Mu0c9T23gtxzOHcn0DMCoIFho/uAhNu+4kzo0PcCT666FepcqeGGoy8fZkPE9
	 NVKaW+1RLmHhQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] coresight: etm3x: Fix cntr_val_show() to match cntr_val_store() behavior
Date: Tue,  8 Sep 2026 08:58:53 -0400
Message-ID: <20260908125853.2181503-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090328-improve-creative-0e66@gregkh>
References: <2026090328-improve-creative-0e66@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuan-Wei Chiu <visitorckw@gmail.com>

[ Upstream commit 41fb4e925528aefa4b7a5f76c7f81db99c0d0f38 ]

The cntr_val_show() function was intended to print the values of all
counters using a loop. However, due to a buffer overwrite issue with
sprintf(), it effectively only displayed the value of the last counter.

The companion function, cntr_val_store(), allows users to modify a
specific counter selected by 'cntr_idx'. To maintain consistency
between read and write operations and to align with the ETM4x driver
behavior, modify cntr_val_show() to report only the value of the
currently selected counter.

This change removes the loop and the "counter %d:" prefix, printing
only the hexadecimal value. It also adopts sysfs_emit() for standard
sysfs output formatting.

Fixes: a939fc5a71ad ("coresight-etm: add CoreSight ETM/PTM driver")
Cc: stable@vger.kernel.org
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20251202082613.3265761-1-visitorckw@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../hwtracing/coresight/coresight-etm3x-sysfs.c   | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index e8c7649f123e7..30fae661090fe 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
@@ -716,26 +716,19 @@ static DEVICE_ATTR_RW(cntr_rld_event);
 static ssize_t cntr_val_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
-	int i, ret = 0;
 	u32 val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etm_config *config = &drvdata->config;
 
 	if (!local_read(&drvdata->mode)) {
 		spin_lock(&drvdata->spinlock);
-		for (i = 0; i < drvdata->nr_cntr; i++)
-			ret += sprintf(buf, "counter %d: %x\n",
-				       i, config->cntr_val[i]);
+		val = config->cntr_val[config->cntr_idx];
 		spin_unlock(&drvdata->spinlock);
-		return ret;
-	}
-
-	for (i = 0; i < drvdata->nr_cntr; i++) {
-		val = etm_readl(drvdata, ETMCNTVRn(i));
-		ret += sprintf(buf, "counter %d: %x\n", i, val);
+	} else {
+		val = etm_readl(drvdata, ETMCNTVRn(config->cntr_idx));
 	}
 
-	return ret;
+	return sysfs_emit(buf, "%#x\n", val);
 }
 
 static ssize_t cntr_val_store(struct device *dev,
-- 
2.53.0

