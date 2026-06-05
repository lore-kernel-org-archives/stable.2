Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6325740B397;
	Fri,  5 Jun 2026 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780651113; cv=none; b=V39OUqti7H1nsx5R7Vk5A48cMnn5MEQxDyP4hYQmc8Uk3p7/2Wi8ay/4l/l915GH4ypMhpz4dYGGPduogk6j3kZPo1RU7vxENzxnghhkqkB8BB1PfnqmjCNR0gSC1xorKOfxs5gZmtkwAumc3IMr5G9m1K34n3VwSs0AsfX5EfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780651113; c=relaxed/simple;
	bh=G2QZCEK/vTr4pE+VNeLCozJhrlBQfUXwmoBsD9PjhpA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FCtClHkIcJfF5sWZ4v4Hcw9YhYLC5gF4RN74NfS9mxKO8AomROyI3u87G0IyWWSLUbcd75imGF025CaBv7YBX+nKtSDY3yKxpqoJEkPiRCrD+vgxUH1rJ1If1wFG0ZUUyK6XlBfEVFF1lPqfcxtcxVHh+rf77FGJ8Tcee/U3N7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACXHgJUlCJqDNppEg--.3405S2;
	Fri, 05 Jun 2026 17:18:12 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: lijo.lazar@amd.com,
	aurabindo.pillai@amd.com,
	superm1@kernel.org,
	Hawking.Zhang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/amdgpu: fix fence reference leak in amdgpu_gfx_run_cleaner_shader_job
Date: Fri,  5 Jun 2026 09:18:03 +0000
Message-Id: <20260605091803.6018-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACXHgJUlCJqDNppEg--.3405S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr13AFWUur43Cr45Jw1kZrb_yoW8Jw48pw
	s3Kry3KryrZa12g347AF1UWas0gw13XFy8Wr429a9a93Z8JFn5Jr1YyayFgF1kuFZ7Canr
	Kryqg3y5XFn0yF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VU11rW7UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCREJA2oiXZfMYQAAs9

In amdgpu_gfx_run_cleaner_shader_job(), amdgpu_job_submit() returns a
dma_fence with an elevated reference count. The function correctly
releases this reference on the success path after dma_fence_wait().
However, if dma_fence_wait() fails (e.g., due to a signal interruption),
the code jumps to the error label without calling dma_fence_put(),
resulting in a reference leak.

Fix the leak by adding dma_fence_put(f) before the goto err when
dma_fence_wait() returns an error.

Fixes: 559a285816af ("drm/amdgpu: Replace 'amdgpu_job_submit_direct' with 'drm_sched_entity' in cleaner shader")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index b8ca876694ff..88bec4e93712 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1686,8 +1686,10 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 	f = amdgpu_job_submit(job);
 
 	r = dma_fence_wait(f, false);
-	if (r)
+	if (r) {
+		dma_fence_put(f);
 		goto err;
+	}
 
 	dma_fence_put(f);
 
-- 
2.34.1

