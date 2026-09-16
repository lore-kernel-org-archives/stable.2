Received: from mta0.migadu.com (out-230.mta0.migadu.com [91.218.175.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFC63563F6
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 14:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789569541; cv=none; b=ataqxba/evWdwStXSxfcjnthLv4ojeDRz2qndOhb+YmjUGwZaBiDY8xrjj85VO/WF+uWdrnnEVTA+w/kXAt3Z8PuCeMZF4WZGLMiDFYmd4cEA5tUFCEome/rwLEzvHAVfgdkl58YI5+kNzvwW/PEqCnZjDoWKBLBpWZwTwu/msA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789569541; c=relaxed/simple;
	bh=xgidOb6wZQb6UV880KBNFOuD0LDd0qtpFCKtTZo+PqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/1lQ+RdifEqRdGUs8fX+mA383n1+6VFZFO4G6S6K3YYQMr2kj093YAbL6LwWTR8+k1+PgB+R5V2zOBT9YBJvAW/DZ71NweloDbmDi/SjhuBnTGMzF1NQjNoNAINBnay22z+Sug7HbxaXkKq0TlnXJrQTeZx4EVb0kuwBHctKrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cZVypZDo; arc=none smtp.client-ip=91.218.175.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cZVypZDo"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xgidOb6wZQb6UV880KBNFOuD0LDd0qtpFCKtTZo+PqM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789569536; v=1; x=1790174336;
 b=cZVypZDo1Ae4a5Q+lg1U5eLvXXGv9ThsZbQ2KXCd9CIpuz6yFq3s0vBVv5rxF2aam7PkoIWf
 bjYLt0xDVaM6H4rnzFg9f6kX/72y/C9ILtLp/i5YDyUlAyG1jjLtNF5jJoWuv62ZSdRTdTk0Df2
 3JnyZpmJjwJj1MKlfO5iWXbM=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b843479c0028f47b;
	Wed, 16 Sep 2026 14:38:56 +0000
X-Mizu-Trace-ID: b843479c0028f47b
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
Subject: [PATCH v1 1/4] platform/x86: asus-wmi: fix unclear usage of bd->props.power
Date: Wed, 16 Sep 2026 14:38:25 +0000
Message-ID: <20260916143838.170950-2-denis.benato@linux.dev>
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

The bd->props.power is checked in parts of the driver correctly
comparing with BACKLIGHT_POWER_ON, while in others with a raw usage
of bd->props.power and !bd->props.power, moreover in certain checks
the logic has been inverted due to BACKLIGHT_POWER_ON being defined
as 0: fix both the wrong usage and the inconsistencies by using
proper comparisons.

Fixes: 130d29c5627c ("platform/x86: asus-wmi: adjust screenpad power/brightness handling")
Closes: https://lore.kernel.org/all/178362762638.911488.8564892548331679884@eldamar.lan/
Closes: https://lore.kernel.org/all/ea9c63d1-4776-49d5-9dc4-6c09498f99c9@linux.dev/
Tested-by: Hugo Baigue <hugobaigue2004@gmail.com>
Tested-by: Ponali <ponali2k@gmail.com>
Cc: stable@vger.kernel.org
Assisted-by: zcode:glm-5.3-flash
Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/platform/x86/asus-wmi.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index b4fd2257bc8e..7382f2b38678 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -4532,7 +4532,8 @@ static int update_screenpad_bl_status(struct backlight_device *bd)
 	u32 ctrl_param = bd->props.brightness;
 	int err = 0;
 
-	if (bd->props.power) {
+	switch (bd->props.power) {
+	case BACKLIGHT_POWER_ON:
 		err = asus_wmi_set_devstate(ASUS_WMI_DEVID_SCREENPAD_POWER, 1, NULL);
 		if (err < 0)
 			return err;
@@ -4540,12 +4541,17 @@ static int update_screenpad_bl_status(struct backlight_device *bd)
 		err = asus_wmi_set_devstate(ASUS_WMI_DEVID_SCREENPAD_LIGHT, ctrl_param, NULL);
 		if (err < 0)
 			return err;
-	}
+		break;
 
-	if (!bd->props.power) {
+	case BACKLIGHT_POWER_OFF:
 		err = asus_wmi_set_devstate(ASUS_WMI_DEVID_SCREENPAD_POWER, 0, NULL);
 		if (err < 0)
 			return err;
+		break;
+
+	default:
+		pr_warn("Invalid screenpad backlight power state: %d\n", bd->props.power);
+		return -EINVAL;
 	}
 
 	return err;
-- 
2.47.3

