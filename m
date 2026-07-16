Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0523D3CEC;
	Thu, 16 Jul 2026 08:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784190368; cv=none; b=dWOgzkpvuJwEltHX8T+bJMCaeR++RrDS0Ycf7ItYifX5Cu6oDnj7nJig0iiKFlcCnF/8PUalsx8nocseawqRqRKdoD38ILfLeagc43DkvcfPKakYo+OFu8ii/60l8CNXTVyjckZ5VX2NhXLkgdpAOj0kb/q9NuszG+UdMcl58sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784190368; c=relaxed/simple;
	bh=nz62sHLjQi5CpoPoDG4kmScDPG6IyitcREyHqaX4rMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dcyt/2d8TnBQMN/1v/IPIuPVTHQrl/5keQujAJ1ay+4q1Eixd3uKhracO+O2AJYKumeOiBP8g7fWkM/rjm5z1AlC17MKbaZmO0RcIZoVQwBXa+EEeN+7bGRn84RZlqLcaIilb8xTfwd5upLyH2dYGtMS+ym+sDdNNpKkta9UkNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f73253ec80ef11f1aa26b74ffac11d73-20260716
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:b14128e5-a760-4486-9e89-827271766f0e,IP:15,
	URL:25,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:35
X-CID-INFO: VERSION:1.3.12,REQID:b14128e5-a760-4486-9e89-827271766f0e,IP:15,UR
	L:25,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:35
X-CID-META: VersionHash:e7bac3a,CLOUDID:a4d5be2708a8940dd70dc61d4d17da1b,BulkI
	D:260716162558JML0MJ9C,BulkQuantity:0,Recheck:0,SF:10|38|57|66|78|80|81|82
	|102|123|127|136|841|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:11|93
	|82|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1
	,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f73253ec80ef11f1aa26b74ffac11d73-20260716
X-User: zhaoguohan@kylinos.cn
Received: from zgh-vmware-virtual-platform.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <zhaoguohan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 894374176; Thu, 16 Jul 2026 16:25:55 +0800
From: zhaoguohan@kylinos.cn
To: "Rob Herring (Arm)" <robh@kernel.org>,
	Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	dri-devel@lists.freedesktop.org
Cc: Oded Gabbay <ogabbay@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 3/3] accel/ethosu: fix job completion fence cleanup
Date: Thu, 16 Jul 2026 16:25:30 +0800
Message-ID: <20260716082530.1023538-4-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716082530.1023538-1-zhaoguohan@kylinos.cn>
References: <20260716082530.1023538-1-zhaoguohan@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

ethosu_ioctl_submit_job() allocates done_fence before validating buffer
handles. Errors after allocation call ethosu_job_err_cleanup(), which frees
the job but leaks the uninitialized fence.

A scheduler dependency error also lets ethosu_job_run() return before
dma_fence_init(). Normal cleanup then passes a zeroed refcount to
dma_fence_put().

Release done_fence in the common cleanup path and use
dma_fence_was_initialized() to distinguish initialized fences from raw
allocations.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260716065219.931088-1-zhaoguohan@kylinos.cn?part=1
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
Sashiko reports:

> drivers/accel/ethosu/ethosu_job.c:ethosu_job_err_cleanup() {
>         unsigned int i;
>
>         for (i = 0; i < job->region_cnt; i++)
>                 drm_gem_object_put(job->region_bo[i]);
>
>         drm_gem_object_put(job->cmd_bo);
>
>         kfree(job);
> }
>
> This is a pre-existing issue, but was not introduced by this patch.
>
> ethosu_ioctl_submit_job() allocates done_fence. If a subsequent
> validation fails, the error path calls ethosu_job_err_cleanup().
>
> This function frees the job structure but misses freeing job->done_fence.
>
> Can an unprivileged user repeatedly call the submit ioctl with invalid
> handles to trigger a done_fence leak?

> drivers/accel/ethosu/ethosu_job.c:ethosu_job_run() {
>     ...
>         if (unlikely(job->base.s_fence->finished.error))
>                 return NULL;
>
>         dma_fence_init(fence, &ethosu_fence_ops, &dev->fence_lock,
>                        dev->fence_context, ++dev->emit_seqno);
>     ...
> }
>
> This is a pre-existing issue, but was not introduced by this patch.
>
> If job->base.s_fence->finished.error is true, the function returns early
> without calling dma_fence_init() on job->done_fence.
>
> When the job is later destroyed, ethosu_job_cleanup() unconditionally
> calls dma_fence_put() on the fence:
>
> drivers/accel/ethosu/ethosu_job.c:ethosu_job_cleanup() {
>     ...
>         dma_fence_put(job->done_fence);
>     ...
> }
>
> Since the fence is zero-initialized, will calling kref_put() on it
> violate the API and cause a refcount underflow?

 drivers/accel/ethosu/ethosu_job.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/ethosu_job.c
index b76924645aaa..be745e36f1fa 100644
--- a/drivers/accel/ethosu/ethosu_job.c
+++ b/drivers/accel/ethosu/ethosu_job.c
@@ -152,6 +152,13 @@ static void ethosu_job_err_cleanup(struct ethosu_job *job)
 
 	drm_gem_object_put(job->cmd_bo);
 
+	if (job->done_fence) {
+		if (dma_fence_was_initialized(job->done_fence))
+			dma_fence_put(job->done_fence);
+		else
+			dma_fence_free(job->done_fence);
+	}
+
 	kfree(job);
 }
 
@@ -162,7 +169,6 @@ static void ethosu_job_cleanup(struct kref *ref)
 
 	pm_runtime_put_autosuspend(job->dev->base.dev);
 
-	dma_fence_put(job->done_fence);
 	dma_fence_put(job->inference_done_fence);
 
 	ethosu_job_err_cleanup(job);
-- 
2.43.0
