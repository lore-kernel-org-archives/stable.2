Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A9A3B8922
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 14:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782137707; cv=none; b=r/Cjs3QQPKZOLwPPeQoRiwPlGuvSXTfnAEHpO/U92v7zYjKad2dFWlnYtudk3wfXPPn9xxlboD8L0ekVnGGr5oHsgKT9E6znKMD1TDN0EkKfnyjeK8FCcttxOo1ws11FOzp8I2phGWY+0Hs5cH3cLW+a7XfJ531QizBbU15onZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782137707; c=relaxed/simple;
	bh=NNyPibn7P54f63BQb5tNU5XeaeS5Q9Dj4omuy0PXFws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mKO/Pms7E3uNTafJ+RnHN8nEbjEtHkPk1Ua4zM8kxLMgU1+OCHS5UoSoAiQLZIRQGy+6pP9VuHLRy/J2FFNKDEali2LvbIxU9SlmP3ySoeAtVrPM3bTmm8eArKw7dUbXU4W2s3x9DphMtTb5aC+hxl62YgjSbhQtVUNbNIDUooE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rh7s5zWv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cH06EtTE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rh7s5zWv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cH06EtTE"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MDScXk1120924
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 14:15:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=piffdiB759PLk/akI9k0fY
	EicyM6im7+yWgCdw1Qj5g=; b=Rh7s5zWvgufeNB3bcG4uRUdrek+rbJfP4Oku2k
	p1xL/ot+CjmuaNijQvcxpY5baDYBLbwfomN0QvggpinaCcPWfPQ+vclc8qW3thrv
	DwBbFvFk+Zbhs2xc53qmnLZ0sLJiQfd2+fERbv/J77pbqU4wqFqf5cChyPCWVvI7
	ys8P+q8YLWlyaJQXe1HF6V3hMArJvNGE84Wx09+Djs9rqNhmzeiZY1c53rJztMnQ
	iPSVPphpF97fa/BLe+yuZM/nAP08hQSjHuPUPPmm3JuRftHchK4so1R8EQbcRrJE
	kBcfPgLPdIAXOWXCKCj2Ur571JydRPqBGEBMm3gVs0tvwpjw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5ye85k7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 14:15:04 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36d97955899so2995404a91.0
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 07:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782137703; x=1782742503; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=piffdiB759PLk/akI9k0fYEicyM6im7+yWgCdw1Qj5g=;
        b=cH06EtTE4R0eJtlCxJK5W9RuOKVv8uTA0ZnVr44RT6OkgB+MJNtWYCBI4O1OKD4iIX
         uNtxVfsBYs14xbBPellufe2qSNugYuh2/ohumaBsfGYOExdCCFJXCEY8TXhNsDYd8G+Y
         M6rhDYLPxezWUzTOMcnpkD3vx0rT8ox1mMxDO8DQ5hEesTzuUd4E3e5wm0qP4P/j2Ii8
         VBsyUwlgnS+78yjoLaMOyAQ6JeHdmn7qQMzb+PolI3W68g/SfxU6792Q+cfZqyhcLib+
         A51J6hUQ4yJ2Xn/dao2uyxFg4q452SWGqws1TkY/j7qIozxfeT9Rjjlc+YeX0ohgtZxp
         3Frw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782137703; x=1782742503;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=piffdiB759PLk/akI9k0fYEicyM6im7+yWgCdw1Qj5g=;
        b=WRy+z9ENDd8BrCnWOgYvfrytGTH4CbOCZEL8orJ0+rze2d2adHiT6yQx6NcGYInnQm
         EqwlvQyLUSvyDXcQoicZpEOTC+MBCXxz58fdkBcbJ5cF4iKVhSrZ+rNGtSij/2+jCgAi
         JWMmnI1cL6g6DSn0Tx6x8AoLlhTdN6IPt6+3YQCEPN1EvrH3rDnTmLGO4n02QytFAJo6
         Zng3w4N8WRZoQkm0KXR20XSm3I55M6qojrQ+ciOKgUPTHLG21CFeuWxR4MyBwH31IgXx
         orPv5iKvsbG94xR6v3F9Crg5zdnLUScDVutPD2ePtDOyUymfrknVwzQBBPyUMryGmnBK
         lNig==
