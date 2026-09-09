Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F18C399D0D
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954333; cv=none; b=apDZk6npMpO3oAq5PyCN/5hLN9NCPcDf1tPQDR4W1fUez2SB/Dqkwy4VMdSlvAU1JEyJv1Ye6BGYlPO9CRWiL4BzjdVDKyIUPZhEbYmKTCFvcXvstqd39Moj/pyt644NuoXlg34BDdbZU4YThgd+qa5Ostun0dvd1VcA4II1idM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954333; c=relaxed/simple;
	bh=NmLDHriALzuCoBH4nmgYuzYgsmzYMaNlww/E0TvrpXA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mcHSoM2iTkAGa428aSId5gE6X5JYCzFFeR0aiQvdKlF1nKR6OOUg70HkldmrGfTpimcypB0EUEuonpQbELMwUTWRzlMyvoyS1crt9T+Z2mWnSRwhHMJDVKQ+3wlMhWz99bjUdfNGdMtTYIjP7SYat4iMdCQCeG7lcsBms6MNnGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rCA64mIQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rCA64mIQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E541F00A3A;
	Wed,  9 Sep 2026 11:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788954332;
	bh=ZkxsEkCQh6T7ZyGEzOQqLxaa0kop3bSw77PtxSxs1l8=;
	h=Subject:To:Cc:From:Date;
	b=rCA64mIQm0dEh8kd6NOsa7j7BEFGrcRbQMGT5OFeKDRuM3qD2vQ3S9L+VNjX2Zwo+
	 XCdw93dO6O48WCDLxR0NktvrF9kWsBk3ItGw1rUtAgeo2p9q81KnSslfAlw4d0kHZB
	 RQJxpXwVORZMSIqnbnznZMvsH2G3ecmJCRkxmI+M=
Subject: FAILED: patch "[PATCH] drm/amdgpu: avoid force-completing uninitialized UVD rings" failed to apply to 6.6-stable tree
To: bobzhou2@amd.com,Frank.Min@amd.com,alexander.deucher@amd.com,leo.liu@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:29:44 +0200
Message-ID: <2026090944-uranium-paramedic-0401@gregkh>
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
git cherry-pick -x 6760f5cb12d2366ddd58a2d8637f7583d73f596b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090944-uranium-paramedic-0401@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

