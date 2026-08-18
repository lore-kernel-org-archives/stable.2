Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549033AAF68
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 02:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787019017; cv=none; b=HR+JEOu3RaaJ9gME+FXD9jsgAO+4mYE64UUm78eiwzxHlWkMBmiaMj0CbppLvttu7U+gdJgikYxz2TU0Xqg44DjSKfNYCJWKYsSv0hq/FvivrMHBsIcp9xDvLHXncqVTtfzykgIgICiolwzTSBGawIFAoO8SpId3nVWUrgpH4M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787019017; c=relaxed/simple;
	bh=R7ClDPED5fZAM18u5fygTm93ZxEhU7uCx11V791hrQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YBq5TtWNZIXH0E0GMt03COP7ccfqkzKYW480w8/Y8ulyFhGoFEa+mEIWzFJQAoOlmycQtr1EfbiCAAmurVYWN5Uug/0iKlAh4hWAIIROQpKN1dnMaRVl4K1YgcyrL1EttN9vZmu/N4LfK5mgoiGn1rH5qyoQaMX57bA19AlVDNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=EORos9mr; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=IQWkXctA; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="EORos9mr";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="IQWkXctA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1787019015;
	bh=R7ClDPED5fZAM18u5fygTm93ZxEhU7uCx11V791hrQ8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EORos9mrakUPaNFszQxJ4bjPi+bBtBukE8p4IwP5/GXIUyuo/H4QAn/9J/j3HMRK8
	 f+emRH04+5kfsO9HFo52CkqL9Lf7pl2Y1uDiHbYSLP6mGmtsF+OnvS7Ppb+s9kvdVs
	 1Mjzhtb1ED9Pd+U/2YUoM2sOBOL0/BeZFXr35MNuPbZWRpcV68lIaWAekgPLEenf4G
	 MG+w0caMw2xI3FwmOtpRuXy4k8mPRkn/vh/tTHWDN0pdS7V+kZm0SAY5iBoXXWS4nh
	 beSTTJ6MvbeEtVp//3WVldKn+XamX+TOgi9WDvABiQi5Lw5GpfXmHhnjbc3m5cZC8C
	 TlNcKusDrWjLw==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id 39CA291F
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 11:10:15 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=IQWkXctA;
	dkim-atps=neutral
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 5ED7692C
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 11:10:14 +0900 (JST)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3823dcc1647so5915248a91.3
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 19:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1787019013; x=1787623813; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=blAtEYI9MivA6nQmBBbGkLtbWjRSXRisfP4s1nyOg10=;
        b=IQWkXctAygICGqI+NwQlnZaBeTnWL+4bY0KfZKvLXPnYG50QISHYP1nWg/+K/tfEvW
         oXJTdnLzi4+J7Mi4g46PpzTEXXpiYZRTKeU80jSRRbcEVFPDDX8RCG0GwBX8YDB61UkK
         vGOuFgPigT/sTGlbGwGtjMNco/DDBAXBTmSsZ4/pzG9lePGcx1tfbmweRSY25vOdKWS/
         yyGjDsy9edvB/T3ivRBEhIn4lux9ztgEhdQgaO9tajLIINSsmHSDx1ZlFMhAYrQ2CIUz
         3pnT8ek8iu0mROD/3h7n56elxMGxgen1ve4Nq3gkVM5LF460k37axz77zgkH6p5g2CKk
         KvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787019013; x=1787623813;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=blAtEYI9MivA6nQmBBbGkLtbWjRSXRisfP4s1nyOg10=;
        b=pOAhQHzvLbIYWrWqFel9/QImiis0k+jk2w2Cd4p78GFl0fyick6z9b0l8NYwGef2FG
         MPIOesYEeNejzmuCzAPZd6kgN8y0Ev62C8nh3yZrVWJdABgvKzw5+p/eKP4oQ+pJ6lRW
         cmRlJ5Jl06hnAYS818JOUklNd1uL5jhrg74O02h/45cESIJckp8MZdD5b9ILkv0Utjq9
         L7NI8bZm0IGWdxJc6IVVEiK+J1XvshDwhNQO0HFykG27jeFEwlTnGRmyWzOpSjX6f0au
         tT57Hl9LywITNe0R8py9CIicHBzed8LUxsDmXgqTMDd5ORQUEuIODyOMi+H7ZlUVVnbt
         yLrA==
