Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273008;
	b=hjvQOnRMd6P/YpGYO1psniIY2nxzJuaCeTLdOj33xCDRUgwXe3UTVGUb6g8LKULK7zNq
	 8DJwoPiLTPwvBBo33I3oNdtsAUAiqvqu1KmxGDTbOgsHg8s58T7mvROzYWzi1CFmeeIcW
	 51aoW9k1IwzCpMdpjMR42ZWSmDNJnXrNyN2UZb0YFiyyrxwS/DrxBF4ClOP4omybk1DCi
	 xd2sHMtdE5lM7BNbCaLQFUXDX78Q7obaT6xYxNPMDfTM72MeuMY8m5ox7H5PbwrjX+oZV
	 FGCNDDjoVmcZkZbUrnhBrm+C5vW5nr1kq5B/h19ZQxU5hLnbtrz2IHUMtG/48Wzq64g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273008;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=mFlWKOjgXQ9MHj2o871sYkt/LFhToFM0XE7SR9uAVvY=;
	b=YjJ+E60CMRXnoRmG98KI5OqcBmtfJa9ghagSuNZm9rB1OkfKiYgjwyjmde+qRRLXu1b1
	 H3wZwTBIC76DELDJ2cpPFuaalrsS9Xr7CfJuR8tYoVTJTphW1CyGfNrs/6XVn2wSS7VXm
	 AMbKgX+aVqWRRllT+ZDsMMKPicHOt4UW21ZqNf6aRadYXhogSLTjSuPui9uLXqRKgUfHf
	 4Oiutj2F9BMDkSEg5gtncBQAx00wZktQ2uupEAlvTGUxFZxNikGqEiYKR4GO6dwfCVMWp
	 KgwnVy8AaAj43BKGXKQdyK9BkxK0iArYiIOyHKGY7cXGRj+ZB5cd3j6hudBbgfN6m+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I4xCICbg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47304606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I4xCICbg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A461F0089F;
	Tue, 10 Nov 2026 01:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273008;
	bh=mFlWKOjgXQ9MHj2o871sYkt/LFhToFM0XE7SR9uAVvY=;
	h=From:To:Cc:Subject:Date;
	b=I4xCICbgoK5jlo4m45XIxGq1ciuMVTCtHb2pw/hChU5y2718zHVeZTqwpjchebuNZ
	 kR28HJVfuGAUV0YEeIzTuIapq6FtVLjyHGchqMsnbkkbqNvs+pSPDjS9sjJyd81f9L
	 iYzczcRyTDK1DakvGayKymgOx6l5L/J4qForQHgYajmwu91cxn//ox3vS5u3jlaNp6
	 TRCRieu4lqTLxqlltDgE8GWE5aC78IQAJSKog8wjeEqTmZC5ydVZs39RVcbTM8PsCj
	 FQ952t6b8kpQmf5N6Vu3YRk9sgFkbg2JAGQoLTA3lsAEyT/ANt3y8Z22DkcnDB2mR7
	 nrUwnAEicKo9Q==
From: Sasha Levin <sashal@kernel.org>
To: jesse.zhang@amd.com,
	christian.koenig@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdgpu: don't walk the CS chunks when allocating them failed" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:10:06 -0500
Message-ID: <20261109201006-failed-6.12-ade92d50aad6@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x ade92d50aad6799a5a9d7e73cd1604fd0576e656
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201006-failed-6.12-ade92d50aad6@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ade92d50aad6799a5a9d7e73cd1604fd0576e656 Mon Sep 17 00:00:00 2001
From: Jesse Zhang <Jesse.Zhang@amd.com>
Date: Tue, 3 Nov 2026 15:05:12 +0800
Subject: [PATCH] drm/amdgpu: don't walk the CS chunks when allocating them
 failed
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index f51a6c00f6ff0..1ba36dd87637b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -203,12 +203,13 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 	if (IS_ERR(chunk_array))
 		return PTR_ERR(chunk_array);
 
-	p->nchunks = cs->in.num_chunks;
-	p->chunks = kvmalloc_objs(struct amdgpu_cs_chunk, p->nchunks);
+	/* parser_fini() walks nchunks chunks, set it once they exist */
+	p->chunks = kvmalloc_objs(struct amdgpu_cs_chunk, cs->in.num_chunks);
 	if (!p->chunks) {
 		ret = -ENOMEM;
 		goto free_chunk;
 	}
+	p->nchunks = cs->in.num_chunks;
 
 	for (i = 0; i < p->nchunks; i++) {
 		struct drm_amdgpu_cs_chunk __user *chunk_ptr = NULL;
-- 
2.53.0




