Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719002;
	b=LtrugYMrIPRN2VKZspavsgFvaFSKU0PmA38fxRNfSc5eDnhiF/8jxuxQScmVd3ARb6vd
	 vruS9pNBE1/92FmHjmkuPtvn62SvFhJEmoGu6Iq/A52BcJEQaOV8OV8QoP4lEQT+U/T69
	 UZ9SIxLWfqLDFR/Da6p9O4POUGRnTTIfqWR5+Y5uZCm++2BZ1/P69ENU8VMNHLwjaLS5j
	 D48RA++DyghlAb0Po9J9Hc4QZH/c0xRoNx8IqbbRJCF4c4ltmzuAzehWl37/gD1PIstGW
	 qa6iXXowWaFkis6Ub1czz7x6NxS7B6G1BAos3jrRQMLBeDHwUTtP8rM1rojj9bhzoug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719002;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=au4AmZUdRYKTQ4LOi/XLGJLc3knMwhjDuZWYgFZcylg=;
	b=qVKLrFlL8cHm8mNl2906YmSSIANc9qkBTx0MPwO5BPo3viMnTqmuj/95J9pT6xHpRILb
	 g6naAgxcTdV4bdeGzJCZ2b/k/WXcUlSMm05jIP+v/9XQi7Krdlg4FwpwnMeZFG92Ods3Q
	 SCekNkFbEy4zpQgSE3FjikI73Ur887TlZBi+/4RF3T0RcvE5JVeYpcYoZlai1D4AwTCcz
	 xak8ALqoT8DT1shlVgXWVuOnXEyufCcKJ79xXqTLE8QteCp9hZv9FW0hsL2c0vVnSf2yT
	 kTLebhzSX0mGyz8gbkrtTM97rYMEs6znuZrDprbi5CNyEpKuCfA7/WUPPISrGzxiFDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kl8sXmOD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E51606A78E
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 15:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kl8sXmOD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E564A1F000C1;
	Tue,  3 Nov 2026 15:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793719002;
	bh=au4AmZUdRYKTQ4LOi/XLGJLc3knMwhjDuZWYgFZcylg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kl8sXmODK6cNwDytNTf+SJXBATcjjqxDQN839WF0T/MiirYSNyd5fs69PEq+lE7Pb
	 UXL+KFg2agfF1rTkfOjwF+2oz4U8hmK3HkJuWxkArGELqW1av+LRbFyUHSQTiWXWk0
	 2vSMdHkBlPIfPRTFU2dLjVmGqX4dUVVuQ18V+uaGoHfhpUcoPPvalU/pmOS6CSa2ww
	 WofLp5w/sJiQdPkbpgs8L3xmKXF8S7Ac9deKz77H+BsmDeoXHGbsG0zzyhDwEZaINQ
	 UDu5zrPUQsUsBv+n+chDXYkcdTtSWYko33ZD5nmuYcQMSPrUPSwfOv/AyU8dqF8pdr
	 k3smioYPvI+BA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vincent Liu <vincent.liu@nutanix.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] driver core: Check drivers_autoprobe for all added devices
Date: Tue,  3 Nov 2026 10:16:39 -0500
Message-ID: <20261103151630.247511-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110314-chloride-agony-d0f9@gregkh>
References: <2026110314-chloride-agony-d0f9@gregkh>
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

Apply the bus-side change to the existing shared probe helper, preserving
the deferred-probe parent locking. PCI still calls device_attach(), so
its probe behaviour is unchanged. Retain this change to prepare
device_initial_probe() for the async-attach retry handling.

Stable-dep-of: 187a62f99da2 ("driver core: take parent lock in async device attach")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/bus.c |  3 +--
 drivers/base/dd.c  | 10 +++++++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 65c138dc9b3fb..dccfbc5f389bb 100644
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
index c6ba7402bd514..4accc885a9d44 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1156,7 +1156,15 @@ EXPORT_SYMBOL_GPL(device_attach);
 
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

