Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5EC3A641C
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 18:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684291; cv=none; b=F33nFzXmvx7LFSeFEZrKzZyf5u2mCurOjboATcmiVuFaYYZEh05EEViliViOr+Ib+kP6S6CSHNHyosg4bf/EihEnB4f1BI8IMzwlruDbk2uWZKPoFSnnDXgfu8StZhmiGzp80/v+muAHXO20Ow/3yAQ+ZylSWAKp8S0o+GLFxRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684291; c=relaxed/simple;
	bh=nVzyh0Sos2aqlaKPrQrvfd6NVastkaOzAxjwyx7xdAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LX+M+IkKfwg6V1hm8ShIQy8w81rb+B6RVTp+pcFN8NiYL7WNMaitzWXUdj8VscC2gFjers02S+d1dkObFoAJMyjaUwOOBLQ/15+H2CsioNCSvOtCUxX+Fa4MuG7lD+az8Ct7n6FK93nabeiQfvQ3BzC4cZqZuePliBj/DJD/EG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0ns1zDS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0ns1zDS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818C01F00893;
	Fri,  5 Jun 2026 18:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780684289;
	bh=/nwzTpR3yg+mxGyojc44awVpp58qMTeJQqA7eaTe0mI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a0ns1zDSsIylNJ6WENrH8qa7SWDXVfDr4ZCHwLrzKzLQtMtNl5rqX23OokjSuYriA
	 eAgBn4dTmccQFTroUPjw73tGzeCyGuNm17es2ZMtpngvWLJClCJe6C3lH/8PPuducB
	 sELLCnFX9p/sy3sKOud1IOxUXOg48vPKt1IzwAi7m/uO9OJvmUEoBiHZJtvb3aZPd9
	 BgYsG7FlqGr4BbN3TmmuEvnJmnkKvzXDZmxjNaVioQEtD9eXrXIBuQxR5YReNF6tB2
	 kghf0XcV2vGCNV5gokklXiI+ufjO89F8mDniZIHrcyTc77M8ZiTH/nemJ1Y/xoW/GH
	 KzGT16KnqFSmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kai Aizen <kai.aizen.dev@gmail.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] usb: gadget: uvc: hold opts->lock across XU walks in uvc_function_bind
Date: Fri,  5 Jun 2026 14:31:27 -0400
Message-ID: <20260605183127.2055332-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060426-many-dipper-76b1@gregkh>
References: <2026060426-many-dipper-76b1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kai Aizen <kai.aizen.dev@gmail.com>

[ Upstream commit 68aa70648b625fa684bc0b71bbfd905f4943ca20 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_uvc.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index 37c33cab208a77..e0182d4eca2c77 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -762,6 +762,16 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
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
@@ -779,7 +789,7 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 				 ARRAY_SIZE(uvc_en_us_strings));
 	if (IS_ERR(us)) {
 		ret = PTR_ERR(us);
-		goto error;
+		goto error_unlock;
 	}
 
 	uvc_iad.iFunction = opts->iad_index ? cdev->usb_strings[opts->iad_index].id :
@@ -793,14 +803,14 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 
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
@@ -811,23 +821,25 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
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
 
+	mutex_unlock(&opts->lock);
+
 	/* Preallocate control endpoint request. */
 	uvc->control_req = usb_ep_alloc_request(cdev->gadget->ep0, GFP_KERNEL);
 	uvc->control_buf = kmalloc(UVC_MAX_REQUEST_SIZE, GFP_KERNEL);
@@ -859,6 +871,8 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 
 	return 0;
 
+error_unlock:
+	mutex_unlock(&opts->lock);
 v4l2_error:
 	v4l2_device_unregister(&uvc->v4l2_dev);
 error:
-- 
2.53.0

