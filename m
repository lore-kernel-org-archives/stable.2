Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5E93B0ADE;
	Mon, 17 Aug 2026 06:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786949443; cv=none; b=Ispx9iCIYWJrLxxW0+sAcAab12rxLnBFGJ1WsHJfL1Bw0hjUMRg0YEw1YsBEW3xZnkEeFojfUaU23uWXUXxbIxWgIKmkuJxD6PtgkM1mOdrrJuZ5I3qjvQwFmUfJkiIZPrNU/va4HSjVIMdUk0cjLT5lCPqhLeBxd1J1T7QtuH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786949443; c=relaxed/simple;
	bh=c7yNfF9QqHZumWNC+mhX0lWqG29d7qwZWTyfRScotlM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LXB//2eYwzGDCKZ0CZ6zhCNskN1v/Vblz2kn1SlRuQWsFAPLY5tt+Yrh6UGvBDjBCZjaGBuwtrATijtAAILtMdi4UHRUBRYLldmRrX/yJ+DEvNDg+7J7EWuqA+cjU/6zzB1uyif9RmjqNZXuSu55g7ov18A9UihVgPMjMHEsbrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=el+kY4/c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="el+kY4/c"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 139C0C2BCFA;
	Mon, 17 Aug 2026 06:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786949443;
	bh=c7yNfF9QqHZumWNC+mhX0lWqG29d7qwZWTyfRScotlM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=el+kY4/czC/hwp9EnyCHxtFVhG5vXwvNpSCah93+Qzk+iFhebMYqtnhSuXhmNPwnE
	 Xc9dqPABbwnbpKVwgBk6zBgfxFzOqd0cSNPMWxBysRiSguL680kQO+iAAhyg4nSTbo
	 tAbWidtWLIMKq42/jBH/+NwF7bKS1jLAODeQ8n3pOcr+C2EAvbeHQd5RJfVHttblX0
	 ydjPJcS2WkiN1iEaOGAUdGrN/8aedv7tSyoeD2pKeBTi4vokn2XZNBhYOQ/kDn+sF+
	 78ZFHwFxuS97CIBumdcQvX+If75nnLeBxWE5hnNB32fZRB/azRoNpHFNFnw9+cuom/
	 1YIbceaGccQ2w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED46EC5DF77;
	Mon, 17 Aug 2026 06:50:42 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Mon, 17 Aug 2026 14:50:41 +0800
Subject: [PATCH 2/2] drm/nouveau/uvmm: reject replace across page sizes
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-nouveau-fixes-v1-2-f518d0c735f3@outlook.com>
References: <20260817-nouveau-fixes-v1-0-f518d0c735f3@outlook.com>
In-Reply-To: <20260817-nouveau-fixes-v1-0-f518d0c735f3@outlook.com>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Balbir Singh <balbirs@nvidia.com>, Mary Guillemard <mary@mary.zone>, 
 Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>, 
 James Jones <jajones@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Junrui Luo <moonafterrain@outlook.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3937;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=JrbRj77WAEZYgqbdSDa9kkg6Hh7BMr9uleUVTR8LTlc=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrKb1jnX5cn/2r6jb7aEc/+vazYlpjCkX63dkKN3dp
 sv5m/tmHlNHKQuDGBeDrJgiy/GCS98sfLfobvHZkgwzh5UJZAgDF6cAXOQvw3/fVdOqk5bMPvLG
 3Czxyuutb4qD1x+zW3IgRSgzK+mRnN8NRoarbvf8rY+z937p/RCokefy8A/Xq1KXAHHxUxvPMgc
 UtfIBAGS1TOM=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

A new mapping takes over the page tables of the mappings it replaces.
nouveau_uvmm_sm_prepare() only acquires page tables for the range no
existing mapping covers, and the map path frees the replaced mappings
without putting their references. That is only valid while all of them
use the same page size, which select_page_shift() no longer guarantees.

Rebinding a GART BO over a 2MiB VRAM BO therefore leaves the new mapping
owning page tables built for a different page size, and it then maps at a
size that was never referenced over that range. Since raw map does not
allocate, nvkm_vmm_iter() can walk down to a NULL leaf and dereference
it. The remainders of a split have the same problem: op_map_prepare()
recomputes a page size with select_page_shift() while the remainder keeps
the parent's page tables, so a parent that was itself downgraded can leave
a remainder that re-aligns to a larger size. This happens on the unmap
path too.

Reject the bind, and make split remainders inherit the page size of the
mapping they are split from.

Fixes: c488a94e7e14 ("drm/nouveau/uvmm: Allow larger pages")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/gpu/drm/nouveau/nouveau_uvmm.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
index f5e4756b4de4..6404c54d097c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
@@ -85,6 +85,8 @@ struct uvmm_map_args {
 	u64 addr;
 	u64 range;
 	u8 kind;
+	/* Page size to give the new mapping, or 0 to derive it from the op. */
+	u8 page_shift;
 };
 
 static int
@@ -655,7 +657,8 @@ op_map_prepare(struct nouveau_uvmm *uvmm,
 
 	uvma->region = args->region;
 	uvma->kind = args->kind;
-	uvma->page_shift = select_page_shift(uvmm, op);
+	uvma->page_shift = args->page_shift ? args->page_shift :
+			   select_page_shift(uvmm, op);
 
 	drm_gpuva_map(&uvmm->base, &uvma->va, op);
 
@@ -684,8 +687,20 @@ nouveau_uvmm_sm_prepare(struct nouveau_uvmm *uvmm,
 	struct drm_gpuva_op *op;
 	u64 vmm_get_start = args ? args->addr : 0;
 	u64 vmm_get_end = args ? args->addr + args->range : 0;
+	u8 map_page_shift = 0;
 	int ret;
 
+	/* A new mapping takes over the page tables of the mappings it replaces,
+	 * so every one of them has to be using its page size. The new mapping
+	 * is the last op drm_gpuvm_sm_map_ops_create() emits.
+	 */
+	if (args) {
+		struct drm_gpuva_op *last = drm_gpuva_last_op(ops);
+
+		if (last->op == DRM_GPUVA_OP_MAP)
+			map_page_shift = select_page_shift(uvmm, &last->map);
+	}
+
 	drm_gpuva_for_each_op(op, ops) {
 		switch (op->op) {
 		case DRM_GPUVA_OP_MAP: {
@@ -713,11 +728,22 @@ nouveau_uvmm_sm_prepare(struct nouveau_uvmm *uvmm,
 			struct uvmm_map_args remap_args = {
 				.kind = uvma_from_va(va)->kind,
 				.region = uvma_from_va(va)->region,
+				/* The remainders of the split keep the page
+				 * tables of the mapping they are split from,
+				 * so they must keep its page size too.
+				 */
+				.page_shift = uvma_from_va(va)->page_shift,
 			};
 			u64 ustart = va->va.addr;
 			u64 urange = va->va.range;
 			u64 uend = ustart + urange;
 
+			if (map_page_shift &&
+			    uvma_from_va(va)->page_shift != map_page_shift) {
+				ret = -EINVAL;
+				goto unwind;
+			}
+
 			op_unmap_prepare(r->unmap);
 
 			if (r->prev) {
@@ -756,6 +782,11 @@ nouveau_uvmm_sm_prepare(struct nouveau_uvmm *uvmm,
 			u64 uend = ustart + urange;
 			u8 page_shift = uvma_from_va(va)->page_shift;
 
+			if (map_page_shift && page_shift != map_page_shift) {
+				ret = -EINVAL;
+				goto unwind;
+			}
+
 			op_unmap_prepare(u);
 
 			if (!args)

-- 
2.51.2


