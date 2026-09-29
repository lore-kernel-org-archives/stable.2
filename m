Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD5E3E4C7B
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790697045; cv=none; b=QAmZO36VFakapyWOxUYIGelG9Zxb9VZ8itd9N4O+sqh8tV2/Iq7yapoCOPTmaKOYUWVr2lmAKiOTkbXBwOG1qPEXxakcw2GS2MYzzjfIjIRkoiiIYOHxjZFR0w9w66zaTOP85QHll3bGJiKD/t82XVof3RHlvyuichlo3QCQ4a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790697045; c=relaxed/simple;
	bh=ynKNkfs1Vg9Dlh3s7a2idHOGpQOYDUWFTpycbCJRsuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZz24gq0CswIWSqMLmQyiTLjtX20lT6gJxKWmVnCgg899XjRsROrlb+AHHbPqrc6JOFi/dm3qawSnQxZHBCCN1imh8nCuDPzuWBpKaiSU8mg97vG+zOoh4FXCXm4yRLgKvPy2jdFSZuyUVQvxlYEZo4P2UEWgjvPg5JHQm65xf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5QGhk4M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5QGhk4M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5350C1F00893;
	Tue, 29 Sep 2026 15:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790697043;
	bh=sAxWBFO28s54R/D+uByO5OJhQ0NPBVknoEsDkwfx4b4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C5QGhk4MyoILvWs/8Zx2nOpldMYK+058eQSa9TVH+rXmvcJkVWIZXooaPQG7NQFB2
	 9eMIURRlpdimjDGpStCWwkoWE5fsGLF15GQgUWLRbXYGqyDZ30xgkEIMsdva+FBT5s
	 7wd6C05RKT86kiOmTzw4SmtuuLGVWsBwuAdHT1v1PHOu5yr8L+cqgspdyDEmQ6NMpP
	 DkAbyjd+koVtQM9h33Ed1c4HG+4fpdTfAyRkWR3BfVbIKC8UkOBt8QanHtPMvMOWi7
	 hF9DxjugBFv0WlBjXCptYIWXw3WbtGiuDJgr7GDupNGX6Xxjk1dUgwAOPiIK/Nzgpw
	 YWJym6vtqKqLA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/amdgpu: Fix acpi device leak in amdgpu_acpi_enumerate_xcc()
Date: Tue, 29 Sep 2026 11:50:42 -0400
Message-ID: <20260929155042.4095950-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092957-surreal-herring-0708@gregkh>
References: <2026092957-surreal-herring-0708@gregkh>
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
index 7730e56444934..45cea079d6c82 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1110,6 +1110,7 @@ static int amdgpu_acpi_enumerate_xcc(void)
 				   GFP_KERNEL);
 		if (!xcc_info) {
 			DRM_ERROR("Failed to allocate memory for xcc info\n");
+			acpi_dev_put(acpi_dev);
 			return -ENOMEM;
 		}
 
-- 
2.53.0