X-Forwarded-Encrypted: i=1; AHgh+RqPa3dzhxsisu1fO5hcsXR2RxX2Yjac0/7dnt/Fp3GzD4QTTp9pVcuc09zMQWtCFvpi3P0HjWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiZfBJQwUZK+snLzhzfYjQoZl3j9yiT0xBLi9/WSnXILv0wPSg
	7M7ietJkwgz9P+bSnixMNgc57rbmKo4Omlg9mQt+zOjVSFBUe9kZPJ5PIYP1Sjb2SmK8a47+s+r
	hhgXdqXeYFnsMoOdoluQvCX9YsgwgW1me9SPcbYFD5CxxvYX90BTbUermDiU=
X-Gm-Gg: AfdE7cn2jKRMDNnGqZwS/3oFx0EslmmDD6NxGzLyedMQFRUWwU+UJzP/GkfN0KQmfGD
	aN5tZT0Fp07KBX2316+p7P7HLTuZYywMEurYIPmEMPONNhJzZJad8I705j7jiK5T6UMV++NE9tH
	GnS0TW5ILN9e9CXJAlXtEq7Ahphq7sCINckuewdYyBf6N+SvoIkr8JoyL0XR3CcL9WEglPXDkKL
	FvLtCljYjNwmi+Vxl6YV9zZATIwI+PyfGA642+EGm8e9y/jYNjhesaG4e5rOdVc6DvZKalDPGdE
	ACENlSETkUg9TcpEoxkGqFkP65nShVB+OfAMzp11y6daMkUUdI87WxGBaJZU9i8W8qFWriPH94B
	l7yc9RP0DOZ49aXPjvBzkXvY07oJdnv6+I3LygTfWL/s6
X-Received: by 2002:a17:90b:4a05:b0:369:a359:b181 with SMTP id 98e67ed59e1d1-37d4e86bf8amr11351171a91.23.1782137703286;
        Mon, 22 Jun 2026 07:15:03 -0700 (PDT)
X-Received: by 2002:a17:90b:4a05:b0:369:a359:b181 with SMTP id 98e67ed59e1d1-37d4e86bf8amr11351115a91.23.1782137702690;
        Mon, 22 Jun 2026 07:15:02 -0700 (PDT)
Received: from hu-ketakish-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d1558b599sm10382253a91.7.2026.06.22.07.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 07:15:02 -0700 (PDT)
From: Ketan <ketan.kishore@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 19:44:54 +0530
Subject: [PATCH v2] mm: page_ext: add count limit to page_ext_iter_next to
 prevent invalid PFN access
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-page_ext-v2-1-135d4cfbc42f@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAF1DOWoC/0WNQQqDMBBFryKzbsTEJkpXvUeREuOoKdXYjIpFv
 HujpXQz8OD9NysQeosEl2gFj7Ml6/oA4hSBaXXfILNVYBCJUIniig26wTsuI0s51lLKs1S1gaA
 PHmu7HKlb8WWaygeacd/vRmtpdP59/Jr57v2y2T87c8ZZmukqT0TJdZpfHVH8mvTTuK6Lw4Fi2
 7YPXaj/8rkAAAA=
X-Change-ID: 20260616-page_ext-31ef555456fc
To: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Brendan Jackman <jackmanb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
        Luiz Capitulino <luizcap@redhat.com>,
        David Hildenbrand <david@kernel.org>
Cc: kernel@oss.qualcomm.com, stable@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Ketan Kishore <ketan.kishore@oss.qualcomm.com>,
        Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782137697; l=5361;
 i=ketan.kishore@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=NNyPibn7P54f63BQb5tNU5XeaeS5Q9Dj4omuy0PXFws=;
 b=x3ahtd2rZYMUyig22NRD3pdqrNVhc/v5mZUHL3Dqupr++LwdYEppRZ4I9G4BQiccDsqOLvMEa
 UuRC8mI5d6mDeEqG3F1Y87zdS+UczTa95RQVa/JXI0h+AWiUbPPiT1T
