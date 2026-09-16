Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07724AF17D;
	Wed, 16 Sep 2026 09:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552738; cv=none; b=tRqPXQgVX7lMNanS6NmKzDO4FFvR5FZ2vHAKdFuQFPapP03foszRvTbqNFZuOkF9rmPEq1BcvG3o/65woHJhttA16Spzs0TaGqgfUQXU7cfeAiIxXg1CTsD5z4lSLJ1e2ze/lRsvrBczlLVLnhVTHlaAxcQjgyG0be14CGWdMV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552738; c=relaxed/simple;
	bh=q1Ggv5xO6t3FDyZggZHheXutMsgqWu8zdxmPa0BfnhY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q0I7jxFQgfhj2h443LwXJmynmtRQs2koYBSRt5Ztucrfs4vZs9IAWccARfo2zd0mcMZubeJuaWMJ44FFP+34td8m/ER+59J3zE7UiJGkE7/QmbdpzBfLKOu3BG4YO5sZQv4+Pi2nDkZ4BtSpa+uG+bfwZjNP9aIzhD198d7V74o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowABXXDpJaKpqJMXgBw--.37267S2;
	Wed, 16 Sep 2026 17:58:33 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Dennis.Li@amd.com
Cc: airlied@gmail.com,
	alexander.deucher@amd.com,
	amd-gfx@lists.freedesktop.org,
	christian.koenig@amd.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	monk.liu@amd.com,
	simona@ffwll.ch,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Fix runtime PM leak in amdgpu_debugfs_test_ib_show()
Date: Wed, 16 Sep 2026 09:58:05 +0000
Message-Id: <20260916095805.2011304-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABXXDpJaKpqJMXgBw--.37267S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFW5JFWDtFW5uFW5Gry8Zrb_yoW8GFy7p3
	9Yg3WYvr1DZF17t34DAa18XFyru3yaqryxGrykuw1Uu3Z8JF1rJF15JrWjgry8GrZ7CwsI
	vrZ7KrW3ZF1qyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9a14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCV
	W8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJr
	UvcSsGvfC2KfnxnUUI43ZEXa7VUbtl1PUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBggMA2qqPpSseAAAs-

amdgpu_debugfs_test_ib_show() resumes the device with
pm_runtime_get_sync() before taking the reset domain semaphore with
down_write_killable().  If the write lock acquisition is interrupted,
the function returns without calling pm_runtime_put_autosuspend(),
leaking the runtime PM reference acquired for the device and keeping
the GPU awake.

Drop the runtime PM reference on the interrupted down_write_killable()
error path before returning.

Fixes: 6049db43d6dd ("drm/amdgpu: change reset lock from mutex to rw_semaphore")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 092fd3309099..adc0252f6400 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1764,8 +1764,10 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
 
 	/* Avoid accidently unparking the sched thread during GPU reset */
 	r = down_write_killable(&adev->reset_domain->sem);
-	if (r)
+	if (r) {
+		pm_runtime_put_autosuspend(dev->dev);
 		return r;
+	}
 
 	/* hold on the scheduler */
 	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
-- 
2.34.1

