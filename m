Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793074945;
	b=R4+4aTy85sL6uhNP1kkCBBiNQzWAWG8KxbV06gmO5sGMCVzBfXVlAzHtH5j5PlS68ncy
	 l0S/4UhylbDesilQIEUIRNM80EWK7lAeoTWEeUK3n51hT0cFhKoHyDGNXWY0FPiBezrCY
	 0ewRO/o0ZDzNt4dSrw3IfgOKdtAL2jAco/jtPobrmolgkj2iDDq7RaJ5FmkSIsZcnsvkY
	 IQi/XPcRqAfRFJNJ6/7Gh/aeMJ4rdjm93/iSgNFdxGXzOP7UTkQz1o0+s2+ZwTIRJn3sP
	 oJUUHDgNfPMrv5zAyDcXvWYIbV9HQHIvUVsGyFAWjc4vZF7RJgqONh3Io+lDf/l7/yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793074945;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=O/I0LmBFR7uBLBrLDEFm/yc+s/I6APM2Icy/EDbK9iQ=;
	b=hy+XdJqkOZWDLDyt3ND5WpCrxofFovW5kQPqCsjRkmUMeeNT0VcOM1ttPuY2VOqNOkTL
	 5pFXTQO9gsZv9iusuVjUPbNFoVpEC3bNeYTE5386xzIvGU3+NfeYSksfGQRL1XcJcDgLy
	 JH/bi69305/Rzj2kKmfDHpjVsQrHoItpnwE2VCyr9kQXnpahdX2Eelq9Sc7vFx11W2GS4
	 3ahDIZM1qf+Cy+ewYf9OCOoWjSQszqPVo6c/5I2SplbdOZIpmTrRQrb3OBGqn43twPcdM
	 Pl2SINN5vBE/J+Kj9Kxc4ebU6OqlmmV4kDMM+7Zt3brHNWfaqesTeyegzgvIaUDuxdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Uh1dDRxG;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE08606A326
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 04:22:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DE08606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Uh1dDRxG
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-9178d514951so31027476d6.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 21:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793074944; x=1793679744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O/I0LmBFR7uBLBrLDEFm/yc+s/I6APM2Icy/EDbK9iQ=;
        b=Uh1dDRxG255t8FsdHTDn6DBOQan/CFITNS+SJISOlJdP3PwYjGv3T8ELkvvXQqFNGl
         xnHyMYbjZ6K+jnitvhsJoeGAbAT3fzxUgjR+gVXxz7uBoEYQi78NHoXaFlWZJIC5+ntl
         AGRIr/A6FGmmCBDilwfZ9rn8hCkAXnsmtoHnZ4Tfmw/e231yLueV38JEGEi892tHROMY
         AcLHbdyRJ7MBMSEWYiYmU0fRZs8UvG8+24vw9eLjyYth0iQAeBptkJochELEdv/7Nnki
         CkWWBOU+GiTtCb7wc341KP45BJwnYweMQKBAH2lSkGS0Bf9sONRg6PIQ1WNgNercipnk
         hBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793074944; x=1793679744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O/I0LmBFR7uBLBrLDEFm/yc+s/I6APM2Icy/EDbK9iQ=;
        b=0pM415y94aXXYKzhok01p/ixLIAdCO1183z/73OyrMwbGmG1Xo0hzyrx2eiu/1Cpsb
         BV9O0HEJMjCETWw69+88rrt+bT4pqtBnVPIReBm6/CpmfiiJKEI8sG5bLXWa6NyjnDgn
         4hZXQcF+AYoZNmXpKoGP7B+bwF1KqPImH9Dy0brXzWtjnFcsPNdDf21IJV/n7SN2eDbu
         pOc1s4tZKvGnzc5KXay7DYu1mP+voVZb7p4D9kadkrL1WW9Lu3qvUs8KDO3pcvM2eI2V
         y+N2AXHEC8fWVYiYNt3IGJJEO1DBx4mjnXXIGgSxMhEG+ugC8JT3Rbv1s+1yEECg9fyD
         byeQ==
X-Forwarded-Encrypted: i=1; AKwUvBzY4NXG4akStmWgNBD1JiEGHyA3NhiLFGz8M7SJOs1cXhpSZRd29w238x4J9Y/oYgDOwVamIpE=@vger.kernel.org
X-Gm-Message-State: AFq9FYL3yWjqY4sLwk7d3j2f3UC53PHlluPrXaUObEBMNdC0Hd8l/AzZ
	BWxWz+Kdnq1DNp+t6dVwvWjxEhKyX8Apl+ZRCiEkj2oKSMcZITVMNTkz4k9/lAV4k1M=
