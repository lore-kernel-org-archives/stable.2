Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42CC3F0A9E
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791302154; cv=none; b=KYaHRFj8qXrBIXqkc725DA/nH5/imxvfItFJuJSRbQMhLa1Tn517G4t4loIiDW4tAAyKjMw7g8HEgatmIoSBmjv9fvwuTBJPNEPllvdiLuwxnvOvKSYFEVR9stccTNlM9g93K50nWkreQSYHSHoJFV+ltLMpFeY/Yjp2hnFmnfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791302154; c=relaxed/simple;
	bh=v+vDzYwO3BlCWZM8HtHIwUjVTK77LvKEORR85MRnYk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T3aVBVW/ZaEAzlX3u6vXt91bHFFlq4IXfpwtp8CijZqw3AXGElBIPI70BPfVz5n0QiEUMwo3CtfWso9AEI80Gfl6nrwGyuL4X0GnKiM0yxJg0N5JCA5dFGo1GQ1Qixw0ZmitHPsoZGqT+e/Z8BKYuHZSrXdKY4U0UH3F5BxoPvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpsqFOxo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpsqFOxo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E73F1F0089B;
	Tue,  6 Oct 2026 15:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791302153;
	bh=9T/EOmssgJSnUpud0jg8z2j9FhGyr2Rd1L7WXvwZCSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RpsqFOxo/cEyjPlvN5ganeft2ngUlMw1xOvAE7XM09k1qlZJZs8oJgG0PBTtciVXv
	 fuze2uVgxIkTEvyYAMnD8YSZJzOW+S8wNsT0p3DuRpbO4KaFIL4ZkMhzVC0DuOP0bX
	 /lj/6765GgOx3Jpe8/2OQ6X2Rp4WpHDu3Avjsf0Bx3koWVpg5hPt2Dvp1in8oB0o9J
	 KtD3Yc6wZ7ZfN/emrJCr63BecFo28Fw9jo4J+Uc4cEo++f5eEA9A2AhyOoilc78Upc
	 drVXWJMa11mTCFzZE1XeLwSDBPwo+gCKQWShJjmdlUTX6MSCOAKzZpFHneiWq1/9q5
	 BIRo6AVaK/xew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] mtd: spinand: fix NULL pointer dereference with no ECC engine
Date: Tue,  6 Oct 2026 11:55:50 -0400
Message-ID: <20261006155527.763392-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100520-premiere-chaps-49ab@gregkh>
References: <2026100520-premiere-chaps-49ab@gregkh>
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
[ sashal: Replaced upstream helper-based checks with a single inline check in spinand_create_dirmap() for the prebuilt descriptor design. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/spi/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index e80e8c747bb29..d320f6a28bccc 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1186,7 +1186,8 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 
 	spinand->dirmaps[plane].rdesc = desc;
 
-	if (nand->ecc.engine->integration != NAND_ECC_ENGINE_INTEGRATION_PIPELINED) {
+	if (!nand->ecc.engine ||
+	    nand->ecc.engine->integration != NAND_ECC_ENGINE_INTEGRATION_PIPELINED) {
 		spinand->dirmaps[plane].wdesc_ecc = spinand->dirmaps[plane].wdesc;
 		spinand->dirmaps[plane].rdesc_ecc = spinand->dirmaps[plane].rdesc;
 
-- 
2.53.0

