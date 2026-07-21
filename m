Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A43A481FB4
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 11:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784634461; cv=none; b=OmpqlS0yu6oipDPYBYmvT/moQc7qpbpsd8ARAKkz/1hDm8bjPdzCdye6QxhUwACvd7q+gdnBLVKAXNrCrsvtg9OfQzd4kO5L1Zuu3SKqtruX2UTUqaMJe03TbXwRKwmD/pJ4S4CY+lXorEU/iU23u6raJhDQP+/qB1yeWwnuW+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784634461; c=relaxed/simple;
	bh=YAwXnRhfCVGVQQq245GJOsN1ODPd86RUs7XQIdmi3dI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tfNd/21Dix9NlQKih9vUIaePEmp47R4tITsv51kmE+7k8r2G2XZNM8tYE/ZSrXnuSGLH6ENApGXLTdQBcP4cx05xvPEX1NeK+BhhLSvV0szQGCAkUZx1fTUkt5fpygzpdaBoYsgIEQVngxItL7wnBLzf1TdNhXAshA8Gqg9Fmc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RoZ+Kg3T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RoZ+Kg3T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A7D1F00A3A;
	Tue, 21 Jul 2026 11:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784634460;
	bh=vLcAyRrO3i67Spw0hvPYhpUh272b9OI5XcHo+H5v9QU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RoZ+Kg3T3CVkePawR78FM4W5DRVpixTA8oL54IDnXfvkW3+CGzZBQwM6KwuVH+AUw
	 ILMcxE1mzwsn9xjAl4I7YONjWOIbAw5YniRw+CZ1U7CYLd8Xmy+3dQn1UDZoiWHwSW
	 u++vTomfqPK8bT1hRIAuhR48Ctq9o6NcrAYD6b8EB+LnIfg9QhzRhdF/bE/tuMngqN
	 xmIR9yjumEXa3PrHsny3oiFUsEANNkRNMjj8+83RLvBbkzmi0OcJjE2U64T5bZ30NV
	 6IKNVxUOPaq7wEjIqfpfVjHrBt5RkGL3s8IpB1gq1WldWkOTkaPu7fYXlOwLrcN596
	 e9Z8Zb1bsG2GA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] regulator: scmi: fix of_node refcount leak in scmi_regulator_probe()
Date: Tue, 21 Jul 2026 07:47:38 -0400
Message-ID: <20260721114738.3689493-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071525-curtly-mothproof-9d7c@gregkh>
References: <2026071525-curtly-mothproof-9d7c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wentao Liang <vulab@iscas.ac.cn>

[ Upstream commit fa11039d6cdff84584a3ef8cc1f5e1b56e045da2 ]

scmi_regulator_probe() calls of_find_node_by_name() which takes a
reference on the returned device node. On the error path where
process_scmi_regulator_of_node() fails, the function returns without
calling of_node_put() on the child node, leaking the reference.

Add of_node_put(np) on the error path to properly release the
reference.

Cc: stable@vger.kernel.org
Fixes: 0fbeae70ee7c ("regulator: add SCMI driver")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Link: https://patch.msgid.link/20260527104850.872415-1-vulab@iscas.ac.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
[ kept the existing of_node_put(child) since 5.15 still uses the non-scoped for_each_child_of_node() loop, only adding the new of_node_put(np) line ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/scmi-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/scmi-regulator.c b/drivers/regulator/scmi-regulator.c
index 7c0d29c7856bb6..3fdc5130523e3b 100644
--- a/drivers/regulator/scmi-regulator.c
+++ b/drivers/regulator/scmi-regulator.c
@@ -350,6 +350,7 @@ static int scmi_regulator_probe(struct scmi_device *sdev)
 		/* abort on any mem issue */
 		if (ret == -ENOMEM) {
 			of_node_put(child);
+			of_node_put(np);
 			return ret;
 		}
 	}
-- 
2.53.0

