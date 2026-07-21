Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD381EEE6
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 00:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784594723; cv=none; b=oj4iS4PHokc0yRfL3X+NjlSEMgkvw+woGxNaCXMMvtGLk2C3y5DInktcyJlEIestqNd5/5Qh02dcN2r6ZlABglPEHsBbzPVIRTViKXfcf77CPwKoWKoQ4NKJCPe0rJYXQFsqfm0AYOS64WaCTVJ4e9OEi84pEqzl45pwxiXR8hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784594723; c=relaxed/simple;
	bh=/BxdSj+uY6ZnmiVyfI09r7Dh66s7qUXbwZevKdXRrT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICjUjjBKXfK0uqWbtP+qkSvpKTqOd7IyT6Lze8BSxwz9ioA947EpaBsAeiLgNRReyRUTL5gQkxbb7qdiL5rsBF6pLw3Ed9LWLyguko0t0/tnxydI6DG471o3PYmUrn5K9OGFZJyyc5iE8fVqWWDJqlu9qrZq3zKmuqzRpn4ZX50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbBAFLdY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbBAFLdY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C477A1F000E9;
	Tue, 21 Jul 2026 00:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784594722;
	bh=sTu5wxcFaspn75IW17DUDGfdbOEgg9qJXBE1j84Yazw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WbBAFLdYzfl4fizo92mINl04Vfve88bvUNzpprvdifEiMiVDq4PyFhohTiGY8qPZ6
	 ZXmFTqC3WU0XztOJnNoHuJNZHsxohd3xlYi6DL66G/ctzK32VoUuHnbGWflFp+Af/1
	 J5Hd0kMclMuf+6xR71zOizPFNMkuNMedWbpfCHFZ1M7Jsd/mNOEoRDrGK1qmGmFCI1
	 x4Z1qL33MlH9f+/AONZBxUmwODNNwqrP/mmrQ7UwQnwHQWtk+kBzXYMSPbI/QXPIJh
	 fddALnacLSEohavqrj7mw84q1ZLWGr/MgG514QCZYe+FzC/hzMbeJr0nEZGNqZfZ6i
	 FzYqf/RTc18rw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] regulator: scmi: Simplify with scoped for each OF child loop
Date: Mon, 20 Jul 2026 20:45:18 -0400
Message-ID: <20260721004519.3422055-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071525-evade-yogurt-25a3@gregkh>
References: <2026071525-evade-yogurt-25a3@gregkh>
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
index 432654fbd7a126..6d609c42e4793b 100644
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
@@ -342,13 +342,11 @@ static int scmi_regulator_probe(struct scmi_device *sdev)
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

