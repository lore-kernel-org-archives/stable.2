Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2DA392C2C;
	Fri, 26 Jun 2026 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485407; cv=none; b=YClwvjsS4NNcmSVbPxQb83eCdL78rqznHPRVbk45xkJJWK9g+wCD1DQDCZ2nDnR1QmIFIP8Xxp9l7Rdko41aFAB7iGz38yx04gwGZmMWqwepL19E2rBNxW9W9ENGIi7lHtNtw87R7tYw+Azg5lpw993DktC3x/iIALVlJx07E18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485407; c=relaxed/simple;
	bh=Mercy5eUuV8gKR1aPQkh8T1bkkdFlX5v98zk8XV9c3k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XNlI7w17b4JHqU+j6vNDA8kkMQ/uoEOVOMqQ4WqC5nJAsdU0ZgWRcXVQ70efMpjfmC3F9ZKJrh/4c17v3pI5foK1SAVmz5ddyvpyGI9Ec+ithYbetu+NB+r6u8T5QIlQebbUir5HnXuPKGSQl6pIObGD+2CLgnDR3sCOCzwquMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowADnh9CWkT5q_slqAw--.16627S2;
	Fri, 26 Jun 2026 22:49:59 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: Thierry Reding <thierry.reding@kernel.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-tegra@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] fix: drm/tegra: tegra_dc_pin: chunks>1 error path leaks current mapping   from host1x_bo_pin
Date: Fri, 26 Jun 2026 22:49:58 +0800
Message-Id: <20260626144958.49221-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADnh9CWkT5q_slqAw--.16627S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFW8trWDur4Uur4UAw4fXwb_yoWftFb_Cr
	yDXrykGwnrWFyDur17urW3ZF9IvFykuF48Xw10ka93Ka4DXF1UW3y8urnY9w1UGF4rKFyD
	Gwn7WF40vanF9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUyMKtUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwQKA2o+ikUTtQAAs3

When map->chunks > 1 triggers an error, the function jumps to unpin
  before storing the current map in state->map[i]. The unpin loop only
  cleans up previously pinned planes (indices 0 through i-1), so the
  current mapping returned by host1x_bo_pin is never released via
  host1x_bo_unpin.

Cc: stable@vger.kernel.org
Fixes: c6aeaf56f468 ("drm/tegra: Implement correct DMA-BUF semantics")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
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

