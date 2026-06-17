Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3233C76BD;
	Wed, 17 Jun 2026 13:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781702484; cv=none; b=d29et9KzmDrcTyUFWE2P7sQrpcinRYfFYJkgFottRbC1VW5kzuPj+HqNFcKA7KqIiQlKyjffZKi8dMBZ+YrHUGcr+efhM77aYuzI4DPzCBUESxIrglu0e5se5xcN/vcZ9pP1lgsMtX/LEW7LKwSl+dO2ZqgWjpiHc4EE0x6TaSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781702484; c=relaxed/simple;
	bh=cXlYSp6X+FT8ZbCLH75IrY765ExigFdRAkqrsvjTB0I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OhFh9pR7oDx7KzUIpGsdoO5u09YAJRIdHBXdnjiT/+X0Dw5baQvRWyq62xFPamnQo/mWiYobsWrjIt+p7Unp/4/n4WVui5RhG5U+zd0y1PHqOMZDWx2erhJzGrki9B0heFC9x0QQuVTuWu/jm2dX4jbiRfcIbExdhXEurJ41IV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wCnFjw+nzJqCam8Ag--.54892S3;
	Wed, 17 Jun 2026 21:21:03 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app4 (Coremail) with SMTP id zi_KCgCn2jE+nzJqBRWdAQ--.32818S2;
	Wed, 17 Jun 2026 21:21:02 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: robin.clark@oss.qualcomm.com
Cc: sean@poorly.run,
	konradybcio@kernel.org,
	akhilpo@oss.qualcomm.com,
	lumag@kernel.org,
	abhinav.kumar@linux.dev,
	jesszhan0024@gmail.com,
	marijn.suijten@somainline.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH 0/3] drm/msm/adreno: fix preempt teardown races and cleanup
Date: Wed, 17 Jun 2026 13:20:04 +0000
Message-Id: <20260617132007.131079-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgCn2jE+nzJqBRWdAQ--.32818S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?HXMpeAXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnXz+g1OQfMo27QHy5TwQyZxLwNNxMHD+hlcs/yDr0L/NQ+VxDRSXxPGQotD49GmWfKpp
	yPDu2GgIIjdkSmMp7CXN5RPxYw6l01w8CbPzC/8w
X-Coremail-Antispam: 1Uk129KBj93XoW7Ww4fGF47Jr43ur1kGF1kXrc_yoW8WF1Dpr
	WfGrWSyr4xA34akw43AF1kuFy5AFWfXFW8KryIg398Cw15Jr1jgF17ZryUXF98WF12yrWI
	qFn7Kr45WF15ArcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU80385UUUUU==

This short series fixes three issues in the A5XX/A6XX preemption
teardown/error paths.

Patch 1 fixes a use-after-free: the preemption watchdog timer
(a5xx_preempt_timer / a6xx_preempt_timer) can fire during GPU teardown
and dereference the a5xx_gpu/a6xx_gpu container after it has been freed.
timer_shutdown_sync() is added to both destroy paths, and the timer is
initialized at GPU allocation so it is valid on every teardown path.

Patch 2 fixes a buffer leak: a6xx_destroy() never called
a6xx_preempt_fini(), so the per-ring preempt_bo/preempt_smmu_bo and the
preempt_postamble_bo were never released. a6xx_preempt_fini() now
releases all of them, clears the pointers, and is called from
a6xx_destroy().

Patch 3 makes a5xx_preempt_fini() idempotent. It is called from three
sites (init error, a5xx_ucode_load when WHERE_AM_I is unavailable, and
a5xx_destroy) but does not null the GEM buffer pointers after put, so a
second call double-frees them.

Patches 2 and 3 build on patch 1; apply in order.

Fan Wu (3):
  drm/msm/adreno: sync preempt watchdog timer on teardown
  drm/msm/a6xx: free all preempt buffers on teardown
  drm/msm/a5xx: make preempt_fini idempotent

 drivers/gpu/drm/msm/adreno/a5xx_gpu.c     |  2 ++
 drivers/gpu/drm/msm/adreno/a5xx_gpu.h     |  1 +
 drivers/gpu/drm/msm/adreno/a5xx_preempt.c | 16 +++++++++++++++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c     |  5 +++++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_preempt.c | 21 ++++++++++++++++++---
 6 files changed, 42 insertions(+), 4 deletions(-)

-- 
2.34.1

