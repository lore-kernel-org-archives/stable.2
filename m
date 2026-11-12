Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794472636;
	b=X0B5okfexxYYrynpNkeFVW+1C+H+hOXqFqeRadOgSwBdGu85U6nmqzUt9IyKlA8KGtua
	 nn1zAiBYGU9UpmeZMzzpS9JhMAgEeQhJnCk66/diZoBMvSIOo9GQX0Ih3+5RVwjdpe3fj
	 7ttCoUiBA2naefnJzvNLY4HF4/r5roR96JCnx235JI7YkkGqDUI4IeKx/JOtFj/tFjTLv
	 H8XBjLZ9T1v9njtjgeq/TCCVsOddCbP1v9ZrGM3xMCEn4hFjvClZXro2SCI0SWhPffXdB
	 ChXuXXjuqD41QycUi8Nj8KfDjM69Ym7CrtU3lT+UxfbasNIZTx2p8k6z0rad1x1jdBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472636;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1cqJMqiYh3ZDxGV/uWvnHrhrCXMJfrson8qGIeROivU=;
	b=mR32DCDzHlD+/WRN3DD1FAlYq8qGqdBavItjRVrQZ17kcvl/ArZ4ywVos04o0kKoHVcZ
	 RpGr7zF/vDdnuAdIgvY/tif0GLMMAuG/loRLGvi7x4DvLGkwAyy2giamyFk8svyq0tnmi
	 aJa4qQnnnUPGkUiQZoE4GDIUw2UVqqnK3sJ75p8bdMdpYQujyUbiwvRUyya6UctsYijMZ
	 EP1qLm+lBMK9OyP+yIMhEzE3y54jfqr8cCEmPwDGLZX6KMTel5HSASePnBWYyDFUkFNVS
	 7iSuKnNvbnhex0jocgj4b9/IwdOWmb2CU1kzEzf8ZQb38oohn6BXqhCJZwv9j1iqR4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oNJbDAfL;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD67606A32A
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 08:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BD67606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oNJbDAfL
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-377f12217c7so727193eec.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 00:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794472635; x=1795077435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1cqJMqiYh3ZDxGV/uWvnHrhrCXMJfrson8qGIeROivU=;
        b=oNJbDAfLQKrR7NvApuc8pq6nqEMGjbc9CyiAFb3pBndsFjEUD2UiNMowdezJldb/Lc
         T/wAiAPOvd7e+9Br147SxO/x4tvpXdJeQwaMPk7Y82NqsuPJuAiU3kcIQGbwSO/IcvZY
         GkIcQssXTkiPeTV151GQIW3YATOhXIBJ+qFXQfxYdrm798/4TUfXBPwJewK1v0k7r258
         1Diyy2kfAkxTx9QgfGMjISxEshQphdhQpoFP6trc7fYsP6mqTTxqYCzx2bxnT3Q9Eqyq
         z/se2tQKPnYOySjCiuUwAhAx6OrQ0IOs9hFF4YAwenQ/m8zFBia8SBJ5WQBOUXnqBLIE
         HKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794472635; x=1795077435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1cqJMqiYh3ZDxGV/uWvnHrhrCXMJfrson8qGIeROivU=;
        b=HtnKu4tNd7R2RYAUMZbuOXvNPqLwNAIROEvruuWJqvbaIRzuaFx9IPcB72tLEtIrUK
         yM1sOcKR0EDkXw+nbf/LalkK9H6YOkNxAkQ4snxpt0DmrcrKiSdEmWbaypmo0Qv0o/oN
         4BgcheLN09o0A7D/5rYVaJ3s7DabkRqbUmm9sm90wE2YUgZ9hHtMcPh7VDURZAP6bFKU
         tlfuVDIDzTcnAzuEemKhfx9FxHJ8dJqZ0uZGOu+ELlc5c9tCMu2Sjh/5yj/z6/h2P4au
         YiTIJfEVP+0S4ovG1sPAcaLkE5j2k9ndlAPmcv/yDGhrYUgn+OboCAX8KsMXpJXL4ePw
         q7mw==
X-Gm-Message-State: APuU4Z/BnVugXHaTJoiN22p6LZcCznkweEzv8v8yxsscXuGeyRocyzRK
	ODbGTDLWUqTbuW60cTWJMywAaLNFX6HSQ4ZVw8N1sDByi/RUDdlud5clKn3SDmzcAEB94A==
