Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790A141DECA
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784556787; cv=none; b=Nft61NzAJcbENzrUZvH2y4SejgbJS5XTICuMJpLFiyYvVKBfKgM6VLPPWie5iwq1aPJAARguMjUsAoPpJXqC0EgKKT3JStUFQHz12HX2YeRPF/P0r0kUvognzH38amYkn4v15asBpbvfdpIO6adP0CpvST8VIHBLKBlnVxtYtFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784556787; c=relaxed/simple;
	bh=ll/49uWw98HtG13jkCuju/9QKWipJ0XC4X80ruQl+0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WHOOPgPXvoirgZPSneAarYPeXbl0M+DHgAjO62ShKpPObGQx0Ev5qO1ajBosxXlsGWeQ/NtRrCk0li50bnCv7J0WEz0wFZYXGzUqcMP5g3O8szs98dHZZaCQBeGXLLzvGcvjm3Ds730aJ+TiPiLOjSTujKoBthzggt6sw6494Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUvz6sRX; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUvz6sRX"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ca64c3ce5fso115351745ad.3
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 07:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784556786; x=1785161586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8N2Eh9+kjraqWaH+OPY3y8zXKExuWvOOjFqxAzkUc8Y=;
        b=YUvz6sRXLCKIUbvPwsr3z682faCfkRgi809np2S4wfrofdvICjkcq2Fkwb6Bx0+8Zl
         kS73aJylM9lfn2hP9knK4rphUQQ951M8NrC218NUdA2Wh/Csv5K8rNw6Ee/WvhCIDG/b
         Rzp8a0qGuLlgY0zsywmS6PdQ7/AbcB1eTFcu+kB1r+hFW6nT+wiRK2H6pDTVucQ358kG
         2KIqUiJ2WAF6UE2Ff9utOYASZkJlepvWC0nOxCouikF4YjpuWu24WTbtyDO0YhECL+y2
         BvqENTjpt/Ner8+8/YkxAr/P1NsBofKmbgskiD2zirVusvwYB1kQvcS/RLOVSJ8UC4zX
         kXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784556786; x=1785161586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8N2Eh9+kjraqWaH+OPY3y8zXKExuWvOOjFqxAzkUc8Y=;
        b=LcVRBTgAn2VGokouGD4oWiLorSjaYHNm6VaiSykAUE2sDELoih36Q5e6oTfxRVASSl
         MVllWdg2RokqY/+4a2jkEIk8e90f/qIajLV8DchU7afA3pqgmpydQvrd5fsI2FZyVEyH
         SwcViur28poMFOVhVuafPK5y2tcm+jTEVgSRtyJyHdlp9FtnvyAF2iVyVYIu0OVyRkJ6
         u/1eZiLFRxApv/kKJLDhA2l7fQzZjYrKwec9UuH8/2b8/9juTVt6CzAAmT2Ka4E04FhK
         KzEL0UJG3Fqv9yNruRFbVF/sEONOKdLjLN5q2KpCAqE/YgotQrQIL7hp+PuoP4SvMiET
         rDYA==
X-Forwarded-Encrypted: i=1; AHgh+RojBt4PKkCmopMEgfrKG26KTEVuhDcRLA4tVkA8f8Jtfi82KhP898cIokfAM73T6L43qME0NeA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1dNG+4UfoBPQRfN/cPCOKSRH0N8+vZhZd1ZuMIKbKKTz0yO2Y
	QokLF5WICGGklww+S/MaiYB3A7mETbDXUeDs7fBvEL6plrdtLDtyKn93
X-Gm-Gg: AR+sD13OG4A35uXAQkyif/n6zgr6JYIM40EJrLS5GN09viNMJCtVrxZPW/nzfHLKW9/
	RMLKU1r8vBgTNKjPFeOdCOHJJR4pxk+mlLRM18aEvbBX8KDZXsLdkx4+cL9ixaDb8314/2Ah6yL
	+UGeBkNxVezPnpTnqwktiWGk1xloXEbZp0XAE2J8VihLj8S1GIIGxptVfqAEZ59KY2bCJDSEnKL
	nWVRMTNLPXmZfDizalGz5FEk306mr/TXgVI2sGAtrOxOfGwr5WQRLihBv0jJTB9moRgL1WEzovB
	GjkZ0/GE3hwuNQC0xnccJAjuB4YtyBZzIUCZd3hdJ05+LsyIsbcjrti2baZo/EknclcLCKNsBIJ
	aiQAYjtvOLUCz+47UzFMhr5mjDSl7j5JQrDUlODr1bH+sCFZYOeuJMWAccDiIZ7C7P2+Zqg2YLR
	qQgfDoRrxwaaMEHcEFiBw3Epn/USbhS6MG0jf/+imtNlLVWLYbzeh1go39I3g503Euvmk=
X-Received: by 2002:a17:903:3243:b0:2ca:ca48:c36a with SMTP id d9443c01a7336-2cf348f9dc4mr150032705ad.18.1784556785760;
        Mon, 20 Jul 2026 07:13:05 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf34730e35sm57578155ad.64.2026.07.20.07.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 07:13:05 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: pratyush@kernel.org,
	mwalle@kernel.org,
	tudor.ambarus@linaro.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: takahiro.kuwano@infineon.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>
Subject: [PATCH v2 1/2] mtd: spi-nor: sfdp: check the length of the xSPI Profile 1.0 table
Date: Mon, 20 Jul 2026 23:11:03 +0900
Message-ID: <20260720141104.2054417-2-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720141104.2054417-1-sammiee5311@gmail.com>
References: <20260720141104.2054417-1-sammiee5311@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The spi_nor_parse_profile1() sizes its buffer from the table length the
flash reports in the SFDP parameter header. But it then reads DWORD1,
DWORD4 and DWORD5 without ever checking the table is that long.

So if a flash reports a length of one, the buffer is only four bytes
while DWORD4 and DWORD5 sit at byte offsets 12 and 16. With a length of
zero kmalloc() returns ZERO_SIZE_PTR rather than an error, so the NULL
check doesn't catch it and the first read dereferences it. And the value
doesn't just get thrown away. It ends up as the dummy cycle count for
8D-8D-8D fast reads.

To fix this, reject a table that's too short for the highest DWORD the
parser reads, the way spi_nor_parse_4bait() already does. The table is
optional, so this isn't fatal. The spi_nor_parse_sfdp() warns and
carries on.

Fixes: fb27f198971a ("mtd: spi-nor: sfdp: parse xSPI Profile 1.0 table")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
 drivers/mtd/spi-nor/sfdp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index 4600983cb579..ece8bbd4bc47 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -1175,6 +1175,7 @@ static int spi_nor_parse_4bait(struct spi_nor *nor,
 #define PROFILE1_DWORD5_DUMMY_166MHZ		GENMASK(31, 27)
 #define PROFILE1_DWORD5_DUMMY_133MHZ		GENMASK(21, 17)
 #define PROFILE1_DWORD5_DUMMY_100MHZ		GENMASK(11, 7)
+#define SFDP_PROFILE1_DWORD_MIN			5
 
 /**
  * spi_nor_parse_profile1() - parse the xSPI Profile 1.0 table
@@ -1192,6 +1193,9 @@ static int spi_nor_parse_profile1(struct spi_nor *nor,
 	int ret;
 	u8 dummy, opcode;
 
+	if (profile1_header->length < SFDP_PROFILE1_DWORD_MIN)
+		return -EINVAL;
+
 	len = profile1_header->length * sizeof(*dwords);
 	dwords = kmalloc(len, GFP_KERNEL);
 	if (!dwords)
-- 
2.43.0

