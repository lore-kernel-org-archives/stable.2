Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683E933A9F8
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 13:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023528; cv=none; b=TS4xBAePBi8Jpd+tZDq8QPaLaq5Z/jbRz4A2vdgITtCBNAENtTigB4/1MUw9MFymCjEGume+4VKgZthUig/BzFHVrC67BYn8v98CCFAlEPUjJptwAKTeT10T+HmuRZAmY74mWImYNRMsEsCUDfA+B9JU0P02zhrHa0lCphnc0Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023528; c=relaxed/simple;
	bh=SJ0CQsymO4jcDTqokRj2XeROVTcXNVQ5WcS9OVMXblk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cJqoybC8YXNRGA4tPBHe2yIygdnIrurCmPPhGIZnDzHod4GrpS/plOUe1qei3A2kqYSdBsJxEpX6hBeWOw2Oyy8ZAE5T8IuJbmnNK2PiEma3cvwv13+KUWYDao5I4CW/NgoLsaSn7FX9vfO4tH/x3Ihk6fPGunb7LyYXptU6VtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6TMgMmH; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6TMgMmH"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-848743155bcso1115636b3a.0
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 06:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786023526; x=1786628326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n8znQjoP1MnTnyeT/KthZOHx57cQrDSiKl3hZQXMu3I=;
        b=T6TMgMmHyyD8gZvlgw4sAdYgo2aZk5GWe/Uuw5WBOZYDlskC4OlTN78QcGvFdhaCyf
         4o/qpqW13FPKhTCa/WCcZE+lqo5iiHOtZPFdxxeBMVrSeFPLZVp/nmPSE1xlj8dAsY7S
         yPzbVl7kOmvfZQnXBYa9MW01NKn6CyPkuCm3fTpQQU0p3VWmtLm+IC7vMl6VlJLtRlTJ
         PBhKkcKfjrf0UA7AA9LQ12xkVrDNWZVKP2TthMQQxQ8p1cOB4ufUjd6tK3qme7Jy60Ut
         g4jwQ+4/TAl99UrY1C3eTJjtjsQjSrwav7g5Qbs/ipFWn6Ukx3lJ4nA0dT1md5yToBCw
         jh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786023526; x=1786628326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n8znQjoP1MnTnyeT/KthZOHx57cQrDSiKl3hZQXMu3I=;
        b=kbZClZq51ivOBnmIx8zb+uAfk73lF5ukIxZGmGUnbLc3e7zAhbGkDjJIrkyRQD4Pvn
         xNbwHTWcyJmdQfjiaZLuhQZD8XKzeldhl/CFThVpNFnliuJorC1z1VY8XTszhMpY2yLG
         iMQ3cjzbXvfxe5pRZLRqAMcqO07q5+Hb/neCKueJP7snsnrR5kmR+Fyx3FE46K97Csl4
         iQL97wspKqmg2bprWO0qUoJzlr4bpMw5fXDRyv4OTO/Fhu3PDDn9NJ4jOAO99ETIMIjR
         G8kKeIpjEQSLme24wlpXFTdu2EBfdiJexl2a7ULlISyKey7bbXQtx8trmiYU/dCZbwgz
         dMDg==
X-Forwarded-Encrypted: i=1; AHgh+RoSVNWHGAnZFKacW8X94Da8MsHk7LUOte91OU3QYLxNx1K593hJeLdvMje2h559vCMLMEZT8uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqL8Wc+xGiohdFwNO9okJeHHO1Ev+zqCdFt1p9ntLWGG56NBxh
	PWfLOknQA5U5ySoNr9BaOAhaOrbGPMw1scE4t/wg3bIH6kwYtt+segA0
X-Gm-Gg: AR+sD13CWXLnt+PgttIbUS4UxIorNr/RiGQVldFwc/mnG4mseUKc/NxV5ED0ewpp2+I
	mMLi2qL/fHWFATby5anmgH8rgPuVoybs6ranBjgIsVlA1ovk7nk8JM1cVEJK9+9vvlAbATDabvR
	+o3oA+nfyTdvqo7qdjs2d3HvXRUrzhtB44MxjONZUcJlcRvDJdDwRijctUC5s2M/rfXNr28W6aU
	8jPzHm7h8Xd851w6oWl8utDaKSFrTvwRxcU+eB1fdx0BubnwEtAeBmFaLnqBs0pDI5FI7sUgO5+
	9AQYePyPAZEte8GIRlWX6/iENYy7QS8owPoggHiLa+QeH723XdzfR9Fl3gdyYcb8OJbqriKBGEh
	ssQvq+BsuXd1TJM5tyVndxRSJrynFI9cErE4PizBmobK0gYoDSY1bU007hNkQ9pIfCG1TQ6wOMn
	oGQtWHPePfgePvax/l/gppl8AmODtb1vivg/K0CYCUWmbHytAnapX+/GjrMAXVZEWBhz9XSB6PR
	W6R4Qotj6iH5216OO2Pfmq6OL4dUr0ZLgMJEtcw8gehWUD798bJGg==
X-Received: by 2002:a05:6a00:8019:b0:848:4a48:9f9f with SMTP id d2e1a72fcca58-84f4fee000fmr1925189b3a.34.1786023525452;
        Thu, 06 Aug 2026 06:38:45 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f453b0cfbsm1463682b3a.19.2026.08.06.06.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 06:38:44 -0700 (PDT)
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
Subject: [PATCH] HID: intel-thc-hid: intel-quickspi: bound GET_REPORT response to the caller buffer
Date: Thu,  6 Aug 2026 22:38:38 +0900
Message-ID: <20260806133838.3378362-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
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
 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c  | 2 +-
 .../hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c | 9 ++++++++-
 .../hid/intel-thc-hid/intel-quickspi/quickspi-protocol.h | 2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)

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
index cb19057f1191..9c4fce09729d 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
@@ -342,7 +342,8 @@ int reset_tic(struct quickspi_device *qsdev)
 }
 
 int quickspi_get_report(struct quickspi_device *qsdev,
-			u8 report_type, unsigned int report_id, void *buf)
+			u8 report_type, unsigned int report_id, void *buf,
+			u32 buf_len)
 {
 	int rep_type;
 	int ret;
@@ -372,6 +373,12 @@ int quickspi_get_report(struct quickspi_device *qsdev,
 	}
 	qsdev->get_report_cmpl = false;
 
+	if (qsdev->report_len > buf_len) {
+		dev_err_once(qsdev->dev, "Get report response too big, %u vs %u\n",
+			     qsdev->report_len, buf_len);
+		return -EINVAL;
+	}
+
 	memcpy(buf, qsdev->report_buf, qsdev->report_len);
 
 	return qsdev->report_len;
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

