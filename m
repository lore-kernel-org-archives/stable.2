Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793222383;
	b=CwNLrl1nYrfMFOVhf4Vib04HNB5+kRqSidX2a67n49AHPfiZbQ0qtYPw5pueGrwrDNT3
	 VBWdSqc9UGqK2FVGWiFQg9r11TqCCYwIstfUQkOteV4sBnIKR2XHBz4xifol+/GW4c+9w
	 JLCWT2jwtXpaGuzlUQ2Q5Wct3X6at3K7CXZnVDdKxH6ceh3ckZOJcLG1u4y8GfNouWQsE
	 pIkLwJwyLDQrvMQ8+ADS65jZeo8XeDc22YDKD2IPX92H+3CgxDKu9dH1QqU6Jz1UfxEAb
	 Nw1OGpuAgfKTmsrGDUlHB+EH6/879kB60A7JZaj1XcafuWyfyt1T83Zt2mGa55OVgRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793222383;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ZIgZaCWO7ouB50zgNC7x8DTFvAXbflI8ZAgrOwWkY6A=;
	b=DM9yiPS6ClnHvRplbItIjYAyoN3BgDx20MG+gh8SsnoeqmXXcDYdPItmJUHbEozty5I1
	 SZIKaEX/AfkfkYYJnyYiIhZovPP/dr/+YSBiWg2r6lZbM0SYHOTrt+2PnIhhwdNFN3c87
	 UZAUhKWsd0vafKotGcLI4rdOSLA4BZhi6IQ+hnWQj6Ps94KQIwLINpjvd3IgttkgM07Zp
	 LlWKpBedsUHu7tp2kIVz1S0TPpozZ3wwFBOSpDP95ZYrymKfGkOSGGnwgAP9wEodtEcZe
	 X86C5VK6HGunoKpAfyZSaDql2er95lW9s/j6ppk7Pk7EYmkPp2RshLp7ie6UH6A/ERw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=XobPomqO;
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9521D60A2635
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 21:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9521D60A2635
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=XobPomqO
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93f1e5d7450so121903385a.2
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793222381; x=1793827181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZIgZaCWO7ouB50zgNC7x8DTFvAXbflI8ZAgrOwWkY6A=;
        b=XobPomqOGjQ2JuRdVXXlnoFmj2MGfcqu2NphESlZ6ykYJ2KjP9b7lKBuKcF8W+3ozx
         e/rE9lSgiZhGX82YHC+I0n1vz+VW/o91RudyYt9haN9/AByWS8eWjAUw3GqlgSJU6Lx3
         m6O48aUdjb1KKJKPactK+Mb73t9blmLzbHQoYUeSHg1by1OGRwifOBhVrLf9Y0mxa6el
         Vjb9xmDQqzfj8kEE37LWWBBiod5wiky3yGS4B1NM3MsKgW1Kgm5W/z40/L4Wk6LV5AVL
         Eeu3jVtwqiQCPEdGuWLx3RaI7BaXP2PX/X6SH+zwRakr6CTDCkXKv9GpT+SBjXgvQ0WP
         q7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793222381; x=1793827181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZIgZaCWO7ouB50zgNC7x8DTFvAXbflI8ZAgrOwWkY6A=;
        b=eR534JoAAtGmc/mMIw/wTXEwRSRZwPOFSSjByS8GQCv1Iix8BYT0FNl2IS129yK6Pq
         HlLgBBYLkH57US+uL9m3U1FDlj6xrU86ZXkpzS0FCp8I/Fg6F1pVjFwIljiMwwdE4VIv
         zB5hl450yNisRH0lXr446efFuxeiSjFpz7Km5y+o+PdjpL5BuRMNZK109DNAp84iR5z8
         f91KP6i9aWZYo5zY7QflWeO8pqi473ThFOneasojtSjSIl1TxKrfVQ+TqjKevr2Jr2v8
         mt/kMiN4p9huqVWa67q/R+92YnZXZIgIsk9J76yliU+cpFDa75TNjH4RSj00j9/N8VRp
         2mkA==
X-Forwarded-Encrypted: i=1; AKwUvBzxXNRDKLwLga6pMT5AmQDdPNRZ71EY7kzCqVEEocWN7Iok3okJFsUa/fvq+JdalvJd7sj3PBw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIIF057a7/wYacMMiKJeyREcHXyKFBQn5iGFh91uRTgp54QQ63O
	cKYoONz2GE1aFbLZgkS6AD9Ji570SAHCRL+JuB0LizZXffpOpQ+Ihp8PWTAYhGhissE=
