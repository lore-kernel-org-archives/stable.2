Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895664B339C
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444912; cv=none; b=OzZ8Cjf84q4M6RcVzVZwtW5orsV43G7nFfNyyrtiz4uv7lVNuhy3kFZ0nHLwgv7Mxo03VLvySf8LDCE1Z/3w8Sz1mlWA0W+4NLwjlO9oUkb6DXpeFKt0PnHi5gIldIrINSkFf1t3WhXI4qkFf3BudZuT+FVMP4xWRUMBL0cGHHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444912; c=relaxed/simple;
	bh=TiCtw98GYtE4btF+BD3wt2iSuaxRHWbWVRLqkwZSv3o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hk3VCTaHFHlHHpG3QGPiNCmY7JF3yY/hkMT61Knh58UwwwfFck/QHBn/wKdem2LcXosfNWYEBphkNCjvAVIsdaIm2URRfywFJ9AqZSTL1rZbhit8BRSlPHc95unaejb/JsqZa4GmvwaokKUkhu7sX6tWe6JF923sPSFxOfrJCWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KWg/wSSF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KWg/wSSF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1EE1F00AC4;
	Thu,  3 Sep 2026 14:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788444895;
	bh=QXgbD/zq3it6noHmy5SvzaUQidGfGG9opL05zn4Kaf8=;
	h=Subject:To:Cc:From:Date;
	b=KWg/wSSFU+Z6GjxpwmCshIiBNU74pxkJzTw5t8x0OIhSr9IzaqCwuhcIrQWWUUArx
	 B4i1+hkjhtti15XKINpsiItiBM+xdeOP3OdyGh3x67DUHCa/R2sGf30bALBqZTkwxi
	 tHgdcmcxujCEB6amo4TRwsiTLHncTAqhdFr3Ox2Q=
Subject: FAILED: patch "[PATCH] coresight: etm3x: Fix cntr_val_show() to match" failed to apply to 6.6-stable tree
To: visitorckw@gmail.com,james.clark@linaro.org,suzuki.poulose@arm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:53:27 +0200
Message-ID: <2026090327-scion-anaconda-5706@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 41fb4e925528aefa4b7a5f76c7f81db99c0d0f38
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090327-scion-anaconda-5706@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