X-Gm-Gg: AYBFou0eRDONW6d/DjmX1xyp/bNahRBf/MWDZW1jyEwPhTdHtPrji6TELzzxtpBm4Av
	sayvewq4n0tablAapuEY+ZznDp0BLqTBtg/mM4U+Sv2M8J8JrL73rYRy9Y97JCtYpSsp8/7Sua3
	HLTLnibdvcvji4R9VKkv3IOADZvk9aj8irC6cNCVlQLJMA5j/34Gz5HpdWM8zDGmN34NhKAmXs7
	imd8nYp/Ioil0+yWbwd9UqxsGc47ogdWVvLdC2EJNfWjygq3HFxT4zpty111EyR2fULN9aYTUGj
	WdFheIlIJQcbvvk9d1qJtY2EBTMhVS/2t7N2aIfHY+uU/Zaf2hSMYGpMcLmqo5C7R/BCdGJF7U7
	lJl/6oyiYPfi7etyYJkC/jugrSAjvaqHJtChx/9DUDh3OZkjuftW9rHpzrWk8Blnuf6WxYIDTZY
	rGZkX6eMIbZcxJLC6uIFaRdlC7ro4rKJFTybst8JIhYUSqDBBQ5xWsBkV/rSgP7GlJAVQSVaGgJ
	sVBShGWmSuNAMLgFdJjOHpXEq6Co2dZVfE5FMxNormK2bzgGmiTzmo70MIy3ierYqlTRY4pgF4p
	+zgAI6uZgTLu/QN8hpSVjiiNQ3yRp0Rd6SqcGgQ2cw==
X-Received: by 2002:a05:6214:800a:b0:91c:60e8:a8aa with SMTP id 6a1803df08f44-91c60e8a8c1mr69350086d6.49.1793074944062;
        Mon, 26 Oct 2026 21:22:24 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47bd01cdsm91139676d6.7.2026.10.26.21.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 21:22:22 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	vbabka@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	rppt@kernel.org,
	osalvador@suse.de,
	muchun.song@linux.dev,
	iamjoonsoo.kim@lge.com,
	anshuman.khandual@arm.com,
	stable@vger.kernel.org
Subject: [PATCH 4/6] mm/page_alloc: don't undo another isolation in alloc_contig_range
Date: Tue, 27 Oct 2026 00:22:02 -0400
Message-ID: <20261027042204.3741307-5-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027042204.3741307-1-gourry@gourry.net>
References: <20261027042204.3741307-1-gourry@gourry.net>
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

An alloc_contig_range() that overlaps a block going offline can leave
the offline spinning until it gets a signal, holding the device hotplug
lock.  When isolation fails, alloc_contig_frozen_range() undoes it over
the whole range, clearing the offline's MIGRATE_ISOLATE too:

  CPU 1 (offline_pages)               CPU 2 (alloc_contig_range)
  start_isolate_page_range()
    blocks are MIGRATE_ISOLATE
                                      start_isolate_page_range()
                                        -EBUSY on CPU 1's blocks
                                      undo_isolate_page_range()
                                        blocks are MIGRATE_MOVABLE
  test_pages_isolated()
    never succeeds again

start_isolate_page_range() fails only on a block someone else isolated,
after undoing its own, so this undo only ever clears another caller's.
Return directly, as before alloc_contig_range() went pageblock granular.

With offline_pages() parked after isolating a DIMM block and a 1G
hugetlb allocation made over it, the offline on base still loops 30s
later in 4 of 4 runs:

  offline_pages+0x5b2/0x1570
  memory_subsys_offline+0x17e/0x470
  device_offline+0x250/0x340
  state_store+0x88/0x110

With this patch the allocation still fails, and the offline completes in
3 of 3 runs.

Fixes: b2c9e2fbba32 ("mm: make alloc_contig_range work at pageblock granularity")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/page_alloc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 55d3fc4b307f5..bb3c7e95f2ed4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7396,9 +7396,13 @@ int alloc_contig_frozen_range_noprof(unsigned long start, unsigned long end,
 	 * put back to page allocator so that buddy can use them.
 	 */
 
+	/*
+	 * On failure this has undone its own isolation, and any other
+	 * isolated blocks in the range belong to someone else, e.g. offline.
+	 */
 	ret = start_isolate_page_range(start, end, mode);
 	if (ret)
-		goto done;
+		return ret;
 
 	drain_all_pages(cc.zone);
 
-- 
2.53.0-Meta

