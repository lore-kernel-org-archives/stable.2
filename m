Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E313E715E
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 01:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784597297; cv=none; b=mbt7yad7YSz13FbsZY1aWVOzKgGamGgv/Ww86lz5VsgZ+UyJ+xHDlTkxdVLJqZzS2YWD0nAI2Ko+38OsUTPTABN6GmjZ+CCzqFUAeEt9m1rnarEEnDy332cWxOS9oCgq3UqjPDTe2xE+isH48ueDM+D1qNOPKxdU8N525owIfVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784597297; c=relaxed/simple;
	bh=W6afxFif0lv3TGTzwaa2yTNcWFiZX7Oti8qkpWihuDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MUQzVoZsLYMPHS7fNy5JujszdHfcItezyibLq1GGb6U7G/TDH/njKwrXFpTB/aPx4GVcPfzSkskYXR88OicJbbrntzB1sk/yz8+0wrZ/obyNlbDPQCWeLEyWC+wIO/u/RwE15D2a5Oza9UfdXD0VHybs7qqus7S/4zXWWE39MAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElAuYW/s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElAuYW/s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDA01F00A3A;
	Tue, 21 Jul 2026 01:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784597296;
	bh=I2hjHDWRliXGsR1vVFz49KJ0CtC043YUttSpYCD77UI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ElAuYW/sGNXERmO0EgqgUXjXafRjwX5H1zdN73Ckbr1KWgI+7vG1x7m8wxBOvurxp
	 BfhdEw44HErMdc20DR6BVX+fiy7SNivLoegpAIbmm3WSqKaAxx/RJyHyPmEcmNI3ng
	 8msXUQPfzd93ikYdJjUjPlH5ZofntkP6m3CliEOPpQV1cUXKJHwQn/wSyIKzjyMOHu
	 wFKIVYsvkEZvfnNcNAxt8p2Aq/nFfPKgKvBIxFQkdBLUC/bWvDoeayFnF64aqGYFKE
	 sLTcoKCurVma82ls7jtwYN9xTdTvNwm0J8gS9TQSsf01kYEMqeBLdTkxuMeq4nfXx1
	 /URgvcEohBplg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] regulator: scmi: Simplify with scoped for each OF child loop
Date: Mon, 20 Jul 2026 21:28:13 -0400
Message-ID: <20260721012814.3459151-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071525-sudoku-chapter-20d7@gregkh>
References: <2026071525-sudoku-chapter-20d7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 99cf5db9cdd39136fd5dbd10bda833aa0f870452 ]

Use scoped for_each_available_child_of_node_scoped() when iterating over
device nodes to make code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://patch.msgid.link/20240814-cleanup-h-of-node-put-regulator-v1-7-87151088b883@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: fa11039d6cdf ("regulator: scmi: fix of_node refcount leak in scmi_regulator_probe()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/scmi-regulator.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/scmi-regulator.c b/drivers/regulator/scmi-regulator.c
index 7252fa32cf0546..78f62f88a39c1c 100644
--- a/drivers/regulator/scmi-regulator.c
+++ b/drivers/regulator/scmi-regulator.c
@@ -298,7 +298,7 @@ static int process_scmi_regulator_of_node(struct scmi_device *sdev,
 static int scmi_regulator_probe(struct scmi_device *sdev)
 {
 	int d, ret, num_doms;
-	struct device_node *np, *child;
+	struct device_node *np;
 	const struct scmi_handle *handle = sdev->handle;
 	struct scmi_regulator_info *rinfo;
 	struct scmi_protocol_handle *ph;
@@ -346,13 +346,11 @@ static int scmi_regulator_probe(struct scmi_device *sdev)
 	 */
 	of_node_get(handle->dev->of_node);
 	np = of_find_node_by_name(handle->dev->of_node, "regulators");
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		ret = process_scmi_regulator_of_node(sdev, ph, child, rinfo);
 		/* abort on any mem issue */
-		if (ret == -ENOMEM) {
-			of_node_put(child);
+		if (ret == -ENOMEM)
 			return ret;
-		}
 	}
 	of_node_put(np);
 	/*
-- 
2.53.0

