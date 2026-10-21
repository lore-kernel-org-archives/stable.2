Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594293;
	b=um8wXLCuUdeSqdcXxyeupHtTkUY/37GWc0r0pQO9cu/MaLxQArx1Et3VuCq7tjuiLsSu
	 dq24PYgPhCgxPsvpFOoQaCfEvueTkqQfHfl8cUUUjyzoZaBBrDFw9U/u0OiXPlkB7z78V
	 tVoVD1PfPnbo52mV1vqIC6lotpRyy2yEvyLl1DEyShooHNe185fgYzPVW1XexzM8VpUdY
	 m6GpIObOWcsFR2kO80qWeOqTeUgt6UdrvQc9g6pqUACf8TF7p5Sx0Ox+Wy8fe+WWKABIH
	 P4BmAsUqozBBPCRcsA2sUvLSFkvy8mghM+PHnKxztF3LTWV07aPKXnTRhiT7mZ1ITBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594293;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7vaML46pOZiIYuwe2+AFKAoXmi/W83xTR9FqmBz55Hg=;
	b=5RkNLzgsLSQXNhQE2eEm4ntxhFNMWrYLEs23O3RGM47bojRplzGy42xbBtnxR/N2FdUt
	 EEZUxRfIOpsYiEGcBp1Um6MI2H7olVgm++/FeYmZW5zdKlfDRRzf53GYLJGuxaCuzxbOc
	 fzf5LuU0GSzg41nCIq+kzodmDfZCsrzHrpHNa2/GmxNYBpIJfVWbz1JA9bP1teE60jm3E
	 Wg1ULliSp5G0l31Stl0KDDZ2pWbWg+cwHJKbP4wKD6gFCSbu6QXd2ntlXFrhCgfKz/Zby
	 FyDKnQTQUYcDOrQgVLBSHMqNTI1dLcDzpclgI6P3CpFt0bB/y/0Eb90GDiTud7r03cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=IQvPywpm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F25606A31E
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=IQvPywpm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8366D1F000C1;
	Wed, 21 Oct 2026 14:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594293;
	bh=7vaML46pOZiIYuwe2+AFKAoXmi/W83xTR9FqmBz55Hg=;
	h=Subject:To:Cc:From:Date;
	b=IQvPywpmVVjhCkJZEaUORG1kkdKeyNsApAa+VsdSecsNxCKm36nqNup5AM6abqwsd
	 zBdFkf1WMaDSn6EJvLsoeWQtOdnlpBdC/YKbYOTyM7ZrJCHgANtlwCKjxVD6z4Q7XW
	 eybwOYGZNXjHtqFGl3QMoWySIgb8AXtvKmL7aL5s=
Subject: FAILED: patch "[PATCH] drm/amdgpu: keep the eviction fence until the last handle is" failed to apply to 6.18-stable tree
To: Jesse.Zhang@amd.com,alexander.deucher@amd.com,christian.koenig@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:46:17 +0200
Message-ID: <2026102117-gaming-valid-6a28@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 3c44cbcec5eb370713bbd2c315ed7c34d8ccec2b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102117-gaming-valid-6a28@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3c44cbcec5eb370713bbd2c315ed7c34d8ccec2b Mon Sep 17 00:00:00 2001
From: Jesse Zhang <Jesse.Zhang@amd.com>
Date: Mon, 12 Oct 2026 12:24:03 +0800
Subject: [PATCH] drm/amdgpu: keep the eviction fence until the last handle is
 closed
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

amdgpu_gem_object_close() detaches the user queue eviction fence from
the BO before it checks bo_va->ref_count, so closing any handle of a BO
removes the fence, even when the file still has another handle to the
BO and the bo_va with its GPU mappings stays. The BO can then be evicted
without suspending the user queues of the file, which keep accessing it
through mappings that are only marked for update.

Seen on navi31 with a SDMA user queue: a BO opened twice in the same
file (GEM_FLINK + GEM_OPEN) loses its eviction fence when the second
handle is closed (traced attach/detach of the fence):

  attach bo=ffff8c78a6c84c00
  GEM_CLOSE handle=7
  detach bo=ffff8c78a6c84c00

while handle 6 and the mapping are still in use.

Only detach the fence when the last reference to the bo_va goes away,
matching amdgpu_gem_object_open(), which attaches it only when the
bo_va is created. With this the fence stays until the file is closed.

Fixes: 31f7efcdca4d ("drm/amdgpu: enable eviction fence")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 8387982f03d4026b7dc11b0b5e3118298eee4d6a)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index ac7c8bb591eb..afd8502a2bc4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -337,11 +337,14 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
 			goto out_unlock;
 	}
 
+	bo_va = amdgpu_vm_bo_find(vm, bo);
+	/* the fence is attached once per bo_va, so keep it for other handles */
+	if (bo_va && --bo_va->ref_count)
+		goto out_unlock;
+
 	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
 		amdgpu_evf_mgr_detach_fence(&fpriv->evf_mgr, bo);
-
-	bo_va = amdgpu_vm_bo_find(vm, bo);
-	if (!bo_va || --bo_va->ref_count)
+	if (!bo_va)
 		goto out_unlock;
 
 	amdgpu_vm_bo_del(adev, bo_va);

