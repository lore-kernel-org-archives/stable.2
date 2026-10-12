Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3F249DB9D
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819118; cv=none; b=tA9lRSXP6psJoMYKm7/NLqgGz/Hc5VPzpU/EAekp3DqHf0UObecNLAuy5yAVxd9SCs5l35BKaScxxIc58IQJO4/MX8s4t0TUckkr3WRiSWmDjpxL7HMNW2fyggmtHHe8OflKsguEGc+E/Qg6KCRspBpFRZyDDXpzw7qheeHcyzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819118; c=relaxed/simple;
	bh=/1SiL5v9lM3ieymPgSujv26V8M7omFFc+ZtnhSBfe+Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Zo2mAtu+NsgO+IhEyUfiwiB/xXzq5s1qxWQsYjiamyf4fDFvuhmUxwhcXg0up1aT+/8ZyOUApHfgshAh+Nju6MYqkodZgzRrQtEfrGwGe1eQ35aPFlviH2f0cH0HLB+vmTPDQvVxI2fyv4YuTg3lW+KdXHte1F1dak6IcjCm58Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SPAtXHGS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SPAtXHGS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172361F0089B;
	Mon, 12 Oct 2026 15:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791819117;
	bh=q4+MsrMBxI+lpryRdWv+hveT9m9D3cDGeqGxsaZwgWo=;
	h=Subject:To:Cc:From:Date;
	b=SPAtXHGSL2dHCzfKBJPjfOlHdhCnVNFwpYNjvUC6BZNwForQoSFtXUEEbaI+EXE+X
	 07a5tNsn9MGhFrMPCq+JjULry6PPMx6XMF+7TCZjrXoTGYKyUMFmIvZsn9FxYMCyGc
	 O/6Cew6FxyM9siqkkkXM7YUbTxL6QU/X6mH7W8TU=
Subject: FAILED: patch "[PATCH] drm/vc4: Fix firmware reference leak in vc4_drm_bind()" failed to apply to 6.12-stable tree
To: vulab@iscas.ac.cn,mcanal@igalia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 17:30:58 +0200
Message-ID: <2026101258-emporium-attempt-639f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x b816da5d5df1461446a0a5f3fe2b4948a659a790
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101258-emporium-attempt-639f@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

