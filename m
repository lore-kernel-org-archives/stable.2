Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795723509;
	b=w6UEO0Qm8UZmNKc61rTGWCECR9JTQwmlGUazz9SXvU+ec9JvqC4Lerw9ykdQ4+SBwyMq
	 Iihat63MYQYgY1GfixdmSktE8pP4E2hTzxo3VBQBfK8cqAai8VMItY30gE9WyAAdXMqXw
	 4H3bqWQQ4+QhT12Xc1YjKwsp2KiI0+j3P8A7qLzlO+PyOT2K+488/FwLPidfO1OQqs1Hs
	 l+9P7b/fqS0rFMc8QSE4iOfZvUB0f5+vhIqS16/oTE4elwPKGEejZWqbliSQds0XOEwLg
	 mvvyVXptEvoKz+mnrrGU1/v/t4BN37XUhaC7H7yTH/KxqaGZpoD8BxrNciT/EiCociA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795723509;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=0RoDpXKihy0m0eE8eaR3PRpGL9mwDqhVFzBp2hDW0qA=;
	b=s5x1i7MJQgxp+hwbHSDZVJAn5Qpbsx8NP0j6d/lNqpsc/wVTCs/NksKh0eAHMIwYgJWT
	 5Jv/gs1SOtQDIi60iIKndEXJI/s2jdF0cTkmkxhNldQMJeiAPPUwETSa7NIH5DD78NZKL
	 zLYBAoTcyfnV3V33t1Y/mnvMKHQeM6U2Sy0W5Xxe8KuFONBRK79A/JdSI8h9Xcr2DgCUj
	 l3TGsq/uIdAZmlusSXoa9BVTtMf1HxYstQOgr4JIblvWyTDtx7nw5srdfI4+cYyC25P7C
	 VxUv1dinQqbrRsqMK1hk2noMMYhWMAnUe/+dzoyUVRaS0AQdE58xeywqz3wvdnxFW7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L6EOr7Nf;
	arc=none smtp.remote-ip=209.85.160.41
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD198606A335
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 20:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD198606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L6EOr7Nf
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-4b0348a4c79so5107938fac.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 12:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795723508; x=1796328308; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0RoDpXKihy0m0eE8eaR3PRpGL9mwDqhVFzBp2hDW0qA=;
        b=L6EOr7Nf+bg+rsFbhJf9o4POLyVIn8fDAk3GtJdVFcJwr75S8PqriS7MLcekZYIYQk
         2FqP8UCw7FWFO45MOukibZln9LGl+2zMYbAs1CQF0aBSju1F3tN/c4r1aP4VOXzXhA8Y
         5nzog3pXW5M0PCrabsbQtbWFsFwqg60K2NsYyyP4Gn3i9MKS1l364ESKwXc3yJmT56Xd
         1E2h8dkKPrAbrisckNM/7M2gpF7gZp2v/zpPeEc6MXWOWicIQTNxm2N430EK6LZrJld0
         kt/udOc4CwS4fyB4RNq7rTE00RK8erx5hNGzJFyJGVKCn6lcoD/hOXO1SJGVc9duYDeG
         4CGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795723508; x=1796328308;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0RoDpXKihy0m0eE8eaR3PRpGL9mwDqhVFzBp2hDW0qA=;
        b=s5zZQDZDbA+1iDol1716/7SJh/glYhq8yf2ic9eYtdONIXJ59CoMdYt1+QEzyQAMa0
         LvIMDxBPJtx5ksfUhADMMLXgscxviGuqT3C1dZHLLJRYC4IAV1HwqKL8kXJoxYx528WA
         Qj4HhfHlHIIpMUjRHNY1h6vO/2jcqdEredJQ3IkULyiYrr7luoiMTiZLA01tHyGRdJnE
         rbDDREagjKyJEsdfNWtcbTEFbcxOyJvNqDdD4uCOLwQgGH4EtFUPpgf5KNgL0xslN2Nu
         ievRI4v2nRQugwkXZbRnyw04wCmUF9gBaDR9yk6iMxpkQKNQNKbVCs1lh/NzhJxGnBfj
         5U0g==
X-Forwarded-Encrypted: i=1; AL+hErGR6C4oCnHz6A3qfI7yS5rV+UVaKkIF+bicvaWAUiPJBze9mrmPVUSAD8Uwt/7Cpa6Xk8FL/pU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+hcdN6H44qYqz/H3uBJGLtLWjc7H+aTfG5H+Ua028l4P2kg2vl
	W0A4aA9pP1t1i1Z2zuT0mMus/NSut1+VCVm5mAWv/oeqcurnzxQBBR+G
