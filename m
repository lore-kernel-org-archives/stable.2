Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794756748;
	b=xXMLArXJe7gDtFS8QTSTC2LU+k0qBwXammQr7bBPalfQ3Vj8xDVxWReIELAdlEmBhaRk
	 YqnuLNmsSrb277Qvm+rmESs5I28V3n3FYs3XQ1h6fEfxW2JXAe6jTMjmQrO4k0j/K9xLV
	 V8GP76opPaPrWGiPoiHpwHDfoowmu51f7C2NWYFhcOOHF9OPFNg0FWNMRYyEJsBH0Bu+W
	 m4cwwaT+YFiQfoYV+CN95vHPsTPbafWDjZhYko/pzQQ446BFxWquyMB4JKdTkOs9lj8+q
	 skk/ymBCnLoqAu3q+d1idC2O28NVNm325uGcyqqKe25VjwRd8F8IPoPm/lRZozPB9AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794756748;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9Gheb114PX2tm5X0UpIyekZ6BqtJsCcfn1Xcv0PiRfo=;
	b=oYrnCwSAtX7ue+Slt8ZnXqaJgFU/s2c+b1n2mp4QQyS+cUoQior0Es6PSCBVAX5bUEXb
	 eiFzTy2fV5IpMXAtEvRV88qXohZbHzL/XNDgNuLml30DGWZ186Kd9rfDv3450k1rct7cq
	 qs2vPpMreD4V8/N9u6PJLzZvTW7qA9MKqmxLbxBsagcVWcnWpuxME+ldRzQoFg0unK2wh
	 iahmpG71srz8Hv9bslR/zkIDIvJiA2IXXX93yBxrjkRu2+GyQDe5vts7KyIoYibJziWRj
	 Trr+msy4g06kuiUYyLHHj06/oTKMgDn4RN8MmkVAxLIAZ6c6K4hnR9kr9ChgFeQ5rvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D3KdkngS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9B6606A31E
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 15:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D3KdkngS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3A51F000C4;
	Sun, 15 Nov 2026 15:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794756748;
	bh=9Gheb114PX2tm5X0UpIyekZ6BqtJsCcfn1Xcv0PiRfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D3KdkngSlrJ24nHR6n+QxY3BVnTk+44aec0990VwPJLhUoaFeAF7OGgRx2XxjVLZo
	 ik8Un9vKRL5sjQNCCZzoALebyBv+o2p4Ex9wGMvcFW68vrol9iT0icnL96sgeOjMeS
	 HjNNduAjZw0sUBgfH5h4deZnJfearIIoVhKHjLO5ZonFhFCVPS6hv/LWu3+zriRkLg
	 mJSQU8bH+lyXvAUfanIFh1u/v5QAipDZ5P6+WUVbCFN9aJIqsfXB9MtdUb1HYPdFa0
	 pQ31aUckTgmFnSumaiZ+oOX33IB3gEM1oDrON4EeXJDtItg5UknQce53XJWj8AHXwm
	 ndEgQvsydjBTA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
	Faith Ekstrand <faith.ekstrand@collabora.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/amdgpu: Check cs flags.
Date: Sun, 15 Nov 2026 10:32:25 -0500
Message-ID: <20261115153059.1559586-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201856-failed-6.1-f5ea64f9fcd9@kernel.org>
References: <20261109201856-failed-6.1-f5ea64f9fcd9@kernel.org>
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

From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>

[ Upstream commit f5ea64f9fcd921bc4e2307a262e19450b8a58524 ]

Had no validation before. libdrm_amdgpu memsets this, even
for the raw/raw2 functions.

We have a lot of functions touching the ioctl struct, no
strong opinion on where this is placed, but I thought
early would be good.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Reviewed-by: Faith Ekstrand <faith.ekstrand@collabora.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 4d01e15e76358f60ef6734462d2b6d9972b9dfbc)
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index cac55781798cd..67dd64eedffd3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -202,6 +202,9 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 	int ret;
 	int i;
 
+	if (cs->in.flags)
+		return -EINVAL;
+
 	chunk_array = memdup_array_user(u64_to_user_ptr(cs->in.chunks),
 					cs->in.num_chunks,
 					sizeof(uint64_t));
-- 
2.53.0

