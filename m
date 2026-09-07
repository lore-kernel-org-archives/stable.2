Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3313BADAA
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 22:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788820090; cv=none; b=opTeHbrHj4WRg3Mt9mfw2HGYRjWE5VPBLmUn3iIHwSpMeAQR5b7OMz9tUMYl6+ZXhZFai3pAYT4YHTcvV2Ms0sEZDVMp8dhIiQtUSvE1mvU1nLCBQFIoj4J6vcougI3Oie2bnsHPowaYlOxirJ/dpGunNu6IWYBHe80VjC2aBbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788820090; c=relaxed/simple;
	bh=TRERrWgmhGbusSYEZZCROeKq68lmoxkZd4YmQmncxw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C5xcY5ewo11fJrqPDpHX8fdDjQDhzLQ0M+KwEgrKvsrSxyV+9J+7f4z6MYhVLEpzQcSKIoYRVj63CpjItW62dVCfl+oCxsf6M/Uaoqnh5q4nVRzDqgn8Llov1i76GES02X2VGbVhFXuvo7cyuXm/pjpYp3bGGLrLHW+7L6ZPY4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7Zl6xuj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7Zl6xuj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9A61F00AC4;
	Mon,  7 Sep 2026 22:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788820089;
	bh=lz/e1oFeXIsyWFmyH4lE6SeJd6deoRmDH1VeSge0Guc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z7Zl6xuja9cfc3B172ffSCjDmTdek3EEfR5yKHOjOkWODqS/WxnG26C6isYsMVHar
	 EJZFKyEq8OAup45bqeldkEq9spo1Iee7HNO86kn0ORQEi2BA6FOMHntQXYSCd892if
	 fvdbdAELYBfx0+UGIu60ZXQTQVkm/e+G8cuIuBIPRi6ZE8BMGvGFOdr30ohuwUUW9J
	 48tv7ljklo0+l1yZx8BpfHOS8O93EhGoqLjFu8B6szcMe70yS7oMMeM9OYJz/SY1vw
	 dFaPKFlwKGPdVmOQbgt62LJ2Urum8OczVoTMEluRbp4fUtuQHuhn1Ml26hQXsibD9m
	 a9yxIcU54Bz7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/5] HID: sony: constify fixed up report descriptor
Date: Mon,  7 Sep 2026 18:28:03 -0400
Message-ID: <20260907222805.669827-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907222805.669827-1-sashal@kernel.org>
References: <2026090345-compactor-scandal-09fb@gregkh>
 <20260907222805.669827-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Thomas Weißschuh <linux@weissschuh.net>

[ Upstream commit d4781a27add1a881b92cd71d1ce6190c121d042b ]

Now that the HID core can handle const report descriptors,
constify them where possible.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://patch.msgid.link/20240828-hid-const-fixup-2-v1-11-663b9210eb69@weissschuh.net
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Stable-dep-of: 7c65699a3a31 ("HID: sony: clean up device list on probe failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-sony.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 33e6e5cebb146..d5b2850e467c0 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -99,7 +99,7 @@ static const char ghl_ps4_magic_data[] = {
 };
 
 /* PS/3 Motion controller */
-static u8 motion_rdesc[] = {
+static const u8 motion_rdesc[] = {
 	0x05, 0x01,         /*  Usage Page (Desktop),               */
 	0x09, 0x04,         /*  Usage (Joystick),                   */
 	0xA1, 0x01,         /*  Collection (Application),           */
@@ -195,7 +195,7 @@ static u8 motion_rdesc[] = {
 	0xC0                /*  End Collection                      */
 };
 
-static u8 ps3remote_rdesc[] = {
+static const u8 ps3remote_rdesc[] = {
 	0x05, 0x01,          /* GUsagePage Generic Desktop */
 	0x09, 0x05,          /* LUsage 0x05 [Game Pad] */
 	0xA1, 0x01,          /* MCollection Application (mouse, keyboard) */
@@ -599,15 +599,15 @@ static int guitar_mapping(struct hid_device *hdev, struct hid_input *hi,
 	return 0;
 }
 
-static u8 *motion_fixup(struct hid_device *hdev, u8 *rdesc,
-			     unsigned int *rsize)
+static const u8 *motion_fixup(struct hid_device *hdev, u8 *rdesc,
+			      unsigned int *rsize)
 {
 	*rsize = sizeof(motion_rdesc);
 	return motion_rdesc;
 }
 
-static u8 *ps3remote_fixup(struct hid_device *hdev, u8 *rdesc,
-			     unsigned int *rsize)
+static const u8 *ps3remote_fixup(struct hid_device *hdev, u8 *rdesc,
+				 unsigned int *rsize)
 {
 	*rsize = sizeof(ps3remote_rdesc);
 	return ps3remote_rdesc;
-- 
2.53.0

