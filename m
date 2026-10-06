Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F883D411D
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 21:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322344; cv=none; b=C1Od7O/NwdubMyWbNKOnWhzYGKhjouKUXaxDYhOCpFuz8DLU01pXLEP4s8kUHMfWhFxvjmHQ6KqnWFcTSxQTb/jM8dUhT0Qr9BCXsi//xiAU+6JuZ9TkskBnVgk+FBxcNxwZ3SYa6x8DYWNLKVYa0XxhNy49VlHhqSP1HlU+hRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322344; c=relaxed/simple;
	bh=d4Ksk7MBD9CMt8hTYt1IJdL6QKEzxLhqS/t26VeRW/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XGUhjBbitfA78nWrqm4y+wRf8HNShDMxDm7LL21hcYDVO5pAHGuz8enRbQqkpEPybOlkndqLaUFpNEVjEQJHQmu9C7SwIURDVfhADBnnP3/fLdm3/PwZGKkrWHtnio52f9cxiy5Gsb6i0FSO0uapB8QrJUb08XEZHkZGrcUGA1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IszuU346; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IszuU346"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF84A1F0089B;
	Tue,  6 Oct 2026 21:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791322342;
	bh=doKssk5DVmFySqRKa5d3SwesVSRMo09bWKfysPqiAwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IszuU346U8/trBQ295DRwTgoRDvaVvWT7/tWyGLhn0nNeuoMnKKOYpd+cOePwiPiX
	 s4LUPcth4R4UO3QGT66fwLcWM7MQrdPk6YUvOwArQ52Jv8WV3WbVXN+zPae7j6NY+J
	 YiM8j4+a4xzh73Uza2rjoHtTmS7tc3ygX3yWcGkN3iFslDKTXSOMU+TI904tJM0ByN
	 lg2fmdTlp90QTAqpadIgO3H+PcXhJT2rKoQso/8Fj1/dqeGKAyBrxVKa4ajo8PPUHo
	 Xp+ImYAJFPSj1uF5YpqsS8VSc2ZqoDtCfJ3InXq3m6DIYRWPW7YlNfC4TfdwUFkjlW
	 ha+GGYc/ZUuKg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mtd: spinand: fix NULL pointer dereference with no ECC engine
Date: Tue,  6 Oct 2026 17:32:18 -0400
Message-ID: <20261006213141.981835-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100521-exes-leotard-b29c@gregkh>
References: <2026100521-exes-leotard-b29c@gregkh>
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
index 39f9826342966..15c54d61cedbd 100644
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

