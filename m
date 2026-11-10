Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794341398;
	b=IATh/DS5n/YsAH7TFil+hpU5qmRi4lZ38vHDESIV4N2qdbc0jVj+JuTkmxCxlqyVL65B
	 emtB2nsmCk6lE94vIfHqDo9AW9nA6RpmLWwiKKucXXObQJSV9FFP99A2rxmrdT1ngDq/L
	 Cl6WAun6BNdIBetlnEDHu3V4zWT6J/GllNvPArUoCxpMsaKBba8LegeIAkQ+JBbopnBS5
	 IbcuHLJvscd+vEAhVYxHo+DP9nImv32zPcsCrtu9wa86jQjEHNQ9pdSLQWhu9Tq3miRaX
	 9xRoJ9Eqrg38Qj6G7/ZluEuXHUlMb1ZgEHm55Bhz+C47gYWap4MVECbcgLKEl7TebeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341398;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5QwhOVFzmiFOly5Xr/Dg8FFp80CkReGXh1LlAD7z5dU=;
	b=3Th1Yux53gfTEiLZGVClk85p7qXM0FZYcWLz8l6TZsVeBXcVQVGxOrrBcyAjq/RQC0gX
	 Hy8CBNtXfz2MFXl90NTGEAGZl1xukOZKAlr9A/xxhY4lCqOeJ226+L7SiH1YGKTgYIOiI
	 ga84ELw8LTDgtGc+9S7Og5z7jg/k6P+s9EJsuKoiFe3zS3ZSJeiFN1Olmr+aAwlL+zOW7
	 aU6bdNDMUQ3cofaCVqqqNpHajvEGgvqttC2UgwCEu75dtQf8mBIY8/4Zw/NPyPM42VJCO
	 Xq6kK9s/I4uAEkOw+rZn+84v4tRzz6h3p2/1DHXxFvHqA1ECr3kpCECWzcfFA5uqCyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HUxze3mz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6011F606A323
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HUxze3mz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9131C1F008A2;
	Tue, 10 Nov 2026 20:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794341398;
	bh=5QwhOVFzmiFOly5Xr/Dg8FFp80CkReGXh1LlAD7z5dU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HUxze3mzKrh60GqkdDiDGjBf73AKp/izy8l9OR9Zq3JNyCZL8TlcJ4TdQY77FFpD7
	 bdotCn5cA77GAudlUTw3eajMpFAU6Bg12I8l4TLwNbOqv+Jy9IoAcGTYzlFGNwNJy9
	 UpGzBbKhz/hDQiu6e0F2HITKRl+7IyNWA/DaARMJ7t0WVQxcSVcahHCKGWimujIQcU
	 Xon/ad+Fg7SCtiYQYucsxPtfFL5zCFyBIUy4ImKN6howfEECVL82VADQuR0yn3wJi2
	 jGiB6q3y2mGUhcl+x+V9n0l9aY+x9VGKlSLeW/hzC3J5YNOEndjDvaO7k7VbnoSnYM
	 ITibWh21k6ROQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alex Sierra <alex.sierra@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Harish Kasiviswanathan <harish.kasiviswanathan@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] drm/amd: update mtype flags for gfx 9.5.0
Date: Tue, 10 Nov 2026 15:09:53 -0500
Message-ID: <20261110200933.3702189-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110200933.3702189-1-sashal@kernel.org>
References: <20261107052447-failed-6.12-232213c9bd7f@kernel.org>
 <20261110200933.3702189-1-sashal@kernel.org>
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

[ Upstream commit dad0c70507a834ac12e9286401d90536a3c4cea2 ]

Update mtype flags to meet gfx 9.5.0 requirements for remote GPU
memory and system memory.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Harish Kasiviswanathan <harish.kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 232213c9bd7f ("drm/amdgpu/gmc9: add extra type-2 TLB flush for gfx942/gfx950")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c |  8 ++++----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c  | 16 ++++++++++++----
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index fba9d8c6fd2b1..68390bdbc51c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1207,7 +1207,7 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 		if (uncached) {
 			mtype = MTYPE_UC;
 		} else if (ext_coherent) {
-			if (adev->rev_id)
+			if (gc_ip_version == IP_VERSION(9, 5, 0) || adev->rev_id)
 				mtype = is_local ? MTYPE_CC : MTYPE_UC;
 			else
 				mtype = MTYPE_UC;
@@ -1217,10 +1217,10 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 			/* dGPU */
 			if (is_local)
 				mtype = mtype_local;
-			else if (is_vram)
-				mtype = MTYPE_NC;
-			else
+			else if (gc_ip_version < IP_VERSION(9, 5, 0) && !is_vram)
 				mtype = MTYPE_UC;
+			else
+				mtype = MTYPE_NC;
 		}
 
 		break;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index a62c94894a274..f3a454d4698ae 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1272,7 +1272,8 @@ svm_range_get_pte_flags(struct kfd_node *node,
 	case IP_VERSION(9, 4, 3):
 	case IP_VERSION(9, 4, 4):
 		if (ext_coherent)
-			mtype_local = node->adev->rev_id ? AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_UC;
+			mtype_local = (gc_ip_version < IP_VERSION(9, 5, 0) && !node->adev->rev_id) ?
+					AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_CC;
 		else
 			mtype_local = amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
 				amdgpu_mtype_local == 2 ? AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
@@ -1287,9 +1288,13 @@ svm_range_get_pte_flags(struct kfd_node *node,
 			 */
 			else if (svm_nodes_in_same_hive(bo_node, node) && !ext_coherent)
 				mapping_flags |= AMDGPU_VM_MTYPE_NC;
-			/* PCIe P2P or extended system scope coherence */
-			else
+			/* PCIe P2P on GPUs pre-9.5.0 */
+			else if (gc_ip_version < IP_VERSION(9, 5, 0) &&
+				 !svm_nodes_in_same_hive(bo_node, node))
 				mapping_flags |= AMDGPU_VM_MTYPE_UC;
+			/* Other remote memory */
+			else
+				mapping_flags |= ext_coherent ? AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
 		/* system memory accessed by the APU */
 		} else if (node->adev->flags & AMD_IS_APU) {
 			/* On NUMA systems, locality is determined per-page
@@ -1301,7 +1306,10 @@ svm_range_get_pte_flags(struct kfd_node *node,
 				mapping_flags |= ext_coherent ? AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
 		/* system memory accessed by the dGPU */
 		} else {
-			mapping_flags |= AMDGPU_VM_MTYPE_UC;
+			if (gc_ip_version < IP_VERSION(9, 5, 0))
+				mapping_flags |= AMDGPU_VM_MTYPE_UC;
+			else
+				mapping_flags |= AMDGPU_VM_MTYPE_NC;
 		}
 		break;
 	case IP_VERSION(12, 0, 0):
-- 
2.53.0