X-Gm-Gg: AZFdTZez3ZJ8qK4J8TqNodAqI6O08LBQNiv08bhgZm0UxoPKnIUBr2stZ22tnZS/YVD
	R3ZFYuHa2FSuJFXqnD9diThUsDQKRReUjlEYbBSiu3FaTaCB2YDdKim2wRaMtUXhwUg/L4zqgDT
	vBiN2OlHakgkGh7IN5Fx+V0OE7opas/6otNVQZB1z1/EW9C6FXcw0a6egFRCoSvieb6sDaYINOb
	hS1daA90tGHHG6I7OngHZ0emwQlGUgpGyPJNoV4Oty99YODGNsn8+WdFPVd/pxQipirvA4PIjaP
	uk5KV7m2fWeAPWm4Fmrj0vOKZcXZDiA5B+3ZH0xR/jv0XD2xD0uaK36unune/YAUSRDDXrdlptW
	qMiBTueqGP1r2Uw8Ej4uWFUPPAngYNCf395hPI9s0zYz9jWadmip9HuAT+Y4s2xhaTMC+4CATqs
	jSNoTifDgHH5ECp8wBSijd5eBeKYvs4tudP7ynFiOMbMjJqpu0YB878QmVSFUSvaRvDiOkR7NoX
	acpWtQukI2hpGYng7gVTxlnrssfmevWHDI3nuFcoarFFZM4Rgf2Ju3XpoVLlVNUXTjlTzj7YPV2
	EccM2itOIyS9gB6yWnosRaOV5QQB+hr/CeteLzOsd+qGSa+XVLxbBsCoZQHwPcoN8vpzMR3jHXc
	alYZiu/SZBJJtZxK2emI59HaCOI77qcwMcZPimu3A3sf1OCGGuL5+6MJnNVLkrAM3UyRhpv1aU+
	18kgaWutBhKNXRp0j+FP3vr4HMrVlp1aznzfVJslAoq6fNG0sCfmhO
X-Received: by 2002:a05:6870:b88:b0:4a7:4c99:8d96 with SMTP id 586e51a60fabf-4bc7beaefd6mr20170070fac.2.1795723507852;
        Thu, 26 Nov 2026 12:05:07 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5fc97bb2sm19548249fac.9.2026.11.26.12.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 12:05:07 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 26 Nov 2026 13:04:52 -0700
Subject: [PATCH v3 2/2] mtd: rawnand: serialize bad-block marker writes
 during BBT recovery
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-submit-rawnand-operation-locking-v1-v3-2-cd3794332f23@gmail.com>
References: <20261126-submit-rawnand-operation-locking-v1-v3-0-cd3794332f23@gmail.com>
In-Reply-To: <20261126-submit-rawnand-operation-locking-v1-v3-0-cd3794332f23@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Arseniy Krasnov <AVKrasnov@sberdevices.ru>, 
 Kyle Roeschley <kyle.roeschley@ni.com>, 
 Boris Brezillon <bbrezillon@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev

When erasing or writing a flash-based BBT fails, write_bbt() marks the
failed block bad before trying another reserved block. The erase and
write helpers release the NAND locks before returning, but
mark_bbt_block_bad() calls nand_markbad_bbm() without acquiring them.

A BBT update triggered by a bad-block marking request can therefore
issue the recovery marker commands concurrently with other NAND I/O or
while the chip is suspended. The chip selection and shared page/OOB
buffers are not protected on this path.

Take the chip and controller locks around the recovery marker write,
as nand_block_markbad_lowlevel() already does for normal marker writes.
Expose the raw NAND lock helpers through the internal header for this
cross-file use.

Fixes: 10ffd570f117 ("mtd: nand_bbt: scan for next free bbt block if writing bbt fails")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/internals.h | 2 ++
 drivers/mtd/nand/raw/nand_base.c | 4 ++--
 drivers/mtd/nand/raw/nand_bbt.c  | 2 ++
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/internals.h b/drivers/mtd/nand/raw/internals.h
index b8b29341b88c..2668f527e637 100644
--- a/drivers/mtd/nand/raw/internals.h
+++ b/drivers/mtd/nand/raw/internals.h
@@ -81,6 +81,8 @@ extern const struct nand_manufacturer_ops toshiba_nand_manuf_ops;
 extern const struct mtd_pairing_scheme dist3_pairing_scheme;
 
 /* Core functions */
+void nand_get_device(struct nand_chip *chip);
+void nand_release_device(struct nand_chip *chip);
 const struct nand_manufacturer_desc *nand_get_manufacturer_desc(u8 id);
 int nand_bbm_get_next_page(struct nand_chip *chip, int page);
 int nand_markbad_bbm(struct nand_chip *chip, loff_t ofs);
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 5c877e2536e4..886512cf87bc 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -207,7 +207,7 @@ EXPORT_SYMBOL_GPL(nand_deselect_target);
  *
  * Release chip lock and wake up anyone waiting on the device.
  */
-static void nand_release_device(struct nand_chip *chip)
+void nand_release_device(struct nand_chip *chip)
 {
 	/* Release the controller and the chip */
 	mutex_unlock(&chip->controller->lock);
@@ -336,7 +336,7 @@ static int nand_isbad_bbm(struct nand_chip *chip, loff_t ofs)
  *
  * Lock the device and its controller for exclusive access
  */
-static void nand_get_device(struct nand_chip *chip)
+void nand_get_device(struct nand_chip *chip)
 {
 	/* Wait until the device is resumed. */
 	while (1) {
diff --git a/drivers/mtd/nand/raw/nand_bbt.c b/drivers/mtd/nand/raw/nand_bbt.c
index a18e10284b9f..a56597dfcea0 100644
--- a/drivers/mtd/nand/raw/nand_bbt.c
+++ b/drivers/mtd/nand/raw/nand_bbt.c
@@ -721,10 +721,12 @@ static void mark_bbt_block_bad(struct nand_chip *this,
 	loff_t to;
 	int res;
 
+	nand_get_device(this);
 	bbt_mark_entry(this, block, BBT_BLOCK_WORN);
 
 	to = (loff_t)block << this->bbt_erase_shift;
 	res = nand_markbad_bbm(this, to);
+	nand_release_device(this);
 	if (res)
 		pr_warn("error %d while marking block %d bad\n",
 			res, block);

-- 
2.53.0

