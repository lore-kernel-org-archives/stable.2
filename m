Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A13477284
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330165; cv=none; b=vCwRvf4R994+OVIzWOqQ6FPm9+Su/xyRZtyolF8X2UNVSUYx3iBGlGrhK8Rn/4OoI31qa9YA+0uIYs5eRN2aUZ+P3PiL3IRPjIG1/HIMCoXUbA3TaJGYJ6jRSTuyd5cKtQVuRnYiCQdf3opzMOO+Eia7fashPYOWzGzmXm2/nJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330165; c=relaxed/simple;
	bh=Yq+Dm1HKI0aV8mBwFseYNBxM0O6T43Ded3c41oEbtS4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=vBZFNqORj8Gt2FEYnjbfI1B1k8WGVLiuvT/bazquM71VPwrjnbI4Yht3JgfpuD7ImsjrEJ8kQvnNj0tR1/2O9FALCLcYQHs/88sfjCt4WjI4AUP2cEC0P89hKBmf/desWIpIdtMLh8hd5wt5DNRmfTwZcdQ9SFfOtDrUTSaYvJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MYpOgin0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MYpOgin0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238431F000E9;
	Wed, 29 Jul 2026 13:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785330162;
	bh=0RkzEi3wL6CH6LgPJt41ztqd1lupMz02fgM9Z2mgF9c=;
	h=Subject:To:Cc:From:Date;
	b=MYpOgin0TfI069femA1vFkBtfPWkNu4/j7gKwylPLfKswkqAK6nwtLLQiGTMSlVmk
	 deuT2MFZE27dhEctjjbAOu1hLxzzce94jlXAyfTAw83u9r1XGOW0vtpZ/zd+RsbfcF
	 Wz1lpeW9evypLbmHofTF/kk9IZDgHvsGsxrWDh+s=
Subject: FAILED: patch "[PATCH] media: v4l2-fwnode: Fix subdev owner overwritten in" failed to apply to 5.10-stable tree
To: mirela.rabulea@nxp.com,Frank.Li@nxp.com,laurent.pinchart+renesas@ideasonboard.com,sakari.ailus@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:02:29 +0200
Message-ID: <2026072929-fresh-parsley-3ec6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 06cb687a5132fcffe624c0070576ab852ac6b568
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072929-fresh-parsley-3ec6@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 06cb687a5132fcffe624c0070576ab852ac6b568 Mon Sep 17 00:00:00 2001
From: Mirela Rabulea <mirela.rabulea@nxp.com>
Date: Fri, 22 May 2026 17:31:20 +0300
Subject: [PATCH] media: v4l2-fwnode: Fix subdev owner overwritten in
 v4l2_async_register_subdev_sensor()

The v4l2 helper v4l2_async_register_subdev_sensor() calls
v4l2_async_register_subdev(), which is a macro that expands to
__v4l2_async_register_subdev(sd,THIS_MODULE). Since the macro is expanded
inside v4l2-fwnode.c, THIS_MODULE resolves to the v4l2-fwnode module
rather than the sensor driver module that originally set sd->owner. When
v4l2-fwnode is built-in, THIS_MODULE evaluates to NULL, which then
overwrites the sensor driver's owner with NULL.

This causes the problem that the sensor module's reference count is never
incremented during async registration, so the module can be removed while
the subdevice is still in use by a notifier (e.g., a CSI-2 receiver
bridge driver).

Fix this by renaming v4l2_async_register_subdev_sensor() to
__v4l2_async_register_subdev_sensor() with an added explicit module
argument and introducing a wrapper macro:
    #define v4l2_async_register_subdev_sensor(sd) \
        __v4l2_async_register_subdev_sensor(sd, THIS_MODULE)

This ensures the sensor driver module is properly referenced even when
the sensor driver does not init the owner field before calling
v4l2_async_register_subdev_sensor() and prevents premature module removal.

Fixes: aef69d54755d ("media: v4l: fwnode: Add a convenience function for registering sensors")
Cc: stable@vger.kernel.org
Suggested-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/linux-media/20240315073125.275501-2-sakari.ailus@linux.intel.com/
Signed-off-by: Mirela Rabulea <mirela.rabulea@nxp.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index 77f3298821b5..62a3a452f788 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -1256,7 +1256,7 @@ v4l2_async_nf_parse_fwnode_sensor(struct device *dev,
 	return 0;
 }
 
-int v4l2_async_register_subdev_sensor(struct v4l2_subdev *sd)
+int __v4l2_async_register_subdev_sensor(struct v4l2_subdev *sd, struct module *module)
 {
 	struct v4l2_async_notifier *notifier;
 	int ret;
@@ -1282,7 +1282,7 @@ int v4l2_async_register_subdev_sensor(struct v4l2_subdev *sd)
 	if (ret < 0)
 		goto out_cleanup;
 
-	ret = v4l2_async_register_subdev(sd);
+	ret = __v4l2_async_register_subdev(sd, module);
 	if (ret < 0)
 		goto out_unregister;
 
@@ -1300,7 +1300,7 @@ int v4l2_async_register_subdev_sensor(struct v4l2_subdev *sd)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(v4l2_async_register_subdev_sensor);
+EXPORT_SYMBOL_GPL(__v4l2_async_register_subdev_sensor);
 
 MODULE_DESCRIPTION("V4L2 fwnode binding parsing library");
 MODULE_LICENSE("GPL");
diff --git a/include/media/v4l2-async.h b/include/media/v4l2-async.h
index f26c323e9c96..54a2d9620ed5 100644
--- a/include/media/v4l2-async.h
+++ b/include/media/v4l2-async.h
@@ -333,8 +333,10 @@ int __v4l2_async_register_subdev(struct v4l2_subdev *sd, struct module *module);
  * An error is returned if the module is no longer loaded on any attempts
  * to register it.
  */
+#define v4l2_async_register_subdev_sensor(sd) \
+	__v4l2_async_register_subdev_sensor(sd, THIS_MODULE)
 int __must_check
-v4l2_async_register_subdev_sensor(struct v4l2_subdev *sd);
+__v4l2_async_register_subdev_sensor(struct v4l2_subdev *sd, struct module *module);
 
 /**
  * v4l2_async_unregister_subdev - unregisters a sub-device to the asynchronous

