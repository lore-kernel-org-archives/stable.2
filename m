Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272749;
	b=pAYW5ITUEiPztBq8WoRirxzp4/vSUmoHaqG/5HvlKeLf8P/9cJiBcIM6Rcd5U1RdZnAf
	 sX1I991l/jSz9OJVhijdAlAtIUoo6GiIwoo3MG9FMRJcCSIo6C7lrqVKjfQmhJHdV+wde
	 2Y5z5FLyJqnzVNZsItmqhXv+BJ2J/Wjd1r0HpX4qtNM5Om2ThdWfd6y4MYgS58S8YAidg
	 jubRzwaiRfxU1FJnEI51xgcjwKhiXTC7BrW9f8OB5I7tTJKenaXrQ6SgHJea5mfbl5mbN
	 CEXhQLW5O3muplgJNP5STLETZY0dgWrNCJbh6KE1aNvAd3Hu0kX7vMeTz1cteUAZiYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272749;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ezJrqr58Kef0VwssLEn6uKyL+kTt0jJAlX1Lnqev3MQ=;
	b=uVuMReaI1/vRaz4Y32sNVADnTkDQ1544Bs7DLu83CCoHpeqwIk8Q7R98mlMX7nrZu3zI
	 JOwzSBQDH9DBPKCMTFMx2RVxU06cpjRZN68zQSaT8R4IDeiRCU3EqJypTZwhrkkeWNa4M
	 UnbfZgROyAn9rzYNBedmzPcXqAzVteX/TeS0aL3vMbrDSFz44cNNtWE2jpZhLrhWim/DH
	 LCvMZYNOw1ds8iLgOrs8QLWSwmLV8E9i3hgBhntvIm2uBNVSHgGfcR2YqB3HWEsL5mpbv
	 8AKIuCY1TS85Xw86JZeP1FxUcjbQZcOjAa+L0bZT6TYB2xnH+vaz2o6h8D1KRQ1LohA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EMc1HNZK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDBD606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EMc1HNZK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A8A1F0089F;
	Tue, 10 Nov 2026 01:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272749;
	bh=ezJrqr58Kef0VwssLEn6uKyL+kTt0jJAlX1Lnqev3MQ=;
	h=From:To:Cc:Subject:Date;
	b=EMc1HNZKBp+wQQeyTaejDEHR+IKv/6wgqemsIA4yzClIBhnA11u36T0HwCRVRs1Ti
	 gtPrVDeXdO4SCAsFroX9qaHg2TjSzvJ431n1Ys18/6c8wDJHkN49aQ8baSHK5TTBlq
	 XozUoqMBuFow8Fp5OqiVECO5V6Lx4SfM0cUpjIzc7mIC2sPuooHxyo4FfStHJb3crz
	 iM/G3OCCJ7h5saBuAdkN80bI6FTp1x8xrfkhJLgYnS283jhY78I0W21faV6ofbwnv9
	 XjOzOtXVGaTRxNUMoEVk+9JUSGk+t0djUmHQ1WNidLv4E+wACavY5UAG7RfOvB638f
	 l8Fe2h3YQVl7g==
From: Sasha Levin <sashal@kernel.org>
To: jesse.zhang@amd.com,
	christian.koenig@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdgpu: don't walk the CS chunks when allocating them failed" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:05:47 -0500
Message-ID: <20261109200547-failed-6.18-ade92d50aad6@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x ade92d50aad6799a5a9d7e73cd1604fd0576e656
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200547-failed-6.18-ade92d50aad6@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