X-Gm-Message-State: AOJu0YxpBgL454rQtzcjwdB4NzaqV6GPwU2dQMX6Kcu2NiVTbKlUNWR0
	3w1rVp/FUKDpWPBuXD4yXlseTMfdcqUiwP9SvOjlwhbzyhorfeHExf9N1CURYkl8X6l0Q2mrzd7
	urBKxZRT8NTtKSPRBKYLMWatDMEWQbTbU2gINp/cBRR7hPHZAOGEJA8dK4Cw=
X-Gm-Gg: AR+sD10ygFcKRZQfW2IfzKSqh5t8eAGFnselpwFopipNYs5Lq6dS8wJeMk8eKbVzrf/
	Vu8SqNma6pwDyHkQdK5aeceU951ssFDRjJw4HTxcygqG7WQQlmbRGz3o6SCHtYFiw2QLSPXsK0T
	cpbWE0wg1PSyDNddpanZ1NE8FUreRt58/KQnrTsV1m7qIODbW24NXBKsmV6szUyX69pTf2oqszE
	Xt5x1JQlQxCzGEdVECiQKgDhaXZFZNO402RhpWEd94VW3apKWxJhG4m8R0RMC3k4BQbdI+egeLt
	uXVqAW9uB4IqWOESLmIHNp/pL6nophANS/MRjiFT4E1N5Db+xAn/ky/6+M3Gg2OPUE0/Jgy48F1
	uvAFpownW0mDudo4SbT1yBoW3adZYKa3WjTNBIwx8EfEDTRoY
X-Received: by 2002:a17:90b:58e5:b0:381:a766:efc9 with SMTP id 98e67ed59e1d1-3933caf3a05mr31691929a91.7.1787019013223;
        Mon, 17 Aug 2026 19:10:13 -0700 (PDT)
X-Received: by 2002:a17:90b:58e5:b0:381:a766:efc9 with SMTP id 98e67ed59e1d1-3933caf3a05mr31691826a91.7.1787019012676;
        Mon, 17 Aug 2026 19:10:12 -0700 (PDT)
Received: from localhost (sodcd-04p2-40.ppp11.odn.ad.jp. [203.139.65.40])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3954d3b40basm4255804a91.14.2026.08.17.19.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 19:10:12 -0700 (PDT)
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
Date: Tue, 18 Aug 2026 02:09:34 +0000
Subject: [PATCH v6.12.y 1/2] mtd: ubi: skip programming unused bits in ubi
 headers
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-ubi-backports-v1-1-324d6816d2ae@atmark-techno.com>
References: <20260818-ubi-backports-v1-0-324d6816d2ae@atmark-techno.com>
In-Reply-To: <20260818-ubi-backports-v1-0-324d6816d2ae@atmark-techno.com>
To: stable@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, 
 Zhihao Cheng <chengzhihao1@huawei.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Dominique Martinet <dominique.martinet@atmark-techno.com>, 
 Cheng Ming Lin <chengminglin@mxic.com.tw>
