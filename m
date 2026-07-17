Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B18A378D64
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 19:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784316249; cv=none; b=nHLnRQwdYdZmHvh465wl+g0NvUGnf0H2obGdSl7+Z9QXMpAdYLmXVIHtJF982w7W4dLz+J09LljJrS9T/ZwTOJ9AsSuRhY7dY6TAvwUFjIRD1jNY147ZZFsxO/w9w/7N6OWUpr2mqtjE/J9T2cDSfkDzn+toWNPwd3K1If1wzw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784316249; c=relaxed/simple;
	bh=fvPkBzbpwmuRoBK+/aFroMGI0jmLv7cXPtrvu7Ztb5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JhNIl6v67QIQrZU1kvBN7y9hb5KXo+pQPic4lPOZ0R9qjkv76uY7yEjM2nH2Lj02fFT+wL3JA5R65+Kiu588PCFNHoOjsk2WvxDGX18uj9uo4BwZzONI4MEBJHM2yYNcq0XXzi1t/SX3GnkLOFj5IKgCPXeZhffNg2ds8LIPUVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dwb99UwY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dwb99UwY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5193D1F00A3A;
	Fri, 17 Jul 2026 19:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784316248;
	bh=Ek552cWKWJhVzyAtmj1pSOWKoHPBkize6PUtKZrvCS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dwb99UwYpFvt6MEg4YHfz9zXR8d1MESinD2JY/JBs/iXNrF5L9ezIHwthONsUHxAD
	 SUnNbHsSJT0RcGFUDgOkLNqOtN/w91tU9UN94Md+T7TmO30QYLEA3oNf+UdmC32ihO
	 2eDEdIpBE8+vwI1akJ8dQed0r9x9O7YUqfgYbR6ERQky/o7GVtPK46b6vW/9NyGwQr
	 R8FxPBTr8+BlFCB6Nu6jdi9igckYaYkL651lmjEa3FvxVdVgx8olSEsW9716psHQjg
	 5lzIa9fRltyurLBFlGvX1yiGnyd4/a4dzSy7ViQZKSZURSHaFhE5+s3KOL0UVaKJhS
	 ZuzhVm4wK9BWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oleg Makarenko <oleg@makarenk.ooo>,
	Oliver Roundtree <oroundtree1@gmail.com>,
	=?UTF-8?q?Ryno=20Kotz=C3=A9?= <lemon.xah@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] HID: pidff: Use correct effect type in effect update
Date: Fri, 17 Jul 2026 15:24:03 -0400
Message-ID: <20260717192403.2131944-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717192403.2131944-1-sashal@kernel.org>
References: <2026071445-promoter-disburse-fa77@gregkh>
 <20260717192403.2131944-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Oleg Makarenko <oleg@makarenk.ooo>

[ Upstream commit b251598b8bf37300510868f739a79e07800d41ce ]

When updating an existing effect, the effect type from the last created
effect was sent to the device instead of the updated one.
This caused incorrect reports when a game creates multiple different
effects and updates only one that is not the last created.

Fixes FFB in multiple games that create multiple simultaneous effects
(Forza Horizon 5/6).

Fixes: 224ee88fe395 ("Input: add force feedback driver for PID devices")
Cc: stable@vger.kernel.org
Tested-by: Oliver Roundtree <oroundtree1@gmail.com>
Co-developed-by: Ryno Kotzé <lemon.xah@gmail.com>
Signed-off-by: Ryno Kotzé <lemon.xah@gmail.com>
Signed-off-by: Oleg Makarenko <oleg@makarenk.ooo>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/usbhid/hid-pidff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index 2dfe44de4c4c74..0e653b104b5259 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -460,7 +460,7 @@ static void pidff_set_effect_report(struct pidff_device *pidff,
 	pidff->set_effect[PID_EFFECT_BLOCK_INDEX].value[0] =
 		pidff->block_load[PID_EFFECT_BLOCK_INDEX].value[0];
 	pidff->set_effect_type->value[0] =
-		pidff->create_new_effect_type->value[0];
+		pidff_get_effect_type_id(pidff, effect);
 
 	pidff_set_duration(&pidff->set_effect[PID_DURATION],
 		effect->replay.length);
-- 
2.53.0

