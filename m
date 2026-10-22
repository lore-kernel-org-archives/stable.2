Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792673695;
	b=mfLXCn89DqfqyTmasg4TSPKHi3LAKEB0k65IqYUCV+FJboqT0BnLQwBlLwmNo4/gSzzF
	 J8xG9D6Yi6f09xkVYKcPG/xnO5QyUZgUYjPpWyZUE1N7LPeRobsWDIoZ2ZABZiS/LEN31
	 c76LKvZE4Kbb6dMpD4rDv75RXsvpFBsF/w3BeiHatUeiPRLoH7R6jz6EeuOO/0yUdhFTv
	 SNaLR4oOBHTw1u6o1eqHHPNtbSESwC5EnFDSTyWxf/4OzHGMtqhT3LUYHRhd8BXXbQ4yH
	 ughNWcW6gpa0FS5OO/nLZEeqFrYmL3ykQtHpfM5ds3B6+omb9EJUEoSHsW86E7Dfn/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792673695;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XaAMdlAl5xA/6ERK0qt9znOYU60zrzPyb7EA3K4qJ8w=;
	b=EViIysCiwKD5OiF0Y3XpfRVwEtjm/FUDcfRMprQhIVlTz4qTx/HLXUGb52dFzACKVQzj
	 95n6Y3joAnnxsgL7FrV8NYgOAImTApQvEE9f1v5I17F8RDjspCFlN/Kwvu8wk8XYLAalA
	 l2rgepOvh6kO4h6th78k1+EJhOOAielWsFG/Hct08q4Q3tngBL6ko8F9tQlpuleVIUlWR
	 iWuCKZMAmNECdFL1nxXfDFP52IPrnHlgbvZu/BnXlIxZ/KGVn1jHSdKim29005bHEMyRY
	 RGWs3zYshmy6xyHgsDVWk2j1dBW1YT0mmwGvYq7f+WKCJJ3cAkhXvunZ8n46xVAjARA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CtdDCOEf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5912F606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 12:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CtdDCOEf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750791F000C1;
	Thu, 22 Oct 2026 12:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792673695;
	bh=XaAMdlAl5xA/6ERK0qt9znOYU60zrzPyb7EA3K4qJ8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CtdDCOEfnKx/OU3nXLrdle7iW2qC63GxsRIhGshKOepcbt1yzoWbdqsEaocyNgjaP
	 dPj5bbnm/GjyXDOGGDOl7PjPKJtuZ/Xy2EpcZYOWlyNTmMABVnjyxAxdVM88RvtM+M
	 Tzc/eR/Yttl3hSSp+810+v6aruf1+gLnNMRAivOPNKjCXTILNCEPes7DqVqbsLgk5n
	 Ux0vQOLARUtF67xN9QUeegEKsO56oJ+lj8Rq5eInQN8lMzCmOhLyvjV6TuADv6dVcn
	 +YJxycZv5wUr1/0+X0Oq8nNFTP2CH6+U0hDI6VAF28RK6vOJQUtqHY9SCiia19wZZE
	 fh+O7tCQGDDJA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jesse Zhang <Jesse.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] drm/amdgpu: free the userptr ranges when a CS fails after parser_bos
Date: Thu, 22 Oct 2026 08:54:53 -0400
Message-ID: <20261022125418.1189136-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102129-upright-catatonic-cf8f@gregkh>
References: <2026102129-upright-catatonic-cf8f@gregkh>
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
[ sashal: Adapted cleanup to the existing error_backoff path using amdgpu_ttm_tt_get_user_pages_done() before the mutex unlock. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 38ce4d7c86f00..f8a2c9e41ca31 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1448,6 +1448,7 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser)
 int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_bo_list_entry *e;
 	struct amdgpu_cs_parser parser;
 	int r;
 
@@ -1502,6 +1503,11 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
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

