Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8545E35BDAA
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 21:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782163150; cv=none; b=f64sfU/JVcs6l7uzhdS/vl92SSTzJT1/UP7RYzrOBxO8NJZK7Br06eAszVMwXW+KGtXn/j2z5RbKqPf1kCNMEmkCkxKytV3sPUnJYX23pe+pCduXpkkCh+xpMxGGC8pOX4VAuFer2A8i8Ufh+qVFILGb1rwkMc/Xd7P5NujiycE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782163150; c=relaxed/simple;
	bh=ATrTdqo1jlcfQ3mHuUEXHK9/hrNkCyYMvwXtawjP/oA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jpGUzI7/BxUtOEN2vnOkiUxYmmU1q0Q6MMgDQm1brm6P6e2xeqzNDt0XnqCFBRorqWqbyXTRnMpjJl31IKKRQ1WSvfoeTNErKM2Q8JUXMQ8Czzs6uMgAj6Gy8AbDBk5I+j1z+mwhI9xgk6y/+aUkC1VjeopL0mpZW+iQsgxydpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oVXhTpzP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dcmbvoLk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oVXhTpzP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dcmbvoLk"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MJZxbH1541992
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 21:19:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=jbWnur0UQozabsJp1eS7Fj
	jSZ9kDV6hLBfR8H71dKkY=; b=oVXhTpzPWyS8DnIR0ZSDgMtKe3m68zHO0HdM2C
	GJUVZEjE5oOO1sx1yqfha+MMRk7uepuKSwiX7lfx4ezWmioZO17+zLyjNrU2vZdg
	jps+mjEH83oxu+Y006A1Tq4Fbitg6AX7d9wHdCg3TmaRr6o22I5ZYLODxKMCD82D
	sTsIRYNnXEy+m7gOTDnxXrWMaFRnmf9/wR4Xef4W9eEXulEJL0Uv2zedaXQNWzRP
	de3trtraKFECIirHsSSKIeePQw6tAAykA+6qUIOtuSEPmxbwnJqARg0bmZZo4UIN
	BhJv5WNBLGkK3+9aQ7jxlj/ASfiKv2smfQy+GWPS4XE9NNjQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey3a0ta3d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 21:19:07 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c8a247a74b7so2722182a12.2
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 14:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782163147; x=1782767947; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jbWnur0UQozabsJp1eS7FjjSZ9kDV6hLBfR8H71dKkY=;
        b=dcmbvoLkytF12cK0KU46cH/XNJEU/EHsCg/YBE1lg9ys/V4BJaFKDYWIVv/feCEEP6
         DcYTbD6GfZLBghV7ZBPDHefzWJZjIhmmA6rOvCgTat20AR42t5dOV2rSNn7hTx3sy3r+
         2ms7QZYz601WtQx7CUl5VW38UkkoFvWU+VS/hkdvDGFMQK/iOHPzKPlkNSlOjjQZmGbW
         VrR0kaIGexQbTEQgVjDdHjxTSNf85RdY0aoO79h5dXQ3QTKnM4K2H+PbXVjbxi6EZYwR
         28a4Swawie8yuowu3eSoBx97N8asyCNE1HX+IuOkq0h+tv0I6E6DmykxdsUByQ2FKCBw
         gl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782163147; x=1782767947;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbWnur0UQozabsJp1eS7FjjSZ9kDV6hLBfR8H71dKkY=;
        b=ai1qHLg7iFOJXH4VQlG+WtvolS+L0iyQwfiwLsBck/TZ6Y7vN3jJc+LkMyndCTWG8n
         9XyYRYX5VIVrxq44EOaClK/86BU+Yt1coIh8m3OW9qMuBWA4X1E7PzeL3xjSGnL1DFo5
         bEfBcGCHiMViZuQWm6Jf+UkxwEmsreBdUxaoT0Q5RhxaLMeILLAaHcS0vRUBO5xpnAax
         NaFyuJdfyO30IgYMNnW7e3I0XuPqLxguAE0IXbixnKRWu4lsV9RS1KSb8uxaiKPG5toI
         VQZjqGeYjjXrKDAj8TZ+LfL1gsqJ77WEkNQt7Rv+Rs7W8R1Ekl3zfqtoUMzQmtjfkRmF
         zkdg==
X-Forwarded-Encrypted: i=1; AFNElJ+XcpbWd0Of42jlxiHbApjq+WOEFjdbsCDal38sD4YZzB9/1poLiHHSDHDaJ7LUbnVgQFeiVLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyyRotjRBO3A0Ea3gma6JBPnV1dHbJ5r3U4d6bRdSgjFSU1L4n
	SnANNKIifAp/K3tv65QGgksRfNQK+KgcrcPl9C9aDb9ICPu+VNtQrmcq2RxacHFwBeUZw6tyRmM
	nhoAa757b/v5gZfLHBaNm0c+BzsHRLWfdoiR/bjWoAgzH2sOm5wHDYiZTGrI=
X-Gm-Gg: AfdE7cnQGPoTm0APQTL8iMuuh9zOftQDgbg5PpwL9qtF0VD4fnS8rYN9FglQfFwnVlX
	eyhstilkZ7MzKu9YUsY0KPO9JJK4kb6rXCkE558/PuJouh93Xd1ZehJ5wIP+vvTFZwf7H9iIHTm
	3hvSWdAZQ5RIk+AsGAJqVwrpbwb9sUQ/204tlFgnBONfOwj9EzLkEAjhOsIb/x7NSnvq6aqwVVn
	g7ksAVAgsM+WL6H7cv+HLx5WyssUs06KfpvmC0SO7TAAoTT894hnZujyqvAUywXmoXGYkSuvk4F
	OO2J+BWpDpm4o0JtLFr52aIj7+wMiJeM+XyFS0DIcXblWPPLuclpC9Xo77Slswza9OrcnLA8Gz6
	hi2J/T2aUri4MFWtGqKm9U6DxqoZaq7s1mTHyBL6WNN4d
