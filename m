Received: from mta0.migadu.com (out-240.mta0.migadu.com [91.218.175.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F89E513566
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 14:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789569546; cv=none; b=KeHwOFGte2zADzwTkUPeiwjT/8/P1Bm6rd5X1OL4Zk48wXpoxl8aoFJLU7B/eB3jA7IsoKP+wEPWUccYG/vqoo994Z9ZYLenrpsw8xc/71hAEj31FBlHsf8eGXKY5mssK+hEqa5+HR4w8Eb1JgpPKuLqkCNEyWMuhXq5WzsOhn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789569546; c=relaxed/simple;
	bh=2KQnoA/3jVWPg6XZS+56Vv+yFvdhfi8eQ1F3fC57pHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5uirUbrfbyCKZW+q7GYXT0xkFfaitzyhDJqf3lZTwDAG7zVxBw5Xech7K4KSmcAGxQ1j2CEpUnKtHdjSEVriJMsgtQOkJ23wzQLaCXe2OXO8KAc1KdXnzTdYr+ozsjMoiB+SnkIYNricrwMADna7+F0kn2QaXix8ZL8EDyQSpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MvuBeEYZ; arc=none smtp.client-ip=91.218.175.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MvuBeEYZ"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2KQnoA/3jVWPg6XZS+56Vv+yFvdhfi8eQ1F3fC57pHs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789569542; v=1; x=1790174342;
 b=MvuBeEYZNIkpOUEWtmr6w2sTWIPrVizqoKGoiqsjbzpYpCiEA6zTCmb1hci4Bm4aGJ5RTeak
 NHPnFxEIPHmXuFBGOuyZQ4ROxOqyo4oRzJPgRE+de37MPidhAB6Bg4PJUcld+NaFexW9g3WvIi/
 ClLewR0ncUUIArDlJC8rZkzg=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 38e479fb58c47116;
	Wed, 16 Sep 2026 14:39:02 +0000
X-Mizu-Trace-ID: 38e479fb58c47116
X-Migadu-Flow: FLOW_OUT
From: Denis Benato <denis.benato@linux.dev>
To: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Hans de Goede" <hansg@kernel.org>,
	"Corentin Chary" <corentin.chary@gmail.com>,
	"Luke Jones" <luke@ljones.dev>,
	"Hugo Baigue" <hugobaigue2004@gmail.com>,
	"Ponali" <ponali2k@gmail.com>,
	=?UTF-8?q?Manuel=20A=2E=20R=2E=20de=20Or=C3=BAe=20R=C3=ADos?= <deor001@gmail.com>,
	"Salvatore Bonaccorso" <carnil@debian.org>,
	"Thorsten Leemhuis" <regressions@leemhuis.info>,
	"Denis Benato" <benato.denis96@gmail.com>,
	Denis Benato <denis.benato@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v1 2/4] platform/x86: asus-wmi: fix screenpad power state detection
Date: Wed, 16 Sep 2026 14:38:26 +0000
Message-ID: <20260916143838.170950-3-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260916143838.170950-1-denis.benato@linux.dev>
References: <20260916143838.170950-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some models, e.g. the UX5400EA, the screenpad power state cannot be
read back: DSTS(ASUS_WMI_DEVID_SCREENPAD_POWER) never sets
ASUS_WMI_DSTS_STATUS_BIT, so asus_wmi_get_devstate_simple() reports the
panel as powered off regardless of its real state.

The DSDT shows DSTS 0x00050031 (POWER) and DSTS 0x00050032 (LIGHT)
both read the same two-byte EC register, each returning a different
byte: byte 0 is a raw EC status byte, which is 0xa0 when the panel is
powered and 0x00 when it is off, and byte 1 is the brightness. Read
the power state from the low byte instead of
ASUS_WMI_DSTS_STATUS_BIT: firmware reporting the power through the
status bit is covered too, since ASUS_WMI_DSTS_STATUS_BIT lies inside
ASUS_WMI_DSTS_BRIGHTNESS_MASK.

Reuse read_screenpad_backlight_power() in asus_screenpad_init() in
place of the raw devstate read. This makes the brightness read
reachable on models like the UX5400EA, so mask the SCREENPAD_LIGHT
value with ASUS_WMI_DSTS_BRIGHTNESS_MASK before storing it: the
unmasked devstate (0x0001ffa0 when the panel is on) would otherwise be
exposed to userspace as an out-of-range brightness (max_brightness is
255) which systemd-backlight then persists.

While at it, pass asus_wmi_get_devstate() the u32 it expects.

Fixes: 130d29c5627c ("platform/x86: asus-wmi: adjust screenpad power/brightness handling")
Reported-by: Hugo Baigue <hugobaigue2004@gmail.com>
Closes: https://lore.kernel.org/all/CAO84+x+P2_xyHP89+nGVSMV6bL+dy0P9=vyEEfZGnFhv0hBNWw@mail.gmail.com/
Suggested-by: Hugo Baigue <hugobaigue2004@gmail.com>
Tested-by: Hugo Baigue <hugobaigue2004@gmail.com>
Cc: stable@vger.kernel.org
Assisted-by: zcode:glm-5.3-flash
Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/platform/x86/asus-wmi.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 7382f2b38678..ded1aa356cf3 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -4498,13 +4498,20 @@ static int is_display_toggle(int code)
 
 static int read_screenpad_backlight_power(struct asus_wmi *asus)
 {
-	int ret;
+	int ret, retval;
 
-	ret = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_SCREENPAD_POWER);
+	ret = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_SCREENPAD_POWER, &retval);
 	if (ret < 0)
 		return ret;
-	/* 1 == powered */
-	return ret ? BACKLIGHT_POWER_ON : BACKLIGHT_POWER_OFF;
+
+	/*
+	 * The firmware reports the panel power in the low byte of the
+	 * devstate as a raw EC status byte that is non-zero when the
+	 * panel is powered; other models report it through
+	 * ASUS_WMI_DSTS_STATUS_BIT, which lies inside the same mask.
+	 */
+	return (retval & ASUS_WMI_DSTS_BRIGHTNESS_MASK) ?
+		BACKLIGHT_POWER_ON : BACKLIGHT_POWER_OFF;
 }
 
 static int read_screenpad_brightness(struct backlight_device *bd)
@@ -4568,16 +4575,17 @@ static int asus_screenpad_init(struct asus_wmi *asus)
 	struct backlight_device *bd;
 	struct backlight_properties props;
 	int err, power;
-	int brightness = 0;
+	u32 brightness = 0;
 
-	power = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_SCREENPAD_POWER);
+	power = read_screenpad_backlight_power(asus);
 	if (power < 0)
 		return power;
 
-	if (power) {
+	if (power == BACKLIGHT_POWER_ON) {
 		err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_SCREENPAD_LIGHT, &brightness);
 		if (err < 0)
 			return err;
+		brightness &= ASUS_WMI_DSTS_BRIGHTNESS_MASK;
 	}
 
 	memset(&props, 0, sizeof(struct backlight_properties));
-- 
2.47.3

