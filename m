Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048392;
	b=BtTaS3Jr7nQSXcrdTtZBftjvKxA743j8xXiryjNtKupIVgwiWvvOAphOUCGHJonj9a/C
	 UH+CGe2EsfqBdxk42iWCejeOdjpTWclqZ36YMeDdpTHhjs0zApaXp8iQuM/bgsTjTs3hh
	 THFVdxBmWLY/N2RtNthhJa1yhmIEGESwcIQ4klNxkBRWiIiubJcg6Lgt8V3uQBXhvqZrO
	 ZLRAPJxwnRdbg4AX+AqM+x1g4G2ePW/AYEn9z4w8KSk+eRv5qIPNF3GpJjy/PSvkdQfEf
	 6OGN0jJlyZ57LD57JWoH4rl1FRq1OpWNtIRcFGeptsENswWvHtJPDCVWhh0HHlJViqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048392;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=AqHw3UQdmomY7ywVa9iR9rsVDm3kH4fqYifqy9RAXJ4=;
	b=ECaTJ6N9cdSYYreAsGl+KbgnYqVf578c8ozNLbS33IcUZJhN1bLGy8Vc8yT9ztBeBIG1
	 MUOK1Pcx1w2DwEWMsFysE8N0m8A1Gv69PGRI61/OcENXeQ9ZKdPy0KRThHBzgJKws1zrS
	 6mJa1JvNyNGuJZfEjxefiTnf4qm27RqtmNRtyJy5LQXVn2O2cEPB5HiBC4jzPMmyEwC19
	 AV5gPGlJQxIj4WvoFJXBnDG4taY9KF4T1tV/erUS7bkFdw+t5DzCi0fW4yKAVsRfNcHtG
	 oQSTap+i/cxftrULYEiwcal/cuL59nxBNoH4YjeqglZ8wlE9o2+oyMfJZRcQVQqhsmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LNxUPxyS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6153606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LNxUPxyS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F561F0089F;
	Sat,  7 Nov 2026 10:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048391;
	bh=AqHw3UQdmomY7ywVa9iR9rsVDm3kH4fqYifqy9RAXJ4=;
	h=From:To:Cc:Subject:Date;
	b=LNxUPxySrOTvPZF0KoEBW4rze9r1hIfs4oRUT6oypthnY0MRnYs5aPM+tqcfelkaH
	 qrf1peh4uYw6nhHGhHbT3AF+LgPuzNH4F9MsFALwY7nN3q5L55N9E5Xvd+dLSgE6r8
	 HvgU3ZQEXKZ7K6wu84bqja0spBOwzQD1a/dkS6lTC6FtozneeJBjJfhn/rXroc/PzL
	 LvjDcUZS33MBBxY1I8nwnkyjTJMAW5YM1ve1fwQ9MpoLVzMONE5+zipmLLBCjzWdD0
	 KVgG5XwvCFs/wzZcZaZJcCGzILvLgyKc7VeFPre5ZsD6/OjX27qYp55T9y034yr2kc
	 vTqdRn6mKrO0A==
From: Sasha Levin <sashal@kernel.org>
To: aliresool567@gmail.com,
	gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] USB: quirks: add USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE for GameSir G7 SE" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:46:30 -0500
Message-ID: <20261107054630-failed-6.1-40224df29729@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 40224df29729618ecd88c5c0077e71b1e82c7a3a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054630-failed-6.1-40224df29729@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 40224df29729618ecd88c5c0077e71b1e82c7a3a Mon Sep 17 00:00:00 2001
From: Ali Resool Tuama <aliresool567@gmail.com>
Date: Fri, 2 Oct 2026 20:42:12 +0300
Subject: [PATCH] USB: quirks: add USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE for
 GameSir G7 SE

The GameSir G7 SE wired controller first enumerates as 3537:10a0 and
then re-enumerates in a mode it picks from how the host enumerated it.

When the configuration descriptor is fetched the Linux way, 9 bytes
followed by the full 80, the controller disconnects about 1 ms after
its string descriptors have been read, before SET_CONFIGURATION, and
comes back as 3537:1082, a generic HID gamepad without force feedback.

When the configuration descriptor is fetched in one 255-byte request,
as Windows does, it comes back as 3537:1010 in Xbox One (GIP) mode,
which xpad already supports, including rumble.

Skipping the device qualifier requests (USB_QUIRK_DEVICE_QUALIFIER)
makes no difference; the configuration descriptor request size alone
decides the mode. Add USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE for the 10a0
identity, as is already done for the ShanWan Wireless Gamepad.

Cc: stable <stable@kernel.org>
Assisted-by: claude-opus-5-5
Signed-off-by: Ali Resool Tuama <aliresool567@gmail.com>
Link: https://patch.msgid.link/20261002-master-v2-1-24b05d8792b5@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index b5b577f0b931c..a4bcbe9c913cf 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -612,6 +612,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* ezcap401 - BOS descriptor fetch hangs at SuperSpeed Plus */
 	{ USB_DEVICE(0x32ed, 0x0401), .driver_info = USB_QUIRK_NO_BOS },
 
+	/* GameSir G7 SE */
+	{ USB_DEVICE(0x3537, 0x10a0), .driver_info = USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE },
+
 	/* DELL USB GEN2 */
 	{ USB_DEVICE(0x413c, 0xb062), .driver_info = USB_QUIRK_NO_LPM | USB_QUIRK_RESET_RESUME },
 
-- 
2.53.0