X-Gm-Gg: AYBFou2NL6WxMUWvxr0oEFVyZyds5flbgLCEq0qpV8YkW9aofu4L66A3iUqPwx0J2ko
	B6O6OSmaN9sb8AVB9EjRljs7DcbJZ+zbDpPaw302sDSwBHpdpaLIiIiZdqj/8NLwsKgcnmExXEV
	dQKIcDJ/1bHp3Jb0zlk0NN4eHZ8F9His/fB1V4IsmQ9Nr2u51BozP4hDt53fz3lnJayySN2y7g2
	/bxamrCH4ePoI2mujyvDpim6I1WFKNeK4qwCgC+oXq4JSL8YeI7Ub0T43rWJa5r4bwa0bV1+Bae
	vO8OeKJ9RmdJlBudeJKibGxLILeTd4qF8uBaL1Si5pZg244W7SJ0E/ElfmJJyt90YmhInM6PInv
	Dwy98p4b0LcTajFMp4+7mWcNQQdGujYmy5ZJvzAzqlTJwj8Aww3tdscU298eyEAgL/QOwd73q+o
	g5Nk9JcN/Cf7n9L2gn87apYL8imLcRv4L192mkTnkTPQt5jWQQUDRtj4jd2FERM+ufAqqEZ0+Sn
	XKfy3wgYGYvpa/uwBve6jgzHxzjB+M52O76bf44cW1zREbkKJQ8knA8fnwBGYpetiV0/kWCCGZj
	WX4GVWmLnjdIntmkY28CVgFrPd7A07jsGI7UVSX3YwcOfzN6B4gzOQg294b32g5skl5j+b8svhl
	EaFA+dZE0p8TDAzqXwAn3PdM1pl3dWUacfB7mLQ==
X-Received: by 2002:a05:7301:2424:b0:36a:21b8:b6c4 with SMTP id 5a478bee46e88-376851ce3acmr5592229eec.8.1794472635204;
        Thu, 12 Nov 2026 00:37:15 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375218c7c50sm45321151eec.29.2026.11.12.00.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 00:37:14 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jan Kara <jack@suse.cz>,
	Gregory Price <gourry@gourry.net>,
	Matthew Wilcox <willy@infradead.org>,
	Stefan Roesch <shr@devkernel.io>
Subject: [PATCH 6.12.y] mm/page-writeback: avoid 32-bit overflow in dirty threshold shares
Date: Thu, 12 Nov 2026 08:37:05 +0000
Message-ID: <20261112083705.6165-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109200742-failed-6.12-9597c2056e05@kernel.org>
References: <20261109200742-failed-6.12-9597c2056e05@kernel.org>
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

[ Upstream commit 9597c2056e05bd79df9d343a9b42e84a54de1c52 ]

The ratios used by __wb_calc_thresh() are scaled to parts per million, but
the threshold and ratio operands are unsigned long.  On 32-bit kernels,
their multiplication can wrap before the result is assigned to u64.

For example, with a threshold of 25600 pages and the default maximum ratio
of 1000000, wb_max_thresh becomes 4125 pages instead of 25600.  The shared
threshold and minimum share calculations can overflow in the same way,
producing incorrect per-writeback dirty limits.

Use a u64 threshold for the three ratio multiplications and div_u64() to
retain the existing division order and rounding.

In 6.12, __wb_calc_thresh() has no freerun adjustment here. Widen the
threshold for the ratio calculations and compute the maximum share once
for the existing clamp.

Link: https://lore.kernel.org/20261021060654.27855-1-dennylin0707@gmail.com
Fixes: ae82291e9ca4 ("mm: use part per 1000000 for bdi ratios")
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Stefan Roesch <shr@devkernel.io>
Cc: <stable@vger.kernel.org>
---
 mm/page-writeback.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index bfb3f90..89b2e4a 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -917,7 +917,9 @@ static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc,
 				      unsigned long thresh)
 {
 	struct wb_domain *dom = dtc_dom(dtc);
+	u64 threshold = thresh;
 	u64 wb_thresh;
+	u64 wb_max_thresh;
 	unsigned long numerator, denominator;
 	unsigned long wb_min_ratio, wb_max_ratio;
 
@@ -927,15 +929,17 @@ static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc,
 	fprop_fraction_percpu(&dom->completions, dtc->wb_completions,
 			      &numerator, &denominator);
 
-	wb_thresh = (thresh * (100 * BDI_RATIO_SCALE - bdi_min_ratio)) / (100 * BDI_RATIO_SCALE);
+	wb_thresh = div_u64(threshold * (100 * BDI_RATIO_SCALE - bdi_min_ratio),
+			    100 * BDI_RATIO_SCALE);
 	wb_thresh *= numerator;
 	wb_thresh = div64_ul(wb_thresh, denominator);
 
 	wb_min_max_ratio(dtc->wb, &wb_min_ratio, &wb_max_ratio);
 
-	wb_thresh += (thresh * wb_min_ratio) / (100 * BDI_RATIO_SCALE);
-	if (wb_thresh > (thresh * wb_max_ratio) / (100 * BDI_RATIO_SCALE))
-		wb_thresh = thresh * wb_max_ratio / (100 * BDI_RATIO_SCALE);
+	wb_thresh += div_u64(threshold * wb_min_ratio, 100 * BDI_RATIO_SCALE);
+	wb_max_thresh = div_u64(threshold * wb_max_ratio, 100 * BDI_RATIO_SCALE);
+	if (wb_thresh > wb_max_thresh)
+		wb_thresh = wb_max_thresh;
 
 	return wb_thresh;
 }
-- 
2.50.1 (Apple Git-155)

