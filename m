Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793499234;
	b=da8/u9KLc9tX68TKynR30YFbtgeaU++QXghZGvIX8ijtZFwtlJBneaU0Kx0C+jK+SwbQ
	 82Xgpzp5gnn16HQyHX8H5hBIBaFhN0FG/QwG+7w7oqZ09oeN7gVfyd9DfYZeDlylWPF0O
	 YQb1jkmfvng3E//C7+SzW1J73hpdErr3A9W76V0myaqXCRRWwHZ4yapMFFxUj9mrFQuAj
	 KoOfr6lqtkQOH45JVx+Zp+hL56FihLhCpCjz/tluW1e+rkE7Yx1gWjsUw9PbA10lOlxT1
	 xzOM3ZBXS+7uE2fy0KN67VT6/AdmBLwZ1U/p/j/8oFgaqBaRQtslWDjpLXh4hFl602w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793499234;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=IX83IRV13zUjxpE8+UB16/ReS4it9bdD0etB9Kv5xx4=;
	b=Gp/f6BvN411yqML6HqP1KXtckS+UH4XtCYBam1pwW0ipclC8CpNTO35cbqAq1tCD85Tl
	 bs4Yxow0jHB6bZEHQgxxJIFJEtHzY4n3JWlVtug4Y2+Fx6Brtv3DeBrKZCathWWxOZiCK
	 uxJUiLlHIp1kdxrquMu4h99Io3Am3imXbemzpEY/YZfZg1T72t8EBB04CVeA2FJEs6No9
	 t75ENDxgT4+nwjTyyzjX7iPNUDpXI2wNh8Wn5d36eldPlywLI0jzCFpTverT2TKz9+CX+
	 //6LeJC0S+tBrTaiNlJgbf8v54vxFGaPQlJzwFODfxHVV6voBYHwNSvoZiB2sS1j0uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=O23ACsgn;
	arc=none smtp.remote-ip=209.85.222.176
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358DA606A326
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 02:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 358DA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=O23ACsgn
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-945ae2daa3eso39839685a.0
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 19:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793499233; x=1794104033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IX83IRV13zUjxpE8+UB16/ReS4it9bdD0etB9Kv5xx4=;
        b=O23ACsgndry4YA9wKXjSwIMGPt9b/CC2wNGJAACC21fdenDx6Kjve0LIwwU2MweSGw
         T10decsrXvUbsgheMEPjL+/2u7BqU/zmPGtoFdLviCMTbeAEqNMAxOfAMSyrbQuGYrOU
         d4MC05i940M0JmuSFgmFI4KSuPXDlOxKi8D2VFi8AERvbUBEw3MXbv+ngrggbUugxR+J
         QNMMIQ9Si8K02YQRunNiV2TmUEOyQ4qI/sMlJurICLWYABWcJ2dtJnHdBYFy0jhqxX+j
         6VlXStC9zGUsXkyyZdpbwL7e+YuT8MpyIsEcK4IFr5O5Yu6Wttm/7dvmIRD2StEfk8W5
         5ViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793499233; x=1794104033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IX83IRV13zUjxpE8+UB16/ReS4it9bdD0etB9Kv5xx4=;
        b=WWpXG/uVnNPzJ/bDay2Lk+6s/yPN6zVgjdYjOM86mTZ4n7fnuluExe85zwjBlw85et
         ofbswQ0GSgqUujp0fj+UQxqzBuDR0m0nMqLO53laLZhvYgtcuzqAci72ubViEglDSVO7
         OqhJfMTpYj18oWTQ+OU8fNE2fYxso5ypDF9gD7Jv6KsQrtm7sZwZK2QICa/xHQeWsDh9
         mgjc3gjQY1DTiYntl14oSL8jIJyFxjxdnMBTj2leRWKnCGeDGrjMWZVvSp4Y0U8Eurd0
         wHEg2CZ8/rWrjMGbcDdNSW0tUENrlVrI5eaJkDOPzWUEm89t18Dyvx+AhM8G+0lq1Fa/
         6YIQ==
X-Forwarded-Encrypted: i=1; AKwUvBzxwo1ww10iHFMFHUD5tMJ8Sx1ziCPABnJEMUidO610ydmwir1Du4SZ4okcGbhQ6iAAdLSuXNU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKjF9MmA7OOZQKxjHqMcCHjz5lPYlzsISRYZw0H5qW0EKixDTc5
	s4Nq8S0tK4xaqfnzIssF/tA/i5gA/9Uxa6ryWEeFr6iqbvR2PdvWaKY1AYVxyDwtSn4=
