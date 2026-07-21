Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3ED126BF1
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 00:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784594724; cv=none; b=hJ/QTLtHuPzq/HjgscOoXyRW0nZ294fA+9bbCm6qmAr5p529DKQ1kH1Dc00/CJKlO+lUXvayuAATOXkEkFdga/AhbOCiBkEO/cGh/0v/P+q5EV+swJgYAAmHMO4u8jwlk1hObsvXQyjBYMEPORnxNRfTSmOLLwk9cw36eFcF7Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784594724; c=relaxed/simple;
	bh=xu/TcRFkRKp5n0ODiATZ9FujlxTgLO1qwVxGFsRM/Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZ/kaqPZNfkIJtkQpJQST9CLxgm+fpOSQLfKrV1n8UNUzeOJYO3a90mdjSzmNJ6gtjm6AwmA6jfDqL7wYbueFAaBZZmXVtvOVEk19R5jnqUEGP03SuhGoRnY/GLXlf3FDfJSdOcdhhTrx+0Z4e+wiBcxMPIuquPMCwRhWd/pDng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9V7+YSp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9V7+YSp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828411F00A3A;
	Tue, 21 Jul 2026 00:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784594723;
	bh=aWkAA+5ZNJ0Ygq+2OLGV5C58JkmKsM2V9uKBUnMvIaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n9V7+YSpTCAjMCKnc01gRDWNOqzQbuWp8cCE6TF6T9E/L3fIjzbd4moHs3XjZwRBQ
	 yGygxALP/DOApR3kd6fytx7CwXhetLxqdoreSyJPIdLzNg4/g2K6K08qj2hnExj140
	 pnAtq7PWJbOTJsxJ7WGn5n2E83w7Go4/+LPFUYgMOCgz/pmCkxi97D9cX2KReg9YOP
	 jotzj26PXhJfo1Poi6k3R1T0NkyIjuDdKAmVuWroG3UTwD91wereIbNIQ8a/rGtFgP
	 BIG0HZ2y9ymJw1OCHtlOb3usIOGcUhm0xU8W6qxdSi91lqsPHJZNI7aXHexG+D+Olj
	 Ftr+3xQ3j2yLA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] regulator: scmi: fix of_node refcount leak in scmi_regulator_probe()
Date: Mon, 20 Jul 2026 20:45:19 -0400
Message-ID: <20260721004519.3422055-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721004519.3422055-1-sashal@kernel.org>
References: <2026071525-evade-yogurt-25a3@gregkh>
 <20260721004519.3422055-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/scmi-regulator.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/scmi-regulator.c b/drivers/regulator/scmi-regulator.c
index 6d609c42e4793b..c005e65ba0ecbe 100644
--- a/drivers/regulator/scmi-regulator.c
+++ b/drivers/regulator/scmi-regulator.c
@@ -345,8 +345,10 @@ static int scmi_regulator_probe(struct scmi_device *sdev)
 	for_each_child_of_node_scoped(np, child) {
 		ret = process_scmi_regulator_of_node(sdev, ph, child, rinfo);
 		/* abort on any mem issue */
-		if (ret == -ENOMEM)
+		if (ret == -ENOMEM) {
+			of_node_put(np);
 			return ret;
+		}
 	}
 	of_node_put(np);
 	/*
-- 
2.53.0

