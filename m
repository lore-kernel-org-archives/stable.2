Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4674B270F
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444913; cv=none; b=ELSlD9U3pHHHEcpTPYUzXHtEUdeeLkqu2/NoBEmN2XImW2vfwnBOpzzTu5Y9uJffhFDUwElIIkCG0Bc+FfTJU/6KVUP9/PoJZaljbTWEe99RyXaIAQaPMl3c69h3tDKymBXZEy8CoXsk6+3AJvjewD53xe9nC7GeW0+Kxxl+rIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444913; c=relaxed/simple;
	bh=D5CfvwnkhYyTCwzl5lr3PU1ngeL7Q2xlRXC6FndGokw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=M6aDnwAs6MvWHB6dbJnc6WW05iIyggZj2cr52yv7OTB69YeWLhZFNnZ0bUHtccItaCGhGj5mnkI5mIQGT3DdJ7WgO61NOdB4bxa+R6HbFe0e5B6IIKzFPcNHkqRhhsenn1+3sf1K1AuG0vxnyD8ofqkqoVMt9rgsVQ0FWQo1DlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bv+twcd4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bv+twcd4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81371F00A3D;
	Thu,  3 Sep 2026 14:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788444898;
	bh=wdQHfuR+/WVTChctGT/OE6sXVW8sxIC1lCeYhC9U7bU=;
	h=Subject:To:Cc:From:Date;
	b=Bv+twcd4E2H/pVDRDadzzb/0o3Y2a6WsFA/zLCppAHaNwBOaFvBW783sabj2cS+hB
	 32mH/pTGqQZCS269FROW3xdUpW7G5MK8BQ0xdy6rBV+FF4JicK/xKF44Ejhx7ce3e+
	 ZivUn9l/W0ZcxbRotFR0kG/NgtGUiP4nExGu3FKI=
Subject: FAILED: patch "[PATCH] coresight: etm3x: Fix cntr_val_show() to match" failed to apply to 5.15-stable tree
To: visitorckw@gmail.com,james.clark@linaro.org,suzuki.poulose@arm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:53:28 +0200
Message-ID: <2026090328-improve-creative-0e66@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 41fb4e925528aefa4b7a5f76c7f81db99c0d0f38
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090328-improve-creative-0e66@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 41fb4e925528aefa4b7a5f76c7f81db99c0d0f38 Mon Sep 17 00:00:00 2001
From: Kuan-Wei Chiu <visitorckw@gmail.com>
Date: Tue, 2 Dec 2025 08:26:13 +0000
Subject: [PATCH] coresight: etm3x: Fix cntr_val_show() to match
 cntr_val_store() behavior

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

diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index 762109307b86..b3c67e96a82a 100644
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
 
 	if (!coresight_get_mode(drvdata->csdev)) {
 		spin_lock(&drvdata->spinlock);
-		for (i = 0; i < drvdata->nr_cntr; i++)
-			ret += sprintf(buf, "counter %d: %x\n",
-				       i, config->cntr_val[i]);
+		val = config->cntr_val[config->cntr_idx];
 		spin_unlock(&drvdata->spinlock);
-		return ret;
+	} else {
+		val = etm_readl(drvdata, ETMCNTVRn(config->cntr_idx));
 	}
 
-	for (i = 0; i < drvdata->nr_cntr; i++) {
-		val = etm_readl(drvdata, ETMCNTVRn(i));
-		ret += sprintf(buf, "counter %d: %x\n", i, val);
-	}
-
-	return ret;
+	return sysfs_emit(buf, "%#x\n", val);
 }
 
 static ssize_t cntr_val_store(struct device *dev,

