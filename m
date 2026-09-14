Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B381F4176
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 22:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789426400; cv=none; b=nvVw3/Rqnbia7rT/ZqPLEldDOREf1Q6SF7UHGUA7v+2i3joou59YvllZ+MLwOoPh2XMTjnlcRiJJhui2Lx0VJnHSltsm9k5MpBto/9J3xa4Fo/6MsYFCP06WgmQqd9MeJSRjVqNRPr1tc8AgKGouvobK7DUN0Z5F19apgOXOX0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789426400; c=relaxed/simple;
	bh=0jdbcgi1ucObaWyrq260b9mGv8DVXuvEllXpVv7pX28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZSfNB5ScCUqPq+BwB+RX5Fn7RZGgMNWQbbbedl1gZ8Fvki8bTj0F1GfFBIafiOrHW5DceLo9lKDm8pMYetvGbz9nbMXYFBcwtWNMPaW6buQI0tDqpoBeydw/7MTjU1hmqrII9wdf6WUbK/tbKB5xqhXJsocegvzYppMJ8UnDygg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvOA9TOK; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvOA9TOK"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4c3304833so1961616a12.3
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 15:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789426396; x=1790031196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nkBmBi2M3bokC0woUyxYsBDQw2qjDISAFTNktCCOhv4=;
        b=mvOA9TOKWN3eiYeqor4FiDATUPvX0/ncCeigFm4H8jYfCAthYQwQ1ZhYK8M/32UlYz
         Xf4TzMmVHt/EEolpPmyN2eVM8dfuvTXkYUb5IL8zFQyF61vN2X559SjcnyW5fymO0tYd
         8o/q+42chTrVI+Rm1t+V3WRXw1hszJlkYozVhP7VO+Cira3GekGWC4mmz/DIly3MkswX
         K41QyMPbM8VVQp0yAeN/fqNGj4Ufljd3wx4t14Y+WSHbeiv+XcAc7gKiU0K10kIrVMvG
         TK4YaoIlhxF9qe9d2ZWwjc0aoOBvcoO8pvoegvHSnQZSZy1//ti607n9T1M2u46DOM2r
         VlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789426396; x=1790031196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nkBmBi2M3bokC0woUyxYsBDQw2qjDISAFTNktCCOhv4=;
        b=wH6UWSoyAtjlK4V12j0LgAkgy9kr0Vr2qo+e2BWJ2IM2o1kmwZXrk8IToIkNafdbd3
         oQ4Gws7eZm8iwICr38Q+VYUdEfQ3in21R6/JI+Rt3N3gnxI3OPadjQzSRSuiE0i9DU1O
         rGQ/SNlrZOCA7XF8GHz/rcjg2pkjtqbXhtUcV4T8zWuE7f8i/TflxmaKIW+gSW0rmM97
         HkFQ9uQ198Ya148/oXn2GuqmwvWf82NTCmrMzHRt23EKykaTIjDBQAnq3tE/7SmL/QdW
         TO7eX2YqPnnfENXHm+NFLZ3mrqVEoXi6DxT2xkcXljm+AtOociKXAnJjNAylWgPoWiiy
         GGag==
X-Forwarded-Encrypted: i=1; AKwUvBw98kiSjhlhVSyAZy4HXQx1lEZZIptfXln8gGIygEqOjOVmu7pAErKpYHLkHQBY0b1X9QzyxaE=@vger.kernel.org
X-Gm-Message-State: AFuF++kLdOQ2M3nCpqmAbB/yvmpaY+vRMpisAeY3b4GgaiUGTjPl7Kiy
	xslfyEEIQ+LJ/1MVNlS3tq6vqKLl8uNpFqtFxsfHCIgRv/pDXAGExvN3
