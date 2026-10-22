Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792687299;
	b=2Ue929o/H/MCeOXzXZOnjyPZHduVk3ypsW3TlTFrIqrTsOgB+CpKssnK5k3n4r7j1ZFC
	 DB1nE2Hx1jbz0+yaPu4T5/ajazoWPLQ/xewi2SrJJWQ2YuK6a1tVSIqvrBlKFD/3cU4li
	 m07KmZd5pHtMzDEmOcgeiXsHZay6za1rMIR3euACFINBspAYqZ2I3ckUwwRdooNmWQ907
	 br6dWy6fYxAkm9j4sV7c7WMAjIYah515Wxi8B9wTrNlyC9Hz9JkrLOAqoBGVT3QvmRVve
	 fpGviXZgoZRpeXBExuAcFqdy13niATocWBbRmy6RNoiGEhc2qOUzery9HFejZQ59/Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792687299;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=L5gpcAyhzAcYS4mCGlD4C+brljL9UYG+ePFjh70n9DQ=;
	b=ID2xAzsKVGFVAjdqkzgd6JtwTidomm6EBrGP5yHh5xvkgu7tKN85oZuSRXsagF6gZU9e
	 d09HnbmnYM9AcRtaQMkSrDb8LpNFTcFFHjzktwVUjMAO2Cb4X/enD68oUMykZa0M0QNtG
	 zawFn6CJjasQF3/BUL6aGh4rW/5L5b+yHdE9hZc34qArOF+YIgxIW4s5IwqalPV20+hdL
	 q5dDgukT91y7q2oRtrN+LIZltrTIsk7jxvoO0VmeUGCTFwiYmj3a5VyFufcCVyOVWhSsD
	 ygVrfMrhQT+Yc5UFyTe6uZohZ44ByTI5bvABqXT1cEUwU7Ir4NpdbtpMNNCH3D9WZeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l+r0axuG;
	arc=none smtp.remote-ip=209.85.160.53
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA22606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 16:41:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EA22606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l+r0axuG
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-483c607ccb4so26225fac.0
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 09:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792687298; x=1793292098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L5gpcAyhzAcYS4mCGlD4C+brljL9UYG+ePFjh70n9DQ=;
        b=l+r0axuGh7AU/VGkJzgVoRn+Nad5h6OlJns3TUBtSfHlwjYtfVU871/OsswkGyXCej
         uOIUm4EwVwNpzU34BsHxCi9P/hjeGIYsW6lF9sPLmLgBN7tyiKyjCTuRCtrJLx2ZU2iR
         26S8VQvq6+d+78CJSXhsyZi0DYqvzmPgFGwJ8kRdxkaqKtGn2wAMyX0usjjfxgd3J3A6
         i8Qz0D76fkEmLiKehMBMtF3G3W5fZwJ4Ja48kBW2VjOqP3isZ2W2dRyFioaD0RZDcYDK
         xTjcKZf+tLN/F/dr7fKZn0PbLSgLMW1AEiEmk+V0GOrZvNo9DWNqM2FjopRv0VyuTly7
         9cJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792687298; x=1793292098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L5gpcAyhzAcYS4mCGlD4C+brljL9UYG+ePFjh70n9DQ=;
        b=rYbQhVPbo5Qy4Z28F/6ugbUfRHR4qyID5zGwVNKZs0cKMeQXzAGYrHJWCRt0iB4yVT
         iKlma651rAphpVmnM3aF0/pWNSdx6pBpGHBsDJ1KbHd/xoqzif/yxJyjeWF+S9kh7kZm
         lfxc3uzZ2hvdxCA7QE9g2zHpEgcG0n7BvgHq8u800k5/DGQVRJaqBgaLs0njNwjIXNb/
         JsHAqUsy2fPVHfyKaQCHK3U0b1comedwmK+c6FljXkR/xj8QBIcufQMEBp6XN8mf9rry
         dxD/yBQ0tzjJK9FrRaG4nwOg5IYcnYaw4QGVaoidzmg6yDKYlPQLAg7UTWYBoDpBxMkq
         Qznw==
X-Forwarded-Encrypted: i=1; AKwUvBx+YDhWDj4UqijQ2NCj5DorPfV71dBeqqUw1BXGxGpA5SjHiNyFesgSbukO8rsR4t7uftNHQo8=@vger.kernel.org
X-Gm-Message-State: AFq9FYI1eHL6bkXXDe+VSE5RaLeUrEG2Fjs2DdkIQYn73cCEMDRjo++z
	2trwSaz/ZuI3k85+8dungT7x9l0WCnkW7s7jMhkes25zAT7QD2oZSAOr3o67ZQ==
