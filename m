Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795449135;
	b=ZmTjVgNXU2J212sntPwC6hsnJP8Q7EQkj11nhg6zsmU2lHGaaFGbEnIoUQlfav9V0iTq
	 8p4PeV0I7s+flWyAVyzEyeg1XkkCaXNWoQIyZ6ueh8cSFuN6k/OFseOsHgZsq9FUBaYkB
	 mcZ5mM0DlkYu5GpP50UCrtL01+GFAZ6dXjts4pJ50JCOMTtw+0yO6IQUcK6TiUwyrAXz5
	 1EaSaT2VxyVxsSJgAK2JlaonuBaoBv/KiO2XoL9vU/97ZKhY2mU33YCu2tmsEHRJG7NOu
	 D8nVqV66ija8cirTyWa4LDhSF114iWqY/aP6aWjijODMYlZDXU+jp1tUxJjDvcjejJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795449135;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4tgswxlrs1di+FF5sNW9XyKqOxnTbKBlOCMpfMTZwAo=;
	b=XRWtQIqlIwIjZlhpKkazSnUdbAe8QPmvjWfDnmzp8hHFaC8KgBEygULCrhxZub5sRs+p
	 ye1TrJfKJoqO4dOrdtUTOHmqkdyB656W4+gniLMT0qmv7klGmMFVCjLPZMHH6YPPB8GJ8
	 B9WSQ4SHW/vrzRuHtK+etc/7RkbOjQspNzA4LlttalyqddlDFyNrqoOxsOJDLUU2wMQGW
	 m78bKOTSUe0Yc1PE/qJDxSURXJKNaKLcX/T4GoWkY47ncj8NAB+v/Vve2MUGIOkPeuzeJ
	 dMgmEwzgWo5Joz5Dhvf85dh4zPnX5RUyphMmr9rKtl7NIR8LTQSxOfRohxPswboEWkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h0HvXbWZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA9D606A31A;
	Mon, 23 Nov 2026 15:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h0HvXbWZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC7D1F000C0;
	Mon, 23 Nov 2026 15:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795449134;
	bh=4tgswxlrs1di+FF5sNW9XyKqOxnTbKBlOCMpfMTZwAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h0HvXbWZV3oTqHKeF2IYa/qZP4nqjj0zy3SGhi1bIUOFQ2v7LjNRo9hU33YBnRQ2i
	 YiGGYG2b4YTEAhWgEK/6Ev3TB3+yZjX/AwPrFjNeTFHgKYOLmbGIRzAkUtx/IRNOXI
	 w4dcug75AidB5eWkLUMtz4jDlTtyyH9WWGuaoIHcCA8pzk+S311iVW9Lq/fGAThXvq
	 b4KX8vi6jKnFt7E01KLvOpmB1bHRICdeW6clPBlIX8/JmvnzttSELDBfWBxyYKHg2l
	 fK1R7gpKcvSUqTK1EbbE6WmiA8dukNUjHN58YQjdz1vlLlztbA8o5ciW9nMSqb+Hi/
	 Kt6fJ4kxPz9ng==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Zhang Lixu <lixu.zhang@intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 04/10] HID: sensor-hub: Serialise synchronous read teardown under data->lock
Date: Mon, 23 Nov 2026 15:50:48 +0000
Message-ID: <20261123155138.2907049-5-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261123155138.2907049-1-lee@kernel.org>
References: <20261123155138.2907049-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

sensor_hub_input_attr_read_values() and
sensor_hub_input_attr_get_raw_value() set hsdev->pending.status under
data->lock, sleep in wait_for_completion_interruptible_timeout(), and
then clear hsdev->pending.status and consume or free
hsdev->pending.raw_data without acquiring data->lock.  When a wait is
interrupted by a signal or times out while sensor_hub_raw_event() holds
the same spinlock, sensor_hub_raw_event() can memcpy() into the
caller's popped stack buffer in sensor_hub_input_attr_read_values() or
race with kfree() and leak kmemdup() allocations in
sensor_hub_input_attr_get_raw_value().

