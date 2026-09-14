Received: from mail-oo2-f40.google.com (mail-oo2-f40.google.com [74.125.231.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECC7415F06
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 21:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789420209; cv=none; b=hsjmbv0R9J/E6y+iDRwbv3mB7HRyJg0TBH15eDSioxLU1hHmTsbFAbkzr8OPFWtEqqwP0KPOvntIyDPRUfTNN/LVOgePNptYzld1m3sHAwNAcsfDF9OKOF1thUecX4ZeTtrEj81KpyVbgYPu7f9649XLf300pRKpF++wcVK+EmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789420209; c=relaxed/simple;
	bh=+EYozN7O+JBkDeCx/hgJ+s4q3FbwEjbXAk835pOjKgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pjz5CvoRQiKABZlg9l95P7I82w166Owu0wCJ1Ek1vq4MfyUm8HYIaRL6nseB5+pCs1u4JcagORGf196QcYglI6bRunnOxRa+QPE15dyfohmZF1Q6Z/SYnr+qWO5iP5DCa+7LVlBudTPi4bmoeX1Ay5AQeo87qBmJS7EU7rxty4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7vsc+j0; arc=none smtp.client-ip=74.125.231.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7vsc+j0"
Received: by mail-oo2-f40.google.com with SMTP id 46e09a7af769-7f4f0d05c12so1827737a34.0
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 14:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789420202; x=1790025002; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5tiLR7FZzQsyTOBW2MGeS5ZnHrzID+Jy7EEHyMHP5gI=;
        b=i7vsc+j0MDzwuy9p8HQ+0B6fX7YeN/OFLSqJ0wix6aKQhWXH7HfuJLbURyJ8YgAGrd
         qeDei1149SAby/vSYf18AEnUaKfPQti759XTfUMCyKH9IO/qpjnhjiu0arn7ravO+7Yq
         +DHCbpphQg5V5X968xFadqFfKcmx9AWWnXERirILenvHCfExLXJo+HRBQk4BcgRRxBnp
         WVvwDPyjJmjN59nC+Cl+UZn7pExjeZVQJP6h3yEAGf+7GoPFuZ/dem9mKTYq619ghJAx
         DoyoJoBNq5UyPANXN7VskMoQywwqhiBntzftlzs2hu0JOTAmzS9EUiYZgeS9jQAv8+sD
         xXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789420202; x=1790025002;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5tiLR7FZzQsyTOBW2MGeS5ZnHrzID+Jy7EEHyMHP5gI=;
        b=sUInu/LbJmJ11ehCFZ8YsE1Y0EDkV4OvO/Y6+cZdN1Znb/p5ZdgJJGSBEtaIJEZa/g
         QPsL/nxvwgwaHYbGvX0vKFNMijW55oNM7wLkh74I2Jy5ETg5cZM3t1nCHgpqz+8Air4c
         1IMdKb48KVlgVIWykVZ/Irdr9rFdf3miu3lQM/NG0FRnTQ9mFhm02DJNutkt7fenp364
         UjOKmgL4EqxqL6lUZTpI+XrG/AcAG95qc0ZP6uSZWidp7H9bMgVJTAG80+iW9cA0OGJT
         FTaufsbAvFpabTZSd1j4iH7eit5QkMoJr1/IVE3ClWliL/WAEBg1t+pQdfagXWPwUumH
         pbdg==
X-Forwarded-Encrypted: i=1; AKwUvBwQkoFnmhW9m1aRDiO1kbdod3gw3STx/HjcUh5dVhgV/ns4YvJxgmmaTWF9Wlp/X9pdBVVb4Fo=@vger.kernel.org
X-Gm-Message-State: AFuF++kWbqtx4UN3q7hhyEMHxWEgXvoCwm2eEmJgapj+02l6EkSY3gwQ
	gKTekTUYJF6/Un24syDSCEx5ONqDVHjFqA1GKbtP+x80q8oG9D9TWdT+
X-Gm-Gg: AYBFou25tdcOakVX/zEUGNU2Hzf6P7/URh2v70l2wZVPm2Urhc2ryLDUiAajbJIkHOd
	E4KwS2gpNF4IDpXC/fOLGE5UqBkNrjcP/J8R2hPlajNHGesqYPsvUMnNSUZyAE3aQ6wFmUvNQv+
	tAqQqCXpj7SlVXOKg3P0TMdbBIVkjmgREd6IUG8xiJ3qZ57/yw9iTC7TM/W6SwVRaRaNbXY1zVc
	jrG4ihabPuGhxZO21NWcYUVNKn06mLs1VvAWXsVHmoPkVrXRAxbh5cCOqUsrtA1YRnrGhAa8c5M
	aG+YHijAgo4GLTCIKcTXe2grAgJ/kAKCM0JfucTM8k5PSdev/j0TZtvnNEuMcE1qZF95cJ/+Ipl
	+zzPpBIBQE3dth8h7x+NIRuMpLe5fXn152R3Tni3cf7EXW1ksPAEvTkSuOcEUqHMDzVjsKotBL5
	6LRkCrpSlOlJffbd7ch46zrrDhrnV0gOzGZMzbn0LKJxsC1jECgOrgnTbuxLgQ/+XttjalU2KeQ
	qp0B/6R1nnu6L8huIPl4iqvOPpScU56iP7DL2z6yQVZXTnrcmJlc8atkiyulKIR4/pgT/P71pUL
	QrYFY8jQhpKCrDNyYoEAjQbDTTF7ijThbbX/G5yeXo/yh1FR3gz5uSLLu3gYkyNZdENOncCA6IK
	1wKh7AFUEd5rjQRFolPpTuZGhjJ33ZQ==
X-Received: by 2002:a05:6820:80c7:b0:6b1:b33a:db69 with SMTP id 006d021491bc7-6c53fb6bf40mr4489299eaf.15.1789420202250;
        Mon, 14 Sep 2026 14:10:02 -0700 (PDT)
Received: from [127.0.1.1] (184-96-157-145.hlrn.qwest.net. [184.96.157.145])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c45bfc3fe9sm4698544eaf.15.2026.09.14.14.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 14:10:01 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 14 Sep 2026 15:09:51 -0600
Subject: [PATCH v6 05/18] mtd: rawnand: sunxi: select the pattern ID for
 the current ECC step
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-submit-sunxi-nand-vendor-oob-layout-v1-v6-5-2fb084fe0751@gmail.com>
References: <20260914-submit-sunxi-nand-vendor-oob-layout-v1-v6-0-2fb084fe0751@gmail.com>
In-Reply-To: <20260914-submit-sunxi-nand-vendor-oob-layout-v1-v6-0-2fb084fe0751@gmail.com>
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

