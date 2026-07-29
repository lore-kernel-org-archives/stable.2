Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777F9485CD4
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 12:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329419; cv=none; b=IzqgnIAXcpVB2NhmClfqq1I8ufaeGj9ADJy/jxDHQB+jM4G/xnb1RBRvy+xn0AyyVVgFkJZJlNOzXCQQSMOr5nAaRLR7il7wSto8yfISt5CPCNdfGB+Tofr6E/kiAidaOae3F0cxwwilgUYQw579ECCUm+EQg9yNPTPctqjG7o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329419; c=relaxed/simple;
	bh=AlVjylnxpU2Pgw9KBoIIZ2sV8nXTIcbimjHdcHUJ/FQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pfFqfrXWGnwuKHK+z/FYVxTr42Lzju1KFHYTEQgikBHlyi5wqlKXKJa1ED7SfBex17BR8ptznjmUPkEw3xEfWZp/9mDvjSkg2EsvE50Mb2VaB0rkRnWJzZXU3GoF4QRpo2OLU5kIk0S8CYfF2LOhz5I4IfuUSHmDu1AbzUDb6PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PJnI3tUG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PJnI3tUG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15E71F000E9;
	Wed, 29 Jul 2026 12:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785329416;
	bh=BF6QiR/jNx93m327OJmqfzPX3JwG5mpPJwtfHXkWm80=;
	h=Subject:To:Cc:From:Date;
	b=PJnI3tUGbPckFdZofRRPoRx6pMZfCRoY4QXsIRlQILk5JxNtEl4KOzZQrdGopm6gY
	 P54xlQPKB6KBEbw4UXrK5GLUvueucbYk1pFdfwscpMIOAs62eHU37Ge5xivFg/UO0e
	 Disba/3wI/xvJTFmmMeTzOqoo+Gh01yZnf8Mz9DQ=
Subject: FAILED: patch "[PATCH] drm/vc4: Prevent shader BO mappings from becoming writable" failed to apply to 5.15-stable tree
To: lilinmao@kylinos.cn,mcanal@igalia.com,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 14:49:54 +0200
Message-ID: <2026072954-paragraph-remnant-37d3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 0c9e6367639548307d3f578f6943ce72c9d39087
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072954-paragraph-remnant-37d3@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0c9e6367639548307d3f578f6943ce72c9d39087 Mon Sep 17 00:00:00 2001
From: Linmao Li <lilinmao@kylinos.cn>
Date: Tue, 21 Jul 2026 09:15:58 +0800
Subject: [PATCH] drm/vc4: Prevent shader BO mappings from becoming writable
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

vc4_gem_object_mmap() rejects a writable mapping of a validated shader
BO, but leaves VM_MAYWRITE set.  Userspace can map the BO read-only and
then turn it writable with mprotect().

Validated shader BOs must stay read-only: the validator checks the
instructions once and the GPU trusts them afterwards.  A writable
mapping lets userspace rewrite the code after validation, bypassing the
validator.

Clear VM_MAYWRITE on the read-only path so the mapping cannot be
upgraded, as i915 already does for its read-only objects.

Fixes: 463873d57014 ("drm/vc4: Add an API for creating GPU shaders in GEM BOs.")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/dri-devel/20260720085554.B0AF01F000E9@smtp.kernel.org/
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
Link: https://patch.msgid.link/20260721011558.1672477-1-lilinmao@kylinos.cn
Reviewed-by: Maíra Canal <mcanal@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>

diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
index 2161761b1f22..5e7c46dd7823 100644
--- a/drivers/gpu/drm/vc4/vc4_bo.c
+++ b/drivers/gpu/drm/vc4/vc4_bo.c
@@ -732,9 +732,13 @@ static int vc4_gem_object_mmap(struct drm_gem_object *obj, struct vm_area_struct
 {
 	struct vc4_bo *bo = to_vc4_bo(obj);
 
-	if (bo->validated_shader && (vma->vm_flags & VM_WRITE)) {
-		DRM_DEBUG("mmapping of shader BOs for writing not allowed.\n");
-		return -EINVAL;
+	if (bo->validated_shader) {
+		if (vma->vm_flags & VM_WRITE) {
+			DRM_DEBUG("mmapping of shader BOs for writing not allowed.\n");
+			return -EINVAL;
+		}
+
+		vm_flags_clear(vma, VM_MAYWRITE);
 	}
 
 	mutex_lock(&bo->madv_lock);

