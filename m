Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187769;
	b=PZZVC68xUQndNy4OX4g9UVvsdKwCPx37cxgnHzuCZUln7Iuy8B0KJPjo/hQzq6zBnUMo
	 4iTqZwVrJHTo2CQF+2psCFuLoUHnmWjU7ibIut9tfIFwUxgJ2kaQ1KXvIc9h2IK8c+6D4
	 Obb+WqmPV3G2xJV2w5VXt1myyeWm7AxiiNJ0KqMK9kVZrYkdhsnAw0YNCnjXC3OYoUS4f
	 /FjNXVJyyjjFCxyHh0qDRIpJRPTkgWAuDDm6Kv8Y1axPwitLOU2BNKHsJiGe/Ezstzg3E
	 a4ePOWqwYoRu9cESs8ryyM7/4ydzAIIGFnZH2bLr+ON40sht+CBOa0ZwY34TxIlGr3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187769;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=muo/8VOQynEi/OPHvo7a1ZNTOIrWbQuTUTCZGRNs7Fw=;
	b=jBFgh3HjXQkR1IO0J4DQWIy43pyWaeErJjqOsMjICwtOBkjQM8lQqe8ZAURSkBxTOwYA
	 z2D6lOtynCvqw4xi2XIxuA0/sy91D4DcNeSp5wn9mAOX6SEgEjQl2WSv4gTO6xjdgpWkU
	 OcLj6vJCq4Wg619Pa19eoWfxbEdp/K7e4TKXhmOg9eOK8j4zwzjiGqwk7btgm5EyJa8b3
	 GmOfDGqlr/7sg9iL+ksKIUNINQgl9LuwJEeZJYCtIpzod3oL/KXq5VyPtjG/b0BPahTSJ
	 JGakK1G9PAuRYwcBMDg7BiACkP+AF/NkGoxEx0toVcDC28ZsQ83njI+ygksUE8pKxoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m8d4j5lX;
	arc=none smtp.remote-ip=209.85.167.178
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CF2606A33B
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 01:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2CF2606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m8d4j5lX
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4ed6d69bdfaso187482b6e.3
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 17:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794187768; x=1794792568; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=muo/8VOQynEi/OPHvo7a1ZNTOIrWbQuTUTCZGRNs7Fw=;
        b=m8d4j5lXOI9CMBXNOhujJKGTVlIAlnDqKU8974XfAExPHOngZHQBsg/ViG2YAJ3ts6
         lPDV1nCJn68sUubpoJf+1W/Pmmy8KF2w84ZFy+zegO0liwDIzfMtNJKlg4i7etx8Eyr8
         SfQSYzII2qS+mrQ+ddOUdvNVDkaaQJgZiqJDb3Ud5b1lDOvE26BK7QfEh3T9KjmplT9O
         nIq6B0i0Pm4tBgVqj5VT6yH52dgDRWI/UW28SdsuXZSjvlh87vZKECjHizXB8Sj+EIMt
         yEzt0CKdaftj4OtByAhKr6za6+aN6VKzIKzM42vgfxmAjRZou753g/oSlJXJ3SBwlKHe
         LLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794187768; x=1794792568;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=muo/8VOQynEi/OPHvo7a1ZNTOIrWbQuTUTCZGRNs7Fw=;
        b=TPtcdiWc6oRntk+3L2X9cJvWFszZ3VN7FZaKSkrL1MDH3lFyOfJapsIMYalKP9bfkj
         7MLZAbiEovaq711CGqP19/I2nWjfrYasmM8sImTCGaz2l+WTtsP+M29yJmd6zTYHQMI0
         L3gZIycf4UbC6X1S63OvCGu7ju4ga3/Xreq1LUCxPBsU++ULiWCDZaYV9x4HsiLZAgNj
         iLwINblGZrjXOtZ9mI/tWk+HXS32Jly5AaNQTfpeYDIcAv1DOcvCrRSPHC6Ecf2g97cb
         xj8heToT6oLjEcPLpvxkZOMsCHd/H6b4bxstDnIMSPYNrLCEwIkxE4EeDXgmB3iH4C1c
         31Fg==
