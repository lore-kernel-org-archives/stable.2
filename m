Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B7D42DFF5;
	Tue, 28 Jul 2026 11:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785239990; cv=none; b=En3KlD2uL+zUwW+z3VSJvTA+E6rmD9a0srf5EIRA81dzARnM1Mb9Hw/LFSMHi+tTuBYpmI0dC1cqqYV0YPvSzSnqPjXtCV4OI2IFWfOYdnqJIj3UWxk1hOhAGaFm6ckB0WJOV9KjoT9AKpiGWKNSORA+d+Kh5BA7eWG9OBB66PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785239990; c=relaxed/simple;
	bh=lHRTwriL95Pr9/wHIGFYRtPnyduJsP68/G4xDpZNW6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SzFKI2Vjp7ejnS55/Gf874YDM/e2DGB00evN0kUzfPLkss1p4FAXORSefdttbBSecfjQee0Dl7kyEz0dKJXNuwIVPzhcORotOqZ+nLjqGI/jPoiZUvDZGL18HOLPn9hV1sHIaB3rTRTaCee3gLJe/MG9xW0AslpxnxhgfayyLiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=fADgfQZR; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="fADgfQZR"
Received: from aerhardt-tuxedo.buero.augsburg.tuxedo.de (business-24-134-105-141.pool2.vodafone-ip.de [24.134.105.141])
	(Authenticated sender: a.erhardt@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 150A52FC007C;
	Tue, 28 Jul 2026 13:59:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1785239981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Vg1DleA7vpCyTm+joNWGDMumyeZJh2BUHdIbGtwOYzU=;
	b=fADgfQZRSkeB70QIDnRtOul9fpGAjYtgKFXGxKFGz+vcGn8vPqp8cGvc0iIAsuS72yfS6G
	vjrECXRV+uRbYfch+E2Qj9qr4MIbt+lk/c8g/556yEZMDGI2vibdkQ9VKg/Lpqi/dbT2pa
	Z902LQuh/BuS+3XD4gY1zuq5vI1K7x8=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=a.erhardt@tuxedocomputers.com smtp.mailfrom=aer@tuxedocomputers.com
From: Aaron Erhardt <aer@tuxedocomputers.com>
To: wse@tuxedocomputers.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: stable@vger.kernel.org,
	Aaron Erhardt <aer@tuxedocomputers.com>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 4/6] platform/x86/tuxedo: Fix keyboard LED map ordering
Date: Tue, 28 Jul 2026 13:59:38 +0200
Message-ID: <20260728115938.125444-1-aer@tuxedocomputers.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LED mappings in sirius_16_[iso|ansii]_kbl_map did contain a
flipped line that caused LEDs to turn on in the wrong order when
counting up the Lamp ID.

Cc: stable@vger.kernel.org
Signed-off-by: Aaron Erhardt <aer@tuxedocomputers.com>
---
 drivers/platform/x86/tuxedo/nb04/wmi_ab.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/tuxedo/nb04/wmi_ab.c b/drivers/platform/x86/tuxedo/nb04/wmi_ab.c
index 8f1ffca0430d..2b985b030197 100644
--- a/drivers/platform/x86/tuxedo/nb04/wmi_ab.c
+++ b/drivers/platform/x86/tuxedo/nb04/wmi_ab.c
@@ -232,8 +232,8 @@ static const struct tux_kbl_map_entry_t sirius_16_ansii_kbl_map[] = {
 	{ 0x2e, { 246000,  67500, 5250 } },
 	{ 0x2a, { 269500,  67500, 5250 } },
 	{ 0x53, { 294500,  67500, 5250 } },
-	{ 0x55, { 311200,  67500, 5250 } },
-	{ 0x54, { 327900,  67500, 5250 } },
+	{ 0x54, { 311200,  67500, 5250 } },
+	{ 0x55, { 327900,  67500, 5250 } },
 	{ 0x56, { 344600,  67500, 5250 } },
 	{ 0x2b, {  31000,  85500, 5500 } },
 	{ 0x14, {  51500,  85500, 5500 } },
@@ -337,8 +337,8 @@ static const struct tux_kbl_map_entry_t sirius_16_iso_kbl_map[] = {
 	{ 0x2e, { 246000,  67500, 5250 } },
 	{ 0x2a, { 269500,  67500, 5250 } },
 	{ 0x53, { 294500,  67500, 5250 } },
-	{ 0x55, { 311200,  67500, 5250 } },
-	{ 0x54, { 327900,  67500, 5250 } },
+	{ 0x54, { 311200,  67500, 5250 } },
+	{ 0x55, { 327900,  67500, 5250 } },
 	{ 0x56, { 344600,  67500, 5250 } },
 	{ 0x2b, {  31000,  85500, 5500 } },
 	{ 0x14, {  51500,  85500, 5500 } },
-- 
2.43.0

