Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793222376;
	b=X5YmuqZR3EkEV1tHiVpPafd0RrR8sqBFH/Fjw/rkAaSRIkQQAI34TEcXdh4VZfaM7Mz9
	 vxZvtec78Md+RmLJYcAMCYc1QTYAw7wxKRmMaTbV4Qskg4MDRDSXEgDvXuKTmnfdVXlNs
	 H3yOwKjzdPV6iM1w6hSB4q4gSYg54opZAJXDKP1HpZY/LgavX9DSaVbSb4ArsaTme5YjS
	 evAIsBp0Ig6+0XGg/B35E+ivA2b6gRcPvAeZGycUNBJsU0fYa+xi3tA8nCCE2TfMLeYL4
	 GIc4WEUIUjWs5vMtoYqgdG7dB3EKnq3M6GKifcNvSxQgah5EW6y/p2aICu0dDm6ooIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793222376;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qyE3BvZ22dE3cQ/ON5Q1I/RqepT+3oR0Tr4bDbH+x1w=;
	b=jlIbqVmxRhRa2USrfvBxHI2AhzXHGtfxPbPnOL+97qtnGzjJkz3PinV2cIeDQyqU2y2E
	 hEseuvRNYyHdrSpLAtMcP0PoiKZAutZv75VclDHADNYFXFheJ0q0QYYcuLzw9kZSJVWHD
	 8ESCBgsnrzhBZXvnysheaTwLGLlgsuRJL5RKMGsxzcszz0VFu2EB6y2baob6oAcOzk1Dc
	 aps4q8Vac3yR4NN4KqaLyLpshR1m2gi+uEV4tLJOwYsahkotjD9i45kyijpAbECh9DFa/
	 DtkgURbG2bA23ppEjcBHSbsz1sM7Iyi3FfiFKf4kjQiUrmVQPrLWw3eQC8YcYQIk7Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=EvUYa4qw;
	arc=none smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD110606A327
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 21:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD110606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=EvUYa4qw
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-53664b4860bso16367481cf.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793222375; x=1793827175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qyE3BvZ22dE3cQ/ON5Q1I/RqepT+3oR0Tr4bDbH+x1w=;
        b=EvUYa4qwi5SXGlC+UBEqHZqCvIE+YN7S91MM+EArmzp+wW6PtPPCdYah7QR7pPuEV1
         kW0ErYOPNz8OBaNREFnU+5/l4NXYle4OV5lMBrS6/iuI0UH8XrYurRwujjvxt7sccV2t
         rBW1i3lzdelTGrdAvLBNW2jwZkoAVVtKoYb2pXtBGt2TPjXRUoDWOr9Fyq3xSbnGmemV
         Fdz4M/IVO9zxmsmKbX/Fct7EtbxHXLsO+aUgGOtWukXy/6y+wLR5cnQAUnjpDiv27wWG
         bLvnB7x3ITeoxdCPJM9AD6+RjehjMiZOhwFdXioBjZsPb82u+HGkdPsZRWjZ7Qdez4ho
         tezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793222375; x=1793827175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qyE3BvZ22dE3cQ/ON5Q1I/RqepT+3oR0Tr4bDbH+x1w=;
        b=OWiKGmZ+KulWNsGsToqzRJ4EEFuLflSvmpwlnt/JEOUSup07UNo5CjieaVW6VnXmYb
         lgyzyTfvJ5rhwGR9KD7HKaYksQsHG8VmiVnggc2zJ9QQneEgKw3DzixckZ3h2c4youkQ
         argpdBdTVa31u5sgHAaKAMHOrYNCdKvBnGHMcRrhl6r4kfDwt1r/0B4XGBMkWOfq2Sqe
         j4Y4jVXRpmdA+crRBO/IQorWLRMu0CZFrpuwxb2Z6Q7r05Och6YfNgw9ZeosEwHDXi1H
         UMHgP6QTOj7beEPYB+7MEVm3JB9OG66L2+bnMX6Gf9M/inFjisf62Ev7LK8Z5A57olb3
         MjcQ==
