Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C424B2CCF
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444920; cv=none; b=hr18m1/ZhnSxjzhEuFedeiPolJ7PHdkMe58ifunmLXZYfv3sGHkZPe/Sui8RM7Lb6cOLSEzCmvNHbdLjBwa4Yyk5HjAI3RBfrqpkBSkTIYayBi41PJoY14RudL66uJDkuRJI330Td06tDeEFUUl9UARRP/D4mB+BlzWMsZidGZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444920; c=relaxed/simple;
	bh=e3M7q3/bQNKpV/yHxPAAIVJvm9O0jS2ZT6bhoGzKS3w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IR+DORAL0qy/8AUu+smDKf7Ot/2u8IwS3k8/OOmDCyrQplPZalFMem+ga7vG9K9shSRzEN3RszvfsEarQ89cjOQwodZ5JBzXvmHynXH9PMTfJqvCcjfE43dRVAcEVIo9k5yiWB4o0w+q0cADMpVq4ryjq/pY/r0nNvifk8gp/K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g9eS0VLa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g9eS0VLa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B001F00A3E;
	Thu,  3 Sep 2026 14:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788444903;
	bh=X5l8Efk4t5as1QrJoqi38/oK4tKDd887A8sGRS2W704=;
	h=Subject:To:Cc:From:Date;
	b=g9eS0VLary3+234elCUYzYb9mZBcpyGIGOmn1yZeF6PSo1d4vZQa4LyDoJUtYGlny
	 YsBn59vYE4kVcdpaQGKmsNCD9DFlPcjH/R5pQ0DMIVdASEFGiKskIxo//zpz16PZ26
	 7P5qw8cqrMceEZMt169EIB5g1zmp12i80rGMSlAM=
Subject: FAILED: patch "[PATCH] coresight: etm3x: Fix cntr_val_show() to match" failed to apply to 6.1-stable tree
To: visitorckw@gmail.com,james.clark@linaro.org,suzuki.poulose@arm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:53:28 +0200
Message-ID: <2026090328-scrounger-immersion-966f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 41fb4e925528aefa4b7a5f76c7f81db99c0d0f38
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090328-scrounger-immersion-966f@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

