Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E6433F8C1
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 03:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789354909; cv=none; b=bQaJpVPH2CeAvz34JgxI9wdo+914F+OBi9Eg7qiHAzCSz/CnafDzdLTpWayoZAfWEcUELi8dQmv+pQ2Kv0qnQMBnJrYY+xeTl9tx9XwC3lG4npomW21Z//RQ9fju/mC33oomFatZCG532K7V22X4vEQ3Ut+i+7ltgEq92aHEfsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789354909; c=relaxed/simple;
	bh=+EYozN7O+JBkDeCx/hgJ+s4q3FbwEjbXAk835pOjKgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=poKE8MYrW+yhqDCfz4pwov/piSZhSj3QeyYQilUF/SqQdh3asq73KgqqH/0cn/0/G/l65EAgVk2bDUYW4WbS6ao5wI+jZI+yR6q8wyTgmArwrr9DNzHL6GLw/MImmL7bF/jfE+922xySZaO49pcqviBZimFLSTfO32Z7dHyHxN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQaKRqXb; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQaKRqXb"
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-7f4f0d298caso274453a34.0
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 20:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789354904; x=1789959704; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5tiLR7FZzQsyTOBW2MGeS5ZnHrzID+Jy7EEHyMHP5gI=;
        b=nQaKRqXbxKrCQc5ucgj4RBajMhwEyd4ArqWujybyPQ/fOBf9SN8nXpEYDHp/B37Nh1
         bagLBQRdqh60nS4c00hAkfKsBnjyynpSSqEOzh1wLOF9630KkPodJzMnYnRRxQe0lg1E
         /S07zC+83w1TieKGxLd+o1VBrYUCrfhO6ed82VlGNxepGHrgDtU8QcAoHekjJQ/ZE7eO
         ilrBPF9JB6GyhLT5iM2WV/wrfMT9EtBJVVbsKGxH/C4E145OtiDh2beJFQllTrq0/jD4
         nG0GNCvpw3Ou8rFk+sLiq7Nss7H6NT76pdl8BN9LrhHLXz9n6C4fVRI92WuOFK+gPYqT
         VKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789354904; x=1789959704;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5tiLR7FZzQsyTOBW2MGeS5ZnHrzID+Jy7EEHyMHP5gI=;
        b=ce6f+nIKXK3Nxv9idIwZdy8UnjLona4JlIOyaEjWHzLssZJcSnVI+NgUSWJ7mnusb6
         4PI4SEG9H1vR2+vCcvFE4by5Gh18g+qxjNNNR27veAtktYOFxgZUpTfQpNvIFJEdxLje
         FQ0waDE2fQkq7A1C0oc1znwpN4i9DGnWpw1AJ7OJJTG4K5rqgZJsySPMiOHjyrAduX+s
         PIBPda9Xq7jkHNEU2T43x6kJtENXlJvyFWA6KKPBmMGs2MD+6qaupw0S2U3YATS0bHjA
         Gpu0ywt/+D67UJH1qLeI0NnMnZXazVPiZ0LfOfE190qbggWH+BPZgj3Ml3jKVAR59F20
         Nthg==
X-Forwarded-Encrypted: i=1; AKwUvByjzrmUCCTG5QdPrl4ZNAEUPvtyYyYkzrtHdy9LM4EvEsT6UPgoIdg9ynIaAcymDZgOUgyfOJc=@vger.kernel.org
X-Gm-Message-State: AFuF++lZUCDwh/s/LU5szvDZMBnxSceznv5hUG2Ag/SxEe9a2N6OUTbE
	r2K8B8nuMcGn8QReP0JJiifj07RLJBuiCN930NGsbdbwKxKA4hLeuiY8
