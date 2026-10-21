Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792562837;
	b=YqF0NRbACLvKhZwOuFoUbEc31ViZQGJwmn6BAYFr6heuKHusO/nwvvzCtEdqZlqv64xK
	 e8ga0t0RM/iVQtxg5VycIPPcOgX3n0Dv2ReUPmeRFw2wZcA4gQzYNcYI5nO04+vXqJVcs
	 04G2/WVcEjZhxLKN+m49yUg5aiZvi2A83IIBiuGGxX3I6DPDCaLaw5Aup7LCYT3pcdA+L
	 TIRah7v87cj3UOa/WEYEynP6dTyz3MLB0hPMfsH8871RRXvP1v0UYxqe9Gu5s1kL3FAxi
	 bPy0t6nMasBYXlRP0TIFMX7Cqkv/V8999JcUAqX6TGaez193bag56OoSUgJ+Eg7oLqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792562837;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fKaDERhzPbkXN7Gq1dg6sjNw7qQA/V1PTTySjHjN2d4=;
	b=WWm3/Q5UoFeVMiXn/INj2gTfBdoxsEnb9YzQi0KzoGbOCQS7EBRJf8pdLr9sogt5Uvx/
	 K312w8Sge2Q248nZHo7dqmopecASNynaJmaidHfb2usPb9VTRM4ZQVWKSf9ushGsx7c32
	 tlzaHNM2BsmWL9/vtFPKtHzVTAKR4iUFh5/LXuPwrfEPv57mZXJy0sjaNKr+6v3WsiSVG
	 HfEuGYxXvSBs3PJdNu6CccrDPR5RrzerDuRwVVyjrNFRct6Vxj9hJBqSoGvH1aAYjHjlm
	 fPZsGqgFCaOrArvwzUV5oklQpYKamRrvwpPI4AQDDUW9DaRZp0OkXmx/6MoYoQA+1VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gmPsU5A0;
	arc=none smtp.remote-ip=74.125.229.135
