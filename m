Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C49C453A4E
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 12:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931254; cv=none; b=Cbm/1YFRc8wV1EtHQYmjUTFg1Q0RH9CkbXLa+gd1vrKRlyBAKVyb0kgaRTNjEY+IZNi0sHx2HzlaPU70HOqkCD5O7mzwrYJ/iPfyZ109VzI7ApMvVJEU+fJ/IRHT8UR31/v5KYb8yW5J7/xhvLFSPIGxHfYEsNiN5f8nok6rHN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931254; c=relaxed/simple;
	bh=2cXUxRBUcS7u0Iryyej5Q8XcLz3PAOFlXS+5C46+Cqk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NbkTHsEMz206iRioVVtyKApLNwHysx+hmWLtc42pKSF/baurn3CK2z29vjzjf9LTy8xhk14PdOtp3NwQWURGLrB3jLuIX6XkG9rieNObj4y5lIRdpTuQHnKgN8z1wAizpUN+5qFlvZGwFlkv0AppMH6+7i63JFsGRKVq+AFMvkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jZILQWcM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jZILQWcM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA18F1F00A3A;
	Wed,  5 Aug 2026 12:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785931253;
	bh=7Kyh4GxIwAG2oBpRyUYB/GaB64HGzAKb3pUIr+mp9Q8=;
	h=Subject:To:Cc:From:Date;
	b=jZILQWcMRKYyMoPEkluXJlXGEfOwq2YxZjUnZUThVhBuv9SRNmvtI6RhEliM5ShMW
	 r+WkR1Fw3OW6LwebgGUIZRcxB6EOkumWINcEP+00YPJmAqq/5dHEuC/O0YzpKmYt/v
	 2YRjtylXQRrwSpB+aMibcd2+Zj1sZ6EWsJj1LAvo=
Subject: FAILED: patch "[PATCH] drm/vc4: Supply the overflow slot size in BPOS, not the whole" failed to apply to 5.10-stable tree
To: jmcasanova@igalia.com,itoral@igalia.com,mcanal@igalia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:56:59 +0200
Message-ID: <2026080559-cartridge-shelving-bc17@gregkh>
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
git cherry-pick -x 6395789e4739aa5177bbec0fa0f07ccc38d249b0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080559-cartridge-shelving-bc17@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6395789e4739aa5177bbec0fa0f07ccc38d249b0 Mon Sep 17 00:00:00 2001
From: Jose Maria Casanova Crespo <jmcasanova@igalia.com>
Date: Mon, 27 Jul 2026 11:32:28 -0300
Subject: [PATCH] drm/vc4: Supply the overflow slot size in BPOS, not the whole
 bin BO size
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

vc4_overflow_mem_work() points BPOA at a 512KB slot inside the 16MB
binner BO, but writes the size of the whole BO to BPOS. On every binner
out-of-memory event the PTB is therefore authorized to write tile lists
across all the other slots (which may hold the tile state, tile alloc and
overflow memory of in-flight jobs) and, for any slot but the first, past
the end of the binner BO into unrelated CMA memory.

Since CMA pages are recycled into page cache and user allocations, this
is arbitrary memory corruption by GPU DMA. In practice it shows up as GPU
hangs with corrupted control list pointers, userspace heap corruption, a
GPU that stays permanently wedged after the first hang, and occasional
full system crashes, whenever a job overflows the initial binner slot.

The bug dates back to the conversion from a dedicated overflow BO (where
writing the full BO size was correct) to the slotted binner BO.

Fixes: 553c942f8b2c ("drm/vc4: Allow using more than 256MB of CMA memory.")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Jose Maria Casanova Crespo <jmcasanova@igalia.com>
Reviewed-by: Maíra Canal <mcanal@igalia.com>
Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>
Link: https://patch.msgid.link/20260727-vc4-bin-oom-fixes-v2-1-0d8a5eddc7c9@igalia.com
Signed-off-by: Maíra Canal <mcanal@igalia.com>

diff --git a/drivers/gpu/drm/vc4/vc4_irq.c b/drivers/gpu/drm/vc4/vc4_irq.c
index 8e5141bb5075..7877d493d80e 100644
--- a/drivers/gpu/drm/vc4/vc4_irq.c
+++ b/drivers/gpu/drm/vc4/vc4_irq.c
@@ -104,7 +104,7 @@ vc4_overflow_mem_work(struct work_struct *work)
 	vc4->bin_alloc_overflow = BIT(bin_bo_slot);
 
 	V3D_WRITE(V3D_BPOA, bo->base.dma_addr + bin_bo_slot * vc4->bin_alloc_size);
-	V3D_WRITE(V3D_BPOS, bo->base.base.size);
+	V3D_WRITE(V3D_BPOS, vc4->bin_alloc_size);
 	V3D_WRITE(V3D_INTCTL, V3D_INT_OUTOMEM);
 	V3D_WRITE(V3D_INTENA, V3D_INT_OUTOMEM);
 	spin_unlock_irqrestore(&vc4->job_lock, irqflags);

