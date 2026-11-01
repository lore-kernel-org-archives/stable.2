Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793499242;
	b=MqB/MfDW1CtEbCN3C6iv603gzj7FMbtLgddbeeS44HO7wSYqhQNiIyTbojp4PmwUL1mt
	 LjYT9/I4fIrMLgGf2+NOivVgBwxNyq0rz7e3Uhrhr+9cD3M7YRLofaTmEHm4O5p6Ok+g2
	 zAuMdUa0VKs9lWFZVH54vfk+RKj/3Jdvl/lVGZ94YYt/Iuxgo07vK6p6mYWH+47LK/xYf
	 ovKEAD2OBCdjcLiUD9FCrZEvuuu0Gi7cJULSNdrqUyy6y3ukJP1FuwDN5aeKFbY3fXpXR
	 NuQGnHZ+6bV/73zji0tpn3hA6et3k7YcWoex4Gq9yiWVN3lLGBkRW6dk2k0phV4Qs0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793499242;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=riPBcqO3vkhc0O/om8wK7f8cpXASGUa4k9CTnWK2v/U=;
	b=fIa1EVoGNQ9ekgln670nHeQyoGvwkOAcS4fpoUZFcKhCF2KfXQKh0E+Sp1a1NU3upWDq
	 k3Ykh6EpEv1OV4RTf13ixemjUyZWt5fYCVjTQgkY/qBXuy+317hL1f5zmEIe6sDpp9wWu
	 eNbitigdnId9w5z85WryPvtmEGQapcUYeYOUG3Xr2kPEupjo7sur2tk/J0EXcHbOQys6D
	 J1gdi2AX7EQ++q2iAO0a6s7hORuNi9LR1qe0sUvQ2k5C6oJxFBWGztYEYsBvwyy8K4aKV
	 vTHO5DSY5KxyGpXxQgkQ+HuZminRNl0xyoHV2A8VAeVSd/+n+Dl69DeduRXgYuGkhrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=bd7gYeyX;
	arc=none smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376E460A261A
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 02:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 376E460A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=bd7gYeyX
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93e4c00d71aso163567885a.3
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 19:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793499241; x=1794104041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=riPBcqO3vkhc0O/om8wK7f8cpXASGUa4k9CTnWK2v/U=;
        b=bd7gYeyXbsO4b5WtmNTM2T9G8thWdsQlW55k8MN3pn2G/e4qmKq7lLj3OkAaqhCE1F
         ecSNEucUyo5DSj8fGheBXBt0lA4lO615Bxd+b2We9Z93ntmKnyznpARpX0hw2LgAWaZo
         lXFzIGovZ+iNQQQwKSoNCJs2Bl0sZRF07EdC9RJ1Gb5i7WIoVaUmXgdm4q8x8IBdevhJ
         iP5jERZy93X8QNJCURmj7kiVY1eOe2Or4PCJgJe74JozP1n6Y2NgdecD/dNgOwx95feV
         sYJjvliydXfnnKvXrVR6lsItsjA76MYob/ct9Mhiao6+dpWoSEPqcMbgWmSalNoP57rI
         CdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793499241; x=1794104041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=riPBcqO3vkhc0O/om8wK7f8cpXASGUa4k9CTnWK2v/U=;
        b=W9BQfPIjeRgIskJiAPLTImZk04U4HIEYazukMbE1YddOjR0D4g59qVjTtJL4/Y+pZy
         2aX70P9SZen6+VsVhM8hQRfzoToV1I5F33SBRarpCnJbLhaqAB5/fRDiTiODrj6Ef4YP
         sL9THOSPEIkb3RHy87pySBc0MMQfDhjKTJgIL3/puczEC+kP4loLrKYWuCmIQgHEjrAt
         GeeF5wAxs/ZtfjUQM9buZjXBGqau6NDiW0vc4u3vwjGf0+pvxWrY4xgoQ+aFOcrI+Tna
         SXS8QRwbaL9muJyQwDQYWYbQp2e/2FNNgNFUctCoro1eXDUVsunm4VzHGa0qlxoBip/i
         rn4Q==
