Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792546586;
	b=llgPv8XuGc1ejPuKZbTH95WkJFTDFXzAB/Mj1fhkGM6gIfMTwV1VgJx7DQ2jhhAVbQSy
	 YG6AgVcF+5H2kgzn3EXgxeCutKYZvU6tGgVHOBmzG9+JtCVEa06HCuM3mxO8ZCyDrPafp
	 6rKYtuIjNzNu/b7SCcN8HYY3qhg+WJTWDv8ZnovVFXfPLQB7pXUWdefr/9KYKRUx+jntI
	 ZGo+MXDnsXcU9CF2b3jJA+vUEbjnfMsb0cOJYEyHhEf8aqL9EL6cnCnkxmkLROe/e8js7
	 D8DxhZRTla+/LWIvb07obHrugl6zBIZF4cYoOBAE0Bo3Prt69hA8653b9Pxku+/LEGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792546586;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ax/MKBRp76FWn3h/ZPK32Hkl8AkiS00UsCUGIQD4n0E=;
	b=3NS93ksrzFxQZ9YU7+YbCNQRM16CnaV4NEc5fLqudY2l3bPX2woQNNuTpvfj6sRW2/fs
	 0sYRyHjvB3VKjnZK2yRq+FfxmS6X2ciwFJWlevc9ZDg4ATBREDHWngkot6oWtdAwo1T03
	 k226OxF69yxgVZ6HMY9We0sJrG/P8DgkJnwWk3yPXMOGJ+xMwQqE4PfOkC1BKho+vLwm8
	 d3LL1CrN5/fb7JjfNgjA2eI30ssvbJOuGg130/ugUfF9Z7E2EyUltdwrY0sCRysTtqaNu
	 3OVshQ+OTmHuTdn4JcdoBt5l9AUeQGnI/gvdgjzBrYbIk2XKHsw6eodgctqrEsnCbGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ou9lYyav;
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AF5606A31B
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 01:36:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53AF5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ou9lYyav
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-35dc2af1f2fso63031eec.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 18:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792546584; x=1793151384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ax/MKBRp76FWn3h/ZPK32Hkl8AkiS00UsCUGIQD4n0E=;
        b=Ou9lYyavZBg15vkdakrlmd0FU6/TQ0XKtiphUaKiLjVJYw8DX8HQImOgtJvkvpTOFb
         WrnHn2nCKay6lGUOfRAdPwEAHJWLdLJG10TmCjutc6vj/n2K6rYmYf3gbMDYQL6NkTHj
         tadho/B+QJqjY+k9jtTed01CVh9zhA4pQ2pD4Ho/MFmefusfa7rW/mkoBCVyrf7v8ujI
         snd+7YP2pY2HzTs+NNNVUEhJiTCChcsXo1HsgiAqwgbMv7OlzIM8tZtdE53/jRMFyLE/
         MRiglMdmSTh946wRJh+jcnwyBg+XLDpzVPydwo830LEZsNUt8XIh8wLm8kKXpXPkityE
         4UwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792546584; x=1793151384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ax/MKBRp76FWn3h/ZPK32Hkl8AkiS00UsCUGIQD4n0E=;
        b=1vInhw0h/khG7cFpcE1CxF8Rbf6yzNtfzUhj6N6XB15moXegrFepnA4CZcSGhgfllV
         a2Ubthoh52r67uTXyWgUsHrSYifXXNYsjvBjmBNDegpgX+AslF7ZMJGnJ4T+/GMZOKYK
         XUDp+4MWqP4y8g4tsv2ZtgK4e8NVNa3A4mim5cCb44K5sAN4rsNNE4TLTt3SIFoZBHn5
         WFdQ5Ea9RCBCsW1btUNloNgsrk9BaCuQtfNzER6FJvWLnLlyaT7Hka9WNU/Dtl4VIXuE
         13dob7neD/vzA5OZVhcRS4woW7ffH6LujGA+CV5xFajxtmSlMUfETyZQ5Wl3uK+H0h+c
         q0sw==
X-Forwarded-Encrypted: i=1; AKwUvBwFTzlaYREJgHMsZZxExljIJALqp1V1PJMhbjbmQvZAOPVaA7cMpix1CT/ywAzbLzIx8mFuyXg=@vger.kernel.org
X-Gm-Message-State: AFq9FYI4PzeTio7B4jfk4clUu2EwTvmbSKS5doBxm1DMy1zDl5lbUQFh
	te9OCRPZXltz2KUpIFxCjUooInt/Se7qHJmP8Ema/bE73LTDMWXbobw+
