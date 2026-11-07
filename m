Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050044;
	b=kzoC3e08LBdDXjEhlX5It0kOvwr9QqZnyrY40a/KdaYRQpocgSJhZOC3QGT0n4DszTDw
	 aQM8E8JCEzQCCj5HVLlDEZAcAfKs2BZXYzf5MCYDHwn12qtRVTebdOOEGlPIGcQ7N7NnC
	 glD6wW/Xm+iIbpdSXZEQ5XIRqRPD5krvvjQ8wE/mM5ZWUqKVBtuUw/m7fS3K3Rs5jFvng
	 M8aTRM5KBPzlwfobM185SYgXS/0cX3bQ3fI/fZKtIqWrD5y5xd/H7S/aQDKKX0N7ERNhl
	 bD0jBRe2v1Sc858u/gcDbqmL+61eSisd3oBg9Rj382KFMqNvAVzll0LevgmETkAQ7QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050044;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ekucqzTk0teoLdXXfjtFrupZ4TkEC1omNK1imssMazw=;
	b=VDNfejA4cuWN+DBfEAZupozJXcYfAS1l/rOw5QtQssz9x7I4LrYT4NUdFFRcMa6doCt2
	 x5YAlGGYsLMRQUQGHLXdRpUzKNnHE/PzGPMWS4t+lki1b8XYEOzTfjrrG9TYKFklBZqlD
	 SXa72pGFhQ3lLMSgAfFRhA0JJ9QaAjKWQOSdqgsR9a6/oVQAXDVwo//eAck6QPlDxyaFJ
	 sNtaU1PYFnbvFbve6a8yRgMCL/aEeP/LmqeiNpefjMpmAGORazy2u6Ebh6Q1mzpUtqhRs
	 BELZqNFLrNvlcsbB0sX4mXoWTudVBAm5t7Yd9fwsHwg7aX4d5XQNkq9sELfp9fyc5WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mh8TABuV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB80606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mh8TABuV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D9C1F0089F;
	Sat,  7 Nov 2026 11:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050044;
	bh=ekucqzTk0teoLdXXfjtFrupZ4TkEC1omNK1imssMazw=;
	h=From:To:Cc:Subject:Date;
	b=Mh8TABuVdWbD7iYBOhN7FijrLYgL4+L3A8VbEV+I+D7AxJi00th4p3u9GatgsATpJ
	 7sWhGR1skpFNOj4g3w5C1RgcARAP/rr8B+XDsA45NTgHrrJdZLUUQOZDSqWOnWZWj5
	 3KKGXGMck2ld2hdSItqT2w+nrcYZJkhTPi7St3fVdqnP+DjNQz4ES6GwBIznMEGTsv
	 w96dtozPgKL5jtAMWyk52xV9dnmcytZjN0rnRxbGczl7qjuiuvt0d8xiu8fNPWoDuH
	 Wz6QFMyEpsmr4LYBgDpeJ7jnrfNSPkVYN0y4UJSkVGvHUEXOWMU6S3dwz7UAnNVmBi
	 LCaSNZm5FTAtw==
From: Sasha Levin <sashal@kernel.org>
To: yubiao.wang@amd.com,
	christian.koenig@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdgpu: recompute the dw estimate after allocating a new VM update job" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:14:02 -0500
Message-ID: <20261107061402-failed-5.10-a74c7832b118@kernel.org>
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
git cherry-pick -x a74c7832b11827907de560169c7d4ac94505fd87
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061402-failed-5.10-a74c7832b118@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a74c7832b11827907de560169c7d4ac94505fd87 Mon Sep 17 00:00:00 2001
From: YuBiao Wang <YuBiao.Wang@amd.com>
Date: Wed, 29 Jul 2026 17:53:57 +0800
Subject: [PATCH] drm/amdgpu: recompute the dw estimate after allocating a new
 VM update job
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

amdgpu_vm_sdma_update() keeps the number of free dwords of the current
job in a local variable. When the job runs out of room it is committed
and a new one is allocated, but that local variable is not refreshed and
still describes the job which was just submitted.

The stale value is then used to decide how many PTEs fit into the new
job. If it happens to be copy_pte_num_dw + 7, or one more than that, the
result is zero. copy_pte() encodes the transfer size as count * 8 - 1,
so a count of zero asks the engine for a 1GB copy starting inside the IB
pool. That runs off the end of the pool, faults on the first unmapped
GART page above it and hangs the ring.

Re-initialize the estimate from the newly allocated job, which is empty
and therefore has its full budget available.

Cc: stable@vger.kernel.org
Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index 50cc0779c340e..eb8cf0d9d9c59 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -254,6 +254,11 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
 						     AMDGPU_KERNEL_JOB_ID_VM_UPDATE);
 			if (r)
 				return r;
+
+			/* The estimate above describes the job which was just
+			 * submitted, take the budget of the newly allocated one.
+			 */
+			ndw = p->num_dw_left;
 		}
 
 		if (!p->pages_addr) {
-- 
2.53.0




