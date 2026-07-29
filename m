Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBCF470E8F
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 10:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785322543; cv=none; b=ur+bY0ekXbPh9lIBUirSgxxRngUefSZe1SFTlAy7u8ZD5YgJUfgcyqZxgq+ktfH8hrcP6sspSBhvG9ya7uFXXCWyqOxfnShuf9rMVaVS3hb0gFKdbtT9nMxTp5HyEawRggbVQa01jYaT2k31HSotAiLMx11u1Msn/26tDt9KxSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785322543; c=relaxed/simple;
	bh=E1CP4xwN01OiMeJj8f1ayjKJqcIJhtBdzIu7CVQETE0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=B0fkYNjqmLu+HBCLeHIkOwWHmHyplJsebSJQfEAoYi5ljueNtNhGTxqbNdJVUAntMHsR2IwXEy6SJ94iPlVlpVJTmvet2aJNKDLAC6XdpJp2JgaZFtvENYTQgiLhXeGbFpV4wR+rGISXhNCcGM6cR261atiBSyY7HI0FHVxFYmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GD2Veted; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GD2Veted"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C8D1F00A3D;
	Wed, 29 Jul 2026 10:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785322541;
	bh=THejCZNx5lZQ3r7qFWXOlujYfPHWU+7fSSVoHA7YkhI=;
	h=Subject:To:Cc:From:Date;
	b=GD2VetedlNnEZlIJhlnQETuZOslD0A6tA2k0clE7NKyRHNrfLi3O3rygROO5H42IV
	 e2QXC8h5FrtlugQJNNhA1D/RFnMtYsY4fz37UWDL1k3GM+AwYdK0vVITIG5wQtZvsF
	 xuGewDlFhW9YtqFc0no/sWcbQDUo/8zbcNgcehwM=
Subject: FAILED: patch "[PATCH] drm/xe/guc: Fix buffer overflow in steered register list" failed to apply to 6.18-stable tree
To: tejas.upadhyay@intel.com,matthew.brost@intel.com,zhanjun.dong@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 12:54:44 +0200
Message-ID: <2026072944-swivel-tidy-c727@gregkh>
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
git cherry-pick -x 632ecc90e1ca5d3b6822bb4d08f84a175b6c42c0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072944-swivel-tidy-c727@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 632ecc90e1ca5d3b6822bb4d08f84a175b6c42c0 Mon Sep 17 00:00:00 2001
From: Tejas Upadhyay <tejas.upadhyay@intel.com>
Date: Fri, 12 Jun 2026 12:34:02 +0530
Subject: [PATCH] drm/xe/guc: Fix buffer overflow in steered register list
 allocation

The size calculation for the steered register extarray uses only the
geometry DSS mask (g_dss_mask) to determine the number of entries to
allocate:

  total = bitmap_weight(gt->fuse_topo.g_dss_mask, ...) * steer_reg_num;

However, the filling loop uses for_each_dss_steering(), which iterates
over for_each_dss(), defined as the union of g_dss_mask and c_dss_mask
(geometry + compute DSS). On platforms with compute-only DSS bits, the
loop writes past the allocated buffer, corrupting adjacent slab objects.

This manifests as list_del corruption and SLUB redzone overwrites during
drm_managed_release on device unbind, since the overflow corrupts the
drmres list_head of neighboring allocations.

Fix by computing the allocation size using the union of both DSS masks,
matching the iteration pattern of for_each_dss_steering().

--
v2:
- use bitmap_weighted_or() (Zhanjun)

Fixes: b170d696c1e2 ("drm/xe/guc: Add XE_LP steered register lists")
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/8049
Cc: Zhanjun Dong <zhanjun.dong@intel.com>
Cc: stable@vger.kernel.org
Assisted-by: GitHub-Copilot:claude-opus-4.6
Reviewed-by: Zhanjun Dong <zhanjun.dong@intel.com>
Link: https://patch.msgid.link/20260612070401.543305-2-tejas.upadhyay@intel.com
Signed-off-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
(cherry picked from commit 0a78a44f4901aa6c9263e66be7fce02282f1109f)
Signed-off-by: Matthew Brost <matthew.brost@intel.com>

diff --git a/drivers/gpu/drm/xe/xe_guc_capture.c b/drivers/gpu/drm/xe/xe_guc_capture.c
index 21f7caf9ea08..1a019137ddf4 100644
--- a/drivers/gpu/drm/xe/xe_guc_capture.c
+++ b/drivers/gpu/drm/xe/xe_guc_capture.c
@@ -461,8 +461,14 @@ static void guc_capture_alloc_steered_lists(struct xe_guc *guc)
 	if (!list || guc->capture->extlists)
 		return;
 
-	total = bitmap_weight(gt->fuse_topo.g_dss_mask, sizeof(gt->fuse_topo.g_dss_mask) * 8) *
-		guc_capture_get_steer_reg_num(guc_to_xe(guc));
+	{
+		xe_dss_mask_t all_dss;
+
+		total = bitmap_weighted_or(all_dss, gt->fuse_topo.g_dss_mask,
+					   gt->fuse_topo.c_dss_mask,
+					   XE_MAX_DSS_FUSE_BITS) *
+			guc_capture_get_steer_reg_num(guc_to_xe(guc));
+	}
 
 	if (!total)
 		return;

