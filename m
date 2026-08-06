Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11EC3914E9
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 14:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786028195; cv=none; b=OQfkQtC+pbTAkwwyu3u7KiU7ZykI6stNXcq/QqF6RM5406I+Ja/pQsDxXJp75aOL0rgpCjyUzfXdo9eel3DKvbbUx53MEZXZnF0dZShbjoEqpzpeo38lpPAPGzTwudJUoBdQOvSSnZjoa/46e159B32pfqe9hh0PNCOsZ1PsDx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786028195; c=relaxed/simple;
	bh=r/Vkb1+BMlYNY1tJcqhwNh3VEVI3USzDIKSso9O7Uts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHc2ILyVtOTFX9J2NqoKxWx06VKBbfIVjvkVtd1LhKnIG/sSapVOMVAO7C/tpaCTGqC26HyHqEHYtOtO7YN/mU26bCYSdvR7ey4NuZoFyYJjK2kOFDrzGbtNpaR2ylRO9cpMuzqgpRQeHuSg276sQN6cZYg6DpvNXNHWrgStTi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7eOxczH; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7eOxczH"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso2041332a91.3
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 07:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786028192; x=1786632992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RnK5eS+Q5x9auDCqli6J0bfpL+fgyXWFA73Li6vz2dc=;
        b=V7eOxczHA2s8KSscwV+JGqXuxLnlwH5Le0ehkTRTXS8vwIxLfMrQXYexRJIni50CWv
         2/kVIk9ht+GkXBnQKvpa1IAQw8FEIIZk6VSkB347QMbvSksC4VmdkI5xsfoKtWygtHQr
         WCwvAmtAz7m5OhAQBsuW8DUdBYRlmtSM9iAzV71HTTd5OLXNqW8mHaKTT7dGOOT/H8PC
         +TBlIOr9CkT/110X2XkBsuD8QJoNC0mo0pfUoomXqlqmXafz93TZg3bOWe9wfYBsTM+H
         lUc8CFp1V6px+6nToEOiPaDoEnbPiKJTytp9jmJmYnDWcR5fpA0wek36HTqEKj8wYWaT
         s5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786028192; x=1786632992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RnK5eS+Q5x9auDCqli6J0bfpL+fgyXWFA73Li6vz2dc=;
        b=rmtCss0/8X4w3JBmGlbiGQegGs4jHC/Y8O8oLbs3TI+gE2dixgY1OBZcvUGRXqj6TD
         iG2LEAo6ps9xaqK3pwz7UGFJmjjwdHcjHg+HsTk1wgdhHmf+Oe3E+WGLr8KeCNeCky+J
         3ag6Oa84cYrhE32I5wxv5gNMG7PHJCbloY2G8/CwmDyj6XUA9NCbHJdLVizHVp3rBGHS
         gGWecmYhx+epqRi9AuF1oUjXoIo7YVWN6t3+efKdV8xbDA8ZXKk99h0TWKJVpuHDK/GS
         GLjnu3dkUTqQiO9/TaO3+q1j1GElPup92fz+H6g7M3xWcWEYExi1dv9niH/bGAF4sq3Q
         gRpg==
X-Forwarded-Encrypted: i=1; AHgh+Rr3drQ92drHQX+kg9o9SANRbcY486A+6godpw+4a85eiv6WxqFIIOBKJ6Voe3hWUk2ARWf9KvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjkXOwMVVLeErZJz1KsLwyMBsZc6Na7FpUnAHh+5EEKXLnN/v6
	IQa4h+tpzwae36kG9t5Njnxsc8Etl22cA0rXz3tEtVG/tpZXOFNSYgDww9LDyFeI
X-Gm-Gg: AR+sD10Lh5qa/GZBrTDRoPdHt+iELYPzpFb17Pp6ChaufmtwWLVXHXN5W/zRH9rMa69
	3f63Xuc+hSb9Hpdc1AmCcSmXawvRxKY2fjIZ2xU/Xa+vbAirva+w1kcUA93aNQHCWbc8WCb1YQ7
	ipEGjlMEQvA+v3DG6bt3Z5lBCfbl9e2xdejguScwa9/MFrdmSeSmZMWnusos136PvG1FQZjPYuo
	RuKzeI7EJ2urab/5qlvPaf2itX6yjqsHDyf671WNn+HNPZk+pTWYK2bZxOJFR3ofCLFznVBZIuz
	qn6aJ/EnQecAsE63Hfr7g7VdICVlEdX6CHGfCR+5NHBc4KJ5fRdbNVCF3Q2jZJWuTgPQF5GWBVL
	5Xv+MOA6u2CiLlsM0LxuEQSk4LijcGoRsMGhUFRYX1tXg01E3UN24cyCbQe53JvrMzqpD0x8jw7
	FhI9OvRxopseo8XzJVnerajFZ5IbAyB898QDQomeKWVhkWqkmHsjzXLlgR5rn0fIjVVnZrfkZA1
	SkJZ/yBFTeOxYL8w7HrSYabXI7+xpKPV+djBYQfGiGOqBqsr8hdaAKPwe3G+QhI
