Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D723BA24F;
	Wed, 17 Jun 2026 13:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781702481; cv=none; b=t2f8I5/tHvLZUFfieRHwvcErZ+lNv3q8b7h0hC+yyAHn5+msGSMCrRruDepvTUAftqdB+ednlm60iI3BWTfh7Ygb3f6dRfumcQeiwnYL+yeC033PD/8+wuexfAkaZ+ZE1VtcdquAyiHw8taQ6w71CSBZDFXLA24CtobdilAi6Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781702481; c=relaxed/simple;
	bh=kpygvBfcifuBDEWdYIDGUxQxLu26PMqo11C4UWhNlcc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sNZep3o6bMyd9lvMv2w2kDeMUJ+Z9d7a0yr2TSu6bNEjGBdsz+MHG87zYTu7THD2+0UFH8A63sq30jG2eAd3i/IqtOF8FETn4qVcaYERd3qhYwX3QQWXba+A6KweBetz7ovBguLcroFy5t8xJMVB1nqIDDG5hlPnMvNIueG1d+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wDX30c_nzJqEKm8Ag--.61156S3;
	Wed, 17 Jun 2026 21:21:03 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app4 (Coremail) with SMTP id zi_KCgCn2jE+nzJqBRWdAQ--.32818S5;
	Wed, 17 Jun 2026 21:21:03 +0800 (CST)
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
Subject: [PATCH 3/3] drm/msm/a5xx: make preempt_fini idempotent
Date: Wed, 17 Jun 2026 13:20:07 +0000
Message-Id: <20260617132007.131079-4-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260617132007.131079-1-fanwu01@zju.edu.cn>
References: <20260617132007.131079-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgCn2jE+nzJqBRWdAQ--.32818S5
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?wrm4WwXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnXz+g1OQfMo27QHy5TwQyZw4RkBG+uCXkjoTHCMQ/XMrQ+VxDRSXxPGQotD49GmWfKpp
	yPDu2GgIIjdkSmMp7CWCT10VStYec0Qz5GEzcv5l
X-Coremail-Antispam: 1Uk129KBj93XoW7try5Cw4fKrykXw47tw17twc_yoW8AF13pr
	43KrW0yr1xAa42yw47K3WjkFyrJ3ZxXFs5G34xKws8C3Z8KFn0kr4UZ347tr98uF4Ivr4S
	qr1kG3yUXFyrAwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zc_3UUUUU==

a5xx_preempt_fini() is reached from three call sites: a5xx_preempt_init()
on the ring-init error path, a5xx_ucode_load() when WHERE_AM_I is
unavailable (which disables preemption at runtime), and a5xx_destroy().
It releases the per-ring preempt_bo and preempt_counters_bo GEM buffers
but does not null the pointers afterwards.

If a5xx_ucode_load() disables preemption (or a5xx_preempt_init() fails
partway), a5xx_preempt_fini() frees the allocated buffers and leaves
dangling pointers; a later a5xx_destroy() calls a5xx_preempt_fini() again
and msm_gem_kernel_put()s the already-freed objects -- a double-free.

Null each pointer after msm_gem_kernel_put() so a second invocation is a
no-op rather than a double-free. msm_gem_kernel_put() is already
NULL-safe, so unallocated pointers stay harmless.

This bug was found by static analysis.

Fixes: b1fc2839d2f9 ("drm/msm: Implement preemption for A5XX targets")
Cc: stable@vger.kernel.org
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/gpu/drm/msm/adreno/a5xx_preempt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_preempt.c b/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
index 96ade4936ef8..1186e7a83860 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
@@ -299,7 +299,9 @@ void a5xx_preempt_fini(struct msm_gpu *gpu)
 
 	for (i = 0; i < gpu->nr_rings; i++) {
 		msm_gem_kernel_put(a5xx_gpu->preempt_bo[i], gpu->vm);
+		a5xx_gpu->preempt_bo[i] = NULL;
 		msm_gem_kernel_put(a5xx_gpu->preempt_counters_bo[i], gpu->vm);
+		a5xx_gpu->preempt_counters_bo[i] = NULL;
 	}
 }
 
-- 
2.34.1

