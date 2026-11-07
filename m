Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046294;
	b=gndXSepOeA9kr4Uvjg5AkRPCh0TFBMvzXUwY4OqvnROks7RNHX5/H4BMAIRXwEybwTx7
	 bBmgNhtT0ttyic8SRTCQJLNqM2eEI0szMRCQqmQwJwRaXPWUylVBHjjXER2iR7VNKh8El
	 5BTIP2O3amRwoW1/ZrmzHlNPRfzpCnBfB92oWIQm7ZhpRBpBwQfbkpykxQuCEgmc0BTfm
	 qpDK2SwJ/CsMSBwEF18cMMgxHwbG6V+itSrk9GM/IrQ2/l+O3Sa9b6rm0o/5C5EtvbVVz
	 NNNMeid/YHCO02Jxt0S4tcHKDbk8BY1XEi1dcN67kvQLHAFbeehphPPq864CN/dDGog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046294;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=PDbnU6sQR6UtvUDPSTwEZhsP3enYDQhsj6fbexf+4Uw=;
	b=nURBYxg4UdfMTNNRh+AueNmV40C+bhanPmb90woSqtEok12eDxam5s+383wPFFb48vqh
	 W2Km9aVpP9bjp8WO9Dle0s3GoRDYmQHm1viqRDDnq+HtCXhmLRuS85dzuRzeaBcGhLnZ8
	 o1WItw7m2DJRBwWwkMCL+WBVtV+veHajZBP78gWTcuEkBugzGaKQBpOAW9klFH0YNMki9
	 ONeqY716NYQh0vUgjNcmfpq3YRx3r9mRD0gcv+2nL9Q9fWuD5FEeMAePlVcMiCtPdILp+
	 HbyhGa0UHkkJK6MRBC4n1ZEpJRzDKJzYADPZSsrfTKSM7y73ggeIXgQ+eCw65TMp5/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cjQQqQVn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E423606A332
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cjQQqQVn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B3C1F0089F;
	Sat,  7 Nov 2026 10:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046293;
	bh=PDbnU6sQR6UtvUDPSTwEZhsP3enYDQhsj6fbexf+4Uw=;
	h=From:To:Cc:Subject:Date;
	b=cjQQqQVnA5IGFv8d9S6tN1Qz17Bqkg8EVqdpelNv1mYgQrdbrIiCjjH6XYjWFv8xM
	 WSYIO6jtn2JTtrf6laIcyyckcEa43Nt/iQWM3ODGOeeWL8jVWGMaPSTI5IZ5Ylbw+U
	 ZYP3WceH+q9ukiByGeIhahf7PNbYctuz97TBppbu08ETRgJJQ/+zrhyALN6Y283qvl
	 9NXFpryT7DxAOTp5IAyx6ECBZrX6ZAHs7CMNj4XOg87YtsFv0AYEmMrsP7ppiQE5sh
	 77J1VdCuXZUKaQ6VTHXuB+gPjNjDVqjdmQ/vd2SlSF7FjYn0SslJWMAWG91hsgvkxa
	 Q+GB94ubUH0hw==
From: Sasha Levin <sashal@kernel.org>
To: junjie.cao@intel.com,
	andrew.tsvetinskiy@gmail.com,
	luiz.von.dentz@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] Bluetooth: btusb: drop BROKEN_EXT_SCAN quirk for 0bda:a728" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:11:32 -0500
Message-ID: <20261107051132-failed-6.18-df5e35f1663a@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x df5e35f1663abc2702cf9f9e7eba024129ac5df1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051132-failed-6.18-df5e35f1663a@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From df5e35f1663abc2702cf9f9e7eba024129ac5df1 Mon Sep 17 00:00:00 2001
From: Junjie Cao <junjie.cao@intel.com>
Date: Sun, 20 Sep 2026 10:02:27 +0800
Subject: [PATCH] Bluetooth: btusb: drop BROKEN_EXT_SCAN quirk for 0bda:a728

Commit 5ead2063611a ("Bluetooth: btrtl: fix RTL8761B/BU broken LE
extended scan") set HCI_QUIRK_BROKEN_EXT_SCAN on every RTL8761B, and
commit ca0583c24661 ("Bluetooth: btusb: limit RTL8761B BROKEN_EXT_SCAN
quirk to 0bda:a728") kept it on 0bda:a728 on the assumption that the
USB id separates dongles with broken extended scan from those with a
broken legacy scan path. It does not. An 0bda:a728 unit (RTL8761BUV,
fw 0xdfc6d922) on 6.18.51 fails the same way the UB500 and 0bda:8771
did: LE Set Scan Enable (0x200c) times out with -110 and btusb resets
the device. With the flag removed from the table entry, scanning works
on that unit.

Two dongles with the same USB id need opposite settings, so the device
table cannot key the quirk either. The costs are not symmetric. Without
the quirk, the unit it was written for gets -EBUSY on LE Set Extended
Scan Enable (0x2042) while a connection is up. With it, 0x200c times
out and btusb resets the device on three reported units, two of them in
a re-enumeration loop.

Remove the flag and the table entry. 0bda:a728 matches the generic
Realtek entry again and runs without the quirk, as before v7.2.

Reported-by: Andy Tsvetinskiy <andrew.tsvetinskiy@gmail.com>
Closes: https://lore.kernel.org/all/CAE4bxw+ofDFVx0aTHqCrzns9oP1CRQDm_wzeyHPeMBYOhSpcuA@mail.gmail.com/
Fixes: 5ead2063611a ("Bluetooth: btrtl: fix RTL8761B/BU broken LE extended scan")
Fixes: ca0583c24661 ("Bluetooth: btusb: limit RTL8761B BROKEN_EXT_SCAN quirk to 0bda:a728")
Cc: stable@vger.kernel.org
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btusb_main.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/bluetooth/btusb_main.c b/drivers/bluetooth/btusb_main.c
index cccdfb0461fee..3518f92ebbd3d 100644
--- a/drivers/bluetooth/btusb_main.c
+++ b/drivers/bluetooth/btusb_main.c
@@ -70,7 +70,6 @@ static struct usb_driver btusb_driver;
 #define BTUSB_INTEL_NO_WBS_SUPPORT	BIT(26)
 #define BTUSB_ACTIONS_SEMI		BIT(27)
 #define BTUSB_BARROT			BIT(28)
-#define BTUSB_BROKEN_EXT_SCAN		BIT(29)
 #define BTUSB_QUALCOMM			BIT(30)
 
 static const struct usb_device_id btusb_table[] = {
@@ -650,10 +649,6 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x0489, 0xe130), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 
-	/* Realtek 8761BU Bluetooth devices */
-	{ USB_DEVICE(0x0bda, 0xa728), .driver_info = BTUSB_REALTEK |
-						     BTUSB_BROKEN_EXT_SCAN },
-
 	/* Realtek Bluetooth devices */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01),
 	  .driver_info = BTUSB_REALTEK },
@@ -4754,9 +4749,6 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_INVALID_LE_STATES)
 		hci_set_quirk(hdev, HCI_QUIRK_BROKEN_LE_STATES);
 
-	if (id->driver_info & BTUSB_BROKEN_EXT_SCAN)
-		hci_set_quirk(hdev, HCI_QUIRK_BROKEN_EXT_SCAN);
-
 	if (id->driver_info & BTUSB_DIGIANSWER) {
 		data->cmdreq_type = USB_TYPE_VENDOR;
 		hci_set_quirk(hdev, HCI_QUIRK_RESET_ON_CLOSE);
-- 
2.53.0




