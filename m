Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038F739AD33
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 08:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790671600; cv=none; b=jJLNnzHqPGmEcbWPJj15t0LeVh83b/T3/+H6+MwP7qaKedkHEURKgI0wqUxWf3At1d9izCYCGdtzB64G1XmgZcfKga6DX49IvXwMRoNPE+oE+XT40GdL8h3Ft+DpwFcN52mPo7tbcpTvvzZTi2ZidJbiWmJjQjrqHYJ7UQj+8ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790671600; c=relaxed/simple;
	bh=jWjktxLxYrcc2w0h0us1jhAIHwWI0O/pSs9cLRh0cBY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tTM7ch/8C5pnG8kyDwsldlPxGxahyI9t4SjspK4CvnT+FiENtQ08eybcQwPxga2g/CkqBlzbdisW3cyItU+0YVPn61bZbdb9X7/z/0vvScrKdtniBOW5kKr26qyqg29YP6/xGLJAfZYlVyjOv9mdk1+eLFrMPak9wPtmQBfcdOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iVoDj41P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iVoDj41P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8B51F000FF;
	Tue, 29 Sep 2026 08:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790671591;
	bh=LtcL0wiIZUBDquhNTqJ2UyKNpfRzaAOo7ho5BEOnfyI=;
	h=Subject:To:Cc:From:Date;
	b=iVoDj41P6uR/Ne0wsB8i/FnuGkMoYc2b1klKivoVb9CRqzIVsxt7BK9/JnmE5RU0+
	 5AKOEcr7FV+IEuRsNYxAms7eRUhVGx5GPZe9xEDAPqoChwHJoWzhtuGvWXBJaz3WJv
	 JRgDOgm8V3MY4yAjPjVi95FrRgUbqUci61qZeYfg=
Subject: FAILED: patch "[PATCH] HID: alps: unregister DualPoint Stick input device on remove" failed to apply to 6.18-stable tree
To: chenchangcheng@kylinos.cn,jkosina@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 10:43:54 +0200
Message-ID: <2026092954-curled-shabby-13d3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x aa9dde93e05a837645fdfd577eea71f0733f0694
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092954-curled-shabby-13d3@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

