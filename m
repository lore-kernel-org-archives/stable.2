Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795799267;
	b=WaAXY0LBcvBwWwz4/bnhoT+IXbUAm+7/V8pFP+II9aOI7SYtz0kloIWuUd2EVc/q5s/x
	 fVtFfEW45VkiNhfWMJEw8U66dE3uVqNx/C0yBY+9xVlDs4k1H5Jg4JSXDmk2AJhMBKwoc
	 dWS3Psqi9SpfOMJfb8fa2/KUlinqsslV4B93V98eeuBwP/gAGBosfge0rCZjySGj85QDa
	 eEXDgIjcPJcrNbuQoHJnIjNOvho0ZbAbNS3p78lfB1iVWGQQomAIglh167vBTOfycM0FO
	 PRPzUupNUVn9bxN6E32HA8H8lMgj+8rVX4ebqgfDWuarzOm7PSUQ/V34ukOjJrSaMFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795799267;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=msSbCQmeBHYz8rK/XqH+Cb7QpYH+bKJSEe53EOPrG9M=;
	b=oc9Be8RLgm6px+TTcKTAs4thw9e20a3mf4c/poGEFLviur5XFT2wdzLJFYEt4ifrrcNd
	 BCJOfY9nR7bGmNp7B27lHnG7TJ3sNZJ7K1PxdcNH5WGb80JcLq3V+pss5OjIvGQ1OS2ZO
	 Cd3lpe8pekLCOcJummucrmONqf45cigfCyQn6HzgeARqmW33aK+BhmC9e0kI8tQq0LGKk
	 2/XLNAZf3PSIf33Oa3atlbvwUBxDYUBOWnR6Zqz/GEWX5ewfbrQrLK09KYGjFvhNFBjW6
	 M4mEca+uEKpqzev0WfHSJKHm+8OaA/kBXp9PFi2Eo0lHKA07II0nD+qIZNmNhd3P2VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SX27KAQV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA671606A31E;
	Fri, 27 Nov 2026 17:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SX27KAQV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3301F00893;
	Fri, 27 Nov 2026 17:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795799267;
	bh=msSbCQmeBHYz8rK/XqH+Cb7QpYH+bKJSEe53EOPrG9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SX27KAQVrxmWVJqSY3/sDJ8RfyVz0pJpWUlJr7gLoW+eNMD+5DhYO559vqU+/NFvQ
	 MvYLQUf+qUCECdHcFSRhrfX8pwn0Pom3KVzRNdgdk2TMM5DtXEha7L4J82uaM5+jvi
	 ENKo6SDAMxXOohjwRpu7MaHYp8wqyB8kEcOs8hCTR7A9mltOfP7LiwXLhfnipCuChG
	 Cfbp/50greY3yXyI1kQ6LhA+Fc7vVV+X3ZpgEe35qLVo0Rqrx5KGB0+rutgyvcT7Wr
	 MU8QQTmceQp6Wt8hnZ/TlDPS8JpD7tkg5shspJnF5BacTcwuEeyf97B8Crsk7yD94M
	 4hz4jApKIqacQ==
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
Subject: [PATCH v2 04/10] HID: sensor-hub: Serialise synchronous read teardown under data->lock
Date: Fri, 27 Nov 2026 17:06:22 +0000
Message-ID: <20261127170712.3163443-5-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127170712.3163443-1-lee@kernel.org>
References: <20261127170712.3163443-1-lee@kernel.org>
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
hsdev->pending.raw_data in both helpers, and clear
hsdev->pending.status in sensor_hub_raw_event() when completing the
request so only the first matching report is consumed.

Fixes: 401ca24fb34a ("HID: sensors: introduce sensor framework")
Fixes: f784fcea4506 ("HID: sensor-hub: Add sensor_hub_input_attr_read_values() for multi-byte reads")
Closes: https://sashiko.dev/#/bug/linux-5bd5ea7c-72f9-4f22-ae1d-00915390f085
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
v1 => v2:
 - Remove kfree() from sensor_hub_raw_event() and clear hsdev->pending.status before complete() under data->lock, per Srinivas Pandruvada's review.

 drivers/hid/hid-sensor-hub.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 2a7f2475171f..180a913888a4 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -310,6 +310,9 @@ int sensor_hub_input_attr_read_values(struct hid_sensor_hub_device *hsdev,
 	long cycles;
 	int ret;
 
+	if (flag == SENSOR_HUB_SYNC && (!buffer || !buffer_size))
+		return -EINVAL;
+
 	report = sensor_hub_report(report_id, hsdev->hdev, HID_INPUT_REPORT);
 	if (!report)
 		return -EINVAL;
@@ -339,7 +342,10 @@ int sensor_hub_input_attr_read_values(struct hid_sensor_hub_device *hsdev,
 		else if (cycles < 0)
 			ret = cycles;
 
+		spin_lock_irqsave(&data->lock, flags);
 		hsdev->pending.status = false;
+		hsdev->pending.raw_data = NULL;
+		spin_unlock_irqrestore(&data->lock, flags);
 	}
 	mutex_unlock(hsdev->mutex_ptr);
 
@@ -379,29 +385,36 @@ int sensor_hub_input_attr_get_raw_value(struct hid_sensor_hub_device *hsdev,
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
 					hsdev->pending.index += copy_size;
 					if (hsdev->pending.index >= hsdev->pending.max_raw_size) {
 						hsdev->pending.raw_size = hsdev->pending.index;
+						hsdev->pending.status = false;
 						complete(&hsdev->pending.ready);
 					}
 				}
@@ -599,6 +613,7 @@ static int sensor_hub_raw_event(struct hid_device *hdev,
 					hsdev->pending.raw_size = sz;
 				else
 					hsdev->pending.raw_size = 0;
+				hsdev->pending.status = false;
 				complete(&hsdev->pending.ready);
 			}
 		}
-- 
2.56.1.839.g22a8290db9-goog

