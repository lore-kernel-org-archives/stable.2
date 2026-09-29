Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876743E40ED
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 08:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670203; cv=none; b=sj9XGIgA0tSSh5D2GWMjHgoNTmy2IyBTS2hYiujqyXuS5txEtcMLQngkB8GNQKx8uBgMm9R3tFC3O/Fru02DWVzKS+gC8lu2YqeTIcqQYeEE86OlWe8WSXEffy8wNCaLMslJc2GF4liyyPqVAh+OjrHkBJeEL0uxdpzrsHvAfuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670203; c=relaxed/simple;
	bh=izivqIX3IrYwrdw1k9mAvbIz4BeIe1wNCUesu8QJ+Gg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mjeq6JvF329Q5DNqBIN0kAh0JtXxRzosAadp52ECFAoDjGnhIGZwhXCJ941uUEXnw48F3Q/lYF5jAJi8ZqSlCOK8YqIY9W+XrDKtQvtTS/oTI/StEaey4K6YtEFbVCkobMlowxmUa9Q+5w+IYflEktabvNaxskh4646UB+VFmd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1cSLraGf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1cSLraGf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880AF1F000FF;
	Tue, 29 Sep 2026 08:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790670202;
	bh=meiaW1ZXcNI1L3cVOXz/YuDhSpod9dcm1/dHfirCkQY=;
	h=Subject:To:Cc:From:Date;
	b=1cSLraGfMk7SqzD589Ya2WTjlPf5h6OGhfA4TKl9TyOs5At2bG5iRTbqhJ8d9sUC0
	 cJzf2fFLxqh+aXkxpdvPcTrC1IfgUvXvoeiFeMHJNMm4hfTZ4yI41Caum7DU2V7qk5
	 GfxMr4rhSecCfJ4/staT2wYHama7xa3XlxyaY85M=
Subject: FAILED: patch "[PATCH] drm/amdgpu: Fix last_update fence leak in amdgpu_vm_init()" failed to apply to 5.15-stable tree
To: vulab@iscas.ac.cn,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 10:23:16 +0200
Message-ID: <2026092916-yearling-rise-4267@gregkh>
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
git cherry-pick -x b4f7b4459b1b155e4c4977a6482b5df2cf08758c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092916-yearling-rise-4267@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b4f7b4459b1b155e4c4977a6482b5df2cf08758c Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Wed, 16 Sep 2026 09:55:36 +0000
Subject: [PATCH] drm/amdgpu: Fix last_update fence leak in amdgpu_vm_init()

amdgpu_vm_init() initializes vm->last_update, vm->last_unlocked and
vm->last_tlb_flush with references to the stub fence taken via
dma_fence_get_stub().  The error label at the end of the function
releases the last_unlocked and last_tlb_flush references with
dma_fence_put(), but the reference stored in vm->last_update is never
dropped, so whenever the page table root creation, the reservation of
the root BO or the PASID registration fails, the stub fence reference
leaks.

Drop the vm->last_update reference together with the other stub fence
references on the error path.

Fixes: 187916e6ed9d ("drm/amdgpu: install stub fence into potential unused fence pointers")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit e7979c84fc05a176bdf855ee664871b1648404c9)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index bb04101b0fb5..4a63b472f68e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2678,6 +2678,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	amdgpu_bo_unref(&root_bo);
 
 error_free_delayed:
+	dma_fence_put(vm->last_update);
 	dma_fence_put(vm->last_tlb_flush);
 	dma_fence_put(vm->last_unlocked);
 	ttm_lru_bulk_move_fini(&adev->mman.bdev, &vm->lru_bulk_move);

