Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6822BE05E
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 12:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955691; cv=none; b=CT93a6qrEB8AHb4ryg+o+E8KgaHs3IE44aiiuDE0ZVHmP6MZo5MDYOC18xHIxC4cRmIIKazhxFU8Rr8pkybKN8tD0rXLkpNgL4UZsEdCgd2C3FnG0yXTZyKkEr7AZ3LbG/t/RwoC/0bZ54qT8jzpzdu5I+87uOsa/HAB/6sntpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955691; c=relaxed/simple;
	bh=D3oVN/E931vVjlWySjSPnZzx0bWkRyt9lZ+NN1lStOE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cKNGXq8wbA/V779gVoZKY6VfCbU45ovPPNXR7jwFxMM+2n0En+/It8DpN7uYyV+5TwiSdtrrdCu0XTJLAT/+OsUqVaOVixFdkjkmxW4lRheDCHyVi1nVSQ0RYMT5bfboS5R0am+EavuqRXQ6sPyQi4KjbiIWKZCALkALKql4peQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AGjgWSJu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AGjgWSJu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18C31F00A3D;
	Wed,  9 Sep 2026 12:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788955690;
	bh=KFOhYnY8pbgRIDtttbtGwRtKl0BXX4GZ9ffzA/agQ2A=;
	h=Subject:To:Cc:From:Date;
	b=AGjgWSJuiSNXxAZ4p/yqqXIZ+vH3pdGJrVOhXHl6p/Uj27gQJfcUrjZ1dKI7oFNxN
	 ECBs4xhrnYM7O4w/ZZ4DWEUEZVQ5aXZgpeupKJQEjrc+UkcZcFyIhG6gSc7qB/U89v
	 o7e6sG+oBCj7kNSkbdvr9W0w2Dt3F0wDEnVCeq4U=
Subject: FAILED: patch "[PATCH] drm/sysfb: ofdrm: Fix integer overflow in fb_size calculation" failed to apply to 6.6-stable tree
To: oushixiong@kylinos.cn,stable@vger.kernel.org,tzimmermann@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 14:01:51 +0200
Message-ID: <2026090951-customary-distract-703c@gregkh>
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
git cherry-pick -x c6f48e59ece0123f6a11527ad4d89b21c2d65b87
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090951-customary-distract-703c@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c6f48e59ece0123f6a11527ad4d89b21c2d65b87 Mon Sep 17 00:00:00 2001
From: Shixiong Ou <oushixiong@kylinos.cn>
Date: Tue, 25 Aug 2026 18:41:34 +0800
Subject: [PATCH] drm/sysfb: ofdrm: Fix integer overflow in fb_size calculation

The framebuffer size calculation `fb_size = linebytes * height` can
overflow when both values are large (e.g., 46341 * 46341 > INT_MAX).
Since linebytes and height are both int types, the multiplication is
performed as int * int, which results in undefined behavior on overflow.

Use check_mul_overflow() to detect and prevent this overflow, consistent
with the approach used in simpledrm.c and corebootdrm.c.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: c8a17756c425 ("drm/ofdrm: Add ofdrm for Open Firmware framebuffers")
Cc: <stable@vger.kernel.org> # v6.2+
Link: https://patch.msgid.link/20260825104134.669676-1-oushixiong1025@163.com

diff --git a/drivers/gpu/drm/sysfb/ofdrm.c b/drivers/gpu/drm/sysfb/ofdrm.c
index 819aed466727..a6dc34b9ec0f 100644
--- a/drivers/gpu/drm/sysfb/ofdrm.c
+++ b/drivers/gpu/drm/sysfb/ofdrm.c
@@ -2,6 +2,7 @@
 
 #include <linux/aperture.h>
 #include <linux/of_address.h>
+#include <linux/overflow.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
@@ -913,7 +914,10 @@ static struct ofdrm_device *ofdrm_device_create(struct drm_driver *drv,
 			return ERR_PTR(-EINVAL);
 	}
 
-	fb_size = linebytes * height;
+	if (check_mul_overflow(linebytes, height, &fb_size)) {
+		drm_err(dev, "framebuffer size exceeds maximum\n");
+		return ERR_PTR(-EINVAL);
+	}
 
 	/*
 	 * Try to figure out the address of the framebuffer. Unfortunately, Open

