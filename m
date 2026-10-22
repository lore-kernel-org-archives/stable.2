Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792678153;
	b=ye3JiJ5NQ8I3P7EwC7/j2X7aw5zPBAO52uKc6nUj3WvxGc6EAZLPpVBW72gt0Ao4Kevm
	 aG9218OtMJUwBGzkqdSgfKot1TcT2eN9h4H89K9eTOD5mKe4L3Py280l7ATFwYxbVY8ag
	 6SkGuyU/50wJqRSzHZuqviA6jVjVsYj7JiqfByDFYWqI82HkJRKSUK+SbZFNoZqXWoPtc
	 QYwU5ItMqs3LQu3PKondRDkXTWZje/gwUeUOmcJvwR/OobaKxWMCAj6nTqPFFPOn9xnTI
	 bvp9uMbuY4Wax9iqQ514j0JhrthEDIpYPPbwRKBNclW6UhD2gVE9v4LE1tmf7aRwyDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792678153;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oaf6ETm+orQAfIIs6cG9pVxGcWgVawUHVcxBE1sS2Rs=;
	b=XxhnDKs/BMl2MPGYhrZ27KBynNRaMRaISodCXy+jlxGxGHpuoe+EixJMTWbqamxb2gv8
	 Pvh8jXCLX/UMf+OXyF4crg4mv7hl0nSKnQhoUwrdW4v8AwfOsOkFHP6xzIx5kyHxFmwQM
	 qcbArFx0AufQdE1X0U52+aDqrhrAoz1TJpbG8xm2VYW9i9eOAhAZwW85a95aIRKJspWhU
	 XbGYtBwUCI8oW0/Y9xRHbXulOB5z8XnTKpbBqBzWksuS8sOIODD+9lgT7QVjVz59nFeJj
	 Yn9bHxsafFhlGP7a/X8qsZTF2wfJRmRPur9yBXODhsCodvdO2PNbm2KuwHkkMapQL/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aBF+GFeG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769CA606A32C
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aBF+GFeG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5CF1F000C6;
	Thu, 22 Oct 2026 14:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792678153;
	bh=oaf6ETm+orQAfIIs6cG9pVxGcWgVawUHVcxBE1sS2Rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aBF+GFeGWsrfAqd0Xh2q8IkimZx3JOKx6q+J1COJXJv6+Kn2/tiojWrUjpjEMdOy2
	 c4H0T7gTYFSZtREA0WfcQavwX750zvtboHn3rrWbqwovTkUkP4dJnGfYLaQrBUzB5E
	 SdqPAy2dfLDoQ2UtL8PDPS5lPvlnNT9lZJTdNgv9/sFq5bOB26F28koo74gMGsikRH
	 cyVpm2W/3CbPQvoKsh6gnO15lCyhHPy/kqzPpvosfe8ncSWUkKVFcmyVVr7I+VhOcB
	 cfyr2nfnPwpwpwrWmPITE+02OxfY/lXrpPQVp4wjHAOCHMpS3dtVuD3UBD8HzapoDC
	 Rq5MbnLPQPQ+g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jesse Zhang <Jesse.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/amdgpu: free the userptr ranges when a CS fails after parser_bos
Date: Thu, 22 Oct 2026 10:09:11 -0400
Message-ID: <20261022140847.1443749-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102130-uncaring-epilepsy-5ad9@gregkh>
References: <2026102130-uncaring-epilepsy-5ad9@gregkh>
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
[ sashal: Adapted cleanup to use amdgpu_ttm_tt_get_user_pages_done() in the existing error_backoff path. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index eb5f528459ecd..528f0aeac36c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1449,6 +1449,7 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser)
 int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_bo_list_entry *e;
 	struct amdgpu_cs_parser parser;
 	int r;
 
@@ -1503,6 +1504,11 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
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

