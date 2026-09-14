Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14FA3AE1A9
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 22:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789426392; cv=none; b=JhaMnxMSIeeUR/SnADXnWNnuXYIxrhw5DAneyOhBi5EtuvoHnwTR/guwW2QwzHCY36Ggp2vGpNk2HHTJu9CF4wnwi4hkqa6kAR16f7XU67K6TwRxbwaPXEt9RzCc1yxkEufSysA3F11Q1XeCF8Pt9sagN5oGTTP7snxatP1ybB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789426392; c=relaxed/simple;
	bh=B5NcsJqiM6ca6zoKCCSiRnmiGiK51EUO/f+42QeBqzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNKsjMWR+Ap+VsSXwOog+WAF0TOH+2wZSJ17UeW+cm4uGuvZ6AmdNij6/5OussXJyNrY2+iLg5IQG7yRUh6JU0Vwzk03ARMcBWO9GQ9ADPrkY4Z4f//uENmtfn9ysJ8xM18Nrxi1dZxek5f9n9fyAdXKmi9upIjl6FxyrfyMtg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPRZmjAZ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPRZmjAZ"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc147d86bebso420441a12.0
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 15:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789426390; x=1790031190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cket7DPZv1j5YnyOIveBa4NpPNYaScJjvnuFzxjWh88=;
        b=fPRZmjAZsPsmNpwQY3WlqF6D4LWwNE4X1Z3K4VbTZwv/KOC1Gh2wqMK9IE8jVWZTaV
         izthCVBd9+kVlO+nuylxmOYUxuZkWX//HIAs/pJpXAXHXy6VnuGJ1MM8i4g+tzrelmv0
         2natDsx+Dl2kL8YdNhVmxvGVt8uSHFIgDVT3OPKT2iO15alDvYNhPZSoInE0vG+66V0m
         lBCIChItBTP4CzfG4mBO87o/3H85VHNjXxkxTnBtpPy1mhxOp1c1hZIzXaC7ACKQGRZt
         aurg6TgmvfDG7U7z/a5C6Z4qCHCBtbmicep1LOXimuaoCyO9MAoPvFKkNYvhEQO9I9tR
         rcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789426390; x=1790031190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cket7DPZv1j5YnyOIveBa4NpPNYaScJjvnuFzxjWh88=;
        b=XxWa/E2H+jvR+ocCNCsfd5A0nEqLc+pwREnA8BPUrBi4qrdSgd46Ta7HyNF7ltnEPl
         SRErZgInSm/oEapCgVijs+rQmb46lihE2P2zDYxMsS1Za3E5tmcVD4g5MZVn2LAdSaxl
         ns5GrHt3m958b0qSS6thBolirfG7xQ8Z2oP9HGwOIledx068SqupWVJw201jxsKPJvsW
         X+ubYOH5ZTbfFz2G3vPDcvtW9UiSCynmcMBUsvYFXHaTi0KwA3r/2SJse54Y0l3vHtVQ
         cSr0uy70vKDl5A+2xX8UziXmYkyjol+vK5KPfiwQZUW5YK/LWtlbLI3BewZ4J/wUHliP
         iyAg==
X-Forwarded-Encrypted: i=1; AKwUvBxUQAKsZEPN7imb3WQWG02m0Z8vqs3o/pjFM23lurlLDpkt9b5KCdgRlADEUcUBfWVyxz5m5DY=@vger.kernel.org
X-Gm-Message-State: AFuF++mrif63mjEvt/XW90WiUXL3Sj79D+EOWnC8Z9kvt7AbGZCFlSjQ
	PRvxcILi4mAJ1vO0dbqQeX119Mtb7Af/O4tOEdPPHe06ejEVW1B+8dc4
