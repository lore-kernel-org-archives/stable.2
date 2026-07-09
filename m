Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F371BD9C9;
	Thu,  9 Jul 2026 12:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783600981; cv=none; b=ArnkSHTRE1NE+ZEFuZ0UJug1EQIVJZVo8GW4yk2yvSjUkCijpR4sW2mElHm59bLu9PAp6l/xLsgYxjobEbUf4t/PlIg+/GsauUJgG8sRHQ9s+l888YmZlfPLO9I/C04KAw7zZ2SrmLWwa1/zlO9g4TW2M1KctPe4+w8I98FGR0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783600981; c=relaxed/simple;
	bh=3FQBNC/pdRcS4V1XzrPnyF7wXWQ06YKt2mDewijeLQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R2owGqI6W6t6iVXM8tZqn0BkBL2PkXQF9zp8ynDP8FAyYw1dDsrr5BovL2yHEXivYmGZygm5y6TvX38Dj51BCehA7NHO5AyNMG6jFbYPT1o7Rh3NxLT1vYBvv0+/8y+UzAuXpVkHa32kDIN7SmMu9GP0lH4BeOh/VcSmjU7k5sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S.localdomain (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowABnBc5Jl09qhrZPBQ--.6430S2;
	Thu, 09 Jul 2026 20:42:50 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: alexander.shishkin@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH] intel_th: Clear dangling resource pointer in subdevice alloc error path
Date: Thu,  9 Jul 2026 20:42:43 +0800
Message-ID: <20260709124243.8127-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABnBc5Jl09qhrZPBQ--.6430S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw18KrW3KF1UArW8WFyfZwb_yoWkWFc_C3
	W5Cw17ZryrGFnIkry7ZF4UZr9YkFW2grZ3ZFsrKr9ay342grn8Wrn7ZryrXr1DW3yq9ryD
	Gws2qr4fWw1rujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbwkFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbhSdDUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwEDA2pPMbT0HQABsO

When device_add() fails, intel_th_subdevice_alloc() jumps to
fail_free_res which kfree()s thdev->resource but leaves the pointer
dangling, then falls through to fail_put_device where put_device()
triggers the .release callback intel_th_device_free() which kfree()s
thdev->resource again, causing a double free.

Set thdev->resource to NULL after kfree() so the subsequent
intel_th_device_free() finds a NULL pointer and skips it.

Cc: stable@vger.kernel.org
Fixes: a753bfcfdb1f ("intel_th: Make the switch allocate its subdevices")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 drivers/hwtracing/intel_th/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index 3924e63e2eee..3ab1a37b045e 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -696,6 +696,7 @@ intel_th_subdevice_alloc(struct intel_th *th,
 
 fail_free_res:
 	kfree(thdev->resource);
+	thdev->resource = NULL;
 
 fail_put_device:
 	put_device(&thdev->dev);
-- 
2.25.1