X-Received: by 2002:a05:6a21:3299:b0:3b4:7236:1b5 with SMTP id adf61e73a8af0-3bd15169c58mr183606637.26.1782163146799;
        Mon, 22 Jun 2026 14:19:06 -0700 (PDT)
X-Received: by 2002:a05:6a21:3299:b0:3b4:7236:1b5 with SMTP id adf61e73a8af0-3bd15169c58mr183567637.26.1782163146079;
        Mon, 22 Jun 2026 14:19:06 -0700 (PDT)
Received: from hu-ketakish-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8bc374375csm8380733a12.13.2026.06.22.14.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 14:19:05 -0700 (PDT)
From: Ketan <ketan.kishore@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 02:48:04 +0530
Subject: [PATCH v3] mm: page_ext: add count limit to page_ext_iter_next to
 prevent invalid PFN access
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-page_ext-v3-1-a89799a5367c@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAIumOWoC/22NUQ+CIBRG/0rjOZyAqOup/9FaQ7woLcVAmc353
 wNby4de7na275y7IAdWg0Onw4IseO206QOw4wHJVvQNYF0HRjSleZqTHA+igRvMI2YEFOc847m
 SKMwHC0rPW+py/bCbqjvIMfpx0Wo3GvvafnkSd99s8ct6gglmhajLlFZEsPJsnEuek3hI03VJO
 CjWPd35lO58GnzCeJ1JVcmMqj/+uq5v+tUKU/kAAAA=
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
        syzbot@syzkaller.appspotmail.com, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782163140; l=5625;
 i=ketan.kishore@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=ATrTdqo1jlcfQ3mHuUEXHK9/hrNkCyYMvwXtawjP/oA=;
 b=cZEBwPoANnoLKkmm74TLao3n44k2IM+wtVqqAQ1nadYNuwacQdKggZ9yR3CDkZq3KnSRPMqn8
 vm58lo3BWYlBJB38MA+2Qcc+WDVUV4LZvVcFHgl+dImn9QBMDGfK7Z3
X-Developer-Key: i=ketan.kishore@oss.qualcomm.com; a=ed25519;
 pk=4sb5Ima5x03wc0KSnl57v8kR/7FxMt01+xlZJ53rSJU=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIwNiBTYWx0ZWRfX2LcKojN8NkVG
 WQumJYnL6U5QLhslKtrLP8E6Bh7+oJ+dQLEih+Och+pYblDnfxBNc83T+N3h736tdmvlf+6/DMJ
 dMpoSuljaoAwE3HcJ4Rr4mkkPVDFHoc=
X-Proofpoint-GUID: 4dzdXF5V_RWeSH_KRXoQc-G9AOQSZRyy
X-Authority-Analysis: v=2.4 cv=UJ7t2ify c=1 sm=1 tr=0 ts=6a39a6cb cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=JfrnYn6hAAAA:8 a=hSkVLCK3AAAA:8 a=Z4Rwk6OoAAAA:8 a=1XWaLZrsAAAA:8
 a=iox4zFpeAAAA:8 a=37rDS-QxAAAA:8 a=v2oVMEoAPVEBj90iUNMA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=FO4_E8m0qiDe52t0p3_H:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=cQPPKAXgyycSBL8etih5:22 a=HkZW87K1Qel5hWWM3VKY:22 a=WzC6qhA0u3u7Ye7llzcV:22
 a=k1Nq6YrhK2t884LQW06G:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIwNiBTYWx0ZWRfX1bE2TqxN566K
 DLMbceBY+6tfW9rya7o+Bgjweh9ORk3WkJQkmV4f4JISeRs5Ksn8wCjyRmBnCuXmVeYG0hZ0hCu
 bhp8QlWbI/1Wl+hevmbNbVweQWDXicxi9xX6Y2VX2TiYepIcoe5lTYC0Xpbn8hl1Hoiczfw8wH9
 i0hID6W2oahF7f5f8AEM9XA+NPMO87QICmWg+1zak3hVgXQy7uVPEMzl+7NBb8AFbtSRM4/oxY7
 NMJJLkKJSU+q2FxFPEVBSoCe6q8ONEfgS9zJmo5/y3jobvsJVfWmy16KuiwCpsEOKYEmUCtIfLL
 mbKtW8ex0IE8HvVIUULOgeVActh90p2smyviHVSrZnSLrT7vxLSOfiuE0NVSSftqq2EfV0jF+4F
 aM0Eg7xfnhgLYdjpYiaSaH9Uw1rfg7vVnyclKTeyHqTNS6KFKNuG7QD7RODqFtO16b0ev8vNyej
 DRXQViAwACvV2fk3chw==
X-Proofpoint-ORIG-GUID: 4dzdXF5V_RWeSH_KRXoQc-G9AOQSZRyy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220206

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
Tested-by: syzbot@syzkaller.appspotmail.com
---
Changes in v3:
- Fix the iter->index++ increment to pre increment(++iter->index)
- modify the (count == 0) check to (!count)
- Link to v2: https://patch.msgid.link/20260622-page_ext-v2-1-135d4cfbc42f@oss.qualcomm.com

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
index 61e876e255e8..f23d4b218da0 100644
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
+	if (!count)
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
+	if (++iter->index >= count)
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