X-Developer-Key: i=ketan.kishore@oss.qualcomm.com; a=ed25519;
 pk=4sb5Ima5x03wc0KSnl57v8kR/7FxMt01+xlZJ53rSJU=
X-Proofpoint-ORIG-GUID: a4bpyPtHBfwC64pnJyf6_6-i-lACLCef
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE0MSBTYWx0ZWRfX557P6VhxFBTb
 mDPGCnAJJLtt5uKoRw0szRjukR7Ol93L/71rwI6k+Bh5srNXJuJw3nYo01pFj9siUFdkUDxdMVo
 jBG70lDJTru9POu8kB/cp/HZgJu1JGY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE0MSBTYWx0ZWRfXwVfw1KIW+0SO
 l+exOWEpm7K+nxvhN4my+jH6OjCKl9gwplj2Cdau77Ko88AR42GZEaLW7+qmtNn5QHNFFCY09qo
 wB/O0LcjcNdIcITRF5Ojnqh49VtAPDRhJse2MRSH1mn9ztzLjIa1xpcbgTnphW59s+Pb/iAugr6
 b1FvdJXNjdt87eByRSM0qJNTYkwZ5mtXlIm9OzXAS167Z8IpjY+dEjt6fxoK3BjNZsHlOxofHg+
 Q3t6Pg2XGp3HMXj7TFNnKRn+5kM6dgSciHeR60OdxHct0/f7VXi412yM9TTFrwWXFpSRKv1TjqH
 JstGV0jeKaXVt7N2jXrX05ZqxLelv4IaKppYhQdffpD0eZFH12IAhS7NAy9njmd4k3ky8TsX8wc
 RfxbSnNDoub4mdOGmHVch8ful/I/DiXVR9m1BMMPnBWeri4VezI7srqjpy/634WKWJWbKS5NU+u
 igAAclGa8L8vTMFdWzA==
X-Proofpoint-GUID: a4bpyPtHBfwC64pnJyf6_6-i-lACLCef
X-Authority-Analysis: v=2.4 cv=YpI/gYYX c=1 sm=1 tr=0 ts=6a394368 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=JfrnYn6hAAAA:8 a=Z4Rwk6OoAAAA:8 a=1XWaLZrsAAAA:8 a=iox4zFpeAAAA:8
 a=37rDS-QxAAAA:8 a=v2oVMEoAPVEBj90iUNMA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=FO4_E8m0qiDe52t0p3_H:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=HkZW87K1Qel5hWWM3VKY:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=k1Nq6YrhK2t884LQW06G:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 spamscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220141

The page_ext iteration API does not validate if the PFN still
belongs to a valid section while advancing the iterator. When
dynamically adding memory in the hotplug path, it can lead to a
NULL pointer dereference during page_ext_lookup at the boundary
of the last valid section when iterator count equals __pgcount.

The for_each_page_ext() macro calls page_ext_iter_next() as its
loop increment. for_each_page_ext() does a
"__page_ext = page_ext_iter_next(&__iter)" at the end. This
causes page_ext_iter_next() to increment iter->index past
__pgcount and call page_ext_lookup(start_pfn + __pgcount).
During memory hotplug (online), the PFN at start_pfn + __pgcount
may belong to a section that has not yet been initialized,
causing page_ext_lookup() to trigger a NULL pointer dereference.

[   14.555124][  T846] Call trace:
[   14.555125][  T846]  lookup_page_ext+0x6c/0x108 (P)
[   14.555127][  T846]  page_ext_lookup+0x30/0x3c
[   14.555129][  T846]  __reset_page_owner+0x11c/0x260
[   14.571201][  T846]  __free_pages_ok+0x5e8/0x8e0
[   14.571204][  T846]  __free_pages_core+0x78/0xf0
[   14.571206][  T846]  generic_online_page+0x14/0x24
[   14.597782][  T846]  online_pages+0x178/0x30c
[   14.597784][  T846]  memory_block_change_state+0x284/0x32c
[   14.597787][  T846]  memory_subsys_online+0x4c/0x64
[   14.597789][  T846]  device_online+0x88/0xb0
[   14.597791][  T846]  online_memory_block+0x30/0x40
[   14.597793][  T846]  walk_memory_blocks+0xac/0xe8
[   14.597794][  T846]  add_memory_resource+0x280/0x298
[   14.656161][  T846]  add_memory+0x60/0x98

