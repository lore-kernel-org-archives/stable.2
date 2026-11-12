Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794471079;
	b=eiMRz78XX9f4LWOT22+veuK9CDQcaj/neqK4mADh9qMrhlHwD2EyRL6yu9hv4C4cS9bm
	 daz7+SzPXdH3yaNloRzZCaNbxDO4MiRBXXMaH2PWga02qXXGBgJoTui5ge5K/u+7T1Bb5
	 3quECezh2jKHgUnQi+sRRXcRkwHCUQDbikHSzPqjUGAfzpoAzyyFJEd3DA23kVxqMgZPH
	 JOjJExWdoY2t0j2Fu94jRrr2hD5pjDBuGl9sjoWt5ZsBfU4tnD5Mr6LMjZO1t/y8CLoKu
	 GplIElFDKPQPainEn7YRvlGUVUnzEG2hWWhRHddg/v41S0BcV61E+3vN3j9QBdJaMQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794471079;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pd1KA1gwB9M4Zxez2FqD9OUgDPWrVpKDiTkmpN+Klb0=;
	b=fzFngwx9257jEojGttZARHk8R/G/Gq58Biz4y5zdnABoV6QUWeO/DtRqUOLTlt3uhlrW
	 RymU1KPo6yXxpujxu1R2GkUDSIVAq+GTo5FL8tsQuRSc9zixRaq7j76CrAn3zLGQpghqo
	 ZfeCMI9u4CJdYBfDOdYONvYNjoiObBqLQbJRLDUci7rIXP+qFVsW7kIhAKpXdzKlDJPVL
	 WNjVvsOAyV5mkPVlM0qE0MAAo1nPLUknZrwzDtC/tFFxGp/en77YFhdvCoABToumoM2n1
	 NNrEVIjx9cqOYiXY30TNZkwL3lyQVlfIXIXRcR2gHxiCNakmMEDkAmoXPhxx+vmipIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="OxJVJ7/Q";
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABA7606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 08:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7ABA7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OxJVJ7/Q
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-36f936424f2so1464208eec.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 00:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794471078; x=1795075878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pd1KA1gwB9M4Zxez2FqD9OUgDPWrVpKDiTkmpN+Klb0=;
        b=OxJVJ7/QbcpRgLv0tyoDo4L2IqjenJBu2+9h/9bukC04n0SyBjTm2j2DD3soZOQX+x
         V47qQR48UyM8/svEK3AegRzoyIt6fd5fmUjxT1UlnmvF6j5as5xZRebms2pbmC5apiXK
         f+XP0VZdbqMp9mE1eExJNOM53P/8MU/qzwU+CsFi4h9GPQr1AfaEXSQW6l2O+3eMB6Ff
         /Hkdbqfi/bDWpFlWNdQo5hifnadpMyWXdd+1mOQQVFiRZvgYJE4yVq3t/TuH+YnXY+O4
         5Eb5vcjzwdgKwJQVIAc74Buav8h1Fl2c6zq9w+uTXc9UOqrc69QbGlzysUlNefpKHFvU
         +lYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794471078; x=1795075878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pd1KA1gwB9M4Zxez2FqD9OUgDPWrVpKDiTkmpN+Klb0=;
        b=fLUEbv6uXn896Jdkruh2yKkkfEmdrVjAfuO2vEZeT2mKBiQxXuj4P5IJws7uVorplf
         O32IPedpz6vlsnpjs5cD0pEEnBZuJQfc5sR4ehfFtqfZ58IlbgB5HbhWJnS1CDDcAN2t
         fJUBc7B8u8+423Mjh4Gks5uKe+UsiygrjHDfvtAuW5Lm9B4VaQ0fAFITSrdssl857COU
         BkN1/wR0pu8a0HewB6ymN1N/mfjSatw0lbnieKhyLszNOTD72aKhrW9R2FXbobfZ8dpP
         sG3Zyw4SKAUNt7x044uCWXM/vLSwmsRuO77kFn2ehpZX5+Z05P6boqgLMPzSN5KfWrDf
         KIuw==
