Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44D2411FB2
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 08:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791362312; cv=none; b=dv04URKQalHjtb1FqQOXtsEjpX/wDchrHhN19GjHVUoiNj+/94TeLenyFPIHXKub4+gxs88NKn7ZISOp39on2Fj2gixjtAawwfscLUnV2nQ3BHgIT+N1Ac2jd88JGeGFkjvmshXflbiuZpo+x1mX4PIsdKSSuz3DZKDzy8mZmoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791362312; c=relaxed/simple;
	bh=1V7E0jNJbPRyMvDfds6pcAeWStPALQfEqfO+1aJcjZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U7Lf67ZNtehrTad8pR8cTHuEP3DJTsU3QMyjkQNn0ZrBSDQf/URLB0nzCe6zYUINVKhnlCOpX5mHHBSU1EnR8smcif4BvGN+C9SrIl3Eof3ePaS0V5iy26tglokmPkuFQOHUNZ5rvp3m6cuIENnZi6NO241fbHnpezbEr1r+ni4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0xGg6/A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0xGg6/A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211C91F0089B;
	Wed,  7 Oct 2026 08:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791362309;
	bh=i2jySMwM3jCdCLIJZHFWBu8O1dCHtPLaNdLtIsI90oY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R0xGg6/ATYub/52ezOyclmZ5XVAG295LT2PhI+FgUcjRIuOwb4GAC3EsGQB0Xj4y9
	 /hLjGrEPPvzCzl5h6Gpe+RMQ2eE11eBSXdoFpv1KOeG+k+8p34YUo1vjDvoFUDfEkc
	 0IKcEVwTuOkZ3Il4d62C6LhdlAJCSJhIzn25hcJffnjX+TmNce8xHfJRuwoS6SVEhz
	 YNCOkvsAmp7cN4L8qRgz4b6apD/Y6mV3KVfDJ3KxU3UMg8XLHSqHwizjl1J+xMi04J
	 wSMTkks+6anhauy77w9Zij+oeT0qsmla3X9qzkxEAkTGtmMEu/ZVbnltZsTMCyigDv
	 VSl6/CtbVCOSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pengpeng Hou <hppiscas@163.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] iio: cdc: ad7150: fix OF matching and publish module aliases
Date: Wed,  7 Oct 2026 04:38:25 -0400
Message-ID: <20261007083726.1954153-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100633-nursing-grandma-6ae9@gregkh>
References: <2026100633-nursing-grandma-6ae9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pengpeng Hou <hppiscas@163.com>

[ Upstream commit 52da294027f53e7084c18dd4b4f73354a40382f3 ]

The OF match entries use positional initializers, which initialize the
name field rather than compatible. Consequently the advertised AD7150,
AD7151 and AD7156 compatible strings do not describe OF compatible
matches. The table is also not exported for module alias generation.

Use designated compatible initializers and publish the OF table. Keep
the existing I2C ID table and its device-variant selection unchanged.

The issue was found by our static-analysis tool.

Fixes: 89f2d5b080bc ("staging:iio:cdc:ad7150: Add of_match_table")
Assisted-by: LLM
Cc: stable@vger.kernel.org
Signed-off-by: Pengpeng Hou <hppiscas@163.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
[ sashal: Adjusted context to match the existing {} sentinel formatting. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/cdc/ad7150.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/cdc/ad7150.c b/drivers/iio/cdc/ad7150.c
index 4c03b9e834b88..0417dffd350a2 100644
--- a/drivers/iio/cdc/ad7150.c
+++ b/drivers/iio/cdc/ad7150.c
@@ -637,11 +637,13 @@ static const struct i2c_device_id ad7150_id[] = {
 MODULE_DEVICE_TABLE(i2c, ad7150_id);
 
 static const struct of_device_id ad7150_of_match[] = {
-	{ "adi,ad7150" },
-	{ "adi,ad7151" },
-	{ "adi,ad7156" },
+	{ .compatible = "adi,ad7150" },
+	{ .compatible = "adi,ad7151" },
+	{ .compatible = "adi,ad7156" },
 	{}
 };
+MODULE_DEVICE_TABLE(of, ad7150_of_match);
+
 static struct i2c_driver ad7150_driver = {
 	.driver = {
 		.name = "ad7150",
-- 
2.53.0

