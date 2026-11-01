Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793499232;
	b=EbwqFqsWD7To6CPilZI6Hmt+RGEJ41iC5NbH3XN4mlBLj550+wGb1Kr2SsQE+CJkK2nb
	 9LqBdsGfl3JYh+MtHmtUDM7EVBtMBCZD34l6nIyUzqx/oZd5TuO6oxXSigejB+25SrkaA
	 9QlNnbvmvi+Yxi18H1Kb7cCg/y5BcXX6MX2YuFXOrAYbiTmxKmaXZn3cxu0SfFspWFOhc
	 V1GcBNXfR6B7e3y1940iEIbLczD2/bqJA9V0qm178kr5G2Zs1YXUnr19vMF7bRKyClS2K
	 ESSS+N8cYu1K6fc6RHpY612fOaI2Y2ZUr84nsF4ZQ1f99W5Huzluqq15Gv9hSy+Eraw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793499232;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KAOVkIrNNyhi9D/V3dLJ+NSr5WjrzmwZ1Aks/FNVQtc=;
	b=zDDRHpUdreQf0e2CTFXyZDtDN7Gt7pWmY7YtrwA6iGDFTNlYCXRG13Isnpts1sLIrhOb
	 KeioiXCa9WUPUYWnjd/XgPm1LvovvJbhTA2In7zfNQP+2w/Y1fFEV00Ho3N15vlOZEPq/
	 POIBPdVH78siNvJtrcfgKZ0jk9QasjvjumiK2NWjl16mak8VxqTUKSh3rZuO9dgLrIYbJ
	 0WamFVDUO4JtY02ax4FKOooHBINcH4atDDAmADsu171oW7or66sROu0a+rOBgkA6Ls85U
	 9T5zfZJV9IZ51c3pxvDda+nd/6V32yFnRaSQ6ZAaDaWLrSnTuVAT0s96RwfAeVlTMmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=GQZwPZut;
	arc=none smtp.remote-ip=209.85.222.176
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA84606A326
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 02:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EA84606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=GQZwPZut
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93f20c3aaa5so205260885a.2
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 19:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793499231; x=1794104031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KAOVkIrNNyhi9D/V3dLJ+NSr5WjrzmwZ1Aks/FNVQtc=;
        b=GQZwPZut1+f0LNuk58xvNeHpw5iZVxdxph21KZg7S3cQYqlDaYoC2soU2pe5O0tbrr
         ZM77qC5FcogyagTiVBGGa20b5p+8WvYkrdxZAWuUpyvziaCPjLrF2Zc7+ltF/e99szjW
         IB0LdH3ROzeg288FHmXf23WAI83PduKfy/e2rBeeEQLjyTEmaqMfECko8xjHJnRjkx9m
         MK/ALbLe8W5W8N14SARnsl8bpxsWg2BRRsVPQXFdsk9cwlLQ+GoFtOeM5yqPuMOBJOO4
         crUFvgoV5iOdeGERJZGRRNcww1RBUg63cGdm1q3rd5lQFfoHAgV6sVQKxU8yU8MMdtHT
         upHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793499231; x=1794104031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KAOVkIrNNyhi9D/V3dLJ+NSr5WjrzmwZ1Aks/FNVQtc=;
        b=jfvTEJ4mGfKllE7BK3BIjyDsWO8dNOgrYsvrfTxCCv2hBuC5f5Rx7lf3R8rWjvPeUW
         mdbrst91yxGcdSKJy+mRqy7C3eGMI6UX7vkpDMv3ztRtSEfqSG9s/E9VQdywM66J8Bs/
         P4P5VBHYJwj7Ud/fiJmokoaz92zqqmHYh2zxhmbyim/BMhK9oQj5pEJlCkMYb6pi75p4
         p6PZfYGiHk1zZPdSYZtXnc9/c8tKXW03H1TVgInVn6k60sEavlQAini1OL3oFxZ6Oxa+
         ir6KgvrY8oTBBZ9HQmszexSVI6tkKCjT1d+rz0uLV1xrpqXIkD1yEza1Gtr/JMl6x7Lw
         SP8w==
X-Forwarded-Encrypted: i=1; AKwUvBzF811bWDHubtnlfPcmVFwZ9SjmSYvdscH8C82TyxRTi9KTbl62nfOM9NkOC1x+0eeSb5tiKPE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIiZfafs+ElJDU4uqtYAFCf0JHNly908fTLLvv4yr/ldskT5nyy
	UgCPknoDtu9zvG4wheodIwxvoJ1NeigeSHHW5e2IfbQHIzS5nHrLPvhsxAvHDLJFyyc=
