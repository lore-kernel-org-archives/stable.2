Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6509A4B0CBE
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443424; cv=none; b=mgzitCKbjzDvyC8IhK3jLRl1Z2Nc64ZpDqLnLkjQUqqLP6M9F3fD+SZto5z16wYchQxrw8gnQLrL+3J6dyxTq2Fq9p7LO4BrYM/Jh64wnQ/smFeXzzyZGrVwXpnjBDlunvW7Qgz5jIG7dPM0snTUx0a6/MbykPsFC3x0wIA61dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443424; c=relaxed/simple;
	bh=IAcidPlUOFnYZjH24RIJPQP9Zi7RU2gCW0GnFw2QzSw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cTygKUMc2YN1AEFSpkRVbd0Dej5XGtdoVzfCEaTTz+D6BCQXv5SAU9Z3VqrnO0ROH8B4ozn7TzXq+u7rJWPbRV5xnJ9Wf514N6Os2nu77He+rEvpeMBq8EicAsK8uehy7PBGh3Q3l0TLddaY9Ho0F7ff6tXsevtUQb+3QWOdEDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UVj3Fxqo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UVj3Fxqo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8EA21F00A3A;
	Thu,  3 Sep 2026 13:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788443407;
	bh=HUgxo8OuUIidDY8KrrtjQ2PeoV9gPLMqAyA/cHWGLTU=;
	h=Subject:To:Cc:From:Date;
	b=UVj3FxqoP7zYPwG2ePkK4YZ53pBp9PztBBnWIeuOLGEpYHtEBM847Rn7bJ2icFkiI
	 zw1+RfnNV/kfl76TD1UbvIBTp3WrfPTG1tLaKjMJ+phGp2IDei82Tm/TkNFjMXJYcA
	 kkuZHmWjsffa2eSmtYu0cNY0tOQwiw9RYFpsxrFw=
Subject: FAILED: patch "[PATCH] HID: universal-pidff: stop the device when force-feedback" failed to apply to 6.12-stable tree
To: baul.lee@xbow.com,jkosina@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:28:56 +0200
Message-ID: <2026090356-slit-cash-4d51@gregkh>
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
git cherry-pick -x ce08c5555cabcd444d8b77fa69a7cb68bb05f611
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090356-slit-cash-4d51@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ce08c5555cabcd444d8b77fa69a7cb68bb05f611 Mon Sep 17 00:00:00 2001
From: Baul Lee <baul.lee@xbow.com>
Date: Wed, 29 Jul 2026 23:24:32 +0900
Subject: [PATCH] HID: universal-pidff: stop the device when force-feedback
 init fails

universal_pidff_probe() starts the device with hid_hw_start() and then, if
force-feedback initialisation fails, returns the error through a label that
only does "return error".  The device is left started.

The HID core does not unwind on the driver's behalf.  __hid_device_probe()
releases the devres group, closes the report and clears hdev->driver:

	if (ret) {
		devres_release_group(&hdev->dev, hdev->devres_group_id);
		hid_close_report(hdev);
		hdev->driver = NULL;
	}

The hidraw character device that hid_hw_start() registered through
hid_connect() is allocated with kzalloc() and added with cdev_device_add(),
so it is not devres-managed and survives that.  With hdev->driver NULL,
hid_device_remove() skips hid_hw_stop() as well, because it only unwinds
while a driver is still attached.  The registration therefore outlives the
device on both paths.

Opening the surviving /dev/hidrawX writes into freed memory.  KASAN reports
a use-after-free write from hidraw_open() -> hid_hw_open() -> the
transport's open callback, which takes a spinlock inside the freed object.
A descriptor that carries a PID usage page and no input reports is enough:
hidraw claims the device so hid_hw_start() succeeds, while hid->inputs
stays empty so force-feedback init fails.  The other failure returns in
hid_pidff_init_with_quirks() - no output reports, an allocation failure,
pidff_init_fields(), pidff_check_autocenter(), an unusable effect count,
input_ff_create() - all reach the same label.

Stop the device on that path.  hid-dr.c and hid-emsff.c, which start the
device with the same HID_CONNECT_DEFAULT & ~HID_CONNECT_FF mask, already do
this.  The two earlier gotos must keep returning without hid_hw_stop(),
since neither has a started device, so give the path that fails after the
start its own label.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: f06bf8d94fff ("HID: Add hid-universal-pidff driver and supported device ids")
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>

diff --git a/drivers/hid/hid-universal-pidff.c b/drivers/hid/hid-universal-pidff.c
index 549dac555d40..60180467a0bf 100644
--- a/drivers/hid/hid-universal-pidff.c
+++ b/drivers/hid/hid-universal-pidff.c
@@ -104,12 +104,14 @@ static int universal_pidff_probe(struct hid_device *hdev,
 	error = init_function(hdev, id->driver_data);
 	if (error) {
 		hid_warn(hdev, "Error initialising force feedback\n");
-		goto err;
+		goto err_stop;
 	}
 
 	hid_info(hdev, "Universal pidff driver loaded successfully!");
 
 	return 0;
+err_stop:
+	hid_hw_stop(hdev);
 err:
 	return error;
 }

