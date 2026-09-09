Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103C354B1D6
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 12:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955680; cv=none; b=Y8vAHizh1faUO27T7IQnffV9r57CHelYWeeD/A2qyyRqbeMBC9GCjbosixFVm2yYGeFbITlhl7Po+sA8vSKJEE3pl9cY1jysgCZ/b30piQp1sD7A28YZf/2xgu+uxCONilN9UFBjEC+V3Id1827KSZHjTdqWV4Ch85YlcwIw7Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955680; c=relaxed/simple;
	bh=HICezZUgJPAi8HrckCbiQHVBhy3qVa+7G5D1chudVe8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WWLtZmmMPh53TV6ru9TgkRwdKKWcNSqsVfHUDE4ytLAG2OFUW9nGcRVtEB7OIUMyHIFi6dxeupNkYxd1BL7vwE2iVxrALKQUz8cbglbRe+8jHU/7qBV4L1N9mSIRGsiSgnlPZwOoiTQgwryWcFp/XnAhgyN+kYNPkFxLNBSIyc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ylabf1ta; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ylabf1ta"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA571F00A3A;
	Wed,  9 Sep 2026 12:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788955679;
	bh=/1cbj/D2ldnyRa/V5KsexI6dWXb+q16pOizV0o0VJwM=;
	h=Subject:To:Cc:From:Date;
	b=ylabf1tasiJBN7/LgBiA/JPBBA60j5R96qTmC+Say/rxcHV0+K3sVr4GmK/ZtcZSF
	 wGS+tQvAEpyRR5M6/lQoMLKTKvV4rkAWwKzQA4JwZB9ncGPoTwQvVspXe1jSaV+vs8
	 g2T+pGSj5EZ8p3i4zfTCVqoppbPpTM/GuD6wfxdA=
Subject: FAILED: patch "[PATCH] drm/sysfb: simpledrm: Improve stride validation" failed to apply to 6.12-stable tree
To: tzimmermann@suse.de,javierm@redhat.com,mripard@kernel.org,stable@vger.kernel.org,treding@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 14:01:38 +0200
Message-ID: <2026090938-kissing-slacking-a098@gregkh>
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
git cherry-pick -x df6533f11688aa30be3bb883c7637f4ffdbb7cbd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090938-kissing-slacking-a098@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From df6533f11688aa30be3bb883c7637f4ffdbb7cbd Mon Sep 17 00:00:00 2001
From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Thu, 25 Jun 2026 11:39:36 +0200
Subject: [PATCH] drm/sysfb: simpledrm: Improve stride validation

Validate the computed stride against the maximum value INT_MAX.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Thierry Reding <treding@nvidia.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Fixes: 7bfa5c7b28d6 ("drm/simpledrm: Compute linestride with drm_format_info_min_pitch()")
Cc: <stable@vger.kernel.org> # v6.1+
Link: https://patch.msgid.link/20260625094509.157581-5-tzimmermann@suse.de

diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/simpledrm.c
index b4e91191a0ba..a899dfb747bf 100644
--- a/drivers/gpu/drm/sysfb/simpledrm.c
+++ b/drivers/gpu/drm/sysfb/simpledrm.c
@@ -703,9 +703,15 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
 		return ERR_PTR(-ENODEV);
 	}
 	if (!stride) {
-		stride = drm_format_info_min_pitch(format, 0, width);
-		if (drm_WARN_ON(dev, !stride))
+		u64 pitch = drm_format_info_min_pitch(format, 0, width);
+
+		if (drm_WARN_ON(dev, !pitch)) {
+			return ERR_PTR(-EINVAL); /* driver bug */
+		} else if (pitch > INT_MAX) {
+			drm_warn(dev, "stride of %llu exceeds maximum\n", pitch);
 			return ERR_PTR(-EINVAL);
+		}
+		stride = pitch;
 	}
 
 	sysfb->fb_mode = drm_sysfb_mode(width, height, width_mm, height_mm);

