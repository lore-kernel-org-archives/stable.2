Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793234987;
	b=WmzwdGDs750gp9IdlixMQS5c8WoFM3/lVaXpjLKJdV1QlYtc8MSoMlaFJsHQvY999klZ
	 XuKGNYXzyqPCLdcpAxp8w9yGObqJvA043N3SxoWaEz6Qfk4TIc6EircqFOLnfZnhDENiS
	 d1Fx4Gavu/lM+ean5yDK/LkBSmPMUuysLTeTkoXw1UZ3TA1vU7Al8H9fazCod5fG+3vfO
	 5L8NvfqSq9RFP7U/g2HOY27da4g9iMhbN8aoE9eI2RpHTZtiJKgqqJi+/5PkOM/8ICVhc
	 4incfA5GXFl69ADXViNmOsd5T1+8Ft0Hl+kzXSYVAYjyn/cSuTWAk5aEvQpwlhmgJNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793234987;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ln037Pf3YbKMICLinA76e7sVprd2bC8Oq7bCHhU7/t4=;
	b=A73Pap+BNwWuKGY/mJuhpM5ODTJBi10vKD4T3tykTHz4pOPfHhv3H5cbhsh9tsuZVeoh
	 lsP+Z1GypXfage37JZtrQ/9EJvECIJVlNHYE0zfEZkhsPL79tN8oXOaUsL82nRryXD7Hr
	 uXKSZuHy1YpyTuKYMhdTni3MM8mGodwJKYKxRB/72bjiXsVJ6wGnoZwcOL1QayWo4lwiQ
	 bEAI/dNFVFt7t3XJ82AU8RRa+YcJ80er53muJaLtXQ2cKnbu02VmLfYZxfRvOmPUiTFb8
	 nnf1wdGajp12/2OECTeDP3Jy+yt++0ZY5sf7ht0JZ4EedarGaE4e1DAARCEQw1GpDTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oNxVS+EB;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6CC606A31C
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 00:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B6CC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oNxVS+EB
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-36888ae05e7so485460eec.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 17:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793234986; x=1793839786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ln037Pf3YbKMICLinA76e7sVprd2bC8Oq7bCHhU7/t4=;
        b=oNxVS+EBLQTXgN9ZgA9vhh/UjS0dd/L1o2EJbRCC6paxeQ1iJpTs7nACX0fUu5MJBB
         CcT5+ty6Viq2+DD1q51ZxYnAWGCRTpVMo/cfWF9TMjBy7xlYAQ2xE+oqlnkh0PHiyDfu
         UpbnY25WeXn8awtDp6O2fY8hp8vEwv+sfckLii7jjTw5sqTQdUW84iK2Posnxr3pXgMn
         BjTJX450ZUXQVfO1JEn+MiYalrtfc6BXBEYsthV7S0QGrtP8aUgkXfi9CIvuLQwtcQkS
         0p5Sw91IuSnqvKlawWbKVhNz9nWgvdY831aucFWtQ0/yyKG8EuzMr1xRxC817atMmMKo
         JBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793234986; x=1793839786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ln037Pf3YbKMICLinA76e7sVprd2bC8Oq7bCHhU7/t4=;
        b=evafapRqUECV4FHcGzSTtkS7LpvYpJuDyUCthYulyHqTz/u8icXgxwOAna+hBbApA1
         T3DtfxiKxI20T2bECuhPnu0Q4YBCA8iv4iFhX7tZfJUGFjLIEuzQ6ahrbcdE3p2lAW34
         PB82190obEOeXr0TTFopWmhvQF6Ef/7LcM5s/LkGB6bqhBAbJJPFCy8Jk83ggoznw3Wn
         Ok6jlIPeZYr2zXhEX55s0pMYX8Frq7UQOnHphGd9UIxYOegX0MZyAzKs7GLQabAHNo/m
         g5jZU0DC8HF7t6hl5r0iycGFUYbq1apCV5jF7lYvzkl7eBx1z2amSEVkZKRpwfavoJx+
         4Utg==
X-Forwarded-Encrypted: i=1; AKwUvBxHaYv9SQan25e0BBLpPO4OtOWjp6PxziGtDr3wSDT22b6xHVa23RvhO3uhwMKsCtZsJEZkhbk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJHafLlyDRgSN9oRcqbCtmj+WnfDPhCWXt5dR4E5c42MKoiB9No
	pla1o4BP12Ufo3bq6Zo4ifzBdKsusFFDwmYVE3ycPRrKwsPF4xR2jyYa5Q2R+mma
