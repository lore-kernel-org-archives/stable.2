Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61BA38736C
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 17:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791309406; cv=none; b=p/bMUXWpItK1aaAuDUKpLiFQz5SVrPywEe7XR5P+cKT2V5HsDIUpj6EHl16CKZpAeXDwcNarqtMBuWKUoxeJ+bDJLIkaYUxoOEYnadkVJ9Rv9Zcf1gK/2zqxk9qO61Tpq+9tKZxkjnYLK1ZSIvsWkaGrOWrhQfkByWIXsrLIG54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791309406; c=relaxed/simple;
	bh=Et0Q1JJyT1n6UcJ7Mf9CBkslr5f8QiOBbq5b8zKRyUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PUKn5+UG98avp6ygaA7bLgdac1xUBjE9mhnkfTOyqx3rD0kDNHXALJJ5HOZtcdq3LjyNlGkCZKYrK730k63tfI4VuOMWVyRF+OGi1LFL+sBDTyxzXk1LGZKlwmEbK7Za3LIT1jcwwJxwetp4q71qw5eAEG+QsIHAMtwQ/SzkfEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1zpEYyY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1zpEYyY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACC11F0089C;
	Tue,  6 Oct 2026 17:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791309404;
	bh=7cdgVV8xDPZwTZKn9KAcmAHiwxFSkaqLry99ru/ZArA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i1zpEYyY2ePViSfkkHwR8sSktOa50gtzEaD8p+ezoLbZXFiNxeUPsAB0DJR0pO5mJ
	 z1YN/vlSndhmY5DXwW5dgRKtc9TYG4XA5JgSCrPivtmdpYO/CseCPgz7CQ0NlwNL15
	 ldz58qXJ2lcMj2tdfkZI1siTRkTJsccTrtIaYo+Yc6Lru8KFFgLyE5tIvlqBAydM5i
	 /lxpQsTNMLOH2GpLlct0psJNbmjhR9woq5DEp3DiuTXQrhe6GnipaD95ceJNNcZ6Pu
	 InT2QgVvER/yK6SGQ/rO30pPeNZhT+ybYA5Pfco1+YnAPMYSZtZXmbp2/O/DAoAMdX
	 nt4BXWRr4BZWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Han Xu <han.xu@nxp.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mtd: spinand: Enable QE on all dies
Date: Tue,  6 Oct 2026 13:56:41 -0400
Message-ID: <20261006175527.883522-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100506-silly-oboe-eb47@gregkh>
References: <2026100506-silly-oboe-eb47@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Han Xu <han.xu@nxp.com>

[ Upstream commit 63d6cace2c4a7f36c1cb44f1bb5e0f3ef19e5c7f ]

The QUAD ENABLE (QE) bit is stored in a per-die configuration
register on some SPI-NAND devices. When a device contains multiple
dies, updating the QE bit only on the currently selected die can
leave the remaining dies operating in non-quad mode.
 
Iterate over all targets and update the QE setting on each die
during initialization to ensure consistent quad I/O operation
across the entire device.

Tested on ISSI IS38SMW04G8B.

Fixes: 7529df465248 ("mtd: nand: Add core infrastructure to support SPI NANDs")
Cc: stable@vger.kernel.org
Signed-off-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
[ sashal: Adapted to spinand_init_quad_enable() computing enable internally instead of accepting it as an argument. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/spi/core.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 04965f21c995f..f0aec31e5ab74 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -179,7 +179,10 @@ static int spinand_init_cfg_cache(struct spinand_device *spinand)
 
 static int spinand_init_quad_enable(struct spinand_device *spinand)
 {
+	struct nand_device *nand = spinand_to_nand(spinand);
+	unsigned int target;
 	bool enable = false;
+	int ret;
 
 	if (!(spinand->flags & SPINAND_HAS_QE_BIT))
 		return 0;
@@ -189,8 +192,22 @@ static int spinand_init_quad_enable(struct spinand_device *spinand)
 	    spinand->op_templates.update_cache->data.buswidth == 4)
 		enable = true;
 
-	return spinand_upd_cfg(spinand, CFG_QUAD_ENABLE,
-			       enable ? CFG_QUAD_ENABLE : 0);
+	/*
+	 * QE is a per-die setting on some devices. Program each target
+	 * individually when enabling or disabling quad I/O mode.
+	 */
+	for (target = 0; target < nand->memorg.ntargets; target++) {
+		ret = spinand_select_target(spinand, target);
+		if (ret)
+			return ret;
+
+		ret = spinand_upd_cfg(spinand, CFG_QUAD_ENABLE,
+				      enable ? CFG_QUAD_ENABLE : 0);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static int spinand_ecc_enable(struct spinand_device *spinand,
-- 
2.53.0

