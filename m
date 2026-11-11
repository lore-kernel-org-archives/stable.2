Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794360032;
	b=0ABKnBM5HmVtMKhTRs9vrEcpd6iqKVt+25hpchDXj4Bp1fzOHMXd50padiIHFJhXxt5c
	 I7NU4xivy3H89CFvRq/Resxs5uyggutnIFsmBXr43HzrC2pANHQ9EETBUCkkIUM9PVZ25
	 q2tBT8Od+Q2Mk91bjbt+7PnenCq9CMBqlvHP7KG1X3f31wC5/T/ZtVH62HEbPSmLVTXyr
	 XzSMoHG3NIjRUEQou6g5mye/qufDF7y6zHOmodfFVwudk/WZXr/k7+qSW7YY+/nk2yUNU
	 o9x5izbqOiDhINIZN0Eh/AcwGxHLqQJ7S32cPbkJ8Mg2azdkaMPcCLFOoKMj2H7A7AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794360032;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xIMpOZftm0rRTVxACy/iLcOUYIWhHYWaeKTgn96NO8w=;
	b=YkPK+ejYWDjLm4tOpSvW8ak04wCpUeYaLHDXXWIlU9fZilqxMROMBveD0sc2WfGN/3ug
	 pkNhStZhRNv9fSRMACH1Z5+CdnZCtO0iUHIc1V2r31yUCquQbF4Ke/8a+vmU02aFR3VAv
	 c0uaj3BndOuGK/hdkOlKLppBSPyNdTzVN9fO7xSoB98GMsQig59Hh7xggZ04730QNG0N9
	 38GYEpsdu8fTvqoTmNOkyxQRceTqHUiK1ADfDsK+GX+Y7HG4b3tpEXDMynni06PWbpi6a
	 NH2wHc46ddFiCvm3zfEzF2noRnbLtrNw9QxsIfI7hPi2PpegZHUQsDW8gAE6TGRs9sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JrYw2wEh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AFC606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JrYw2wEh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1928A1F0089F;
	Wed, 11 Nov 2026 01:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794360031;
	bh=xIMpOZftm0rRTVxACy/iLcOUYIWhHYWaeKTgn96NO8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JrYw2wEhi1l6JJcgAWkJm1FXvlOjq8vinBgjStoXzO9Hl47XsUBuPA3D7qe450Vfq
	 oY53l0jP85LgGtjztnoW7xfrvXufkzHkMPzUzn7GYWBJcs+AeGWEcKvUrRDpTgGwgM
	 uNLVDjykngJrRABdC7AcqRX7NJGpnAkPKXuW8QGmCpcbcKjjY+esofyaHv7rm8Nf+D
	 nv1TU1163Z9waQwyTscJ0EaVcpxYDDXn1vl1XnpxuzcQEKJOdOC0+ZiD3Cgkcnwcwo
	 DTmex9E84b3F4VyVVlcgxyTS5J37NOjpf/H08r2d8KE42WY7NhIjXUfw3Khsvlw6kh
	 4zZYoFrhkBhYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
	Xiaogang Chen <xiaogang.chen@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] drm/amdkfd: stop restore retries on device unplug
Date: Tue, 10 Nov 2026 20:20:29 -0500
Message-ID: <20261111011811.370172-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062953-failed-5.10-3254ed0b15f2@kernel.org>
References: <20261107062953-failed-5.10-3254ed0b15f2@kernel.org>
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

From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>

[ Upstream commit 3254ed0b15f2fe656c9cb36ccb59b92422440bf8 ]

amdgpu_amdkfd_restore_userptr_worker() and svm_range_restore_work()
reschedule themselves when validation fails with evicted objects
pending. After a surprise removal the restore paths fail with -ENODEV
permanently, so rescheduling just spins the worker uselessly until
cancel_delayed_work_sync() in fini finally stops it - which can take
a while, since process teardown itself is delayed by the dead device.

Treat -ENODEV as terminal in both workers.

Cc: Xiaogang Chen <xiaogang.chen@amd.com>
Signed-off-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 266fab83139600e58db7e900e930c722e619b78c)
Cc: stable@vger.kernel.org
[ sashal: adapted restore retry handling to the existing atomic eviction counter and delayed-work scheduling ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c    | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index a574c89193bc4..ca89abf0aca8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1952,6 +1952,7 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 	struct task_struct *usertask;
 	struct mm_struct *mm;
 	int evicted_bos;
+	int ret;
 
 	evicted_bos = atomic_read(&process_info->evicted_bos);
 	if (!evicted_bos)
@@ -1969,7 +1970,8 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 
 	mutex_lock(&process_info->lock);
 
-	if (update_invalid_user_pages(process_info, mm))
+	ret = update_invalid_user_pages(process_info, mm);
+	if (ret)
 		goto unlock_out;
 	/* userptr_inval_list can be empty if all evicted userptr BOs
 	 * have been freed. In that case there is nothing to validate
@@ -1979,7 +1981,8 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 		if (atomic_read(&process_info->evicted_bos) != evicted_bos)
 			goto unlock_out; /* Concurrent eviction, try again */
 
-		if (validate_invalid_user_pages(process_info))
+		ret = validate_invalid_user_pages(process_info);
+		if (ret)
 			goto unlock_out;
 	}
 	/* Final check for concurrent evicton and atomic update. If
@@ -1988,8 +1991,10 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 	 * reference counting inside KFD will handle this case.
 	 */
 	if (atomic_cmpxchg(&process_info->evicted_bos, evicted_bos, 0) !=
-	    evicted_bos)
+	    evicted_bos) {
+		ret = -EAGAIN;
 		goto unlock_out;
+	}
 	evicted_bos = 0;
 	if (kgd2kfd_resume_mm(mm)) {
 		pr_err("%s: Failed to resume KFD\n", __func__);
@@ -2003,8 +2008,10 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 	mmput(mm);
 	put_task_struct(usertask);
 
-	/* If validation failed, reschedule another attempt */
-	if (evicted_bos)
+	/* If validation failed, reschedule another attempt, unless the
+	 * device is gone for good
+	 */
+	if (evicted_bos && ret != -ENODEV)
 		schedule_delayed_work(&process_info->restore_userptr_work,
 			msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
 }
-- 
2.53.0

