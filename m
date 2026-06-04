Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D0F255E43
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 10:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780570045; cv=none; b=mfO3trt8hxQvPT+yb4mcsYy+DYSY6BNmgK8iiHzuQEaSwDHNLnIQ4WbimgVPHmRhDfqHaCSUMQWlDte2IMqg6Dkcp7dKsRFIdct1PvzSWoELatMxc3AF3vSVhRp6FQO6HPkeWHiFu+Q+MDJdNs5sc3mlBZZwC8BtJmMA6Rle5wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780570045; c=relaxed/simple;
	bh=VW7YzEor4HC2klB7NQ5QQWexifuu7qEggarYFZ16WVw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qmskgTtVferKQdb1v3HB6mOm3K7RyeUKjMr4YK6TpsmxGf+gdrshSxQLQ9Veu3XyoozxAYGglQu2ojBY5L89CcD/XQOv3OsM7woe7JUSN8XpF7kVUX50XHKULVRt5TbP9Ndi95++rma9cUO2e2hx8cNUgKzi/PT1iSCF1bHlkPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vVmCuHtW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vVmCuHtW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BEA1F00893;
	Thu,  4 Jun 2026 10:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780570043;
	bh=J3dn5IFkggiK2cZKg6MRDpD5sxdAsM7lNDk3CSmnyug=;
	h=Subject:To:Cc:From:Date;
	b=vVmCuHtWBoy+2tazVKOPJSVnfIYjJWysl0HB3VFV9VoFMeX35ztvfQ48TwHmFxT3/
	 SFoT6KRXjJHK2Xyon8qzVKW6T0zu/517sMkyiH3wlbAUoBLBr/U7Ty1sWf1USfffVM
	 SVw/re423CdttevFhBT+/FpIzJ0qY+UpvnJLrKC8=
Subject: FAILED: patch "[PATCH] usb: gadget: uvc: hold opts->lock across XU walks in" failed to apply to 6.6-stable tree
To: kai.aizen.dev@gmail.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 12:46:26 +0200
Message-ID: <2026060426-many-dipper-76b1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 68aa70648b625fa684bc0b71bbfd905f4943ca20
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060426-many-dipper-76b1@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 68aa70648b625fa684bc0b71bbfd905f4943ca20 Mon Sep 17 00:00:00 2001
From: Kai Aizen <kai.aizen.dev@gmail.com>
Date: Thu, 30 Apr 2026 20:56:43 +0300
Subject: [PATCH] usb: gadget: uvc: hold opts->lock across XU walks in
 uvc_function_bind

uvc_function_bind() walks &opts->extension_units twice without holding
opts->lock:

  - directly, for the iExtension string-descriptor fixup loop;
  - indirectly, four times via uvc_copy_descriptors() (once per speed),
    where the helper iterates uvc->desc.extension_units (which aliases
    &opts->extension_units) to size and emit XU descriptors.

The configfs side (uvcg_extension_make / uvcg_extension_drop, in
drivers/usb/gadget/function/uvc_configfs.c) takes opts->lock around its
list_add_tail / list_del operations.  A privileged userspace process
that holds the configfs subtree open and writes the gadget UDC name
to bind the function while concurrently rmdir()'ing an extensions
subdir can race uvcg_extension_drop() against the bind-time list walks
and dereference a freed struct uvcg_extension.

Hold opts->lock from the start of the XU string-descriptor fixup
through the last uvc_copy_descriptors() call, releasing on the
descriptor-error path via a new error_unlock label that drops the
lock before falling through to the existing error label.  This
matches the locking discipline of the configfs callbacks and removes
the only remaining unsynchronised reader of the XU list during bind.

Reachability: only privileged processes that can mount configfs and
write to gadget UDC files can trigger the race, so this is a
correctness fix rather than a security boundary.

