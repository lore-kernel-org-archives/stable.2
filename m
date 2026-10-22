Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792682077;
	b=vbZhVIVmmGEmgXZWJxc03Ktan8GRefpu9FMlZfhwPjCHhGjbfUH0J74REtM7/UAXJQvd
	 LDmCZgIV909Xnw/RmAK7MzJxJyRqxjpJcaBSW0Z+fAy9+fCPChI0G0mG20kTTDy+Vv46G
	 cKh9j4YhVfhhOA7+Nv51Ov9BXzWOItUra0dLT14gxIlFOf5sM6wxnF6Gj3DBc2eK+KpGy
	 wQux+3MxK8Nzulm1UB39F6DdxkIuWDDEmSRBtEvodAGNJ5iVdwa4KjHDukuWn9rlY5vXC
	 +zuVgwEEJVyYIMGqIXlU0oO2jxdrIR1O+wUUNBhjM5YDJV4zjVpR/GmRhYQYEThYjQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792682077;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KgWVFDa2E0cLr/9Wnj7v1nG+UnLVadTXNL6vt+3ilwA=;
	b=Gj7kUy1j4MxFzcJ/b3cmz8gu1uiLXhGUxxxYVZuPyup3arPY6L34Lx0tKlwqdOmfk5aq
	 A9cjGZ+6f0is8RuR3yrZHdtSzciYClWKw3I7Im0MsdHNd+K74lq1cnQd9DxK4VrqdfmpI
	 ax83aNN23p96p4kmfdVE53p6boznJ2s3Z0TgaJYbqylSNgSkwgmZ/kWnSvuJxgrXQJY8O
	 4nJbxEWdy3KnUNkIKqVYPEEoIS5NHBC7eVGLzSd2YDPDmLTQBaa0iBAP121tJIN8w9TWa
	 Xb0rt9nUlp8GrEIAMH4Jsx6kmdax7VkoeoeyT5RAmQKDcJK6MtJ+eS3KnNK0G/vMMuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k9LMa7At;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1810F606ACD9
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 15:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k9LMa7At
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B6D1F01825;
	Thu, 22 Oct 2026 15:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792682076;
	bh=KgWVFDa2E0cLr/9Wnj7v1nG+UnLVadTXNL6vt+3ilwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k9LMa7AtMuRJIr8V6ieRNGbYQBY3C7CcatuZ5Fx9xyIbN6XqUikRuoG2JaUapxgOQ
	 FEoijDm2sGECeQf9gF/LIiIeHkgUFRft+NDEVlf1b64mUZYZIeh7L0VGSoH4VVuZJB
	 IXGohub0T0JRTXa4LZttGgICaJMGVcDmyL3Y8gh9A/in2jNZhHxVtmjOkxrl0a3Bk+
	 SJeuQ61MyP1wR4U3BMiGecXaouaYjKwImaz6XK5hZ6r9OxJ3G2865KX2y5ZFv0rp81
	 dzvMahrkEBshcPcoTmQ+lXYcC6HQoRllS+rnLV8mk3oW5Kl43djYZTL3VgQO2qj74S
	 02oADClmGPbtw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jesse Zhang <Jesse.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/amdgpu: free the userptr ranges when a CS fails after parser_bos
Date: Thu, 22 Oct 2026 11:14:35 -0400
Message-ID: <20261022150728.1586153-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102130-unworn-juggling-1cdf@gregkh>
References: <2026102130-unworn-juggling-1cdf@gregkh>
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

From: Jesse Zhang <Jesse.Zhang@amd.com>

[ Upstream commit 1b4da805a0ba354a549ce07459c871c17dd94fe0 ]

amdgpu_cs_parser_bos() allocates an HMM range for every userptr entry of
the BO list and looks up the user pages. Those ranges are only freed when
amdgpu_cs_parser_bos() itself fails or when amdgpu_cs_submit() checks
them under the notifier lock. If amdgpu_cs_patch_jobs(),
amdgpu_cs_vm_handling(), amdgpu_cs_sync_rings() or the early part of
amdgpu_cs_submit() fails, nothing frees them: neither
amdgpu_cs_parser_fini() nor amdgpu_bo_list_free() touch e->range.

Each such CS then leaks the range, its hmm_pfns array (8 bytes per page
of the userptr BO) and the BO reference the range holds. An IB on a ring
that patches the CS in place (e.g. VCN) with an unmapped va_start fails
in amdgpu_cs_patch_ibs() and takes this path.

Free the ranges on those error paths. Ranges amdgpu_cs_submit() already
dropped are NULL, so freeing them again is a no-op.

Fixes: fec8fdb54e8f ("drm/amdgpu: fix userptr HMM range handling v2")
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit c52a9542ed7cfd527feb938bd0accada2ac8d267)
Cc: stable@vger.kernel.org
[ sashal: adapted cleanup to the existing error_backoff path using amdgpu_ttm_tt_get_user_pages_done() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index df7a5775d361e..6709041c4b94a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1440,6 +1440,7 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser)
 int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_bo_list_entry *e;
 	struct amdgpu_cs_parser parser;
 	int r;
 
@@ -1495,6 +1496,11 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	return 0;
 
 error_backoff:
+	/* amdgpu_cs_submit() only drops the ranges once it got that far. */
+	amdgpu_bo_list_for_each_userptr_entry(e, parser.bo_list) {
+		amdgpu_ttm_tt_get_user_pages_done(e->bo->tbo.ttm, e->range);
+		e->range = NULL;
+	}
 	mutex_unlock(&parser.bo_list->bo_list_mutex);
 
 error_fini:
-- 
2.53.0