Hold data->lock when clearing hsdev->pending.status and detaching
hsdev->pending.raw_data in both helpers, and free any prior
hsdev->pending.raw_data before kmemdup() in sensor_hub_raw_event().

Fixes: 401ca24fb34a ("HID: sensors: introduce sensor framework")
Fixes: f784fcea4506 ("HID: sensor-hub: Add sensor_hub_input_attr_read_values() for multi-byte reads")
Closes: https://sashiko.dev/#/bug/linux-5bd5ea7c-72f9-4f22-ae1d-00915390f085
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/hid-sensor-hub.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 81c8e723f9ba..ea846e0bb301 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -306,6 +306,9 @@ int sensor_hub_input_attr_read_values(struct hid_sensor_hub_device *hsdev,
 	long cycles;
 	int ret;
 
+	if (flag == SENSOR_HUB_SYNC && (!buffer || !buffer_size))
+		return -EINVAL;
+
 	report = sensor_hub_report(report_id, hsdev->hdev, HID_INPUT_REPORT);
 	if (!report)
 		return -EINVAL;
@@ -335,7 +338,10 @@ int sensor_hub_input_attr_read_values(struct hid_sensor_hub_device *hsdev,
 		else if (cycles < 0)
 			ret = cycles;
 
+		spin_lock_irqsave(&data->lock, flags);
 		hsdev->pending.status = false;
+		hsdev->pending.raw_data = NULL;
+		spin_unlock_irqrestore(&data->lock, flags);
 	}
 	mutex_unlock(hsdev->mutex_ptr);
 
@@ -375,29 +381,36 @@ int sensor_hub_input_attr_get_raw_value(struct hid_sensor_hub_device *hsdev,
 	hid_hw_request(hsdev->hdev, report, HID_REQ_GET_REPORT);
 	mutex_unlock(&data->mutex);
 	if (flag == SENSOR_HUB_SYNC) {
+		u8 *raw_data;
+
 		wait_for_completion_interruptible_timeout(
 						&hsdev->pending.ready, HZ*5);
-		switch (hsdev->pending.raw_size) {
+		spin_lock_irqsave(&data->lock, flags);
+		raw_data = hsdev->pending.raw_data;
+		switch (raw_data ? hsdev->pending.raw_size : 0) {
 		case 1:
 			if (is_signed)
-				ret_val = *(s8 *)hsdev->pending.raw_data;
+				ret_val = *(s8 *)raw_data;
 			else
-				ret_val = *(u8 *)hsdev->pending.raw_data;
+				ret_val = *(u8 *)raw_data;
 			break;
 		case 2:
 			if (is_signed)
-				ret_val = *(s16 *)hsdev->pending.raw_data;
+				ret_val = *(s16 *)raw_data;
 			else
-				ret_val = *(u16 *)hsdev->pending.raw_data;
+				ret_val = *(u16 *)raw_data;
 			break;
 		case 4:
-			ret_val = *(u32 *)hsdev->pending.raw_data;
+			ret_val = *(u32 *)raw_data;
 			break;
 		default:
 			ret_val = 0;
 		}
-		kfree(hsdev->pending.raw_data);
+		hsdev->pending.raw_data = NULL;
+		hsdev->pending.raw_size = 0;
 		hsdev->pending.status = false;
+		spin_unlock_irqrestore(&data->lock, flags);
+		kfree(raw_data);
 	}
 	mutex_unlock(hsdev->mutex_ptr);
 
@@ -590,6 +603,7 @@ static int sensor_hub_raw_event(struct hid_device *hdev,
 					}
 				}
 			} else {
+				kfree(hsdev->pending.raw_data);
 				hsdev->pending.raw_data = kmemdup(ptr, sz, GFP_ATOMIC);
 				if (hsdev->pending.raw_data)
 					hsdev->pending.raw_size = sz;
-- 
2.56.1.750.gf70dc682cf-goog

