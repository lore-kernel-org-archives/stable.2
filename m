Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDA24B5CC0
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445533; cv=none; b=rKvG9p9nJGVN5HyxrQUg/BeubsvdXhEO6dNjm63ScljgU60WwLnan33/NETdEl+50t4vIc8WQlVY6G+Hi8TpAKTTWR9Ameb8Fyz1XIt2GS9Ncx3wEqAmYKBRxyaeQm9Mhy132UfYdt6LVjivMXV8gnMSNHKRhtz8c0D1XrVldu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445533; c=relaxed/simple;
	bh=5dukhpvLCaJM16oJDgsWALoVEZjnKFK7V0Ppi2do2+Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Md6tBmhqr0C3Ctoguvmwemph7uIF9UmdKT/yGn2mTpU8lexc+Uhb18SPu/CCQAJpjyGPye9nj1VJM2rbk1kUzdfokUYcWMERUA//szzJqDTuY06WHTZqNS8SZvDB7HlFOjjr3Vr+MHY1eXB0lcT0ntjEeS3iOVqM9o3gdwE8PYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mzj4gOXU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mzj4gOXU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C221F00A3F;
	Thu,  3 Sep 2026 14:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788445521;
	bh=azm0oBrZcAdxfyFY/XTng0MisBfv2o2f7aLhNcqogS4=;
	h=Subject:To:Cc:From:Date;
	b=Mzj4gOXUgi4YA6PJ/gZXqrIpwPAiSzcLKCsnWLkvyeHKTmglaHu24uoA/ZVLztdUi
	 YIlgWOpqIOIa41nPJN+mtU/HI4fOgiHzEtYq+BYMcZXIiRFrXTxXOwsi96Xxc/Cw6b
	 aWe5rwv5mzDOyuTPzNazxvwrS9Kz/HJSDtMXGg4U=
Subject: FAILED: patch "[PATCH] nouveau/gem: reserve the bo in the info ioctl around the vma" failed to apply to 5.10-stable tree
To: airlied@redhat.com,dakr@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:03:06 +0200
Message-ID: <2026090306-creamlike-diagram-e3f0@gregkh>
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
git cherry-pick -x 5e17160d41d92823f3379c1982e1369680c5ce4d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090306-creamlike-diagram-e3f0@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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
 

