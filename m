Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D752D483808
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 12:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785328987; cv=none; b=Bp1Ny2ngcUw130jH/OPU6HYDkSRH0iDC85/ixsTB6++dd7rX5QT2uRWtfvkU6KWMGOY3U9EdhzB9d3UppDqItEmUZIRXKe1z/2xlrMi+2nrkCDfgQF630pvKE7f6aAz77EhKpNqruYqZM37vcQ8cbBAejIIYJvZpH7La7990Ylk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785328987; c=relaxed/simple;
	bh=58cNMnxrx+BY7YIdiaUTJIgd2gacnwqPsZoOk+K0bIM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bCDVh3R8N0X1uMyKYyH3an0NsZ/yvih27ouXLjdrysgsF+AFDkp8HvUmSgh303dhZY6Q6RA5OAsrEYnvmUUFbfAYErG3+dIdhh3d4OaiH3EkxSCE+G7tTRcdybeeUpP/cdlcX+ko7c39rwB84lqh7V90LOnnwFoMiqXnI/RGm4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QEF85SMI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QEF85SMI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0193F1F000E9;
	Wed, 29 Jul 2026 12:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785328978;
	bh=svvKwyw2+84yDhi0QbURVFnepqE0Rbnh71j53vPB34Y=;
	h=Subject:To:Cc:From:Date;
	b=QEF85SMIaFCswCCjQg0TFmmf2BibpM7qqnrMIaEDgn5aZGBETH+YepG1KyW2QYaG2
	 DsdSWLSBt+Z6JbC0H2YGUOLTz/icCV1aGJ4CJyJ0xrTFG3FEsZoP2yPBtc5ySnh3vu
	 tj06e8fiXHJ+RpEbPx7TEb7MoWy2Ms6/HtVt+pfA=
Subject: FAILED: patch "[PATCH] drm/amd/display: set new_stream to NULL after release" failed to apply to 6.1-stable tree
To: vulab@iscas.ac.cn,alexander.deucher@amd.com,george.zhang@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 14:42:45 +0200
Message-ID: <2026072945-passable-squeegee-1637@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 9fa26b9eed6195bf840f39ac183b9a6237548755
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072945-passable-squeegee-1637@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

