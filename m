Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74B54314BD
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 12:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329317; cv=none; b=FNkd5T9CYUx3RxwPa18MgAXWdp4g9Y2TXfexlgmrcFjxqH0HO+XUwWxUz8AnFC7OteFF+5MpGkR3ov8AKiLYZW/8SLZ0K37b3Kv5vQGhXPKeKELDoR2qmzPtRedsREyh8OBWaL3gVKwRpZ2LjKUzQRfKApASwHpo47tT+VcAdhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329317; c=relaxed/simple;
	bh=Ob7mIhMUL7GkgDFFYgoyWgGtDAse52JS6+pHfnQIDzM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Fyhpegr0XhjvYDHkRkoa/3vmfiPbsZScaNLwp8wlsPNxJJ6Pm0QChiDpMfQKeVuTIfGPkBQ7qoDfGZWucNMGkUr5zueE3y9yXnhAHODcAEyz7c5v1XYPOGSP6+uklUTjoJhlKLBfLnG8SlfEUx5ADllVmRgAPsMTIkVrElttdeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cHJvgfkV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cHJvgfkV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED41E1F000E9;
	Wed, 29 Jul 2026 12:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785329316;
	bh=s0AatLx2cwx9r6OMdO8CvlbkTOmOnMvogsVquV/ECbA=;
	h=Subject:To:Cc:From:Date;
	b=cHJvgfkVqsj6XJ3CtuZB0m1kxMZhAZtUZ04uX6Ul0rWTLaJ6zI6ZhOjVaX4pSGwrv
	 5EodNC3G1wKT0i9TeYcBPB5H2kDT7OjvmwaCpKcrbetiidp7hQRW6Smu3llirNFg17
	 MCQEOvqs71b4x4Kcjue/EEVgjxwKWrCwiKVBfGiU=
Subject: FAILED: patch "[PATCH] drm/amdgpu: Reserve space for IB contents in devcoredumps" failed to apply to 6.6-stable tree
To: timur.kristof@gmail.com,alexander.deucher@amd.com,christian.koenig@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 14:48:11 +0200
Message-ID: <2026072911-crumb-stroller-ce87@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x b5eab15944b6b140f003af6e639a25f5c3a8ed0b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072911-crumb-stroller-ce87@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b5eab15944b6b140f003af6e639a25f5c3a8ed0b Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Date: Sat, 11 Jul 2026 13:21:08 +0200
Subject: [PATCH] drm/amdgpu: Reserve space for IB contents in devcoredumps
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently the contents of IBs are abruptly cut off and don't
show the full contents. This patch makes sure to reserve
space for those contents too so they may be printed.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 4e2c0821509fed754e8c31d5053d152fbb3484a5)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index acab3d94a51a..6480a344006d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -234,6 +234,9 @@ amdgpu_devcoredump_print_ibs(struct drm_printer *p,
 			drm_printf(p, "\nIB #%d 0x%llx %d dw\n", i,
 				   coredump->ibs[i].gpu_addr,
 				   coredump->ibs[i].ib_size_dw);
+
+			for (int j = 0; j < coredump->ibs[i].ib_size_dw; j++)
+				drm_printf(p, "0xffffffff\n");
 		}
 		return;
 	}

