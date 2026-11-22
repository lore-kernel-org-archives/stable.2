Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795339559;
	b=UQsMzySCAJpKYzazStQ56sNJEt/VHl/hzbZXPrUbWC3Z6BK2biA0Wb1YpPQ7CwEaX+v4
	 5bvfse4fsC8AUk2+ggbagQr9kmTwkzhnUlMHe0kdw4Ia+KNmCvf1LcR5ooXnZxht4IQAr
	 DOJ69gYrsXIkHvHGnGHZl4NEszcJCZNeeihgapwQQjGdsd8sxBvenO6+8jkhye9K3wFxY
	 i2j2Q/UWFFxLOgIND5OO8JoQmqOKTterY2Cwngo/D2Q9SgmpXgp2sBpA3tAQBoCInueig
	 ZFGnzJ2XtfRYvaPZoVy++jIOf5LMLsQNM5wffmq+m8JyiZFByGViaIAL5FzxECvpVsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795339559;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=nG3yzDOrObg/oDwHdoEhmw7sw76zpjbwPxW4S93B/2w=;
	b=SbTddJtCSoiomyEVw6LEU0jOPmAItqxQL8UjL+w+tNxqLTdjQbHECuKDTPIyG7BiSNvI
	 CTmVWqz1jzB8afugIv1roQ/gldJ20+nTNNEjS4uS2kGF+/UKn7mEEXwnQFlJc3yPdWfVo
	 7C+cl5MPF/0TSS5ae7TuNq3ViScmNhRFqraNcOfAsP2MH96mSHLa9WjoSqgUKOwhUlHXW
	 u9COuKJgsy7EfVt3E7pM0ULqwmgrhWKv99qfHTUMvuyb6wTznJ7CKNIcJSL7uyGFmbdqb
	 gPdEzEhQ09d2wNbwXFfU39z4Z6HiJYrTPLmaN0Ccm9GCVvD/g3Vw5VKfzpgZZFBdIow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P6B2U0pZ;
	arc=none smtp.remote-ip=209.85.160.49
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A95606A33D
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 09:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83A95606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P6B2U0pZ
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-46556b9e02cso1822042fac.1
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 01:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795339558; x=1795944358; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nG3yzDOrObg/oDwHdoEhmw7sw76zpjbwPxW4S93B/2w=;
        b=P6B2U0pZnvaBpj7XDjR+kO8khb7+ylTdd7kpNjRjJevrIPRj/lFk+8PWwta4Ug1IMK
         nCzymaXVEHBN1MJ9Te1gbiuvg6v1XxS8R4HaKBoHns8H/nopAwvHWsSXua362qiTpgHx
         MDezoOmEE3sXmn/xctZu1SK3w0V5oO/+YDjDNAjQrpzOE6aSkADSE8PmvyK4eNpu7wT2
         O4knZ9obH5eoVKgxvSHjYSlA7DXvyLkDbxqx7RrEzECbZzNv6uX0WMvz1Jowo6IZrKyN
         FB0FxsiOSEZ3FScD1RdHWmezfkNKdhJa8CCStN5Emcg78QBwDeBl2SPlbfLcXIzFDY15
         kAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795339558; x=1795944358;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nG3yzDOrObg/oDwHdoEhmw7sw76zpjbwPxW4S93B/2w=;
        b=KVWKFowH8xvNgCGRmhjeAPYHcrV+H3Hd6IFDnxGn66EY32KDT4SIX9s7P+ZZsmksDs
         D1rA3aDVqAKOetjlsBr2nRDbN5FAwhyfavL/L22a18dXOZwz2d4muv/D4dBDLn7Xciiy
         Vpfr/sEj3PFdksGK2qV3Esk+/9qKScz5tcY93VT6GxfM/lYpqliE0j+Q357au92a8eKX
         jBId/mWZ8Mh720kLc7xyP/osXVuAJvYEu+dED+f7xujqpLb9plL7uGA3y1W1fk3aK0Rk
         VoV/HNw0B1HohSqka2tThi/VIbkEHBl4TDSxe59hAICSru88CyXbkXUhZ3hgSvgisT5t
         JJ+w==
