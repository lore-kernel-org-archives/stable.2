Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756D44D8DA1;
	Thu,  3 Sep 2026 15:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448904; cv=none; b=Ur97aV5I/LDnMzZ3w786WnyEks1zbb3AnX6lmMVeeB07RqyAes3eSARXsdX9HvMGvg1JHneSX/VqA8vI+Ukbh9qaSTrYR2Hz3C1cCd/mV1ix/yjkvjg5RRFKsfd5qZX/SfFUNETQDFeDgntg1HNvWcnkWiNkXxHWt7dwg1NjEbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448904; c=relaxed/simple;
	bh=vykZ2grde6xxUCKjF8SZuF7N5SRlRgYnRvKt4HsKLN0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EyaHJkCouTE/7719XG03IW/b8lKlaksSjKwWkuZsjfgLCg2nq2GmW8g1sgGLmJkVp4ExzCmWO+qen6T+QRYtzYfj1MST5TD5TM1wrpZBua8Ak2o9QRqY7r0bBbBlUIaSjnC6YFl8BjOzHJG+VSxrKw+fkuSW4F7CRjSKiFkbEoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uR0Ohz4B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uR0Ohz4B"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F855C2BCFA;
	Thu,  3 Sep 2026 15:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788448904;
	bh=vykZ2grde6xxUCKjF8SZuF7N5SRlRgYnRvKt4HsKLN0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uR0Ohz4Bqj5gM/vmnVSBA4WfenWQQUCXdbDOunzHk4VNUDdQtxDFeTcgHBVVilaKt
	 KL9drltpaPGQxuoLhnH9yQYtFcTab05y9sj2OvmXkf0hiDDSee4/aSVAZzCgOQU2Ns
	 F2elx9hrMqS4zN4QUWnCNPg8+vxrxJ0u4IR7T4ebuNJp9XNkPpLkTsjyttr29Z/Mkp
	 mk7u4ODc+1Vp3wKMajs6oRgTMnNbgaHbuj98KWQAQofz09f+frViw52XIt8+qTgNMt
	 lcx3PdR13DriT37e86pE6GC959Wkg4xlPjSre+stbbtqas0Jl8baS6Kq8NQQFjBtDc
	 8hKOoJcVdptIw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AEBC624D6;
	Thu,  3 Sep 2026 15:21:43 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Thu, 03 Sep 2026 17:21:42 +0200
Subject: [PATCH v3 1/2] mfd: wcd934x: Fix NULL pointer dereference on IRQ
 probe deferral
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-wcd-dma-v3-1-d3920c6563c4@ixit.cz>
References: <20260903-wcd-dma-v3-0-d3920c6563c4@ixit.cz>
In-Reply-To: <20260903-wcd-dma-v3-0-d3920c6563c4@ixit.cz>
To: Lee Jones <lee@kernel.org>, Thomas Tai <thomas.tai@oracle.com>, 
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: mfd@lists.linux.dev, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>, 
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1653; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=VU4vkCCqWQAD3UTvE2YpWnadOlQKw+33pNCRUeftoV0=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqmZCGhwMASsnSM+8t5MAsRgjVHLop/57TOI64h
 WI1V4q6fAaJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCapmQhgAKCRBgAj/E00kg
 coPnEAC1Px2HkZLmtRmIHu9hIipFEDgWLidgYxi1KZr576tJQGtw/9aEaKWPkCPlKy0D3AWKKOq
 sNUlIyEVWwO/4EHjAHv+7qyodwjoRNB64Uf02m7ROxJO4ocV7GsagVe56yt6v1LhoBD9bQkEmPl
 52N87NlJIO0yhaxdLnAFq9XYnRNXEnpSn8n3EAU0M4POaf8j2TqonGq0nGAMfLVJ1CPsGdBTaQt
 oVftq8QvEDQFRYEMxLQue6ZKvu8Xs/oj7oza9HUex9DdbVwvXnUx/W9QQtd/Xq5Oe5slG/iPU71
 ctWo3S5eFv4vkaLPgeDjsJt585iwxkgoeJhWSk0NALwFhBiGTHUxiE9clFMWVZcsqXE/IH0tJzQ
 fOmO6eGVCvQlP7ojqeX1slIRgzuUsmjiCaqOOAWZp0ojKnL8eQLZT/OqMvvIzQ69u0xdoSDrr7x
 6eI/KL/gPQgJ5v+z3UEwDuXOCnUQp40tnCW/0UYV7w+DrEamiuHZWmSzjEyKEjzn6DaozHWoH9C
 NPYT6R7LXgSmTVRIloXlp7CfKy2TXSkmViZEr8tKe/9cJZcEOlRIhgEtJwJLPOQaY5CAxCPPw/S
 FfgECH26z6JU8+aCCZZGVbnM+fNTgezxcLQpIid8eAnwjEfn8AZhEiODrwKgxmZ0g9ULx3n9grN
 ovw1ocL3n3xkvlw==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

ddata->dev is only assigned at the end of wcd934x_slim_probe(), but the
of_irq_get() error path has passed it to the error print since the
driver was added, while it is still NULL.

This used to be harmless with dev_err(), which copes with a NULL device
and was skipped on -EPROBE_DEFER. Since the switch to dev_err_probe(), a
deferred IRQ reaches device_set_deferred_probe_reason() ->
dev_driver_string(), which dereferences the NULL pointer and crashes
during probe. Use dev, which is already valid at this point.

Cc: stable@vger.kernel.org
Fixes: 0f1b1b899521 ("mfd: wcd934x: Simplify with dev_err_probe()")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/mfd/20260903145651.AC1311F00ACA@smtp.kernel.org/
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/mfd/wcd934x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/wcd934x.c b/drivers/mfd/wcd934x.c
index 3c3080e8c8cf7..3a939e7ad3da5 100644
--- a/drivers/mfd/wcd934x.c
+++ b/drivers/mfd/wcd934x.c
@@ -218,17 +218,17 @@ static int wcd934x_slim_probe(struct slim_device *sdev)
 	int ret;
 
 	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
 	if (!ddata)
 		return	-ENOMEM;
 
 	ddata->irq = of_irq_get(np, 0);
 	if (ddata->irq < 0)
-		return dev_err_probe(ddata->dev, ddata->irq,
+		return dev_err_probe(dev, ddata->irq,
 				     "Failed to get IRQ\n");
 
 	ddata->extclk = devm_clk_get(dev, "extclk");
 	if (IS_ERR(ddata->extclk))
 		return dev_err_probe(dev, PTR_ERR(ddata->extclk),
 				     "Failed to get extclk");
 
 	ddata->supplies[0].supply = "vdd-buck";

-- 
2.55.0


