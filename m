Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274140;
	b=Fd7z889nz9USo1blpy7tup2iLHHpv2eTdG1NJskYGYEtmIQ5yWCTOn4YLPZXczgLLPdD
	 zChyEChfQBnV1Yd+ZkOoPL3kTz4MkFsG9Jw+8qyPNLHJAIjTCwcAEsNDuL+x9L0Os8avo
	 HAMg2fZEYN05NRhCVfrIhJECWNLT+P/C3JfEswh+OPfNVAcAY0ADSCsJZm+5zEKI/Ppi5
	 foJWIagOy6g+UcPiMmVEiWaKu1C24dhaZE0vhjudjc6riWbiDwVebvGq+h9JZqp54p5ii
	 6d59ZKY+NCUWYkDWW7UKz4wL/O+w54FtOys7Ap1X/B0egPpXHXzCdUQ+IKq5R8TulQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274140;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Lza0/Ti2D/rXOFXmUugp7E9V8wpMwijPNNzFptIpW4E=;
	b=XglT+sAeGp9SODasu7NHpaKxtsunZbdPM3West3HdQJ9tSmZgvUPNubSzWpiHpv4o5cY
	 dRS5PVrSkD7jLGwzDVdCWuwpvsiN308Ae0XRa+nZXgDYPpFkLxDP6MEaGv/rOX4bJLisU
	 qyspP+RfhmR5TCdPeK0Q76LnoZ6tAz68+yJGZ00UDM/2+qlbVi6jdMnYO9bTwZjwd70wK
	 i4BSwrZ12M7cWO45bgGqAwcIueC8rBtIk/i36g8dvkSAZTQac2FLywjPQPmT9TnWXULlt
	 Cg0h0r2tu/YEn4DEzm25rBYn7sW+1ofOyuYnWy+pNVOb2DIbAMoyDm7NsPNDsj6fQeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nPFBJUa1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2396D606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nPFBJUa1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795A31F008A3;
	Tue, 10 Nov 2026 01:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274140;
	bh=Lza0/Ti2D/rXOFXmUugp7E9V8wpMwijPNNzFptIpW4E=;
	h=From:To:Cc:Subject:Date;
	b=nPFBJUa1GbntHhC6Nk7hNnzrA98pGgZlL4lJ4nlsVWs/ifDdpj8AVX/3RdwHoA1a+
	 05lmlTvGEsEMkCZuILI/UBw+f1N5Izb5okvy5CyioTgykX/GQuT8RJf3dVvigGd1cf
	 g+VfmzcmSG1NmZGlq62v8HzdQjW6BJsjzwI3EGblfTQUw5kU+9BTROYUF7fP1FC9vM
	 VYU8truuGorv8SEPMvV8CJEr+S4AbMDISrK81edgSO8wpmKVSiak51Ulft7KAkstUd
	 smPtqkWK/MyGowmtsLhyktLeDCXRRUvG66xbr56f56g3lqGSxvZeLb/eg5YTQzpPll
	 Qgn2jeVIF9HUw==
From: Sasha Levin <sashal@kernel.org>
To: jesse.zhang@amd.com,
	christian.koenig@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdgpu: don't walk the CS chunks when allocating them failed" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:28:58 -0500
Message-ID: <20261109202858-failed-5.10-ade92d50aad6@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x ade92d50aad6799a5a9d7e73cd1604fd0576e656
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202858-failed-5.10-ade92d50aad6@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