X-Forwarded-Encrypted: i=1; AKwUvByIv2GwqHRCXTjcVGnfdPq5yFjhVPGYeuDVj1bNWmGdkE+A/FMZloeH4PnAd41xqFeNQVVnWhs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJEiOIhvQkQSi7q2RbLVJ5xm4pqnOzZd97tBm/Jp4YddpKrl5m9
	QPW6HykovooCVJPX4Ha2gdFhHTsdr23QE8DtZQzDFa+++6NIaK8+YrvQBXIxdm7G6m0=
X-Gm-Gg: AYBFou1aXm1rRTAzeUzHDyHK4xBYgtqJcL/V8mcEUjjC3M8h4yricb94QBY3Yw/7pC7
	BiCj0ZGgRvk6w+MSlJDQAMt1jtREg5LC6ePl2h+7KSpnzRBWcS2AEdJNhF2rOAiwLUuvBxxrT/W
	cTwxVXNMEeL8/HRpho6050j0ZessFaW3HfqHqlOo3QhQHsYf1J3BnB/deNqNiBoiWH0lQ9YoxBG
	Sa39ko8WQlAtlxVLWDOyEubbO153Uxe2mrVwdvT7gAcf2i6z87w1+KFQy+HRtbm2OrKg++9qI9i
	dP+mYdEOe3jobglneagdVzUFcOvwG+j7/0SHWjoN6ZbC153jTYccVg0A828xiuHpBNO7NXJJU59
	bVmmevc8cPy+cnsAvWbRqM+PcrQc/3az3wYJ1GvBsS/QH/t35/PskjGIE3tU7oF9XnkTL3/OgK+
	fFu1X48Z3g+s0BHfuTrZRTwOZmkVgPh4F2DlYTMY5Z9TBRPUoMOwlm2xFfk3MfI2DMlRijsHyLR
	idnoAgWs8xR9mKvPXre5m0DEXJSLgtAfaXo6OregFYbgFYCacDLunixUZDSLDg92Bm8TIv4mdHl
	am7bzymUkiJ7RMy8Dso/6ZXLMD6TPric4FrT3/tIjmwYvrNacFXsN6lxIzl/wIBycquqVpeSESc
	In3aUT/T+RGAXA2U=
X-Received: by 2002:ac8:5d47:0:b0:535:b506:11c6 with SMTP id d75a77b69052e-53fcc7ca8e2mr64934561cf.57.1793222374554;
        Wed, 28 Oct 2026 14:19:34 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47a6d598sm139778966d6.3.2026.10.28.14.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 14:19:34 -0700 (PDT)
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
Subject: [PATCH v4 1/8] mm/page_alloc: reset can_retry_reserves when the slowpath restarts
Date: Wed, 28 Oct 2026 17:19:23 -0400
Message-ID: <20261028211930.3504634-2-gourry@gourry.net>
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

Commit 2c4c3e29897d ("mm/page_alloc: simplify __alloc_pages_slowpath()
flow") retries an allocation once with reserve_flags when the caller
becomes eligible for reserves, guarded by can_retry_reserves.  The flag
is set at its declaration and never reset.

A restart after a cpuset update or a zonelist rebuild drops
reserve_flags and comes back with can_retry_reserves already false, so a
caller that cannot reclaim, such as GFP_NOWAIT | __GFP_MEMALLOC, fails
without trying the reserves again.

Reset can_retry_reserves at restart.  Only a cpuset or zonelist change
restarts the slowpath, so the retry still runs at most once per change.

With kprobes failing every attempt without reserves and the first with
them, and a memory block onlined during the walk, the allocation
returned NULL in 3 of 3 runs, and a page in 3 of 3 with this change.

Fixes: 2c4c3e29897d ("mm/page_alloc: simplify __alloc_pages_slowpath() flow")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/page_alloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2daf358269ae..78569ac6f2d9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4783,7 +4783,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	unsigned int zonelist_iter_cookie;
 	int reserve_flags;
 	bool compact_first = false;
-	bool can_retry_reserves = true;
+	bool can_retry_reserves;
 	unsigned long alloc_start_time = jiffies;
 
 	/*
@@ -4817,6 +4817,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	no_progress_loops = 0;
 	compact_result = COMPACT_SKIPPED;
 	compact_priority = DEF_COMPACT_PRIORITY;
+	can_retry_reserves = true;
 	cpuset_mems_cookie = read_mems_allowed_begin();
 	zonelist_iter_cookie = zonelist_iter_begin();
 
-- 
2.56.0

