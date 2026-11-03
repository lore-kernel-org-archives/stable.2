Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692892;
	b=DVJcvbvLELu9csCd7l7wehTN1VxwVMXm45q3sa8FUOzgMEAiZp9dkmBzW73Rr1zDkYIA
	 jyIzDUbEJTsaCQawV/FwT8cOpe8QGdq+QswML63yLgbX9PcacwYvW/zVHaITrou7kRRub
	 Wwjv4LL/xNZdYLpIC94npwTz4rvfSuMQUiDv2cQhrRdsyyuiPUGVm9OACkgL30OwDtM1H
	 MJEcRyYJk2yNFUVVifnKIJAUCoelTAg8zCNmjhIwUVGiIsjWCGMygJV5vfrY+8FO+jI60
	 StmO8kvGrlZzLFzxIC1/vycd8yzzWjorazdrmqjyYy4fBvW05zAqCaGN+CY0tQ4tlHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692892;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=52KCXwmm9ZCNyw3KBw/dQ/3mW8BHvTfiOxfI1L0wd18=;
	b=ZMyZOUE4fNgHpm2zQW+nhz4IT3gU073JtnRHtYIdwE4qh37kf7uDC3BoAYChnUEr3TAj
	 QhBskiIPBElebvMWR05pR3+VcGZJevdOKwbOGJDczLHJArY33oFciGCqVjJoIrN+oSxGs
	 gnzh8TfWcEVCQ0Oa7cWCaDdArJH5IemC5YTRQ1Ldx+4wovsx8Fv2T9E8bbqYU9LXe09MM
	 le4XLNKkNIb6JMhgHNrcJJWG4AU123Sz2zziIs2P0DznodygX641LKyNK1/G9t7/29lKO
	 XmBF0qNATRw32mk5wCkPmlwWdN3Fw8lghXLW16sgv8fhgvbuwYdsq2yngd6BCRide3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JAFlrt5z;
	arc=none smtp.remote-ip=91.218.175.104
Received: from mta0.migadu.com (out-104.mta0.migadu.com [91.218.175.104])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A19D606A329
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 08:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A19D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JAFlrt5z
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=EbWR22LQF8i7FNouXAnt5TAEQhSWkm045nRZT2gB0fY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793692889; v=1; x=1794297689;
 b=JAFlrt5zHrloovNEv52uOljvv8Ada0Z7DmXl4q/UvI0lNWNARHqcLu+tgnoV9smUvNdFtM3V
 ZqFyXeby0JHQ5rDDt1Pv7s7aWv6Nu0Cx953nyDoT0eCc5qxvS27yAKVPRODA7czR+ewk9ypLiBi
 qAXe37CDRVPgZvBo1zbRcPhI=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8deed9b99d672b83;
	Tue, 03 Nov 2026 08:01:29 +0000
X-Mizu-Trace-ID: 8deed9b99d672b83
X-Migadu-Flow: FLOW_OUT
From: Qi Zheng <qi.zheng@linux.dev>
To: muchun.song@linux.dev,
	osalvador@suse.de,
	david@kernel.org,
	akpm@linux-foundation.org,
	azpijr@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/4] mm: hugetlb: skip CMA allocations under PF_MEMALLOC_PIN
Date: Tue,  3 Nov 2026 16:01:05 +0800
Message-ID: <5bc00742fe249cf09a3095abccf8889d5fa71116.1793692578.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1793692578.git.zhengqi.arch@bytedance.com>
References: <cover.1793692578.git.zhengqi.arch@bytedance.com>
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

From: Qi Zheng <zhengqi.arch@bytedance.com>

With gigantic overcommit enabled, a fault during long-term pinning
can allocate a fresh HugeTLB folio from CMA despite PF_MEMALLOC_PIN.

The folio must then be migrated before it can be pinned. However,
fresh gigantic migration targets are not supported, so pinning fails
when the HugeTLB pool has no suitable target, even if the original
fault could have allocated pinnable memory outside CMA.

Honor PF_MEMALLOC_PIN in the HugeTLB CMA allocator so the fault can
try the non-CMA fallback, or fail when allocation is restricted to CMA.

Fixes: eb02f14c4a2b ("mm/hugetlb: allow overcommitting gigantic hugepages")
Cc: stable@vger.kernel.org
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/hugetlb_cma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/hugetlb_cma.c b/mm/hugetlb_cma.c
index 95fd2d190f0d2..dde1c866406fb 100644
--- a/mm/hugetlb_cma.c
+++ b/mm/hugetlb_cma.c
@@ -62,6 +62,9 @@ struct folio *hugetlb_cma_alloc_frozen_folio(int order, gfp_t gfp_mask,
 	if (!hugetlb_cma_size)
 		return NULL;
 
+	if (current->flags & PF_MEMALLOC_PIN)
+		return NULL;
+
 retry_cpuset:
 	if (!nodemask) {
 		cpuset_mems_cookie = read_mems_allowed_begin();
-- 
2.54.0

