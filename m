Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB6235B65D
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583039; cv=none; b=sozdhMVGbSvMqvQRzleAsPdUWS5yEpmhhx28NH8mkMjFnJc/6vyylO0/GUfyQGR2NBjLmMPDGaKmTtUf3kIqbGEsw2ojmEqkFptLg4sk+4d6s5zmHdJ+JlY6WC4PWXG1wAect15Drpsx77SYxuN5GpWFC103JjGMX38zGpkZ1U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583039; c=relaxed/simple;
	bh=66NVb/Jdak0+4xa8msmHjCpup9y1lNTd9snoXl1Pd30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nTl39DFBl33iRfHytkYJ+hLS4snp5Oy+G0d8W4L1WcquK2kUQVDw0u0ad4PK6IXS6lLPTbp2QoQIA7jj1r5BwkD9j2KyKSBPHguGotXAVkntC+yJXYvy/YVrEyv38jw5B5kyGixeH/EXJRwqbqktiO3WwpOibqKBzyTtAemvz8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d655ySjQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d655ySjQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13841F00ADF;
	Mon, 24 Aug 2026 14:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787583038;
	bh=sKwQ/UzJDb/c9ZTgzrlZvzV0LlR8VuPVB9076CWoPN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d655ySjQ7KrRLsiaE3aADav+vxLKyM0pXU/TtnRKDFfuP3N4O47KTMiwEm93tf8Lv
	 afWT3s7WMaO3w9pU7GuFTMgqaQGPXyFOt0CkfdTAz7+lRRWZVO2DCAEOomwlI9R/l1
	 fMe7Fh1yRMAV5zUveEW5GKTwATs51nyy4BZ0C3TpOKKaqlRvWh4zn216NPC2SOK9jL
	 gxVgc4WHWi24i7A8aZ9WylUcqOy0S+RXjfOqqHqi2ya92wsTmXX2YFQNbBv8GJ/67F
	 MKLvnN8/TG/C6B6xVP6zcGw+5gajBwzFhz8ySiiIIHdSxuV0uN0jUzeIlQERC89/CV
	 ZpfoRL7z1qyqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Donglin Lyu <DongLin_Lyu@outlook.com>,
	Donglin Lyu <donglin_lyu@outlook.com>,
	Ruslan Shevchenko <adefka@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] Input: atkbd - skip deactivate for HONOR ZQC-P
Date: Mon, 24 Aug 2026 10:50:35 -0400
Message-ID: <20260824145035.3662153-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824145035.3662153-1-sashal@kernel.org>
References: <2026082021-ungraded-halves-33f6@gregkh>
 <20260824145035.3662153-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donglin Lyu <DongLin_Lyu@outlook.com>

[ Upstream commit 410c44b1096789d0c40fbee706520e981dba7bc1 ]

The internal keyboard on the HONOR ZQC-P (HONOR MagicBook Pro 14 2026)
does not work after boot.

Using the kernel command line 'i8042.dumbkbd=1' makes the keyboard
functional, but the CapsLock LED does not work. Adding the
'atkbd_deactivate_fixup' quirk fixes the keyboard and CapsLock LED
natively without requiring boot parameters.

DMI: HONOR ZQC-P/ZQC-P-PCB, BIOS 1.09 03/19/2026

Fixes: 9cf6e24c9fbf ("Input: atkbd - do not skip atkbd_deactivate() when skipping ATKBD_CMD_GETID")
Signed-off-by: Donglin Lyu <donglin_lyu@outlook.com>
Tested-by: Ruslan Shevchenko <adefka@gmail.com>
Link: https://patch.msgid.link/20260801151115.52709-1-donglin_lyu@outlook.com
Cc: stable@vger.kernel.org
[dtor: keep all HONOR entries together]
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/keyboard/atkbd.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index f06ce0a7b156d..db7762abfe5c6 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1940,22 +1940,30 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "HONOR"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "FMB-P"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "BCC-N"),
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
 	{
-		/* Lenovo Yoga Air 14 (83QK) */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "83QK"),
+			DMI_MATCH(DMI_SYS_VENDOR, "HONOR"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "FMB-P"),
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
 	{
+		/* HONOR MagicBook Pro 14 2026 */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "HONOR"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "BCC-N"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ZQC-P"),
+		},
+		.callback = atkbd_deactivate_fixup,
+	},
+	{
+		/* Lenovo Yoga Air 14 (83QK) */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83QK"),
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
-- 
2.53.0

