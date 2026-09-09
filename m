Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9A053D0AB;
	Wed,  9 Sep 2026 11:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952405; cv=none; b=NluFHCBxS/Nl61TmFT+fY87ZZdExqASIo0CVrGWyuzjj4WBFyyWzX9jQK/0S3/FrtMfWhdI4pqxpWjZAPUGmWYvgmrzsa+1Mf2LQoMP+71jQ+6J45pvmjdJcZOspaRp2O4qmdceioyiBUKZHAcO3q0ujCo/2WGZ8GDDykpKRZW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952405; c=relaxed/simple;
	bh=fjJSr/y0LyN10hQSd8ss9RqHrX/3ULie5c5xU59P+zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ee7+rf3hGyOWmhoM8qBoYOVS1ExU8UD0/7/zaULIDtsyJ7dwKzQs7VI49Yzx03qGZc9CfmPRrBPIv2NzxotZVVtuVFRg3JmznGDn5x55btOIyqBp7OS5GrcM71stGD+lIqxmZBddmqmgsnFikPGCdamkKGkKpJNaCnl2XfL6Fxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cu3LIr14; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cu3LIr14"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DFC01F00A3E;
	Wed,  9 Sep 2026 11:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788952401;
	bh=BnEwMumo39BwnH7wYSj+UllcOvjFJBabZV3HDL+BlBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cu3LIr140NtIntjJDFe2pPEOJOA2XiXq1kU5kgQrelh2Dc1lofFMGOE54DOKBm/2i
	 30YcpgZpO5thsr4/3dmBBKg9LC9pxTmhfoQTA/ZjTnD9HYwmbJUCb9aG+22NSylDd9
	 QWNkVUGSGlu4+Vq61o5LBtk+bvsilrwNgWik0VetzQC6lJirleOq1WDshHBtMlvE1U
	 4gFy1fT1ida14FZUPiRj5QULrvrGbNjyz247THch68MvFPNCjCP104xcGQXojfVhRa
	 CAtZmB6RMKITmn+/QnFva4APX6av5Syb7Jv6Xt20IGGuSKNg+yH6Ue71XrlPmPTxSh
	 WetVmXhz6647w==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Aaron Skomra <aaron.skomra@wacom.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v10 5/5] HID: wacom: Redesign shared sibling data lifecycle
Date: Wed,  9 Sep 2026 11:12:27 +0000
Message-ID: <8b0c6a2636ee52caae814603cbd65f0fb3e382d6.1788868602.git.lee@kernel.org>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
In-Reply-To: <fa3cb42f7b58c1b3022d8208969a81882783a5ec.1788868602.git.lee@kernel.org>
References: <fa3cb42f7b58c1b3022d8208969a81882783a5ec.1788868602.git.lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Wacom driver coordinates state between sibling interfaces of
the same physical device using a shared structure 'wacom_shared'
inside 'wacom_hdev_data'.  The driver kept a volatile representative
pointer 'data->dev' pointing to a sibling 'hid_device' for physical
path comparisons during sibling matching.

This pointer management is fragile.  When the representative device
is disconnected, wacom_remove_shared_data() failed to clear/update
'data->dev', leading to a Use-After-Free vulnerability when
subsequent sibling probes dereference the dangling 'data->dev'
pointer.

Resolve this issue by redesigning the sibling data lifecycle:

 - Eliminate the volatile 'data->dev' representative pointer
   completely
 - Redesign 'wacom_hdev_data' to store stable static copies of the
   required attributes upon first allocation: 'phys' path string,
   'vendor', 'product' IDs and the sibling's 'device_type'
 - Use these static attributes for stable sibling matching in
   wacom_are_sibling() and wacom_get_hdev_data()

This ensures sibling matching remains safe and stable even if
individual siblings are dynamically added or removed.

To secure the lifecycle against concurrent probe/disconnect races:

 - Switch kref_put() to kref_put_mutex() in
   wacom_remove_shared_data() to serialize refcount drops with list
   traversal and lookup
 - Modify wacom_release_shared_data() to assume the list lock is
   already held

Also, do not accumulate the 'device_type' capability flag during
subsequent sibling probes.  Keeping only the first probed sibling's
device_type exactly preserves the original sibling matching behavior
without introducing side effects.

