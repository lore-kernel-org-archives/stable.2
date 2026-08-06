Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A04397AFF;
	Thu,  6 Aug 2026 06:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785996475; cv=none; b=hQgtt+2NdeNdVyzALRKq5naIr4Nr5b/nSNmioypRcGAH09tc64zjNabPySuKUTpa6SuLUXbTW079ETpEZmFUhJeQ3hKoX9jgZs0FQnTXh97uUeFwAlhBk3p8X36rqgwI9FK9bEwWWgqAcrp98tYQrckKJ6+xSkQg1PumeaF5P6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785996475; c=relaxed/simple;
	bh=v1kwBJTp+8PbepCUl0jsDhBebrmE7vFLoSFB5gsT89s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NqiNdM/psy8WPWqYFaU6/N4TVWNxMCNRChK3Ke5Xgxr2vtxH5pxvTxasg4uc0mrbQUegXZ40xMaPb/1Kqr9FowSO0mNAEX7mSPnkr7VQ3xFJs1uVdmL4xUV1RhDp6kZwAVmTM6KBvYOoCnk+e1NlyNF4D5JgAR4Le9sjzH2itz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=ZolzeUSj; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="ZolzeUSj"
Received: from LAPTOP-99KJFSET (unknown [36.153.54.46])
	by smtp.qiye.163.com (Hmail) with ESMTP id 48fb94a46;
	Thu, 6 Aug 2026 14:07:38 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Jens Wiklander <jenswi@kernel.org>
Cc: Sumit Garg <sumit.garg@kernel.org>,
	Olivier Masse <olivier.masse@nxp.com>,
	Etienne Carriere <etienne.carriere@foss.st.com>,
	op-tee@lists.trustedfirmware.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Hongyan Xu <getshell@seu.edu.cn>
Subject: [PATCH] tee: avoid accessing dma-buf shared memory after put
Date: Thu,  6 Aug 2026 14:07:26 +0800
Message-ID: <20260806060727.191-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fd5af2d7403a1kunm76c5a6df289405
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGh1MVk9JSkoeShpOHk5LS1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKTkhVTk9VT01ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ZolzeUSj6YRiIv0ruZIBmWVn7EZqYLx5elbDP+PQDVOTVHKiNDX42GiLxepaSEG1cAAnfDOhEOuP3REMaZTvpBhoHuRcnmmGBDLVAUEXGvYZP/fpt2VMFbJc2yi+StiBsU66jy7HDm3CJp4evRISoeUyhLGaIiFgjCUcSUIotmk=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=9RA2Z8b4dmp5tFkLa2Y9ivfrK61mgA5v6jB4BSnog4w=;
	h=date:mime-version:subject:message-id:from;

param_from_user_memref() obtains a temporary reference to the dma-buf
tee_shm wrapper by ID. If closing the shared-memory file descriptor races
with the ioctl, this temporary reference can be the wrapper's last one.
tee_shm_put() then frees the enclosing tee_shm_dmabuf_ref, but the function
still reads ref->parent_shm and ref->offset afterwards.

Save the parent pointer and offset before dropping the wrapper reference.
The additional parent reference keeps the parent shared memory alive for
the parameter list as before.

Fixes: 146bf4e75eca ("tee: new ioctl to a register tee_shm from a dmabuf file descriptor")
Cc: stable@vger.kernel.org
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 drivers/tee/tee_core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 1aac50c7c1de..489c39d5b35f 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -397,6 +397,7 @@ static int param_from_user_memref(struct tee_context *ctx,
 		}
 
 		if (shm->flags & TEE_SHM_DMA_BUF) {
+			struct tee_shm *parent_shm;
 			struct tee_shm_dmabuf_ref *ref;
 
 			ref = container_of(shm, struct tee_shm_dmabuf_ref, shm);
@@ -409,10 +410,11 @@ static int param_from_user_memref(struct tee_context *ctx,
 				 * list instead of the shm we got with
 				 * tee_shm_get_from_id() above.
 				 */
-				refcount_inc(&ref->parent_shm->refcount);
-				tee_shm_put(shm);
-				shm = ref->parent_shm;
+				parent_shm = ref->parent_shm;
 				offs = ref->offset;
+				refcount_inc(&parent_shm->refcount);
+				tee_shm_put(shm);
+				shm = parent_shm;
 			}
 		}
 	} else if (ctx->cap_memref_null) {
-- 
2.50.1.windows.1

