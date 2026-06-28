Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6163B2FF7;
	Sun, 28 Jun 2026 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782658523; cv=none; b=dQOEH8cgoJet6cyquhh23npkEWTh2typ3MGTKscXJM4oEgkeNMEMZ7yil2/gaklORaPpexd08ZMBFG2+8FAJ0fKgg7bAl6BJYwua+te3qNcXHPxU8Tzql7F8iR97GLdjoh3XHamdN5xXUvER2/NRppHmWnbTCDXXkFu9HHg5EMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782658523; c=relaxed/simple;
	bh=xpCmf38i1pBhocoiA/RjuZiHG5Vq4rHQ+04hm0s8gMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ao1iVl4fgjwT3b00QbxWDDCTQ3cfQzF67YlKweO0ad7JGtdQxH2vcjFUJxahkkLMfDrW0cIQuOQnAVJYRFT9mccR9nhGbepZnqJ3yOh2ZVjLVWp9MhCZrwAs70LV8ej5/jFenyxHWRZSSdPWxHsWMHCIpFBf2XvuZOlLLhXCMyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJfRY9o5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJfRY9o5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A69D1F00A3A;
	Sun, 28 Jun 2026 14:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782658522;
	bh=pK3wmBFyvbIR4po+L1VPow88KO+kJdxcXPWuOXcUG7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kJfRY9o5wU2Z6uYCKD+Qn/003m+rkRzr8vIijbk1ooMgkVZovQ/LJ6sztnGUPZsVS
	 umRCGXauMKUTc3LghmNRpbGIzuDYw5aX85bEomiW678ZrAAJqABddf9DoWp3WR3Dbn
	 B2d9hLbr3TZHX0zFXK5O1/EwBziS65Gw9JJvpZlSArjFUpKTcG7U8T8alHQ4XYYKqB
	 u4gJdsuG/w+UC4HBhgKAad18hFyMa0EhoerDDmYb9OWFCnwHUfpucyv2B8LkN2T/wY
	 uIMS3Ercu2YEVrPghhVCXwI5xYaDWt3QHtG47VcadZRMKy8lO95Ag1W7xSJXCIpx/z
	 iMfwQbOpMK0AQ==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org,
	aliceryhl@google.com,
	daniel.almeida@collabora.com,
	acourbot@nvidia.com,
	ecourtney@nvidia.com,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	deborah.brouwer@collabora.com,
	boris.brezillon@collabora.com,
	lyude@redhat.com
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: [PATCH v5 16/19] drm: fix race between partial drm_dev_register() failure and ioctl
Date: Sun, 28 Jun 2026 16:53:36 +0200
Message-ID: <20260628145406.2107056-17-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260628145406.2107056-1-dakr@kernel.org>
References: <20260628145406.2107056-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If drm_dev_register() fails after registering a minor (e.g. render minor
registered, primary minor fails), userspace could have opened the first
minor and entered a drm_dev_enter() critical section. Since the
unplugged flag was never set, the ioctl proceeds while the error path
tears down device resources.

Fix this by introducing drm_dev_synchronize_unplug(), which sets the
unplugged flag and waits for the SRCU barrier, ensuring all in-flight
drm_dev_enter() critical sections complete before cleanup proceeds; call
it on the error path of drm_dev_register().

Fixes: bee330f3d672 ("drm: Use srcu to protect drm_device.unplugged")
Cc: stable@vger.kernel.org
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260620190648.2E9F61F000E9@smtp.kernel.org/
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/drm/drm_drv.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 675675480da4..e890052061f3 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -473,6 +473,22 @@ void drm_dev_exit(int idx)
 }
 EXPORT_SYMBOL(drm_dev_exit);
 
+/*
+ * Mark the device as unplugged and wait for any in-flight drm_dev_enter()
+ * critical sections to complete.
+ */
+static void drm_dev_synchronize_unplug(struct drm_device *dev)
+{
+	/*
+	 * After synchronizing any critical read section is guaranteed to see
+	 * the new value of ->unplugged, and any critical section which might
+	 * still have seen the old value of ->unplugged is guaranteed to have
+	 * finished.
+	 */
+	dev->unplugged = true;
+	synchronize_srcu(&drm_unplug_srcu);
+}
+
 /**
  * drm_dev_unplug - unplug a DRM device
  * @dev: DRM device
@@ -485,15 +501,7 @@ EXPORT_SYMBOL(drm_dev_exit);
  */
 void drm_dev_unplug(struct drm_device *dev)
 {
-	/*
-	 * After synchronizing any critical read section is guaranteed to see
-	 * the new value of ->unplugged, and any critical section which might
-	 * still have seen the old value of ->unplugged is guaranteed to have
-	 * finished.
-	 */
-	dev->unplugged = true;
-	synchronize_srcu(&drm_unplug_srcu);
-
+	drm_dev_synchronize_unplug(dev);
 	drm_dev_unregister(dev);
 
 	/* Clear all CPU mappings pointing to this device */
@@ -1091,6 +1099,7 @@ int drm_dev_register(struct drm_device *dev, unsigned long flags)
 		goto err_minors;
 
 	dev->registered = true;
+	dev->unplugged = false;
 
 	if (driver->load) {
 		ret = driver->load(dev, flags);
@@ -1118,6 +1127,13 @@ int drm_dev_register(struct drm_device *dev, unsigned long flags)
 	if (dev->driver->unload)
 		dev->driver->unload(dev);
 err_minors:
+	/*
+	 * If a minor was registered before the failure, userspace could have
+	 * opened it and entered a drm_dev_enter() critical section. Ensure all
+	 * such sections complete before we clean up.
+	 */
+	drm_dev_synchronize_unplug(dev);
+
 	remove_compat_control_link(dev);
 	drm_minor_unregister(dev, DRM_MINOR_ACCEL);
 	drm_minor_unregister(dev, DRM_MINOR_PRIMARY);
-- 
2.54.0

