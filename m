Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF04372ECD
	for <Stable@vger.kernel.org>; Thu,  9 Jul 2026 05:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575915; cv=none; b=p6TZi/YNiOUVe/nbbakmd/8d47eBsPLlqH1/tArHYiCNHzeq5i4w7ZL5wdb7Lo6rzGunQ0h2XbkbG1bc9hQZpHeqylNxMhIFVgDb6lErJyvTpI0VDZaaHKvkK64+zLb6xUhtYnwPQDh0O0YmhLkrNDr7NP6a1nVHUbY+um8rGRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575915; c=relaxed/simple;
	bh=H96tdD/dmTrddr39IWldOzK4EYkrb7IhYSUO8GXzagE=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=tXBSJOhwWfVDcPTQQifTqqvuuayRwxXYIgzNq72DqX7zPjzj1CTLWqUnFvy19iVnAQzXf1Pqws0O00cQCg5Hj/n2qzsg4jYhplCRkkQO2yHrl2Hdabi/hzNSgZnE4zUxoH5/NXPM0hbjd/jINHtZTAnzz8XrH4EwGPPE5NW5eQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g6cu9gPa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g6cu9gPa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60341F000E9;
	Thu,  9 Jul 2026 05:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783575913;
	bh=6+Ofagpu3XNd2dA9LX28v01TBZwWxy/daE11YFe1rag=;
	h=Subject:To:From:Date;
	b=g6cu9gParoceCcdrEXeAD+Ttyw5z36azxex4ri/8MwIdCSCqRojQCXnlSPGGuAyoA
	 B+w4WdBMCtvFvc0FI4seFMv+loWA9xSgdfDUmgt2tWpMfqqmDkV1PSRQEyz8M0sdrU
	 uamfSTdGUu/KbYZ1XqvNS5CWRI3ZbqS3BTc3RP9w=
Subject: patch "HID: sensor-hub: Add sensor_hub_input_attr_read_values() for" added to char-misc-linus
To: srinivas.pandruvada@linux.intel.com,Stable@vger.kernel.org,andriy.shevchenko@intel.com,jic23@kernel.org,jkosina@suse.com,lixu.zhang@intel.com
From: <gregkh@linuxfoundation.org>
Date: Thu, 09 Jul 2026 07:44:48 +0200
Message-ID: <2026070948-playful-showroom-1d01@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    HID: sensor-hub: Add sensor_hub_input_attr_read_values() for

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From f784fcea450617055d2d12eec5b2f6e0e38bf878 Mon Sep 17 00:00:00 2001
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Date: Wed, 10 Jun 2026 16:29:09 +0800
Subject: HID: sensor-hub: Add sensor_hub_input_attr_read_values() for
 multi-byte reads

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
---
 drivers/hid/hid-sensor-hub.c   | 77 +++++++++++++++++++++++++++++++---
 include/linux/hid-sensor-hub.h | 25 +++++++++++
 2 files changed, 96 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 90666ff629de..34f710c465b8 100644
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
@@ -478,6 +526,8 @@ static int sensor_hub_raw_event(struct hid_device *hdev,
 	struct hid_collection *collection = NULL;
 	void *priv = NULL;
 	struct hid_sensor_hub_device *hsdev = NULL;
+	u32 copy_size;
+	u32 avail;
 
 	hid_dbg(hdev, "sensor_hub_raw_event report id:0x%x size:%d type:%d\n",
 			 report->id, size, report->type);
@@ -518,12 +568,27 @@ static int sensor_hub_raw_event(struct hid_device *hdev,
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
index e71056553108..ab5cc8db3fbb 100644
--- a/include/linux/hid-sensor-hub.h
+++ b/include/linux/hid-sensor-hub.h
@@ -43,6 +43,8 @@ struct hid_sensor_hub_attribute_info {
  * @attr_usage_id:	Usage Id of a field, e.g. X-axis for a gyro.
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
@@ -183,6 +187,27 @@ int sensor_hub_input_attr_get_raw_value(struct hid_sensor_hub_device *hsdev,
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
2.55.0


