Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700710;
	b=aY5xWZa9bt9IvjgMlgWSZ0uwNpY1G+lv/orjNyjf+SQpbMvhduKttIMHX5WkNL02O3nF
	 oCbHT+NfwCdtS1nWw2ICXkr3FDblGTrcKKYoId1CoHLnDB9NEnxV5f3+cqkzxSZgIAB2L
	 qj3x/86DYzkKdsqyNKVvVSSqL8ud/2nFwTYHKPEucUknfHlOgvM2MX0jW1AiHcjmPy+5x
	 YiEtK72BE2m1s85EviLyhZ1ra1jN7H+IAHHuKSVcJN3Z7sMrItjoUttj9L8dy9HFu6uw6
	 nXzRzKZdjAurCUmLNYiYMtVaCm8I03KdhboCFnfNCCS9WrFi9Q7Ga/DlRbOEsFwE7iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700710;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qDgYHdnp0IrsiryvbRed5LaI/ewTpxVGx0c/skmlZSo=;
	b=ErUgLDoHAldGQwcFKVF3PB0HAMIX6MFWuqcogmV5WYe+SvSL0B2FCA6YKMsWI0EIQSCC
	 GeiganLVkgh9JGLXDnOOs/O5GwmhWKsyD2Xw4CXbCvtotiZ9vu4qXRQvYV3mq07iP9zyK
	 k+kYbRzVqO/jrp2J1uH2Rc80VJ16yjUQbTCAPhiuRkx7nNV+x+LdckItPIXXnEouWhfcI
	 8AzgsmgfwwAoYRu105LE+zyUfrEdfd+WcTJVO0u/2GAI9aNv9BdQILEHB7gMwLNWiiewF
	 uGSiI6SXV/+6IJ0LBM8uzMYKoOkpE/BVHdsepV/VdIg5O+yXXU7WiAtHsB62v+1eKIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=0Q1QLLZW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11459606A32F
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=0Q1QLLZW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61FA91F00919;
	Tue,  3 Nov 2026 10:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793700709;
	bh=qDgYHdnp0IrsiryvbRed5LaI/ewTpxVGx0c/skmlZSo=;
	h=Subject:To:Cc:From:Date;
	b=0Q1QLLZWB8mRHwm3tFuz/i+cXiwqKjL3X/B8044B9Lkbhfu7Usy+gtMx/6ovVZgW6
	 470dJ/ISR4YEA2H0PVCgax1OVz36H0SAutQfkz8T5+Kx5F7s0eW+WuTFIk1760K3ff
	 uzTgQ3JPaMVIn8V+gTxEst7fdeugW9uRttwauORM=
Subject: FAILED: patch "[PATCH] driver core: take parent lock on deferred probe" failed to apply to 5.10-stable tree
To: johan@kernel.org,dakr@kernel.org,mario.peter@leica-geosystems.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Nov 2026 11:11:40 +0100
Message-ID: <2026110340-parcel-swear-8531@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 4059f8986c8f50102a04335cc1da4921dfd262d8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110340-parcel-swear-8531@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

