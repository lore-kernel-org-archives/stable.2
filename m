Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794967678;
	b=Rm6gipIF4o6ExAznNE3H97oDjtk732LaV8mqX1toHIuX2/2zUDEqn5hbpCDHo2+tJJhX
	 nLPda0a3C5l/iHncPmWFfqSvrywPTnm2UkvHS40BnthO+40tdbpfr8IA242j6ejSbuvHj
	 7YjhAL5NMRmQJUN5KPmcK3TITCGbiDF4FZfpvSQmqN9kjyMfgEA3giO75gsIP75TeR85l
	 1HDPAkyOGCG0tHw7e5DDkeCxLVYO2GmDuY5zriJ6nlHSCsBqc/GT/vaxU44AsMsAsZv09
	 68LoLdxnYSDeV1hcbgFYLJLVLReIL9b1ZqCE5qV50rTTgJtUvonsvwIJwDzXb1AVrIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794967678;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4sCen6N7/ej1iTjZeKlmK1FSRs7B5KNsHG5+ndEgEmo=;
	b=yC+u/w1T57BvEO3uOipIec7UsJDBA8EPS6Bi+eAELiUOnNmtbvnj+I42J+9gd87IFaaD
	 gx1Nt9quACwfDm7oN3jP4t5D0sawwmYFbfnbutB71Fx3ZiuCg5jRG9xRqA6DiKTNKKKXO
	 qN100rwYjFnVVO3kZ4hJl5iaggiCOEegAEdGq1U/2igjXRq2sVCQhiOi9mzS3B2gfecTg
	 ilyQzPh8uPSOO0jDgWM198cq53kChGT6Sa+71lGzUq6JcOIgjdUfsrKi+EXe3bP/qWzMe
	 I0c8JgYPeh3hPyG+aQgmZHphpNjfs18YD9cBcbj78qSgBfG0hZQcD5rqiFQRoTwSTpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=oFs0q61Q;
	arc=none smtp.remote-ip=115.124.28.169
Received: from out28-169.mail.aliyun.com (out28-169.mail.aliyun.com [115.124.28.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0619B606A339;
	Wed, 18 Nov 2026 02:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0619B606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=oFs0q61Q
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794967673; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=4sCen6N7/ej1iTjZeKlmK1FSRs7B5KNsHG5+ndEgEmo=;
	b=oFs0q61QcYkaR0CEmCDarxl4xbFqxDY0kj8yih305qRtHIK9K6NRvgB849b4N9tKxNpO9HZncIb4/7MZBYH7A7rYPP/PXs8gdYiark8jvQL74PfwVyCBF7AGB/TnFmKT6XEYc83qVf+zJWDN1YqUX80zpc4iGTZ7rI6LzUl739g=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1074903|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00566328-0.000578767-0.993758;FP=13790843656047517396|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034254;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.k4NZxW7_1794967672;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.k4NZxW7_1794967672 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 18 Nov 2026 10:07:52 +0800
From: Guanglei Zhu <zhugl3@xiaopeng.com>
To: paul@crapouillou.net,
	harveyhuntnexus@gmail.com,
	miquel.raynal@bootlin.com
Cc: richard@nod.at,
	vigneshr@ti.com,
	linux-mips@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	liuwb@xiaopeng.com,
	zhugl3@xiaopeng.com,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] mtd: rawnand: ingenic: validate BCH error index in jz4780_correct()
Date: Wed, 18 Nov 2026 10:07:51 +0800
Message-ID: <20261118020751.1833498-2-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118020751.1833498-1-zhugl3@xiaopeng.com>
References: <80f1ef9dd605d16df2add0a9dbdcdd5f9f508174.camel@crapouillou.net>
 <20261118020751.1833498-1-zhugl3@xiaopeng.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weibin Liu <liuwb@xiaopeng.com>

The JZ4780 BCH controller reports each corrected bit error as a byte
pair index, in the INDEX field of the BCH_BHERR registers. The field
is 11 bits wide, but nothing in jz4780_correct() checks the reported
index against the size of the data buffer being corrected:

    buf[(index * 2) + 0] ^= mask;
    buf[(index * 2) + 1] ^= mask >> 8;

With data or ECC coming from an untrusted flash, the decoder can
report an index that points past the end of the data buffer, and the
above statements then flip bits outside the buffer.

Skip the correction when the reported index does not point into
the data area.  A bitflip in the parity bytes does not affect the
data, so rejecting the page for it would fail reads that are
perfectly correctable, and an index beyond the codeword has no
buffer to update in the first place.

Fixes: ae02ab00aa3c ("mtd: nand: jz4780: driver for NAND devices on JZ4780 SoCs")
Cc: stable@vger.kernel.org
Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
---
v3: add Cc: stable, my Signed-off-by as the sender, and Paul's
    Reviewed-by, per review.

Changes in v2: skip the correction for an index that does not point
into the data area instead of failing the page with -EBADMSG.  A
correctable bitflip in the ECC bytes leaves the data valid, and the
early exit also dropped the error entries that followed it.  This
matches how jz4740_ecc_correct() treats its indexes.

Verified with a userspace replica of the correction loop: with
params->size = 512, an index of 256 (first parity word) or at the
field maximum (0x7ff) produces no write outside the data buffer,
and in-range indexes keep correcting as before.

 drivers/mtd/nand/raw/ingenic/jz4780_bch.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/nand/raw/ingenic/jz4780_bch.c b/drivers/mtd/nand/raw/ingenic/jz4780_bch.c
index 12b5b0484fe9..3a4c5d6e7f8a 100644
--- a/drivers/mtd/nand/raw/ingenic/jz4780_bch.c
+++ b/drivers/mtd/nand/raw/ingenic/jz4780_bch.c
@@ -216,6 +216,10 @@ static int jz4780_correct(struct ingenic_ecc *bch,
 						BCH_BHERR_MASK_SHIFT;
 			index = (reg & BCH_BHERR_INDEX_MASK) >>
 						BCH_BHERR_INDEX_SHIFT;
+			/* Skip indexes outside the data area. */
+			if ((index * 2) + 1 >= params->size)
+				continue;
+
 			buf[(index * 2) + 0] ^= mask;
 			buf[(index * 2) + 1] ^= mask >> 8;
 		}
-- 
2.50.1