X-Gm-Gg: AYBFou3FOa8FR264axclxj7K6PLqQ1pE9p6MRat/QCUGS9db37/h3qC0hGkJP5GQcgQ
	vbcXLAOoasYL7/3DYv3G5RgZzbeR4AJVEpQYFUs8WH2EeMiEYkV2G9xZmuPNYflyLPSqlefx6eQ
	bZQ/mTg3aqfgNXcZAIDvxA5s1hN4iyziy4qZtJavs6IRNPDbdmxnuFznXugr69zOdaA3hwOsC+h
	ok6CYkPFz61grIUsdO63H9vvbl6/yuhWFrumqfuO5zgYC6tngrPgHvy7jpMOlcRSu5MvU8v+R9+
	ycyCBO2i2sUchDioX62w+KD3Uj6k5U4bpWlMiVwZjM/lD5OXhsnSfFLNSbj5HyZx/OECJg/H3E/
	F9ne7TjraK3nO+UFQISepmJK4KlsuvLthFGJ5nUUzqGT9dsznl9WT+ba1MZRO24AUJaq9bf1tfC
	Os7vsSKIBjv920wVPpBl6U/NRMF9KTgpMMDGuaTMf23mhzcnQR8YHjGLmVJPriXv710RVFmdkGb
	tMGtKrNmZhTsbTetk1JNsPJ8jo31YosqszBnrHa0nKfhc6uDuvYpoRjlsrQOjIcDC5SbA==
X-Received: by 2002:a05:6870:ac06:b0:4a7:4b64:3818 with SMTP id 586e51a60fabf-4a7dc21864fmr3629103fac.39.1792687298482;
        Thu, 22 Oct 2026 09:41:38 -0700 (PDT)
Received: from localhost.localdomain ([192.63.62.92])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a7d5b32f87sm4973475fac.0.2026.10.22.09.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 09:41:38 -0700 (PDT)
From: Jorge Mora <jmora1300@gmail.com>
X-Google-Original-From: Jorge Mora <mora@netapp.com>
To: Jorge.Mora@netapp.com
Cc: jorge_luis_mora@yahoo.com,
	Jorge Mora <mora@netapp.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] NFSv4/flexfiles: calculate stripe boundaries from the file offset
Date: Thu, 22 Oct 2026 10:40:45 -0600
Message-Id: <20261022164046.38079-2-mora@netapp.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20261022164046.38079-1-mora@netapp.com>
References: <20261022164046.38079-1-mora@netapp.com>
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

ff_layout_pg_test() subtracted the layout segment offset when splitting
I/O across stripes. Device selection in nfs4_ff_layout_calc_dss_id()
uses the absolute file offset, which is also how RFC 8435 sparse
layouts number stripes.

A LAYOUTGET reply that starts off a stripe boundary therefore moves the
clipping point while the data server is still chosen from the file
offset. After a data-server error, a direct write that crosses a stripe
is joined and resent past the real boundary, and a later read of that
range is not split.

Clip with the same file offset used to select the data server. The
segment offset remains the covered byte range; pnfs_generic_pg_test()
already limits coalescing to that range.

Fixes: 4934ccbeaed3 ("NFSv4/flexfiles: Read path updates for striped layouts")
Cc: stable@vger.kernel.org

Signed-off-by: Jorge Mora <mora@netapp.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 7fe8b91fa..09d44de26 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -996,7 +996,6 @@ ff_layout_pg_test(struct nfs_pageio_descriptor *pgio, struct nfs_page *prev,
 	unsigned int size;
 	u64 p_stripe, r_stripe;
 	u32 stripe_offset;
-	u64 segment_offset = pgio->pg_lseg->pls_range.offset;
 	u32 stripe_unit = FF_LAYOUT_LSEG(pgio->pg_lseg)->stripe_unit;
 
 	/* calls nfs_generic_pg_test */
@@ -1006,10 +1005,17 @@ ff_layout_pg_test(struct nfs_pageio_descriptor *pgio, struct nfs_page *prev,
 	else if (!ff_layout_lseg_is_striped(FF_LAYOUT_LSEG(pgio->pg_lseg)))
 		return size;
 
-	/* see if req and prev are in the same stripe */
+	/*
+	 * Sparse flexfiles stripes by logical file offset, the same value
+	 * nfs4_ff_layout_calc_dss_id() uses to choose a data server. The
+	 * layout segment offset is only the covered byte range.
+	 * pnfs_generic_pg_test() already stops coalescing at the end of it.
+	 * Subtracting that offset here shifts the stripe phase whenever a
+	 * LAYOUTGET reply starts off a stripe boundary.
+	 */
 	if (prev) {
-		p_stripe = (u64)req_offset(prev) - segment_offset;
-		r_stripe = (u64)req_offset(req) - segment_offset;
+		p_stripe = req_offset(prev);
+		r_stripe = req_offset(req);
 		do_div(p_stripe, stripe_unit);
 		do_div(r_stripe, stripe_unit);
 
@@ -1018,9 +1024,7 @@ ff_layout_pg_test(struct nfs_pageio_descriptor *pgio, struct nfs_page *prev,
 	}
 
 	/* calculate remaining bytes in the current stripe */
-	div_u64_rem((u64)req_offset(req) - segment_offset,
-			stripe_unit,
-			&stripe_offset);
+	div_u64_rem(req_offset(req), stripe_unit, &stripe_offset);
 	WARN_ON_ONCE(stripe_offset > stripe_unit);
 	if (stripe_offset >= stripe_unit)
 		return 0;
-- 
2.52.0

