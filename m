Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558A32745E
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 18:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783966403; cv=none; b=sA6bYntFIT0RjNUD2lOMZD8Ek9b8HozlhCNmNi6gQC78YcnZNUoYVjHqKt603ARSsjDtj1xyVE0xP5AiuLl8rH9xzyEc5hBS3Mt3tTaPx8zpSmQMviVZyyWUHu6DDn9pK7Co0c5U8K1lWWVjf71vVoBl7lq66phgV5VG3whR9LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783966403; c=relaxed/simple;
	bh=BBvIafieRFMn9Q4F+v82rWAF5VjbiaF2RfLN89nks94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fIm+t2PIMBaoVj5ridzH6XeSyP38HZ/QWlXU8lkyXUBGmu9Ib16oFPBbWfd99Kb6BbSiWo6tY5JHV05d+YCU7pIhDYwlMmZoHwjnzUQbnP/DW2U/ymmMFbbK9S0rDD0t80q+5/uEEcPy12p0fdAYOJLGv9gF4OSTrt1DdyBhJrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIUmKuFw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIUmKuFw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364551F000E9;
	Mon, 13 Jul 2026 18:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783966402;
	bh=++l6fRREokEuxAD9xKHAUpYlI0gZp4wSSU1tcCSHSnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DIUmKuFwu/jgQziyLXOP9HB4dWnCQ+0YiKn+Flb70URHuX+KP2deD/7wrz4+W82N8
	 KT1O3BIpvaAD0igAL8SLuS5d/zsVg5n4WaOlin/8R0rnRGvgQ096la+oJf4RDS4IsG
	 55nXvpN+BwPXyIeUdeLKeIItccIXH5lgINePo/EWaP/X+CHVBINVAkFy14U8V4sQyz
	 MvDXtIgECfEhW0un7ov1ug2XaCOdgOuTgRo02xG4FczGpi+LgQLT3EdHtxI53oqYPF
	 3oxyIJ7X1wLpWZlRWBvDZPWae3EsOBkOq9S/D6HF3oFH/9Y4tcZ/ihp8Avjk4gP6nV
	 XUTeH2lQqRaoQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Zhang Lixu <lixu.zhang@intel.com>,
	Jiri Kosina <jkosina@suse.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] HID: sensor-hub: Add sensor_hub_input_attr_read_values() for multi-byte reads
Date: Mon, 13 Jul 2026 14:13:18 -0400
Message-ID: <20260713181319.1932247-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071307-sensually-supplier-b03e@gregkh>
References: <2026071307-sensually-supplier-b03e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

[ Upstream commit f784fcea450617055d2d12eec5b2f6e0e38bf878 ]

sensor_hub_input_attr_get_raw_value() is limited to returning a single
32-bit value, which is insufficient for sensors that report data larger
than 32 bits, such as a quaternion with four s16 elements.

Add sensor_hub_input_attr_read_values() that accepts a caller-provided
buffer and accumulates incoming data until the buffer is full. The two
paths are distinguished in sensor_hub_raw_event() by pending.max_raw_size
being non-zero, preserving backward compatibility.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Co-developed-by: Zhang Lixu <lixu.zhang@intel.com>
Signed-off-by: Zhang Lixu <lixu.zhang@intel.com>
Acked-by: Jiri Kosina <jkosina@suse.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Stable-dep-of: 3ce8d099e0af ("iio: hid-sensor-rotation: Fix stale or zero output when reading raw values")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-sensor-hub.c   | 77 +++++++++++++++++++++++++++++++---
 include/linux/hid-sensor-hub.h | 25 +++++++++++
 2 files changed, 96 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 3cd00afa453a6d..3fc2967bc81768 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -286,6 +286,54 @@ int sensor_hub_get_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
 }
 EXPORT_SYMBOL_GPL(sensor_hub_get_feature);
 
