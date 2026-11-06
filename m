Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981080;
	b=t4qX+0V9WmlaYreHwQmEy/G840+cNr2AXbToQarqlKW1wkwGFVfmawoISfzXYpOe56em
	 zcZ/COGmiGa/UKdipJPaRziI4bzZSRwntc100fn3eR6jOvVi2o84WJMbXYuStxdfPXOXO
	 alxpuCYuM0jJq0IrRcY3kDxwD1IcSCu7HD4eSqawjqxbGM+K4hN1VT1age1Gr7XJkVQ7y
	 nME9sHrI+K13juxxN5U/zZTdSXijlpXhik1wKTdhLABOApTLUaaeTF0x+IXMYSeK5dPcB
	 vGJgnBY/qNBiBallMMxVUejK329uIkokNDytvQQW7kTPnQrAyXX2Osd9VV137X7uqYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981080;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jrPqOBbmQTC7cKWIEZPDDl/+MmJimjcBhJLEmrI30vM=;
	b=TvGTEOWApfZxgGLgVeej36YJRczBeV9EzMpnkCnt1Ctggd7DDHQvvZAH8PjolTg05mWK
	 TyxPoBE6jD/LKWrihCB9T9dAC0p2qsCmp1stqf1UhKOJG47MYwDgSWyAO4jMciumEo1pp
	 XDK2jafM+vYkNbFRuTCOufi5cEB6xnfgYZHo3IP7tfIr+y3RTQ/O5+nKVXqVkSE/wKA/r
	 YnBBPl2pCOosnMcP8QBTDvSIyKuTvin3/UVE1gwYgFI5xKWI4mD9WZRsMZWUTBrzP784K
	 IMtNsS9cnmzO/mInLvRb/3slsq4n8XY29GiKiFF9CIRHAkXxmzn5orYHj4D697j08Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ff7UR6zH;
	arc=none smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE80606A33D
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 16:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEE80606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ff7UR6zH
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b31261e8a9so4804647b3.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 08:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793981079; x=1794585879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jrPqOBbmQTC7cKWIEZPDDl/+MmJimjcBhJLEmrI30vM=;
        b=Ff7UR6zH8D/UYE+JNHj2vEDlM3salg3JzD1PfqLOOq12vE1XOB8Vvs/asg27NihOm6
         K+csszUNlCm4+bG+3OemETdsEFrsxQ3YLKf5mCeKol5MlkcRqjF4CPE1V18SsyX1n1JN
         QFfASz6m/ekYiqsYcjr1nOcHE7ADAe/1Q5Sv1YGsyZT6EGXvospr2lMykh1TnnT/lxLG
         6Q7C2J0dkHXxADXJ/xwcr+mFJHPsky4I1dNsVAs/WHa1dbWkUUCay6kNGGamI/UaLjtm
         w+3qKRTkV3k7Ov5ug/C+PDxWRkzras9X5JVzMXf5YRcPRK5rJo1jEy1HCEjyDmIf3mWl
         iMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793981079; x=1794585879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jrPqOBbmQTC7cKWIEZPDDl/+MmJimjcBhJLEmrI30vM=;
        b=f1Pg6IEUtg2dAAp0GY204gIyfeyAv6J4cTHN85MmEMem1VxntWfZiGp1keRjiho2OE
         14hw4silfi0Yv7CnbYCjtO1GAN+PKxVKAw+xYlft++TiCjfUaVXHi0qm7yQgqMu2fVdF
         mUCyOp8UIScSB/Ew2PNSDI//2iGnL3Jei+r27z3bipEDqndCf5AcYG8hlsGQbttKYFfj
         ANXSHU6r4gdH4A7nI5XMI2DeEaKBJbpnjtznlxeTY+DDCyUkKVXQkxKKLpEEBDUtuk+W
         z5M7nXb0Qsmhj1WmE1vwMmNFt/xh/3sQ4/F2Ci3IDIVi9MzZpazeMEmftD2c6RIHT70v
         A0MQ==
X-Gm-Message-State: APuU4Z8Mb6JOs75RUBPQjkjzoUrwXXil5zqOyPwm+nzGchiGhm39EY9o
	OeWgIert9wEpxvvClLd7fJxR/xOqyoV307Eh7uy7suz0IwehZimLDRsb
