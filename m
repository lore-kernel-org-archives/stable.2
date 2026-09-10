Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86CA349CFD
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003576; cv=none; b=G2fX+T7f20HBshAVZEoaQC8uYx3d4NqEdN4ADDyI0QVfZ3JnNI+sPmt+68IdAkKmW20rhUuS4qbL1SAH2g4XSpMnAk/vWWy1+CDLxhQFkQtJHBlHQse/oX04368bv6uksKI9ftaAeEKQNGjoKWIzAXE41yHGxShNkVyYHv3HPL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003576; c=relaxed/simple;
	bh=OT5N0THSCo35iF1wYeVt7ULQXT1s8ijS4CEOrAAMJPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=awHrB6/vJggiWCwHa0iVYtOjVjHEE1LZrg5eu1AxBvVwpGlxC5HSOA2A8pztW9jiKbBK87+ZShgGi052hgxs5NNGw7qWq3bmHTCWGZT1TSDElnK/zJXXLMMZOS+nQV6yaAtG5//A57X7fNSroGU872/tz5eDOU42at5lc5OiUbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5V4GS2O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5V4GS2O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1596F1F00893;
	Thu, 10 Sep 2026 01:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789003574;
	bh=uKKDJGEmPupxSmPCx4FfyfboifuDpV5V9CUZsxJ53Ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i5V4GS2OjFkTmDT3rOdhVmrOvYa9yXKsvF3UqWU0APmJ8R9P8Sr0zJK/2buuncpVn
	 H3Q/p5w5AEc2c9s13htlmkcQDnihWSHhXB6dwoX/x1a8FyoMXmEUlHXkVHR1iF3IFG
	 FVWZZXD2KYUET33VDl2ZQp/KniihUkyNVwrCohbyYTrT7LpoZXt9FWRpQ3PxuIhg3d
	 5UexFxaZgh2ftkDEAyJjsaoqkilKt6uuAgNMKIAD2Hj1tcqu5HFqYIqqFl4fPU2G7H
	 9X6gHPf6smwIIjmaqDExKnKAFn+sGiKgUrA7q0BmMraZKSEkfRTKv8YBHnGrHOAa6F
	 wpZKCb5y98UiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Frank Li <Frank.Li@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] i3c: master: Fix use-after-free of master->this
Date: Wed,  9 Sep 2026 21:26:12 -0400
Message-ID: <20260910012612.3866980-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090432-surpass-exciting-1def@gregkh>
References: <2026090432-surpass-exciting-1def@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit feb0ed76601f3c2f91f08688c5a7d8b9d382f720 ]

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
[ retained of_node_put(dev->of_node) instead of upstream’s fwnode_handle_put(dev->fwnode). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index add78b03c5338..e91cedea961eb 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -529,6 +529,11 @@ static struct attribute *i3c_masterdev_attrs[] = {
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
@@ -541,6 +546,8 @@ static void i3c_masterdev_release(struct device *dev)
 	i3c_bus_cleanup(bus);
 
 	of_node_put(dev->of_node);
+
+	i3c_master_free_i3c_dev(master->this);
 }
 
 static const struct device_type i3c_masterdev_type = {
@@ -728,11 +735,6 @@ static void i3c_device_release(struct device *dev)
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
@@ -1602,6 +1604,8 @@ int i3c_master_set_info(struct i3c_master_controller *master,
 	return 0;
 
 err_free_dev:
+	master->bus.cur_master = NULL;
+	master->this = NULL;
 	i3c_master_free_i3c_dev(i3cdev);
 
 	return ret;
@@ -1622,7 +1626,8 @@ static void i3c_master_detach_free_devs(struct i3c_master_controller *master)
 					i3cdev->boardinfo->init_dyn_addr,
 					I3C_ADDR_SLOT_FREE);
 
-		i3c_master_free_i3c_dev(i3cdev);
+		if (i3cdev != master->this)
+			i3c_master_free_i3c_dev(i3cdev);
 	}
 
 	list_for_each_entry_safe(i2cdev, i2ctmp, &master->bus.devs.i2c,
-- 
2.53.0

