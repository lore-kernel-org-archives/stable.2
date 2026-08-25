Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE9246A60D
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 13:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787663651; cv=none; b=VVMdwdPSsRTnyDvCbzn5lE6O/Kizdtd1jjdwDSG+NvSJJboHHClJqLiTwSYi0F/NB57FsQgpxprS7/L0LxU7YeEwyTp77qbn9JdNm2xsrv347MMPBQF2IC1louY1UzISfl4FAlaOdpHpqC2bDBM8VlQvL3s6d+56k87K5bO0WSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787663651; c=relaxed/simple;
	bh=dv5Xmjrnl9LpvVUIuYdwsKSdNqLuF+d1ivpQdbimJTc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Co2FRpTlBqP1t1VitOL0VF0Nh0Vrpo2/FezE9M2ZRy106UEBkU0j4dpUJqDxbaW6kb5O1libktSha1xLnBwYNLgoWeYvalF4t69OxvcKdZ36YAAx4exGzpfzwO6/hqU8ferfiOsTQY3didSe7AWiBPgn6wCB49qDRQSyChJLqaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z9YqkY85; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z9YqkY85"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4EA1F00A3D;
	Tue, 25 Aug 2026 13:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787663645;
	bh=0RsYSwFe87gC6x7pPCnjPLfJG1qaKB6M2W7bIrwanIA=;
	h=Subject:To:Cc:From:Date;
	b=Z9YqkY852F840c14xeMvgzUVzlRUOS1PCWSZSd5a0W3U6GjwyrrcQiHRf3ic4ouYO
	 uzCiLkIxu3AZHy5JS75oINvVxZxYhoWijuraCOSOODa4buT4sQSOCw/SnIJH+ch4JW
	 8qHYVTpaOoksyOirlLg6y02+/NCuayn2rF4eQLsE=
Subject: FAILED: patch "[PATCH] HID: asus: fix missing hid_is_usb() check" failed to apply to 6.12-stable tree
To: jannh@google.com,jkosina@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 25 Aug 2026 15:13:50 +0200
Message-ID: <2026082550-county-disabled-f55a@gregkh>
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
git cherry-pick -x 02bf61dfb44f17ec187d1da1a82495951bbd12df
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082550-county-disabled-f55a@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 02bf61dfb44f17ec187d1da1a82495951bbd12df Mon Sep 17 00:00:00 2001
From: Jann Horn <jannh@google.com>
Date: Fri, 3 Jul 2026 17:45:52 +0200
Subject: [PATCH] HID: asus: fix missing hid_is_usb() check

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

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 3a3de999514c..f6e882a1cee6 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -950,7 +950,7 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
 			return ret;
 	}
 
-	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
+	if ((drvdata->quirks & QUIRK_ROG_ALLY_XPAD) && hid_is_usb(hdev)) {
 		intf = to_usb_interface(hdev->dev.parent);
 		udev = interface_to_usbdev(intf);
 		validate_mcu_fw_version(hdev,

