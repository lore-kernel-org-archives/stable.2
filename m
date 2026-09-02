Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90244A0906;
	Wed,  2 Sep 2026 13:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356684; cv=none; b=FtBcZ5DnAn4jFgrFH7jKjQl5fWVhnkoIi1FaKk+dxoq6lVdqhjJjLJspwHX4OlWgPJnVpnIBQMZ2EmqpFvS6z2Qs3zwCR01/1WpZlOJTwuA24NFn9u96Cu6DR+M0sSmVfKJZR314OBhyvpR67fWmdYVzwx8HlLMEFN5/WyIVAsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356684; c=relaxed/simple;
	bh=Bgbauw2/8PHd1zyiV+8EGeTixjcSZEmcmgDfOCd01VE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VLrNhnnkUgjrxMWqiAibxEIq1GrxlWbonlP9eaUAPf9N9AEkyDVbtM0mD6v1s4B2DaD9uCaH6u3pJCW4NShGA5FgfugTCXh5M4I/7BAdSENlog8THCJ8yZ7k+nMi41nxv37YX/g3paklI5i5UHN4KSgU4FUzUhCFw52x8093k/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCzcF9Ug; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCzcF9Ug"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74BD81F00A3A;
	Wed,  2 Sep 2026 13:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788356682;
	bh=aIST0kyAvmm/hcGI7MAHNtpWOoWo9oYV9/FEa43LLwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SCzcF9Ugy5vy0aSKzCpURtPEWR0jFPchIDKruUg45/P6W6r6JwwPXVNbeRtz4FZyc
	 mYT8ycTYqwL4xNnEKrVnoiW0IL6Wyf/7lq0Y/d5t0szSLqroOjWuBCo9Jl+Sr0KKpM
	 sg+rttEGEGYlDkWx+sijNyWBP+SVAomBNd3UbCcfSWp/PQZo4tuR2LaPe1VPTARnP1
	 7+wbJj6kH5ZmfygFkQiJlJQMuk2rak2QFtUWjWf6sSbmKW5VLzJqppVTGefD0Y1y5V
	 u1A6BeLw6YrbVIVZk1q3EY9Me+Fh/WG1/kyzPErRnqcm69ivir/FZ62aTxafY4WaCr
	 hUQznvWyzPGVQ==
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
Subject: [PATCH v9 5/5] HID: wacom: Redesign shared sibling data lifecycle
Date: Wed,  2 Sep 2026 13:44:05 +0000
Message-ID: <20260902134417.1270552-5-lee@kernel.org>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
In-Reply-To: <20260902134417.1270552-1-lee@kernel.org>
References: <20260902134417.1270552-1-lee@kernel.org>
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

v1 -> v2: Split and use RCU as per Dmitry's review
v2 -> v3: Sashiko fixes
v3 -> v4: No change
v4 -> v5: No change
v5 -> v6: No change
v6 -> v7: No change
v7 -> v8: No change
v8 -> v9: No change

 drivers/hid/wacom_sys.c | 70 +++++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 24 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 12f6a32cbc5f..9b991078a36d 100644
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
2.55.0.966.g6673acef38-goog

