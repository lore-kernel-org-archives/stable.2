Received: from va-2-44.ptr.blmpb.com (va-2-44.ptr.blmpb.com [209.127.231.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123D8483BD1
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785947923; cv=none; b=TQ7K8N9ck/Bb1F9/z4TqiCCg9q1H5u45Ffs45QC/JoIzUQSDUJoF2HGhuM89yVPnsFGmRBVrck3b7V+eAGP2Ps9gp0aUa0dSrxu3FkzJO3TfeKRKS6yUdc9McpWwNXVUpWXBZOv+sVgL3DtOmIxSRrja4thOulLCjuHM8tKpf5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785947923; c=relaxed/simple;
	bh=1eaZjSyQiauYjPvavxFDl1LvGdOwtRGiMfDerN/NcNc=;
	h=Date:Mime-Version:To:From:Subject:Message-Id:Content-Type:Cc; b=O0aXkbKUPIg02Wxg7odX7933k7E6MLz3xlKVjhVZnksdybAolkcrb6au9tCcc74dsRCxvI1cuRIRu1eDyemsXQgXG/AdcbYpPjBqLe/ZTWt85hQ4lhaK4pZ72omddluLohduNiaumOmWGvPiZhhw4ob+s8pQRTZwi72wPgSy4no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=VZImHwDo; arc=none smtp.client-ip=209.127.231.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="VZImHwDo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1785947916; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=LnsE1iNZiHSw8OO+Ugls5I5U6nYU7LBTDmRHK5suJ3U=;
 b=VZImHwDo0JalED+kG++QnWTV07wV81cfVk+C7p3gAVIg6XB6+fLvsdOKfQcn7dQ/HFb9gp
 /ivk5pibGare/KttFMfhNCqLlpzAtRAPOQiCfEDeMuXpPS3WxxGNVTJRnepA3VgCIeCbms
 jV/h+x9Htne7h5CRD/ukPQ+Dia7niPhluK2R3T1KPFHibDDSc/vhuDPgtlYkF9w3oaKm0Y
 bAg9JzStRHaMGRk8BQNBhv7KypOyj9rAJHYs7LhzcGgwhA7sliOssHmRnX8I9/adTuZSdD
 DXBzhBqKFiwFqwkn+UZXgrtqo5ygp4f6+OI6hZ0ybT/bpLPE5y0bX0zfVNdXqA==
Date: Thu, 06 Aug 2026 00:38:19 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from [192.168.9.107] ([111.40.58.243]) by smtp.feishu.cn with ESMTPS; Thu, 06 Aug 2026 00:38:33 +0800
To: "Jiri Kosina" <jikos@kernel.org>, "Jonathan Cameron" <jic23@kernel.org>, 
	"Srinivas Pandruvada" <srinivas.pandruvada@linux.intel.com>, 
	"Benjamin Tissoires" <bentiss@kernel.org>
From: "Shengzhuo Wei" <me@cherr.cc>
Subject: [PATCH] HID: sensor-hub: fix out-of-bounds access in sensor_hub_get_feature()
Message-Id: <20260806-hid-sensor-hub-oob-v1-1-f8e210e7eafe@cherr.cc>
X-Change-Id: 20260806-hid-sensor-hub-oob-f316fd015b76
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
Content-Type: text/plain; charset=UTF-8
X-Original-From: Shengzhuo Wei <me@cherr.cc>
Cc: <linux-input@vger.kernel.org>, <linux-iio@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, 
	"Shengzhuo Wei" <me@cherr.cc>
X-B4-Tracking: v=1; b=H4sIAPpmc2oC/x3MQQqAIBBA0avErBvQIouuEi0yx5yNhkMRSHdPW r7F/wWEMpPA3BTIdLNwihW6bWAPWzwI2VVDpzqjJmUwsEOhKCljuCymZNH32nin9GBHAzU8M3l +/umyvu8HR4BHdWQAAAA=
X-Lms-Return-Path: <lba+26a73670a+ae85e9+vger.kernel.org+me@cherr.cc>

sensor_hub_get_feature() copies each field value with
memcpy(..., report->field[...]->report_size / 8), a size taken only
from the descriptor and bounded neither to the caller buffer nor to the
field->value[] array.

When report_size exceeds the remaining buffer (e.g. a 64-bit power-state
field into a 4-byte int) the copy overflows the caller's stack on the
first iteration; when report_size > 32 it also reads past field->value[]
(one __s32 per logical value) into slab, leaking bytes to userspace via
callers that expose the buffer (hid-sensor-custom show_value over sysfs).
Reachable from an untrusted USB or Bluetooth HID device with no local
privileges.

Bound the per-iteration copy to min(report_size/8,
(report_count-i)*sizeof(__s32), buffer_size - buffer_index).

Fixes: 5459ada2b3cd ("HID: sensor-hub: Fix packing of result buffer for feature report")
Cc: stable@vger.kernel.org
Signed-off-by: Shengzhuo Wei <me@cherr.cc>
---
 drivers/hid/hid-sensor-hub.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 34f710c465b80a0c46cc207e3d99a07c5767f291..978335db71b09617c87e879911b8e75b6bfdebb8 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -270,11 +270,18 @@ int sensor_hub_get_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
 
 	val_ptr = (u8 *)report->field[field_index]->value;
 	for (i = 0; i < report->field[field_index]->report_count; ++i) {
+		int copy = report->field[field_index]->report_size / 8;
+		int src_remaining = (report->field[field_index]->report_count - i) *
+				    sizeof(__s32);
+
 		if (buffer_index >= ret)
 			break;
 
-		memcpy(&((u8 *)buffer)[buffer_index], val_ptr,
-		       report->field[field_index]->report_size / 8);
+		if (copy > src_remaining)
+			copy = src_remaining;
+		if (copy > buffer_size - buffer_index)
+			copy = buffer_size - buffer_index;
+		memcpy(&((u8 *)buffer)[buffer_index], val_ptr, copy);
 		val_ptr += sizeof(__s32);
 		buffer_index += (report->field[field_index]->report_size / 8);
 	}

---
base-commit: bf0a94fb2b59542f9dd6fea4eec67336f1ccfa56
change-id: 20260806-hid-sensor-hub-oob-f316fd015b76

Best regards,
-- 
Shengzhuo Wei <me@cherr.cc>
