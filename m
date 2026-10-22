Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792668916;
	b=12BavonBTZjMeJbmx5rYFlQhBGVLfMZTGDDukXvIw6g8DHL78rFdAe4/s2aCNVzlxB5+
	 idF5fHe/nU0NTwnqQEKOs+vdd/VnzHlETH4mEQuJCjnBom/qdWeMikYuH8dNfFqAInnir
	 a1GFyq3iXQPLTzNm8stZ0uHOtycKvKQKMSCnBK3maCK7rZIMNQN5yrbTQmF0aHfLPSLze
	 35IehQ15DvGK8u0neaPJCF7lPu6xuqSQAGLmBeHg9IMGmH4+BOxN3VGi0kxfcNUyjiOPa
	 xwGR8qTApdkoAed6xnv9ptO/gPIXMDCrpmVjr2uy1v+cnxA5ahlRu8L8Q3nnyUa+uUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792668916;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FPj32X6Nu3TTBINIhmsXh2D0w9Zb87XpFhq/W5XJTKA=;
	b=k1RORfa5QLdxDaNnGAb3lUm40ZqG7IIEorCm5S9YZ4/a49BSNOPnLn0ehI652bb7pn+n
	 A4fLVmjcDWwT2e1brfz+lZuX1E3Cp193+pnFBJfR4nEsOAQ0dGrkW21OY5UGqyNTgBlrQ
	 /5y6yBG4Z2KywPm4pkSjG5wMrE0GkstWwyejHLOlsPBeeZdOzoTywL0Dk/Ev9YUjAvRdO
	 BoKT+ft80THwvO/5ujtoWc/rXH86B+HLY1pCo/vi1UpRfGvUxbGroIkRGNlotYXbPJwLA
	 XxwhgrDAIdnW54vf0mrUXkBG6fXk1175dvq7SAasEaoGjlQZxUOALCKOrLtdT+C698Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iMxJEPbK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9640606A31F
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 11:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iMxJEPbK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7DB1F000C4;
	Thu, 22 Oct 2026 11:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792668915;
	bh=FPj32X6Nu3TTBINIhmsXh2D0w9Zb87XpFhq/W5XJTKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iMxJEPbK7NSNBejgp181GfCfUGrgZn6BMQ/l1PE9rfagwE10xqeuepgJSO5vmpJU8
	 rWk7R425/m5B2YsEaPy2XiYLSfdhsya+PENUgq6AeVp8baMEWUybo3EmnXzzjCOSHy
	 wN7aCXUWVl4L9WMjk03s66dgrchS7B09FQHknnJ66hpeoTOdQTfYB6SdhyvnRnoo5U
	 z6t+2+iWYoK0DoBrbKKJOLz9qsn3bGWmMGpmgaBvCBV4v8mxNv85rSGjvHGCMkagQe
	 XI3rrl4mAjzXHxl2OsOexcqzwnx8fTiJa6xKZI3KXS4OmIO2e8PxjK9n1n7AkoGrbI
	 CibcP6UIQMrmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jesse Zhang <Jesse.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/2] drm/amdgpu: free the userptr ranges when a CS fails after parser_bos
Date: Thu, 22 Oct 2026 07:35:12 -0400
Message-ID: <20261022113410.917928-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022113410.917928-1-sashal@kernel.org>
References: <2026102129-frying-registry-eb6b@gregkh>
 <20261022113410.917928-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 2c1c540808109..75b39a41fb923 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1434,6 +1434,7 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser)
 int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_bo_list_entry *e;
 	struct amdgpu_cs_parser parser;
 	int r;
 
@@ -1468,25 +1469,31 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 
 	r = amdgpu_cs_patch_jobs(&parser);
 	if (r)
-		goto error_fini;
+		goto error_free_user_pages;
 
 	r = amdgpu_cs_vm_handling(&parser);
 	if (r)
-		goto error_fini;
+		goto error_free_user_pages;
 
 	r = amdgpu_cs_sync_rings(&parser);
 	if (r)
-		goto error_fini;
+		goto error_free_user_pages;
 
 	trace_amdgpu_cs_ibs(&parser);
 
 	r = amdgpu_cs_submit(&parser, data);
 	if (r)
-		goto error_fini;
+		goto error_free_user_pages;
 
 	amdgpu_cs_parser_fini(&parser);
 	return 0;
 
+error_free_user_pages:
+	/* amdgpu_cs_submit() only drops the ranges once it got that far. */
+	amdgpu_bo_list_for_each_userptr_entry(e, parser.bo_list) {
+		amdgpu_hmm_range_free(e->range);
+		e->range = NULL;
+	}
 error_fini:
 	amdgpu_cs_parser_fini(&parser);
 	return r;
-- 
2.53.0

