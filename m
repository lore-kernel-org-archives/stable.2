Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D349524A078
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 00:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789518567; cv=none; b=GbuWl0HmNiIcr4DEXjriiccxlr41Jv+v+FsIA2RG7b8OanGcNeTN2I3c/iW4QEjDEbpFsCH/X1IdJsealetNxOsektSIEIK00ZDk04BZDzDFKsrzOP0jN/DxISrEGi472xWmec3tQsMkkTulQX5pE7vWk4xwRZhMyGlUwlOF3f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789518567; c=relaxed/simple;
	bh=p/5oJV7q1FbNiz+/7hDgsnCOP/jEEcdtH/tFny2YVic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pFVTJyle4gbJBC5VrTim/qRH9LyS6TDVbKcKe1nSC9KDYWk5jIRLRX884+ltmnKWTw3abxMWA+AmOZVd/S+rmRvU3iO18s8jq5YXnYuoXi3c/D3EUzYgHL6rsX8Xb7XLrr0b25cbW0XMQZD55b7LXhnTbvM3JJMcgQrEjKYQ3oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nxq6AqFM; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nxq6AqFM"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6c0fce17so1876965e9.1
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 17:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789518563; x=1790123363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sxA4w87jUv9QABdrf7SXrS6ck3FNWWnv2LyiPXHQ/P4=;
        b=Nxq6AqFMS1CB3+VhPwGu52kxvreB6Ob+uS/gKPgZeSfRwFo3M4WIXlfs79fbYB72nW
         UK9jvwrndtR3HCb+i6CQaP778BbfzZzwrNXuj3MwK5LCVEJEvNX0sg56qhS0/k2br+kM
         DC6IVPQcu1V+zwmC+9NTDs6mHu5XOlF9JxTe90n31A2lrt2NC1tT8kwZ+2m6OKoBoCZN
         8J4EXStFalqzQnA/Q9ry+8BE4YrlN207hE6AUGJgtSZOAn8+JSd/sNhPmrt/HXCpaa5K
         4dzjeRETK/ynqQP+kfHlpkJCuYWb+d7bGJC9e7BgN6356w+q9PhSdpqafe1fgyIKuYFr
         VctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789518563; x=1790123363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sxA4w87jUv9QABdrf7SXrS6ck3FNWWnv2LyiPXHQ/P4=;
        b=dQEOsjZogA5NyP1TiqfUspzwqOUmMBGzsdGY0llngo/bu4WDm9MPGYHOIwCc5bWH1d
         t6YmU4dJQorAquYc4sgc9PMzA8MLNKuGhAuCgZpqsZX5Z+kZVkXGJ1TIRJxvm0eTYIGp
         DWQ+w+3jUbu9yVu2pTfA2zIbWmJiuhxGmRebtxGUv8aD1bQBEN0YFT1pPH7S1f5v/nl9
         frXXjPRAGSSxzFRhG9mdarBnp0e3ikG20mXByA9XTDz6j3VJntS4gcTxq5qDVH1yYYtl
         gNRoDMZMyOwTX0tResfn6THLTB28wh6jDoPhe0Vn2mGK5XZy5fQdl2hoBFNi+fcwJf8R
         nCFA==
X-Forwarded-Encrypted: i=1; AKwUvByyK87d3le0JEc6WghGETG6SYVumL+kOkStGulBqTjdgyJpR2KgZL1uo+4IwzquWIWqSt6L0XQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nYLAjvWIZlQpdAwZIAQVLJOvKpch86lGRp0/Oqsojhg7RI1roT
	Ova1cdJBEG0hWpJB8oXNFqOAfkIqdCl6GKblvaS6QNoXwsSqj1/UzAmh
X-Gm-Gg: AYBFou0xjE0r6TuLkcQRspMBuv870NAOqO7wQFdo0AULfhI+we1q026BikhMQ3zz0vt
	bClRYuDE8qc7y56j65qtrCunKXy3LsTJ0Gfk59qidQpUxgGp9H5KBmkJ2nB2rRE3bFkRu+eIon4
	eOLGHEFKhOEwUrJZGzx/xeRRcAhhw4DL4rOiOXXJXuJDMrfelARc0YDkblYSlBVbaiflCKGDVoe
	NgjhZaurJanjaknuqSG+AAqqT7TZBd7ON8SD0cCHJye2cP+/rXNUwGp6qCE+21MGhuc/Egnk0Tf
	BXynGdOHz3qRFTk4eDYZW+Bijo98xcp/2LOmfC437++4KNiolbju/10Mk6yyu1HfIB74C2HigIY
	iJIEz83AMGsIO0GSzjHhsBLNivoeJk8VB4Xl99ONIJCh9hXxXFBdRK9/vrNhGdf1ERmIcbDgIk3
	ncvE/W5Z78Akr4DP5luCPNY/TIl1HfwCQ7MOICNpkWg2YDVbK+VpsMUrdW6iVAjU7pREvkbuqyi
	2czmic965qkoxdkpK5NhhX4VUVe2GfK3UGkjuSPoEo8ZISeq4g8v1HmJnMrFg==
