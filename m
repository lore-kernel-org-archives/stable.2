Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA1F3C1D66;
	Tue, 13 Oct 2026 14:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900408; cv=none; b=J3RcLtE6L05SJgUVH2FagI82pzYSxFMvw38GOv8/hBZ4WcB8Dv61FsowxOEV1F5VqtilNbPLbA/59QQ4E0vfydau9D+yiPXmC+1WhlU7dDoh6jfAoS62+9f2HlTiZpzb3WRQUpke44rxunq5zUfdB1TkWB7dYsa0RkuodIbmpj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900408; c=relaxed/simple;
	bh=qBM0oFJyiP5nGCBoW1aU1ZOtHYPwrvo1e/jOSOMCWDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SxDE6+7QzwqY7tp9NKzWGyaK/HV6+1R6yKDo4yaZX2vNozyBS1MzH0jMCm1pIx/swK3lSCxLeavs/BlTJ21pHdTuFURboJDo/WTAbNTkJZ6CHBUVvWslGyUuW13qL3M7mpn//O7QjUQ0hdrtkhhPwTuLnXottwj/zR/KKNgueuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiLs+rR0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiLs+rR0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8335B1F000FF;
	Tue, 13 Oct 2026 14:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791900406;
	bh=noQ+gtaIeSfcBbf4IVs7251oKyPHxgZa73oom00Xu90=;
	h=From:To:Cc:Subject:Date;
	b=HiLs+rR0/BU9LaVyfSNKyQlc22NVHi9JbrV1sUZgBhxd7aIy9ee7hKX2iWAt4I3Ma
	 5Nj12dmK8i0N5XNfbLZ+/r5D3N/+jaHm2RoU0OLOpJ3ceA/QLAgS2bPpfd+yEwJP++
	 DPRFXwDbJQSleg1sRhzazw7hl39RTzlaCmN1LGFWcx0WSs8pjQ8bYaimrZp8RpM7h6
	 aFqWt3/TM19zLSSz1/Gaf3+kN2UdCU3Ow5t9hUCsoJGaogqj/U3PGxW/wKxweHMiOk
	 GgjCJfN6bPqGzSxT3TD1ClDHqwFVb4hthzlRtlZusdNDEvavjDGbRQ5twSsxP+23kI
	 P1bzV9lOy124Q==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xGd9Q-000000059Ct-1yfW;
	Tue, 13 Oct 2026 16:06:44 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	driver-core@lists.linux.dev,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mario Peter <mario.peter@leica-geosystems.com>,
	stable@vger.kernel.org
Subject: [PATCH] driver core: take parent lock on deferred probe
Date: Tue, 13 Oct 2026 16:06:15 +0200
Message-ID: <20261013140615.1226992-1-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

USB interfaces should be probed with the parent USB device lock held,
but this is not honoured when probe is deferred.

Add a new bus_probe_device_deferred() helper to handle deferred probe
where the parent device lock is not held.

Fixes: d1c3414c2a9d ("drivercore: Add driver probe deferral mechanism")
Reported-by: Mario Peter <mario.peter@leica-geosystems.com>
Link: https://lore.kernel.org/20261007131514.1260696-1-mario.peter@leica-geosystems.com
Cc: stable@vger.kernel.org	# 3.4
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/base/base.h |  1 +
 drivers/base/bus.c  | 28 +++++++++++++++++++++-------
 drivers/base/dd.c   |  7 ++++---
 3 files changed, 26 insertions(+), 10 deletions(-)

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
index c51ad96d4de4..fd62594eb6f9 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -606,13 +606,7 @@ int bus_add_device(struct device *dev)
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
@@ -630,6 +624,26 @@ void bus_probe_device(struct device *dev)
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
+	if (dev->parent && dev->bus->need_parent_lock)
+		device_lock(dev->parent);
+	__bus_probe_device(dev);
+	if (dev->parent && dev->bus->need_parent_lock)
+		device_unlock(dev->parent);
+}
+
 /**
  * bus_remove_device - remove device from bus
  * @dev: device to be removed
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 9dc7cce9bd8d..87962f4e914c 100644
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
-- 
2.55.0

