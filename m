Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D637B49B1F8
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 12:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352861; cv=none; b=rHN1Lk6l3Km1tOwFQT5uCw+Q4AF6+KVQqym/rRVU47FH3HKlEkxhSvf9h/pbZVpTu8iXme/CMj5s10rdlnI2eQ90iedzNViAXQz0Xr42hX5ou8fGM5DUtjmZvdD5UpYBavWxYTc6TjrMDcqg/tlEkIBm3Uy/viIdPe1OpY1HeZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352861; c=relaxed/simple;
	bh=69ncB8hBajtEa8HDapr1rxkd8n/GxAyhRCT8Oborio4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z8efxEUH60kTPoLGjTO7xre6reD/d1Vuz0dA9iDpMbX/fSxpWd6mQiXcLLDYqqOWb4QlqUtz96n3a/ZLAM5toLCyS2ZNrkJPaBmV7iaIAhIW7LFzxXwTOybW6dna1xlKlhGtHsR+2P8K0hUfbkcQWH4HekGLBdgBii0PjbpvTiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QL07uXIK; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QL07uXIK"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ca97d139d5fso987156a12.0
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 05:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788352859; x=1788957659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z+i1+hLinUt3Q2bK2ZT3Wc0emmUMZr61lAfSOzdane8=;
        b=QL07uXIKeHZgy+eT7hNC39PGCw9CxqidJDdTdLfROj9P22mXs5mETheHi2CmZnvHF0
         HRud3iv6Z0prAGUZR7Sd8xy0R9zzl8Scx2VgI5gtTgEbKNcqCq2FVTPL1cmCy5X1zte0
         48Y3gStBNWIJYj8hzUu+abuE7ZnfEBTwKLArm9xM/1iJegrBzKpkXXWDVP9J298pypM7
         EiWYrTgB8rLej8BK/T4ORYb3/8nSSQTM0/r9FbUENcyZGgYQ0b9pQcDG+k2Idpv19y0+
         gf6K4muorfIv59mNoUV3ujgPRiCjL7ZhMMHeV0Z8pWyvxWtuTZAicvDWBF+Ym/UB11lF
         QJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788352859; x=1788957659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z+i1+hLinUt3Q2bK2ZT3Wc0emmUMZr61lAfSOzdane8=;
        b=Ul4rWAVyPXndfLHiJ9eylZRunUAqb5wPWgwApP+XsZeT9yPqzYV0X8qM/6BthE0v/w
         bGjHuQAhcTgWzYkrbxLmeAMxoOSXyrQUXceY0sL+iaIgZZzzBWRt40GRPtbSOr7hSFNi
         Yc9/Od0l3FvY34hcrHcIQtNLTk9fLCX8CeYJS5JQIzSHEmq2DXdgMskjW9o7GlE5l2WW
         y/hS7CfiAe24fnXqfF+5BQ+hojM8SKr628HG07SiqBCa5azTlNURry+czCsuzJWhZtQn
         b1N9jUYTpbTlZaz7TsEsHETnbp7xwyR6tjq5haNdCc3uaAcBIG1v4JrxYaRvgkkDYGRu
         VJOQ==
X-Forwarded-Encrypted: i=1; AKwUvByX9iaA7MWMyNhD9kjpdsRp5v3c7YhLs9F8e42uy2+lixeFKiU1DylQzrz61UfExW4JecJOsrw=@vger.kernel.org
X-Gm-Message-State: AFuF++lfgOdoJhleuNsB64VReXvngc3zwanuGkVaipvHDIWFu7BOBW3D
	5FFyKxBb8nadxAYcUjLw2hWnGnCT1HosnqUAP/0TgqlsWquznlj6QeN/
X-Gm-Gg: AYBFou1IdRtTQWXhTsnDrrG5toz+K0VZahdMicp5Q9z+ypEb2qV00vN9+be6P0AeuIr
	OnSlL+0RF8/spckX7uxEcfVZkOyTCWA+2HWrnGLAimSXTlFFVx8fOqWdPT/2dLyMUXdZE3UobOx
	nrAW9YXW3RPNCiyqfVc23QYhsup2YCHk5MMYSPaVmP70tm9oBrKaZ+xO6NUh9mGyW8aNWyYKdPu
	fHgxCvqegTA5/VQNrqoses/u/VsMae3t494dv3q30b/P+xfDo5F7G85ATnUKa8A6pNJvzypexf1
	m/RcBysXT0lzpOHwtwwrqUgs67GzI8+Chuf4t8OIOCAlComD/J8Ei1LYzHLdg+5ow9FkmikKF41
	T35YF7zk38VDXDYoE+PUznYBIRbi+nVZZ4ct7PNmEY4t/QK7Ou99IAlbFlohCwWnUb+PXqxZM1G
	spEQOYCVrWZLba1HnO85qCO5ZRdjeGqknXJHr2bTfPw60sY4YGd2qvAE/1xPI9px5zfcA2MK/WD
	Jkx8ROTmCnkUeEaMOmSGwqssikIbFXpfQ==
