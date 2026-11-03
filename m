Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700711;
	b=xi3u9uIUvmRFT6uTWzEY+cUU5jBYNcVU2fLy2nOrz/t9qgXaVeBqTeX8DHhZqmXzPHZz
	 l0DTiiVuaDO0nBGpahMub+XAD0Ao8aN25JzgY0n0OdE76qM77gtsuY70yJ6vsoU4ugD//
	 YZzUvJpzaWLSqj+Fv3l84gtk5uxNUwXjD5AnBfgDdLu32bcRjh22N1Tmvn2/zP26uLBYf
	 6HZasKotoNfwqJ0gDHotbJg6HafpbdvjvjOxE9Z6cEYCeXiz0sO4MrSbeZm1KZkM3f5Db
	 0OiIiRfzdm1M6ldjlJy1ZsBt5Mt70ExGyfwfrGaADIGt3dW1NTVOWEP4Cj03nIBv9GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700711;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=MhpsWMnnoQm+8wujGogAKt+apipafqlmB2u8FwBsPZk=;
	b=vOxC64ZtKaqVQc3N8BBYThlbrXZvhgrebDgRtKRwJBqELcpLqin2nvS2S01XI1fL3dMj
	 Jdd1w+R6yepDG5+BASmSpkreFJfCRVXhruN6Bh9Ptk97Ulpk+vcEy6u5cdT4JgrKS7PgP
	 R0HyuEPFoK96Omd8C3KYehHvwyzQuN0XmF2nlRqa59OSyuFF7SsyLN/8xHDBndXKJ5MsX
	 Cz/xljnM/P8AlGamqg5XX6cZO5c3UIEg2gKHglDWeSiUIcA4HOs9yX7ZYVZAjIZNZUvGM
	 RZ3z0Jvi2orYYwH7+2F98kOHYAhH9u6o/TumYcuepVPnndA0xrBWPsQ0PMPdWk8Aa9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=c4Rkyp4Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CC6606A32F
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=c4Rkyp4Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059FD1F00A02;
	Tue,  3 Nov 2026 10:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793700711;
	bh=MhpsWMnnoQm+8wujGogAKt+apipafqlmB2u8FwBsPZk=;
	h=Subject:To:Cc:From:Date;
	b=c4Rkyp4QklEySnAF6NWuMbltptnk+w2Ok09NOvcZsFBxypdKU7QbM457/m73Keaqa
	 05Pm4ysjm9XnlRUIedf37CXMIYTuDWkDIuw8MupKZoxmA/3JoAKy4JFihDF0UKpru4
	 1/n1cHuwGOivRayA22a6TZf8iw1gR+AZnade97wE=
Subject: FAILED: patch "[PATCH] driver core: take parent lock on deferred probe" failed to apply to 5.15-stable tree
To: johan@kernel.org,dakr@kernel.org,mario.peter@leica-geosystems.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Nov 2026 11:11:40 +0100
Message-ID: <2026110340-circus-eggnog-92d2@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 4059f8986c8f50102a04335cc1da4921dfd262d8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110340-circus-eggnog-92d2@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4059f8986c8f50102a04335cc1da4921dfd262d8 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Wed, 14 Oct 2026 15:31:08 +0200
Subject: [PATCH] driver core: take parent lock on deferred probe

USB interfaces should be probed with the parent USB device lock held,
but this is not honoured when probe is deferred.

Add a new bus_probe_device_deferred() helper to handle deferred probe
where the parent device lock is not held.

Fixes: d1c3414c2a9d ("drivercore: Add driver probe deferral mechanism")
Reported-by: Mario Peter <mario.peter@leica-geosystems.com>
Link: https://lore.kernel.org/20261007131514.1260696-1-mario.peter@leica-geosystems.com
Cc: stable@vger.kernel.org	# 3.4
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20261014133109.1392265-3-johan@kernel.org
Signed-off-by: Danilo Krummrich <dakr@kernel.org>

diff --git a/drivers/base/base.h b/drivers/base/base.h
index a5b7abc10ff0..3c36a2128f88 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -154,6 +154,7 @@ struct kobject *virtual_device_parent(void);
 
 int bus_add_device(struct device *dev);
 void bus_probe_device(struct device *dev);
+void bus_probe_device_deferred(struct device *dev);
 void bus_remove_device(struct device *dev);
 void bus_notify(struct device *dev, enum bus_notifier_event value);
 bool bus_is_registered(const struct bus_type *bus);
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index d6668fb8ddea..43d131fd8085 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -603,13 +603,7 @@ int bus_add_device(struct device *dev)
 	return error;
 }
 
-/**
- * bus_probe_device - probe drivers for a new device
- * @dev: device to probe
- *
- * - Automatically probe for a driver if the bus allows it.
- */
-void bus_probe_device(struct device *dev)
+static void __bus_probe_device(struct device *dev)
 {
 	struct subsys_private *sp = bus_to_subsys(dev->bus);
 	struct subsys_interface *sif;
@@ -627,6 +621,26 @@ void bus_probe_device(struct device *dev)
 	subsys_put(sp);
 }
 
+/**
+ * bus_probe_device - probe drivers for a new device
+ * @dev: device to probe
+ *
+ * - Automatically probe for a driver if the bus allows it.
+ */
+void bus_probe_device(struct device *dev)
+{
+	__bus_probe_device(dev);
+}
+
+void bus_probe_device_deferred(struct device *dev)
+{
+	if (dev->type && dev->type->need_parent_lock)
+		device_lock(dev->parent);
+	__bus_probe_device(dev);
+	if (dev->type && dev->type->need_parent_lock)
+		device_unlock(dev->parent);
+}
+
 /**
  * bus_remove_device - remove device from bus
  * @dev: device to be removed
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index d7a82c436c45..04e9977ed743 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -86,8 +86,9 @@ static void deferred_probe_work_func(struct work_struct *work)
 	/*
 	 * This block processes every device in the deferred 'active' list.
 	 * Each device is removed from the active list and passed to
-	 * bus_probe_device() to re-attempt the probe.  The loop continues
-	 * until every device in the active list is removed and retried.
+	 * bus_probe_device_deferred() to re-attempt the probe.  The loop
+	 * continues until every device in the active list is removed and
+	 * retried.
 	 *
 	 * Note: Once the device is removed from the list and the mutex is
 	 * released, it is possible for the device get freed by another thread
@@ -121,7 +122,7 @@ static void deferred_probe_work_func(struct work_struct *work)
 		device_pm_move_to_tail(dev);
 
 		dev_dbg(dev, "Retrying from deferred list\n");
-		bus_probe_device(dev);
+		bus_probe_device_deferred(dev);
 		mutex_lock(&deferred_probe_mutex);
 
 		put_device(dev);