X-Forwarded-Encrypted: i=1; AKwUvBwhIPoLfPQufL/EpHfig0EP3eBR43IUW7iMVKMo4Di0UMNw6qhy00rTUmkcfLT9VFH4ZTvELzI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJBjrL87aPEzKvTZxG5zysDadyFNXASvP09+W2F25otk5mZnpiM
	LRgK3eRbqD8S+A8GHYvYaEF+A0Q9S92INovo7C0YL+sFUVdbJMze47Xr2YUfSTyJRgw=
X-Gm-Gg: AYBFou0OR4nTC8MLx/Lfiq6WPDUFkTtMkUzy/qQ5fvPIqI8OyF7NHmSjNPd2dPU28Tp
	Aag7L+WSfJNbCWQBpo8FzAVOX1xEh2ZiYkwbTUntZWb+gaNsbSz7McmwWBmpOsK0OX3LtdN3mJw
	qHVTQMVl9j7dRjB1CwXgGtJHXAX2kjCbxbJh5XQ8E8X9e2Hq1pxwOB++TUo3nGNsD/hhRnvtIL3
	4dBjCtG3ACe22W0Kfiu2LBiyO5Mh3H++T9y0m2kB1P41h1QFbeRuEO3UdQTrBp0p1wljKAnWhHV
	fv0TPFYfAjrrn0iliy3zqkXfVjORwKO1a/pBfOQSj1QNm4XzFa1mwTwsbvg9cbWPdTngv5RL7XH
	I10/0rQUvoVZHVi/1gl4XYgInfA4FHVS5OVFMPQeLmLF62Y/87bN0MczUtZmEZeqDlTexQtXNOb
	V1VT0FJVipTQWckERxWN6IM/+JOloS3+YEcR8fsZamKvxi8ZfoMgfkR3MDNG9+5308HTr1EeLKN
	1aHAFM0YyyshCu0WJyG1HgNQLS1WBsE2XZ0BViVeKEW1oB5dp569rrSqVPAJc5J79wtof49nMht
	3JTYWikiONjuT9cxKfD9dYpNuaNGFVhRNkE25BCO0A959xrt+I21M6vV3B1kmz3r1VA2sgEdSZ+
	yvi3ETKDYiQ==
X-Received: by 2002:a05:620a:440d:b0:943:faab:a144 with SMTP id af79cd13be357-9442175cf9cmr1087655285a.45.1793499241148;
        Sat, 31 Oct 2026 19:14:01 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425858552sm498131985a.18.2026.10.31.19.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 19:14:00 -0700 (PDT)
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
Subject: [PATCH v5 09/12] mm/hugetlb: retry the pool walk when the zonelist is rebuilt
Date: Sat, 31 Oct 2026 22:13:37 -0400
Message-ID: <20261101021340.2251928-10-gourry@gourry.net>
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

Onlining the first block of a zone rebuilds every zonelist in place,
shifting the slots after the new zone.  dequeue_hugetlb_folio_nodemask()
approves a slot by its node, then loads the zone from it, so a hugetlb
fault bound to one node can take a pool page from another:

  CPU 0                             CPU 1
  dequeue_hugetlb_folio_nodemask(nodemask {2})
    slot 3 (NORMAL2) approved
                                    online_pages()
                                      build_all_zonelists()
                                        [.., NORMAL1, NORMAL2]
                                        -> [.., MOVABLE1, NORMAL1, ...]
    zone = zonelist_zone(slot 3)    /* NORMAL1 */
    dequeue_hugetlb_folio_node_exact(h, 1)

Check zonelist_update_seq before using each zone, and on the way out
with nothing found, and restart the walk if it changed.  Checking before
the dequeue leaves nothing to put back.  Reset the last-tried node on
restart, so it is not skipped.

With kprobes holding the walk across the online, a fault bound to node 2
took a node 1 page in 3 of 3 runs, and a node 2 page in 3 of 3 with this
change.