X-Gm-Gg: AYBFou0Pal+iXFhc81tl+xfjjryCMgtN5KfVX6JOHQFF+NBgcPNlEbfg5zCU8h/1p2c
	kB7vktERagc7PeDwqzF6wBU1ESbDn1xJ9o9lFbCrQeWmcZ7Lcve9+uN7VeNvPgfnRGMoEq1yBbi
	tB1NF0u7b6hn3ZvC7XpzT8QCGzZ5lov2Q+v+RD19+MOcCBQOFMLJgNqZVHOQuL9Wo6HcyrorhFi
	RruqGh++ev/R4bwp2b96AU0dkYC3eZWzWnlhPK2owKpSp+/3qLrCnpwztliwJZ5D15bu8ayIfw7
	SnzTThcK25czowYoKawjHsxRHuPi3DtvlcPae9NY9sdOFmynNFdT7pRSPfkXfSvokNfucgMqUy6
	LH9WfpJ3la03DuuGwxVu/0tBr4WJiCaIqnw1pwlsv2K2qU8IV5wMDPCCCBi2HqpBxKQ1JonlJ9g
	pV6tsi88XPvud7LORUW9WRao7aGdjRqWeuPY4r06OKW8H6npISh966QV3u3nLV41dUvwnNWQmyQ
	CzZUIOKTqwa3Fn10YqTUjVepC90eP1FaKzMeC3oUeuAP5uu3H3IfQt667FCMjE58iWOJoKCOo2F
	hOmzWRX5uEqW+Wy1z8KxkNgrMetXUUTAFqCgrbMie/HsieJFdo0Wv+S/j+u/A0szEFX8+Gn3XTK
	sXHgiim4aXg==
X-Received: by 2002:a05:620a:3703:b0:93f:3120:6c84 with SMTP id af79cd13be357-9442173fc02mr1051691885a.36.1793499233173;
        Sat, 31 Oct 2026 19:13:53 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425858552sm498131985a.18.2026.10.31.19.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 19:13:52 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	rientjes@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	gourry@gourry.net,
	ziy@nvidia.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	Bessel.Wang@huawei.com,
	jiang.liu@huawei.com,
	mgorman@techsingularity.net,
	anshuman.khandual@arm.com,
	stable@vger.kernel.org
Subject: [PATCH v5 04/12] mm/page_alloc: detect zonelist rebuilds from memory hot-add
Date: Sat, 31 Oct 2026 22:13:32 -0400
Message-ID: <20261101021340.2251928-5-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101021340.2251928-1-gourry@gourry.net>
References: <20261101021340.2251928-1-gourry@gourry.net>
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

The zonelist_update_seq retry was limited to CONFIG_MEMORY_HOTREMOVE,
presumably because only hot-remove takes zones out of a zonelist.

However, build_zonerefs_node() rewrites the zonelists in place, so
onlining the first block of a zone shifts the entries that follow it
in every zonelist containing that zone.  This can cause a spurious
allocation failure for a __GFP_THISNODE caller.

For a node with only ZONE_NORMAL, onlining its first ZONE_MOVABLE block
rewrites the node's ZONELIST_NOFALLBACK list as:

  [NORMAL, NULL] -> [MOVABLE, NULL] -> [MOVABLE, NORMAL, NULL]

A concurrent GFP_KERNEL | __GFP_THISNODE allocation can observe the
intermediate list, skip ZONE_MOVABLE, and find no eligible zone. With
CONFIG_MEMORY_HOTREMOVE=n, check_retry_zonelist() returns 0 and the
allocation fails even though the node has free ZONE_NORMAL memory.

Gate the sequence checks on CONFIG_MEMORY_HOTPLUG, which covers every
configuration that rebuilds zonelists after boot.

Fixes: 3d36424b3b58 ("mm/page_alloc: fix race condition between build_all_zonelists and page allocation")
Cc: stable@vger.kernel.org
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/page_alloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e14d550d4128..11be12b443ad 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4404,7 +4404,7 @@ static DEFINE_SEQLOCK(zonelist_update_seq);
 
 static unsigned int zonelist_iter_begin(void)
 {
-	if (IS_ENABLED(CONFIG_MEMORY_HOTREMOVE))
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
 		return read_seqbegin(&zonelist_update_seq);
 
 	return 0;
@@ -4412,7 +4412,7 @@ static unsigned int zonelist_iter_begin(void)
 
 static unsigned int check_retry_zonelist(unsigned int seq)
 {
-	if (IS_ENABLED(CONFIG_MEMORY_HOTREMOVE))
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
 		return read_seqretry(&zonelist_update_seq, seq);
 
 	return seq;
-- 
2.56.0