Cc: stable@vger.kernel.org
Fixes: 4492efffffeb ("Input: wacom - share pen info with touch of the same ID")
Signed-off-by: Lee Jones <lee@kernel.org>
---
v1 -> v2:  Split and use RCU as per Dmitry's review
v2 -> v3:  Sashiko fixes
v3 -> v4:  No change
v4 -> v5:  No change
v5 -> v6:  No change
v6 -> v7:  No change
v7 -> v8:  No change
v8 -> v9:  No change
v9 -> v10: No change

 drivers/hid/wacom_sys.c | 70 +++++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 24 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 307eda9bbdd0..8dc7aa1c0a26 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -757,27 +757,47 @@ static void wacom_retrieve_hid_descriptor(struct hid_device *hdev,
 struct wacom_hdev_data {
 	struct list_head list;
 	struct kref kref;
-	struct hid_device *dev;
+	char phys[64];
+	__u32 vendor;
+	__u32 product;
+	__u32 device_type;
 	struct wacom_shared shared;
 };
 
+static bool wacom_compare_device_paths(struct hid_device *hdev_a,
+				       const char *phys_b, char separator)
+{
+	const char *p1 = strrchr(hdev_a->phys, separator);
+	const char *p2 = strrchr(phys_b, separator);
+	int n1, n2;
+
+	if (!p1 || !p2)
+		return false;
+
+	n1 = p1 - hdev_a->phys;
+	n2 = p2 - phys_b;
+
+	if (n1 != n2 || n1 <= 0 || n2 <= 0)
+		return false;
+
+	return !strncmp(hdev_a->phys, phys_b, n1);
+}
+
 static LIST_HEAD(wacom_udev_list);
 static DEFINE_MUTEX(wacom_udev_list_lock);
 
 static bool wacom_are_sibling(struct hid_device *hdev,
-		struct hid_device *sibling)
+		struct wacom_hdev_data *data)
 {
 	struct wacom *wacom = hid_get_drvdata(hdev);
 	struct wacom_features *features = &wacom->wacom_wac.features;
-	struct wacom *sibling_wacom = hid_get_drvdata(sibling);
-	struct wacom_features *sibling_features = &sibling_wacom->wacom_wac.features;
 	__u32 oVid = features->oVid ? features->oVid : hdev->vendor;
 	__u32 oPid = features->oPid ? features->oPid : hdev->product;
 
 	/* The defined oVid/oPid must match that of the sibling */
-	if (features->oVid != HID_ANY_ID && sibling->vendor != oVid)
+	if (features->oVid != HID_ANY_ID && data->vendor != oVid)
 		return false;
-	if (features->oPid != HID_ANY_ID && sibling->product != oPid)
+	if (features->oPid != HID_ANY_ID && data->product != oPid)
 		return false;
 
 	/*
@@ -785,11 +805,11 @@ static bool wacom_are_sibling(struct hid_device *hdev,
 	 * device path, while those with different VID/PID must share
 	 * the same physical parent device path.
 	 */
-	if (hdev->vendor == sibling->vendor && hdev->product == sibling->product) {
-		if (!hid_compare_device_paths(hdev, sibling, '/'))
+	if (hdev->vendor == data->vendor && hdev->product == data->product) {
+		if (!wacom_compare_device_paths(hdev, data->phys, '/'))
 			return false;
 	} else {
-		if (!hid_compare_device_paths(hdev, sibling, '.'))
+		if (!wacom_compare_device_paths(hdev, data->phys, '.'))
 			return false;
 	}
 
@@ -802,7 +822,7 @@ static bool wacom_are_sibling(struct hid_device *hdev,
 	 * devices.
 	 */
 	if ((features->device_type & WACOM_DEVICETYPE_DIRECT) &&
-	    !(sibling_features->device_type & WACOM_DEVICETYPE_DIRECT))
+	    !(data->device_type & WACOM_DEVICETYPE_DIRECT))
 		return false;
 
 	/*
@@ -810,17 +830,17 @@ static bool wacom_are_sibling(struct hid_device *hdev,
 	 * devices.
 	 */
 	if (!(features->device_type & WACOM_DEVICETYPE_DIRECT) &&
-	    (sibling_features->device_type & WACOM_DEVICETYPE_DIRECT))
+	    (data->device_type & WACOM_DEVICETYPE_DIRECT))
 		return false;
 
 	/* Pen devices may only be siblings of touch devices */
 	if ((features->device_type & WACOM_DEVICETYPE_PEN) &&
-	    !(sibling_features->device_type & WACOM_DEVICETYPE_TOUCH))
+	    !(data->device_type & WACOM_DEVICETYPE_TOUCH))
 		return false;
 
 	/* Touch devices may only be siblings of pen devices */
 	if ((features->device_type & WACOM_DEVICETYPE_TOUCH) &&
-	    !(sibling_features->device_type & WACOM_DEVICETYPE_PEN))
+	    !(data->device_type & WACOM_DEVICETYPE_PEN))
 		return false;
 
 	/*
@@ -836,7 +856,7 @@ static struct wacom_hdev_data *wacom_get_hdev_data(struct hid_device *hdev)
 
 	/* Try to find an already-probed interface from the same device */
 	list_for_each_entry(data, &wacom_udev_list, list) {
-		if (hid_compare_device_paths(hdev, data->dev, '/')) {
+		if (wacom_compare_device_paths(hdev, data->phys, '/')) {
 			kref_get(&data->kref);
 			return data;
 		}
@@ -844,7 +864,7 @@ static struct wacom_hdev_data *wacom_get_hdev_data(struct hid_device *hdev)
 
 	/* Fallback to finding devices that appear to be "siblings" */
 	list_for_each_entry(data, &wacom_udev_list, list) {
-		if (wacom_are_sibling(hdev, data->dev)) {
+		if (wacom_are_sibling(hdev, data)) {
 			kref_get(&data->kref);
 			return data;
 		}
@@ -858,18 +878,15 @@ static void wacom_release_shared_data(struct kref *kref)
 	struct wacom_hdev_data *data =
 		container_of(kref, struct wacom_hdev_data, kref);
 
-	mutex_lock(&wacom_udev_list_lock);
 	list_del(&data->list);
-	mutex_unlock(&wacom_udev_list_lock);
-
 	kfree(data);
 }
 
 static void wacom_remove_shared_data(void *res)
 {
-	struct wacom *wacom = res;
+	struct wacom *res_wacom = res;
 	struct wacom_hdev_data *data;
-	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
+	struct wacom_wac *wacom_wac = &res_wacom->wacom_wac;
 
 	if (wacom_wac->shared) {
 		data = container_of(wacom_wac->shared, struct wacom_hdev_data,
@@ -883,17 +900,19 @@ static void wacom_remove_shared_data(void *res)
 				rcu_dereference_protected(wacom_wac->shared->pen,
 							  lockdep_is_held(&wacom_udev_list_lock));
 
-			if (touch == wacom->hdev) {
+			if (touch == res_wacom->hdev) {
 				rcu_assign_pointer(wacom_wac->shared->touch, NULL);
 				rcu_assign_pointer(wacom_wac->shared->touch_input, NULL);
-			} else if (pen == wacom->hdev) {
+			} else if (pen == res_wacom->hdev) {
 				rcu_assign_pointer(wacom_wac->shared->pen, NULL);
 			}
 		}
 
 		synchronize_rcu();
 
-		kref_put(&data->kref, wacom_release_shared_data);
+		if (kref_put_mutex(&data->kref, wacom_release_shared_data, &wacom_udev_list_lock))
+			mutex_unlock(&wacom_udev_list_lock);
+
 		wacom_wac->shared = NULL;
 	}
 }
@@ -916,7 +935,10 @@ static int wacom_add_shared_data(struct hid_device *hdev)
 		}
 
 		kref_init(&data->kref);
-		data->dev = hdev;
+		strscpy(data->phys, hdev->phys, sizeof(data->phys));
+		data->vendor = hdev->vendor;
+		data->product = hdev->product;
+		data->device_type = wacom_wac->features.device_type;
 		list_add_tail(&data->list, &wacom_udev_list);
 	}
 
-- 
2.55.0.979.g7e5102b832-goog

