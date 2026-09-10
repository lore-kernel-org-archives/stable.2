Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ADE17A2F6
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 00:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788999486; cv=none; b=Jp2GNWepRWZ5D0avN5nBGnKGJWWVI7zy7kemRtACJDCHY01dzgML7ga2ya0c/95ilk5qBwJyEfcRCR9dZTmAQjUfMC75tRGwjULr0eFFK6WdLw7+KY7ZvZrBx2gRpzrlgfioHAlKLAeBaMG7lxMu9IunwOG1Ug7K88JEY1wlcqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788999486; c=relaxed/simple;
	bh=WPFp5I/qfr48LSjHDWsPlavbQzABkJvja0AUAm2m35c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ImWsBwWkuA6zq3JTXy0ZOPeB0ytwtCmK5dhP3PAGDGEIyZGZMit9iQcLfDbVJCJASEf5yf3rDrtFvrhL+PPVmEL07WpoVNkWPvHRX7HCp53PtduMNO4LbM+JJDHaaCLoazzxwIdr+8KWwuYBmA5VuYF3TKYl69iANUnG7W1cyrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1NpNNa6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1NpNNa6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B281F000FF;
	Thu, 10 Sep 2026 00:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788999484;
	bh=DPm3yU3SwPWHgqTD91DM8LoJtC++E1vXoOQSUCvbuTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R1NpNNa6nTt5OnCO9N4VM5l9xAy41qd1Z3kXS2yBVXsVADWobHml3s1A3H8KfgY7r
	 evpNbS9qt00c18uyHbea2ZxbE2j2Wox1mEHERqPHYHirkHcjFk0c9kf7NFrPtu4QYo
	 BFDZKeYfYqKWB815p5LKYJWGpA4lrOewVcLLaO01TKOz0G1sa53JrLUEngqZJ4lhVC
	 l681RmB5xTwoqmZjcEU/ThRH5t2bAgaAkMCJJ4N+/AbXE9o+tN4YIda+8wkbdZGIOm
	 R75Zi5A8tYX8YGHf1RXAU8hE51G5NHNE9Sdz4eKlCzqxTOqN+UPI0Ny7StGAeYZhwK
	 EsFXZ2jCtPm4A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Frank Li <Frank.Li@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y] i3c: master: Fix use-after-free of master->this
Date: Wed,  9 Sep 2026 20:18:02 -0400
Message-ID: <20260910001802.3749089-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090430-outward-retry-7bdd@gregkh>
References: <2026090430-outward-retry-7bdd@gregkh>
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
index b51b159fadeed..6b0646c8645b1 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -820,6 +820,11 @@ static struct attribute *i3c_masterdev_attrs[] = {
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
@@ -832,6 +837,8 @@ static void i3c_masterdev_release(struct device *dev)
 	i3c_bus_cleanup(bus);
 
 	of_node_put(dev->of_node);
+
+	i3c_master_free_i3c_dev(master->this);
 }
 
 static const struct device_type i3c_masterdev_type = {
@@ -1042,11 +1049,6 @@ static void i3c_device_release(struct device *dev)
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
@@ -2069,6 +2071,8 @@ int i3c_master_set_info(struct i3c_master_controller *master,
 	return 0;
 
 err_free_dev:
+	master->bus.cur_master = NULL;
+	master->this = NULL;
 	i3c_master_free_i3c_dev(i3cdev);
 
 	return ret;
@@ -2089,7 +2093,8 @@ static void i3c_master_detach_free_devs(struct i3c_master_controller *master)
 					i3cdev->boardinfo->init_dyn_addr,
 					I3C_ADDR_SLOT_FREE);
 
-		i3c_master_free_i3c_dev(i3cdev);
+		if (i3cdev != master->this)
+			i3c_master_free_i3c_dev(i3cdev);
 	}
 
 	list_for_each_entry_safe(i2cdev, i2ctmp, &master->bus.devs.i2c,
-- 
2.53.0

