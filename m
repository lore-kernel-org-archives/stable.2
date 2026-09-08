Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349A753CA95
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870978; cv=none; b=APLP9DJ0z3maUe4BNRObHfnwXyH7Zme7xo2OiyUVtVNR0v9JrnxV8la1HXQLTpHwr0gIMaI4+3uREgHZOAVDVmsjLUSFng0v46RUSTQLqhssfolcyn2HLwOjMgseCSpXRSq+dQj7gC3qQkfmKZ2aNaEM6dV0tNo9OT+Rlm1mZ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870978; c=relaxed/simple;
	bh=qCF0gk4fJMQ/gC3vusoKYlPpqlPDP7a7Dg5rLPYkjh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=murIzi+OhRubANY8h7e6wTKEWx0y9kXxWUnjwOxwEjSMzwdNF253Elm4Lv5ULmHospfbv4ZGU4dnLncT1wvV0LogGRwGrwrcHszfprTJ403gRVcMQ2FEuAXx7da9XofYAR1IX9KP/SHGdMKJTOGPrajCNw8seEjAWbTjzdhhG2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHQsaoOA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHQsaoOA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E2C1F00A3D;
	Tue,  8 Sep 2026 12:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788870975;
	bh=aUhbjvQMGzcXZHu7Le8gtyX6ZyWm2EZxU0PPXjJOFPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OHQsaoOAOgQggHjVOVupyp1ue5b+uijNDyFxP/hBJgFYXKbWDaYO6N9Tlss0R5/qD
	 W6iQN+vmXKiOt4nVXz19vP0DsoYWr/rkVQO0u8vuzI8UYrYxyR/qXtIJTIpOb/4H5K
	 ySmjMK+hUy5zmexFLAKhuhenu+v7B0XKTbBp6K6Gu/dBzay6GvMJY+x48SdqJkXW4d
	 UVPIlFrzHqTswTmsp2SOcWnBSFR5l7nxp5sWEG7vHlhnr6AB1dUUJCBxT9eBs3jz9f
	 PyE7xKpHO7MKsCyBUSxUFWaBtDPfJmxJqb8AsQfWQk5GdOYEageZE+5OLQa70XeVpi
	 A4jxceeHDuwGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] coresight: etm3x: Fix cntr_val_show() to match cntr_val_store() behavior
Date: Tue,  8 Sep 2026 08:36:12 -0400
Message-ID: <20260908123612.2107089-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090327-scion-anaconda-5706@gregkh>
References: <2026090327-scion-anaconda-5706@gregkh>
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
index 2f271b7fb048c..c88c64900698b 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
@@ -717,26 +717,19 @@ static DEVICE_ATTR_RW(cntr_rld_event);
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

