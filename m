Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDA614A619
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560890; cv=none; b=ZDr7ROBUTEAAymLVnEPEo8k55tmnTjj4dQk5mBuY1nuWLPkrAmsKBonST6V03gJJEZUuWy2rHybgzsYb5VLoxupCwKr6ffDMYUo9JHabf1czpdsJyQtbqbJ3eJvp+sIoQo2M2ZFjD3tI8Z3vMnVOvWCVdBlHZSZP1HOrMnIasq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560890; c=relaxed/simple;
	bh=1nUtSaqc8O3pqOTvnBjKTifzrD7ZWAs55gEnM/qwGE0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BAHDdrX1yGnnEpEKSqLRCvcDs93G3niO4sESXifsolHgpUtdiQcmkE4tICurHWzkxJisscXd2m3gvFDUzW0OoxiQUsFeBctMua7ld63JoiVFCW+huAi3iW7GUPBTc2KjI23ac0F5IuxONGNtElmXFriN1ke1R2ZyHgDjHYV699I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BKKkoLmK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BKKkoLmK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8171F000E9;
	Mon, 20 Jul 2026 15:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784560889;
	bh=v0l73/pSWgtJnBxs2izXN9Mx+x6zg+n8l1+ij8wQnfs=;
	h=Subject:To:Cc:From:Date;
	b=BKKkoLmKyv0KJGktmpPQxXGgtVNt3A+39oYNgGh6UXWUb6ndXMCT90y78RrBxUYEg
	 Vx0xqH65sUp5A2uRIVC3jxNTwlOQl82rS7kKOVwpIpQ7wBVTLM4X4uMb8Dsqf31Hr6
	 ZiO8YTkoaGBxHFNoo83M3geX8cZIRL60GLiq1WO4=
Subject: FAILED: patch "[PATCH] scsi: lpfc: Fix memory leak in" failed to apply to 5.10-stable tree
To: nihaal@cse.iitm.ac.in,justin.tee@broadcom.com,martin.petersen@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:21:12 +0200
Message-ID: <2026072012-backlash-recycler-8fd8@gregkh>
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
git cherry-pick -x 1bd28625e25be549ee7c47532e7c3ef91c682410
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072012-backlash-recycler-8fd8@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1bd28625e25be549ee7c47532e7c3ef91c682410 Mon Sep 17 00:00:00 2001
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Tue, 7 Jul 2026 12:23:02 +0530
Subject: [PATCH] scsi: lpfc: Fix memory leak in
 lpfc_sli4_driver_resource_setup()

The memory allocated for mboxq using mempool_alloc() is not freed in
some of the early exit error paths. Fix that by moving the
mempool_free() call to an earlier point after last use.

Fixes: d79c9e9d4b3d ("scsi: lpfc: Support dynamic unbounded SGL lists on G7 hardware.")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Reviewed-by: Justin Tee <justin.tee@broadcom.com>
Link: https://patch.msgid.link/20260707065304.949135-1-nihaal@cse.iitm.ac.in
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 82af59c913e9..23355f12fbff 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -8189,6 +8189,7 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 		mempool_free(mboxq, phba->mbox_mem_pool);
 		goto out_free_bsmbx;
 	}
+	mempool_free(mboxq, phba->mbox_mem_pool);
 
 	/*
 	 * 1 for cmd, 1 for rsp, NVME adds an extra one
@@ -8311,8 +8312,6 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 		goto out_free_sg_dma_buf;
 	}
 
-	mempool_free(mboxq, phba->mbox_mem_pool);
-
 	/* Verify OAS is supported */
 	lpfc_sli4_oas_verify(phba);
 

