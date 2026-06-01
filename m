Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B751C3AB5AC
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 09:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307873; cv=none; b=JwThl/ZWt8HpjjDmKhOa0u4c553uHKVqGTI4jAI1C50k76P2hvvOu3kYEV9lAWY/HMIjqQp4fnNb2ood4ReRVgC00RwTjPU9s8rnQg4AdOxXCyL01pKXhGOpyHBSKzIS+6jfkYqHJ8oxQdznfjIkmWzRWbgtjZQboOgBu4TRh4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307873; c=relaxed/simple;
	bh=2VZS15ovfor2YtE2z2p5xiUQ/ptnv6btt6wjTVbphAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uwMHyl25/HLIyNgqkzS6ER+CarDesRHP/CCmd/tq4a6DBkQFb/DztDD0oJ6j+ojepsxB3BgmtFlbaYJ4ZPHGCeBF5AdqcWPjAiY1IxDc5hBZrkpdEXbbj6n1gE5lvG+D3Ya1TV3DjY1C+n6vp51QGKHbkLicDOh1/lwzJnjwaUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAEi59EA; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAEi59EA"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490a78fbd7bso1521695e9.2
        for <stable@vger.kernel.org>; Mon, 01 Jun 2026 02:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780307862; x=1780912662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VeYhkIkkPdmPxP0oRNh636yFz6Mw8IPmOd/UUON7A0w=;
        b=SAEi59EAqg34v+vIMfU0v0WPdXDPQwJ1g9AjmaBVxhu6FSfDRzR2k96BtaVsbm2AXx
         Dmjh48oiRkhQSSQbPLK7FkKKjWND3tsVQbAvaB3S8kga1FsIBEnP1eKpkilaXcRiTPKq
         flPK3z8jtKCHauwpAz5OR52MynHoyUuoiqHJUmcEUBgdoOI6vfMCUgyD9FgKXSfwKq0C
         AdNW41nUsVopejl4DkrwgbKDT/SUYH3VZafu7QwNjtSfq0yRkmAilNsFS/wuuR/ihwDj
         oxrMu+t68bOO5ibArUSi8G8XCDwCX4S3aPMt7T6CmpSrFJ2b5Pv0Xl6TkcbbERpDxmze
         blww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780307862; x=1780912662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VeYhkIkkPdmPxP0oRNh636yFz6Mw8IPmOd/UUON7A0w=;
        b=OWF1b6Z3HMsXp4FF4hGFarx2Obfcrf5zTLncDGFMMYJRKpvT/QBifsxVqZ1joyktAG
         O5/mE9oP3+/h+v4pRkEhQ7+nYeAMY9HSsr1UGyiS+LRrrucndM4HfMPWMvrnUKjxD2R9
         176BchuuJPdlhc/uxjZp/scjqdB7oMStzpBVtJ+J2xsNmEgyrAQQeAS+SVZTStjafqLd
         XW6SK5+Sk5lLEuSEpc/P5an+1Ok1UhJ/P73al8LDOE/64qJsTROZxRldiPk4MiB6GzzC
         pvfrsmC/3Pkb8qtDvXtZtUJHLr/b+POALkUSc5us4vXU9nxdDpsM6F0y5sqOG0I6Ia0n
         4uTg==
X-Forwarded-Encrypted: i=1; AFNElJ/3YrDus+y/CKRUeUo9kEzhsBdNcC/ED7Vg2ae7hIB5dVq7MGVAPjBpwKFJkKSYGZn+hCkhAlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDl/Xt/KeqHN7/8LmaGb/tyCBOUzvRwh6J2ruCKHnxE9mfyJrX
	NRXJTHL7Vcj1R6NqTQ6gm9IlDyxecVr5kLjQsb39BNhkIWoxZC8iDwJi
X-Gm-Gg: Acq92OFE00B6Jv021RBc/CBIbfIlPJUZtisn4qZuGEoB4227ZqhteuDfRvfLpbrTLlx
	QBDyTe+n7c5Z6ltokpr7LgEsgo+TxQCAX7dfnIcEHyCwkMPqsW/wxq/SHf7BDys60SvUdbXpnqs
	HnBUbI9kilERhyBN0aOE/TTQAh/CSKwFsUyHKZD316FW1G/SyavAattLxRPC4nYIQFEMrPttDV9
	f1cri+qYoestok7vN7fAQ5bYp7yzqqJooHBBWGEOLPRWovFD/0sW8k4gF5Kge63Yj+25yJNYbiO
	ZmxJmVUF8/MNikQbdwHlF/4D79+zKwTgTuCaDComHMV2mlVTlJ50omWMMhU3T9aAmUUjokJYxP0
	o8tCUZwyw8UBR7LuW2zF/vtrYQxtqTtha9nhPL9wfGyFoXL2h1BL80lEFNH13N/3hjUM/eezXeW
	EO1OBFSlaWZTn0bQ8pfpvs5MCj3/R1o66w6w/3wnmk9iM7YrBam+mitPuq/O/tc9vrb6SBCZkAT
	DdZo5WsaXQigkr3aoahLNOt98X1BwLB5goGIBbCZubE4ul4oeLwWpLnnXRlmkhmOwd6QuDhoA==
X-Received: by 2002:a7b:cbc4:0:b0:490:a2f4:c499 with SMTP id 5b1f17b1804b1-490a2f4c5f7mr49990015e9.6.1780307861689;
        Mon, 01 Jun 2026 02:57:41 -0700 (PDT)
Received: from fedora ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34a03f8sm25589419f8f.7.2026.06.01.02.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 02:57:41 -0700 (PDT)
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
To: akpm@linux-foundation.org,
	vbabka@kernel.org
Cc: surenb@google.com,
	mhocko@suse.com,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Subject: [PATCH] mm/compaction: guard move_freelist_head() against invalid freepage
Date: Mon,  1 Jun 2026 17:39:42 +0400
Message-ID: <20260601133941.111989-2-giorgitchankvetadze1997@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In fast_isolate_freepages(), freepage is declared uninitialized and
is only assigned a valid page pointer if list_for_each_entry_reverse
exits via break. If the loop runs to completion (all pages in the
freelist have pfn < min_pfn), freepage holds the list head sentinel
and high_pfn remains zero, so the high_pfn fallback does not update
it either.

The subsequent unconditional call to move_freelist_head(freelist,
freepage) then passes the sentinel as a page pointer, which is
invalid.

Guard move_freelist_head() inside the existing 'if (page)' block
where freepage is guaranteed to refer to a real page.

This issue was identified via Coccinelle (use_after_iter.cocci).

Fixes: 5a811889de10 ("mm, compaction: use free lists to quickly locate a migration target")
Cc: stable@vger.kernel.org
Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
---
 mm/compaction.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 8f664fb09f24..320c082420fd 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1611,11 +1611,10 @@ static void fast_isolate_freepages(struct compact_control *cc)
 			freepage = page;
 		}
 
-		/* Reorder to so a future search skips recent pages */
-		move_freelist_head(freelist, freepage);
-
-		/* Isolate the page if available */
 		if (page) {
+			/* Reorder so a future search skips recent pages */
+			move_freelist_head(freelist, freepage);
+			/* Isolate the page if available */
 			if (__isolate_free_page(page, order)) {
 				set_page_private(page, order);
 				nr_isolated = 1 << order;
-- 
2.52.0

