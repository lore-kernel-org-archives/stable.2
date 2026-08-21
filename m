Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB0743B6DA
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 15:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787325176; cv=none; b=Mu6xa5W777r4A+O/Ji/CS855OiGjb8tJV0u/X4+/d9KNX8ZEplLAg43gpFil3mTWYsDyktgbI5wipuOfxPW7WzFr1zJb3n7qkOIEXaLfmnxudJbOAiIi6tZexrGJZH78HbLv/nuZ38RIfiIFyD/O8Hhq2qG2lHcdvPzdr6c0NyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787325176; c=relaxed/simple;
	bh=fSnUC/Uevm5Vbrih7n+FM4vcyD9bqX8J6oiWP1kp/DY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bmVrqKIlLZp4kysnoWP+J7q/2gh5Aq8NtTeEV9b8KDjzJGbhGiaDP4k7NRlbwBN2gqWcZr9l3YC/IVaGiWoZs6Yd4K73fMeOZ5lCHFwzwYu8JoVI3l4xl0Q2f/S92CsAOGG1xpPsFhg186EBDIloMfBiabtI0iJ35IPlE4Pyk2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IiODAYOF; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiODAYOF"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cee9b74ee1so8633705ad.3
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 08:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787325174; x=1787929974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1HavqBuvOK9+7hkcuCpVB9Cv/dvjoerCr3RPaWhvFOI=;
        b=IiODAYOFsOAuQ+eSZReAYZUaTNXQWZALnaBvKwIDVH30t38bppy74aLAeoNNTKF06n
         DdLU5XcpDM9/YPfN3/Ke1KZNauX3HVCdE1fuiIwbeTQoEtrMz3oTh1u+aGx/R/zSq5RB
         7UgwcXkIQDO+T8cnyOMb6GknloyxQVu9oYsZAWjiqioTlo1lM5QLVdKS9ci+CNNXEeHk
         Ncqex42KIVoilAmso27QhYTStVCgoFvfpGoFY34bRPrmgnq3YZCZzy/1+Je3ajyCkoD2
         6aAAqsKb1d1LOa82TEdidgT4t7vaP0NiDEuFWQTl/y7jN0OgfiLkMxPsPw4yasPpXd1F
         0sYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787325174; x=1787929974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1HavqBuvOK9+7hkcuCpVB9Cv/dvjoerCr3RPaWhvFOI=;
        b=U3BHNI9HT5RNXpzC/LmFf81UmEYYJj9x8gC2gfYquih5YibGDnw0vbShJc0Wb1X81G
         x+a59mqjqQ6lczD4cSA5lAuLcqfE4GR8eUexleV7EkZGS2qc1LyZaEbdI9Ewx4e3gaj4
         /EGuLseTEFNVBBVppOOjB+6mhLPZnfUGAUTwxGUiZGm0+vTzZK8o5jPrD/Oi23SRnv/W
         9t9QHCVLnVb8ZiXfduXLpXO9BdeFdnvTv/6fxiZQD+uPAIMaFRi4tNrk24HM0RK0II39
         H/MtNfRvH7VIFNBisCyBg6DDUxm5ZaTZWqGCPb8K1cGc2YVlGiqUG6unnyNAM26JuW3z
         tBag==
X-Forwarded-Encrypted: i=1; AHgh+RpTDTQmw3EAXNG1he/NPXYpmdAgO4tPkvDoEThut9wHa9J9rkOLgymtUZ7Q0BxBlKOHJsOdBWw=@vger.kernel.org
X-Gm-Message-State: AFuF++lAGf8DKm5BmjiRKM2MXZahcHdpKTxeCxrMq2MIXSUEOTOmMivG
	8I8XRD2BXu6cNZlIM0+ew4ZaJq7kqGPAOXwtTKrXoVDoNvta0yyyO7mPST/34DQb
X-Gm-Gg: AR+sD10MwI77fAWNlgtM5N1cVOaS8d95X4OnAMSNibiVtLlLwgUSJgEl0xd62XfF8R+
	GQJOh8DsGcHbpbCStfer6OBLGuL4qWddJLg83KiXZm31k9w+mNnqufobwVOkmYvo578TnbxQKPv
	5ancGsJEnMcLEqeQk/rdXaRFSHUq9MSqrRmXTiEuxulE6BX037DcMKFMKcC2qiv87ATmWvE/vMj
	GgodLBCncyS4JUNmag9a2AzXFpbqoIrIuPu1q9A4sRsk+P0SZBwrK9gc710rcMSBWahnjIiAVSW
	nKjjtZN//DZehxm9IEJX/bRQ6icSC42jyNIAPOoyulWyHhpqpDhQtzwF36EDwKLu5Ic2NUfS/EM
	ifD3aTlnMb8c8178Jibldz4/FSbnOQYCXYjzl6YEIZb7wLJm9qFTOX0ajF6qiCiw1mB3MddM6XL
	X5NG1TAzSZrTvu5c+bBpFKZPs+a2z8YaFnoi96plAIpVVFtg6qlIBs+D+oCHTjIBDGZj3BrwRFT
	LjUqwpT
X-Received: by 2002:a17:90b:4c0a:b0:38f:de97:b06 with SMTP id 98e67ed59e1d1-395c351386amr12380816a91.5.1787325174270;
        Fri, 21 Aug 2026 08:12:54 -0700 (PDT)
Received: from kernel ([103.219.206.63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c4be666bsm3779132a91.11.2026.08.21.08.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 08:12:53 -0700 (PDT)
From: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
To: clabbe@baylibre.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	jkoolstra@xs4all.nl,
	linux-crypto@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] crypto: amlogic: Fix IRQ handler return value and fallthrough logic
Date: Fri, 21 Aug 2026 20:42:43 +0530
Message-ID: <20260821151243.8125-1-raizudeen.kerneldev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In irqreturn_t_meson_irq_handler(), when an interrupt matches a flow
but the status register is empty, the driver prints an error but
doesn't return. It falls through the loop and incorrectly prints an
`unknown irq` message.

Fix this by returning IRQ_HANDLED immediately after the error print.

Additionally, the handler returns IRQ_HANDLED for genuinely unknown
interrupts. This masks false interrupts and prevents the kernel from
detecting interrupts. Return IRQ_NONE instead for unhandled
interrupts.

Cc: stable@vger.kernel.org
Fixes: 48fe583fe5417 ("crypto: amlogic - Add crypto accelerator for amlogic GXL")
Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
---
 drivers/crypto/amlogic/amlogic-gxl-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/amlogic/amlogic-gxl-core.c
index 6cb33949915f..302b398405e2 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-core.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
@@ -38,11 +38,12 @@ static irqreturn_t meson_irq_handler(int irq, void *data)
 				return IRQ_HANDLED;
 			}
 			dev_err(mc->dev, "%s %d Got irq for flow %d but ctrl is empty\n", __func__, irq, flow);
+			return IRQ_HANDLED; 
 		}
 	}
 
 	dev_err(mc->dev, "%s %d from unknown irq\n", __func__, irq);
-	return IRQ_HANDLED;
+	return IRQ_NONE;
 }
 
 static struct meson_alg_template mc_algs[] = {
-- 
2.53.0