Received: from mail-dl2-f7.google.com (mail-dl2-f7.google.com [74.125.229.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A1360A2611
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 06:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06A1360A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gmPsU5A0
Received: by mail-dl2-f7.google.com with SMTP id a92af1059eb24-13985f8229aso340835c88.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 23:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792562836; x=1793167636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fKaDERhzPbkXN7Gq1dg6sjNw7qQA/V1PTTySjHjN2d4=;
        b=gmPsU5A0udQnjW1Kk0RVwWRDw1aGaaWBl5groR9VnSYKEnmFFRbNIZ8vk8OI+w/gFs
         OfHFHESQOQRlKcAd5c12KWmNuTupXgcf3tk0YSkkRfW3QmA3o9PFqKyGXdScEmt4AFa+
         P96V452jEG4+bTEN52okYDYh87RDYuEFt9LpDELgL9Nj36iC39moEROlZh8zVw/aXAHe
         NYD2TAKMMoRtnsFsSzTFvpT0OCvuIjJZrywmDeslm0NS15QS4RnQvPhEK+9A4gsONefN
         W25LiRMSXTSOPj5JiPA0VT7+vWNtT8qBdewth11rD/S/3diFP5RwEMIAxCKhnkbnVTSs
         3OAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792562836; x=1793167636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fKaDERhzPbkXN7Gq1dg6sjNw7qQA/V1PTTySjHjN2d4=;
        b=PHbJZO4AftACT3F6zMWkRzI5E6JFFFuSfVEA6m6cxDajfTQgvxUTYT2QaGTQU8OrGb
         wvqhxXUhF8W4lCewe0w7CPyhyf/Ohq91u+2NtMCfkm50Y8x/MbRs1hTs9HCGMwuFfihc
         2+a9w7I6gGn64rOzS6gAa192kWFBzBF+osOHECwR5P8nZpmJ+6WZO3S0OOIH80NC9Fet
         qdSIXH3ddNaPouBmn+khCe8yWyVUO3FEQit5V6Ayfj5AADNEIEGJ3vqBvna5wgpRjoUZ
         9k+UkOiA0UqDN3ZhExZhcmmXEjwrx5GPvo1pyEtpq/bRq4qAK9kiyCG/8+DBtOfD0n/B
         SGNw==
X-Forwarded-Encrypted: i=1; AKwUvByx94AQlJ8Hz9nsk9oEftQLNU1wEKHa960hTqvzEhq1y0W80sDv5+SgzFpd5khjHXzjTUQnV2U=@vger.kernel.org
X-Gm-Message-State: AFq9FYIpHr9jgbMkBrM8oJib5ZWNEVDFxCWCsk+MYQZs/FxfpWFHJGm4
	N57Bygp3D4Ee0Cm0HlDCdLX1GhiJZpCmdpPaizqBialC76U03Hoxrmop
X-Gm-Gg: AYBFou00H57xAWC5VUof4xhZDaNmM6fa6JTGCiaAzqfyqHiCZhYE904yqLSuK/RDnya
	/NPMlxbLnf6atebc3X/hJgevoV6wyX0K/0Aili0OOulVmKuwGkMZiq4SIFQLDKRVx66mTmoeLh9
	jzwL2OQrl32zQGZimLsJ0z6zRgEHP4kw4WiUShGhJX0H0MtBiiRJPqEPtBQqclFTiU9LmVZQsFO
	TgNuyNMEiqCSpFve+qrvn50nPuT2c4asNCElFifFoI6/E7FXBhqyOLyBe6629j/Huf2vtscBK/G
	onEeZxvgJ8f455rHMeyqqLHXXk+zmdzEdUtjPYG3CoDpCXO4VhC3XHTUnv81VrfzP3B3Et0485J
	qnstdfEHvmvJGjUrPhcQ+hbh2fbRmheoLK3UW1ZozOcPvc3tLjJ7rxRvTbRb4mVls69H8qEMIK5
	kOah/u1frSp4O8OuNsmGVAeumC1mn9ykZ8fHRLTyholThxr6Iu/PaKDqzCTCqo32OzXJ52GMDBL
	QrO1hJL+3odO5UZaG0+45ZuiKEv13uLCSR6EfAiPYnJaJzBPXTw0gNIGDLkiSFP3GBnJq9wGoFm
	Ci/fTTM=
X-Received: by 2002:a05:701b:2608:b0:144:c127:dd1b with SMTP id a92af1059eb24-190a7f02797mr1363525c88.39.1792562835846;
        Tue, 20 Oct 2026 23:07:15 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19035c0c9a6sm3504720c88.3.2026.10.20.23.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 23:07:15 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org,
	jack@suse.cz,
	shr@devkernel.io,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH v2] mm/page-writeback: avoid 32-bit overflow in dirty threshold shares
Date: Wed, 21 Oct 2026 06:06:54 +0000
Message-ID: <20261021060654.27855-1-dennylin0707@gmail.com>
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

Use a u64 threshold for the three ratio multiplications and div_u64()
to retain the existing division order and rounding.

Fixes: ae82291e9ca4 ("mm: use part per 1000000 for bdi ratios")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
Changes in v2:
- Use a u64 threshold variable instead of repeated casts, as suggested by
  Andrew Morton.

 mm/page-writeback.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index eeab25d6ce36..1d6aab8781a5 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -883,6 +883,7 @@ static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc,
 {
 	struct wb_domain *dom = dtc_dom(dtc);
 	struct bdi_writeback *wb = dtc->wb;
+	u64 threshold = thresh;
 	u64 wb_thresh;
 	u64 wb_max_thresh;
 	unsigned long numerator, denominator;
@@ -894,13 +895,14 @@ static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc,
 	fprop_fraction_percpu(&dom->completions, dtc->wb_completions,
 			      &numerator, &denominator);
 
-	wb_thresh = (thresh * (100 * BDI_RATIO_SCALE - bdi_min_ratio)) / (100 * BDI_RATIO_SCALE);
+	wb_thresh = div_u64(threshold * (100 * BDI_RATIO_SCALE - bdi_min_ratio),
+			    100 * BDI_RATIO_SCALE);
 	wb_thresh *= numerator;
 	wb_thresh = div64_ul(wb_thresh, denominator);
 
 	wb_min_max_ratio(wb, &wb_min_ratio, &wb_max_ratio);
 
-	wb_thresh += (thresh * wb_min_ratio) / (100 * BDI_RATIO_SCALE);
+	wb_thresh += div_u64(threshold * wb_min_ratio, 100 * BDI_RATIO_SCALE);
 
 	/*
 	 * It's very possible that wb_thresh is close to 0 not because the
@@ -916,7 +918,7 @@ static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc,
 			wb_thresh = max(wb_thresh, (thresh - dtc->dirty) / 8);
 	}
 
-	wb_max_thresh = thresh * wb_max_ratio / (100 * BDI_RATIO_SCALE);
+	wb_max_thresh = div_u64(threshold * wb_max_ratio, 100 * BDI_RATIO_SCALE);
 	if (wb_thresh > wb_max_thresh)
 		wb_thresh = wb_max_thresh;
 
-- 
2.43.0

