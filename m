Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531D558598B
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 16:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788972307; cv=none; b=nnaW1brzqC/f6Vc1YXo8MaqJMOSB82rmTMMEq7FtEreLUT2id2gYfRY+YUjPDujrRcazUXsQsaXKG0CMQo8xYuu8mzXDCDwl+Jfbtqjvn6qMdE/fhoIn4P8GDR+urFGguizO95hj25PyHVL+9/FMH5k8O8hyQdPrrATaDr6dMyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788972307; c=relaxed/simple;
	bh=XWUFrb2QRwjg9GapQPvpaCJSVEx64x9v9dmDQRZL+pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XT9OFF/6QIdwlbYGjKvlVOOIGZ9WgqEztiEDphEBt2OkJRD9iaUzaaMoM1eLLAjmtpsaq/1+VDxgBCcy9ARbB9SVc2HkC9bEoH1bq85XtJNHOEtda8TDknn1S57J4vE+sRTdh2OXZHlIn0CLkpWEvts6p/aSeif4ICpWprykpF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmhF6IuR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmhF6IuR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A381F000FF;
	Wed,  9 Sep 2026 16:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788972301;
	bh=2JNRqb7C/YFmWTCXdi7KLxZM+z23Y0l5/moMDU/A9JQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MmhF6IuRdInowc30+vRRBj2n1AmKG92dIC2xvOVkGeInE99aryZyu8gzaJMpcn6YM
	 F3wPetsHfrNVV/imGLqzRlKNqOCuiYeTjopz4UW9TzGT7arFZb/90PyRT1s0pTH7mK
	 0qWKEJJtafbV0Z5EudV7oYAaFqnJHlflH3I4sM/19rpHxRQcMsoowpsKU2I2m+iFZG
	 aNl87ZY0M5WnD8yuK23fR8wHFj/sIguy+xM2o6l5xaFd5T7hAobRmirQpJCL4XXlGs
	 1anVdF80cePTkaP3gO0lcfARNzf+AS1/PkvaKZXkrsmaV39S0csZNsb4LJGV0gmNt6
	 GUJBRePvOtp1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krishna Chomal <krishna.chomal108@gmail.com>,
	Yahia Ahmed <yahmedd043@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] platform/x86: hp-wmi: Add support for OMEN MAX 16-ak0xxx (8DD6)
Date: Wed,  9 Sep 2026 12:44:57 -0400
Message-ID: <20260909164457.3072235-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090337-factoid-slander-d0ac@gregkh>
References: <2026090337-factoid-slander-d0ac@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Krishna Chomal <krishna.chomal108@gmail.com>

[ Upstream commit a7320d6eb9c4240c948cd9c64582b3bd04cbaf4b ]

The HP OMEN MAX 16-ak0xxx (board ID: 8DD6) has the same WMI interface
as other Victus S boards, but requires quirks for correctly switching
thermal profile.

After testing we know that (similar to another HP Omen Max 16 device,
board ID 8D87), the embedded controller on this board does not expose
thermal profile which means we have to intentionally disable EC readback.

Add the DMI board name to victus_s_thermal_profile_boards[] table and
map it to omen_v1_no_ec_thermal_params.

Testing on board 8DD6 confirmed that platform profile is registered
successfully and fan RPMs are readable and controllable.

Tested-by: Yahia Ahmed <yahmedd043@gmail.com>
Cc: stable@vger.kernel.org # v6.18+
Signed-off-by: Krishna Chomal <krishna.chomal108@gmail.com>
Link: https://patch.msgid.link/20260623141314.33947-1-krishna.chomal108@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
[ adapted the board entry to the older victus_s_thermal_profile_boards table using omen_v1_thermal_params. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/hp/hp-wmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 550d4b39a92af..5eb2aade44cca 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -194,6 +194,10 @@ static const struct dmi_system_id victus_s_thermal_profile_boards[] __initconst
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8D41") },
 		.driver_data = (void *)&victus_s_thermal_params,
 	},
+	{
+		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8DD6") },
+		.driver_data = (void *)&omen_v1_thermal_params,
+	},
 	{},
 };
 
-- 
2.53.0

