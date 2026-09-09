Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17B23469F6
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954336; cv=none; b=DLxXVcnxnqS7mJL2ZEpbG0FCoYQ9oWHZ6jyOej+aKnE/uKTVAB0dDTDcoehpF/0E/CHm9S9/8AQHRpKswQ9IlSI/JQFzFzckkcZ+FnvrS8ZePuX6fFL9ORfJWkSHmosNtKUU29q2vXamK+08PoB08SAP7QiazAO3nokUfoSpig4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954336; c=relaxed/simple;
	bh=PmUWR+glS+bHbRY5SurUJTnNhZYcBQG2sZgHaJvOe6E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eQJmU9mOwLwtOFOCtcYg+EpN/XYRct4r9aa38/8YPUjyaENbEXfLCTYtssofQOwZzD9f5zneAk80kJNw/mRAvLLODG5hxMWC7LI8W4cTokW0rOGxq31oIIysn8n7OYBR4BzZVHEtGWduyCE+sCJMCHEhQUuylfE+Jphmp1Ln51Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FLKn5adt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FLKn5adt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574051F00A3A;
	Wed,  9 Sep 2026 11:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788954334;
	bh=FaxSDNDLyXHUs90bU/lSLePojvWmRLs4WlrnjZZRNzo=;
	h=Subject:To:Cc:From:Date;
	b=FLKn5adtnRsR6etKNOHVyBSnkwmKbY5aJFMBwWvV9adaRC3yNoSGofUijw2r0jYeG
	 yXVCKYAbtHj50jhnlT9Fx4/9XasMdkQ2UTvLS6lPMw00aiybbCZIbRfmYgw8ckSRK1
	 K5PPFb8j75CatOYAG1BnZrXdvRPn+U3/UMKroLSo=
Subject: FAILED: patch "[PATCH] drm/amdgpu: avoid force-completing uninitialized UVD rings" failed to apply to 6.18-stable tree
To: bobzhou2@amd.com,Frank.Min@amd.com,alexander.deucher@amd.com,leo.liu@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:29:44 +0200
Message-ID: <2026090943-snugness-plexiglas-e964@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 6760f5cb12d2366ddd58a2d8637f7583d73f596b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090943-snugness-plexiglas-e964@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6760f5cb12d2366ddd58a2d8637f7583d73f596b Mon Sep 17 00:00:00 2001
From: Bob Zhou <bobzhou2@amd.com>
Date: Wed, 19 Aug 2026 14:23:49 +0800
Subject: [PATCH] drm/amdgpu: avoid force-completing uninitialized UVD rings

uvd_v7_0_sw_init() does not initialize the UVD decode ring for an
SR-IOV VF. However, amdgpu_uvd_resume() unconditionally force-completes
the decode ring when restoring its fence sequence.

Skip fence completion when the fence driver is not initialized.

Fixes: 0a33b11d26c6 ("drm/amdgpu: mark force completed fences with -ECANCELED")
Cc: stable@vger.kernel.org
Signed-off-by: Bob Zhou <bobzhou2@amd.com>
Acked-by: Leo Liu <leo.liu@amd.com>
Acked-by: Frank Min <Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 228a405a94c4..ecd7caa95d4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -517,7 +517,8 @@ int amdgpu_uvd_resume(struct amdgpu_device *adev)
 			}
 			memset_io(ptr, 0, size);
 			/* to restore uvd fence seq */
-			amdgpu_fence_driver_force_completion(&adev->uvd.inst[i].ring, NULL);
+			if (adev->uvd.inst[i].ring.fence_drv.initialized)
+				amdgpu_fence_driver_force_completion(&adev->uvd.inst[i].ring, NULL);
 		}
 	}
 	return 0;

