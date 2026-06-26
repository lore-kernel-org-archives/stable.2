Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB541DFFB;
	Fri, 26 Jun 2026 12:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782476514; cv=none; b=lhkl4vG6ZIAG5duoEXkaxc5zzIDSAwrD8E2US84/g2XiPHydR2E8WOOEb77C4x5Yu+fhpydUyLwUHJfJ6/mJvJl2DRkk1G9kXpGkighL1e0pWilK98QM93f3A16MPkL3UlULseM+aH/2n5rYg1S3AYDDu3dfH7wx2kiH9tPxluE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782476514; c=relaxed/simple;
	bh=vLOKBcrc63VddPsDy6p81z6kYwZ+TobrdCmhG/cIbCI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XDWuRnPojdM6IF39OmU6ohmznzp9WgZj+ROReOb6jRAZ3LDRcSiY4lGVIw+YCTr4r0KZAO6qgZbHupOwX+SsRbx0i8910XPvo8g9lIDcOTCDy7Rroix0rzW5sZ2nU4iDpUYwxVPtnJzpYlx2HKsgJaLtRKGxcXMhEL3MYv/3eA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-05 (Coremail) with SMTP id zQCowACXCOzabj5qp9NnFQ--.11068S2;
	Fri, 26 Jun 2026 20:21:47 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: sumit.semwal@linaro.org,
	christian.koenig@amd.com
Cc: linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fix: dma-buf: unwrap_merge_order: success path leaks chain and array   fence references
Date: Fri, 26 Jun 2026 20:21:45 +0800
Message-Id: <20260626122145.35549-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACXCOzabj5qp9NnFQ--.11068S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JF4UGw1UXFy8ur4rXF48tFb_yoWDXrbE9a
	18GFn3X34vyFsxtr17AFn0vr9akryUZrs5Crn2qFyay345ZFnxWw4DWFs7X3W8Xw48WFWD
	Jr92q34rJry7ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
	IxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUhtxDUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQ4KA2o+TZNnCwAAso

The success path only releases a2 via dma_fence_put but does not release
  a1, c1, or c2. The dma_fence_get calls at lines 440 and 445 were intended
  to pass references to mock_chain, but mock_chain already acquires its own
  references internally, making these extra gets surplus and permanently
  leaked.

Cc: stable@vger.kernel.org
Fixes: b1cce631e61f ("dma-buf: add selftest for fence order after merge")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/dma-buf/st-dma-fence-unwrap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma-buf/st-dma-fence-unwrap.c b/drivers/dma-buf/st-dma-fence-unwrap.c
index 9c74195f47fd..72ca632e3981 100644
--- a/drivers/dma-buf/st-dma-fence-unwrap.c
+++ b/drivers/dma-buf/st-dma-fence-unwrap.c
@@ -472,6 +472,8 @@ static int unwrap_merge_order(void *arg)
 	}
 
 	dma_fence_put(a2);
+	dma_fence_put(c2);
+	dma_fence_put(a1);
 	return err;
 
 error_put_a1:
-- 
2.39.5 (Apple Git-154)

