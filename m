Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A2012CDBE;
	Sat,  5 Sep 2026 02:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788575544; cv=none; b=LzTftj7A2sXch51cXt1zVY/Qp44XwLoGXdV4ejcbRTftaIceXqd+u4Hd+3vwjvF0WdSiItGXNWEY1ClO+VwxmCCU6ym5Dv9VzcMaoOcmv1DcuMRvVCA2VIV76wNGrhDTpx3mb+/3brA4GuddOyCAGSCT3Raj1iwVPJBZsof8zak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788575544; c=relaxed/simple;
	bh=VcbI1zdpgsAUB7yCSIZHS6yIjgEbJZvgBpxWQznmC3s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X623S37j5851aTHv6hI8FCuCtoMqrMz0uW+Ss87MQlU8ElpCWl2QYPWDmYBnL5rrERNLqR+Pp2TUOBdfb5o28jH5Ha9Rfy8ZhmXDnmC+vtxrJ4FvjZGnZrJkzeMocUeUMc9vtKtDXje/p0pt081yuet/G2mZdkM+6C0Bg9Xhfbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cucbROWx; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cucbROWx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=vE
	zmrB5MeuSiRL/5kGaj4D0jLgiYVOzfWaAYz/uOVNM=; b=cucbROWx88pqC2EWHY
	4hQZ5tBjzjM+lv1YjQLT3MPvv2Hy+XxLzMxod+rhZV3yrYgPoIwdel8sm//yMANg
	t900v+9izRkLj6YOBlOX+MAYHHunJf/gUrsOeqYk0xz9UNV1usVvmsS3Hyq1fXbo
	DGcnyjC0nDGq6PxSCUlA5t/8E=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3_1gbf5tq0ootAw--.50391S2;
	Sat, 05 Sep 2026 10:32:04 +0800 (CST)
From: oushinnyo <oushinnyo@163.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Harish.Kasiviswanathan@amd.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	oushinnyo <oushinnyo@163.com>,
	stable@vger.kernel.org
Subject: [PATCH v1] drm/amdgpu: keep freed VM mappings on clear failure
Date: Sat,  5 Sep 2026 10:31:51 +0800
Message-Id: <20260905023151.90699-1-oushinnyo@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_1gbf5tq0ootAw--.50391S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WryfJw15CF4DGF45Kw1DGFg_yoW8AFWrpF
	WrGFs5K3yUXa4jqw1DCF1jva4Yyw4xXFW09r4UuwsF9w15AF93tFn8Aa18JryDGrWkuFW7
	XrWkt3yUu3WqvF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEWSo9UUUUU=
X-CM-SenderInfo: xrxvxxpqq10qqrwthudrp/xtbC4wRqt2qbfyT7wwAA3o

amdgpu_vm_clear_freed() removes a mapping from vm->freed before
clearing its page table entries. If amdgpu_vm_update_range() fails,
the mapping is currently freed even though the PTE update might not
have completed.

This is particularly problematic with CPU VM updates. Waiting for an
earlier submission is interruptible, so a signal can abort the wait
before any PTE is cleared. The old mapping then exists neither in the
VA tree nor on the freed list, allowing a later VM update to reuse the
virtual address while an earlier submission still references it.

Put the mapping back on vm->freed on every update error. This keeps the
pending clear operation alive and makes later VM updates retry it before
installing new PTEs. It also covers partial CPU or SDMA updates
conservatively.

Fixes: b4d42511b7f2 ("drm/amdgpu: Support page table update via CPU")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5
Signed-off-by: oushinnyo <oushinnyo@163.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 47cde5459469..e20905d2d90c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1606,11 +1606,12 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 		r = amdgpu_vm_update_range(adev, vm, false, false, true, false,
 					   &sync, mapping->start, mapping->last,
 					   0, 0, 0, NULL, NULL, &f);
-		amdgpu_vm_free_mapping(adev, vm, mapping, f);
 		if (r) {
+			list_add(&mapping->list, &vm->freed);
 			dma_fence_put(f);
 			goto error_free;
 		}
+		amdgpu_vm_free_mapping(adev, vm, mapping, f);
 	}
 
 	if (fence && f) {
-- 
2.25.1

