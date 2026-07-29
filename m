Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DA1481AA1
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 12:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329423; cv=none; b=hUIgQqoy/6fXixemjiTdkKZQnbgTB2zigFIqGqEJkQA3zuXKkn0R+jV8akUfJMVPk8fszO1mfURhSrw08UoG9DQLKU/b9969cBjiWhfuO+O6KpII1gejEh0yX6x/0a4qeq77wztG+bqzJ44B9g5XkTcPzWXWEDXNfPMn58kroJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329423; c=relaxed/simple;
	bh=ruTrmenfY36CeMadb0Z1b305PBBwRdQAWAhdQjQt6Pk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LoScK4pwg025TA1obruR+eS+pGIaphOc2ahP6JokMyOS/jVSFzyF8VwsCeiwsE+W/ej5EdKA7AoTYCh1Jz297CUaPRtbyY/rw+HfJ2pdFoooH3+OwCmKJib8TGxdW+5qwdLgy8OLkQBcyUAiTIGnaZKqtoaIOlHuKdWtB/vcEAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZCp2O2ae; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZCp2O2ae"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DF11F00A3A;
	Wed, 29 Jul 2026 12:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785329419;
	bh=1jCDxTprnXQ+zKaMB+Pg2RQDuLwvCtMlBybkrqM24mk=;
	h=Subject:To:Cc:From:Date;
	b=ZCp2O2aeOiVCa9OON9098PRqzV5apBKrSyS4X371Fklgkg/5suFzyLS3G+yv6QeLH
	 bmTOHR3W/BnZ1AALNWFHUjsxtuWoksokvHJz4KIVH+fZnFx0pwSNvUJdVlFwcvFAV8
	 WW5PVHp7SrcM3SYhXZMIWAGWhXvlO2tsNgDB88qk=
Subject: FAILED: patch "[PATCH] drm/vc4: Prevent shader BO mappings from becoming writable" failed to apply to 5.10-stable tree
To: lilinmao@kylinos.cn,mcanal@igalia.com,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 14:49:55 +0200
Message-ID: <2026072955-sizable-shaft-8750@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 0c9e6367639548307d3f578f6943ce72c9d39087
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072955-sizable-shaft-8750@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