X-Received: by 2002:a17:90b:4407:b0:398:9bd4:d13 with SMTP id 98e67ed59e1d1-39aee219427mr6732990a91.18.1788352858942;
        Wed, 02 Sep 2026 05:40:58 -0700 (PDT)
Received: from localhost.localdomain ([180.101.244.71])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990bd21e9dsm11879576a91.4.2026.09.02.05.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 05:40:58 -0700 (PDT)
From: henrymei <ljp1205831794@gmail.com>
X-Google-Original-From: henrymei <henrymei@tencent.com>
To: linux-mtd@lists.infradead.org
Cc: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	linux-kernel@vger.kernel.org,
	Aohan Mei <henrymei@tencent.com>,
	TencentOS Corvus AI <corvus@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH] mtd: inftl: validate MediaHeader partition geometry before allocating tables
Date: Wed,  2 Sep 2026 20:40:19 +0800
Message-ID: <20260902124044.3942821-1-henrymei@tencent.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aohan Mei <henrymei@tencent.com>

find_boot_record() trusts the on-flash INFTL MediaHeader partition
fields without validating their relationship to each other or to the
device geometry.

The sanity check

	if ((ip->lastUnit - ip->firstUnit + 1) < ip->virtualUnits)

is evaluated in unsigned 32-bit arithmetic.  With lastUnit < firstUnit
the subtraction wraps to a huge value and the check passes.  Control
then reaches:

	inftl->nb_boot_blocks = ip->firstUnit;    /* loop bound */
	inftl->nb_blocks      = ip->lastUnit + 1; /* table size */

so PUtable/VUtable are allocated with lastUnit + 1 entries while the
boot-block marking loop writes firstUnit u16 entries:

	for (i = 0; i < inftl->nb_boot_blocks; i++)
		inftl->PUtable[i] = BLOCK_RESERVED;

A crafted MediaHeader (e.g. firstUnit=7000, lastUnit=3) turns a
kmalloc_array(4, 2) 8-byte allocation into a ~14 KB out-of-bounds
write:

	BUG: KASAN: slab-out-of-bounds in find_boot_record
	Write of size 2 ... 0 bytes to the right of allocated 8-byte region

The MediaHeader unit itself is also marked through PUtable[block]
without verifying that block lies within the described extent.

Reject inconsistent partition geometry (lastUnit < firstUnit, or
lastUnit beyond the device) as each partition entry is scanned, and
reject a boot record that lies outside the extent of the selected
partition.  The existing virtualUnits check then subtracts values
that can no longer underflow.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Cc: stable@vger.kernel.org
Assisted-by: CodeBuddy:Kimi-K3
Signed-off-by: Aohan Mei <henrymei@tencent.com>
---
 drivers/mtd/inftlmount.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/mtd/inftlmount.c b/drivers/mtd/inftlmount.c
index 87e246a6f488..b0f01db95280 100644
--- a/drivers/mtd/inftlmount.c
+++ b/drivers/mtd/inftlmount.c
@@ -192,6 +192,23 @@ static int find_boot_record(struct INFTLrecord *inftl)
 				 ip->lastUnit, ip->flags,
 				 ip->spareUnits);
 
+			/*
+			 * Reject inconsistent partition geometry before it is
+			 * used: lastUnit < firstUnit would make the
+			 * (lastUnit - firstUnit + 1) check below underflow,
+			 * and lastUnit must stay within the device as it later
+			 * bounds the PUtable/VUtable allocations.
+			 */
+			if (ip->lastUnit < ip->firstUnit ||
+			    ip->lastUnit >= inftl->nb_blocks) {
+				pr_warn("INFTL: Media Header "
+					"Partition %d sanity check failed:\n"
+					"        firstUnit %d lastUnit %d "
+					"(nb_blocks %d)\n",
+					i, ip->firstUnit, ip->lastUnit,
+					inftl->nb_blocks);
+				return -1;
+			}
 			if (ip->Reserved0 != ip->firstUnit) {
 				struct erase_info *instr = &inftl->instr;
 
@@ -233,6 +250,18 @@ static int find_boot_record(struct INFTLrecord *inftl)
 			return -1;
 		}
 
+		/*
+		 * The boot record unit must lie within the described
+		 * extent; it is later marked through PUtable[block].
+		 */
+		if (block > ip->lastUnit) {
+			pr_warn("INFTL: Media Header "
+				"Partition %d sanity check failed:\n"
+				"        boot record unit %d beyond "
+				"lastUnit %d\n",
+				i, block, ip->lastUnit);
+			return -1;
+		}
 		inftl->nb_boot_blocks = ip->firstUnit;
 		inftl->numvunits = ip->virtualUnits;
 		if (inftl->numvunits > (inftl->nb_blocks -
-- 
2.43.7