X-Mailer: b4 0.16-dev-a9e92
X-Developer-Signature: v=1; a=openpgp-sha256; l=2537;
 i=dominique.martinet@atmark-techno.com; h=from:subject:message-id;
 bh=HJvhoiOjIe9nNu2RlsGRExOAzZRI5eQ3mmYZZFbmpC8=;
 b=owEBbQKS/ZANAwAKAfKKYH/WjHEHAcsmYgBqg78Aze2trKQWuMUsy+egLC2N65QMVPDv0JLYk
 Ku9l/EaYquJAjMEAAEKAB0WIQQoFSiLMD+txr0veJbyimB/1oxxBwUCaoO/AAAKCRDyimB/1oxx
 B1SBD/4+WmZjfcNBAm4smlV1jtTsrwmhFLvWXUO0TYKQTEwOdlAls43b8TSVhWWqbwsTN27Mwsr
 5HTdMQr7k6W/vYMfFiEzFCxszmPK5bRGyn8gEC2VMImlF7d3pjUpzKZLJ/bvN9uAuAz/uynL8z1
 VcwpI+KZ2GTzqLy7kjDC3+FtOr78VOoUTYK3yl7yG9Hw+fcFekgkvNLWWVdDnY1rf+21WC1brbB
 Gg/rqSXUCEHHd7nZDLyjxL+P8Nalm3tPJJ58PzJc8S2CyRa9r1RUV0ZYHxutbgPTW51bQpEmJHl
 du7ezOT+PY06mqj5x5POXbH7qUNDnm8yAG6Fjw49o+uSU5Hs6x0XeHa+8fgbVz9iuajLRv6A7l9
 F3BgnEVx8OQIxQrNASwajS70HbJsMvtQP2WgeZtpH/Zw6ECyDsfUyNG+Z3S8TlJGGI/rzsYFuPa
 Xb4NFnmptcFRuhDonOJtyT+cDHKO5Dbvu6I7l4i24JWvImNhpf+LSR9fqPAoiZn83Bs9aFT58vl
 cgiXJg3M7CtdlRKTv4ZpZ/n2FDhCuNuR8JZgcq8NN13MIbxo3kuoFfuNKyuYct7qcASoi5xH/vX
 EJsU+NXr/a2kF0a0pBhDKi2F9DIerkcM8MH6II3I3esuHLzlqrhWuKNyO2bLaUyb4ZhrIsp4G/y
 3aOh2DJqpbhhZXA==
X-Developer-Key: i=dominique.martinet@atmark-techno.com; a=openpgp;
 fpr=2815288B303FADC6BD2F7896F28A607FD68C7107

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

This patch prevents unnecessary programming of bits in ec_hdr and
vid_hdr that are not used or read during normal UBI operation. These
unused bits are typcially already set to 1 in erased flash and do not
need to be explicitly programmed to 0 if they are not used.

Programming such unused areas offers no functional benefit and may
result in unnecessary flash wear, reducing the overall lifetime of the
device. By skipping these writes, we preserve the flash state as much as
possible and minimize wear caused by redundant operations.

This change ensures that only necessary fields are written when preparing
UBI headers, improving flash efficiency without affecting functionality.

Additionally, the Kioxia TC58NVG1S3HTA00 datasheet (page 63) also notes
that continuous program/erase cycling with a high percentage of '0' bits
in the data pattern can accelerate block endurance degradation.
This further supports avoiding large 0x00 patterns.

Link: https://europe.kioxia.com/content/dam/kioxia/newidr/productinfo/datasheet/201910/DST_TC58NVG1S3HTA00-TDE_EN_31442.pdf

Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
(cherry picked from commit 77530d1a78ca5c274e37d6494a965223672630b2)
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---
 drivers/mtd/ubi/io.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mtd/ubi/io.c b/drivers/mtd/ubi/io.c
index a4999bce435f..915eb64cb001 100644
--- a/drivers/mtd/ubi/io.c
+++ b/drivers/mtd/ubi/io.c
@@ -868,6 +868,8 @@ int ubi_io_write_ec_hdr(struct ubi_device *ubi, int pnum,
 		return -EROFS;
 	}
 
+	memset((char *)ec_hdr + UBI_EC_HDR_SIZE, 0xFF, ubi->ec_hdr_alsize - UBI_EC_HDR_SIZE);
+
 	err = ubi_io_write(ubi, ec_hdr, pnum, 0, ubi->ec_hdr_alsize);
 	return err;
 }
@@ -1150,6 +1152,14 @@ int ubi_io_write_vid_hdr(struct ubi_device *ubi, int pnum,
 		return -EROFS;
 	}
 
+	if (ubi->vid_hdr_shift) {
+		memset((char *)p, 0xFF, ubi->vid_hdr_shift);
+		memset((char *)p + ubi->vid_hdr_shift + UBI_VID_HDR_SIZE, 0xFF,
+		       ubi->vid_hdr_alsize - (ubi->vid_hdr_shift + UBI_VID_HDR_SIZE));
+	} else {
+		memset((char *)p + UBI_VID_HDR_SIZE, 0xFF, ubi->vid_hdr_alsize - UBI_VID_HDR_SIZE);
+	}
+
 	err = ubi_io_write(ubi, p, pnum, ubi->vid_hdr_aloffset,
 			   ubi->vid_hdr_alsize);
 	return err;

-- 
2.55.0.dirty


