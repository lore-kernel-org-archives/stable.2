Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1395823D2A4;
	Sun, 28 Jun 2026 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782658962; cv=none; b=n6/MM6aHM/qg0/OJ/UaPZQHmfrM0riSZpPB9xf8CnsRFtqAOX2V4lTou8Za1qrc3/Lq6vWTK0+P96EBpRwt+GwwOYt3KHgahQet9IZ2ZnkVpvkNTvKqGUMzNG0obTXr7NNH63O6EfvpLJ1+kjIMpwZX4POmsSJHdfyAPq470H6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782658962; c=relaxed/simple;
	bh=hzK4i6G98Ni6u8lkrPFC2md3TaxFQt0rfkLlx0Xq2SQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WhUI+4Vkpgqnln2vafWPMFIyKjeJPjLRrQF+7yxKe20zppWUBR8aN/GG0S+uDLx54e1nmJgzwqmVsVrmoi1F4DpWgXdl1XoKPBf7xmHCBv+ffDZKSrW/9yafqysJ9Uvzb4Mt1jiS8l4khBfNgXqAwQtM5ZhWc2djXv8B7ICrBXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.74.7])
	by APP-05 (Coremail) with SMTP id zQCowADHNemFN0FqF5TJFQ--.35071S2;
	Sun, 28 Jun 2026 23:02:31 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: thierry.reding@kernel.org,
	mperttunen@nvidia.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	jonathanh@nvidia.com
Cc: dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	Greg KH <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/tegra: fix host1x_bo_pin leak in tegra_dc_pin error path
Date: Sun, 28 Jun 2026 23:02:28 +0800
Message-Id: <20260628150228.47948-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADHNemFN0FqF5TJFQ--.35071S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFW8trWxuF1UZF1UJr4xWFg_yoWDtFb_u3
	4kXrykGwnrWFyq9r17ZrWavFyS9a4kuF48X340ka93G3s8XF1UW3y8urnY9w1UGF4rKFn8
	Gwn7Ga10v3ZF9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvf
	C2KfnxnUUI43ZEXa7VUb8hL5UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAMMA2pBLNsO9gABsl

When map->chunks > 1 triggers an error, the function jumps to unpin
before storing the current map in state->map[i]. The unpin loop only
cleans up previously pinned planes (indices 0 through i-1), so the
current mapping returned by host1x_bo_pin is never released via
host1x_bo_unpin.

Suggested-by: Greg KH <gregkh@linuxfoundation.org>
Fixes: c6aeaf56f468 ("drm/tegra: Implement correct DMA-BUF semantics")
Cc: stable@vger.kernel.org
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
Changes in v2:
- Fix patch format based on reviewer feedback
---
 drivers/gpu/drm/tegra/plane.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tegra/plane.c b/drivers/gpu/drm/tegra/plane.c
index 0cb30910773f..e61485ee58f6 100644
--- a/drivers/gpu/drm/tegra/plane.c
+++ b/drivers/gpu/drm/tegra/plane.c
@@ -161,6 +161,7 @@ static int tegra_dc_pin(struct tegra_dc *dc, struct tegra_plane_state *state)
 			 */
 			if (map->chunks > 1) {
 				err = -EINVAL;
+				host1x_bo_unpin(map);
 				goto unpin;
 			}
 
-- 
2.39.5 (Apple Git-154)

