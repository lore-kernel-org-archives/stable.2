Received: from mta0.migadu.com (out-215.mta0.migadu.com [91.218.175.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F89A598C0E
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 17:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788889487; cv=none; b=sMgYoG29FgcFfQR0/HGGiAEEEmW27eiZhqyjbBTC0XqshXU0Cz6VmIgSEKBQnF5wOxaulC6m3zBX1+KcyeolLRDtUMqVBzD4RGuGahJWjn1TFpAQ4MI/LJFHqNZB/PRg1rVaKUaKc9jQOgUmDk5NATnj0s/Nr1esF4yWI+sFY+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788889487; c=relaxed/simple;
	bh=zLK9ilxnouBl8OfzKtWT4IUHOCTEywTf0m+xYBuIXWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AIa7QWkwLyRVIGPsPyi66mVJ79BW74Q40J0lMVulUfWZSeqbU7EMgpLjB9Ieg9URu2yit7PGAY9sEm35wFDXGM/4qjNJhWrcrL9Jo7zggiYFmxMIUp1dYzHyajfJDl2Cxs4+EFcuOJWVfSK688ZQgHz3F8D99BzBnEle/Y38OMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HqCs0Iez; arc=none smtp.client-ip=91.218.175.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HqCs0Iez"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zLK9ilxnouBl8OfzKtWT4IUHOCTEywTf0m+xYBuIXWw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788889480; v=1; x=1789494280;
 b=HqCs0IezO0f3LQHksBjZd54u4bNx9c28PXVNZgolt1IRvCRjgnFghk7Q1Kmi0h7IdS6llbab
 Ipn0nxM0Ntc+S2Sex4ACu/XTMVB9InGn5fGm84WLlihXAGjqEVRhizbMzAByQ9N9p3ELhD1oe4+
 LUpm3IrZBtrK4TOHr7oCE6Cs=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5043b55b054dda9e;
	Tue, 08 Sep 2026 17:44:40 +0000
X-Mizu-Trace-ID: 5043b55b054dda9e
X-Migadu-Flow: FLOW_OUT
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schwartz" <matthew.schwartz@linux.dev>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Jonathan LoBue" <jlobue10@gmail.com>,
	"Khamunetri Clark" <khamunetriclark@gmail.com>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Panz Dev <panz.development@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v6 01/13] HID: asus: do not send keyboard init reports to touchpads
Date: Tue,  8 Sep 2026 17:44:21 +0000
Message-ID: <20260908174433.74260-2-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260908174433.74260-1-denis.benato@linux.dev>
References: <20260908174433.74260-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Panz Dev <panz.development@gmail.com>

Commit 0919db9f3583 ("HID: asus: always fully initialize devices") added a
loop during asus_probe() to send keyboard feature report initializations
(asus_kbd_init) to all ASUS HID devices.

On ASUS laptops with I2C/HID touchpads (such as the ASUS E200HA), sending
keyboard feature reports (FEATURE_KBD_REPORT_ID) to touchpad endpoints
sends invalid feature requests to touchpad hardware, corrupting probe
state and causing the touchpad to become unresponsive.

Wrap the asus_report_id_init loop in an `if (!drvdata->tp)` check so
keyboard feature initialization only runs for actual keyboards.

Tested on ASUS E200HA (where touchpad functionality is fully restored)
and ASUS VivoBook Flip 14 TP401MA (confirming zero regressions).

Fixes: 0919db9f3583 ("HID: asus: always fully initialize devices")
Cc: stable@vger.kernel.org
Signed-off-by: Panz Dev <panz.development@gmail.com>
---
 drivers/hid/hid-asus.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index ec966fc0a411..bd46aba6622a 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1493,12 +1493,14 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return ret;
 	}
 
-	for (int r = 0; r < ARRAY_SIZE(asus_report_id_init); r++) {
-		if (asus_has_report_id(hdev, asus_report_id_init[r])) {
-			ret = asus_kbd_init(hdev, asus_report_id_init[r]);
-			if (ret < 0)
-				hid_warn(hdev, "Failed to initialize 0x%x: %d.\n",
-					 asus_report_id_init[r], ret);
+	if (!drvdata->tp) {
+		for (int r = 0; r < ARRAY_SIZE(asus_report_id_init); r++) {
+			if (asus_has_report_id(hdev, asus_report_id_init[r])) {
+				ret = asus_kbd_init(hdev, asus_report_id_init[r]);
+				if (ret < 0)
+					hid_warn(hdev, "Failed to initialize 0x%x: %d.\n",
+						 asus_report_id_init[r], ret);
+			}
 		}
 	}
 
-- 
2.47.3