X-Gm-Gg: AYBFou3iD7HpXlOGBuyrw2mnL0pnKIyLXDVe/aehMJ4vx9+dstz1N96BheE6uHPfoHE
	r9oxf8VaBRLIF+ociu0z+8aO6qBHlVuGtbXZP7J4E6CCeQdthuOJPfeiBEWgO+tiDsK6mBCCLEs
	dVBY/Jvq9zk8I/+EFsY1Nagj3Muq+bxdfGz84mvGSLzhWmGntjY2naSgfpYtPjsOkM80czjBVuP
	6Bflx5knPsjC/Bu4XOmDtXwyq9OcUVsXQoaU89tOWCKkNzt254+UkRAhBmzFxWBB+h7KHBM+C1/
	Rsy6U1Bi2BnQuG0d2q9OeytFWFNuBGO7/2g5SdkoHrytvonNA5tdoobJxTl16zu7NODWPIY58fF
	JOMOM8TkMSFEFGbyAcsXzMAFurFS0bfAQMtPAdkz4YZCb207Wi0lwpkAseia1A2QVVZaPiOjzRM
	6uSGNUX+NNJ12PmxDEomGPdxTfz3wfyopnMI/F5n8chyrtua/JTxt2oAxFxhq7LmoRCZVmbCuiD
	pDoHWyzgYcjCWhDqOz2DiqyPaCECdllJrVuJmeYrB4o/CJzLc2u1Ilxwq31I1mVOBMjmgwNdKIN
	6FWnuxo=
X-Received: by 2002:a05:7023:a8b:b0:143:72b1:9004 with SMTP id a92af1059eb24-190a87a3b70mr819537c88.45.1792546584157;
        Tue, 20 Oct 2026 18:36:24 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903a275026sm2991870c88.5.2026.10.20.18.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 18:36:23 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: willy@infradead.org,
	jack@suse.cz
Cc: akpm@linux-foundation.org,
	shr@devkernel.io,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] mm/page-writeback: avoid 32-bit overflow in dirty threshold shares
Date: Wed, 21 Oct 2026 01:30:46 +0000
Message-ID: <20261021013046.23997-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The ratios used by __wb_calc_thresh() are scaled to parts per million,
but the threshold and ratio operands are unsigned long. On 32-bit
kernels, their multiplication can wrap before the result is assigned
to u64.

For example, with a threshold of 25600 pages and the default maximum
ratio of 1000000, wb_max_thresh becomes 4125 pages instead of 25600.
The shared threshold and minimum share calculations can overflow in
the same way, producing incorrect per-writeback dirty limits.

Promote the threshold before each ratio multiplication and use
div_u64() to retain the existing division order and rounding.

Fixes: ae82291e9ca4 ("mm: use part per 1000000 for bdi ratios")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 mm/page-writeback.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index eeab25d6ce36..451750df8b74 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -894,13 +894,14 @@ static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc,
 	fprop_fraction_percpu(&dom->completions, dtc->wb_completions,
 			      &numerator, &denominator);
 
-	wb_thresh = (thresh * (100 * BDI_RATIO_SCALE - bdi_min_ratio)) / (100 * BDI_RATIO_SCALE);
+	wb_thresh = div_u64((u64)thresh * (100 * BDI_RATIO_SCALE - bdi_min_ratio),
+			    100 * BDI_RATIO_SCALE);
 	wb_thresh *= numerator;
 	wb_thresh = div64_ul(wb_thresh, denominator);
 
 	wb_min_max_ratio(wb, &wb_min_ratio, &wb_max_ratio);
 
-	wb_thresh += (thresh * wb_min_ratio) / (100 * BDI_RATIO_SCALE);
+	wb_thresh += div_u64((u64)thresh * wb_min_ratio, 100 * BDI_RATIO_SCALE);
 
 	/*
 	 * It's very possible that wb_thresh is close to 0 not because the
@@ -916,7 +917,7 @@ static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc,
 			wb_thresh = max(wb_thresh, (thresh - dtc->dirty) / 8);
 	}
 
-	wb_max_thresh = thresh * wb_max_ratio / (100 * BDI_RATIO_SCALE);
+	wb_max_thresh = div_u64((u64)thresh * wb_max_ratio, 100 * BDI_RATIO_SCALE);
 	if (wb_thresh > wb_max_thresh)
 		wb_thresh = wb_max_thresh;
 
-- 
2.43.0