X-Gm-Gg: AYBFou18ouYcrSgRGNK6S2nADtuM/SRK6TxeR8hqRdCWTsHSATVq3X0C1YblO32gdjv
	kdgS/oqWo4cS+l+ZnaYi3EJzDm1F+itXFrPk1baRTCZUb+2sJb0x+i5rlMg0c9DQUX/c/yggUhH
	hJRwg+twLgeqTUNG1bY5ni4xN5SOlC/h4yvnG77rN1Fm1hHn8B1rCJFnysAjqEk12u1zzG/ptQL
	eiV84+YHlv+yU7NjDFE3WHiWvKNjnNMKxWALvpbhXcejV2pTYs3g24GneqcuvF7EkpCIP5TjTas
	Q1/Tm9UXqYHJZqNZJDK4BSEkT85uDfAHpdXr1v5/B+JuXMcpKWq3VGg1DdGxNFWsVivRqc1L577
	8R3e/OVw2ZMMzlO8YZ5Lk/3ezq+sXN5En3m8quFwWTJdwKHOWG4z6Inw13ERIJCZmRki8MPoZdy
	cuhAGxHZM3wv2lSYuDP0LVBy8fFL0ChDAJpTfyoAhbB7hq4E14H6DFkoTcUqMWmoeXtmjzSHtzW
	QozTRs2cjhmYitEoKH9M5EsmLb6dvDPcfknJmV7sIXrev175INGa6AXOJzCbvOqssI0AyxTdcsZ
	FfLvasbfn4Pd0B2s8GH+1b89ZRnN/RnglkPwesTUvrejrdl6vqhnVNbl3Vpl8zUqGU4FbHosN7l
	CBhYyL2n4IMxtgGM=
X-Received: by 2002:a05:620a:2629:b0:940:f224:5a85 with SMTP id af79cd13be357-94408d6a286mr556498485a.71.1793222381385;
        Wed, 28 Oct 2026 14:19:41 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47a6d598sm139778966d6.3.2026.10.28.14.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 14:19:41 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	david@kernel.org,
	akpm@linux-foundation.org,
	gourry@gourry.net,
	ziy@nvidia.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	mgorman@techsingularity.net,
	anshuman.khandual@arm.com,
	stable@vger.kernel.org
Subject: [PATCH v4 6/8] mm/hugetlb: retry the pool walk when the zonelist is rebuilt
Date: Wed, 28 Oct 2026 17:19:28 -0400
Message-ID: <20261028211930.3504634-7-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028211930.3504634-1-gourry@gourry.net>
References: <20261028211930.3504634-1-gourry@gourry.net>
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
 mm/page_alloc.c |  4 ++--
 mm/page_alloc.h |  3 +++
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b37d7d0db7fc..8edf323baf0f 100644
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
index 33aab9deaaa1..70830689048a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4411,7 +4411,7 @@ EXPORT_SYMBOL_GPL(fs_reclaim_release);
  */
 static DEFINE_SEQLOCK(zonelist_update_seq);
 
-static unsigned int zonelist_iter_begin(void)
+unsigned int zonelist_iter_begin(void)
 {
 	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
 		return read_seqbegin(&zonelist_update_seq);
@@ -4432,7 +4432,7 @@ static unsigned int zonelist_iter_sample(void)
 	return 0;
 }
 
-static unsigned int check_retry_zonelist(unsigned int seq)
+unsigned int check_retry_zonelist(unsigned int seq)
 {
 	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
 		return read_seqretry(&zonelist_update_seq, seq);
diff --git a/mm/page_alloc.h b/mm/page_alloc.h
index 2b1017a91928..53df6b8a0c00 100644
--- a/mm/page_alloc.h
+++ b/mm/page_alloc.h
@@ -265,6 +265,9 @@ extern void zone_pcp_disable(struct zone *zone);
 extern void zone_pcp_enable(struct zone *zone);
 extern void zone_pcp_init(struct zone *zone);
 
+unsigned int zonelist_iter_begin(void);
+unsigned int check_retry_zonelist(unsigned int seq);
+
 enum fallback_result {
 	/* Found suitable migratetype, *mt_out is valid. */
 	FALLBACK_FOUND,
-- 
2.56.0

