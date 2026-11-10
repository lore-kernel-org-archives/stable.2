Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794341398;
	b=LpnfmSkYbocyl9Ggo0fF7O+LXnFbrMfgzN3uIRLjx529EQ84Af2qmrCkk3gtdGCr4X+B
	 gFFz6B/pCFIs1g9jHLyjtjT+MQXCQ9VrRzttKNHLnDHg7cXG84eeKSdLvCKKTeJAiPv9e
	 kvw3AnIBBAuDygBVdzWS+jpBB5tVOtlUOpoVGlUQMHsH5T7RBC/FX0bVUCE1XFvAYX2xa
	 qpzn03UNpJvaQlOJLt5n1Hm4tvpg0xDg5GH7Da2p/H/rK1aBApHypXgdluKlNlexrsUld
	 /RWj8ckwa6BLM8hU9ciudhhE1XtESH4fnynxpe/451J39ruzI5UgXQdEXAD09jjb5+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341398;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hFqjAssd77993nns0I6mAzNSOazaCI7Naka9xzicewQ=;
	b=DAfKMXxQ041Y1q2n4tlHQ8tyx5aAb3TgMVc0F55KvSzGSQ/e03JQ4t5w1Lj+wdaS+u/4
	 l7P8TYGWiCpzAIQ5aCv2BYcfNMdnF3CacIhKqECQz4cpahTrr2kPHk2R6gabtvDlK89vA
	 P468kyAE2ZDZMikwhP2cH8xchco2LVaWWPaFT6Fkaa2HE96gwYcHt94lKNGQLFUVABlRf
	 OhupRu9wqJfrj1Cu4VeQG1kIaacVlRM7quA/X/PWssfWB9EoqrKnGlnaraIDGs8I69Etv
	 VURBMx7YrO0M4K5Xk+xMqnB14UpzI9hwRgfF9NgqgkGKZK+xsmLwmcy9K9ZPBRaNe7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YvUJ0bx8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59CD606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YvUJ0bx8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A339E1F0089F;
	Tue, 10 Nov 2026 20:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794341397;
	bh=hFqjAssd77993nns0I6mAzNSOazaCI7Naka9xzicewQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YvUJ0bx8SeAbz9TkN9R2wOWMg7r+mNq1d+2pKm1J6dvKEUAYXtc6VL/01nDnK33vL
	 qfqPNPB9X5ZMQ5CMA4M1Bh/ZDqP+20GPU4pGKX55uq7cu67OXffcMICMk02YXk1ILP
	 Ee69fm9Yar9k9hGPK7o0kR5KMN1/B8NLeJ8Xn8Jhhwvnan2aVUoqDLLftCQsTQ+B5U
	 2hnAtZZi64AtZcNgjIOY72xPeimiJK+bXul/+Qqg9FvPaaLXhooD8mjvMi8E6Cg+P1
	 A+JceyBEKI3baz8Ew150pCMxUZhsYIRXUE5GaNSTQzRQ7v9F9eww9Kpa8z2ZPBr0Ct
	 E2xZs895IK08g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alex Sierra <alex.sierra@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Harish Kasiviswanathan <harish.kasiviswanathan@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] drm/amd: define gc ip version local variable
Date: Tue, 10 Nov 2026 15:09:52 -0500
Message-ID: <20261110200933.3702189-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052447-failed-6.12-232213c9bd7f@kernel.org>
References: <20261107052447-failed-6.12-232213c9bd7f@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Sierra <alex.sierra@amd.com>

[ Upstream commit 9bfe4caa4e57ba343d81e837911242f058688200 ]

For better readability. Also leftover orphaned code.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Harish Kasiviswanathan <harish.kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 232213c9bd7f ("drm/amdgpu/gmc9: add extra type-2 TLB flush for gfx942/gfx950")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 8 +++-----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c  | 5 +++--
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index d82f90f480240..fba9d8c6fd2b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1139,12 +1139,13 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 	bool uncached = bo->flags & AMDGPU_GEM_CREATE_UNCACHED;
 	struct amdgpu_vm *vm = mapping->bo_va->base.vm;
 	unsigned int mtype_local, mtype;
+	uint32_t gc_ip_version = amdgpu_ip_version(adev, GC_HWIP, 0);
 	bool snoop = false;
 	bool is_local;
 
 	dma_resv_assert_held(bo->tbo.base.resv);
 
-	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	switch (gc_ip_version) {
 	case IP_VERSION(9, 4, 1):
 	case IP_VERSION(9, 4, 2):
 		if (is_vram) {
@@ -1158,10 +1159,7 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 				/* FIXME: is this still needed? Or does
 				 * amdgpu_ttm_tt_pde_flags already handle this?
 				 */
-				if ((amdgpu_ip_version(adev, GC_HWIP, 0) ==
-					     IP_VERSION(9, 4, 2) ||
-				     amdgpu_ip_version(adev, GC_HWIP, 0) ==
-					     IP_VERSION(9, 4, 3)) &&
+				if (gc_ip_version == IP_VERSION(9, 4, 2) &&
 				    adev->gmc.xgmi.connected_to_cpu)
 					snoop = true;
 			} else {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 7bbeb9768a56f..a62c94894a274 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1224,6 +1224,7 @@ svm_range_get_pte_flags(struct kfd_node *node,
 	struct kfd_node *bo_node;
 	uint32_t flags = prange->flags;
 	uint32_t mapping_flags = 0;
+	uint32_t gc_ip_version = KFD_GC_VERSION(node);
 	uint64_t pte_flags;
 	bool snoop = (domain != SVM_RANGE_VRAM_DOMAIN);
 	bool coherent = flags & (KFD_IOCTL_SVM_FLAG_COHERENT | KFD_IOCTL_SVM_FLAG_EXT_COHERENT);
@@ -1233,7 +1234,7 @@ svm_range_get_pte_flags(struct kfd_node *node,
 	if (domain == SVM_RANGE_VRAM_DOMAIN)
 		bo_node = prange->svm_bo->node;
 
-	switch (amdgpu_ip_version(node->adev, GC_HWIP, 0)) {
+	switch (gc_ip_version) {
 	case IP_VERSION(9, 4, 1):
 		if (domain == SVM_RANGE_VRAM_DOMAIN) {
 			if (bo_node == node) {
@@ -1322,7 +1323,7 @@ svm_range_get_pte_flags(struct kfd_node *node,
 	pte_flags = AMDGPU_PTE_VALID;
 	pte_flags |= (domain == SVM_RANGE_VRAM_DOMAIN) ? 0 : AMDGPU_PTE_SYSTEM;
 	pte_flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
-	if (KFD_GC_VERSION(node) >= IP_VERSION(12, 0, 0))
+	if (gc_ip_version >= IP_VERSION(12, 0, 0))
 		pte_flags |= AMDGPU_PTE_IS_PTE;
 
 	pte_flags |= amdgpu_gem_va_map_flags(node->adev, mapping_flags);
-- 
2.53.0