X-Forwarded-Encrypted: i=1; AL+hErFaPc6g5T3fjlvzvkGJBiFP9EbOnOkJSD66t7vjH2drKPk9JN3mggakLM7eSGvgrjP4ysSDjuA=@vger.kernel.org
X-Gm-Message-State: APuU4Z83GkCRr0gtkfy0zKfooV+OEef+6pTl+h5EzulocrQ32a7nIhNg
	SJKWPPPy69J2UKBsUYvDtcrWF+wrlKhYV5r22cqWnZoMghsu7Cwy/JGu
X-Gm-Gg: AYBFou01wgoDearzlfR/XKkJ1mMzY35Q78PxM1mH6d6eCtEhU3DQLz61askVHcnQp2i
	R16NJabi/BX1qQb6Z2rtSlUoeedOEBs/M8Mx8ZP+Wn46oSBOiCNB6SqeJuYEKrzrOLd7deuQAVj
	+44c1aPhpgDPgPNujfw4IQv6+wxfpv5GBbA5OKPKKoFfNuJQUJsdF716DUODOSb62dxpn/mQe2Q
	0NuV50AZG2y6s1eY4Y1zhMSTG9mdid5ZWPUBdGFqoq/t1tnyBXK6/hXZ6SFcArm6LtxI6UnWP/I
	6zxYVICnUJO2EXHsbfWjwQchQKseJCis0/v00ZfNktTQsZ5x1EzxgZ6s1IhJOqzaSVGdLzuOZFN
	WpwYGPMnbMxD7TB6CIhY91V7I2tNp+p3zgpgNAHH/3XnDXNCrGMvLpQvU2voUBISf9wiWvZRh1N
	5rs4pRuR672kFQv9mR66IAxJDpDwxiSUTulO/yZC9WZ7XUBDM1aiGoYhh/hXg1xHGF2Cbqa1SQK
	ZuuRZfa7QEALtSsHolEMQ6gtpArpgb/B0zlpelcf+9HZDhzLndb6KZ0Cp8AMvasIe0ErzTcXyor
	HRT2h7eBBpHmEmpGtOi6aNr5Mvn7jg13ue6b+4vCxicElglHgQO0VeumOtsX2S62x/jfYaYaT9W
	Uf492XkQJKDpwqqHV5ktVnCrWsbtDfT1t8fn4MW19s/UuJt/3ni7ZbEuSY59iQZMYHU2toXSoMY
	y9bgiaape59lq5bCa5jKjGduwbBKi/lcRjmImmLs7Pm6Vu7CnxEAPG
X-Received: by 2002:a05:6808:11c7:b0:538:d44:aaaa with SMTP id 5614622812f47-56814428c0bmr1663265b6e.63.1794187767780;
        Sun, 08 Nov 2026 17:29:27 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ade695a5a6sm4225818fac.10.2026.11.08.17.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 17:29:27 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 18:29:20 -0700
Subject: [PATCH 1/4] mtd: rawnand: sm_common: restore the first ECC region
 offset
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
Message-Id: <20261108-submit-r852-smartmedia-attach-v1-v1-1-56d08c0571a2@gmail.com>
References: <20261108-submit-r852-smartmedia-attach-v1-v1-0-56d08c0571a2@gmail.com>
In-Reply-To: <20261108-submit-r852-smartmedia-attach-v1-v1-0-56d08c0571a2@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, 
 Boris Brezillon <bbrezillon@kernel.org>, 
 Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2

The conversion to mtd_ooblayout_ops moved the first ECC region from bytes
8-10 to bytes 5-7. Those bytes contain the bad-block marker and the first
logical-block address, so software ECC writes can overwrite them and ECC
reads use the wrong bytes.

Derive both ECC region offsets from struct sm_oob, restoring the original
8-10 and 13-15 layout without overlapping the metadata.

Fixes: 987b913c2b7e ("mtd: nand: sm_common: switch to mtd_ooblayout_ops")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sm_common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/sm_common.c b/drivers/mtd/nand/raw/sm_common.c
index e238784c8c3e..a3a3a05cc5a4 100644
--- a/drivers/mtd/nand/raw/sm_common.c
+++ b/drivers/mtd/nand/raw/sm_common.c
@@ -16,7 +16,8 @@ static int oob_sm_ooblayout_ecc(struct mtd_info *mtd, int section,
 		return -ERANGE;
 
 	oobregion->length = 3;
-	oobregion->offset = ((section + 1) * 8) - 3;
+	oobregion->offset = section ? offsetof(struct sm_oob, ecc1) :
+				      offsetof(struct sm_oob, ecc2);
 
 	return 0;
 }

-- 
2.53.0

