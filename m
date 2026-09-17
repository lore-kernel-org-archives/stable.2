Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32954E3237;
	Thu, 17 Sep 2026 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789658761; cv=none; b=L/3+EbDY1Vwnm2SaYfOPZ45hlW5gdOTwKO3tB/1qe1JhOzph46tEbj3AmkrgEFVeMPk28dVG8leEHlfaZDyUqN0F3BQrV/MiOyOeMhKKFR4p7FxaiXiF2Z8gCVxdQ34Y2aXmZHM3wmnKFfnWfSML/qKblPsL2EASfcLPd/fUcZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789658761; c=relaxed/simple;
	bh=b2tYbP9dEWbJQwP9zqMlozdzKLmVGmupdMg6XCPlg0s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pE1YfL4wTP29de/FQNnUguAUaMd9con5DipOC2tf41ItFlbuD5HdKJRObhEk0PI1WXlCdt6ARiOQHNoiexm1LOv8mO3009PFMWwc8r3JPMWoe//mrX32VoLQ/lXMjby7dUG3jX+JQxLiT9JMdGUrzUFmOKREEOhMoajZVXxJ0MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAAHcz1lBqxqu36DCA--.46214S2;
	Thu, 17 Sep 2026 23:25:25 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: gregkh@linuxfoundation.org
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	srini@kernel.org,
	vkoul@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] slimbus: ngd: Fix runtime PM leak in qcom_slim_ngd_xfer_msg_sync()
Date: Thu, 17 Sep 2026 15:25:25 +0000
Message-Id: <20260917152525.2160238-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAHcz1lBqxqu36DCA--.46214S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtry5GF13tr4UCFWUuFWfZrb_yoWftrcEka
	4fXFn7AFy5CFnrAwnFqrs8ZrZ3ZayDWa48uwsFv343G34jvF15XF4SvrZ8Cr18W3y5tw18
	Jwn8JrWvy397WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfAYjsxI4VWDJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVWxJr0_GcWlOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq62Iq12xI8VA0II8E6IAqYI8I648v4I1lc7Cj
	xVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8GFyrJr
	1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_GcCE3sUvcSsGvfC2KfnxnUUI43ZEXa7IU1mLvtUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwUNA2qr9tgk1AAAsT

The successful transfer path returns 0 without dropping the runtime PM
usage counter taken by pm_runtime_get_sync().  The error paths all jump
to pm_put, which releases the reference, but a completed transfer keeps
it forever.

Fall through to pm_put on success so the reference is always released.

Fixes: 917809e2280bb ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 1ed6be6e85d2..be5640f45d7c 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -937,7 +937,6 @@ static int qcom_slim_ngd_xfer_msg_sync(struct slim_controller *ctrl,
 		ret = -ETIMEDOUT;
 		goto pm_put;
 	}
-	return 0;
 
 pm_put:
 	pm_runtime_put(ctrl->dev);
-- 
2.34.1

