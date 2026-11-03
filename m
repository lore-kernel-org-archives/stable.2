Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717947;
	b=Gy6iHZzlYWJ79SzzmiYkXy6VANEOsoJ6xz+Emn5m3VyfqIEuKwtigzqcwC/mkrK0QioK
	 H75RjVfcZQmWB/W5tL5OrHK51u5meUtzSpuvZ2gfSS2zn1OK//qRTfbnj3pn5l3uQ4m9M
	 LcyKugbkXM0gq6D4hRcuLT84B/v4CA9NAzax12bWvhe25BSYmsYrJNF/eFByzVt+L1nX7
	 MqqZwA7Fy9dPEEgmdvyiiH6jJOaa3YqEk+9PbK1ALjJurh3zBUZbDbNAITRUMBbUkt1FP
	 MEdjVJdt9xHns2+OiO8hHhPkyyi/3MTz52PbHRmRQo2fTwGp+OVGAPn5ChpXZ50Xcqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717947;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CE4CYyvf2CZ5fmLifR82GF8XhbsCXKVvE7qvmtdKOzE=;
	b=h8fiCKvm8QoaW+oxLlfGlG8mXlHGtIst9eL+Lt40C106cu5yqdsNjh4zsVNL7GUOWgLb
	 KHhEd727JBQQHfWwUUYKXyhtnHCsMbxtEi4Tn78yrnAje3BZfbjiX8AH0aQeCr8ELr0G4
	 iJnQ5AdZHW3F/g91mp0z4rJ5STl7Sk3NzWoWjqbaVGQMPY+diGlSNM6lyDgy+KhYa4z0K
	 Mj0WMnPGILUPYl7CZUq5CWFuBHbJtryIQw7vhVGv4UI2As5HNuMRJihvwl2rzURsVFiRq
	 AP6YItCoFQOWE2hT0Z7wO6o/oqxPxrjXMtWihKorgzT4xbJZnigAwfFVn+nMVd88XbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H2vmH3AM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C19606D825
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H2vmH3AM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26231F000C1;
	Tue,  3 Nov 2026 14:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717947;
	bh=CE4CYyvf2CZ5fmLifR82GF8XhbsCXKVvE7qvmtdKOzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H2vmH3AMnKpofXWDCsuj1oOLy29fgXuWJM/vxD4TAMvKSaSx1iylLYQkqihMj3pbN
	 dQOv26jX9gEbozQZlBHalb9ts7pbTqHaSNUKTXC/8JEmLRXhzsreffT2JMyTQsr/Sc
	 KAkmTRVmSVgdAY2fmMDQDgKSTebUa10P1dJKbz4tM9KrtilcL+1dEIo+07t6W5sRKl
	 GJjDJzDExR5NRE6syMwo7/SmrXJebaRrsRTZ2Trr/Zr+gHdAMKS59f1/oEkvYhHoOd
	 YBcEijve/fWKGSYYMdIU59WkGK6hOE74TbwxNVgApZ4SF2hhh96Van+tGZvqGOfZpU
	 1FLe8HGC2IZsw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vincent Liu <vincent.liu@nutanix.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] driver core: Check drivers_autoprobe for all added devices
Date: Tue,  3 Nov 2026 09:59:04 -0500
Message-ID: <20261103145825.4109075-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110313-outburst-clinking-4199@gregkh>
References: <2026110313-outburst-clinking-4199@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vincent Liu <vincent.liu@nutanix.com>

[ Upstream commit ea34511aaf755349999a1067b2984a541bee1492 ]

When a device is hot-plugged, the drivers_autoprobe sysfs attribute is
not checked (at least for PCI devices). This means that
drivers_autoprobe is not working as intended, e.g. hot-plugged PCI
devices will still be autoprobed and bound to drivers even with
drivers_autoprobe disabled.

The problem likely started when device_add() was removed from
pci_bus_add_device() in commit 4f535093cf8f ("PCI: Put pci_dev in device
tree as early as possible") which means that the check for
drivers_autoprobe which used to happen in bus_probe_device() is no
longer present (previously bus_add_device() calls bus_probe_device()).
Conveniently, in commit 91703041697c ("PCI: Allow built-in drivers to
use async initial probing") device_attach() was replaced with
device_initial_probe() which faciliates this change to push the check
for drivers_autoprobe into device_initial_probe().

Make sure all devices check drivers_autoprobe by pushing the
drivers_autoprobe check into device_initial_probe(). This will only
affect devices on the PCI bus for now as device_initial_probe() is only
called by pci_bus_add_device() and bus_probe_device(), but
bus_probe_device() already checks for autoprobe, so callers of
bus_probe_device() should not observe changes on autoprobing.
Note also that pushing this check into device_initial_probe() rather
than device_attach() makes it only affect automatic probing of
drivers (e.g. when a device is hot-plugged), userspace can still choose
to manually bind a driver by writing to drivers_probe sysfs attribute,
even with autoprobe disabled.

Any future callers of device_initial_probe() will respect the
drivers_autoprobe sysfs attribute, which is the intended purpose of
drivers_autoprobe.

Signed-off-by: Vincent Liu <vincent.liu@nutanix.com>
Link: https://patch.msgid.link/20251022120740.2476482-1-vincent.liu@nutanix.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Adapt the bus-side change to __bus_probe_device(), which is shared by
the normal and deferred probe entry points. Preserve the deferred probe
wrapper and its parent locking.

Retain this change to provide the device_initial_probe() layout needed
by the asynchronous attach parent-lock fix. PCI still calls
device_attach() directly, so this change does not alter PCI probing.

Stable-dep-of: 187a62f99da2 ("driver core: take parent lock in async device attach")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/bus.c |  3 +--
 drivers/base/dd.c  | 10 +++++++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index e0afc8e371438..36383037f2dd2 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -570,8 +570,7 @@ static void __bus_probe_device(struct device *dev)
 	if (!sp)
 		return;
 
-	if (sp->drivers_autoprobe)
-		device_initial_probe(dev);
+	device_initial_probe(dev);
 
 	mutex_lock(&sp->mutex);
 	list_for_each_entry(sif, &sp->interfaces, node)
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 9d1e231d41f53..57aa8d8b00428 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1155,7 +1155,15 @@ EXPORT_SYMBOL_GPL(device_attach);
 
 void device_initial_probe(struct device *dev)
 {
-	__device_attach(dev, true);
+	struct subsys_private *sp = bus_to_subsys(dev->bus);
+
+	if (!sp)
+		return;
+
+	if (sp->drivers_autoprobe)
+		__device_attach(dev, true);
+
+	subsys_put(sp);
 }
 
 /*
-- 
2.53.0