X-Forwarded-Encrypted: i=1; AL+hErER0cDHSDFc84fh4GpEf4wP13yemalovxGPqXFRDWbZzL/YpQO0VWHhBHfEaN5X59Z+lFZ6R8A=@vger.kernel.org
X-Gm-Message-State: APuU4Z9gQtxTqOzWa+Wd/UDVF4FPFphvwhTBU9wjJSYTg9Tl++9G8fJu
	kFFwq7UqVYtI0y81/C5HHprKQNEg+KBp4ah/+dNRvGEgnzS9vPwI7Pmx
X-Gm-Gg: AZFdTZd1HeYI81i1qo0InT3c7lelYlcr17UY3oH9ZSQYVqCKtYQtBcVpjxs7bHdnLTi
	Cw0NCPHJrn/n5Kd9HDnqX+REewhysGupk8dMa5btzpzGl20AlfIYlgDkZpVGz8P/3HsVpF0zN78
	KD84RzSv8s5nqCcSb82xinHf4O+4j8Lk7NOKCrIciELZW0B1wmsyj1VO0F9PvtaTFDk0uOEA5Ih
	XkhPMuFODpMRUBDFNIHUc+uxh5K9F9/bveeVqlB0r4aBNOMkwIzQ2U5O67iD5+HfhyFovVRpF9/
	JENHvhZLztAS1zc6sNxbw5BE+AIam+cgnvMfMHnGFpYPjS6ggl3xBnatzd75PDJ9A5Vc5i2shVs
	JoXsyesaQqjzSMc9WrNevZfliqQ236uKD9TMGsEBvilf9BJUDJIhdsfFMa4wo9NHI9BlfX2pZzw
	Hqzcxy7H1wXfM2neY4jyhU8vu4l8govgqII/wB9LXEZNt2fd7UWf+b4djnfJ97y6lWO+ABcONkb
	9jbJQjMHJ/QAOFPTkJUWYbnB4NDCMJE5OV0n5/RoJ3LIX+yh0brcEMP9zjE6XnmNrbAG7Hg+yaj
	+jKFldAbhAuenexQY7loeVDPNnR/2npuX/4P/0+QM3c6RcE2TSTW7suJ8M1ilMR1BDQjM27+u0L
	/4cXyKoJVlM9wlQqIzwivaLZchokcehc5yngrWNqTkgnBC7lnGH2KEVWQP7H/Ovm576MAU49NlH
	N83lAPO5B/LotDwiVZTCe/cPrfWTZFRkG51edDbqId2ic32ZJy+mnm
X-Received: by 2002:a05:6870:31ab:b0:4ad:60e2:474b with SMTP id 586e51a60fabf-4bc77f2d42amr5237085fac.0.1795339558408;
        Sun, 22 Nov 2026 01:25:58 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5ebdc0acsm8698476fac.3.2026.11.22.01.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 01:25:57 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 22 Nov 2026 02:25:21 -0700
Subject: [PATCH v2 2/2] mtd: rawnand: serialize bad-block marker writes
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
Message-Id: <20261122-submit-rawnand-operation-locking-v1-v2-2-030bc867f0c7@gmail.com>
References: <20261122-submit-rawnand-operation-locking-v1-v2-0-030bc867f0c7@gmail.com>
In-Reply-To: <20261122-submit-rawnand-operation-locking-v1-v2-0-030bc867f0c7@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Arseniy Krasnov <AVKrasnov@sberdevices.ru>, 
 Boris Brezillon <bbrezillon@kernel.org>, 
 Kyle Roeschley <kyle.roeschley@ni.com>
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

Fixes: 10ffd570f117 ("mtd: nand_bbt: scan for next free bbt block if writing bbt fails")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/nand_bbt.c | 2 ++
 1 file changed, 2 insertions(+)

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

