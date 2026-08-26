Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AEF440625
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 14:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787752922; cv=none; b=u+JXAjHp8sgOfUDmd90PBEGab94V8Ax7xrMiYXFbSBDt3AotYfH0RsIPcRILlC6ZU1KrAihv6Rj5YdYlwOEeigZ1Zuj/m+0pBeNj5Xq7rlqX2+l7QZzkVV8nA5Ji4qN+VvpPvnxfmQ/8nRQY7hi5Jlk8fUFAMz65s3IkVF7FAwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787752922; c=relaxed/simple;
	bh=XHNVO/d91tjgG+CQq+BqokqczYyMyEOb43vZOulnJJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+lPQu4UvVyujmyRWt3epK4XZlMlBHW1dRchtcqIZJWoDDlOOY5FyCXuhfPKcEf4nc8KUun2GVPtv0HRynq+1xgEkuQcWYg3tFljpiYVGI9cKM2tTCpmJdEUdCkGebW8gSVuZ5vypK9ksvRf565dgkkUUIapcosWZLSks034TPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wrl+18VH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wrl+18VH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7341F00A3E;
	Wed, 26 Aug 2026 14:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787752919;
	bh=uP0TjHXk2Q8RaL3WgBLtcsA9PfPSUgLfuQTDWo0AF3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wrl+18VH46zW1PFIQjGLli/9V23MdJ+Z6APgK1hGlEfcYyiLiJNs8JOMWOFugtNvh
	 4vQMa+F7ybl8phJ/zC6QXCEsyk9mJOE21Owk1Rijk5dVNG3a26keapfEtBSF82EYe1
	 4w8OhaHkRFc/VTXeHy17671/4y5ekd1uEVqAs+zPcEHqDkDefVpk6yzzDpz4c5fMwQ
	 z4/aD8r/hakqmysLKoBQGWGb2Mo2dpt7fGKoMKTfgdQH/PnwOSL3iA76dGHEJL+BSl
	 RnaFKnP22E31Q41Pj4GeYSzomJ6jrGHtsYVivBYllD1J43UmC1IZd2T9lYPZmVed37
	 Zt6EALhlDkSeA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] HID: asus: fix missing hid_is_usb() check
Date: Wed, 26 Aug 2026 10:01:54 -0400
Message-ID: <20260826140155.107206-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826140155.107206-1-sashal@kernel.org>
References: <2026082550-county-disabled-f55a@gregkh>
 <20260826140155.107206-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jann Horn <jannh@google.com>

[ Upstream commit 02bf61dfb44f17ec187d1da1a82495951bbd12df ]

to_usb_interface() can only be used on a hid_device whose parent is really
USB; uhid can create devices that identify as being on BUS_USB, but don't
actually have a USB parent.
Fix the use of to_usb_interface() without a hid_is_usb() check.

I have verified that it is currently possible to trigger a kernel splat due
to this bug in an ASAN build, and that this commit fixes the issue.

Fixes: 00e005c952f7 ("hid-asus: check ROG Ally MCU version and warn")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-asus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index c9097e91f891d..28426337a2f11 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -664,7 +664,7 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
 			return ret;
 	}
 
-	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
+	if ((drvdata->quirks & QUIRK_ROG_ALLY_XPAD) && hid_is_usb(hdev)) {
 		intf = to_usb_interface(hdev->dev.parent);
 		udev = interface_to_usbdev(intf);
 		validate_mcu_fw_version(hdev,
-- 
2.53.0

