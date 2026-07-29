Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C480483801
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 12:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785328998; cv=none; b=jkdL1/+m6h/CiUckebMP3kRRQorNAWalckhjG59wQgJsDseiijjSP0OQkbZR6ViYBwWvIHlXGuE3YTfHllRh7Xn9szHSZPSEt0SZ5zduua9uFZRXnCE3WBSrmFrkTgV0DweYBx7ZjjCCL70Rg2twhooEih2eKUc8i4WjJO91RQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785328998; c=relaxed/simple;
	bh=CuCRtpu5wnJvUGpQbgf/V4HkAuLQ3uvvDnepgJz9c6M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IlUpkofdHX128pXzFWFLG7IFtsFOG1YAswBgawszWE/9dm0Ag9/pdkt6KKX3PMoQoz2ucl4le/LEOmBnczC09q3ELm0UWwgP0CmfDWsRw5zBkp0e8vcivEqxdJ7jRDgvCTlLaqXgcxDH9YdM0j+AqaPHhyjo2xUA4DOOZ7a8USo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xpFuBMHi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xpFuBMHi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4D71F000E9;
	Wed, 29 Jul 2026 12:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785328990;
	bh=lGjdPmtzVAZdTb1GtIGGM4PYZ2Grv5KRG8f7/Whyi8A=;
	h=Subject:To:Cc:From:Date;
	b=xpFuBMHi/3g150jotvVOToYP4M+8TsYqC1tujO0K8Wsp60yO9aqquDj06Ilj6s79S
	 2fRZl6NljiVFMn0y6EuaQVCKnTPOqffBKZcRMcJI/UZvH1YqvifkYHG6SuVPlq8Fwh
	 qYklcOq7le9Ry7ayqbfeBagAiI6CfuPHvtoju0Uc=
Subject: FAILED: patch "[PATCH] drm/amd/display: set new_stream to NULL after release" failed to apply to 5.10-stable tree
To: vulab@iscas.ac.cn,alexander.deucher@amd.com,george.zhang@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 14:42:45 +0200
Message-ID: <2026072945-shading-makeshift-64dd@gregkh>
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
git cherry-pick -x 9fa26b9eed6195bf840f39ac183b9a6237548755
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072945-shading-makeshift-64dd@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9fa26b9eed6195bf840f39ac183b9a6237548755 Mon Sep 17 00:00:00 2001
From: WenTao Liang <vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 15:27:40 +0800
Subject: [PATCH] drm/amd/display: set new_stream to NULL after release

In dm_update_crtc_state(), the skip_modeset path releases new_stream
via dc_stream_release() but does not set the pointer to NULL.

If a later error (e.g., color management failure) triggers the fail
label, the error path calls dc_stream_release() again on the same
dangling pointer, causing a double release and potential use-after-free.

Fix this by setting new_stream to NULL after the initial release.

Fixes: 9b690ef3c704 ("drm/amd/display: Avoid full modeset when not required")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
Reviewed-by: George Zhang <george.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 99f3af19073b3ddbfd96e789124cce12c4277b28)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6210a1ff7cc2..b1e6d735cf02 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -12101,6 +12101,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 	/* Release extra reference */
 	if (new_stream)
 		dc_stream_release(new_stream);
+	new_stream = NULL;
 
 	/*
 	 * We want to do dc stream updates that do not require a

