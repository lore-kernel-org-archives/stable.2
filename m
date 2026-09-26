Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE6138398E
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 04:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790396940; cv=none; b=nY4MCrCWCXlu0XsXFljB8UH1W4Q2fgk13ElFHpxNzS5POA/TZmcZQzOOC5h4jyMAnjeteOiNUVpMIfDx+GxDcT4JK0QskzZRSbCyT81/Klp3c544LKsJTWh8BzaQ5KOHGBKzzYVBgDhwwPue8VcOKjKP1vWISttpzsPytcXqzoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790396940; c=relaxed/simple;
	bh=+oFiQMh34Yo1wjCxUXc0WSNGzDHCpRZDGEYi5TVqUt0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=colme4rJgjDuTU+xSyMJrKqTDTSMNDWd9L0KTcTOjIelhyE6YNaKSjpR0ggGjhGQpCPFtRsdr5kbPWjd7LGr6BSIRD1b6ovw2M4uaVaU1LIboLligsdXOXmehgagmOBDoRl7oK1+i3AEV4zepcHuP/ik83UA0H83b1Ph2ppqQNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJd9uOHP; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJd9uOHP"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0bec20a6fso517606a91.0
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 21:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790396939; x=1791001739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rZYtb7HyZs5jwg8H8lmzZlpM9HbrBErAFFHpko/rscE=;
        b=OJd9uOHPfE4SW5QVX7CGPSbgq5+gTdjzOCkWsGMy6221DiKvqg9x21OL8YpO7b7+Ii
         ghe82xdviLRrufP3I5/5HVTjAiBuLqnHtEiMtLG3hDWoN7eLkxJ2RCH9d7mpqEBsubaV
         axJ7Sq4iZCaPL5ONkqu/5s4NCIYzxbbTf+k8AIoY6cvo1Zto5FGnE8RZK8mMDkIJ4kTz
         z733EnBYWAUzfPD2UPtWeNQvlbyx6scEOfp8NuvS2WTY8rjY2uZ7od35/liSgr9FymM/
         xpBvl6D5Vbk8xq59RV7APxg5NBFj4xB248jGcAUW0K/qFilfdhqajFt6OgqDuHJ4n+um
         2HSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790396939; x=1791001739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rZYtb7HyZs5jwg8H8lmzZlpM9HbrBErAFFHpko/rscE=;
        b=ZhdM+yckNEpVmpYp13OOWhWXvhZ7YutocxvJkW2JOyfuG657EOs7oUJxqZs82HqSik
         aV9OjeBVao6fkjvPfOIzJsWzbdFUFwtcQgtWcgIvyrLxRh/cGbleN2GBbSnGOFD9DXyu
         9XIDUv0hcG5YszhTzp4YGpb1fHL5axLfEX0Aan0ffU8+chOWIVfFOtAbBfAuXpzYpbph
         3NrjMGGwfL0V5moqDtSCLUspuN8VAaAOg/HRoYpg0dlcPN+q9DkNFG55cWUAubjLAMbZ
         J+/dJqPhyyWsWWX4iERtOj1zqdkBmdqfe499pHXNo2mNrVleTc1bK/SDHZ4g6ur9v2uD
         ISLw==
X-Forwarded-Encrypted: i=1; AKwUvBzAT9E+cc79arkmzn5B+d/au1jASpUa0L5shrk6c3dTxFnTsyV5gttTQ4VeLmqecSmqFo6FNR8=@vger.kernel.org
X-Gm-Message-State: AFuF++l6/QTGWW8WpVeRXfDliBL/4/q2W3mHsTt7OOXViUhtlV3RGime
	DYQkipSoZiWZGEXFuw6Ym3qXlVGwco8bjZ9d9Psnx+v5xU+LWOIWe4h4
X-Gm-Gg: AYBFou0DosNhN+JEwYHovLA9VCMz4eoyxKyfbZ9Q18HBSPupDA3mIoOKeQ2NR+GSwHN
	pjwe2aEC9t1vrFIcIEgQGGubH06BdWZirPGuS5L1CXIz6IHmrUxvY3DlLzJao5tx4ofH3E4bvdH
	r9hQ2QYK8K2H3aHzQXZpcX1G13pn6BDLHGiBlWv9Mcf/dKc/nZ+yfjqi5+On0IO9Dk+d/6do+bt
	8XO+NhIxMKYpShWQ98kYXwsrc8fsVfA/93aNADLVEvGtZNafx3x639PDIzb4Cs52rIlHxhYn8Ra
	iaIFyFnUTE7/fPevbDN6vMb/6C5c8e8rC9lLFuGMKP8ybOHBR0FLdSLoZm61T6UK97gD1QG4byq
	PfTkVMhr8ii09dfU2/3gKUKgKZmSqrAvEOsJsqOeOl54r+oeZnImdFRM0AcMnyaUe0qpTUZ6Kc8
	+AQ7iwdYT1jXWnzLQlGkKT3bq1hcPf+eHWq+P/CnREDyIbm3rDcC6na5pAvxFT2QD/BgnT5M19F
	UrkvzPM+tg6yKgt/slUaO++TpKQwbqXSxLTrq8cc3Kf336TaB3Z3SmcaRKb7aV34Kgy9uIY4+OA
	ZTlHTFk5UZM4BPe/vp8rHpzQRjRVsDidwDKPWw==