X-Gm-Gg: AYBFou3N4wjp47gVLHGUQncPXm3Ty476j3B8MaKtHfhonqi/nGVvbnPI6zQpY+p2DZH
	flwnTQJLXpZ4agO1LYMlmZR7olJJTk1bY4/5M790fsBdESTVDgI8GPdrNIq2pQx7p4jmCEJghYU
	BgOe3GSM5lGlMon0n0XilMfQaMexgsiCrD4Msj7rLSzRq2c4mv62+ePjZ0LID3ltgqCDcSXYj/O
	nsSLDT8xA20uMk4/w/2/STqEcFPAL5+tEOpIJLVGjn1vuFiZMUUKL1MX5egm1x7bB3p7fifsti9
	NdymR7bcfQVHD/mvu5f0s9wOXOY1jF52MvzPmyqP/Q9X6Wo6PZMxhc7KlWxVEYa8ff01aXmttyJ
	2oA4BJ/M4UloB+9a79BVRJdNZDX8lga1ESNFyQYyAAsxmwtvop/fUxLy7I0IWtYy2z90gAKF0Ax
	nu17b+gYtnfu0VMYK5Lcz6YEsptzWNZyQuZLnP+3cPKb/cjdVo60L5XVWLymF7bzY6/r7cWlak0
	QUn3EOBnU4U8+GDFBSZrekB1dWUQw4HxxhYto1xTEsNaCJMz2rGstFWaKtESHELIRliz0ZcMIt5
	6lmuEx6e7s9MCnCZt7xHszKO5SroLYsOcGk38b8RWkJULoOZeeMsWcjFOYI/1ACJDj9lmAiJXoI
	ak1nC/St3sA==
X-Received: by 2002:a05:620a:254a:b0:93e:6325:ae6d with SMTP id af79cd13be357-9442175ae31mr1053484485a.40.1793499231477;
        Sat, 31 Oct 2026 19:13:51 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425858552sm498131985a.18.2026.10.31.19.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 19:13:51 -0700 (PDT)
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
	Josef Bacik <josef@toxicpanda.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 03/12] mm, page_alloc: pass zone pointer to trace_reclaim_retry_zone
Date: Sat, 31 Oct 2026 22:13:31 -0400
Message-ID: <20261101021340.2251928-4-gourry@gourry.net>
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

From: Josef Bacik <josef@toxicpanda.com>

should_reclaim_retry() walks a zonelist and passes the zoneref pointer
to the reclaim_retry_zone tracepoint, which loads the zone from the
entry again to find the node.

Memory hotplug rebuilds the zonelists in place while allocations are
under way. When a zone in front of the zoneref entry has become empty,
the entries move up, and this one can be the end marker by the time the
tracepoint looks at it. zonelist_node_idx() then dereferences a NULL
zone. Short of that, the event can name another zone than the one its
numbers belong to.

Pass the zone pointer instead of the zoneref pointer.

Fixes: d379f01de095 ("oom, trace: add oom detection tracepoints")
Cc: <stable@vger.kernel.org>
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 include/trace/events/oom.h | 8 ++++----
 mm/page_alloc.c            | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/oom.h b/include/trace/events/oom.h
index 9f0a5d1482c4..cbcf6fe4cc61 100644
--- a/include/trace/events/oom.h
+++ b/include/trace/events/oom.h
@@ -33,7 +33,7 @@ TRACE_EVENT(oom_score_adj_update,
 
 TRACE_EVENT(reclaim_retry_zone,
 
-	TP_PROTO(struct zoneref *zoneref,
+	TP_PROTO(struct zone *zone,
 		int order,
 		unsigned long reclaimable,
 		unsigned long available,
@@ -41,7 +41,7 @@ TRACE_EVENT(reclaim_retry_zone,
 		int no_progress_loops,
 		bool wmark_check),
 
-	TP_ARGS(zoneref, order, reclaimable, available, min_wmark, no_progress_loops, wmark_check),
+	TP_ARGS(zone, order, reclaimable, available, min_wmark, no_progress_loops, wmark_check),
 
 	TP_STRUCT__entry(
 		__field(	int, node)
@@ -55,8 +55,8 @@ TRACE_EVENT(reclaim_retry_zone,
 	),
 
 	TP_fast_assign(
-		__entry->node = zonelist_node_idx(zoneref);
-		__entry->zone_idx = zonelist_zone_idx(zoneref);
+		__entry->node = zone_to_nid(zone);
+		__entry->zone_idx = zone_idx(zone);
 		__entry->order = order;
 		__entry->reclaimable = reclaimable;
 		__entry->available = available;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1850a41f24f7..e14d550d4128 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4670,7 +4670,7 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 		 */
 		wmark = __zone_watermark_ok(zone, order, min_wmark,
 				ac->highest_zoneidx, alloc_flags, available);
-		trace_reclaim_retry_zone(z, order, reclaimable,
+		trace_reclaim_retry_zone(zone, order, reclaimable,
 				available, min_wmark, *no_progress_loops, wmark);
 		if (wmark) {
 			ret = true;
-- 
2.56.0

