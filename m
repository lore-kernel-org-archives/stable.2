Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792668915;
	b=nx8KKVKGijEv2Vs1qq9ySwkv6vqH2kI/dBCBm7lZmGtWSw4u/+hqTgmLpnPRBQVPh6sl
	 21Lh45Eia8qq2PhscrlslFF6A3g68NUFS0mwaYDadUzL2KYRcVKDmDFHOlawR6WKjG291
	 y+ZZkUxWGLxN9Ku+75OgrXfAkEyXhnYgnedEyRDhucIMfTk5rlsWe6C3wCUk7DwwQLWdM
	 pkc6CJKi9Xj1Eyv5MkQduydhfMaOwtw47X7L4RBAJsmyqT+fqJ9dFLbyo2vnCPsS5XCXE
	 ll1dtKisiE6vC1adTcQ/RrTCfBdzvP8RfV7GnSQyb/1oIIBi1PUm2OvMjrCNIfKHh9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792668915;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9MCUT1tbnlVFErMzxiXz9/rtWPCwB4Vh9oSWaBSgLm8=;
	b=BnPu6JavHEJW+xth1ct7GjbsUl9WQbBTHnGLMgwo/ossub8J40IP24k270HTqF6ycgl2
	 St8PXrsz1CNUrHfiZcu9iTmsaD/l12A/JrKpJO6CWHR1s8yEe1asJZdjuPdMLu8nm1sFO
	 vSHdSxtCMffBpd23j8/qL++4/Fy90MvrKhfktr+fqBXU93jWFy4yYDtP+09hZgN2QuZIc
	 Ca9X91rT3BHjuA81J80Q/Rn9UMUFOQkKtan7Y1N/6ffRfz9I0Hyd+aR5aMRNLANn6ossX
	 /ov5LfUTbqxr1Z8mIgllEoCiIyZfqrhPS8pYZXyj/F6wdByeWNRLfZgRoTvwOqbawIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WUZLtGNe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6E6606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 11:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WUZLtGNe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5ED1F000C1;
	Thu, 22 Oct 2026 11:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792668915;
	bh=9MCUT1tbnlVFErMzxiXz9/rtWPCwB4Vh9oSWaBSgLm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WUZLtGNe55TgwgvdPD0hBiYKJ8Nl2C3ugWQaejqSZ5t2r7+EibVFsM6JzlG0RJbx3
	 PIbXacqhHpSxGNVF6iq+9le69bBJFwnyEw/4TSIPAdXGaNCkmmRE9IOk6zeD4GOKdr
	 ZmItAde7UEqvwUnsrjqSfNv2U6rXox+efrMmstLrbqWigNJVrezH+nj1IZmi7s90YT
	 RYIdbYsOEHt/LoU6I4cqBQWUnXjG0urioPuHm5+HI4FPGYniDb3sT9Hx/LHjwiJaEP
	 lsaE2WR0WHhVPpCL/s/bjlTd+N7dTKSR0M2ru1MHRVP4WDVF62BlW7M3WAGSo6PeqB
	 da2ijPi6MkgdA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 1/2] drm/amdgpu: Remove the bo list mutex
Date: Thu, 22 Oct 2026 07:35:11 -0400
Message-ID: <20261022113410.917928-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102129-frying-registry-eb6b@gregkh>
References: <2026102129-frying-registry-eb6b@gregkh>
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

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

[ Upstream commit a300c90f00905632ad9f89ad719537941a88600c ]

The bo list is immutable during command submission since the drm_exec
conversion so we can remove the mutex.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 1b4da805a0ba ("drm/amdgpu: free the userptr ranges when a CS fails after parser_bos")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c |  3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h |  4 ----
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      | 15 ++++-----------
 3 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index 43864df8af046..560b409b5b70c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -42,7 +42,7 @@ static void amdgpu_bo_list_free_rcu(struct rcu_head *rcu)
 {
 	struct amdgpu_bo_list *list = container_of(rcu, struct amdgpu_bo_list,
 						   rhead);
-	mutex_destroy(&list->bo_list_mutex);
+
 	kvfree(list);
 }
 
@@ -134,7 +134,6 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
 
 	trace_amdgpu_cs_bo_status(list->num_entries, total_size);
 
-	mutex_init(&list->bo_list_mutex);
 	*result = list;
 	return 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
index 2b5e7c46a39d4..1acf53f8b2f9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
@@ -51,10 +51,6 @@ struct amdgpu_bo_list {
 	unsigned first_userptr;
 	unsigned num_entries;
 
-	/* Protect access during command submission.
-	 */
-	struct mutex bo_list_mutex;
-
 	struct amdgpu_bo_list_entry entries[] __counted_by(num_entries);
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 35d76cfbc88af..2c1c540808109 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -898,8 +898,6 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 			return r;
 	}
 
-	mutex_lock(&p->bo_list->bo_list_mutex);
-
 	/* Get userptr backing pages. If pages are updated after registered
 	 * in amdgpu_gem_userptr_ioctl(), amdgpu_cs_list_validate() will do
 	 * amdgpu_ttm_backend_bind() to flush and invalidate new pages
@@ -1016,7 +1014,6 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 		amdgpu_hmm_range_free(e->range);
 		e->range = NULL;
 	}
-	mutex_unlock(&p->bo_list->bo_list_mutex);
 	return r;
 }
 
@@ -1385,7 +1382,6 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	amdgpu_vm_move_to_lru_tail(p->adev, &fpriv->vm);
 
 	mutex_unlock(&p->adev->notifier_lock);
-	mutex_unlock(&p->bo_list->bo_list_mutex);
 	return 0;
 }
 
@@ -1472,28 +1468,25 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 
 	r = amdgpu_cs_patch_jobs(&parser);
 	if (r)
-		goto error_backoff;
+		goto error_fini;
 
 	r = amdgpu_cs_vm_handling(&parser);
 	if (r)
-		goto error_backoff;
+		goto error_fini;
 
 	r = amdgpu_cs_sync_rings(&parser);
 	if (r)
-		goto error_backoff;
+		goto error_fini;
 
 	trace_amdgpu_cs_ibs(&parser);
 
 	r = amdgpu_cs_submit(&parser, data);
 	if (r)
-		goto error_backoff;
+		goto error_fini;
 
 	amdgpu_cs_parser_fini(&parser);
 	return 0;
 
-error_backoff:
-	mutex_unlock(&parser.bo_list->bo_list_mutex);
-
 error_fini:
 	amdgpu_cs_parser_fini(&parser);
 	return r;
-- 
2.53.0

