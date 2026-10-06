Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA52D3033FD
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303865; cv=none; b=T56IARBmr8kGpXAPpoaZbTDrXQNoN9LXYRshxwfJHFmUkuxQIMYAFfQ3OzDyZCQ3LrWfjwuUizg0JiZiTN3QU8nYtP1kuYRx9IfQE7r/kkTRE0iNmf2cAuq/qfxVGgiVuDbNKMPn4hRxql8z4XavczvpNVb2p21O27RJoipY+jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303865; c=relaxed/simple;
	bh=fcitlg2aKHQ+xsT9YErVNaJ0q6/k2Wjbau7ujxwPCnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TflA0QgbyuZ1mkNm3zhhyBbcfCG4qhWnwiNjcyzBV1XFcqAiLppzzoHGpHm9smlueVKYvz9H9s1WQ9qp3nWMVpGc/qBo7rHnp2ve2LSgkkwiATTuLR0C6ZbnD6VrKtICifQlc09w266tCDhPcWjU5nEB+WJfFnBfx8UvQmTb08c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXPcWXlj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXPcWXlj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB921F0089C;
	Tue,  6 Oct 2026 16:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791303857;
	bh=lYBVorJoVnZsIsZYaVNekne2eqcSWEStHZvS8PVozRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jXPcWXljR/0lamAAWfV1TLQ0dwgQF+a3mEMQOTjKbsWH81Q7lO6529umg28dNKdC/
	 VPZBs5SPfF8KxI7hvixp4EhX1CJy5m3kcwtD2JtqqtFLyRcZn9jPC0NblFetB/J5iu
	 Ho/QQLom8VhyKRx9/cxBx1tf9gVak3twWrgXULlTi4Muo44oQFkSbLCApPj/TeRhCR
	 GzoUX85rL24xhV3T0PfC/WKOVJ+ZyYFYQSO3nuMvErBNeBD4leSsuWr94GMu2gtT9E
	 gSFZpr6HpOMN6ZC0PNsgrOco0bNZ4CsZFlVdzDh81ydmWIZlBp/m1zx5WyH9tbGSC+
	 mjOWbxh1ylT9A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mtd: spinand: fix NULL pointer dereference with no ECC engine
Date: Tue,  6 Oct 2026 12:24:14 -0400
Message-ID: <20261006162347.883005-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100520-luminance-trough-b11b@gregkh>
References: <2026100520-luminance-trough-b11b@gregkh>
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
[ sashal: Replaced the nand_ecc_is_pipelined() helper with an inline NULL guard in spinand_create_dirmap(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/spi/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index a41f2fd47379c..cb10cc573d9ae 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1108,7 +1108,8 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 
 	spinand->dirmaps[plane].rdesc = desc;
 
-	if (nand->ecc.engine->integration != NAND_ECC_ENGINE_INTEGRATION_PIPELINED) {
+	if (!nand->ecc.engine ||
+	    nand->ecc.engine->integration != NAND_ECC_ENGINE_INTEGRATION_PIPELINED) {
 		spinand->dirmaps[plane].wdesc_ecc = spinand->dirmaps[plane].wdesc;
 		spinand->dirmaps[plane].rdesc_ecc = spinand->dirmaps[plane].rdesc;
 
-- 
2.53.0