+int sensor_hub_input_attr_read_values(struct hid_sensor_hub_device *hsdev,
+				      u32 usage_id, u32 attr_usage_id,
+				      u32 report_id,
+				      enum sensor_hub_read_flags flag,
+				      u32 buffer_size, u8 *buffer)
+{
+	struct sensor_hub_data *data = hid_get_drvdata(hsdev->hdev);
+	struct hid_report *report;
+	unsigned long flags;
+	long cycles;
+	int ret;
+
+	report = sensor_hub_report(report_id, hsdev->hdev, HID_INPUT_REPORT);
+	if (!report)
+		return -EINVAL;
+
+	mutex_lock(hsdev->mutex_ptr);
+	if (flag == SENSOR_HUB_SYNC) {
+		memset(&hsdev->pending, 0, sizeof(hsdev->pending));
+		init_completion(&hsdev->pending.ready);
+		hsdev->pending.usage_id = usage_id;
+		hsdev->pending.attr_usage_id = attr_usage_id;
+		hsdev->pending.max_raw_size = buffer_size;
+		hsdev->pending.raw_data = buffer;
+
+		spin_lock_irqsave(&data->lock, flags);
+		hsdev->pending.status = true;
+		spin_unlock_irqrestore(&data->lock, flags);
+	}
+	mutex_lock(&data->mutex);
+	hid_hw_request(hsdev->hdev, report, HID_REQ_GET_REPORT);
+	mutex_unlock(&data->mutex);
+	ret = 0;
+	if (flag == SENSOR_HUB_SYNC) {
+		cycles = wait_for_completion_interruptible_timeout(&hsdev->pending.ready,
+								   HZ * 5);
+		if (cycles == 0)
+			ret = -ETIMEDOUT;
+		else if (cycles < 0)
+			ret = cycles;
+
+		hsdev->pending.status = false;
+	}
+	mutex_unlock(hsdev->mutex_ptr);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sensor_hub_input_attr_read_values);
 
 int sensor_hub_input_attr_get_raw_value(struct hid_sensor_hub_device *hsdev,
 					u32 usage_id,
@@ -480,6 +528,8 @@ static int sensor_hub_raw_event(struct hid_device *hdev,
 	struct hid_collection *collection = NULL;
 	void *priv = NULL;
 	struct hid_sensor_hub_device *hsdev = NULL;
+	u32 copy_size;
+	u32 avail;
 
 	hid_dbg(hdev, "sensor_hub_raw_event report id:0x%x size:%d type:%d\n",
 			 report->id, size, report->type);
@@ -520,12 +570,27 @@ static int sensor_hub_raw_event(struct hid_device *hdev,
 					      hsdev->pending.attr_usage_id ==
 					      report->field[i]->logical)) {
 			hid_dbg(hdev, "data was pending ...\n");
-			hsdev->pending.raw_data = kmemdup(ptr, sz, GFP_ATOMIC);
-			if (hsdev->pending.raw_data)
-				hsdev->pending.raw_size = sz;
-			else
-				hsdev->pending.raw_size = 0;
-			complete(&hsdev->pending.ready);
+			if (hsdev->pending.max_raw_size) {
+				if (hsdev->pending.index < hsdev->pending.max_raw_size) {
+					avail = hsdev->pending.max_raw_size - hsdev->pending.index;
+					copy_size = clamp(sz, 0U, avail);
+
+					memcpy(hsdev->pending.raw_data + hsdev->pending.index,
+					       ptr, copy_size);
+					hsdev->pending.index += copy_size;
+					if (hsdev->pending.index >= hsdev->pending.max_raw_size) {
+						hsdev->pending.raw_size = hsdev->pending.index;
+						complete(&hsdev->pending.ready);
+					}
+				}
+			} else {
+				hsdev->pending.raw_data = kmemdup(ptr, sz, GFP_ATOMIC);
+				if (hsdev->pending.raw_data)
+					hsdev->pending.raw_size = sz;
+				else
+					hsdev->pending.raw_size = 0;
+				complete(&hsdev->pending.ready);
+			}
 		}
 		if (callback->capture_sample) {
 			if (report->field[i]->logical)
diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
index c27329e2a5ad57..f034d1dbbee9e2 100644
--- a/include/linux/hid-sensor-hub.h
+++ b/include/linux/hid-sensor-hub.h
@@ -43,6 +43,8 @@ struct hid_sensor_hub_attribute_info {
  * @attr_usage_id:	Usage Id of a field, E.g. X-AXIS for a gyro.
  * @raw_size:		Response size for a read request.
  * @raw_data:		Place holder for received response.
+ * @index:		Current write index into raw_data for multi-byte reads.
+ * @max_raw_size:	Total buffer size for multi-byte reads; 0 for single-value reads.
  */
 struct sensor_hub_pending {
 	bool status;
@@ -51,6 +53,8 @@ struct sensor_hub_pending {
 	u32 attr_usage_id;
 	int raw_size;
 	u8  *raw_data;
+	u32 index;
+	u32 max_raw_size;
 };
 
 /**
@@ -182,6 +186,27 @@ int sensor_hub_input_attr_get_raw_value(struct hid_sensor_hub_device *hsdev,
 					bool is_signed
 );
 
+/**
+ * sensor_hub_input_attr_read_values() - Synchronous multi-byte read request
+ * @hsdev:		Hub device instance.
+ * @usage_id:		Attribute usage id of parent physical device as per spec
+ * @attr_usage_id:	Attribute usage id as per spec
+ * @report_id:		Report id to look for
+ * @flag:		Synchronous or asynchronous read
+ * @buffer_size:	Size of the buffer in bytes
+ * @buffer:		Buffer to store the read data
+ *
+ * Issues a synchronous or asynchronous read request for an input attribute,
+ * accumulating data into the provided buffer until it is full.
+ * Return: 0 on success, -ETIMEDOUT if the device did not respond, or a
+ * negative error code.
+ */
+int sensor_hub_input_attr_read_values(struct hid_sensor_hub_device *hsdev,
+				      u32 usage_id, u32 attr_usage_id,
+				      u32 report_id,
+				      enum sensor_hub_read_flags flag,
+				      u32 buffer_size, u8 *buffer);
+
 /**
 * sensor_hub_set_feature() - Feature set request
 * @hsdev:	Hub device instance.
-- 
2.53.0

