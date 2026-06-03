Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F067943637A;
	Wed,  3 Jun 2026 16:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780504237; cv=none; b=NOoRwLPCQTWKdVwbJ6dn3GR5mSMjfpf23qq5Ta0+9TVD5J2LEIEdG0dQ0yvf9vuq6YHryD0DNMxLnYLRmZ/DiW3BhdClCkLvB5clF0reAZHEvq0LlkLbty6VAXHL7F6kF3a5EjRthU5qFfTOxiptMfAkG2SYawK4iFrtggvp6FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780504237; c=relaxed/simple;
	bh=m48N8EtrjZOFGnmmREgpDdomK+qxPyYvpywPWxIYPn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cpcAKEWQBhX/nf+EVKHt3jgWuUsMk1ePO2REiyXOu03J71q6nZIr5trlgWzhnRC89WFTCd6tJEf+/dkkj/ym9QfFfXxSEuSS6+TGTCwtYd7ElMLOooeAQgiOmI4TsSf9uuV4HHImFCcm8irDcKem9dFWqs9hMpGLIuncVJCvTL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKHzN7sS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKHzN7sS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45641F00893;
	Wed,  3 Jun 2026 16:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780504235;
	bh=b/289Llr71EjVLLCjJt/OxZWrs0VB++6DzyuhEhHHiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nKHzN7sSDtq7gJzYHEz8RVOodSqXhwPs71OX55WMo+NhtLNaqR0htg5fIt51aVGUn
	 1U+8enFuoDAHDd7/4xSRL4eOdWbLq8Srfzvt6gZwj8gWFwow1vK5aI4/UgAuk5CoNR
	 YUaZhcBExX/YAjI/Q/fYH3iwRwspN6Igp37k3b7F033wBa42xMcI/9iBldzK+Ne6lV
	 1DfyB9pwjsVmNgOt3Qg1JDXHFc740k5wcVz9mjFsD1JcvYwOSDOUTvXFRBqUZjX6Tn
	 awwZFA+FqfmMxAT57TpUfpKsQfs90f0vKi3mFnInoDSbyJSIavnSm0/g0oHj/j9DU/
	 5ZdqfEMtOxjiw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	=?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev
Cc: stable@vger.kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [linux-6.1.y 2/3] HID: pass the buffer size to hid_report_raw_event
Date: Wed,  3 Jun 2026 17:30:13 +0100
Message-ID: <20260603163022.3301081-2-lee@kernel.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <20260603163022.3301081-1-lee@kernel.org>
References: <20260603163022.3301081-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Tissoires <bentiss@kernel.org>

[ Upstream commit 2c85c61d1332e1e16f020d76951baf167dcb6f7a ]

commit 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing
bogus memset()") enforced the provided data to be at least the size of
the declared buffer in the report descriptor to prevent a buffer
overflow. However, we can try to be smarter by providing both the buffer
size and the data size, meaning that hid_report_raw_event() can make
better decision whether we should plaining reject the buffer (buffer
overflow attempt) or if we can safely memset it to 0 and pass it to the
rest of the stack.

Fixes: 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing bogus memset()")
Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Acked-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Stable-dep-of: 206342541fc8 ("HID: core: introduce hid_safe_input_report()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
(cherry picked from commit 509c2605065004fc4cd86ee50a9350d402785307)
[Lee: Backported to linux-6.12.y and beyond]
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/hid-core.c           | 33 +++++++++++++++++++++++---------
 drivers/hid/hid-gfrm.c           |  4 ++--
 drivers/hid/hid-logitech-hidpp.c |  2 +-
 drivers/hid/hid-multitouch.c     |  2 +-
 drivers/hid/hid-primax.c         |  2 +-
 drivers/hid/hid-vivaldi-common.c |  2 +-
 drivers/hid/wacom_sys.c          |  6 +++---
 drivers/staging/greybus/hid.c    |  2 +-
 include/linux/hid.h              |  4 ++--
 9 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index e3d728d67b53..346c5554da5c 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1986,24 +1986,32 @@ int __hid_request(struct hid_device *hid, struct hid_report *report,
 }
 EXPORT_SYMBOL_GPL(__hid_request);
 
-int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *data, u32 size,
-			 int interrupt)
+int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *data,
+			 size_t bufsize, u32 size, int interrupt)
 {
 	struct hid_report_enum *report_enum = hid->report_enum + type;
 	struct hid_report *report;
 	struct hid_driver *hdrv;
 	int max_buffer_size = HID_MAX_BUFFER_SIZE;
 	u32 rsize, csize = size;
+	size_t bsize = bufsize;
 	u8 *cdata = data;
 	int ret = 0;
 
 	report = hid_get_report(report_enum, data);
 	if (!report)
-		goto out;
+		return 0;
+
+	if (unlikely(bsize < csize)) {
+		hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d vs %ld)\n",
+				     report->id, csize, bsize);
+		return -EINVAL;
+	}
 
 	if (report_enum->numbered) {
 		cdata++;
 		csize--;
+		bsize--;
 	}
 
 	rsize = hid_compute_report_size(report);
