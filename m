Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4D93E5588
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 11:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787655806; cv=none; b=uKS12lOLbUXm18X/1A32m3EDgu+cU8M34eqsb7KqLXfXq2/bpfGr5LPLaOizOiscG9NuQmXHuSYq3M0PM/7lXEdWdA08mXS91vfIJxxsbTb3pDUgjLcq/BNSDu/MbIdqt2NSM4xTWd6ZtlnXKSFve5rZgxGR9D50Col1CrvyE0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787655806; c=relaxed/simple;
	bh=7+ZmvUeSm4Z7dHGgpNwpwyWm+rkXXfNFwX6xpT+pSUU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UlI/mB7rMNspH722/Xj7mJpWoS9CPWpoKYVilFMdRO07d8cPPjpg+3wbKDiJlmthqtYBDL5zOSgBoHGxJU5c2tvzxfwAk2csixa7hV9/ZgjVMCEDWoRcFmrqczAQsS6asxEfF3GJXt2hLisv7DzkkdPds6NcQHbgtb+xTyBdzEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eWo6iDNT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eWo6iDNT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7451F000E9;
	Tue, 25 Aug 2026 11:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787655803;
	bh=rS+huXssvfUzOq5GM+B2kRgyylpaFCfJGpxdo5Hfv3w=;
	h=Subject:To:Cc:From:Date;
	b=eWo6iDNTgCJz/Rwvoxi1zqeNcLF+mpUTzmMpmJpblLT+zdN6iIe8LxLozLMgrG3IL
	 pQlNUhFlhNaRBIBGj0zncRyJ7ZpuaLFQb1uVgExkubOf3qTgYv6+G5iBePQmnIGh/s
	 mWcR5p3JCSTkAn32MQiMPNYAme9CR7v3Gh9eOeZI=
Subject: FAILED: patch "[PATCH] HID: pidff: fix OOB write when hid->inputs is empty" failed to apply to 6.12-stable tree
To: baul.lee@xbow.com,federico.kirschbaum@xbow.com,jkosina@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 25 Aug 2026 13:03:17 +0200
Message-ID: <2026082517-petroleum-anaerobic-3fd3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 67bb1074e3d2d12fa059a9cc707e89398a4e4704
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082517-petroleum-anaerobic-3fd3@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 67bb1074e3d2d12fa059a9cc707e89398a4e4704 Mon Sep 17 00:00:00 2001
From: Baul Lee <baul.lee@xbow.com>
Date: Sun, 26 Jul 2026 15:25:03 +0900
Subject: [PATCH] HID: pidff: fix OOB write when hid->inputs is empty

hid_pidff_init_with_quirks() derives its input_dev from

	list_entry(hid->inputs.next, struct hid_input, list)

without first checking that hid->inputs is non-empty.  The list member
of struct hid_input is at offset 0, so on an empty list list_entry()
yields &hid->inputs itself and the following hidinput->input load reads
an unrelated member of struct hid_device.  dev is then a type-confused
pointer, and force-feedback init writes through it: each
set_bit(FF_*, dev->ffbit) stores 8 bytes at dev + 192, past the end of
the object dev actually aliases, and input_ff_create() adds further
writes of a heap pointer and two function pointers.

Until hid-universal-pidff the only caller was hid_pidff_init() from
usbhid, which runs under HID_CLAIMED_INPUT and therefore always has at
least one hid_input.  universal_pidff_probe() starts the device with
HID_CONNECT_DEFAULT & ~HID_CONNECT_FF and then calls
hid_pidff_init_with_quirks() directly whenever the descriptor carries a
PID usage page, bypassing that gate.  A report descriptor whose only
application collection is on HID_UP_PID leaves hid->inputs empty while
hid_connect() still succeeds through the hidraw claim, so probe reaches
the unguarded list_entry().

The write happens in the USB probe path, on the hotplug workqueue, so
plugging in a malicious device is enough to trigger it; no attacker
software and no logged-in user are required.  KASAN reports an 8-byte
out-of-bounds write in hid_pidff_init_with_quirks() reached from
universal_pidff_probe().

Check for an empty list before deriving dev and return -ENODEV, as the
other HID force-feedback drivers already do.  universal_pidff_probe()
propagates the error and unwinds.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: f06bf8d94fff ("HID: Add hid-universal-pidff driver and supported device ids")
Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
Reported-by: Baul Lee <baul.lee@xbow.com>
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index 5f4395f7c645..22951b7ecd17 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -1539,13 +1539,20 @@ static int pidff_check_autocenter(struct pidff_device *pidff,
 int hid_pidff_init_with_quirks(struct hid_device *hid, u32 initial_quirks)
 {
 	struct pidff_device *pidff;
-	struct hid_input *hidinput =
-		list_entry(hid->inputs.next, struct hid_input, list);
-	struct input_dev *dev = hidinput->input;
+	struct hid_input *hidinput;
+	struct input_dev *dev;
 	struct ff_device *ff;
 	int max_effects;
 	int error;
 
+	if (list_empty(&hid->inputs)) {
+		hid_err(hid, "no inputs found\n");
+		return -ENODEV;
+	}
+
+	hidinput = list_first_entry(&hid->inputs, struct hid_input, list);
+	dev = hidinput->input;
+
 	hid_dbg(hid, "starting pid init\n");
 
 	if (list_empty(&hid->report_enum[HID_OUTPUT_REPORT].report_list)) {

