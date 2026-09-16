Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACA94A49B3
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789550668; cv=none; b=rF9ZJT/QcRDzwcGfJSx5BdcWPVJZztG37lIYb6VCeoUpyTU8fSlzoWBKQGCcEyKFE99lWWxENXEGbYlI45/OjTGo7V6OvGXY1cn5BQstRKf5uLaZ47C5/ND2LHcDkFF/Op0yJeqKhojswL7IWRDX/1uIO8pzM2VMknqXrN7Oyhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789550668; c=relaxed/simple;
	bh=mI1JhBRGMvqCC+8zN57a8ZYzfZnVxP1WeIv2boo2f5E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=H7P+HqIreKQywVpw4szv1zGeHyxE5wVAjTxc4MfFmZqaLkO3vxLQXvqzjGpdhj7q0K4HWLOh/KVyOz6FPojDzB56XWJDCdQnxRfU959mHVrgPLxKYRyvtHACqCamZXiY5ZTUtZq7VXjS+OJ7LM/LnZTrRXWZv++k9jlDUwGMNPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jNK91cnP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jNK91cnP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFBAB1F00893;
	Wed, 16 Sep 2026 09:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789550662;
	bh=AcM+J8HImk0reESpq06iG6A2YPmCx2kxI272+XdhKT0=;
	h=Subject:To:Cc:From:Date;
	b=jNK91cnPwPv9J/QqV/keoBhnPDF2j7WKUT/jEFe/t8+BmnrWRPdxmaZpPMlgtLLfC
	 ffTxPoJU3i2Ib/4nqqjA0ej8BVEyVuIkHBgvaPaQSyZAHcjsgh9g/pAB7Uo4ZfnHUJ
	 plOhTxS0womTEHXNqaa9uXeLRn/zQOVoSnQZiO5A=
Subject: FAILED: patch "[PATCH] Revert "drm/amdgpu: debugfs: avoid extra EOLs in" failed to apply to 7.2-stable tree
To: cascardo@igalia.com,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 10:20:51 +0100
Message-ID: <2026091651-justifier-ramrod-f274@gregkh>
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
git cherry-pick -x 829157e762ed043e28ecb2e9f3c7d22b54e5989e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091651-justifier-ramrod-f274@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 829157e762ed043e28ecb2e9f3c7d22b54e5989e Mon Sep 17 00:00:00 2001
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Tue, 8 Sep 2026 16:59:51 -0300
Subject: [PATCH] Revert "drm/amdgpu: debugfs: avoid extra EOLs in
 amdgpu_gem_info"

This reverts commit c119d05a36a884482decc67e55944648f8cba97e.

It removes the newline even when there are no fences attached to a
struct dma_resv, leading to multiple BOs being output on the same line,
making the debug file less readable, not more as the commit intended.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit a2aafaeb2be13ed3c893e6a44a3a5d26b251ae6a)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 5d9d137209b6..1b6c32a177fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1701,9 +1701,8 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
 	if (dma_resv_trylock(bo->tbo.base.resv)) {
 		dma_resv_describe(bo->tbo.base.resv, m);
 		dma_resv_unlock(bo->tbo.base.resv);
-	} else {
-		seq_puts(m, "\n");
 	}
+	seq_puts(m, "\n");
 
 	return size;
 }

