Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3394071D7
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688783; cv=none; b=bXzlfSS0y7e41Ha3lPtWPO+q4VZScn09Sc7wj6csCPx0f9SzgtiSkkWITEGqqgeMOtNyE51FH5gi02BmNFF5w3iVH5NDrSEDcb0E4yaw9C7byajLZqvsETRYBu5hjfN4y7XEQTBgcVs98J6gwn8QZ7UJPiqOOYghjggMfjI1W+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688783; c=relaxed/simple;
	bh=THdJEmWjtbsFcHQV858qggW6M06W/t9U1YDE6KHAUf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/hESlrRmcqICA/5Og5EVEIZunLaOkLDimB+YrzeDw6J6IqObKk/vydVJhZl3RrQ76+/8QwjFHMcaPLj5JA0wyOXjfniI/Rt/YGh324wfEVFoP/cMKwDQAmgcG2yTVoJtfeJa8EFa8paQ6ugSNmTWuS9oBUKEO62CyzVBfDmN+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Emc3o4xh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Emc3o4xh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE0F1F00893;
	Fri,  5 Jun 2026 19:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688782;
	bh=y1WMEs4LNcDXaX3591aQDMUWlmqfQu09Swc4gqWECJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Emc3o4xh4nT2KxgaGRp7Nwr7FydBimwpOjP0iiO04OtbOwUSLuj7uLosxCvA+UtT1
	 q38vx4PSPIxzD8PRnpUJce7j0GI5LEZlgIlNdoKjqcAOH+fyUeEG+byAXYImx+qf3Z
	 h0oA7xev+pG36T5zUcgWJbVDjFCBwbqkPflQ6AWcZ0CxJfbhfJ3Ixq5K17/vI/VUK3
	 pvzqSgR0FcYFua9n7BSsX2qkHa6evNVWcBALOzSRitXXen8GUzIEO5FHmtaz7RAVm1
	 Ef9eJvkm6DdCvSoxFjn+UxjP4D99A9zN7pG2alKBuAewrh+U50gYA4mZhCwgV4WFz1
	 r+inZRw7xvfoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: John Keeping <john@metanate.com>,
	Lee Jones <lee@kernel.org>,
	Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] usb: gadget: f_hid: tidy error handling in hidg_alloc
Date: Fri,  5 Jun 2026 15:46:19 -0400
Message-ID: <20260605194620.2186017-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060453-blazer-sublet-0c66@gregkh>
References: <2026060453-blazer-sublet-0c66@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: John Keeping <john@metanate.com>

[ Upstream commit 944fe915d00d3cb1bacb1e77cabfb6dc82e6f8b8 ]

Unify error handling at the end of the function, reducing the risk of
missing something on one of the error paths.

Moving the increment of opts->refcnt later means there is no need to
decrement it on the error path and is safe as this is guarded by
opts->lock which is held for this entire section.

Tested-by: Lee Jones <lee@kernel.org>
Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Reviewed-by: Lee Jones <lee@kernel.org>
Signed-off-by: John Keeping <john@metanate.com>
Link: https://lore.kernel.org/r/20221122123523.3068034-4-john@metanate.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 4f88d65def6f ("usb: gadget: f_hid: fix device reference leak in hidg_alloc()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_hid.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index e3738a1aa9f483..7c5916caf61b30 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -1265,7 +1265,6 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 	opts = container_of(fi, struct f_hid_opts, func_inst);
 
 	mutex_lock(&opts->lock);
-	++opts->refcnt;
 
 	spin_lock_init(&hidg->write_spinlock);
 	spin_lock_init(&hidg->read_spinlock);
@@ -1278,11 +1277,8 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 	hidg->dev.class = hidg_class;
 	hidg->dev.devt = MKDEV(major, opts->minor);
 	ret = dev_set_name(&hidg->dev, "hidg%d", opts->minor);
-	if (ret) {
-		--opts->refcnt;
-		mutex_unlock(&opts->lock);
-		return ERR_PTR(ret);
-	}
+	if (ret)
+		goto err_unlock;
 
 	hidg->bInterfaceSubClass = opts->subclass;
 	hidg->bInterfaceProtocol = opts->protocol;
@@ -1293,14 +1289,13 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 					    opts->report_desc_length,
 					    GFP_KERNEL);
 		if (!hidg->report_desc) {
-			put_device(&hidg->dev);
-			--opts->refcnt;
-			mutex_unlock(&opts->lock);
-			return ERR_PTR(-ENOMEM);
+			ret = -ENOMEM;
+			goto err_put_device;
 		}
 	}
 	hidg->use_out_ep = !opts->no_out_endpoint;
 
+	++opts->refcnt;
 	mutex_unlock(&opts->lock);
 
 	hidg->func.name    = "hid";
@@ -1315,6 +1310,12 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 	hidg->qlen	   = 4;
 
 	return &hidg->func;
+
+err_put_device:
+	put_device(&hidg->dev);
+err_unlock:
+	mutex_unlock(&opts->lock);
+	return ERR_PTR(ret);
 }
 
 DECLARE_USB_FUNCTION_INIT(hid, hidg_alloc_inst, hidg_alloc);
-- 
2.53.0

