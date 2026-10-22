Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792687724;
	b=1mTEL5wxT5qiFtj+sZ5fa/N6PiZ7/tiGAcaTyDsLMPqdc2lc0lbNesqtle+f+rRPV8wX
	 ayM3oXZxgsyN4EkDYA39a2bjByau8aFLGAXDTa2d7JduMmwt0PRHo2kLBuNWaJqt7sf0J
	 1IzPHeUKPSrdz5VbfpcEiAKzo/sag7Pe3fI/andTnz/GbeQLASxTp7fgjaBA6qPcTmb4k
	 PVcyY2JJ913NYdj4PDfxSUjKn8FbmeCqZ7UkFy667T4ZvNAVQVRgzJqDufmn17xR/xpI/
	 oXu4Z3rJMrbKNIXid8vDMTgvm5HwRT1r7FUiQqCK9097U9Q+4U65V2NkxlzBnJjWkXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792687724;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=L5gpcAyhzAcYS4mCGlD4C+brljL9UYG+ePFjh70n9DQ=;
	b=uITL5uppQwTRJOCGrLeuq/oUvFz3AocqlTW/KNqh3AzUjxLbtct3eGdILU5O4uOu6fdG
	 7mhmRH74GgWYxMmMXud890w0bKwFuISapG8jqVvq7NLor6slXR9ToD+ogb2a4KOt4t4u5
	 rK8fXuC80GDoMOX4amgFza06gqDcnexT+jUwbN1+p/432mA6ryy9j2mMpB9kokxyGfr1T
	 IXyv3ojOJPOJdzdkNk4AbA1RXESGcKLSqadXzYSYMI6y0TBjLZXZrAzrwmcCrFAcbirff
	 JDmtiIHuV6SY8YNvD3L3KuxzsYVr6IHU3Dj8Nc7qSqkooK5/O+A0ITQGSphA/i2Al1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XKqWfPwQ;
	arc=none smtp.remote-ip=209.85.160.43
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC39D606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 16:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC39D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XKqWfPwQ
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-48ed188ee81so26026fac.1
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 09:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792687723; x=1793292523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L5gpcAyhzAcYS4mCGlD4C+brljL9UYG+ePFjh70n9DQ=;
        b=XKqWfPwQwhBLd0T/rRASHp9ltDnZA96tszZHsqD7eFQFA4W54ukwqFDr/7tUSTyDHP
         MAa9jYh5KknLWSBzuMv9GxaNeKQaUmhi/zo9yu8ivwF5KWvilBORwW66A+PjljTLhhMV
         VbC/RVQYlTfMC47M18mJCS794RCXJwkJKniepbbfS9nYQolNPKmoDElhhX8ae+62p7lf
         n/rMEbn1DHQNYJe2DNZbDwTsAKplaTFwvSSyn/5lYUX8mVNPx8c/LrboRpcbVv91Dzav
         jHpWM4raIz+CMc9ItTcHJfHAtKeLuapABX/RXa5OLgb3XAt0025/Bh9z2GXVS+XwOhKp
         LhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792687723; x=1793292523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L5gpcAyhzAcYS4mCGlD4C+brljL9UYG+ePFjh70n9DQ=;
        b=h0Q9Yk5i3Zt5ZHk1DJbe3KOUxzgXq43cnWkYSkT/EO8OYFZIv3Y48bi17REDbMkh3N
         pj2zdzT/d6MiFQI+YM2YvTHiHtjLUG5QjyTVfH2mf/gNISK/wPZDG9ioS4L3Errbs3NA
         ULABPj8Elhu4QzEkZOJ+H3cX81zGGFcT+tw625UJ4rQT3kpkWbJatnaV6ifhBqKjknzz
         w84+Mr8DMmK1/ZeNvkSMpGPSZSPkDy6CQzmaYWFfPwXiOEaYMgVXS/hIXcJxVCKYn2BS
         P/TAiWIlFI5dKfQI47i+hJgPAfES1cSDSjNVNAQ5gkp4TMWpygHLKAFkpMIRsxLbaa2D
         bDOw==
X-Forwarded-Encrypted: i=1; AKwUvBzMMueJFE8EQOIeCSv12bPGVjoDnUm/TuRoKuJexBhPRugoEpJlda60ueDUoAsTKKkUvJ2UHTU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIyiYei7GAISOQR8nbQBFarSq7peGAaleO99+xB3KyXnPYVo3n1
	Ox6kGkJp4E7MGXeWrYcG0TrhIdWo8kh0uYCd0VZu7POGODmX0kicY9K+
X-Gm-Gg: AYBFou3Xqn+52p8dXrV24GFlazYrvHCJbsDS2KExXSH/XdGb4OCGxAQvkz3WTYbSpWF
	+eyZFVpfJ9fQkA4SN5EHVd3l3Q05bUyehMPQJd0cjHKaLG2mPIHbnbDv7b5rk+rURC0tgL6XfUi
	1GfzhUs1frEuLZOrUdyNa6Gu1dn2v0M+ZXslKe9fetjpbZVBQJbROMF3sTXHQa+F7uMcg4ni7J2
	OOljWMIUy5RsT+eXiNFQs6Zy/n4FMqYY4rGbfquwr5sjWpMNpFTrJ4c234XbQ3jsmTIjSQIslxO
	VRzLOYIODYRTc446R6E+bHs2a6BcBiO8pXtFBbNuA1SA6ETs2//f6i2Jtg2bGd4pJaEU0KtJMCK
	9CWNk7KZRuwlEaJcExNZCMTMF4DkqzJwouQpOH5nlCGZVy9WDFzaBlHrw7gbhEVRzxzKenp08tI
	nN7nCXdTbXlLpKPVjuCbr+QJPwXKhGPk2m9ri+ZkMZY9x9yjJqlWUWIWTlz7W8CFOOMP4I+AZlV
	yY16w0wrBzMlm6bYLmDqABK8/lifVY9SwSJa/D9ATzCwyz2rLTdhUpipq9Ahr6VjmaQ5g==
X-Received: by 2002:a05:6871:d205:b0:49d:ff8c:2070 with SMTP id 586e51a60fabf-4a7dc2d1b0bmr3362636fac.62.1792687722878;
        Thu, 22 Oct 2026 09:48:42 -0700 (PDT)
Received: from localhost.localdomain ([192.63.62.92])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a7d616e848sm4937676fac.7.2026.10.22.09.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 09:48:42 -0700 (PDT)
From: Jorge Mora <jmora1300@gmail.com>
X-Google-Original-From: Jorge Mora <mora@netapp.com>
To: Jorge.Mora@netapp.com,
	jorge_luis_mora@yahoo.com
Cc: Jorge Mora <mora@netapp.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] NFSv4/flexfiles: calculate stripe boundaries from the file offset
Date: Thu, 22 Oct 2026 10:48:25 -0600
Message-Id: <20261022164826.38125-2-mora@netapp.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20261022164826.38125-1-mora@netapp.com>
References: <20261022164826.38125-1-mora@netapp.com>
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

