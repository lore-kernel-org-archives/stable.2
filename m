Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597540;
	b=xgWUq9ZMgFmJok/UvdT90XmgQkSvzsBYoMa0w1tjEK4SvcnWAk/gV5HvP58nDVjwIALo
	 TogCHlHY99rtvQgXBfgp1FcOyvExpNgQTfEQYDGmPDyaIDebs0THpNs/nNkx0Up+WZEZ8
	 ZVAOpPB/+pmgK+8Vy13XOs/A0nj3x4FaVKnJ/56nhF74RxITO46R0FBeJxsi41UD3vJZg
	 mS80037xHFlmfj1iwXkqXkpdsLasjZGzmWQZjm3Yqgq/kok6cP151wwaPhh486vRTa09k
	 YNk1PCSAYe572DK+Az6NCRKVg+oNQcO4kUFo0mtQ0J95T2csS2pS50Wp8MPsew+ShWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597540;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=PWltaqhhArMBtmTuKQL1RcN6aVZWcklCJcHV6qRZ7pY=;
	b=1W8dBLz56dynlwt6z0MYc7bhnebcnYqizUITfiWbPG3mNSGypGRS2UBgiia9IKweXk4j
	 LOn3R4zNOGdvrpWsvn+m8VPNSvxSQ34RbhZ+pf+NThoXuVTLgGiUBZtDHZEQeYn+yO+BI
	 Qah02lvdaIgt8K74E7fsexyzayZRIa1RVjTmuNVCdGVSpMkySvXPdzpgSzTPgEfW94/uH
	 2FPII+/rQ6wVani3DimgXTIJtmWzXz8ot9Oeh904IhknjJY45S2GbuwapjEhnpEHaQuFd
	 qp73nxXvxtjozi/7x1baW+IQ1OHwmnmXGI+Dxsr+pByl85721Sl1FSdB11QEoB+nCew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hEeCraZp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94A2606A32D
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hEeCraZp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9001F000C4;
	Fri, 13 Nov 2026 19:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597540;
	bh=PWltaqhhArMBtmTuKQL1RcN6aVZWcklCJcHV6qRZ7pY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hEeCraZpi+JRMIxKyMvfcru3UR3djYnTqcr5Zq6bQeL8iQl3P6ZczTue0icpUhqUN
	 4Gze8YyaQKRDU9NsYvWDiMSzj8HdvDDF1NAe7MiNvEpTMzw5M9qLCU4Z5Ll8GFvS8r
	 JY9eF1Du3MFqYwfbru/OhTdIjdgl1fZXKPLvudrQ12fD23IGMYP0vFN4koEvgaeeI6
	 L5DCnKsklHzJXWRA0ASx27VkUDuJgs5jfyKXl/ynHpa2r+2FFYyIbnTbRN0kt+qUiH
	 y+3EjPHFzP7SD3UObdrBMJIHv8oSvK9kx2c12w+ujNIdCyAcpCog/vl6EH8vJg1A4J
	 P7TxFmKYYNRdg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jesse Zhang <Jesse.Zhang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/amdgpu: don't walk the CS chunks when allocating them failed
Date: Fri, 13 Nov 2026 14:18:59 -0500
Message-ID: <20261113191528.2250750-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201006-failed-6.12-ade92d50aad6@kernel.org>
References: <20261109201006-failed-6.12-ade92d50aad6@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jesse Zhang <Jesse.Zhang@amd.com>

[ Upstream commit ade92d50aad6799a5a9d7e73cd1604fd0576e656 ]

amdgpu_cs_pass1() sets p->nchunks before allocating p->chunks, and the
allocation failure path skips resetting it. amdgpu_cs_parser_fini() then
frees the kdata of nchunks chunks from a NULL array. On navi48 with the
chunk array allocation failed through failslab:

  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
  RIP: 0010:amdgpu_cs_parser_fini+0x35d/0x710 [amdgpu]
   amdgpu_cs_ioctl+0xcae/0x7a20 [amdgpu]
   drm_ioctl_kernel+0x180/0x320 [drm]

Set nchunks once the array exists.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 0c828445757b86aaa3ed2638832d76f450022bdf)
Cc: stable@vger.kernel.org
[ sashal: used kvmalloc_array() with explicit element size and GFP_KERNEL instead of kvmalloc_objs() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index c49aabb343a72..364fbaf4e0fa5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -215,13 +215,14 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 	if (IS_ERR(chunk_array))
 		return PTR_ERR(chunk_array);
 
-	p->nchunks = cs->in.num_chunks;
-	p->chunks = kvmalloc_array(p->nchunks, sizeof(struct amdgpu_cs_chunk),
+	/* parser_fini() walks nchunks chunks, set it once they exist */
+	p->chunks = kvmalloc_array(cs->in.num_chunks, sizeof(struct amdgpu_cs_chunk),
 			    GFP_KERNEL);
 	if (!p->chunks) {
 		ret = -ENOMEM;
 		goto free_chunk;
 	}
+	p->nchunks = cs->in.num_chunks;
 
 	for (i = 0; i < p->nchunks; i++) {
 		struct drm_amdgpu_cs_chunk __user *chunk_ptr = NULL;
-- 
2.53.0

