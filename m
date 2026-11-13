Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794532763;
	b=OgTbZwN8pPMZ2xMbW2uw9r1VfIHiQ1s1yrbFHzRgXrq2Kn1LQvSZWz2PbZNIcICFiopV
	 tI6+84B5hPjhQTZdBxQqWDXR3OLSJ6mLRAeLh3mvEEnUFQwDAJEFA1ELSKKM6iaHqkIzK
	 HXGazugcpVtnF26YF9P6dYCzzKaorrYcRFg07B1Sp2yvf78XbBQ71sBXeWrKJxCzA8eBk
	 OM2lZ1n3CB79jYpSmlea9SNmq1E4K+8qgk/4QDcUBZgg48uBrkjPGClqQ3jClWGkJpTiH
	 iXS3q2sflNG5TAtN46or21Yg2B53hkELE/qsxVglUw+++WBGPwUjevOBz31OzSatDhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794532763;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=AK0AaGEwk4cMTiFqsZy64T6KJJduF/beo0b819eugg0=;
	b=SDIPGaeK9Srt3/fUBbnJOx7LM7HQ21xPi6wi7kpRMCFzbWAO7rBzbsJJpHZeDGHJNB44
	 ofvG/f+2oviV9Gsr2tpxUi7jJfVsb9qoLpVZyZtIr9GM4eMkYe7Ihy5N7mIGz9J/xI7IF
	 BL+EyiiXm41nrdm2uRMwah69qThNaPaPf5EBY6gkJAiyM7A3xUk5QlmF+ynzT3sTk9Scq
	 Trjyj7/Q8LheosaxDR4Hr58lFJ8ijP17WbAC1I33h7ej0NNafKjMBlLn8Qgyj10AXbOZ8
	 jY+rx5xZRjiYKnlRXoptBt8JJdY6ldgDnM/YDpTiHRRjbQvXEj+mBumhK46BGsOQiIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W2lev20e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E32606A32A
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 01:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W2lev20e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E429E1F000C4;
	Fri, 13 Nov 2026 01:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794532763;
	bh=AK0AaGEwk4cMTiFqsZy64T6KJJduF/beo0b819eugg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W2lev20eAiQqGUaQDGB7zvZDOtRNiwxmvEFpnkwPIbb1pGoJCxf9bE1FHF1DEeD/M
	 bS/zfN8HEFUowOHr2kEjPNwxogKKQuJvod2yKoRI1JLFP1qdYlGCqPbasSLCX0iS7I
	 WJ0UvuZGpLRQbiOlm98gfyn3riWyd1QKlXXkI1b7B5q7JP/4Cwsj523dTBctsALAMS
	 EFErIIK86bzbHrRGQti4XvTHswtFcP3pktLiG+tGEI9R/85CchekJy7iJPfLGsTkhk
	 H8K9MUe7WWfx3EDFCb7bv9PDuTM23yrN5NzuCcNblpMmLtQSuz+FixAIW6pGTPtV7B
	 pU3e+xYSfefMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jesse Zhang <Jesse.Zhang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] drm/amdgpu: don't walk the CS chunks when allocating them failed
Date: Thu, 12 Nov 2026 20:19:21 -0500
Message-ID: <20261113011912.545798-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200547-failed-6.18-ade92d50aad6@kernel.org>
References: <20261109200547-failed-6.18-ade92d50aad6@kernel.org>
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
[ sashal: Retained kvmalloc_array() with explicit element size and GFP_KERNEL in place of kvmalloc_objs(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 0f6505d4c958b..5a4e7a6623748 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -219,13 +219,14 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
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

