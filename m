Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA70E3909AB
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 17:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791309370; cv=none; b=JMAmaMGqX9xtwoXMsv82PZ3vG9bCTBwIQutp6hKoc2h+NI4V7O2ZTXGJ8MIn4a4J4ADJXvffp5rTdiXqz1R6IUw9EHrrVZ9ST9GFGH0ZuDalPxUktkhxPXpVzBZ715B87IxeWMaemaSOU3IEZijLttLUdZUQlWxEsV0P+frWJZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791309370; c=relaxed/simple;
	bh=BSCMTVPQ6a6tRzPxRXGGg+7ybrqOfOgvd89qPYHe2iA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FmLbMEUej68SUmkLzHAsaKgsbFyp+su7h+wOLf4lz0TrRZJ48HcSGP5Cr+JRLrSDwFhZctxzL23sKsCNeM77L2fkhn8icHNyiIc9UBnC4ZPc+ajKHpSYY2ypp+RJDCpk8KQv2j1dPcmCdToYuhFQO5G8NxSMDgOm3mMpovajgvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=La4nSko2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="La4nSko2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372701F0089B;
	Tue,  6 Oct 2026 17:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791309369;
	bh=WVwxlsJJHYaj422WVq0nQKlrZp6E3cKYb4X46c9WUgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=La4nSko2hMe5N53NtjpTaPlN2opKqWRoxOLtIWamrOAdeFLCCqroDImK70kjSQjGC
	 w2+v47hJjivbK12TYbdpRQrv/E+izyWXFZkxLXX8Lo6GHNZAKyX3DzxeDnnI67Tm4Q
	 u7NH1perQdQRpOAJRomnPeJ9iDlN36kry6sGApTejxHdGRuUTXTSRGGQDQm7xhFuuz
	 r1GXAP+p09vLeTUFXkxWWEgDl3n0BhR6mR0oIYsWFTHkGHB01IgBBwrGNPG6zOmumL
	 q7kel8urAVXEbRuRAeq4ryEXDswxbvtCNu3NeHd2wYEKhRBb8MXVa8m9tL7znQU0R/
	 L4LWe0ucf7mPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mtd: spinand: fix NULL pointer dereference with no ECC engine
Date: Tue,  6 Oct 2026 13:56:05 -0400
Message-ID: <20261006175526.928344-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100521-bargraph-feminize-2166@gregkh>
References: <2026100521-bargraph-feminize-2166@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Nuno Sá <nuno.sa@analog.com>

[ Upstream commit b890e6163761ddb580cc74f43e15f8bbde15647e ]

When "nand-no-ecc-engine" is set in DT, nanddev_get_ecc_engine() takes
the NAND_ECC_ENGINE_TYPE_NONE path and returns success while leaving
nand->ecc.engine NULL. The SPI-NAND code nevertheless dereferences it
unconditionally to test for a pipelined engine, so probing such a
device oopses immediately.

Rather than open-coding the test three times, add a
nand_ecc_is_pipelined() helper to the NAND core that folds the NULL
check into the integration comparison, and use it everywhere. Future
callers then cannot reintroduce the problem.

Fixes: f9d7c7265bcf ("mtd: spinand: Create direct mapping descriptors for ECC operations")
Cc: stable@vger.kernel.org
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
[ sashal: replaced the new nand_ecc_is_pipelined() helper with an inline NULL check in spinand_create_dirmap() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/spi/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 04965f21c995f..9143553bc5704 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -884,7 +884,8 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 
 	spinand->dirmaps[plane].rdesc = desc;
 
-	if (nand->ecc.engine->integration != NAND_ECC_ENGINE_INTEGRATION_PIPELINED) {
+	if (!nand->ecc.engine ||
+	    nand->ecc.engine->integration != NAND_ECC_ENGINE_INTEGRATION_PIPELINED) {
 		spinand->dirmaps[plane].wdesc_ecc = spinand->dirmaps[plane].wdesc;
 		spinand->dirmaps[plane].rdesc_ecc = spinand->dirmaps[plane].rdesc;
 
-- 
2.53.0

