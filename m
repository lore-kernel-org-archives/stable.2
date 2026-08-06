Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21CC48BD57
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 18:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786040257; cv=none; b=hY/HFkz31UKRhgCCoAuNARrw00dxY5l9RALs+csUgvWhld0wbfwpzMogx4CT1wbbuLvQG5rhK0aFNPbMVBmTVxd7h5xN8oisNEWBORigJPIws6kJbUP1f4/Wsr+Rw32jhxgRqaz7Bu+r0lnAnKRTjqstFzehMJXk1GtLars3P2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786040257; c=relaxed/simple;
	bh=vHDZw7jqs4tHbk+G7gYmRfpf2LnHN5sjV6zrjJMeOfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LE/dgicqlbckoagLqJSVbSVqCJkAsI8D0ihf9/D2GkdMGOak8VdHvBQ0JlYdoLVdcGn/5I9o3qtn3M3D/EBym1kRGhYT3zoGad2+7XnllA5VfAja7zjmLJwp2lrLQQmV+QcNIN/TAZHSte0URwYj6TEKFA739sL2sn7iXg7h9yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIgEsTeJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIgEsTeJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BEC1F000E9;
	Thu,  6 Aug 2026 18:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786040255;
	bh=smRVb0VqFGoFfnM6jYpAjBYlcsB3MHtPKK3o1xQAX14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PIgEsTeJAJJNvBMNh3hAfULoIlpRH9NXQraqmCN/OAMEXi//eTfsJ6qZp2eopM8Hk
	 JaZBYl7SuXwsPvJViK1qwXLwPszRg2lJHkgUkyg71y5SHxQzsoCxz2LXySzn4RB/Ql
	 JGuS/7QlGfN7ixpSgZlCsM3ASSmJxtMRUUPpnFrGY88JY0l+Iab/Lc1uoDpXw9fD5L
	 GBTm5B2QezhzwvBBUofAcSs2YXfFw4glqPryih9mkAUZuyvBIQu4j4tpxdpP6LR6xe
	 u9fsejdlVKAwVm/02Ao7MVXY+4QfmB9WKl2t8xHOXwovAgBUWsmDoQOACO7ysz+MEZ
	 x3bHKgEZSuo5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	stable <stable@kernel.org>,
	Menachem Adin <menachem.adin@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mei: bus: access mei_device under device_lock on cleanup
Date: Thu,  6 Aug 2026 14:17:32 -0400
Message-ID: <20260806181732.1423282-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072943-hamlet-onion-0655@gregkh>
References: <2026072943-hamlet-onion-0655@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Usyskin <alexander.usyskin@intel.com>

[ Upstream commit f112ea910e554d58b4b39a4492b7d302f0f4204f ]

Fix couple of problems in mei_cl_bus_dev_release():

mei_cl_flush_queues() is running without lock.
bus->file_list access after mei_dev_bus_put(bus) can become a
use-after-free if this was the last reference to bus.

Protect queues cleanup and WARN traversal by device lock there
to avoid the concurrent access problems.
Move WARN traversal before mei_dev_bus_put(bus).

This file uses bus variable name for mei_device, adjust
code of mei_cl_bus_dev_release() to use bus variable too.

Cc: stable <stable@kernel.org>
Fixes: 35e8a426b16a ("mei: bus: Check for still connected devices in mei_cl_bus_dev_release()")
Reviewed-by: Menachem Adin <menachem.adin@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Link: https://patch.msgid.link/20260705151259.3054795-1-alexander.usyskin@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/mei/bus.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index 19bc1e9eeb7f0..1997ecd4ed4ff 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -4,6 +4,7 @@
  * Intel Management Engine Interface (Intel MEI) Linux driver
  */
 
+#include <linux/cleanup.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
@@ -1113,18 +1114,19 @@ static void mei_dev_bus_put(struct mei_device *bus)
 static void mei_cl_bus_dev_release(struct device *dev)
 {
 	struct mei_cl_device *cldev = to_mei_cl_device(dev);
-	struct mei_device *mdev = cldev->cl->dev;
+	struct mei_device *bus = cldev->bus;
 	struct mei_cl *cl;
 
 	if (!cldev)
 		return;
 
-	mei_cl_flush_queues(cldev->cl, NULL);
-	mei_me_cl_put(cldev->me_cl);
-	mei_dev_bus_put(cldev->bus);
-
-	list_for_each_entry(cl, &mdev->file_list, link)
-		WARN_ON(cl == cldev->cl);
+	scoped_guard(mutex, &bus->device_lock) {
+		mei_cl_flush_queues(cldev->cl, NULL);
+		mei_me_cl_put(cldev->me_cl);
+		list_for_each_entry(cl, &bus->file_list, link)
+			WARN_ON(cl == cldev->cl);
+	}
+	mei_dev_bus_put(bus);
 
 	kfree(cldev->cl);
 	kfree(cldev);
-- 
2.53.0

