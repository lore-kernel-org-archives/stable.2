Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BCB3F86F0;
	Mon, 10 Aug 2026 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786378668; cv=none; b=esvyE6XUTgFDirRehbfPx2rwusNeS9UvEJ9lNpSHDhrIlgdi3cHp8TMvG7b9SzPMjua6PiZBsGxzIIHxapCaVqMGrZ7oxxz0HPKGo68iq8031zt5GSYSG7IB/8gy8mj/gw1pbH0NddgFPFAiTKMXWaQvAvj9wPmhtap8uowaeVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786378668; c=relaxed/simple;
	bh=TtwXuOo7f/6QzG98rp5LXPITn3SYcjaZqv2NU1Zo/2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=boYCPxNkPSEi532xKlbfeTOq8d1yVrCD9w15VfG1ggGGRXlrfi9JoSUu/SDH9jf0YNZcOxuIr9UjOckLABt6wZrfG720sq5+dZGk0BBR48Oq0/bub9dsHPVb75jNYp6Gt8AKZtJAgsFveO0SGyTc7HMHkZBtORATehahJ5UBqaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cASpjYhd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cASpjYhd"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB0C6C2BCF7;
	Mon, 10 Aug 2026 16:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786378667;
	bh=TtwXuOo7f/6QzG98rp5LXPITn3SYcjaZqv2NU1Zo/2M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cASpjYhdIVf0owsIGF8yCYwZQ3IeDnTbp0qffmKhq+RzZRsJ8gwg9MMdMibzLnlJV
	 uGpq8UcU7DTtT6CZyY8tOHHQEVQwLel8jWb1CT1tZwF2x9FsOxuwCm6VmAO04fdxFR
	 09hUZEUWe9FpOArXNKFPX4gvyoMuvJArv17DmWFvf87OaTOY7i/TnkaHX95vLyNg94
	 sQWXxmb0ly5a5xFoVEoVNiq8CCLZHfmoXm+xYOAgZNf+2kdcPAf7TuwN3Nmk+BI8Ke
	 3dRzdzYgSkxW77ceUN9jHx3xirPu8egARiWeBs5hTxwyPc2Wjva9wPkqm4RbuUxIEy
	 T/baJexq4Wh+w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCEAC5B56D;
	Mon, 10 Aug 2026 16:17:47 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Tue, 11 Aug 2026 00:13:11 +0800
Subject: [PATCH 2/5] drm/amdgpu: reject PRT mappings as user queue buffer
 VAs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-amdgpu-fixes-v1-2-4954a417b8ff@outlook.com>
References: <20260811-amdgpu-fixes-v1-0-4954a417b8ff@outlook.com>
In-Reply-To: <20260811-amdgpu-fixes-v1-0-4954a417b8ff@outlook.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Junwei Zhang <Jerry.Zhang@amd.com>, 
 =?utf-8?q?Nicolai_H=C3=A4hnle?= <nicolai.haehnle@amd.com>, 
 Prike Liang <Prike.Liang@amd.com>, Arvind Yadav <arvind.yadav@amd.com>, 
 Shashank Sharma <shashank.sharma@amd.com>, Leo Liu <leo.liu@amd.com>, 
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, Junrui Luo <moonafterrain@outlook.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2330;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=lfRKX90eM1yWKlq0c1LdgUl6q5HeCXaJonPRnO3TU20=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrMqfS8MzkkW8LcUEFkwJaFi1V09slfqyG/p2N5wes
 iw49vLaimkdpSwMYlwMsmKKLMcLLn2z8N2iu8VnSzLMHFYmkCEMXJwCMBFRB4b/SdMkBBe5RRtO
 Kl8g8cNstk7TrfXJ4Q4LbT0f2EaHsxRdYGS4rlpeoZampVt1JDRg451N3yeHZ+1T8PzAf9bk7c5
 PjdbcAPu3SQM=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

amdgpu_userq_input_va_validate() resolves a user-supplied queue_va,
rptr_va or wptr_va to a VM mapping and latches userq_va_mapped on
the owning bo_va. It only checks that a mapping exists and that
the requested span is contained in it, never that the mapping has
a backing BO. PRT mappings do not: amdgpu_gem_va_ioctl() routes
every AMDGPU_VM_PAGE_PRT map through fpriv->prt_va, created via
amdgpu_vm_bo_add(adev, vm, NULL), so base.bo stays NULL while
amdgpu_vm_bo_insert_map() still sets mapping->bo_va.

A VA inside such a mapping therefore passes validation and marks
fpriv->prt_va as userq mapped. The flag is never cleared. On the
next unmap of any PRT mapping in that VM, amdgpu_vm_bo_unmap() sees
userq_va_mapped and calls amdgpu_userq_gem_va_unmap_validate(), which
reads bo_va->base.bo->tbo.base.resv before its ip_mask guard, leading
to a NULL pointer dereference.

Fix by rejecting a mapping without a backing BO in the validation
helper, so the invariant amdgpu_userq_gem_va_unmap_validate() relies
on holds by construction. A sparse mapping has no memory behind it and
cannot serve as a ring, rptr or wptr buffer.

Fixes: 2e7ceac0ea41 ("drm/amdgpu: validate userq va for GEM unmap")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 6d3ed55e9ab4..bec107216811 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -259,6 +259,14 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 	if (!va_map)
 		return -EINVAL;
 
+	/*
+	 * A PRT mapping has no backing BO and so can't carry the eviction
+	 * fence which amdgpu_userq_gem_va_unmap_validate() waits on. Reject it
+	 * here, otherwise that helper dereferences a NULL bo on GEM unmap.
+	 */
+	if (!va_map->bo_va->base.bo)
+		return -EINVAL;
+
 	/* Lookup guarantees start_page is mapped; ensure full span is covered. */
 	if ((end_addr >> AMDGPU_GPU_PAGE_SHIFT) <= va_map->last) {
 		va_map->bo_va->userq_va_mapped = true;

-- 
2.51.2


