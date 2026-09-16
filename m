Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865884C33E0;
	Wed, 16 Sep 2026 18:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583191; cv=none; b=KBs9Sz+gKOVStyTyVeHFWWtUEjyPtTwRS8EDovL4VtSDi/iLrhSg/ZrSKbrqnSrJxNe80UM0/ZJD9T2pjqxN96gPblkt4mc4fPMKp/dqMUgPuxQNAp6nBHepCwE3RqPk+uBIEc6TUr0BYxWy9p9T90+BY0WjMS/K1Z/jjU3cRrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583191; c=relaxed/simple;
	bh=02pmzJfioY5sM9RU8KqEw/pGb/Mp5V59fFHCtJ+Ck5s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XuLt1bY7heu3nOW/Bc8G2Px9cng2SHmueuicsEFYxpn2aG6aYuAlh1HHDHfFlTIBL1BmTC7v+pnCbETl2plZWbMu/EppT5zalvSZoepmJKuLvt+hW856hceTm1LRvlEMtvfJl4nSazYml9vQKgC2p+WTE4U+vZERcjFNpTM6qo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowADnVD9K36pqEH1vCA--.24263S2;
	Thu, 17 Sep 2026 02:26:18 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	mperttunen@nvidia.com,
	simona@ffwll.ch,
	thierry.reding@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/tegra: Fix bo reference leak in host1x_reloc_copy_from_user()
Date: Wed, 16 Sep 2026 18:25:50 +0000
Message-Id: <20260916182550.2091797-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADnVD9K36pqEH1vCA--.24263S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKr47tFyDWrWkAr1DKw4xtFb_yoWDGrb_WF
	1UWFn7W34DuF4qy3WUAr47ZryIyFn5uF48Xa12yayfK34UZFyjq3429ryDur17Ca1xAF1D
	A347X34SvF4SgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
	4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
	xVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JF
	I_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6r
	xdYxBIdaVFxhVjvjDU0xZFpf9x0JUtgA7UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwUMA2qqpVh7CwAAsA

If the lookup of the relocation target fails after the command buffer
object has been looked up, the reference taken for the latter is not
recorded in the caller's refs[] array and is never released.  Drop it
before returning.

Fixes: 961e3beae3b2 ("drm/tegra: Make job submission 64-bit safe")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/tegra/drm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index 1dcef4e7d104..4e4d41c527c6 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -159,8 +159,10 @@ static int host1x_reloc_copy_from_user(struct host1x_reloc *dest,
 		return -ENOENT;
 
 	dest->target.bo = tegra_gem_lookup(file, target);
-	if (!dest->target.bo)
+	if (!dest->target.bo) {
+		drm_gem_object_put(dest->cmdbuf.bo);
 		return -ENOENT;
+	}
 
 	return 0;
 }
-- 
2.34.1

