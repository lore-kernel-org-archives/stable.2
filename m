Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BDA3101D8
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789002044; cv=none; b=LmWGnzN2xg8Rt1SG0+tmYNuuR9kNUoY7SGYBRtwzW8sraYcjHx3mMK+jPYUonbTKl72Wpc1CA2yvPt6xNwA3eoDWRbo3Hs283jcXqO4neKCVHY2scY1/fH8aFEoyEIYhHBVEx6btRoh7KrUnY2T7VrHB5qUmDHzdZpAVpLPEgBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789002044; c=relaxed/simple;
	bh=G4wh5gsQFrS9x0+XF5GfUArakctwvRhMvUHXxFV5NDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hvglGkWBn2YpRm/9TJFKTuEEuMV/5DHJd3RUX4AZY/0vhhD3MEpmDN1CF7MAhFBnwZjKRBobtlst5JGJDNILPCH5OpfraDIBD4+z4KNMhPY6Sihg9fdLUNs8aZffhTmr6M9PaNk+fjWobQ/Upo6M0ps0Mm5HXAPzM3Dt11Z6Hz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iV4c9EMn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iV4c9EMn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8681F00893;
	Thu, 10 Sep 2026 01:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789002042;
	bh=kyORUyK/LylYVaaVOmKDKjVoxjkIjrOKYRB6YkAu07k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iV4c9EMnI2uppmVBwjWzbmEVWhiUyxJDrmPnY4icySz8uELANjDZJ4vinzDkdVnY4
	 nH7VSuqVrHShNetl5HcrYDJdRbMw1jafkg6YsWkYQxiFKRlOEo6UOoTfyizoP0DWJn
	 mUUvvpq7jDDUNG5MGVmegUqTyIzCVZHXMoyhL9EM1SNqoHc+jsaeqPet+LsbgRlx3u
	 OpZZdxnSQqBL5FrxspRqjLt9pYzO8iZm10aAvlg09W4mMv8enmdBBIg+2ZJr2wz4CU
	 mlRVYo9F3cwZ6sEXhHeeAl7I35tAIzGs3vRQRuZDBRrkekOCsnaegI0nj0r0UTw33Z
	 vcB0sD2fq40Zw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Frank Li <Frank.Li@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] i3c: master: Fix use-after-free of master->this
Date: Wed,  9 Sep 2026 21:00:39 -0400
Message-ID: <20260910010039.3789919-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090430-uneven-sincerity-cdcd@gregkh>
References: <2026090430-uneven-sincerity-cdcd@gregkh>
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
index 41452a27262d6..c528b58970fdb 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -799,6 +799,11 @@ static struct attribute *i3c_masterdev_attrs[] = {
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
@@ -811,6 +816,8 @@ static void i3c_masterdev_release(struct device *dev)
 	i3c_bus_cleanup(bus);
 
 	of_node_put(dev->of_node);
+
+	i3c_master_free_i3c_dev(master->this);
 }
 
 static const struct device_type i3c_masterdev_type = {
@@ -1023,11 +1030,6 @@ static void i3c_device_release(struct device *dev)
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
@@ -2023,6 +2025,8 @@ int i3c_master_set_info(struct i3c_master_controller *master,
 	return 0;
 
 err_free_dev:
+	master->bus.cur_master = NULL;
+	master->this = NULL;
 	i3c_master_free_i3c_dev(i3cdev);
 
 	return ret;
@@ -2043,7 +2047,8 @@ static void i3c_master_detach_free_devs(struct i3c_master_controller *master)
 					i3cdev->boardinfo->init_dyn_addr,
 					I3C_ADDR_SLOT_FREE);
 
-		i3c_master_free_i3c_dev(i3cdev);
+		if (i3cdev != master->this)
+			i3c_master_free_i3c_dev(i3cdev);
 	}
 
 	list_for_each_entry_safe(i2cdev, i2ctmp, &master->bus.devs.i2c,
-- 
2.53.0

