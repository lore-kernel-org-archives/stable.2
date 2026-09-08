Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAD2549362
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 13:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873130; cv=none; b=O0Pvklsb9AsVPVQChlnSZIBP7YCWCHel0zE5h8SmFcxgei3ksi95tQMwJcTcL67PQwMNiu+FFWt/plDj0NySzBc95yYqI15AI1x5Xm1jICGEzVp6whoMC2Oz/9FKWnYMaOYIrCyRNQWxdDQjLO+M98Z4GbXmKsQ1vjwUETEauzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873130; c=relaxed/simple;
	bh=4UQgB7+0+JEhVXz8ALEjW3N1sX2IARIbQKvTQaRirJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AwiPmgIb9CnWFHKSnv9J31bMI8FiuapAWpW0y/5QXe+EG7z2v9F8tF0Ii4taLYwq7OrtinGJAEyCBArQVkAhEcY3TAHLtdMcMlhGzAO2Wy+iIEbrteLnT/3hm9SUQfkMhacZQ7k4aAfozn4lo3jZHcCIgcUMvgWVr9qhqtjaXrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkBy+1jH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkBy+1jH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C574B1F00A3D;
	Tue,  8 Sep 2026 13:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788873121;
	bh=TnUzjB/BVUox34Inim8ZJg7LkRmxK7GnfALHInGkieg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CkBy+1jHVRBKxYPYGP5I/Fv+w7K7XSobWBcy2zxxPeYOHDPzesk3DZMiFXWhJ0zo9
	 htQuoQqWlorHEtiTwC0Xqp1y+rCsZO8jbykpWkDdluRbF6L7BZMiNjyTveBRPxlIEV
	 WJPlGv8pd/jbJL2w4+slBLV3Itvr2wjd6XDmoup1bxRt+HFM2F7LTihpJrLpH2Ougc
	 Gz2bH2l9ur75VSUHga7qb84FnIzge4ADeq3cCPiBOENlnza6J9soWLt7x5ASP03V7x
	 uBmcbec3Qwc4OD5MfiUVBri2bgNqsz77diu1gAUCf04P0kA6yFtXK+wtSi+4Fas6YL
	 bAIy/a01WI+kg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] coresight: etm3x: Fix cntr_val_show() to match cntr_val_store() behavior
Date: Tue,  8 Sep 2026 09:11:59 -0400
Message-ID: <20260908131159.2235921-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090328-wildland-dweller-279c@gregkh>
References: <2026090328-wildland-dweller-279c@gregkh>
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

