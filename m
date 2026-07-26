Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4A937999D
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 12:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785068816; cv=none; b=PpM61LDFL/SaRdWigEWK0S1rQtKNi15T7xOkBYTQ9PmUIFFPNkHNnbVQsyNXL/RnHVPNVscGNvZb84YElk8lNHFhOWq+tfvm9NB4ksnimgRMGTpbxEnIs3C7IlbvJ4hYyBG1HreaUCXrESW0OCVM9Pl0+3cd/YzJgnylUqQcoMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785068816; c=relaxed/simple;
	bh=xcoYnNBfNEepL3+Pua0QFjWqzOF7q0vbGAcbAYpewCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tCQ7bXER4mJYYMxJZ3jyubwgDPtk+r6mNg4tBMltS+PWCJ7eL4HxqnecBaB4YsYGAp5oMunuTm/okheAcHifu8ncNNF2S3ygWAP3wAxY8p44K0+8z4WsJFkrQHbJAoJTnAlo57n9wWclRKcKsfNDrITxmxN8cuuIrQT1QFEDuo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvDnizUK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvDnizUK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057491F00A3A;
	Sun, 26 Jul 2026 12:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785068815;
	bh=fgRwhFORfAJArvgaGGgyNQaRRT25TIme9WieMA7+96U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AvDnizUKUuE9Fkaj0RQHjQnhLLGHXyVAyaZ/wy/Uz54BkKZFKj47+W+jAPh3004/U
	 6eRU7ZQ5NDj0v38tJ87uMk5Q5Yupk2HmFKtMTzVzRwuaYJvq+MtN34HVxodClDNF2X
	 ZGMQIOEgeDHO5/DzYZysUPPoEZQ9ODZQiF9dLlmBg+O+ygVk0U+YYEoDQM1EUV9xb7
	 DmfKCloRsYoMeRHq/TSZO4MTrDVm5NEX/V1wWYWFj4GewKNaOkLRUHmn+Fclibl8dJ
	 Hwb0v4X1O6Mva5XkdMbQmLYycihAuZC6zaDmT4L0JXrHDhM1a6eZiIlrxUE6QXVMN9
	 amLx4+r0RNPiA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	stable@kernel.org,
	Michael Walle <mwalle@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] mtd: spi-nor: swp: Improve locking user experience
Date: Sun, 26 Jul 2026 08:26:52 -0400
Message-ID: <20260726122652.4191470-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726122652.4191470-1-sashal@kernel.org>
References: <2026072003-rocking-alkaline-274e@gregkh>
 <20260726122652.4191470-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miquel Raynal <miquel.raynal@bootlin.com>

[ Upstream commit e1d456b26bf23e30db305a6184e8abd9ab68bbf2 ]

In the case of the first block being locked (or the few first blocks),
if the user want to fully unlock the device it has two possibilities:
- either it asks to unlock the entire device, and this works;
- or it asks to unlock just the block(s) that are currently locked,
  which fails.

It fails because the conditions "can_be_top" and "can_be_bottom" are
true. Indeed, in this case, we unlock everything, so the TB bit does not
matter. However in the current implementation, use_top would be true (as
this is the favourite option) and lock_len, which in practice should be
reduced down to 0, is set to "nor->params->size - (ofs + len)" which is
a positive number. This is wrong.

An easy way is to simply add an extra condition. In the unlock() path,
if we can achieve the same result from both sides, it means we unlock
everything and lock_len must simply be 0. A comment is added to clarify
that logic.

Fixes: 3dd8012a8eeb ("mtd: spi-nor: add TB (Top/Bottom) protect support")
Cc: stable@kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Michael Walle <mwalle@kernel.org>
Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/spi-nor/swp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/swp.c b/drivers/mtd/spi-nor/swp.c
index c4e296523dd64d..2fdc23edd73a6f 100644
--- a/drivers/mtd/spi-nor/swp.c
+++ b/drivers/mtd/spi-nor/swp.c
@@ -272,8 +272,15 @@ static int spi_nor_sr_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 	/* Prefer top, if both are valid */
 	use_top = can_be_top;
 
-	/* lock_len: length of region that should remain locked */
-	if (use_top)
+	/*
+	 * lock_len: length of region that should remain locked.
+	 *
+	 * When can_be_top and can_be_bottom booleans are true, both adjacent
+	 * regions are unlocked, thus the entire flash can be unlocked.
+	 */
+	if (can_be_top && can_be_bottom)
+		lock_len = 0;
+	else if (use_top)
 		lock_len = nor->params->size - (ofs + len);
 	else
 		lock_len = ofs;
-- 
2.53.0