X-Received: by 2002:a17:90a:c106:b0:38e:250b:122f with SMTP id 98e67ed59e1d1-3909d8d5993mr2367502a91.16.1786028192196;
        Thu, 06 Aug 2026 07:56:32 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3903d183e66sm3069178a91.0.2026.08.06.07.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 07:56:31 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>,
	Sashiko AI <sashiko-bot@kernel.org>
Subject: [PATCH v3] HID: intel-thc-hid: intel-quickspi: bound GET_REPORT response to the caller buffer
Date: Thu,  6 Aug 2026 23:56:19 +0900
Message-ID: <20260806145619.3386809-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806142321.3383353-1-sammiee5311@gmail.com>
References: <20260806142321.3383353-1-sammiee5311@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

quickspi_hid_raw_request() receives the caller's buffer length in len, but
quickspi_get_report() never sees it and copies the whole device-supplied
response into buf regardless:

    memcpy(buf, qsdev->report_buf, qsdev->report_len);

qsdev->report_len comes from the input report the touch controller returns,
while buf is sized to whatever the caller asked hidraw for through
HIDIOCGFEATURE or HIDIOCGINPUT.  A response larger than that overflows buf
with device-controlled content.

The intel-quicki2c sibling already passes the caller length down to
quicki2c_get_report() and validates the response against it before the
copy.  Do the same here.

Fixes: 4138f21115ae ("HID: intel-thc-hid: intel-quickspi: Complete THC QuickSPI driver")
Suggested-by: Sashiko AI <sashiko-bot@kernel.org>
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
v3: added READ_ONCE() around the qsdev->report_len read the v2 bound uses -
    quickspi_handle_input_data() writes this field from IRQ context with no
    locking, so per kernel convention for a lockless shared read it needs
    READ_ONCE() regardless of how many times the value is used afterward.
    Raised by the Sashiko AI review of v2.  No other change.

v2: fixed a Time-of-Check-to-Time-of-Use race the Sashiko AI review of v1
    pointed out - the new bound read qsdev->report_len once for the check
    and again for the memcpy, so a concurrent update between the two could
    have overflowed buf with the checked-against-a-smaller-value length.
    Read it once into a local and use that for both.

v1: https://lore.kernel.org/all/20260806133838.3378362-1-sammiee5311@gmail.com/

 .../intel-thc-hid/intel-quickspi/quickspi-hid.c  |  2 +-
 .../intel-quickspi/quickspi-protocol.c           | 16 +++++++++++++---
 .../intel-quickspi/quickspi-protocol.h           |  2 +-
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c
index 91d5807b4a83..a60a0a7f16aa 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c
@@ -61,7 +61,7 @@ static int quickspi_hid_raw_request(struct hid_device *hid,
 
 	switch (reqtype) {
 	case HID_REQ_GET_REPORT:
-		ret = quickspi_get_report(qsdev, rtype, reportnum, buf);
+		ret = quickspi_get_report(qsdev, rtype, reportnum, buf, len);
 		break;
 	case HID_REQ_SET_REPORT:
 		ret = quickspi_set_report(qsdev, rtype, reportnum, buf, len);
diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
index cb19057f1191..9dacfdf7aff6 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
@@ -342,10 +342,12 @@ int reset_tic(struct quickspi_device *qsdev)
 }
 
 int quickspi_get_report(struct quickspi_device *qsdev,
-			u8 report_type, unsigned int report_id, void *buf)
+			u8 report_type, unsigned int report_id, void *buf,
+			u32 buf_len)
 {
 	int rep_type;
 	int ret;
+	u32 report_len;
 
 	if (report_type == HID_INPUT_REPORT) {
 		rep_type = GET_INPUT_REPORT;
@@ -372,9 +374,17 @@ int quickspi_get_report(struct quickspi_device *qsdev,
 	}
 	qsdev->get_report_cmpl = false;
 
-	memcpy(buf, qsdev->report_buf, qsdev->report_len);
+	/* quickspi_handle_input_data() updates this from IRQ context. */
+	report_len = READ_ONCE(qsdev->report_len);
+	if (report_len > buf_len) {
+		dev_err_once(qsdev->dev, "Get report response too big, %u vs %u\n",
+			     report_len, buf_len);
+		return -EINVAL;
+	}
+
+	memcpy(buf, qsdev->report_buf, report_len);
 
-	return qsdev->report_len;
+	return report_len;
 }
 
 int quickspi_set_report(struct quickspi_device *qsdev,
diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.h b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.h
index 775e29c1ed13..8a2338bee808 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.h
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.h
@@ -12,7 +12,7 @@ struct quickspi_device;
 
 void quickspi_handle_input_data(struct quickspi_device *qsdev, u32 buf_len);
 int quickspi_get_report(struct quickspi_device *qsdev, u8 report_type,
-			unsigned int report_id, void *buf);
+			unsigned int report_id, void *buf, u32 buf_len);
 int quickspi_set_report(struct quickspi_device *qsdev, u8 report_type,
 			unsigned int report_id, void *buf, u32 buf_len);
 int quickspi_get_report_descriptor(struct quickspi_device *qsdev);
-- 
2.43.0