X-Gm-Gg: AYBFou3DNbkTmKjSNDfH38nRnIYnvHljnbR2TsBQoBLVxbhw6PCVMojB0qn7/2oEIe0
	91VtgKE+89ljcAHwKF7gqZcyTM6piHqTqpzyXDJHOgTfw5PU7buYH11zwGF7Ms0TFrbx+/Z+ece
	VVA7LoI3rbzY9B2Yy9YQeOHBkoHcgDQWK+aychDvzeoA4EIFVi36zP6jklp1Fhyyr+CuhYD4/Yv
	/IGRAfHNHqvz5HbZsw+ArDbXfswkzyVXmQWLJHuVtk7WCZaMFifnjRLMnVAsjKJwf1P7Y0iFRd0
	uFYrdXjZoZ8xkEwOiwjXCbYLOkditbecrd6ks/f8XgI/b+sQDB9aLqrbus+b2iv9x1bhb4mW8/G
	l5ZsxrOJ6ggjqaMYydPWSLXjrf3d1gjkVvi6mkosZSKcP+LtdvM76rVYUkHaKo3WTh7RwRVF1A+
	GXTusdzg+zMUfNPkbVJkm2eg+VzhADCDnScObQyQ8gA3XDtplK8Sd88iwsQIvv3d0qfANaVIIxF
	co7PYveQHQxs+lClq8d2o3DbuwQBkHCbAHvX1rJ5Qg+a71Wf4lup20sBefCsNNGSRutj8lP8c98
	OaLeJc/d+zXv+wbwCvS9IBxeBPenjsBjDkmUl7q0o6Do+btmEfASatXG
X-Received: by 2002:a05:7300:d101:b0:369:5583:bf4c with SMTP id 5a478bee46e88-36a200c8c63mr4761503eec.28.1793234986083;
        Wed, 28 Oct 2026 17:49:46 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a2399b05dsm11195789eec.25.2026.10.28.17.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 17:49:44 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: jack@suse.cz
Cc: sortie@maxsi.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH] isofs: handle Rock Ridge long-form dates before 1900
Date: Thu, 29 Oct 2026 00:49:02 +0000
Message-ID: <20261029004902.76944-1-dennylin0707@gmail.com>
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

iso_date() stores the year relative to 1900 and rejects negative values.
Rock Ridge LONG_FORM timestamps encode calendar years from 1 to 9999,
so valid years before 1900 are returned as seconds since the Unix epoch
equal to zero instead of their recorded dates. For example, an 1899
timestamp on an image produced by xorriso is reported as 1970 by stat,
and cp -p preserves that incorrect time.

Use the calendar year for both timestamp formats and pass it directly
to mktime64(). Keep the epoch fallback for year zero, while allowing
valid long-form years before 1900. Short-form dates are unchanged.

Fixes: 5ea45f54c8d6 ("isofs: fix Y2038 and Y2156 issues in Rock Ridge TF entry")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/isofs/util.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/isofs/util.c b/fs/isofs/util.c
index 42f479da0b28..6f9a90e58a89 100644
--- a/fs/isofs/util.c
+++ b/fs/isofs/util.c
@@ -25,7 +25,7 @@ struct timespec64 iso_date(u8 *p, int flags)
 		year = (p[0] - '0') * 1000 +
 		       (p[1] - '0') * 100 +
 		       (p[2] - '0') * 10 +
-		       (p[3] - '0') - 1900;
+		       (p[3] - '0');
 		month = ((p[4] - '0') * 10 + (p[5] - '0'));
 		day = ((p[6] - '0') * 10 + (p[7] - '0'));
 		hour = ((p[8] - '0') * 10 + (p[9] - '0'));
@@ -34,7 +34,7 @@ struct timespec64 iso_date(u8 *p, int flags)
 		ts.tv_nsec = ((p[14] - '0') * 10 + (p[15] - '0')) * 10000000;
 		tz = p[16];
 	} else {
-		year = p[0];
+		year = p[0] + 1900;
 		month = p[1];
 		day = p[2];
 		hour = p[3];
@@ -45,10 +45,10 @@ struct timespec64 iso_date(u8 *p, int flags)
 		tz = flags & ISO_DATE_HIGH_SIERRA ? 0 : p[6];
 	}
 
-	if (year < 0) {
+	if (year < 1) {
 		ts.tv_sec = 0;
 	} else {
-		ts.tv_sec = mktime64(year+1900, month, day, hour, minute, second);
+		ts.tv_sec = mktime64(year, month, day, hour, minute, second);
 
 		/* sign extend */
 		if (tz & 0x80)
-- 
2.43.0

