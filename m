Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050440;
	b=Jzc4gJYw+OFMdUmsqpQ7Mr5d5G9dmbci/jhXMC9DsQyslvLwSbAfAjLQC7lAoFO41bZI
	 maiy/Qvi+x9Bm2Doj7VvINzn+97xlBH3yo2/yacaUyWCoVpqD9+tfDFN3MCqkNirZ00sz
	 NNCRQAPRx9NkAhtMKOXajVBcyNNDdRF6wtqxtj1kV7VnZKI2Yrl9IXO0TnYtlKTSwfwPL
	 tE5pP7XQY6+QSlVnjKwA3qNtaw5XzP/I7UuiKpaiTmO9mMMU1v59JiQUSf5howDAZZ1de
	 iiyRwTUV2GoEb46X50Lj7nRQ06am6evWiX5opj+GOKPuloj3hjKkLLOWbSO0C71GKqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050440;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=NJa3A5Jpb2IgPfQXdY6GjMFPk/IpjFZNgBlMk/BoE+k=;
	b=rfh2iEc9+U+qi4xVY21VvMpQ1nf8Cb2kp3q8Wat9StLSX2ucl7kv3TYJ/awKJctb5It6
	 piF5pAmR58mrSFHewM2QVESFjaimf+SSyw/svlztFZMxY8SI8l9BVK24q2yAXxy6ngiQi
	 cipkSU8+840h+pxr38y0BNIt752NDeSv1ouHvqfSfDDLlHHPye880s1aAevLojaLNv1vR
	 2KnUxvKwadtP1bWehI1zF+/TEcsY1htXlMxBhRcZjpjfBni/0amVW7U3DxpShOAUc+X22
	 wF47Xn0mUq/aS+qOC8OwPO+Ra3QIcY+J+RV8mCIVaelb16MnO04Y+x8BRjmhDuOe8Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HvzwoyFU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5844A606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HvzwoyFU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82591F008A1;
	Sat,  7 Nov 2026 11:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050440;
	bh=NJa3A5Jpb2IgPfQXdY6GjMFPk/IpjFZNgBlMk/BoE+k=;
	h=From:To:Cc:Subject:Date;
	b=HvzwoyFUAf2icMaJK37TWJfD2lhjTDEIaR75fe1sUIRwgdLfXaiMuyIPEHvdDcPvQ
	 dxWzYcNX0GMxjdbx/b/mO96UOg+m66oivSY35tGsAGnOydQ6/pCvYsUD/yH8cIv2Xd
	 rmL7OCm2g+j5EB4mviysmApQKOA5fpFvhvlT10Menpv2/+0zG9N6u8LIjhDs9OoAOO
	 9qDICVd5P6AbFIbOPWJ5k49P6YT3XT9D+StpmfiqXOhVKRaolJG9GI6bNHReNbJq7Q
	 +ogzFU7KZS7kBUkge/t9/hfygjDur9pkLwsGZUc19z8gH99YObDl0tSoCT0iZTsldC
	 lTfWpV0U8BVVA==
From: Sasha Levin <sashal@kernel.org>
To: aliresool567@gmail.com,
	gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] USB: quirks: add USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE for GameSir G7 SE" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:20:38 -0500
Message-ID: <20261107062038-failed-5.10-40224df29729@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 40224df29729618ecd88c5c0077e71b1e82c7a3a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062038-failed-5.10-40224df29729@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