X-Gm-Gg: AYBFou2/rptqcSaSiflcPu/sdgG7tGAXEajtcQFM6jjUTzegGTpwMo1zcMgmbuJhRj9
	UQAbJCaRA0snH27hcpWwEqkGjxyBir1jxxVo/pBxQL/59bXhno4zIVDdxfifhcsNS2tlwEthDEu
	c8L9vVDi5qarT1YWyEFyQa+f95RJIy3KZM3InlMJRoyxnuJPcfLJecQ35m99zsoFMNzkZteggS0
	gf94+lVe0BfnmW0ucMRfAR8BzmJK05Q2eDyQErRwCa4rtnpc8b8F+HZ26Q/ORLhisMo2szYs3DR
	yadAgVpgQGaOcTfJEw8uBkMdyff79ONmffQVYQdXKZOj2/OKPO/dOzBd5vfSlqxaXmf7qEAFpuR
	+uaPFNEbDZALBsi3qe1NYhRNNSwBXB+EW7IYisvKf0aslm7uIJdXoDfG0en5WT38LElpnWm9pWJ
	maknl0QSxZlWy2Z7Sxcyw12BeBmLoB9qKCrYmbHBL176KsCCp4HYMEcOb5r1vrH3ssCF/7Pzggx
	Lu6MUBCw2yapdKw+ed+wE6FYu+wjfa7/ekTszvhAuc7C/LQJ+2L
X-Received: by 2002:a05:6a20:4310:b0:3d3:aed2:6f20 with SMTP id adf61e73a8af0-3db50019fa8mr1791026637.20.1789426389991;
        Mon, 14 Sep 2026 15:53:09 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bbeb053a5sm14924296eec.27.2026.09.14.15.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 15:53:09 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	stable@vger.kernel.org
Subject: [PATCH 01/10] HID: hid-lenovo-go-s: Return ret instead of 0 in mcu_property_out()
Date: Mon, 14 Sep 2026 15:52:54 -0700
Message-ID: <20260914225303.868569-2-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914225303.868569-1-derekjohn.clark@gmail.com>
References: <20260914225303.868569-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently mcu_property_out() blanket returns 0, discarding the ret
value and any errors with it. Wait completion returns a positive value
when it is not timed out, which would error on all successes, so if it
is positive return the ret value from the raw event handler. Only if
it is 0 set it to -EBUSY, otherwise pass the actual error.

Fixes: a23f3497bf208c59ad ("HID: hid-lenovo-go-s: Add Lenovo Legion Go S Series HID Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-lenovo-go-s.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index a72f7f748cb5..68301d4c762a 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -38,6 +38,7 @@ static struct hid_gos_cfg {
 	struct led_classdev *led_cdev;
 	struct hid_device *hdev;
 	struct mutex cfg_mutex; /*ensure single synchronous output report*/
+	int cmd_status;
 	u8 gp_auto_sleep_time;
 	u8 gp_dpad_mode;
 	u8 gp_mode;
@@ -435,7 +436,9 @@ static int hid_gos_raw_event(struct hid_device *hdev, struct hid_report *report,
 	dev_dbg(&hdev->dev, "Rx data as raw input report: [%*ph]\n",
 		GO_S_PACKET_SIZE, data);
 
+	drvdata.cmd_status = ret;
 	complete(&drvdata.send_cmd_complete);
+
 	return ret;
 }
 
@@ -474,12 +477,10 @@ static int mcu_property_out(struct hid_device *hdev, u8 command, u8 index,
 	timeout = (command == GET_PL_TEST) ? 200 : 5;
 	ret = wait_for_completion_interruptible_timeout(&drvdata.send_cmd_complete,
 							msecs_to_jiffies(timeout));
-
-	if (ret == 0) /* timeout occurred */
-		ret = -EBUSY;
+	ret = ret > 0 ? drvdata.cmd_status : ret ?: -EBUSY;
 
 	reinit_completion(&drvdata.send_cmd_complete);
-	return 0;
+	return ret;
 }
 
 static ssize_t gamepad_property_store(struct device *dev,
-- 
2.55.0

