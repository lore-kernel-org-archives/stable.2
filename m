Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471C76DCE1
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003770; cv=none; b=Bh9BDe8jSkriLKChjurR6FX2VomLcFyrLa2Ps4c9kEYrzgO0n8fFZFSyk7WynW+5wAlNbN2nHq3G/HKcvNcY5rTkKSi5kmcThjxG1t34+e51hLd2Pr/VfENYQuClFHXvLlHeNlnWs8ZDez+vuG4YS9Exq7Z76g+FLk381oOBFys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003770; c=relaxed/simple;
	bh=7CoztHRx3efld8qquUKAkxpRDFMl3TrIzuWvPVKcEnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X5RB2jktMZ5OqYmF+GW9oYUvXGOl6iB+CGhk2AAlBdloCF7kd8NjeqboHPbUZLA2lX6zCEzjiJHm81Q+dXh7FDoGtRc9iSG3bBC3+hPUg62kFEKWEGvXJZvZOxgnOvJ5Lt7O5hMeuJYz79S+I2UYD+RypxU04F0Zydf+vceKWLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhKd1FOO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhKd1FOO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E7C1F000FF;
	Thu, 10 Sep 2026 01:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789003768;
	bh=IBxw96PZlkxSpSFn1Zab0vO4YYOJLGliWLpPr9Y4yxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EhKd1FOOuCsvLRn9wQrd5WcYnDMEWEU7u0/p3mXrfIX/5dwUw7aslodVoD4opwr7W
	 1EKzUtE/m0JmEQGbfAOMIqQZ4pzVet9QBx4ofFig0xtkEe7ZlvaVKNzAFmUEPF3BKV
	 fITAeJPyi2iwM60VGrKmwGFjqy+zPeMDPShERRcXf8Wb6umBPpbz46QWUCdpjyDtrs
	 POG6jTEvFZ+wI84kUQJMNxBF7NY9PIh9v66HMP7Ofqa5lBDtcoEuKpXfT0fOrDxk1t
	 h6rmA1JpkswkijL00HxtA3KFAWqQcDkd5uDfWbzMMMV2VwGAHMq5VQdCmBWpIrwai6
	 VhIOIGvaR7rAA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Frank Li <Frank.Li@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] i3c: master: Fix use-after-free of master->this
Date: Wed,  9 Sep 2026 21:29:26 -0400
Message-ID: <20260910012926.3879265-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090432-creasing-wilt-9c7e@gregkh>
References: <2026090432-creasing-wilt-9c7e@gregkh>
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
index 22a95b30d5aba..cfd7496f70447 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -575,6 +575,11 @@ static struct attribute *i3c_masterdev_attrs[] = {
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
@@ -587,6 +592,8 @@ static void i3c_masterdev_release(struct device *dev)
 	i3c_bus_cleanup(bus);
 
 	of_node_put(dev->of_node);
+
+	i3c_master_free_i3c_dev(master->this);
 }
 
 static const struct device_type i3c_masterdev_type = {
@@ -774,11 +781,6 @@ static void i3c_device_release(struct device *dev)
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
@@ -1641,6 +1643,8 @@ int i3c_master_set_info(struct i3c_master_controller *master,
 	return 0;
 
 err_free_dev:
+	master->bus.cur_master = NULL;
+	master->this = NULL;
 	i3c_master_free_i3c_dev(i3cdev);
 
 	return ret;
@@ -1661,7 +1665,8 @@ static void i3c_master_detach_free_devs(struct i3c_master_controller *master)
 					i3cdev->boardinfo->init_dyn_addr,
 					I3C_ADDR_SLOT_FREE);
 
-		i3c_master_free_i3c_dev(i3cdev);
+		if (i3cdev != master->this)
+			i3c_master_free_i3c_dev(i3cdev);
 	}
 
 	list_for_each_entry_safe(i2cdev, i2ctmp, &master->bus.devs.i2c,
-- 
2.53.0