Fixes: 11cd8638c37f ("mm, page_alloc: remove stop_machine from build_all_zonelists")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/hugetlb.c    | 13 ++++++++++---
 mm/page_alloc.c | 18 +-----------------
 mm/page_alloc.h | 19 +++++++++++++++++++
 3 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index da5d04edf7c1..b8a4fc2a996c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1293,11 +1293,11 @@ static struct folio *dequeue_hugetlb_folio_node_exact(struct hstate *h,
 static struct folio *dequeue_hugetlb_folio_nodemask(struct hstate *h, gfp_t gfp_mask,
 							int nid, nodemask_t *nmask)
 {
-	unsigned int cpuset_mems_cookie;
+	unsigned int cpuset_mems_cookie, zonelist_cookie;
 	struct zonelist *zonelist;
 	struct zone *zone;
 	struct zoneref *z;
-	int node = NUMA_NO_NODE;
+	int node;
 
 	/* 'nid' should not be NUMA_NO_NODE. Try to catch any misuse of it and rectifiy. */
 	if (nid == NUMA_NO_NODE)
@@ -1306,10 +1306,16 @@ static struct folio *dequeue_hugetlb_folio_nodemask(struct hstate *h, gfp_t gfp_
 	zonelist = node_zonelist(nid, gfp_mask);
 
 retry_cpuset:
+	node = NUMA_NO_NODE;
 	cpuset_mems_cookie = read_mems_allowed_begin();
+	zonelist_cookie = zonelist_iter_begin();
 	for_each_zone_zonelist_nodemask(zone, z, zonelist, gfp_zone(gfp_mask), nmask) {
 		struct folio *folio;
 
+		/* A rebuild may have shifted a node outside @nmask into this slot. */
+		if (unlikely(check_retry_zonelist(zonelist_cookie)))
+			goto retry_cpuset;
+
 		if (!cpuset_zone_allowed(zone, gfp_mask))
 			continue;
 		/*
@@ -1324,7 +1330,8 @@ static struct folio *dequeue_hugetlb_folio_nodemask(struct hstate *h, gfp_t gfp_
 		if (folio)
 			return folio;
 	}
-	if (unlikely(read_mems_allowed_retry(cpuset_mems_cookie)))
+	if (unlikely(read_mems_allowed_retry(cpuset_mems_cookie) ||
+		     check_retry_zonelist(zonelist_cookie)))
 		goto retry_cpuset;
 
 	return NULL;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f2f7e96bdef2..242bef2fe400 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4409,15 +4409,7 @@ EXPORT_SYMBOL_GPL(fs_reclaim_release);
  * retries the allocation if zonelist changes. Writer side is protected by the
  * embedded spin_lock.
  */
-static DEFINE_SEQLOCK(zonelist_update_seq);
-
-static unsigned int zonelist_iter_begin(void)
-{
-	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
-		return read_seqbegin(&zonelist_update_seq);
-
-	return 0;
-}
+DEFINE_SEQLOCK(zonelist_update_seq);
 
 /*
  * Never wait for the writer, which an ALLOC_NOLOCK caller in NMI may have
@@ -4432,14 +4424,6 @@ static unsigned int zonelist_iter_sample(void)
 	return 0;
 }
 
-static unsigned int check_retry_zonelist(unsigned int seq)
-{
-	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
-		return read_seqretry(&zonelist_update_seq, seq);
-
-	return 0;
-}
-
 /* Perform direct synchronous page reclaim */
 static unsigned long
 __perform_reclaim(gfp_t gfp_mask, unsigned int order,
diff --git a/mm/page_alloc.h b/mm/page_alloc.h
index e238ee91ed24..10a40ead6c00 100644
--- a/mm/page_alloc.h
+++ b/mm/page_alloc.h
@@ -9,6 +9,7 @@
 #include <linux/mm.h>
 #include <linux/mmzone.h>
 #include <linux/nodemask.h>
+#include <linux/seqlock.h>
 #include <linux/types.h>
 
 #define ALLOC_DEFAULT		0
@@ -265,6 +266,24 @@ extern void zone_pcp_disable(struct zone *zone);
 extern void zone_pcp_enable(struct zone *zone);
 extern void zone_pcp_init(struct zone *zone);
 
+extern seqlock_t zonelist_update_seq;
+
+static inline unsigned int zonelist_iter_begin(void)
+{
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		return read_seqbegin(&zonelist_update_seq);
+
+	return 0;
+}
+
+static inline unsigned int check_retry_zonelist(unsigned int seq)
+{
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		return read_seqretry(&zonelist_update_seq, seq);
+
+	return 0;
+}
+
 enum fallback_result {
 	/* Found suitable migratetype, *mt_out is valid. */
 	FALLBACK_FOUND,
-- 
2.56.0