X-Gm-Gg: AYBFou3md9IJX0JEkFhVjegfM27CUG+kvfynXnij+Zb/S0kBMkk39+RcFtgYD3FbQTa
	4L9qowyB6GZ7IF3bHHBEWHoScII80QO06Vgwh3pC16/R+sEzxCpre8HRORTQXh/mzAzMtdP6U18
	ksFtDmWpEwv2+f2GTkR2Y7d/y7bduUYax6xHS30sxK67JOQm0e1R2SX3SgAwndd8ydwbtRSMIgC
	PePGS1lO72A1NX1Gam4lP0YWL1OS3wY834G8hJAZHug2NiiLJ5jgQ11khNhDqI+HN8KCh+YyJ9a
	XByvt6ii3z62URpo/V4yX4WjnRxIqWkjMZOzZV7uDiQ9TAtv11tLbXyoJgBlE36InD5yLh7tI7A
	gPZG2ARZ7lEXQnzevd5qqbYkTLdB0JnLPc7FyRnc6S6AO2CZLwx/4YFf0An0WlqHLg+u2HyiQRb
	tzp5rGI5JmZ1FQFsVaoOCvMmjFR54y6geCGki34sP7FendF1LK0OSrQ0kqHLy6xivzbW5Wqyg2i
	dtmINK/Hme8RIvyiDdx7wrtDn0TRcvT+01Q3WPvheNkUJZAB6Ol4wk9vq/2iHcyjYyJsQH6iIHb
	3k11OBr+eMc7G/idxxF8hEaOMsTnsQ94U3hEt7JrrNlKMfTUDQcyC1Vzn5fMDztLZPRK1PNR2F4
	pYZTlcCN2s0PaQd1bhG0LuERA29U2HQ==
X-Received: by 2002:a05:6830:67d9:b0:7f4:eb76:8820 with SMTP id 46e09a7af769-80897e81b85mr306525a34.13.1789354904353;
        Sun, 13 Sep 2026 20:01:44 -0700 (PDT)
Received: from [127.0.1.1] (184-96-157-145.hlrn.qwest.net. [184.96.157.145])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f60feba1sm10619014a34.13.2026.09.13.20.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 20:01:43 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 13 Sep 2026 21:01:11 -0600
Subject: [PATCH v5 05/18] mtd: rawnand: sunxi: select the pattern ID for
 the current ECC step
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-submit-sunxi-nand-vendor-oob-layout-v1-v5-5-7d711076a6f7@gmail.com>
References: <20260913-submit-sunxi-nand-vendor-oob-layout-v1-v5-0-7d711076a6f7@gmail.com>
In-Reply-To: <20260913-submit-sunxi-nand-vendor-oob-layout-v1-v5-0-7d711076a6f7@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Masahiro Yamada <yamada.masahiro@socionext.com>, 
 Boris Brezillon <bbrezillon@kernel.org>, 
 Brian Norris <computersforpeace@gmail.com>
Cc: linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2

The pattern ID register has one bit per hardware ECC step, distinguishing
all-zero from all-ones data. The correction helper checks the current
step's pattern-found bit but always reads pattern ID bit zero.

PIO reuses hardware step zero, so this works there. DMA processes several
steps at once: a later all-ones step can be filled with zeros and reported
as a successful read if pattern ID bit zero is clear. Conversely, a later
all-zero step can be treated as erased when bit zero is set.

Use the current hardware step's pattern ID bit, matching the error and
pattern-found bits already checked by the helper.

Fixes: 614049a8d904 ("mtd: nand: sunxi: add support for DMA assisted operations")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 5d88ad3b8f70..3f506d0666a1 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1117,7 +1117,7 @@ static int sunxi_nfc_hw_ecc_correct(struct nand_chip *nand, u8 *data, u8 *oob,
 	if (pattern_found & BIT(step)) {
 		u8 pattern;
 
-		if (unlikely(!(readl(nfc->regs + NFC_REG_PAT_ID(nfc)) & 0x1))) {
+		if (unlikely(!(readl(nfc->regs + NFC_REG_PAT_ID(nfc)) & BIT(step)))) {
 			pattern = 0x0;
 		} else {
 			pattern = 0xff;

-- 
2.53.0

