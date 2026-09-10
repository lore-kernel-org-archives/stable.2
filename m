Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1852338DC62
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 19:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789069361; cv=none; b=HQL/v7UyQ+HJYVjb52O2m9RdHGeWUpEdiCBmWXWHz8fkIowmqF/0c+BHR/2wGUcq/G9M45WojUDpCbiijslGlHsplWjlONw+ewPlhmDV19bgItxgQ16JgKoF+kJfa6dn2A/2EfQ/XEVt2vQqR1RkNYvxzotMe80XuERbLvubnhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789069361; c=relaxed/simple;
	bh=oii34dkQdH1tLVvgOKCfLB8O1a8EiWK68qIFHjtowYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i4wtw5A0Q40FFfGMKo6iPECUTW6LgDE1TKXoP3pN8GSx1NLdJEyS/YCFbQq1eIF8WoSDDNpB2BWQsf2EwdpMkIFGRD4D/9ECVKJhSDeEowfoEXWyZT9dBZdVsUI0L2i4Cmbj9Nq4bDXEmabCRFSBYhFDLwq7fZeDBvyi75CqAks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcFQ1QLM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcFQ1QLM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4025A1F000FF;
	Thu, 10 Sep 2026 19:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789069359;
	bh=1YpuzsMRhi760Ioj7E+EsE3lgHmlasBLbVUdVsnHVoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NcFQ1QLMaEuFTTWaRjvunODYs0iB/6XzLrnm+48tSSJXiFG/OonAVmfgodb0YcXIk
	 VPuffIPUdXohdSalmBAjswL5+s6Am8ZHHSqNNgRSNaLwgyV7la2XwP427qkaReB/b7
	 1PqErcZVu5QYUn7YxT+9y9ZJh3r6m8N9/b1cYxY+E+Q/lLL5rWwPVxFbXauxVGfNIz
	 E8xK8mLgkrqPqyfRPHbRwiamSDA9xDfm58+kMAu73eNbnlG/2KI6QhbPtmAMwz9yP5
	 8+Y1kFEBdEi0SqKJdeGoz1vdogcrfljqwmIvRpYu+HXiIJym0y+y7IAEXhVoIRDK75
	 Cdlhy8VcdmqbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] accel/amdxdna: return early from a zero-length flush
Date: Thu, 10 Sep 2026 15:42:37 -0400
Message-ID: <20260910194237.1586329-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090959-anyhow-crinkly-25f7@gregkh>
References: <2026090959-anyhow-crinkly-25f7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>

[ Upstream commit dc14753664240cedf669623b27ae9922b0618b25 ]

SYNC_BO does not constrain its size, so a request for zero bytes reaches
drm_clflush_virt_range(), which ends with an unconditional
clflushopt(end - 1). For an empty range that is the byte before the
mapping, and abo->mem.kva comes from vmap(), so the access lands in the
guard page below the vmalloc area and faults:

  BUG: unable to handle page fault for address: ffffd16fbbc70fff
  #PF: supervisor read access in kernel mode
  Oops: Oops: 0000 [#1] SMP NOPTI
  CPU: 7 UID: 1000 Comm: sync_bo_probe
  RIP: 0010:drm_clflush_virt_range+0x3c/0x70
  Call Trace:
   amdxdna_drm_sync_bo_ioctl+0x124/0x430 [amdxdna]
   drm_ioctl+0x301/0x4c0
   __x64_sys_ioctl+0x115/0x2f0
   do_syscall_64+0xa6/0x3d0

Any process that can open the render node can do this. Reproduced 3 of 3
times on a Strix Point NPU (1022:17f0), by calling SYNC_BO with size 0 on
an AMDXDNA_BO_SHARE object. The import arm takes the same request but
flushes the whole scatterlist, so it survives it.

Nothing needs flushing for an empty range, so answer before choosing a
path.

Fixes: e252e3f3488a ("accel/amdxdna: Revise device bo creation and free")
Cc: stable@vger.kernel.org
Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Link: https://patch.msgid.link/20260817230655.356785-1-taimuraz@kaitmazov.com
[ moved the guard into amdxdna_drm_sync_bo_ioctl() because amdxdna_flush_bo() is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/amdxdna/amdxdna_gem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index a719dc6aab339..ca747457cec79 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -949,6 +949,9 @@ int amdxdna_drm_sync_bo_ioctl(struct drm_device *dev,
 		goto put_obj;
 	}
 
+	if (!args->size)
+		goto unpin;
+
 	if (is_import_bo(abo))
 		drm_clflush_sg(abo->base.sgt);
 	else if (abo->mem.kva)
@@ -958,6 +961,7 @@ int amdxdna_drm_sync_bo_ioctl(struct drm_device *dev,
 	else
 		drm_WARN(&xdna->ddev, 1, "Can not get flush memory");
 
+unpin:
 	amdxdna_gem_unpin(abo);
 
 	XDNA_DBG(xdna, "Sync bo %d offset 0x%llx, size 0x%llx\n",
-- 
2.53.0

