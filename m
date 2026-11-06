Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794000940;
	b=mChTsCofb8sJ9rTIU3djc1Bh0ljq3rShi20RCsmaaa26pyxL+Zjo9mxZq6imRWqPdFdb
	 ZNNjuYMX/gh/hoFpkYopGSvfdvarW20TXGD7xKgux7M9rSpTQXT0ChTVkGZHosWUDuTEb
	 idAilwjrQzaHcbtnexdEEKzG4HKdf21ykBky9ZQz87yMXlynV0tHGqrEgpojweio2CJRT
	 Bkvow1Ni1qPLnzPqT/TyEWbDg+2HdM2RO5XB0qKqpke9aIKn5T6RGvfxMqlapi7cPVJyC
	 I2iDxt7p9TwIGI6B9WmnSKnG1gNJNaV2EgEx77r4WzUCadDLC7FeHRCPJBoAxN9ixFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794000940;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wdxh+aljoFBv60+IjwtRPv+nHnuCCpie0lKl0KHTOho=;
	b=pOwCQS/oz6tR+iu8yFwbFl+JJcIixTogQ1ZKB97cKMPl8H99/DutU9zf4dXG/4dwHry/
	 gTcKWosiaXIyLF0uuW2bc+qlddUpMUxe+iDVnJRea4R/ionDYhF1FL9DACWD/64umeSkz
	 UHVpiMQzcX+FggbSYozCetrrjpg51y1FIBqUG7DvjpzmYh2Rnb3Z7JCgIIbYCfMf6dUq6
	 /Uzg7pOfP6xrPy7PWZaGmQYqr9mj2hxL0miaJUp049UFVMn9GjPjxF+by8g06YS0Qn5x7
	 NDeV9eGU2W5pVrNm3OvKpfLipNdB/0xVDpo9FxwD16cYVdwnRj/Ap0Zqr8ufl2RJSqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gbjcMn5a;
	arc=none smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86680606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 21:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86680606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gbjcMn5a
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b429f71dbeso1129182a12.1
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 13:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794000939; x=1794605739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wdxh+aljoFBv60+IjwtRPv+nHnuCCpie0lKl0KHTOho=;
        b=gbjcMn5aR2wOI66yF8d+3Zdznq6J+xtRck++4A5CylDDKDYFMD1vrtwMjIXwoAMRPV
         7PSHfZM7laJuwt7BTSoG4hK5GtRYoreSBHXcWlz8iwKL/r7Uu52MnMXY3DFwfYz+++Zb
         xgBq+ZQsYZUR450/S94cTt7zKKlZbmAuz8ffMA5RvOpGAPScO3qXhpXLZooh95yq6sRw
         CKM1ybYpMYJP4N8QJT7zS18I8LJMfLiDRTnzEleICPtfBaLVxPkdOg2xUlN0nmcbVuzV
         LIkQI+4Jx5bN2tiTuxUIc4VXa7Qb/xXrc/1xZV7Z+uqC1wAR/YcHSEwrmqdw+mSA8qEy
         7laQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794000939; x=1794605739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wdxh+aljoFBv60+IjwtRPv+nHnuCCpie0lKl0KHTOho=;
        b=dJmrJ6b4bzN6Bq61kA9w//hzV0ZYhMuWa1MC1vx7XrUxQ3qJoHhSxGjfel4o4dtvn/
         axnulox3HT1U2kB5qNI0z10Me/jnNeLln8P0gH8p20vrUVO7fjWETD9mbrkfovL+8qc6
         2h0PJaA4mF/3DatTCQUn/91XUQZZgCGakBIAGB8fXeW5DkcV6S98akuzQsW0efsFEgdm
         YZusabgNXJPlOtorGUJ7HB27ojI3WiV+RerX8wVz5h6HzDJ72wMJl49aXhlJD3ikXwJ+
         TCo9zcfWvVhYZG+UNubi4PgaJi2j0NNGMIV1DqrqfiWCh3TyH+17ybFDWhsv8nFXLZ20
         VRDQ==
X-Forwarded-Encrypted: i=1; AL+hErFq+Vg4sdHKssLiciNHNSSKA3m7OuMv17GGtFrViy16iLcftUPwMFavyfM95yVrMIvo5IRvjTA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9NLdbJ6Fu1KKhgfVPwCOgDG+zIpZQYg1wqJtaAlL6wSMAiyKF/
	+NH/2No2bTzLtpk9EATl4yOEr8slWGwdmEZBbMo5LtNg5J9o3kpcGjAP