X-Gm-Gg: AYBFou0cSRC9mCxMlQiLeTiAlSMxkKyiSERF00JaL1knUF2g/lW4roXFbasAQCmr8hQ
	S2NmgHTnpW7WJQjF2H3cR8aNp/RKO/btQq69gqkcQszcWIBroA96E/M5Ax9Nbf8GgXwJQAy6Pk0
	tDX7FwA/d8MdiDzd/usvG9nyJbhUovwwpI8uAu/S+k+DqOcasz6TSbqkB3IffIPa0BiCLPGorG+
	IxM4Pn7HPbOwwOEzWD9KCJpk70+aQ74bR0+kmBRH4Y1pQZ0MtzBklPZZNemTfPEEDgAcm6nWV1r
	GVkLsLcdN0IQJdRxLXFwwUWAqUGacHkmFFLXEQbNWIg28YL7lsbYVrCWGehysXEa3y989LMx3Ok
	j5CJIzyqoWMeEA+HzSXrxSr+4dij7dgxyqsOqfjXeZkRNPtEqOUsojFDULrqS4CVdBR4cN6cYdk
	iIijWRP1zXw4YTeHmvPA+0ieDfGiCzHKLAdQhm5eL85WR5pSQJDc/YVpm00lYa5VGlChpSpTtkz
	4E9a+Sd4sUss9G6CcklCj8LAUAd71URjn5lcxs7z4kuaT8HJvS2
X-Received: by 2002:a05:6a20:72a6:b0:3d3:ae40:51e4 with SMTP id adf61e73a8af0-3db405e637fmr8959185637.24.1789426396151;
        Mon, 14 Sep 2026 15:53:16 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bbeb053a5sm14924296eec.27.2026.09.14.15.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 15:53:15 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	stable@vger.kernel.org
Subject: [PATCH 08/10] HID: hid-lenovo-go-s: Reorganize and rename hid_gos_cfg
Date: Mon, 14 Sep 2026 15:53:01 -0700
Message-ID: <20260914225303.868569-9-derekjohn.clark@gmail.com>
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

Renames hid_gos_cfg struct to gos_cfg_drvdata in preparation for later
fixes.

This is a prerequisite for later fixes. No functional change intended.

Fixes: a23f3497bf208c59ad ("HID: hid-lenovo-go-s: Add Lenovo Legion Go S Series HID Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-lenovo-go-s.c | 39 ++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index f1a0bcfcdb71..e5c4104a3adb 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -32,36 +32,41 @@
 #define GO_S_CFG_INTF_IN	0x84
 #define GO_S_PACKET_SIZE	64
 
-static struct hid_gos_cfg {
-	struct delayed_work gos_cfg_setup;
+static struct gos_cfg_drvdata {
+	/* MCU General Variables */
 	struct completion send_cmd_complete;
-	struct led_classdev *led_cdev;
+	struct delayed_work gos_cfg_setup;
 	struct hid_device *hdev;
 	bool orphan_ack_pending;
 	struct mutex cfg_mutex; /*ensure single synchronous output report*/
-	bool gp_registered;
-	bool rgb_registered;
 	int cmd_status;
+
+	/* Gamepad Variables */
 	u8 gp_auto_sleep_time;
-	u8 gp_dpad_mode;
-	u8 gp_mode;
-	u8 gp_poll_rate;
-	u8 imu_bypass_en;
 	u8 imu_manufacturer;
+	bool gp_registered;
+	u8 tp_windows_mode;
+	u8 tp_manufacturer;
+	u8 tp_linux_mode;
+	u8 imu_bypass_en;
 	u8 imu_sensor_en;
+	u8 gp_dpad_mode;
+	u8 gp_poll_rate;
 	u8 mcu_id[12];
 	u8 mouse_step;
+	u8 tp_version;
+	u8 gp_mode;
 	u8 os_mode;
-	u8 rgb_effect;
-	u8 rgb_en;
-	u8 rgb_mode;
+	u8 tp_en;
+
+	/* RGB Variables */
+	struct led_classdev *led_cdev;
+	bool rgb_registered;
 	u8 rgb_profile;
+	u8 rgb_effect;
 	u8 rgb_speed;
-	u8 tp_en;
-	u8 tp_linux_mode;
-	u8 tp_windows_mode;
-	u8 tp_version;
-	u8 tp_manufacturer;
+	u8 rgb_mode;
+	u8 rgb_en;
 } drvdata;
 
 struct gos_cfg_attr {
-- 
2.55.0

