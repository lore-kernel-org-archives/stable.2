Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C973A4F30
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 08:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670212; cv=none; b=b1txiNX2mXsOwJa5nnXuhqlR4KrCEAyMTF1dkJKaIU+DJqPEcxxMWt6QZ//PKqs+O7JHKPO1GatTEI6M97KLwsMy6Xr72cC3/CK2r3bqLzkNkJYIRIYHdNfUkx37wktChXC9BrDZPC9ulFl5dNaNCj5gFYD5GCDA0arj3ts0yyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670212; c=relaxed/simple;
	bh=LX+BPgTQiqfGnOIlTOPkA4qLCdTQH/Q2vKRBelkWyoM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iesTykapdjrSfFVJvJCp5zwXqds6Bw3CL4jPFfArFgLTZPJeETsb2w8r/+FuICOdKyTSb5IzyYdpkZ31OGTwgEkjcwJtGQRn0//sn8ykiExyy1LbHfrSU9IasdY8tzbrz7tjA2ohz4ewiIN0FPyVKX3Y5Tbu3DIw+1LoKHQiXgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K+/TbeVN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K+/TbeVN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6CB1F000FF;
	Tue, 29 Sep 2026 08:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790670210;
	bh=cRZ2b97RiaiEkeDyN+sPh/rEVbHnGS+npkX/zfVRs3M=;
	h=Subject:To:Cc:From:Date;
	b=K+/TbeVNbnM+x6ALwZIw5Smkg5g06c8posSPiDvckuU++xFbha5nkwkVU6JcWwMIw
	 4hz0I2CiCr7XfRM+71Y7aXLvXZC19S/ah7NvTZzh9pagWu3rBSL38yGXaXiGTDYGVd
	 QjZY8l4O6r+negMQ6m6u9NuaRpS0iSCqJSbZcm4E=
Subject: FAILED: patch "[PATCH] drm/amdgpu: Fix last_update fence leak in amdgpu_vm_init()" failed to apply to 5.10-stable tree
To: vulab@iscas.ac.cn,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 10:23:17 +0200
Message-ID: <2026092916-hurry-appendix-2bde@gregkh>
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
git cherry-pick -x b4f7b4459b1b155e4c4977a6482b5df2cf08758c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092916-hurry-appendix-2bde@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

