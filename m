Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6C14A3413
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 13:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783000416; cv=none; b=W+tWHr+eOosNUt0SkPY8MHRRKx/9163o3fr/Z2P/y/Z6ADMXFG710JEnhFwtFasHmYNu4FylpqhaUZET5vCw//6Z5K0TEkHr/X3e7Xw9pmG9KXHmOyLBMQtl9oqSCt+gupbevdG2Oxc+6KklXAFLV4guUX/UHMrbgySP43InMus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783000416; c=relaxed/simple;
	bh=2k9qpOuOLPRa1MNAE804g+Ra8GD/o82U5xjly2PYCZ0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kBlYJz6bWdEmzCDUaifPoWX77qT/9GF6tbh3dX1A4ZAfD6ACnWVdEyBiane2nd2wkfKl80w7vR0r06jggQR2zEjHstMmsnUAZ8uIowhJUDrdjhfibmhN3Fqw9ucwJDei6kRJjEEjVNhtsX8ScVKsWmxMMMCqoDZ+eyztkQZVHkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gis/2q85; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gis/2q85"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 807A91F000E9;
	Thu,  2 Jul 2026 13:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783000415;
	bh=5fnqPH6tPfCs1DmKT5+ToLv93lUDLWknc37VYicDizk=;
	h=Subject:To:Cc:From:Date;
	b=Gis/2q85xNgc0B0HSMeXyRuziTSt40Qh3D2N8Bl6G8PkT2uicIfGNa/LlhvdpQKom
	 /slx/6dMZEqeVgfSWY27uuvF63BX/8X/oRDyc52N1uqdqFpk+7k8YGQBAfdv6zElR4
	 ssXyv3muGrOAapbQPYzoYqMj5T0/MqtP7JsJPICQ=
Subject: FAILED: patch "[PATCH] i2c: core: fix adapter registration race" failed to apply to 5.10-stable tree
To: johan@kernel.org,wsa+renesas@sang-engineering.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 15:53:33 +0200
Message-ID: <2026070233-lushly-episode-a47f@gregkh>
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
git cherry-pick -x ba14d7cf2fe7284610a29854bdff22b2537d3ce6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070233-lushly-episode-a47f@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ba14d7cf2fe7284610a29854bdff22b2537d3ce6 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Mon, 11 May 2026 16:37:12 +0200
Subject: [PATCH] i2c: core: fix adapter registration race

Adapters can be looked up based on their id using i2c_get_adapter()
which takes a reference to the embedded struct device.

Make sure that the adapter (including its struct device) has been
initialised before adding it to the IDR to avoid accessing uninitialised
data which could, for example, lead to NULL-pointer dereferences or
use-after-free.

Note that the i2c-dev chardev, which is registered from a bus notifier,
currently uses i2c_get_adapter() so the adapter needs to be added to the
IDR before registration.

Fixes: 6e13e6418418 ("i2c: Add i2c_add_numbered_adapter()")
Cc: stable@vger.kernel.org	# 2.6.22
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index fdf7d7d50f79..01a984d3ca0e 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1580,6 +1580,10 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 
 	adap->debugfs = debugfs_create_dir(dev_name(&adap->dev), i2c_debugfs_root);
 
+	mutex_lock(&core_lock);
+	idr_replace(&i2c_adapter_idr, adap, adap->nr);
+	mutex_unlock(&core_lock);
+
 	res = device_add(&adap->dev);
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
@@ -1638,7 +1642,7 @@ static int __i2c_add_numbered_adapter(struct i2c_adapter *adap)
 	int id;
 
 	mutex_lock(&core_lock);
-	id = idr_alloc(&i2c_adapter_idr, adap, adap->nr, adap->nr + 1, GFP_KERNEL);
+	id = idr_alloc(&i2c_adapter_idr, NULL, adap->nr, adap->nr + 1, GFP_KERNEL);
 	mutex_unlock(&core_lock);
 	if (WARN(id < 0, "couldn't get idr"))
 		return id == -ENOSPC ? -EBUSY : id;
@@ -1672,7 +1676,7 @@ int i2c_add_adapter(struct i2c_adapter *adapter)
 	}
 
 	mutex_lock(&core_lock);
-	id = idr_alloc(&i2c_adapter_idr, adapter,
+	id = idr_alloc(&i2c_adapter_idr, NULL,
 		       __i2c_first_dynamic_bus_num, 0, GFP_KERNEL);
 	mutex_unlock(&core_lock);
 	if (WARN(id < 0, "couldn't get idr"))

