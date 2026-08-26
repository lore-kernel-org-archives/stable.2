Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ACE438036
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 13:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787752024; cv=none; b=DEQ+fi0blfI489MKTzYv5munSQNaTX8Tcdq1Y7TqWAOx62MnidhspQtIcUL84BRHVv+Owi4wca023DdDP9fP9GzvqWENMECxEcJFT5tlIyIm+FYyTId8BhYXDxc521UuVKvx/aC/h/mXCvOZyE59JLLImPcpy+/lUpgYij61Fs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787752024; c=relaxed/simple;
	bh=bDirCRv9ZLQu1dVzv043voUwENN6qxhcSZleYJAuBDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WtTYLegE8wPp3a/KL4Yh/W6+Z9I0lPv85erTmyyHx3ueXB8deA2qCz7l4rAxm6iacgwsxacT/zttNhmHjSIaftzwalgdfaphn7uMNiUWfflzMxMZsPKpgL0etdOZ1xBmY3OgUjQYMyr3yLjw32fpwk9St/mRJtwBIqNeSBAbT4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBuSSXC1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBuSSXC1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A511B1F00A3A;
	Wed, 26 Aug 2026 13:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787752021;
	bh=IAhaWF+qF/Pb+mVyrskP0mBvERMAJk7SMM9lm+0Usas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WBuSSXC1GROZejTcjBOYS1jKyQ/jcd6EpEVzPZc7rStxLfmskLrJlqTsGWOlULtGM
	 +sVZKlB+ICrOtSaPhtPSqFEMsBSBvphsbtHu5gAfl+GVlKdLhiPOQAMQPdHj1LQs2D
	 BmNlMFphrvWd0zQOZck4h09AH/IkdL90THUd1OOX6N2h7aTRyHlSsDI9R9fSQfInw1
	 Ic9wUJwV4xIIAoYlVzDDZKrl8vD+ta5KqV1S7BBiej6GkvmYXHMfkfJ/KIl+q6/2Uq
	 SEoDjEnQakjL+K09ryf3AmB82kGPvS6Y+RkKnx6nQrnhh9v6AT5ZpR4v2std17tNJ0
	 davDdgDvP+MOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] HID: asus: fix missing hid_is_usb() check
Date: Wed, 26 Aug 2026 09:46:56 -0400
Message-ID: <20260826134657.3953358-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826134657.3953358-1-sashal@kernel.org>
References: <2026082550-stinging-mushily-fa27@gregkh>
 <20260826134657.3953358-1-sashal@kernel.org>
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
index e1ae518bfb217..185bcdb538f24 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -667,7 +667,7 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
 			return ret;
 	}
 
-	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
+	if ((drvdata->quirks & QUIRK_ROG_ALLY_XPAD) && hid_is_usb(hdev)) {
 		intf = to_usb_interface(hdev->dev.parent);
 		udev = interface_to_usbdev(intf);
 		validate_mcu_fw_version(hdev,
-- 
2.53.0