Fixes: 0525210c9840 ("usb: gadget: uvc: Allow definition of XUs in configfs")
Cc: stable <stable@kernel.org>
Signed-off-by: Kai Aizen <kai.aizen.dev@gmail.com>
Link: https://patch.msgid.link/20260430175643.67120-1-kai.aizen.dev@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index 8d404d88391c..73dc7e42875f 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -768,6 +768,16 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 	uvc_hs_streaming_ep.bEndpointAddress = uvc->video.ep->address;
 	uvc_ss_streaming_ep.bEndpointAddress = uvc->video.ep->address;
 
+	/*
+	 * Hold opts->lock across both the XU string-descriptor fixup below and
+	 * the descriptor-copy block further down.  Without this, configfs
+	 * uvcg_extension_drop() (which takes opts->lock) can race with the
+	 * list_for_each_entry() walks here and inside uvc_copy_descriptors(),
+	 * leading to a UAF on a freed struct uvcg_extension.  See
+	 * drivers/usb/gadget/function/uvc_configfs.c::uvcg_extension_drop().
+	 */
+	mutex_lock(&opts->lock);
+
 	/*
 	 * XUs can have an arbitrary string descriptor describing them. If they
 	 * have one pick up the ID.
@@ -785,7 +795,7 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 				 ARRAY_SIZE(uvc_en_us_strings));
 	if (IS_ERR(us)) {
 		ret = PTR_ERR(us);
-		goto error;
+		goto error_unlock;
 	}
 
 	uvc_iad.iFunction = opts->iad_index ? cdev->usb_strings[opts->iad_index].id :
@@ -799,14 +809,14 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 
 	/* Allocate interface IDs. */
 	if ((ret = usb_interface_id(c, f)) < 0)
-		goto error;
+		goto error_unlock;
 	uvc_iad.bFirstInterface = ret;
 	uvc_control_intf.bInterfaceNumber = ret;
 	uvc->control_intf = ret;
 	opts->control_interface = ret;
 
 	if ((ret = usb_interface_id(c, f)) < 0)
-		goto error;
+		goto error_unlock;
 	uvc_streaming_intf_alt0.bInterfaceNumber = ret;
 	uvc_streaming_intf_alt1.bInterfaceNumber = ret;
 	uvc->streaming_intf = ret;
@@ -817,30 +827,32 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 	if (IS_ERR(f->fs_descriptors)) {
 		ret = PTR_ERR(f->fs_descriptors);
 		f->fs_descriptors = NULL;
-		goto error;
+		goto error_unlock;
 	}
 
 	f->hs_descriptors = uvc_copy_descriptors(uvc, USB_SPEED_HIGH);
 	if (IS_ERR(f->hs_descriptors)) {
 		ret = PTR_ERR(f->hs_descriptors);
 		f->hs_descriptors = NULL;
-		goto error;
+		goto error_unlock;
 	}
 
 	f->ss_descriptors = uvc_copy_descriptors(uvc, USB_SPEED_SUPER);
 	if (IS_ERR(f->ss_descriptors)) {
 		ret = PTR_ERR(f->ss_descriptors);
 		f->ss_descriptors = NULL;
-		goto error;
+		goto error_unlock;
 	}
 
 	f->ssp_descriptors = uvc_copy_descriptors(uvc, USB_SPEED_SUPER_PLUS);
 	if (IS_ERR(f->ssp_descriptors)) {
 		ret = PTR_ERR(f->ssp_descriptors);
 		f->ssp_descriptors = NULL;
-		goto error;
+		goto error_unlock;
 	}
 
+	mutex_unlock(&opts->lock);
+
 	/* Preallocate control endpoint request. */
 	uvc->control_req = usb_ep_alloc_request(cdev->gadget->ep0, GFP_KERNEL);
 	uvc->control_buf = kmalloc(UVC_MAX_REQUEST_SIZE, GFP_KERNEL);
@@ -872,6 +884,8 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 
 	return 0;
 
+error_unlock:
+	mutex_unlock(&opts->lock);
 v4l2_error:
 	v4l2_device_unregister(&uvc->v4l2_dev);
 error:

