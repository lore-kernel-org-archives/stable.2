Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1CA3DB626
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 15:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790696556; cv=none; b=DZYbB0BAYK2aDWlTfVZWXoCI/wZPPeh4loWvxhUnMDWeEEuMSyYkPS1eaeFsoX0aaMCZl87lJ6je8ptmXQhoA6zuuoLxVUh1/uaiiue8wtkzUfx+ic4GKqS12d0oOsouGM/rb2SCWNYje6mLbhqmwIZpki/PmVvNaV5Lm8q3K3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790696556; c=relaxed/simple;
	bh=4QXoquDZXRZf9HXF9HEiKoKV6gehnCzuWTE3hjyIsMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYrgMFK9CX/Yb4ujGzBU/4zyQPEQdeRk4/YqcUo86OFDfxesGUA7bzTi21ZYRigSoj8ry5a/2qKFX8pc1DT2PGWibX5/LOtrxAYuO09NpUFsWb3DRNJwN3ViPAn1hWlwVPDvzZbTu2KDg8wnqLnXIhaFEhrNHd3pljoDoiNIxW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gin7NMGi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gin7NMGi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8131C1F00898;
	Tue, 29 Sep 2026 15:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790696555;
	bh=nSVcJaGZF0YJgG99KY9w8djrPaU1fQxBZATu8eOpO6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gin7NMGi/XRCS01QH40ngpO30UhY/iYX4UV2o0Ivjh6ZMEixt4FcMEGhKoJCT5d68
	 7vEgZ8jeqgxdiH/aXoc1CgNm7HddChcPi1zHQ528l4FZqWMRVoC4I8W4M1mC8TRm2O
	 5d489rzuhfhC1OjqKbuuBaE7S/CTp3RDe/lyAk8Br/NJQ0hSQ7hIWCTBa77oKClcqT
	 cxVi+wFulZXDkcYLAA0qdBaqPxW2hEgkMOSG3NQNqx6KxtYdovURldfAreklERhWWn
	 JhvAefM0Mhq45Sta3LDVL4hoW6qaAF8Hg1IIYIUxnZL/JHyFEJpvmkmilXKtCxUb36
	 OwBkT29fNG79w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/amdgpu: Fix acpi device leak in amdgpu_acpi_enumerate_xcc()
Date: Tue, 29 Sep 2026 11:42:33 -0400
Message-ID: <20260929154233.4087662-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092957-folic-dropout-bdd4@gregkh>
References: <2026092957-folic-dropout-bdd4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wentao Liang <vulab@iscas.ac.cn>

[ Upstream commit a997baa61179b450bd55c4810c7ccfed3b753a54 ]

amdgpu_acpi_enumerate_xcc() looks up each XCC ACPI device with
acpi_dev_get_first_match_dev(), which takes a reference to the device.
The reference is dropped with acpi_dev_put() after the XCC info is
initialized, but if the kzalloc_obj() allocation of the XCC info fails
the function returns -ENOMEM without releasing the reference, leaking
the last reference to the ACPI device.

Drop the ACPI device reference on the allocation failure path before
returning.

Fixes: 4d5275ab0b18 ("drm/amdgpu: Add parsing of acpi xcc objects")
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 9211ef48b31ec66999cf55e04d0cbc60cd855fd5)
Cc: stable@vger.kernel.org
[ adapted the hunk to the existing kzalloc() failure block with braces and DRM_ERROR() logging. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index d484804181756..442fd81f1cf62 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1114,6 +1114,7 @@ static int amdgpu_acpi_enumerate_xcc(void)
 				   GFP_KERNEL);
 		if (!xcc_info) {
 			DRM_ERROR("Failed to allocate memory for xcc info\n");
+			acpi_dev_put(acpi_dev);
 			return -ENOMEM;
 		}
 
-- 
2.53.0