Move the iteration boundary enforcement inside the iterator
functions, so callers cannot inadvertently access beyond the
requested range.

Fixes: 9039b9096ea2 ("mm: page_owner: use new iteration API")
Cc: stable@vger.kernel.org
Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Ketan Kishore <ketan.kishore@oss.qualcomm.com>
---
Changes in v2:
- Incorporated comments from David and Matthew to check for invalid PFN
  in page_ext iterator rather than checking for NULL section in
  page_ext_lookup.
- Minor improvement in commit description to include the issue with
  page_ext_iter_next
- Link to v1: https://patch.msgid.link/20260617-page_ext-v1-1-37ad802b1a38@oss.qualcomm.com

To: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>
To: "Liam R. Howlett" <liam@infradead.org>
To: Vlastimil Babka <vbabka@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
To: Michal Hocko <mhocko@suse.com>
To: Luiz Capitulino <luizcap@redhat.com>
Cc: kernel@oss.qualcomm.com
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/page_ext.h | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index 61e876e255e8..4f7d7a8709de 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -120,14 +120,18 @@ struct page_ext_iter {
  * page_ext_iter_begin() - Prepare for iterating through page extensions.
  * @iter: page extension iterator.
  * @pfn: PFN of the page we're interested in.
+ * @count: maximum number of page extensions to return.
  *
  * Must be called with RCU read lock taken.
  *
  * Return: NULL if no page_ext exists for this page.
  */
 static inline struct page_ext *page_ext_iter_begin(struct page_ext_iter *iter,
-						unsigned long pfn)
+		unsigned long pfn, unsigned long count)
 {
+	if (count == 0)
+		return NULL;
+
 	iter->index = 0;
 	iter->start_pfn = pfn;
 	iter->page_ext = page_ext_lookup(pfn);
@@ -138,19 +142,22 @@ static inline struct page_ext *page_ext_iter_begin(struct page_ext_iter *iter,
 /**
  * page_ext_iter_next() - Get next page extension
  * @iter: page extension iterator.
+ * @count: maximum number of page extensions to return.
  *
  * Must be called with RCU read lock taken.
  *
  * Return: NULL if no next page_ext exists.
  */
-static inline struct page_ext *page_ext_iter_next(struct page_ext_iter *iter)
+static inline struct page_ext *page_ext_iter_next(struct page_ext_iter *iter,
+		unsigned long count)
 {
 	unsigned long pfn;
 
 	if (WARN_ON_ONCE(!iter->page_ext))
 		return NULL;
 
-	iter->index++;
+	if (iter->index++ >= count)
+		return NULL;
 	pfn = iter->start_pfn + iter->index;
 
 	if (page_ext_iter_next_fast_possible(pfn))
@@ -183,9 +190,9 @@ static inline struct page_ext *page_ext_iter_get(const struct page_ext_iter *ite
  * IMPORTANT: must be called with RCU read lock taken.
  */
 #define for_each_page_ext(__page, __pgcount, __page_ext, __iter) \
-	for (__page_ext = page_ext_iter_begin(&__iter, page_to_pfn(__page));\
-		__page_ext && __iter.index < __pgcount;          \
-		__page_ext = page_ext_iter_next(&__iter))
+	for (__page_ext = page_ext_iter_begin(&__iter, page_to_pfn(__page), __pgcount); \
+		__page_ext; \
+		__page_ext = page_ext_iter_next(&__iter, __pgcount))
 
 #else /* !CONFIG_PAGE_EXTENSION */
 struct page_ext;

---
base-commit: c425609d6ac4012c8bbf01ec2e10e801b1923a7b
change-id: 20260616-page_ext-31ef555456fc

Best regards,
--  
Ketan Kishore <ketan.kishore@oss.qualcomm.com>

