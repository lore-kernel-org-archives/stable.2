Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9569043E06E;
	Thu, 10 Sep 2026 08:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789028191; cv=none; b=FDeSRz1kG8BsRSALzO6vewWghPfLgLqhQdbJb0uPev8r9XgYns/maO/gWcz1qwl90G1vkl/nbxUkoR1oDKVSxZMx8+uRR/gi+WTbgxQVy4R5dcDqeHypu2bg72YSUbKASY5loNKcmZoC/OFYBDc6oo0/POvJKMJaoTPl5xVi0AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789028191; c=relaxed/simple;
	bh=UukVNUlYRSADEuitvWiu7FZr654YDkY/O55oeljGjBg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fHYpmofE30lp/fDWRxhIUASCQQwaNCn4A1IzMTZ6W+AjYnpl/uD9yM0P9NcY7AVrGX9yS4dCDznKUzt9uN0L77gVegfJ8sn3g8oK9F8UxpDFCEOertGLiMn79y8dKhm4zZmg6ftLvDF5klYat4cLzZ4i93Al2Sjn+ja7OGe3fuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=iFzTX/7M; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="iFzTX/7M"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d421c52d;
	Thu, 10 Sep 2026 16:16:15 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Steve Longerbeam <slongerbeam@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>
Subject: [PATCH] media: ov5640: Initialize mutex before probe cleanup
Date: Thu, 10 Sep 2026 16:16:08 +0800
Message-Id: <20260910081608.1264077-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa08a638f4003a1kunm0a5a666218c294
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCGh9LVk8eHx9KHR4dGkMeQ1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=iFzTX/7MVvSgklVd6Rb6wmD/XPQjrfXt0SYPw4iTmddvtxNTLJw9HhtEpCf9aj4dro6dM4jxmNyaQhwfXlww5OjW6gSpYHvsb9PoB5hgWw2uy0y3CbCx+tjQYSJEexDjZZMZdWBvkz3/Yh1Fs83nRpSL//gGCSHhHo8bV1FdRaI=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=+Pm/31Jpbf+4i/zgHSeTmquj68bZ4VqT8ii7dXRKmv0=;
	h=date:mime-version:subject:message-id:from;

ov5640_probe() can jump to entity_cleanup when regulator setup fails,
before sensor->lock is initialized. The cleanup path unconditionally
destroys the mutex, so this error path passes an uninitialized mutex to
mutex_destroy().

Initialize the mutex after media_entity_pads_init() succeeds and before
ov5640_get_regulators(). This keeps earlier direct-return paths outside the
mutex lifetime while ensuring that every path reaching mutex_destroy() has
initialized the mutex.

Fixes: 19a81c1426c1 ("[media] add Omnivision OV5640 sensor driver")
Cc: stable@vger.kernel.org

Found by PatchProof Module 4 candidates
PILOT-4c6b03072e508260 and PILOT-4f9a36d855eb7c54.

No runtime reproducer was available; the failure path was verified by
inspection and the affected object was built successfully.

Tested-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Assisted-by: LLM Codex
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/media/i2c/ov5640.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
index 8deb5f550..36c8bb345 100644
--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -3930,12 +3930,12 @@ static int ov5640_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	mutex_init(&sensor->lock);
+
 	ret = ov5640_get_regulators(sensor);
 	if (ret)
 		goto entity_cleanup;
 
-	mutex_init(&sensor->lock);
-
 	ret = ov5640_init_controls(sensor);
 	if (ret)
 		goto entity_cleanup;
-- 
2.34.1

