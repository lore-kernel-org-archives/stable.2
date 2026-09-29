Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9833B3D9537
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 08:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670215; cv=none; b=WqPg8kKqR++W5er4eukIY3PbM9xhO06peD30EyajfWPlzSd0vS43yvfsGNgodjfYB2N/iyF9cg1VfgBxSt7YiofKeDcE7FBUDhLaRNmUQ9uDHKOiP7DqAvr50FOwzK1zZcwO1CEUKmc+LIp7uYp/BH3VVxpbmVlyu2p5Xy63lXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670215; c=relaxed/simple;
	bh=lZha7bgqL6FiejPP7V7HPiFTB3nATxiz+Hs52Fpge7k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AAE01nINqKQKm9wU3yYMxOgWDNWvSGccTGLA2U0J8iIRcC2zEv0AVrWGeuzi/vJ+q+1ucY5fCGP8/x4+01YDSNyzDQuudSlvJYOFHxNx2wYA5cHjQjd8wZEoml1jQKgbVYExpnHs1i7czO5t4JAvFb4TrrZgzMAuhURZ6H6fN+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OHzKVA4V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OHzKVA4V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C381F00899;
	Tue, 29 Sep 2026 08:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790670214;
	bh=GB+qbhDWHXGkSePnKQswqlmpbii0UWCvos+SXeXULNQ=;
	h=Subject:To:Cc:From:Date;
	b=OHzKVA4VIIVzCHL2mFClAjf0qfY9l2VISU+OxqLaa0fp38107f/bJ8tkEaBi9gH7Z
	 qwUjBjoNrLFZSEuPi8TyGBJQwwBEGajSvOcrmqM827T7V7FyBOXnRti2/5wDgcFOAH
	 CpNnAnt9nTNx1DaRhxgyKjey1LP1vR2+mqKbmewU=
Subject: FAILED: patch "[PATCH] drm/amdgpu: Fix runtime PM leak in" failed to apply to 5.15-stable tree
To: vulab@iscas.ac.cn,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 10:23:28 +0200
Message-ID: <2026092928-heading-septic-a26f@gregkh>
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
git cherry-pick -x 2b86ab1bd6673c525adda88819d7658ba9e784ec
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092928-heading-septic-a26f@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2b86ab1bd6673c525adda88819d7658ba9e784ec Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Wed, 16 Sep 2026 09:58:05 +0000
Subject: [PATCH] drm/amdgpu: Fix runtime PM leak in
 amdgpu_debugfs_test_ib_show()

amdgpu_debugfs_test_ib_show() resumes the device with
pm_runtime_get_sync() before taking the reset domain semaphore with
down_write_killable().  If the write lock acquisition is interrupted,
the function returns without calling pm_runtime_put_autosuspend(),
leaking the runtime PM reference acquired for the device and keeping
the GPU awake.

Drop the runtime PM reference on the interrupted down_write_killable()
error path before returning.

Fixes: 6049db43d6dd ("drm/amdgpu: change reset lock from mutex to rw_semaphore")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit ec30a576c2d4c0364549e6c04218f50704ef56c8)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 132d054900b5..aca1a8045afa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1780,8 +1780,10 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
 
 	/* Avoid accidently unparking the sched thread during GPU reset */
 	r = down_write_killable(&adev->reset_domain->sem);
-	if (r)
+	if (r) {
+		pm_runtime_put_autosuspend(dev->dev);
 		return r;
+	}
 
 	/* hold on the scheduler */
 	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {

