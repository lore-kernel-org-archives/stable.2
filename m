Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE0840D564
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 12:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205731; cv=none; b=Zt58L3ZPVnazvkTHAkwuDyf7NFTSZhlKwTew/Akeu6iV13H87HLkr74QaNpvWwB90hx7ZEo1Rj28D1mnkP4FWNSDR1OQBJRAymcptVfh+dfk/AqkokdGdWYuir4rZl/meYW2XWTNF/nvnhR6JtLeOFlwM5JmN6DGPK32NkulbRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205731; c=relaxed/simple;
	bh=2ksuCQqXZrBoghk02YJYBZGO6JTLMX7SDOqArDL8BhI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=j+R5x0/5722Z4A3a/EWVYFThQEEGeBF6H/Q1HtghdWcxEjyWCm2S7bSduybuRcv1I9LbqBcmiZsdJ2/til0tf/IBO7jffv0MtZ1xB2xSTw7XkKFz9Tzm5qwOLTVZKG+VZ+OybrdP7TuMogXJMp5kwyHd6rXIFMVvfRmqzP/0O5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bVUY9sn6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bVUY9sn6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6751F000E9;
	Thu, 16 Jul 2026 12:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784205728;
	bh=MYwrKwuF9BamfztXDvVgrrCllOOENdjHvm3ABlMRvH8=;
	h=Subject:To:Cc:From:Date;
	b=bVUY9sn6xS9QNPH/rEsT3i1Zopmc0ZHBFwhTSkXYJiBStmeauYRrbrpI8HSDitGMY
	 n0Oz751GjbXRB3oSDppvu/65p2hwBSbXB7xhDdQLi4l7WZVOKXpcYZMu8G90UOyxME
	 DVznBuXcR+0yq23JJsw8B0m1MUqbZ37Tl91kWqbs=
Subject: FAILED: patch "[PATCH] i2c: core: fix adapter deregistration race" failed to apply to 5.10-stable tree
To: johan@kernel.org,khali@linux-fr.org,wsa+renesas@sang-engineering.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jul 2026 14:42:01 +0200
Message-ID: <2026071601-remnant-map-dbc0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x b1a58ed9eab146b36f41a55db8f5d7ce9fdedf3f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071601-remnant-map-dbc0@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b1a58ed9eab146b36f41a55db8f5d7ce9fdedf3f Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Mon, 11 May 2026 16:37:13 +0200
Subject: [PATCH] i2c: core: fix adapter deregistration race

Adapters can be looked up by their id using i2c_get_adapter() which
takes a reference to the embedded struct device.

Remove the adapter from the IDR before tearing it down during
deregistration (and on registration failure) to make sure its resources
are not accessed after having been freed (e.g. the device name).

Fixes: 35fc37f81881 ("i2c: Limit core locking to the necessary sections")
Cc: stable@vger.kernel.org	# 2.6.31
Cc: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 01a984d3ca0e..38f425aecef8 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1587,7 +1587,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	res = device_add(&adap->dev);
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
-		goto err_remove_debugfs;
+		goto err_replace_id;
 	}
 
 	res = i2c_setup_smbus_alert(adap);
@@ -1614,7 +1614,10 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 out_reg:
 	i2c_deregister_clients(adap);
 	device_del(&adap->dev);
-err_remove_debugfs:
+err_replace_id:
+	mutex_lock(&core_lock);
+	idr_replace(&i2c_adapter_idr, NULL, adap->nr);
+	mutex_unlock(&core_lock);
 	debugfs_remove_recursive(adap->debugfs);
 	pm_runtime_disable(&adap->dev);
 err_put_adap:
@@ -1804,6 +1807,8 @@ void i2c_del_adapter(struct i2c_adapter *adap)
 	/* First make sure that this adapter was ever added */
 	mutex_lock(&core_lock);
 	found = idr_find(&i2c_adapter_idr, adap->nr);
+	if (found == adap)
+		idr_replace(&i2c_adapter_idr, NULL, adap->nr);
 	mutex_unlock(&core_lock);
 	if (found != adap) {
 		pr_debug("attempting to delete unregistered adapter [%s]\n", adap->name);