@@ -2016,9 +2024,15 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
 	else if (rsize > max_buffer_size)
 		rsize = max_buffer_size;
 
+	if (bsize < rsize) {
+		hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %ld)\n",
+				     report->id, rsize, bsize);
+		return -EINVAL;
+	}
+
 	if (csize < rsize) {
 		dbg_hid("report %d is too short, (%d < %d)\n", report->id,
-				csize, rsize);
+			csize, rsize);
 		memset(cdata + csize, 0, rsize - csize);
 	}
 
@@ -2027,7 +2041,7 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
 	if (hid->claimed & HID_CLAIMED_HIDRAW) {
 		ret = hidraw_report_event(hid, data, size);
 		if (ret)
-			goto out;
+			return ret;
 	}
 
 	if (hid->claimed != HID_CLAIMED_HIDRAW && report->maxfield) {
@@ -2039,7 +2053,7 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
 
 	if (hid->claimed & HID_CLAIMED_INPUT)
 		hidinput_report_event(hid, report);
-out:
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(hid_report_raw_event);
@@ -2055,12 +2069,13 @@ EXPORT_SYMBOL_GPL(hid_report_raw_event);
  *
  * This is data entry for lower layers.
  */
-int hid_input_report(struct hid_device *hid, enum hid_report_type type, u8 *data, u32 size,
-		     int interrupt)
+int hid_input_report(struct hid_device *hid, enum hid_report_type type, u8 *data,
+		     u32 size, int interrupt)
 {
 	struct hid_report_enum *report_enum;
 	struct hid_driver *hdrv;
 	struct hid_report *report;
+	size_t bufsize = size;
 	int ret = 0;
 
 	if (!hid)
@@ -2105,7 +2120,7 @@ int hid_input_report(struct hid_device *hid, enum hid_report_type type, u8 *data
 			goto unlock;
 	}
 
-	ret = hid_report_raw_event(hid, type, data, size, interrupt);
+	ret = hid_report_raw_event(hid, type, data, bufsize, size, interrupt);
 
 unlock:
 	up(&hid->driver_input_lock);
diff --git a/drivers/hid/hid-gfrm.c b/drivers/hid/hid-gfrm.c
index 699186ff2349..d2a56bf92b41 100644
--- a/drivers/hid/hid-gfrm.c
+++ b/drivers/hid/hid-gfrm.c
@@ -66,7 +66,7 @@ static int gfrm_raw_event(struct hid_device *hdev, struct hid_report *report,
 	switch (data[1]) {
 	case GFRM100_SEARCH_KEY_DOWN:
 		ret = hid_report_raw_event(hdev, HID_INPUT_REPORT, search_key_dn,
-					   sizeof(search_key_dn), 1);
+					   sizeof(search_key_dn), sizeof(search_key_dn), 1);
 		break;
 
 	case GFRM100_SEARCH_KEY_AUDIO_DATA:
@@ -74,7 +74,7 @@ static int gfrm_raw_event(struct hid_device *hdev, struct hid_report *report,
 
 	case GFRM100_SEARCH_KEY_UP:
 		ret = hid_report_raw_event(hdev, HID_INPUT_REPORT, search_key_up,
-					   sizeof(search_key_up), 1);
+					   sizeof(search_key_up), sizeof(search_key_up), 1);
 		break;
 
 	default:
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 339a227c457e..113307157a27 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -3692,7 +3692,7 @@ static int hidpp10_consumer_keys_raw_event(struct hidpp_device *hidpp,
 	memcpy(&consumer_report[1], &data[3], 4);
 	/* We are called from atomic context */
 	hid_report_raw_event(hidpp->hid_dev, HID_INPUT_REPORT,
-			     consumer_report, 5, 1);
+			     consumer_report, sizeof(consumer_report), 5, 1);
 
 	return 1;
 }
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 003950894362..6c04eed0a464 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -479,7 +479,7 @@ static void mt_get_feature(struct hid_device *hdev, struct hid_report *report)
 		}
 
 		ret = hid_report_raw_event(hdev, HID_FEATURE_REPORT, buf,
-					   size, 0);
+					   size, size, 0);
 		if (ret)
 			dev_warn(&hdev->dev, "failed to report feature\n");
 	}