X-Gm-Message-State: APuU4Z9ArlxsjIEKctdsMwj1JzGp7YrBDBrkwy1Fwm1fVEngL5CsnHhw
	L/enkQTny6H0nNBceQorgTZBdBPDFXXFddG3kq6q4L/b4O2oC7ZZXOqVQP2xjHXRsWUYCw==
X-Gm-Gg: AYBFou1a61EoPk7M7J5NK6Yzp8NQtO2BjdevRh3mlpjaTQ7Xwf8aeJCDOtqmQEM+gUf
	5cFEz+PFkhvPGd2l3yRig8n4DITxtYx2uqgpsmmBvXcLW0br/wPYDLh8PlVu2CI+/8GFkkzcH4I
	8Y521WVystQfDLpp8rDHNXBBPYBsNZa3u1ZXvxzhz6ZEK1vpzvyk+IxmEMgmw0vaNoQQOz1R+Os
	/Cp2JP/D36JYyeyW59AJrORd1pS7XYwoaFbHSIpOUfwY47pzujSE/RB4FHuBIbWBXMC9fIjrq2R
	HNvVlicD9R2yDqCMLmp3R51ufksZsUZ4jT1ZJ1CUkFKVbC8stHAt7xia3FAg8Wimii1WjMjb7aq
	1ajkS2P1rbl5Q58Ij/Uq5WapbtvT/50pkpPSFt0nWSJ+aDdDMp0gRcEulKpYFTVzUkFoCwhALSf
	sXy4lDN0+BSNyP3J4OU0M4sbRoJqZKhy2S0bsFEZomrlwEufh10jFMHe2AAcHNvJUNLNbPqn5tv
	ioKX/qC0Ou5efav6JChurMQM59VHjkghvRm6uHbC6MaloYr+nngI1mOm//zhBV46frU1jMdO527
	oogM/RQRTRinJF50efksBUm3PT+UycH0nduGQSqojrEWLak57tfdP7bv2XLXCYQtBcYV8advutD
	u/LfnASpFoJEZ/4LiGYdILCbilVaznWyMHyly6w==
X-Received: by 2002:a05:7300:f588:b0:376:98e7:eeb5 with SMTP id 5a478bee46e88-37698e7efa9mr4760081eec.14.1794471078493;
        Thu, 12 Nov 2026 00:11:18 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfe29fsm26253422eec.21.2026.11.12.00.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 00:11:18 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	odys.yuan@gmail.com
Subject: [PATCH 5.10.y] mm/migrate: untag addresses when querying page nodes
Date: Thu, 12 Nov 2026 08:11:05 +0000
Message-ID: <20261112081105.6025-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109202700-failed-5.10-7d8746d7dc9c@kernel.org>
References: <20261109202700-failed-5.10-7d8746d7dc9c@kernel.org>
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

[ Upstream commit 7d8746d7dc9cc4003661011424e5880ea7ae364b ]

When move_pages() is used with nodes == NULL, do_pages_stat_array()
uses each page address as-is for its VMA lookup. A valid tagged address
therefore gets -EFAULT in its status entry instead of the NUMA node
reported for the corresponding untagged address.

Strip the tag before the VMA lookup while holding the mmap read lock.
Use untagged_addr(), the helper available in 5.10 and already used by
the migration path.

Link: https://lore.kernel.org/20261026195330.46757-1-dennylin0707@gmail.com
Fixes: 057d3389108e ("mm: untag user pointers passed to memory syscalls")
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/20260721183257.706661F000E9@smtp.kernel.org
Acked-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Gregory Price <gourry@gourry.net>
Cc: Ying Huang <ying.huang@linux.alibaba.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: <odys.yuan@gmail.com>
Cc: <stable@vger.kernel.org>
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index bf59b09..bf112da 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1813,7 +1813,7 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
 	mmap_read_lock(mm);
 
 	for (i = 0; i < nr_pages; i++) {
-		unsigned long addr = (unsigned long)(*pages);
+		unsigned long addr = (unsigned long)untagged_addr(*pages);
 		struct vm_area_struct *vma;
 		struct page *page;
 		int err = -EFAULT;
-- 
2.50.1 (Apple Git-155)

