Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43D64A0124
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819121; cv=none; b=Mh5s9IQm45CFjxENG6LXRyMi9/VjFa7CYvVd2N4QiewNFnm5qlUqR4ywA/iVa9aANnESWrzNtRsz5fpl2AJQtQAkQR+laZZs41vOhTN/ZLOfNeaGoGCgU/9ioZZW4p7ENM1Vk7xy8L9R+E+/RNQ4qLxVX6VD4aP7s1zGIm6Rtgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819121; c=relaxed/simple;
	bh=B0rrz706fZP9o/krGtsMkq9n14hW00h6cAynlu8+auI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uzb9VfblfWwwUy7I6wd3tjd7o8NboRUWBdLHWPYINN2eqwIfZOc9fwFL03slq5WCANhAnJScyZh3q+YwbOxvVHiJFrjm4W50zw1e4PIx8ps3jRe/MKx8//22qprR/BOx73r3AJwspZQ3GUi9kjxhbVyutVRDDdpJGQnQPisfE2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LaOtmgI/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LaOtmgI/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD901F0089B;
	Mon, 12 Oct 2026 15:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791819120;
	bh=3feCI9NiKqmNQUm+3zu3ZFJUTijKAM4jporgNlHarNs=;
	h=Subject:To:Cc:From:Date;
	b=LaOtmgI/gHos4Orkm/X7xD8GjtzhyItvZd5pNqmLJWnkhsJ7nIP5GkyGTDBlQtTh7
	 U/NQ9Hemi93G+eTSB/CEVc2GBjN/zM+JYteM4oyl46M2x0KiSm85iWdojszJVsAwRn
	 erEJZAwKGxsufJXitEl6GwEckN20CVA7pRHtQ8qQ=
Subject: FAILED: patch "[PATCH] drm/vc4: Fix firmware reference leak in vc4_drm_bind()" failed to apply to 6.1-stable tree
To: vulab@iscas.ac.cn,mcanal@igalia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 17:30:59 +0200
Message-ID: <2026101259-chess-obstruct-51c3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x b816da5d5df1461446a0a5f3fe2b4948a659a790
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101259-chess-obstruct-51c3@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b816da5d5df1461446a0a5f3fe2b4948a659a790 Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Wed, 16 Sep 2026 15:40:15 +0000
Subject: [PATCH] drm/vc4: Fix firmware reference leak in vc4_drm_bind()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The firmware reference obtained via rpi_firmware_get() is leaked when
aperture_remove_all_conflicting_devices() fails, as the error label
returns without putting it. This happens before the firmware is
consumed and put further down in the function.

Put the firmware reference before jumping to err.

Fixes: c406ad5e4a85 ("drm/vc4: Notify the firmware when DRM is in charge")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Link: https://patch.msgid.link/20260916154015.2056797-1-vulab@iscas.ac.cn
Reviewed-by: Maíra Canal <mcanal@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>

diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index 616caf9d9915..7b64e1ed02d4 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -360,8 +360,11 @@ static int vc4_drm_bind(struct device *dev)
 	}
 
 	ret = aperture_remove_all_conflicting_devices(driver->name);
-	if (ret)
+	if (ret) {
+		if (firmware)
+			rpi_firmware_put(firmware);
 		goto err;
+	}
 
 	if (firmware) {
 		ret = rpi_firmware_property(firmware,

