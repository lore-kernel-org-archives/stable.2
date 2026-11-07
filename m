Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047606;
	b=1nFppXP273l2rRZuBvz/0EBkoTUGTY2zM01MUct2CB2OWsB/ZcMSRK5/FZrdF+rJqHXA
	 SUX7RS1ht+olipRG14WWFoV+qa+TRZJIG+punWAwr7irWK3jaBgx5z0XjmEl6bQFasKbM
	 hgPymsdAimRfgEjTxeObw5T9pBjaipruwi7DF2pB/ZsUZsIj1YWTvkujwDQeHb/fChC9u
	 jSR9ghGpYff3ZRZ53tDgV2sa15beaAHApfzlF4tBuWcISvWXvDslnCHnVe0lHGY4CT1iS
	 9fkMozMaVeD0DFGP6HtTUotSWr9KZ7DLl5FaZv2dqEIPXDHLX289t3+bBngwlWvM15Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047606;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=nIbaFlgpd9d7prKtpvgUrRo5wkaSswGgNvtpRy25IEM=;
	b=Sss8NG2t9rVIPT/2Z0e6znkndIdZ5T17QUT8fumBSLjdX5MOzfmBxEhhm/RKH9X9EfuN
	 +9LSpUW6VQj4WLormugh11AOdfl26f+zvuuqSMj/O8f3w5Lv5p4r8wPzr75IfJaSb9WnF
	 qErHxtjGZinv+gnzgfVs6Ed/uSgbhgccjleGp2vA2KXxydb0t2v0STcTchaxUoDJQc6so
	 /zRg4rcfVaMQykO2ven0Ay+9UtSKuz9hTSzo8m3HIHcZSpIqxBToOyKPPOwJOUalm+OC8
	 Y67jsA/fZQND2yi5xJaqfOu+9B1JNrh4YvYRX+M95h7JOkkP84LR7BEefNa6U/f/SYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EP9RsVgB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA98606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EP9RsVgB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EE61F0089F;
	Sat,  7 Nov 2026 10:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047605;
	bh=nIbaFlgpd9d7prKtpvgUrRo5wkaSswGgNvtpRy25IEM=;
	h=From:To:Cc:Subject:Date;
	b=EP9RsVgBS8nYNDHmUxxS+KggNo/uaESwKSoOi57hlMI8Ms/aIe0Bh2l4j2oYuTfHJ
	 JbESwC/lUHzNVqcgZ5su/RIc2+sSCpw/bD2NeXW5hx7t97zw4nbH3hm9HKhcApq9Yl
	 I+XP1EFcH1Vdqt3aM6lLlnjNMdZPdWdTJXjW+a4br19O5YcqJsXhr7ftt5G53uJV4W
	 M4yNhI2z0dxy6I8fAO3uEhIqsAUkm3RV3sWimAcPxatwXNP3hNl4bbky5LK9dB3JGR
	 XXcA+/NMobtiZKFVIzKcI0qp6YLq5nGeGrMLCG0dAHgCCEPxtamqSgbWni/gcp9IqS
	 dWAeBSL1XzXDA==
From: Sasha Levin <sashal@kernel.org>
To: aliresool567@gmail.com,
	gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] USB: quirks: add USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE for GameSir G7 SE" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:33:24 -0500
Message-ID: <20261107053324-failed-6.6-40224df29729@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 40224df29729618ecd88c5c0077e71b1e82c7a3a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053324-failed-6.6-40224df29729@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




