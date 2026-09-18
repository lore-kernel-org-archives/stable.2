Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287F43AA1BB;
	Fri, 18 Sep 2026 06:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789712550; cv=none; b=u6OHjohTeMn3wuySo8bHmII84wA0tEn7DoqqzPAh7Co3HqiL6e8DulEYTocn+ZGEDp51f8yCamCljXmLxFX76HJ93cho3ep55UmJwfKOKru7b9oWN8Ev+1IdyR5/VAxnSMiJD+Hv1zfmTl3oZaFikXalz8kiyWeeUYQfvD634Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789712550; c=relaxed/simple;
	bh=+IC0YJIYx+ucaCyhm/5LDSwx8BTFDb0NiEuU93prER0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HqMNgCQ0iuIlRbvJMWGSx1F8S8AqZ2kKMynMGC8ATZbj8hbn8RWULC9tiEuSNze9fhZjNYH2I29w9R64PGN1OC8QydqGvhkPKRw2K5eacgt4ZpTgPDNhEVXgZYBBJ7k0e7D5M1lYywiNn7egJeoY0zSkybVxRs0xIhxNSD2gywM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=dRQwKQcc; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="dRQwKQcc"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e3ed536a;
	Fri, 18 Sep 2026 14:22:16 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Steve Longerbeam <slongerbeam@gmail.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH v2] media: ov5640: Initialize mutex before probe cleanup
Date: Fri, 18 Sep 2026 14:22:09 +0800
Message-Id: <20260918062209.2937067-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260910081608.1264077-1-runyu.xiao@seu.edu.cn>
References: <20260910081608.1264077-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0b32e11a203a1kunmd85d9d8339153c
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTRpLVktOTx5LHU0ZGkpCQ1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=dRQwKQccx9PFtQlClu+haHbUqePnyejFwKsAHqS0jhDDcwmMUSBjXYm2AyY7ibaDLOz8yJ0Yg9ioWR9sszdEt1qPEW5lUgEoSk7II3aDTXrrJxBzYQvTwHTtFmfSqVAMNd162dyLpWL/Hu0xwd/rzsM0Aqta3RdGA7q8cgh+6CA=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=yAMkqGbLlF5Fl7ax4v5q0xfkZjhr2qGa9YXS2R6e8ZM=;
	h=date:mime-version:subject:message-id:from;

ov5640_probe() can jump to entity_cleanup when regulator setup fails,
before sensor->lock is initialized. The cleanup path unconditionally
destroys the mutex, so this error path passes an uninitialized mutex to
mutex_destroy().

Initialize the mutex after media_entity_pads_init() succeeds and before
ov5640_get_regulators(). This keeps earlier direct-return paths outside
the mutex lifetime while ensuring that every path reaching entity_cleanup
has initialized the mutex.

Use devm_mutex_init() so the mutex is destroyed by the device-managed
cleanup path when lock debugging is enabled. Remove the manual
mutex_destroy() calls from probe cleanup and remove.

Fixes: 19a81c1426c1 ("[media] add Omnivision OV5640 sensor driver")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-media/20260910081608.1264077-1-runyu.xiao@seu.edu.cn/
Found by PatchProof Module 4 candidates
PILOT-4c6b03072e508260 and PILOT-4f9a36d855eb7c54.

No runtime reproducer was available; the failure path was verified by
inspection and the affected object was built successfully.

Tested-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Assisted-by: LLM Codex
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
v2:
- Use devm_mutex_init() and remove manual mutex destruction as requested
  by the reviewer.

 drivers/media/i2c/ov5640.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
index 8deb5f550..7f3af6a59 100644
--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -3930,11 +3930,13 @@ static int ov5640_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	ret = ov5640_get_regulators(sensor);
+	ret = devm_mutex_init(dev, &sensor->lock);
 	if (ret)
 		goto entity_cleanup;
 
-	mutex_init(&sensor->lock);
+	ret = ov5640_get_regulators(sensor);
+	if (ret)
+		goto entity_cleanup;
 
 	ret = ov5640_init_controls(sensor);
 	if (ret)
@@ -3972,7 +3974,6 @@ static int ov5640_probe(struct i2c_client *client)
 	v4l2_ctrl_handler_free(&sensor->ctrls.handler);
 entity_cleanup:
 	media_entity_cleanup(&sensor->sd.entity);
-	mutex_destroy(&sensor->lock);
 	return ret;
 }
 
@@ -3990,7 +3991,6 @@ static void ov5640_remove(struct i2c_client *client)
 	v4l2_async_unregister_subdev(&sensor->sd);
 	media_entity_cleanup(&sensor->sd.entity);
 	v4l2_ctrl_handler_free(&sensor->ctrls.handler);
-	mutex_destroy(&sensor->lock);
 }
 
 static const struct dev_pm_ops ov5640_pm_ops = {
-- 
2.34.1
