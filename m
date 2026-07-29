Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D238470E88
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785331925; cv=none; b=hO2O/TNBcLJjY4Xy7oIh2HmOW/X3yoI6oFSwJlwQL7pL0scmfpg2M/zcM6RlzvMX/qYBA6UOHi8zo1sLcNsPDa6VkajelVu4fmSllOCxTpU3TGfrLT7ANCYlLONe/fTe3LYklAVjh/MerL7ImAwjeSyok/ocZl10S6/Xu4UEfp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785331925; c=relaxed/simple;
	bh=RIcgqFJDhDk7r1QKc825YMqoWo4XkgsxSHCWMs+Vkrs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QArpSZ5rPZ/aTwf3zPvN4aQFrHqA7cT7SziNt/LNnfT7TwJpxzaa2wkaYMcvKrV/CeeZmul2WHzVjced4KRp8CsRIDk0vHbBM/3dcjdCC7eRfcRINJjdwF3jPbd4YgEAjSzE5NSA7ujIeGmcyU9SPiatXIrUdRHmpaPEU1ECQsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xX3+UC8L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xX3+UC8L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315A91F00A3A;
	Wed, 29 Jul 2026 13:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785331916;
	bh=TNB5Q/tgPWJWP0VbYSPdv1s2g9YY1TIPZp04haBEf0c=;
	h=Subject:To:Cc:From:Date;
	b=xX3+UC8LjlfTm5HJ4ag0gqXp+5ZT9mh0OBU6yyO4QqiknfZSMCH+NTBQCMZSJZKN3
	 dNPr+4eBAT7G+ztPp8Iyp0wIEr+wIsoxso8ivjlkKl7c80sbdh6niOzqhB8uDHeflm
	 Gj/7C1yha9faEN8FRJ2Ak7TO88XynbPUJvC4eyBA=
Subject: FAILED: patch "[PATCH] mei: bus: access mei_device under device_lock on cleanup" failed to apply to 6.1-stable tree
To: alexander.usyskin@intel.com,gregkh@linuxfoundation.org,menachem.adin@intel.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:31:43 +0200
Message-ID: <2026072943-hamlet-onion-0655@gregkh>
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
git cherry-pick -x f112ea910e554d58b4b39a4492b7d302f0f4204f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072943-hamlet-onion-0655@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f112ea910e554d58b4b39a4492b7d302f0f4204f Mon Sep 17 00:00:00 2001
From: Alexander Usyskin <alexander.usyskin@intel.com>
Date: Sun, 5 Jul 2026 18:12:59 +0300
Subject: [PATCH] mei: bus: access mei_device under device_lock on cleanup

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

diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index fcde082eb5e3..cfb87ab8667f 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -4,6 +4,7 @@
  * Intel Management Engine Interface (Intel MEI) Linux driver
  */
 
+#include <linux/cleanup.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
@@ -1330,15 +1331,16 @@ static void mei_dev_bus_put(struct mei_device *bus)
 static void mei_cl_bus_dev_release(struct device *dev)
 {
 	struct mei_cl_device *cldev = to_mei_cl_device(dev);
-	struct mei_device *mdev = cldev->cl->dev;
+	struct mei_device *bus = cldev->bus;
 	struct mei_cl *cl;
 
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

