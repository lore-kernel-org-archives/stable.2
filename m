Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECF54BB5D4
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 08:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790671607; cv=none; b=frlfWrmU6LgA3NB3KzzcsT4wUbtlS6bpGxuqVJeUI8tVzTKuBDDBvRnvGJf3mfweHhRtjjpvBs6TTD+Yl5sKkg8uNgAVg4hId7rLbMzuo2Sx+xCVgXpmX4ZlU1b0BPH/+4gFSQN1QjS9xUL8cl2IAYPNsIiTNV1hmcB6cOv/sBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790671607; c=relaxed/simple;
	bh=7Itl09WsY2VeQLfM0LkS6DDEq3ZuHvvRHKqsF14prIo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XmPa97sUeLN0OfmBlZdO9Bwg9erj1GyZd/x10p4wzjBs2eXVRFg5MbORBIIYBhlz/IWw8U6aWG38DuGCsCkSlT7UcJwqKW8mDo8uRAqz8Z+xIa9VLHh2qSviPCq7NkAfhs16lr2tHjZMZ4xGOj91VfVw84DoKswMU680ymL1DY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bGHRvo8W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bGHRvo8W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C321F00898;
	Tue, 29 Sep 2026 08:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790671600;
	bh=VjOqlxkXdIVgxUHm0tJzrKDwh2E5OjiO2TkFz6LY46w=;
	h=Subject:To:Cc:From:Date;
	b=bGHRvo8WdZBzv9GxZxjRfNi1NTa+sjb9LOxQzCjxPcKCv5u1cmw4o7us/x3xxs/7Y
	 JL6FOfi9Eb9L9OoWw3tv9d/iASI3NcakaKra1losos+wP61zO9bEkt23fWAlOpnrET
	 U8f5dZXUmD3ZwUPpBbv8H92nqB+KCyCYuau9gRMg=
Subject: FAILED: patch "[PATCH] HID: alps: unregister DualPoint Stick input device on remove" failed to apply to 6.1-stable tree
To: chenchangcheng@kylinos.cn,jkosina@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 10:43:57 +0200
Message-ID: <2026092957-hanky-stipend-aaa1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x aa9dde93e05a837645fdfd577eea71f0733f0694
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092957-hanky-stipend-aaa1@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From aa9dde93e05a837645fdfd577eea71f0733f0694 Mon Sep 17 00:00:00 2001
From: Chen Changcheng <chenchangcheng@kylinos.cn>
Date: Fri, 14 Aug 2026 15:06:20 +0800
Subject: [PATCH] HID: alps: unregister DualPoint Stick input device on remove

alps_input_configured() allocates a second input device ("DualPoint
Stick") with input_allocate_device() and registers it, but the
alps_driver struct has no .remove handler and input2 is not tracked in
hdev->inputs.  The default remove path (hid_hw_stop -> hidinput_disconnect)
only iterates hdev->inputs, so input2 is never unregistered and leaks
on every device removal.

Add a .remove handler that stops the device first (preventing URB
callbacks from touching input2 during teardown) and then unregisters
input2.

Fixes: 2562756dde55 ("HID: add Alps I2C HID Touchpad-Stick support")
Cc: stable@vger.kernel.org
Signed-off-by: Chen Changcheng <chenchangcheng@kylinos.cn>
Signed-off-by: Jiri Kosina <jkosina@suse.com>

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index 67179e3fe39b..370635f5b704 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -823,6 +823,24 @@ static int alps_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	return 0;
 }
 
+static void alps_remove(struct hid_device *hdev)
+{
+	struct alps_dev *data = hid_get_drvdata(hdev);
+
+	/*
+	 * input2 ("DualPoint Stick") is allocated separately and is not
+	 * tracked in hdev->inputs, so the default remove path
+	 * (hid_hw_stop -> hidinput_disconnect) does not unregister it.
+	 *
+	 * Stop the device first so that no URB callback can touch input2
+	 * while it is being unregistered, then drop it explicitly.
+	 */
+	hid_hw_stop(hdev);
+
+	if (data->input2)
+		input_unregister_device(data->input2);
+}
+
 static const struct hid_device_id alps_id[] = {
 	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY,
 		USB_VENDOR_ID_ALPS_JP, HID_DEVICE_ID_ALPS_U1_DUAL) },
@@ -845,6 +863,7 @@ static struct hid_driver alps_driver = {
 	.input_configured	= alps_input_configured,
 	.resume			= pm_ptr(alps_post_resume),
 	.reset_resume		= pm_ptr(alps_post_reset),
+	.remove			= alps_remove,
 };
 
 module_hid_driver(alps_driver);

