Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0797481238
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 12:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785328996; cv=none; b=ZUv67gtGTGzjJqv5F2AqoKDzCt6aYs2Y82CyuYuJMufz2P08y3uZQKvkhsiYeGZB3rwdCHhbiKqa+7wvU+uOfX7kthcaOSTmAenNKtdQtfeQ1HaVXUIrpdRhYUKfIxKfyiV9i0wV10ZztQWxplb1w83EG45LyiJ2Pd/c0unobn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785328996; c=relaxed/simple;
	bh=IjssHmKAZcjj0nfsmQ87P1CwqTx9g9RzgNM0lZRFgxQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Juooqm/WpX+kp6xLjPOLxAuPjrBWmcSv9hrsS3wnjgsieXcmI3A0hEqzbpnPO9c+ACmW/cAGRycThYzammj1D0BdZVzlrabXkXY5vUbP9/a8GLrOUoj9Nt18JYUF3MtqDNyQ0JtGS94GefJk/xC+BJ5hAVklApbV6udnF8rkJJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bg3M3AwH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bg3M3AwH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C311F00AC4;
	Wed, 29 Jul 2026 12:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785328986;
	bh=QQzdG4+fMgqUYUMo57KBFQeVk5jrerNiBJ2ZS/L8Bas=;
	h=Subject:To:Cc:From:Date;
	b=bg3M3AwHluVzIMOo4tXlxORKbpQYJ0Mu7mP3HCFPMQ9pO5p4o+DBpUj2vHAD4snIx
	 IXKIUAvG2A/6LaplS1i3a0AlsR/11iHwLvj3m1HsZxKwBIY7rpz9iiIN9UPdVqPFXP
	 tReFQfN58nIMUSKbjHv5y8Vm+Lwl8UuKTkZn4g4A=
Subject: FAILED: patch "[PATCH] drm/amd/display: set new_stream to NULL after release" failed to apply to 5.15-stable tree
To: vulab@iscas.ac.cn,alexander.deucher@amd.com,george.zhang@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 14:42:45 +0200
Message-ID: <2026072945-tactics-jaws-984a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9fa26b9eed6195bf840f39ac183b9a6237548755
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072945-tactics-jaws-984a@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

