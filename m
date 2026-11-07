Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048015;
	b=oXSv3V0fGb6pFU1R6Baokh4Vi1B82cgM43FKCLo/ceL6EpxzorGviteSCq96a7Ku0uZo
	 IF+cz7nk96eS1D8C1QBxvN/nOICLsunaiA3E2mNfaJNUfmRdgbELOM+u06bJ5vGorCe2i
	 Re4Nz9wvRDKlgnGfdJi3Q0+0ygzqJZ60qlImfgZHxu7qkY9LaveCcZchu4uGk0TqkyGpM
	 bgIm3YGjYUFpXOgLSmjPQc3NWtvPuHK7z+7l//1j6GRMxghBf7md/jMdAV7a1E+pKZLjf
	 mPvqeE/I6iY4yG/MjQBvoIO12SVCE6LWNKhuG6VQPy6DGxiwXUflJ6hS/97zQgK1zsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048015;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1PC2d2LT64zSfGuzFC811dN59hW31MVNV43f9IPznq8=;
	b=hyDmFu0i3UrXB4DHTHV3xUzCKLhY9oEeqiIvtuRSknrdMMYu3SyV7jvX9h3EP2PLv1tp
	 VP4mJtUtSrimiRmK2NgElGiLdC502Nf8n0us44/MNlTcz7XZJ4QqiTs/ON98BAOR+EiYt
	 iYikMLP0U4gYzq8dfTSsd8fcWf4aNaOha+Fp+wPiMTWMjVl6Pzyg8Xq076fMGW7OkTokG
	 RRd81NdDgcBM9kHVmSscgY/U397kayhTttrhbm72epCsA4So6M0s6UmE0l7p3+uKc/rks
	 hZf91u5WN+111lIVfVQMYr0LpFnC9QfCd+vSH5nx8NTha8I5qvdztdp3OUXjqUxOIwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mwpdC1tN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC22606A33A
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mwpdC1tN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DFE1F008A1;
	Sat,  7 Nov 2026 10:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048014;
	bh=1PC2d2LT64zSfGuzFC811dN59hW31MVNV43f9IPznq8=;
	h=From:To:Cc:Subject:Date;
	b=mwpdC1tNqH/UQ7d5RvXliZ3cDOD8GXXHjKmUYPDTJAMfd7y1F+9kx/BBSePTFr5KG
	 AF8+Ux+AtKUNGXhcEjFyVVkfZG8wah8Cmym9f6HNlz9nhFuJO88R65qXUVYnnkiVv1
	 dTLyijDlZq6Cp7BtccN3H7qZ1yy6TTYcp4OcnJB6ysmEltXO80UuPlcAO/yyyDC289
	 PLuJGLQzBjpsu6BRq6L0VSHCVzV8CK9Oe9HgZciIC1TC/eSWg+P6akSenAqj+a7llQ
	 Jd/vCE+S333VPvsxHOJAPGPd9brrBbitRW3ioGZ7YlLdz5RCltF9ky/B11k0Vnd7XH
	 XilPsaO16b06A==
From: Sasha Levin <sashal@kernel.org>
To: jesse.zhang@amd.com,
	christian.koenig@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdgpu: reject CS chunks too large for kvmalloc()" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:40:12 -0500
Message-ID: <20261107054012-failed-6.6-ba4c3c202919@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x ba4c3c202919405f461a393e823e4b72c8518494
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054012-failed-6.6-ba4c3c202919@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ba4c3c202919405f461a393e823e4b72c8518494 Mon Sep 17 00:00:00 2001
From: Jesse Zhang <Jesse.Zhang@amd.com>
Date: Sun, 18 Oct 2026 19:17:57 +0800
Subject: [PATCH] drm/amdgpu: reject CS chunks too large for kvmalloc()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 65e13ad445bbb..70bc53923d119 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -218,6 +218,12 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 
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




