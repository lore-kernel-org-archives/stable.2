Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5DF20B80B
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 08:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791187778; cv=none; b=nJsJT+GJQTr/40RjFLvyWrPZ4mXeZMZsuNeHUmk131dxjnMKM4OCPGuMRjl6aSLHNLBX4GskdlVYSudNm1Jkc5OSYeZO4h5u+H6cvYiAcyPuOiz1ntIxQ/hlSCekY3gl6Ez6cOlzzRoOMCjImf5s77YsELRQ+guk8SFUNKrhHH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791187778; c=relaxed/simple;
	bh=S3KzjMjnlDAq8fSIL+KMRl0KhZL/xNsqbcWbbWEPkB0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cAccahFHc/sQyHb9csoRR1UMhYwU7OnJJzCvwTLQuCa2VDXsabCmlowhffs+05wIIFe86F2vlvU+pWOAXxzZbMRUZEBZfAjJBfh2bLz+DvAdH3KnZI081gSpp33HEeRaiuJDT/xL40RZ3uRm9glqTCll0b7plNaprHccYwAZJTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RYvxjy1X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RYvxjy1X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D8C1F000FF;
	Mon,  5 Oct 2026 08:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791187777;
	bh=XcYX1YO0rMevufe+usoIFeYZVEZ+A3KdZWbcCrx3Bxk=;
	h=Subject:To:Cc:From:Date;
	b=RYvxjy1XVgnF0d6QkMnBCha3FaS5X11XDMg1bNDIYxqcF5XnZ4/fK7VjyHsRRViNI
	 HjY/NxEVflmqWMWMMXTIirBQlPu2SF4+3JElJ0Z/DU5ppwiCkpNSJgw6rUW7yjYrTO
	 iG5cBEb8hpZj2Pj3QrMQoanBsg0ybp1O+byOlJGA=
Subject: FAILED: patch "[PATCH] drm/amdkfd: Fix always mapped range mapping to all ACCESS" failed to apply to 7.2-stable tree
To: andrew.martin@amd.com,alexander.deucher@amd.com,philip.yang@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 10:09:34 +0200
Message-ID: <2026100534-driving-grip-8fa4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x 0e4101c11aed803e6e69a83f8cc48160a676c19d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100534-driving-grip-8fa4@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0e4101c11aed803e6e69a83f8cc48160a676c19d Mon Sep 17 00:00:00 2001
From: Andrew Martin <andrew.martin@amd.com>
Date: Mon, 14 Sep 2026 12:19:10 +0000
Subject: [PATCH] drm/amdkfd: Fix always mapped range mapping to all ACCESS
 GPUs

CWSR ranges use the always mapped flag and only need a mapping on the
GPU running the queue. However, svm_range_validate_and_map now updates
the mapping on every GPU with the ACCESS attribute, which is all
supported GPUs when XNACK is on. After the range is prefetched to VRAM,
those GPUs may span different XGMI hives, so the page owner mismatches
and is set to NULL. hmm_range_fault then tries to migrate the VRAM
pages back to system memory, but svm_migrate_to_ram skips it because
migrating pages back to system memory is not allowed while the GPU
mapping is being updated, so the CPU page fault is never resolved.

Only map to the ACCESS GPUs if the range is not mapped to any GPU and
is not in VRAM.

Fixes: b96f26104946 ("drm/amdkfd: Unmap svm range from GPU set to no-access")
Signed-off-by: Andrew Martin <andrew.martin@amd.com>
Assisted-by: Claude:claude-opus-5
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Philip Yang <philip.yang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 093cf8842ace35ce212858d5059fee007ec8e778)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index fa4054d51f60..d7f2ff5c8f02 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1752,12 +1752,15 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		}
 
 		/*
-		 * If prange with always mapped flag, update mapping on GPUs with
-		 * ACCESS attribute
+		 * If prange with always mapped flag is not mapped or migrated
+		 * yet, update mapping on GPUs with ACCESS attribute. Don't add
+		 * them otherwise, ACCESS GPUs may be on different XGMI hives,
+		 * that would force hmm_range_fault to migrate VRAM back to ram.
 		 */
-		if (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
-			bitmap_or(ctx->bitmap, ctx->bitmap, prange->bitmap_access,
-				  MAX_GPU_INSTANCE);
+		if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE) &&
+		    prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
+			bitmap_copy(ctx->bitmap, prange->bitmap_access,
+				    MAX_GPU_INSTANCE);
 	} else {
 		bitmap_or(ctx->bitmap, prange->bitmap_access,
 			  prange->bitmap_aip, MAX_GPU_INSTANCE);