X-Received: by 2002:a05:600c:4e86:b0:49d:15b9:2a2a with SMTP id 5b1f17b1804b1-49eb72f3d08mr4275965e9.10.1789518562814;
        Tue, 15 Sep 2026 17:29:22 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf438fbsm2809121f8f.36.2026.09.15.17.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 17:29:22 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: James Seo <james@equiv.tech>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] hwmon: (hp-wmi-sensors) Accept raw WMI strings in numeric sensor properties
Date: Wed, 16 Sep 2026 05:29:07 +0500
Message-ID: <20260916002907.161210-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit c9ba59258094 ("hwmon: (hp-wmi-sensors) Fix failure to load on
EliteDesk 800 G6") added support for BIOS-reported WMI strings that
are encoded as a length-prefixed UTF-16 ACPI_TYPE_BUFFER instead of
a plain ACPI_TYPE_STRING. check_wobj(), extract_acpi_value(), and
update_numeric_sensor_from_wobj() were all updated to recognize and
decode this encoding.

check_numeric_sensor_wobj() was missed. It performs its own
independent, stricter type check on every property of a
HPBIOS_BIOSNumericSensor instance:

	type = elements[i].type;
	valid_type = hp_wmi_property_map[prop];
	if (type != valid_type)
		return -EINVAL;

and, separately, on each entry of PossibleStates[]:

	type = elements[++i].type;
	if (type != valid_type)
		return -EINVAL;

Neither site has the ACPI_TYPE_BUFFER exception that check_wobj()
gained. Both populate_numeric_sensor_from_wobj() and
update_numeric_sensor_from_wobj() call check_numeric_sensor_wobj()
first and bail out on its -EINVAL before ever reaching the
buffer-aware code in extract_acpi_value() or the CurrentState
handling added to update_numeric_sensor_from_wobj(). So on any BIOS
that reports Name, Description, OtherSensorType, PossibleStates, or
CurrentState of a numeric sensor as a raw WMI string buffer, probing
that sensor fails outright, and the buffer-decoding path added for
it is unreachable dead code.

Give check_numeric_sensor_wobj() the same is_raw_wmi_string()
exception as check_wobj(), in both the main property loop and the
PossibleStates[] sub-loop.

Fixes: c9ba59258094 ("hwmon: (hp-wmi-sensors) Fix failure to load on EliteDesk 800 G6")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/hwmon/hp-wmi-sensors.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/hp-wmi-sensors.c b/drivers/hwmon/hp-wmi-sensors.c
index 03c684b..a4bb4da 100644
--- a/drivers/hwmon/hp-wmi-sensors.c
+++ b/drivers/hwmon/hp-wmi-sensors.c
@@ -631,8 +631,14 @@ static int check_numeric_sensor_wobj(const union acpi_object *wobj,
 	for (i = 0; i < elem_count && prop <= last_prop; i++, prop++) {
 		type = elements[i].type;
 		valid_type = hp_wmi_property_map[prop];
-		if (type != valid_type)
+		if (type != valid_type) {
+			if (type == ACPI_TYPE_BUFFER &&
+			    valid_type == ACPI_TYPE_STRING &&
+			    is_raw_wmi_string(elements[i].buffer.pointer,
+					      elements[i].buffer.length))
+				continue;
 			return -EINVAL;
+		}
 
 		switch (prop) {
 		case HP_WMI_PROPERTY_OPERATIONAL_STATUS:
@@ -651,8 +657,13 @@ static int check_numeric_sensor_wobj(const union acpi_object *wobj,
 			/* PossibleStates[0] has already been type-checked. */
 			for (j = 0; i + 1 < elem_count && j + 1 < count; j++) {
 				type = elements[++i].type;
-				if (type != valid_type)
+				if (type != valid_type) {
+					if (type == ACPI_TYPE_BUFFER &&
+					    is_raw_wmi_string(elements[i].buffer.pointer,
+							      elements[i].buffer.length))
+						continue;
 					return -EINVAL;
+				}
 			}
 
 			/* Old variant: BaseUnits follows PossibleStates[]. */
-- 
2.43.0

