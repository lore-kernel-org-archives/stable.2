Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE843AEF59;
	Wed, 24 Jun 2026 12:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782305689; cv=none; b=Vd9hNThxWo+3F7/lfzVTVLdZmF/K8+PHMHwjErFDeMC9yVBHfgPNUWyM5oE/0hMGWR+/I8NU1I1AlncdTS+vt5GuZHevGv3LGMwfAfiOULdYOBF4mCmdeDtDWzaxKT3Z3c5FhqOjHK3THQeQSwdccV2GksfNbgHkK2SFS2kZNxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782305689; c=relaxed/simple;
	bh=PX65Uws/u7npoi1freBnkSIjgM1Lr6ZNbU/gEi1HGSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EitsboR4QwhxzA+xRj4nQR5Be9ER3DFHlCR2oQGXbqEQTiaK3aZYCuC98Q0K9T91zq35D7JO2jOUTXmyqQ21Xr9dTeNGxrKKQ9PQBK9TNzczSvBH5cdH9UKXnd/NfcSbHCaRFI8cADE0uXYpniUJu5/SrVnxayxulTTcVZACiUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-05 (Coremail) with SMTP id zQCowADXYQXl0Ttq9ogDFQ--.42119S2;
	Wed, 24 Jun 2026 20:47:35 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Lijo Lazar <lijo.lazar@amd.com>,
	Mario Limonciello <superm1@kernel.org>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Xiaogang Chen <xiaogang.chen@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v4] drm/amdgpu: Fix resource leak in amdgpu_gfx_run_cleaner_shader_job()
Date: Wed, 24 Jun 2026 20:47:31 +0800
Message-Id: <20260624124731.37479-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADXYQXl0Ttq9ogDFQ--.42119S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr4DXF4xWw4kZryUGF45Wrg_yoW8GF4rpF
	sYgw12vryUZa1xt34UZ3WkXF95Kay3Xa4fGrnFk39Y93Z8X3Z5JFy3JFWYqr97CrWkCF4a
	grWqq3y7XFnIvaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwsIA2o7lQXSkAAAsE

When amdgpu_job_alloc_with_ib() fails in
amdgpu_gfx_run_cleaner_shader_job(), the function returns directly
without destroying the scheduler entity, causing a resource leak.

Fix this by moving the entity cleanup to a common error path. Set r = 0
on success and use a single cleanup point at the err label to ensure the
entity is always destroyed regardless of whether the function succeeds
or fails.

Also remove the unnecessary error check for dma_fence_wait() since it
never fails with intr=false and infinite timeout.

Cc: stable@vger.kernel.org
Fixes: 559a285816af ("drm/amdgpu: Replace 'amdgpu_job_submit_direct' with 'drm_sched_entity' in cleaner shader")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 523b681d0da9..29a07af6f5f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1689,9 +1689,7 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 
 	dma_fence_put(f);
 
-	/* Clean up the scheduler entity */
-	drm_sched_entity_destroy(&entity);
-	return 0;
+	r = 0;
 
 err:
     /* Clean up the scheduler entity */
-- 
2.39.5 (Apple Git-154)