X-Gm-Gg: AYBFou3Pa9C/kr9euxbyMLsEmMzAaGH9bLeXBMAeohLfbJ6ikwqMEPw8ptzuJvFW8w5
	1sQbk+d1kkx0kAS52gYGZqECU0FkO75Ubf8wUFFPjX+37NAiDURBq2vnImp3gpcfb49ozvwtLE6
	gmc2KHuFcP2C/lslQVZ/vTuMjpTf5MVtDxp6TDtmQ2hpbGLqwUm2y4MwQMexBHNpb7Abn62wRai
	s2yPo4wDVCrxShwUINNQL6d11hBiZ2UPZvMHPtTQcCSuvXwsZki20VPWlvcPbf9cPHquTnK8jeK
	aXkURYSHYIUWWVIdA4X+Cg9nEELv2FYs5Ho8rjOUayG1TuobpZaZyLA8gAaFxTCyYN7chE2ovNU
	t8iW6vnKhn0p0sQZSovInbOZpPIkNqcaoydrq8rfzxom8XPTYs+wEtfdK7qJI7dm/+tkcqctsZG
	4iA8mcdgNRXSbe10k+7/+v2fm9GsiirD3LSeC/bInV4jHFqAgL+A/hyhP9WQy56496k1ZayyA/Y
	avOiDSRek0t4CrSu45jCXEVTDxOnUm8BtJQnkg7mzCzocrTFyih2v7LdKi14hcJilQ8maDnqWgy
	AT5yCwudBjCJpwYmn7Kk5Q==
X-Received: by 2002:a05:6402:28cc:b0:6b4:5a98:2628 with SMTP id 4fb4d7f45d1cf-6b5977d5c9bmr2608295a12.23.1794000938821;
        Fri, 06 Nov 2026 13:35:38 -0800 (PST)
Received: from beelink ([186.247.78.219])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b664ad2cd6sm1118836a12.7.2026.11.06.13.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 13:35:36 -0800 (PST)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Jason Gerecke <killertofu@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] HID: wacom: validate battery range before scaling
Date: Fri,  6 Nov 2026 18:35:26 -0300
Message-ID: <20261106213526.3393779-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CANRwn3Tt0VguzG=_azEZAP8vfxr0BbyWj=Nu-R3a0TA1nNGqog@mail.gmail.com>
References: <CANRwn3Tt0VguzG=_azEZAP8vfxr0BbyWj=Nu-R3a0TA1nNGqog@mail.gmail.com>
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

Battery events divide by the difference between the logical maximum
and minimum without validating the range.  A malformed HID descriptor
with equal limits can therefore trigger a divide-by-zero exception.

Move percentage conversion to a helper that rejects non-positive
ranges and accounts for a nonzero logical minimum.  Clamp the result
to [0, 100] so that hardware whose ADC occasionally reports slightly
beyond its declared limits still registers its battery and updates
capacity normally.

Fixes: 37d160193834 ("HID: wacom: generic: Scale battery capacity measurements to percentages")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---

Thanks for the feedback, Jason -- you are right, the s64 stuff was
overkill here.  Much simpler this way.

Changes in v3:
- Drop s64 widening and div64_s64 as requested by Jason Gerecke.
  Use __s32 range with a <= 0 guard instead. Keep the clamping.

Changes in v2:
- Clamp the computed percentage to [0, 100] instead of returning
  false, so that slightly out-of-range ADC values do not prevent
  battery registration or silently drop updates.

 drivers/hid/wacom_wac.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 361738b..36bab07 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1960,6 +1960,16 @@ static void wacom_wac_battery_usage_mapping(struct hid_device *hdev,
 	return;
 }
 
+static __s32 wacom_wac_battery_percentage(struct hid_field *field, __s32 value)
+{
+	__s32 range = field->logical_maximum - field->logical_minimum;
+
+	if (range <= 0)
+		return 0;
+
+	return clamp_val((value - field->logical_minimum) * 100 / range, 0, 100);
+}
+
 static void wacom_wac_battery_event(struct hid_device *hdev, struct hid_field *field,
 		struct hid_usage *usage, __s32 value)
 {
@@ -1973,7 +1983,7 @@ static void wacom_wac_battery_event(struct hid_device *hdev, struct hid_field *f
 			wacom_wac->hid_data.bat_status = POWER_SUPPLY_STATUS_UNKNOWN;
 		}
 		else {
-			value = value * 100 / (field->logical_maximum - field->logical_minimum);
+			value = wacom_wac_battery_percentage(field, value);
 			wacom_wac->hid_data.battery_capacity = value;
 			wacom_wac->hid_data.bat_connected = 1;
 			wacom_wac->hid_data.bat_status = WACOM_POWER_SUPPLY_STATUS_AUTO;
@@ -1981,7 +1991,7 @@ static void wacom_wac_battery_event(struct hid_device *hdev, struct hid_field *f
 		wacom_wac->features.quirks |= WACOM_QUIRK_BATTERY;
 		break;
 	case WACOM_HID_WD_BATTERY_LEVEL:
-		value = value * 100 / (field->logical_maximum - field->logical_minimum);
+		value = wacom_wac_battery_percentage(field, value);
 		wacom_wac->hid_data.battery_capacity = value;
 		wacom_wac->hid_data.bat_connected = 1;
 		wacom_wac->hid_data.bat_status = WACOM_POWER_SUPPLY_STATUS_AUTO;
-- 
2.53.0

