Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86BD4503E4
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 08:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791363252; cv=none; b=VFhMIkOktKKiHD0zk0uqha4z+9zBlA+vhFHcWmSKRvZEbe4AAFjlzxv7K4zge+gMyqy9/IUG1wRyYUikUGSfG9Du5ft1AXx/kIGTHuKiu5hfmDR0aKgVFNDqLmKaEm3rOwVXiTZFTZWLmRJDKaPTqDUJloPk2HaCyrjMhVs2lXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791363252; c=relaxed/simple;
	bh=WTYQTd8b0Jmj87kdAXkKsiGBXKSzLEiz7EKx4S4Fep8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KJhHFvuCvbUT6unn1qhYORWuR3By1PMub2ntcSaqOLh1SWhG6eV3yprgai+3WsF5FlTfFChQNhsVyhBTiKGKFl3f95w4hAvPUlr3EKrj3vDOZt/lEJIP+u9fk76Zq/lIoQ0hsrsRmUwWQpo4w+7T+7GCL+YroKxqGeWZhRUUgBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evPjllbJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evPjllbJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A471F0089B;
	Wed,  7 Oct 2026 08:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791363251;
	bh=qPlrSa3AuGVDfxwySfUKpWQamc++HZrgM4emyK5N09s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=evPjllbJ8TgpnnB91MzlXKAbqE7WhkTdBFCxh8zIk2yrTKsndNqpO8TnCSDNsYh7r
	 kvMNv+OZJlbVPJuZ1o5LS1pIYLyiD7d/xxP6rW11S6QbDbCs7BDPlahrFBY7FMTCpO
	 2mhPqucFTYd2c9velbx0STQU7SUOtC5wMoJzrWE/E+Ix5LnS/FkR6J4cOInVWYu3rQ
	 qhyVStJfs67yBCNYBhsyAWKtBedYd6XCBFAJ1GC9/K0LcQ/6cLmD37uK4xg4PMDvon
	 aKH3zFGJwIUtYGbSHjgS37Lk6WOcJ6L+ySMqFaA211CDXUxys7ttoalSmHhmzruTyU
	 0k45dvcRobo3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pengpeng Hou <hppiscas@163.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] iio: cdc: ad7150: fix OF matching and publish module aliases
Date: Wed,  7 Oct 2026 04:54:07 -0400
Message-ID: <20261007085342.2003960-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100634-contempt-twister-1ab1@gregkh>
References: <2026100634-contempt-twister-1ab1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
[ sashal: Adjusted context for the OF match-table terminator’s existing {} formatting. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/cdc/ad7150.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/cdc/ad7150.c b/drivers/iio/cdc/ad7150.c
index ebe112b4618b0..023b4fd09b254 100644
--- a/drivers/iio/cdc/ad7150.c
+++ b/drivers/iio/cdc/ad7150.c
@@ -653,11 +653,13 @@ static const struct i2c_device_id ad7150_id[] = {
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

