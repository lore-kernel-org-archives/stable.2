Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362343;
	b=sxIFsmvBdOeNo4MJYj4QaV+/UeWdF6lsQhXABLpPTOM0mvK+dA0JXXUVzaT8s632FZvo
	 5XOEGJb4Be8ftmwBzajMJnb3w52rJgyjdkm8ilRw+cnRRh20a1ECwP2HqJ2ZwuWSyvQaU
	 4UBD5aHywWGGIJJDEdMyP0IBJXGXC3X6CGAxVsM4BodYAIHxyON3b9EnjslyQp9wtgQPu
	 X58I6lN4/O1g3/9Pf1J9h5vQUPBAGe9S+x28J3pQQUV0pjJqf5d3mozGwGNO2H6Wfkt9f
	 82bzcmRVSGmC+YNGXbZuFIKoFQdfviQT89uST4KiDa/O0m/J66P6K0cpnf6RG2CHr1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362343;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=PvjVL4qn34GnCO77qVAnfHpPOYhlz1KAlOCAbzURFuw=;
	b=mn01JOdp+DhRIo9Q0RUJIeuzPHZ3lM5a7Bm6K1zxA3vf4iL16DkXEpZ5a15zAGLXaIY2
	 5IhVSikIIXaMNTC4seNkKOEB14euCdRvyMyBgEtW5AUDXAODiXgwuMJKWiAXdbRu7HW3i
	 ZhbiNrzJCats+bLYFHpa3OdXe/RPH8sifGLtLLqklyn/hYBYpt/qBrljzzS95K3LY+IgW
	 Dbi7bbWDRG9IxnDDolZ+Kx61UJ55OKR+ML5cgANqcc9lDDuiEJoWlMKWz652/dgt1qaiL
	 9jCHBMgrFQktafbufLKYLQp1MpNO8FOWpLtcxq7gXU7SCyeU6XITGfS5qiCGmC2Y35A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ON8RIUS+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF29606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ON8RIUS+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E917B1F0093C;
	Wed, 11 Nov 2026 01:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362343;
	bh=PvjVL4qn34GnCO77qVAnfHpPOYhlz1KAlOCAbzURFuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ON8RIUS+c86ftbVg+ue7RajHXSCjVk2hvnBt+v2PDvra8bgBe8UuwjFgHCFDK1RnV
	 u80+/TWc9r6uiSireIINRloBgnYycil0ZtaFUarSxm1HAl1hUDuhdKPUQoaRASChC3
	 zxx5YqeJzD9jhmWlu6sZSawuxEOe8K12pGnCbRMLCoOFzXROW/lEOKE59hMKmgqjM4
	 a1NRrQbSBUp+4HGnHfewDLpDbt2wp70dJXC8UNQwTCDEiVCYCuPvQpAjgO2lwcuZqH
	 LuH9kPwYAjWVuvREPiOD2l1aaCmqIejI4/OfrL+r8PAasaRhm19xHlDrZe2qtBqTc0
	 afvli+YL+IiDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jesse Zhang <Jesse.Zhang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] drm/amdgpu: reject CS chunks too large for kvmalloc()
Date: Tue, 10 Nov 2026 20:59:00 -0500
Message-ID: <20261111015832.481125-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111015832.481125-1-sashal@kernel.org>
References: <20261107055610-failed-6.1-ba4c3c202919@kernel.org>
 <20261111015832.481125-1-sashal@kernel.org>
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

[ Upstream commit ba4c3c202919405f461a393e823e4b72c8518494 ]

The CS ioctl copies every chunk with vmemdup_array_user() before it
looks at it, for whatever length_dw userspace gives. kvmalloc() warns
about allocations above INT_MAX when called without __GFP_NOWARN, so any
process with the render node can trigger a warning. On navi31, a CS with
a chunk of length_dw 0x20000000 returns -ENOMEM after:

  WARNING: mm/slub.c:6841 at __kvmalloc_node_noprof+0x5a5/0x7d0

Reject such chunks with -EINVAL before trying to copy them.

Fixes: 2098105ec65c ("drm: drop drm_[cm]alloc* helpers")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit dab5f5280406088591645f499f048dcfefab8d7d)
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 37782e2b6cf18..894989f453fff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -227,6 +227,12 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 
 		size = p->chunks[i].length_dw;
 
+		if (size > INT_MAX / sizeof(uint32_t)) {
+			ret = -EINVAL;
+			i--;
+			goto free_partial_kdata;
+		}
+
 		p->chunks[i].kdata = vmemdup_array_user(u64_to_user_ptr(user_chunk.chunk_data),
 							size,
 							sizeof(uint32_t));
-- 
2.53.0

