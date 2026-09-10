Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7994A3659F9
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003044; cv=none; b=gafFLhPjrYfxg6xnTHiGpk/UXLbDTmiU3vg5TYdcCFWciO79uFChjsTZQI9+hYL8B4RbCxDluW8Ix4vqGOoLzaMXpe1uJrB7D7I7nVt3hSEgWzrypV1GWAjxJXdo4pbY9FsdzMLoV2BDJFtCJVXAM6yulTYSOjEf7qUmvoWzl/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003044; c=relaxed/simple;
	bh=k+U10FxcnAx9UrVFoe14MmuVHFJtZYE6T9V4Wm8PyuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uf8JNCcZWF696NaN+Or41E8E10XznsXGHFjBmNPe/Erw/xi3zyfsFumqRAMVD2vLBVciANZABblRdddfAv/NrbZmyjYsFpkkoQmAhw04EQFy13TxQz0janMUb2FzZlW/1GtTgxpHO4fvqxoPWLATgRLQoyNVjxBEYvAFNkZc43U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gpc2nJnR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gpc2nJnR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8187A1F0089B;
	Thu, 10 Sep 2026 01:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789003034;
	bh=5xZv9L7qydQc7xD08rij5pdHfadL/gTNolPEaP82MLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gpc2nJnRmQp/JZW6XGsmoUE4mLPehaeIT2K5VRY4sfMgDZZ9eHYE6KuwHYwe//Yfd
	 dDeRigkP3Grh/nPaZ0g52QcwAEpagnzRI3hpfUWhy/+NDLDs5CFhGCZh1Atv6uk+O/
	 L6vbC9Nxv+eiiAvpBWL+g2KwZFgaTUgtAWTevDdMxwhzpS6YqYLE9PcXuTuTlIpsUL
	 cbDASwD7zCRzg2VmsHfgdyC46Z304Wx5ec0BQg2h3RbxFJuKKz4Dn5bOkrM/aM/jga
	 ewvi4Ora/+6YSUIUMzgb3Bxy8cEUzLX8UldP4K+j1Hs+2M8lLpwYN6/8symdi9IQF5
	 zej5TqmQylADw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Frank Li <Frank.Li@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] i3c: master: Fix use-after-free of master->this
Date: Wed,  9 Sep 2026 21:17:11 -0400
Message-ID: <20260910011712.3831821-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090430-specks-lisp-beb4@gregkh>
References: <2026090430-specks-lisp-beb4@gregkh>
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
index 6eec1e6fb139f..55600b1af316d 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -700,6 +700,11 @@ static struct attribute *i3c_masterdev_attrs[] = {
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
@@ -712,6 +717,8 @@ static void i3c_masterdev_release(struct device *dev)
 	i3c_bus_cleanup(bus);
 
 	of_node_put(dev->of_node);
+
+	i3c_master_free_i3c_dev(master->this);
 }
 
 static const struct device_type i3c_masterdev_type = {
@@ -899,11 +906,6 @@ static void i3c_device_release(struct device *dev)
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
@@ -1782,6 +1784,8 @@ int i3c_master_set_info(struct i3c_master_controller *master,
 	return 0;
 
 err_free_dev:
+	master->bus.cur_master = NULL;
+	master->this = NULL;
 	i3c_master_free_i3c_dev(i3cdev);
 
 	return ret;
@@ -1802,7 +1806,8 @@ static void i3c_master_detach_free_devs(struct i3c_master_controller *master)
 					i3cdev->boardinfo->init_dyn_addr,
 					I3C_ADDR_SLOT_FREE);
 
-		i3c_master_free_i3c_dev(i3cdev);
+		if (i3cdev != master->this)
+			i3c_master_free_i3c_dev(i3cdev);
 	}
 
 	list_for_each_entry_safe(i2cdev, i2ctmp, &master->bus.devs.i2c,
-- 
2.53.0