X-Received: by 2002:a17:90b:2645:b0:3a0:c85a:ee12 with SMTP id 98e67ed59e1d1-3a0c85aeef6mr1436224a91.41.1790396938711;
        Fri, 25 Sep 2026 21:28:58 -0700 (PDT)
Received: from dell-pro-max-tower-t2.cse.unsw.EDU.AU (pag-t2-pc.cse.unsw.EDU.AU. [129.94.173.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a09773e7c3sm13841518a91.17.2026.09.25.21.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 21:28:58 -0700 (PDT)
From: Weigang He <geoffreyhe2@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	linux-mtd@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Weigang He <geoffreyhe2@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mtd: parsers: qcom: fix offset/size overflow on large partitions
Date: Sat, 26 Sep 2026 14:28:53 +1000
Message-ID: <20260926042853.2209428-1-geoffreyhe2@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In parse_qcomsmem_part() the partition offset and size are computed as

	parts[j].offset = le32_to_cpu(pentry->offset) * mtd->erasesize;
	parts[j].size   = le32_to_cpu(pentry->length) * mtd->erasesize;

Both le32_to_cpu() and mtd->erasesize are 32-bit (u32). The multiply is
therefore evaluated in 32-bit arithmetic and the product is truncated to
32 bits before being widened and stored into the 64-bit (u64)
parts[j].offset / parts[j].size fields, so the 64-bit destinations are
never used at their full width.

The SMEM partition table is firmware-provided and the per-entry offset
and length are not bounds-checked against the device geometry (only
numparts is capped). On a sufficiently large flash, a partition whose
(offset|length) * erasesize is >= 2^32 gets a silently truncated
offset/size and is mapped to the wrong region of the master MTD, which
can overlap or extend into an unintended area.

Cast one operand to u64 so the multiplication is performed in 64-bit and
the result fits the 64-bit fields without truncation.

Found by static analysis tool CodeQL.

Fixes: 803eb124e1a6 ("mtd: parsers: Add Qcom SMEM parser")
Cc: stable@vger.kernel.org
Assisted-by: LLM codeql
Signed-off-by: Weigang He <geoffreyhe2@gmail.com>
---

Notes:
    Compile-tested only (ARCH=arm64 allmodconfig, W=1). Not tested on
    hardware, and there is no reproducer.
    
    The CodeQL query behind this report was synthesized with LLM assistance,
    and the fix and changelog were drafted with LLM assistance; I have
    reviewed them.

 drivers/mtd/parsers/qcomsmempart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/parsers/qcomsmempart.c b/drivers/mtd/parsers/qcomsmempart.c
index d4fdc46a00730..1591aea48b280 100644
--- a/drivers/mtd/parsers/qcomsmempart.c
+++ b/drivers/mtd/parsers/qcomsmempart.c
@@ -143,9 +143,9 @@ static int parse_qcomsmem_part(struct mtd_info *mtd,
 			*c = tolower(*c);
 
 		parts[j].name = name;
-		parts[j].offset = le32_to_cpu(pentry->offset) * mtd->erasesize;
+		parts[j].offset = (u64)le32_to_cpu(pentry->offset) * mtd->erasesize;
 		parts[j].mask_flags = pentry->attr;
-		parts[j].size = le32_to_cpu(pentry->length) * mtd->erasesize;
+		parts[j].size = (u64)le32_to_cpu(pentry->length) * mtd->erasesize;
 		pr_debug("%d: %s offs=0x%08x size=0x%08x attr:0x%08x\n",
 			 i, pentry->name, le32_to_cpu(pentry->offset),
 			 le32_to_cpu(pentry->length), pentry->attr);

base-commit: 165768bb70265b5c38cf0b73fafd75be235f8b14
prerequisite-patch-id: c5a3be8688fd8e88a00352acb1374e91fcb52a03
prerequisite-patch-id: 67693e2c08624df0841619cc085ce9200f4385fc
prerequisite-patch-id: f3d73f7c19be7e952aa8061303f53f9a08576a88
prerequisite-patch-id: 541e578709d048f4c8115f1d926be2f2c03ecb0e
prerequisite-patch-id: f23f8e0693435497645805822d98a92e57fb46f3
prerequisite-patch-id: eae82895db8ba67018a777a91a283ad6bc4a55b2
prerequisite-patch-id: aed00f7502865e3f9262959d828eae4a4021108f
-- 
2.43.0

