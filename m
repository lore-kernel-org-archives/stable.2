Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793713401;
	b=w8MwkIXcpeh38eChCt4xZ1s8JwcXEU1TDBzJZr85brHH0NK9YoXowuLqckywsseJiPFO
	 s4RGlqWq7nSXPDPsMQOS8mSY5jFcSm8xVSvRjbyM4g0pDt42tXNSue5O9Brw1/DedPnie
	 JZJT+RSIfJMTcanDpP8zn6SdJzuWYJsvacm4/BDPMRoG9v0yYSIjYk4Zmm7idMuv03cGD
	 zMFZG0wT6RBmK09bXnfrfFBFiM/Xh7a8pQ6dqHrt2T9PkRLbm9vsXG5vwpLXAPcciRrv7
	 359t5a5+MPG91XmjP7nKCtP2uip5cO1bM1eOdG3d/xZgK0Bf8CBAuhPxL/Ypkyg8yvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793713401;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8rjMcf9wWac8oxA6YarSg0AzRw8cI1xU140HJMDAg1c=;
	b=v2MF2TnvvNSqM+5Q6DuAtKBm1jxOa2s5pqjzP7eDCGwG5rAGvtHo9kSJMJ/reOQHyAGD
	 HhymDXLmosGPipjXo6yPgtI7ygD4qbiR2Bo3PWgnaDmyHu1zD85YaFZNl4TmkBPIIKvZC
	 mz89gaf18Ojl+J7xzQd6HTs9Wvu/IZ3EysxJ2A9MwnpsICKBusClGeX43O/70RZ0eYIRG
	 34b65LJt/CmIFRLzdY1DTepUVkoELfQGNEDJ1wGv1n2XGrYwnzpBolRLdUANfWtUqKIPB
	 mDKeSDBt5CpVzDttZBKUJTa1wUIwzMnTDiUCEMlZy1YNYSUudDErQMqrga55YwWsKMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eTZNCbJD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E1A606D816
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 13:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eTZNCbJD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7F61F00A18;
	Tue,  3 Nov 2026 13:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793713400;
	bh=8rjMcf9wWac8oxA6YarSg0AzRw8cI1xU140HJMDAg1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eTZNCbJD/FGdwdViwWWF+8xQE817XOqp1mwAHIEiGiq/qSLMNJeRcXbN/ovZsrxlp
	 7F5gTbORUCC8zBUpudF+uVBOGZby3RS6x/ivdDm6xCWURqhlRI3RyJB3QOTFESAw7b
	 fKnHFw1jqUUWoQNYLnh6kqik4+2TkCVDwb7Rf7KVh01DqbF1onzljpJ+q+spywVaU9
	 lfW4ZQ0bsYkC5HJmQ0UTg7qXYkOtdqVZXRHYSos/pXH4OVWRdN71sa5Viq8hZEYOXP
	 rT5J8ll3rK1Xudd/+fZJ0inkqBn4b74MF1+r/b51z72djF8Ha/7Re67jY1IynQnbk3
	 ChMQ02qVg2Yyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vincent Liu <vincent.liu@nutanix.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] driver core: Check drivers_autoprobe for all added devices
Date: Tue,  3 Nov 2026 08:43:17 -0500
Message-ID: <20261103134302.3982320-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110312-lint-gizmo-6095@gregkh>
References: <2026110312-lint-gizmo-6095@gregkh>
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
Stable-dep-of: 187a62f99da2 ("driver core: take parent lock in async device attach")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/bus.c |  3 +--
 drivers/base/dd.c  | 10 +++++++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 5e73e0bdb1127..069e1aa991e68 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -573,8 +573,7 @@ static void __bus_probe_device(struct device *dev)
 	if (!sp)
 		return;
 
-	if (sp->drivers_autoprobe)
-		device_initial_probe(dev);
+	device_initial_probe(dev);
 
 	mutex_lock(&sp->mutex);
 	list_for_each_entry(sif, &sp->interfaces, node)
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 6ae212614e544..707d65396f2e0 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1157,7 +1157,15 @@ EXPORT_SYMBOL_GPL(device_attach);
 
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

