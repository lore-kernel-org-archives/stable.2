Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003A732F748
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 12:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205663; cv=none; b=GqD99Jdr4atUvYOB4/p4CcAwxYUKgcAnbxqL9yt9cy/Xw1LdGwpFIcIrFv5wwtN1z8CVIAXUGyatWfM09oh94nH0jdkWmHJCoEvtTGX6zJZGHUEwFTGh72KvndKeWH41Lg3MHS6ARGuf4qqqNHx99tJB8hwzypx9Jg4WBpXBVyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205663; c=relaxed/simple;
	bh=4bxClnz7eqpF3GVkmNXTMi78mG5e305OEA4Z/XmfeHE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=czZ5JIO0M7YYQ3qMLhmuAIWTVHMuexQ37Zc5ToYNc3BH++8zDD66EePdyZE+tDmxRnkXbZxlxmWYuSAOMbeMigSViXT8yTxYROsWLKj5vIGs9v2RtlwhwLXREGH9E/xdexn2xv5GQZrn87MBGgsiWlnwLoNur3TWmvdATjfMjPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x4YFrHNI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x4YFrHNI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8861F000E9;
	Thu, 16 Jul 2026 12:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784205661;
	bh=Ld9WMHaziqiryaujK9TLYL0BAwtRCzq+XwNBlrdFuS0=;
	h=Subject:To:Cc:From:Date;
	b=x4YFrHNIBN6fNDRjn+JqMK0eo9Xp2g5xZGJrJvdKFDONL191ldAz1xpqnP4ca0T/m
	 U2Y4CPO6jY/6Idtw7drwmLprC1LYlJsGGI/+xJUrcTOXQTrwqQsNjJ+UFLOFk1pJnq
	 M0LzIBP/PeBW8hZf+rqTdey+mXhmrAZILFBz94e8=
Subject: FAILED: patch "[PATCH] i2c: core: fix adapter debugfs creation" failed to apply to 6.1-stable tree
To: johan@kernel.org,wsa+renesas@sang-engineering.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jul 2026 14:40:37 +0200
Message-ID: <2026071636-deceiver-subzero-c7fe@gregkh>
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
git cherry-pick -x 07d5fb537928aad4369aaff0cbae73ba38a719af
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071636-deceiver-subzero-c7fe@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 07d5fb537928aad4369aaff0cbae73ba38a719af Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Mon, 11 May 2026 16:37:10 +0200
Subject: [PATCH] i2c: core: fix adapter debugfs creation

Clients can be registered from bus notifier callbacks so the debugfs
directory needs to be created before registering the adapter as clients
use that directory as their debugfs parent.

Move debugfs creation before adapter registration to avoid having
clients create their debugfs directories in the debugfs root (which is
also more likely to fail due to name collisions).

Note that failure to allocate the adapter name must now be handled
explicitly as debugfs_create_dir() cannot handle a NULL name (unlike
device_add() which returns an error).

Fixes: 73febd775bdb ("i2c: create debugfs entry per adapter")
Cc: stable@vger.kernel.org	# 6.8
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 1caaa3b3ee10..25d66de41287 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1557,7 +1557,10 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 		goto out_list;
 	}
 
-	dev_set_name(&adap->dev, "i2c-%d", adap->nr);
+	res = dev_set_name(&adap->dev, "i2c-%d", adap->nr);
+	if (res)
+		goto err_remove_irq_domain;
+
 	adap->dev.bus = &i2c_bus_type;
 	adap->dev.type = &i2c_adapter_type;
 	device_initialize(&adap->dev);
@@ -1575,14 +1578,14 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	pm_suspend_ignore_children(&adap->dev, true);
 	pm_runtime_enable(&adap->dev);
 
+	adap->debugfs = debugfs_create_dir(dev_name(&adap->dev), i2c_debugfs_root);
+
 	res = device_add(&adap->dev);
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
-		goto err_put_adap;
+		goto err_remove_debugfs;
 	}
 
-	adap->debugfs = debugfs_create_dir(dev_name(&adap->dev), i2c_debugfs_root);
-
 	res = i2c_setup_smbus_alert(adap);
 	if (res)
 		goto out_reg;
@@ -1606,13 +1609,14 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 
 out_reg:
 	i2c_deregister_clients(adap);
-	debugfs_remove_recursive(adap->debugfs);
 	device_del(&adap->dev);
+err_remove_debugfs:
+	debugfs_remove_recursive(adap->debugfs);
 err_put_adap:
 	init_completion(&adap->dev_released);
 	put_device(&adap->dev);
 	wait_for_completion(&adap->dev_released);
-
+err_remove_irq_domain:
 	i2c_host_notify_irq_teardown(adap);
 out_list:
 	mutex_lock(&core_lock);

