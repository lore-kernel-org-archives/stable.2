Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E954AE108
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445526; cv=none; b=HjYZdxbMdesdsYaLvAH+gQjgZEBlTZUFt3skKsTiB5Uw3IboOD2XFPKe+hmRySCaU06XX7rOxrS5p6bKyRgjUxQ82612wkMarrolaejfw0tUyPTp1RxHfRyUHOmHn3qZeE4u6hg6vj+kA1ieNIkUcdhO+RFVnyGmfnZPZ3zbNDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445526; c=relaxed/simple;
	bh=WVS2jQ03jIz8HfdSehC21Hs34BQYFA5NLtWzvBmAuiE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XgiLlOCu4qKYyzh7ee10NIirEWNcIURhXdh+JMSU1PHDHcK59Ga5LgU2cooq0a7wMC5F9YKk30LsqK72SgF8AwjvZAVH0qX0lFVXRCaXai8Nje+CCV73JDFKO5HiBWkt9syZxrNW7xybZIFLxebPM12ULmRiNcNi1iQ+aa2KhBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HWs4uXH1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HWs4uXH1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39DBB1F00AC4;
	Thu,  3 Sep 2026 14:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788445515;
	bh=JHrXz6QG4d3wAzIP2NuN+V5fulKo212OjYG5PdqpYQg=;
	h=Subject:To:Cc:From:Date;
	b=HWs4uXH108n34nq9k5vWfuzEQn1c2qdwlXYQRigjWBtvnsOMXkBPefqYy1KRa6Xlc
	 QVfQXF9EjYXEq+UtYXPekP/wH5/Zh2KvvXF4lpKmtzEuHI6pIFo1h3r1vdzOpqKMLl
	 QvXxewpSO0XKIafIRCE9R107CqVU0kl9msFSWAxY=
Subject: FAILED: patch "[PATCH] nouveau/gem: reserve the bo in the info ioctl around the vma" failed to apply to 5.15-stable tree
To: airlied@redhat.com,dakr@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:03:05 +0200
Message-ID: <2026090305-skeleton-brush-8637@gregkh>
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
git cherry-pick -x 5e17160d41d92823f3379c1982e1369680c5ce4d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090305-skeleton-brush-8637@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5e17160d41d92823f3379c1982e1369680c5ce4d Mon Sep 17 00:00:00 2001
From: Dave Airlie <airlied@redhat.com>
Date: Fri, 12 Jun 2026 12:06:58 +1000
Subject: [PATCH] nouveau/gem: reserve the bo in the info ioctl around the vma
 lookup

In the non-uvmm path, there could be a race between the info lookup
finding the vma, and the gem close path closing the vma leading
to a use-after-free.

Spotted with the help of Opus 4.6.

Signed-off-by: Dave Airlie <airlied@redhat.com>
Fixes: e758a3111914 ("drm/nouveau: fixup gem_info ioctl to return client-specific bo virtual")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260612020658.3176270-1-airlied@gmail.com
Signed-off-by: Danilo Krummrich <dakr@kernel.org>

diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
index 20dba02d6175..c5a24dff4b69 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -313,11 +313,20 @@ nouveau_gem_info(struct drm_file *file_priv, struct drm_gem_object *gem,
 	rep->offset = nvbo->offset;
 	if (vmm->vmm.object.oclass >= NVIF_CLASS_VMM_NV50 &&
 	    !nouveau_cli_uvmm(cli)) {
+		int ret;
+
+		ret = ttm_bo_reserve(&nvbo->bo, false, false, NULL);
+		if (ret)
+			return ret;
+
 		vma = nouveau_vma_find(nvbo, vmm);
-		if (!vma)
+		if (!vma) {
+			ttm_bo_unreserve(&nvbo->bo);
 			return -EINVAL;
+		}
 
 		rep->offset = vma->addr;
+		ttm_bo_unreserve(&nvbo->bo);
 	} else
 		rep->offset = 0;
 

