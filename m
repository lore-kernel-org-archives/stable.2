Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39893370AC2
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 04:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788496695; cv=none; b=JVANUjtjEsj1JvBn8//zxko4YL0kfAjCiUcY9AscI1bNcg27q8kaFdmjUz2VXaKqNqi88u0OoCwkIXJh63UWkom5SAJG+m+kiIFRJrLlV0wIs+IMe3nlzZ4YfxZbA9ChIhjmUcUCOBlih6khCssOnq0jgFDhy4KnZkQn51FntW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788496695; c=relaxed/simple;
	bh=CmWx82HIPneGEmxPzzQLcFHBELyhwt1e3xODwSeuPvw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eURX9Q2tjW9/qjJHDtaPg2Azb2HcZ2XZn6pecKzfmFzv+lDV6VkD+FnPs+p9bSMIagv+44ryT95A/RW+IV3N6cwAIRjn1IPc9J47428RlCvcbW0h5hFCeFrkL2mHQf/1OdDjY8ZpUrc9h6m6m27ke9zLpJuX52t2IEWlKjBcu80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WiKBXTF5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WiKBXTF5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930471F00A3D;
	Fri,  4 Sep 2026 04:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788496694;
	bh=recX+zeLoyZ60sAF3wKRDUs6lp0d3N46uFlVQsx6/I4=;
	h=Subject:To:Cc:From:Date;
	b=WiKBXTF5JRLBP/P9PE3Td1fTbPCsuO/9rdGOBk8pWo+zaOme1vPYAcAElQYFj7gzV
	 f0Y8mmqBCduKYWRrGmkWcW8AzSf2YSj7kMjH1gbmB9l4f7Uy4FwZ4fY1NHuf+hW6IH
	 vmU1iwix42+nfu91OIpaxQIqSOFvqekF46fa3+5k=
Subject: FAILED: patch "[PATCH] i3c: master: Fix use-after-free of master->this" failed to apply to 5.10-stable tree
To: adrian.hunter@intel.com,Frank.Li@nxp.com,alexandre.belloni@bootlin.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 04 Sep 2026 06:37:32 +0200
Message-ID: <2026090432-creasing-wilt-9c7e@gregkh>
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
git cherry-pick -x feb0ed76601f3c2f91f08688c5a7d8b9d382f720
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090432-creasing-wilt-9c7e@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From feb0ed76601f3c2f91f08688c5a7d8b9d382f720 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@intel.com>
Date: Fri, 7 Aug 2026 17:56:28 +0300
Subject: [PATCH] i3c: master: Fix use-after-free of master->this

sysfs attribute callbacks for the master controller device dereference
master->this.  However, master->this is freed in
i3c_master_detach_free_devs() before the master device itself is
released.

As a result, sysfs accesses can dereference a freed master->this
pointer, leading to a use-after-free.

Keep master->this alive until i3c_masterdev_release(), which is called
after the master device and its sysfs state are being torn down. Do not
free master->this as part of the normal device detach path.

On the error path in i3c_master_set_info(), reset master->this and
bus.cur_master to NULL before freeing the allocated device.

Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260807145638.168865-5-adrian.hunter@intel.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index abb582645a2e..2357874bb9d6 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -842,6 +842,11 @@ static struct attribute *i3c_masterdev_attrs[] = {
 };
 ATTRIBUTE_GROUPS(i3c_masterdev);
 
+static void i3c_master_free_i3c_dev(struct i3c_dev_desc *dev)
+{
+	kfree(dev);
+}
+
 static void i3c_masterdev_release(struct device *dev)
 {
 	struct i3c_master_controller *master = dev_to_i3cmaster(dev);
@@ -854,6 +859,8 @@ static void i3c_masterdev_release(struct device *dev)
 	i3c_bus_cleanup(bus);
 
 	fwnode_handle_put(dev->fwnode);
+
+	i3c_master_free_i3c_dev(master->this);
 }
 
 static const struct device_type i3c_masterdev_type = {
@@ -1125,11 +1132,6 @@ static void i3c_device_release(struct device *dev)
 	kfree(i3cdev);
 }
 
-static void i3c_master_free_i3c_dev(struct i3c_dev_desc *dev)
-{
-	kfree(dev);
-}
-
 static struct i3c_dev_desc *
 i3c_master_alloc_i3c_dev(struct i3c_master_controller *master,
 			 const struct i3c_device_info *info)
@@ -2266,6 +2268,8 @@ int i3c_master_set_info(struct i3c_master_controller *master,
 	return 0;
 
 err_free_dev:
+	master->bus.cur_master = NULL;
+	master->this = NULL;
 	i3c_master_free_i3c_dev(i3cdev);
 
 	return ret;
@@ -2286,7 +2290,8 @@ static void i3c_master_detach_free_devs(struct i3c_master_controller *master)
 					i3cdev->boardinfo->init_dyn_addr,
 					I3C_ADDR_SLOT_FREE);
 
-		i3c_master_free_i3c_dev(i3cdev);
+		if (i3cdev != master->this)
+			i3c_master_free_i3c_dev(i3cdev);
 	}
 
 	list_for_each_entry_safe(i2cdev, i2ctmp, &master->bus.devs.i2c,

