Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B57753ED05
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871693; cv=none; b=J9CAzwyd57kp4XEbhcu/3Jyk8grhB7mDbvKYNK2ax130iNup+h4mN4fAoCHx7Xveo8WtZa5GhVt5Z+WI59+59x4OF3Lvq6sdyseoAS1TGFT0QXg716rgaM7cGLPjhJBJNmOXAWdtA3X81zDjHjkJj4h/sMaR5r1n0JEP70t5OFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871693; c=relaxed/simple;
	bh=PpF+Baz4bJnDgaCtFu+j5jWmdooJWhMDFZ8Dsp9E7Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8CGKAeJpwYpKy4vRQ31931Q4nKdRyB6pG9YQVB9SzaOvtETVV+aYrFiCpivrbSGGCLRShqkNHW/5CyeHb6PItbV+IfqTTiNKIhRieMCQFxXR0+YPyBAsAekuFtVUa0TUZY+fL2uR2cLgTNoizVzuu96/j3DglH49pvhb42ul18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkFrjURg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkFrjURg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FCF1F00A3A;
	Tue,  8 Sep 2026 12:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788871692;
	bh=mbxSxkwFQBZaTcOH+iAATTGG1LFPK3ugqbS5CaN4jPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PkFrjURgwgNc1CVOat8rqTC4CWffXjOQa1zcIvxdTfAk/rC+1vf770nNPQgG9yVoA
	 7g2INxTXv+qq/wcBWIr1/TQBAMC3d1tL6O7IeOm8h4lOUM6UyRy0oHUWAyfcENMKj6
	 G052Dyweyhs5HBpoSc7XgFgQ/kEajEYytQ6aZ0Fr0aFMHQ3WkdpFRVls9TBgHv9TCo
	 vfsRvWmPjT0rnBDZqgLZXMkaEXaeHDR1Nbfr/teIKPWtyx9ai7Qr8zTsHXguK/6LgP
	 UZ7pE4QmZE2wk2T3hSUI+NPTrIbEDy6llBLqWApNBg59IwlIOtKciBQQUFUHLf4k0V
	 olw5a2CEBBmAw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] coresight: etm3x: Fix cntr_val_show() to match cntr_val_store() behavior
Date: Tue,  8 Sep 2026 08:48:09 -0400
Message-ID: <20260908124809.2160670-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090328-scrounger-immersion-966f@gregkh>
References: <2026090328-scrounger-immersion-966f@gregkh>
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
index fd81eca3ec182..a49b3c237c079 100644
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

