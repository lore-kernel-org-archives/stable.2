Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5F33CF218
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 22:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784154266; cv=none; b=fc3MtKS4ZiYeUdOD9yAhREiJ0++qr7rb0BZpej99Xa6H+mGiDQNmc7uckupHwDSgYSX7pXihHIt9fXdw8/1mFr9YpG/0AG17Nftun+tdfGWxuW9225JinF4f2R+BXPVTMVRQ0SoabbIfX+3QQr3erAkO+q6a1KKuflmxxzfYjLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784154266; c=relaxed/simple;
	bh=d+ktqVndZJhCJrT8O2h4M5jsdq4wiPW+WKcCbzjTV00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcQ/dTxA98vBkfA8HFHATYRtkFqQakXqcmyTu8VhSVyQC2fszRFLA1cpv0m+W73edLIN5FMaXNJvsr2z6JVvdmFsZLZ5PmVPIRpvvqluj2NuWZFtTwTbVzAaQ4n7N2+P6OZ+H7C9zrl2Ge+l/XZpIsdqXDJVZ7Tgoz5hqCkYvPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o0Wc1nws; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o0Wc1nws"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-475cb71a4ebso5571038f8f.0
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 15:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784154263; x=1784759063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+WEq6Gzmt1f2hEZj2wO18jW2AXF+11Es6P4mjwJfz0Q=;
        b=o0Wc1nwsyCrvK2SlkyiiD2Kzdg0ZHfdeFVVn6Sjwr5mcMxh2/wjrn/GLYcpU5qvt86
         GbepI8Dm1KMelKdQ8RQRE/FZJ9VM8xTgIFuf549AyDjSI9nvaVbwAuTVRUuUn0MZtpMK
         elZo2He8ex0QKDqxaDyPMWgF8bjhIzTSWspwofDMw1GGLOEpGlHUx4jBLB58UX6oN3LT
         RZakbWtXwGl4QhzBpJbKaavbNAt3xY0HA8k7pNu90VFDVNIWrPMeD16Scw9Bhawiiqvi
         pERr4AHkigkD3aO2VEcX6H1dJtEEimkkTu9v1ho2qu1B282pxrLO1hVlb2zdz+FyqgBY
         FdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784154263; x=1784759063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+WEq6Gzmt1f2hEZj2wO18jW2AXF+11Es6P4mjwJfz0Q=;
        b=tA8ro/mC2+8rPleGJQe8IR4lOAEuF1gQigYmjbtrRqm0KlCl5nWN+QaToefZhnQPUX
         w7ENSSrl/B17BCOdtraJIt1broAK6SsQaN8ut0hAqETOXNVLhh4b1BQD8rhpYObPxmBH
         Nw+IusLEHLbxBCXxLNniNQUh/sOpLdITu7ZxnhWT9kiXQh2LbpqNQ5v42CrdXshLdyDY
         1OYSwBxY+uc4foN/Z4twiTsSQGCFbyMG0/11uLAfGcoVG+JO/VgTJaO3itfZHQMXUYoi
         7mm11nfOc5RziRoOd5nEv3LecizJRD4q/lyIdN4svESjUfrBwA45q3IcrMwBGAQRMRSK
         w/2Q==
X-Forwarded-Encrypted: i=1; AHgh+RpzOYpa423OGWYb8s+JJh8mpq2e0Z3KECrGXndGEFOpQViU0Bz2Rl81MEgV0F1F1RjFC3SBH7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQvsbS8gWZrcDGM0Jhozj0qpFDrnb2QYfLM6bi8AtQthW4SmUn
	Od8M90WnzxR7VAlIwUR8GPlxlxoQPcJ3+qNQnpbYqembVv7jYswHzmBC
X-Gm-Gg: AfdE7ck0Mi63+65mBeTKGzzfMrgxocOfCuU0ElLyFgZbRA++GP9wSLDpfu2PCRkxr9e
	eZ/UqC/wcBfGkLI9DzviBoOiERzzc+1BIy2KGoYd4RCOtdGCsjaDnbja/f5Y9HZoTA+5VLuy7U3
	V+Vv0gMD+RUATW0S1kvcHEF9jEx6tZNcvIRcNxigEy1cZUe6uTBmeowhSKvj6SDwXHPZKR5Phn8
	wySoDMxSz2Z2WXx740ns6X0iZ6MGu2BrpawqWJZSi+IhfRuNDUIXiUCQACm4vPBXL37lc5LjPlL
	+DrAmeJALX2NxEhVyRjADMWoYiywlylbStj2ar/fHBi46r8B8JUVZ/DgQiwT3CVGECaBi451sob
	ThA+VZ6BaRFXvUrDm6xQ2a96g5CmvDWM3s76qLnl89nQpHlyXODBUJ8QZHDUhpK8IIPj4vf3mRI
	SHX1rw/0vP90BgOoFLukvfcmoH7QXLH8giMaM7a2b7/KQvOu/ICx8F/Tg0hZr1qHtmGLGzJElHG
	W7RbSby+mUkdA3y3d3/2v/n7rI=
X-Received: by 2002:a05:6000:1acb:b0:47f:4893:d17f with SMTP id ffacd0b85a97d-47f4fcd5c16mr5321708f8f.22.1784154262632;
        Wed, 15 Jul 2026 15:24:22 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:6d4f:b160:7aea:9d1b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4634e036sm22337783f8f.5.2026.07.15.15.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 15:24:22 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/7] memory: renesas-rpc-if: Mark XSPI_CDD1BUF0 as volatile
Date: Wed, 15 Jul 2026 23:24:11 +0100
Message-ID: <20260715222417.2997712-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715222417.2997712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260715222417.2997712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add XSPI_CDD1BUF0 to the xSPI regmap volatile register table.

XSPI_CDD1BUF0 is a data buffer register used during manual transfers and,
like XSPI_CDD0BUF0, its contents are transient and should not be cached
by regmap. Mark it as volatile so reads always access the hardware
register.

Fixes: 687cac9559d8 ("memory: renesas-rpc-if: Add RZ/G3E xSPI support")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/memory/renesas-rpc-if.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 3755956ae906..104c28532c20 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -34,6 +34,7 @@ static const struct regmap_access_table rpcif_volatile_table = {
 
 static const struct regmap_range xspi_volatile_ranges[] = {
 	regmap_reg_range(XSPI_CDD0BUF0, XSPI_CDD0BUF0),
+	regmap_reg_range(XSPI_CDD1BUF0, XSPI_CDD1BUF0),
 };
 
 static const struct regmap_access_table xspi_volatile_table = {
-- 
2.54.0