diff --git a/drivers/hid/hid-primax.c b/drivers/hid/hid-primax.c
index 1e6413d07cae..16e2a811eda9 100644
--- a/drivers/hid/hid-primax.c
+++ b/drivers/hid/hid-primax.c
@@ -44,7 +44,7 @@ static int px_raw_event(struct hid_device *hid, struct hid_report *report,
 			data[0] |= (1 << (data[idx] - 0xE0));
 			data[idx] = 0;
 		}
-		hid_report_raw_event(hid, HID_INPUT_REPORT, data, size, 0);
+		hid_report_raw_event(hid, HID_INPUT_REPORT, data, size, size, 0);
 		return 1;
 
 	default:	/* unknown report */
diff --git a/drivers/hid/hid-vivaldi-common.c b/drivers/hid/hid-vivaldi-common.c
index b0af2be94895..7fb986615768 100644
--- a/drivers/hid/hid-vivaldi-common.c
+++ b/drivers/hid/hid-vivaldi-common.c
@@ -85,7 +85,7 @@ void vivaldi_feature_mapping(struct hid_device *hdev,
 	}
 
 	ret = hid_report_raw_event(hdev, HID_FEATURE_REPORT, report_data,
-				   report_len, 0);
+				   report_len, report_len, 0);
 	if (ret) {
 		dev_warn(&hdev->dev, "failed to report feature %d\n",
 			 field->report->id);
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 52011503ff3b..52b7f474d866 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -74,7 +74,7 @@ static void wacom_wac_queue_flush(struct hid_device *hdev,
 		int err;
 
 		size = kfifo_out(fifo, buf, sizeof(buf));
-		err = hid_report_raw_event(hdev, HID_INPUT_REPORT, buf, size, false);
+		err = hid_report_raw_event(hdev, HID_INPUT_REPORT, buf, size, size, false);
 		if (err) {
 			hid_warn(hdev, "%s: unable to flush event due to error %d\n",
 				 __func__, err);
@@ -319,7 +319,7 @@ static void wacom_feature_mapping(struct hid_device *hdev,
 					       data, n, WAC_CMD_RETRIES);
 			if (ret == n && features->type == HID_GENERIC) {
 				ret = hid_report_raw_event(hdev,
-					HID_FEATURE_REPORT, data, n, 0);
+					HID_FEATURE_REPORT, data, n, n, 0);
 			} else if (ret == 2 && features->type != HID_GENERIC) {
 				features->touch_max = data[1];
 			} else {
@@ -380,7 +380,7 @@ static void wacom_feature_mapping(struct hid_device *hdev,
 					data, n, WAC_CMD_RETRIES);
 		if (ret == n) {
 			ret = hid_report_raw_event(hdev, HID_FEATURE_REPORT,
-						   data, n, 0);
+						   data, n, n, 0);
 		} else {
 			hid_warn(hdev, "%s: could not retrieve sensor offsets\n",
 				 __func__);
diff --git a/drivers/staging/greybus/hid.c b/drivers/staging/greybus/hid.c
index 15335c38cb26..e761411ccf64 100644
--- a/drivers/staging/greybus/hid.c
+++ b/drivers/staging/greybus/hid.c
@@ -201,7 +201,7 @@ static void gb_hid_init_report(struct gb_hid *ghid, struct hid_report *report)
 	 * we just need to setup the input fields, so using
 	 * hid_report_raw_event is safe.
 	 */
-	hid_report_raw_event(ghid->hid, report->type, ghid->inbuf, size, 1);
+	hid_report_raw_event(ghid->hid, report->type, ghid->inbuf, ghid->bufsize, size, 1);
 }
 
 static void gb_hid_init_reports(struct gb_hid *ghid)
diff --git a/include/linux/hid.h b/include/linux/hid.h
index f4bdaf1b8f41..a9857fdfc327 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -1205,8 +1205,8 @@ static inline u32 hid_report_len(struct hid_report *report)
 	return DIV_ROUND_UP(report->size, 8) + (report->id > 0);
 }
 
-int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *data, u32 size,
-			 int interrupt);
+int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *data,
+			 size_t bufsize, u32 size, int interrupt);
 
 /* HID quirks API */
 unsigned long hid_lookup_quirk(const struct hid_device *hdev);
-- 
2.54.0.1032.g2f8565e1d1-goog

