Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B2B54A7F3
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 12:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955689; cv=none; b=SU4TIs3bFAL7CSUU+wLW4abwSmaek4d3CSo/Lk4hoHdTueQrelXlTRX+06SnSnZuzNqcSRzwAZsU4j5QD7DX9iOCXhg3KWn45zeDSlOJP32jt9vWSU4AlmM/ahdHSxvZvQCqP4dXhXV6+9KamQFDqj5H+4DnNV0lGArJGx+K+Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955689; c=relaxed/simple;
	bh=hnOzKncDAkwqtkNCoQdx1RCdb/1Jrq8c9uZpsNl0EQQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZtVJt20rXYI13YZKWh5uoT+gJx6JQvvyN5eY909KUaboMDIBOUF7NA7lC8gBa5xYFGgpckkUkhrMfsZaJ+RyqzkxfeprgW0W5FYr8oKyNZ5w6cpg9cBo7ShTRUi4xEufe3SGlkagGZFHaJz/ltjA8fBmD4tTOW2FJlnekrzUHl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PfyMH5hj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PfyMH5hj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE19A1F00AC4;
	Wed,  9 Sep 2026 12:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788955687;
	bh=lmTCLj7b7HL/7dmyj5KlGfFNh9rQuusbZdAlnaKgwdM=;
	h=Subject:To:Cc:From:Date;
	b=PfyMH5hjqkREnE2cKXG90Z/VU1TAeUErvVlJGmqy5RLaDcSnBvoljtw1VsytrbY1f
	 eM0BkiCn/6+EwGdSwelBAtYYTqzST5D6epEGy284u6cSx94nPM1dVSF0Yt2NImeRDx
	 vzFmsxdqbW/bVHKo7fuAktvbASMXhhUjfk6s7LTM=
Subject: FAILED: patch "[PATCH] drm/sysfb: ofdrm: Fix integer overflow in fb_size calculation" failed to apply to 6.12-stable tree
To: oushixiong@kylinos.cn,stable@vger.kernel.org,tzimmermann@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 14:01:50 +0200
Message-ID: <2026090950-unstamped-slather-7c9d@gregkh>
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
git cherry-pick -x c6f48e59ece0123f6a11527ad4d89b21c2d65b87
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090950-unstamped-slather-7c9d@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

