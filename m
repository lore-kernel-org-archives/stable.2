Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273875;
	b=Ggsg3kEkzNaFCZ0npER6XRurIm2bTgv6j3bJnkpe/RgAglJoZu9jjsT9PhJvInKH2oh8
	 RDojmcX57slSlSW9N/iTGhZkkvbNYLpINhSCPAmithC7Eewp2juOSo14QFwwA4VefIlHr
	 SsejEEezw56ko9hGYRJ4ete+tCgXS99E4YYmTgswaVq11h9qQRYYbFPd8+IVT5GKpqhov
	 vZrC4t6Z/cxJeHdByDFFEdfROkbQpNgNKiYbY8EDdP4AzE40l1AjDLIYg9OQyDjUl2MJC
	 jNLDcTxEFYcupu0EcrT2ORqDNEzUOD7cWmyfq6RRz+OmZRJ4tNVPuaCYnPEp3pAd4kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273875;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=kTkSoKol/7dWXLgJva58SDNRa2tY/AKIbJymVtP2xTk=;
	b=zCdqj/ZDztJrALzcokamDh8Fm18hrSHOp68rDB6tYXNk5n3Ztsfe8lwv14gBnJoYwMIl
	 nAKfgnR/EXb4sVbHhsiefl8Jyr95m01X6NByxRBJdTup3NRkFn1UQBAC2okYG43Wb8VqM
	 ItCSne4f6omhCzfMMVkkGWKihNt8JUZeCSSBEJZE025BlPLHg7992jB8K8P6LFHZHxbGB
	 aR1Xb4d8e5dFRGOoLj1HGA1J7vznIGYn2NhY3j8VqUNJpiTNFkV38dMp6rX/UErZrSFxI
	 GfZ0rCNb0pLuis0hOkMM0zWVBq0WryfPr1EfBrBsRFirOWgykC6u65tE7HP37AjBQ4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M0nBDNBn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAB9606A333
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M0nBDNBn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3A61F0089F;
	Tue, 10 Nov 2026 01:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273875;
	bh=kTkSoKol/7dWXLgJva58SDNRa2tY/AKIbJymVtP2xTk=;
	h=From:To:Cc:Subject:Date;
	b=M0nBDNBn9dOl5pQaRjV2VdcWm8jEo4GTXSykZPepycMy5UGvmGy/pVwIoB440KrO6
	 DPaT37Zzo3pB8Ab+lx8Fxg6rI1zOA9Dma7lpUM8h8c3dufbO/Ku9snJjJG0QVSEVu1
	 L+cPhV31UBJMfaBNvZz1TaS/YQthZqnSKdHr4wBtl/VTEfwFinI6FnH2WjCvZJo9rs
	 sYJHud8hxs5aHML5xvhz6RVqOMqi16J/sSyKKIRYBs6wtXt2DUEK1iU8xsh6/d8Xfb
	 LT6888LWn37axo+CRlDpC65shidFw8TWMzpttwE0cU9lybmSYn7JoYygHFW09dOXvZ
	 BlcSVLL6GmiKw==
From: Sasha Levin <sashal@kernel.org>
To: jesse.zhang@amd.com,
	christian.koenig@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdgpu: don't walk the CS chunks when allocating them failed" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:24:33 -0500
Message-ID: <20261109202433-failed-5.15-ade92d50aad6@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x ade92d50aad6799a5a9d7e73cd1604fd0576e656
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202433-failed-5.15-ade92d50aad6@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