X-Gm-Gg: AYBFou36KWosxzN3VxNUaDXrdgoNecw5wSzcfGsyeHdZB2hXX0YexQnl+r6HCwwsnNg
	fSD1Xb+JdRab6gYQ2qMBsUKIkvVnIer9DK7LZEVYk/TGrdqiFURra0q3ekrIcJyY/RDBsv2qpSK
	pKPK+IBgE5W9UgT4ltg0+l2uPfcyE5lrwZttULIuZhcO4w+I5kXOFAJwmMKGOqiObiQxSW0arDc
	wZIchMIXaG8IzVUH1giCzIjCpvsPpinPwiiWPya4pWCMsm/Qn+qTQhcmEimtAdUyDbNAMOuysYY
	2wOPjV4ThhFFdbtQpQXkRvJRFoaLPfu/EpLCdF2xdFgOosCtVsg5jcLzY+K8XN7OKSYfoMBZIEB
	daMBsO3TC+oXd2gDJ3TVRhk7paHknICrmqcZRnlbS8qLe71AnslgCFP4i46eBhd+pRBdI/4lXp0
	n7GJu/zKVp/IdBZ3/pGZe0s0ZNzW3oQjWILpAWDfo8YTUcleiE0Kr7fOS1GvTnMGclvnUsZYj43
	/itmod75lrbBMYBrtNwqZM7fMnMVyxK2ibTSlCYz8zkrfEHbv4ihYBGCCft/EOqO9qjHtRw8XlT
	/QJCYaoOqNW4KAP7FCWz8OaHNsUf+23aCsWPsJhE1ZfX7Ib4ptnvRjOlzU2nkliEm+rW3DImf9r
	p/gfGEN3jj3RPLGLAMXFSHPnnW/qeTnv/kHmS+Q==
X-Received: by 2002:a05:690c:930a:b0:8b0:ca83:c5a1 with SMTP id 00721157ae682-8b34157e11bmr14898427b3.0.1793981078714;
        Fri, 06 Nov 2026 08:04:38 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:22::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b33f7cb4eesm21953687b3.16.2026.11.06.08.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 08:04:37 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	axelrasmussen@google.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	baoquan.he@linux.dev,
	brauner@kernel.org,
	chrisl@kernel.org,
	david@kernel.org,
	hannes@cmpxchg.org,
	kasong@tencent.com,
	ljs@kernel.org,
	mhocko@kernel.org,
	nphamcs@gmail.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	shikemeng@huaweicloud.com,
	weixugc@google.com,
	willy@infradead.org,
	youngjun.park@lge.com,
	yuanchu@google.com
Cc: stable@vger.kernel.org,
	ryncsn@gmail.com
Subject: [PATCH 1/2] mm: vmscan: allow writeout of swapcache folios without anon mappings
Date: Fri,  6 Nov 2026 08:04:31 -0800
Message-ID: <20261106160432.2552507-2-nphamcs@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106160432.2552507-1-nphamcs@gmail.com>
References: <20261106160432.2552507-1-nphamcs@gmail.com>
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

Unfaulted zswap readahead folios can be dirty and in swapcache without
an anonymous mapping. pageout() rejects them before swap_writeout(),
so reclaim cannot write them out while their swap entries remain
referenced.

Allow swapcache folios through the filesystem folio check. They already
have swap entries and can use the existing swap writeout path. Anonymous
folios outside swapcache have no mapping and already return PAGE_KEEP.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/all/sashiko-outbox-181078@kernel.org/
Fixes: 84798514db50 ("mm: Remove swap_writepage() and shmem_writepage()")
Cc: stable@vger.kernel.org
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/vmscan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7db6be53f3a9..4b014e3c07bd 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -714,7 +714,8 @@ static pageout_t pageout(struct swap_io_ctx *ctx, struct address_space *mapping,
 	 */
 	if (folio_ref_count(folio) != 1 + folio_nr_pages(folio) || !mapping)
 		return PAGE_KEEP;
-	if (!shmem_mapping(mapping) && !folio_test_anon(folio))
+	/* Anonymous folios outside swapcache returned PAGE_KEEP above. */
+	if (!shmem_mapping(mapping) && !folio_test_swapcache(folio))
 		return PAGE_ACTIVATE;
 	if (!folio_clear_dirty_for_io(folio))
 		return PAGE_CLEAN;
