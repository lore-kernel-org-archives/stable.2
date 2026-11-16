Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794859470;
	b=bjhQ/oS8fgxRIJzwY0zsMtb6zOfJGXWp1ZBZDW4Mdgvu8ebNXkugaHSjGJqXeL+zD3VR
	 QsIwTHCX6csdTzK1/JbprRvLjcWXn6iye431DwXZJsHog/rq9iZhxmszUrVY74/cu9fKG
	 LC5DtfosaYOycSgKMocMccnt3otKqJn+7awiN/ttMzLXPOoHleINWW8ZLRzRMUUiP0m7d
	 Md12dguJodV90IIO+aRhgwWfEhotOEPHTJY4OMjGwVMZXngf2lSwnuStHSsYkOSrnHwoX
	 HW/A6yn8E4g2EsIK2IcdYc2rmXA+VyiRjjMRiS+ROvTEFQMsX6VrIx1DOVS/8MqzO2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859470;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=RP1wf1hEuo72YiQL0ApBaCY3IcmJDKYfBXmWsofzDvU=;
	b=JrVw/8aIYLk41y+sXrAT96JpBE5nW6n04CIddDyXQgvHy7XNoQ27yqjdGnqWhcMzgqxs
	 2Dcy9aoD+EtjGCV3HYaqGitLO+m4BC/lKSfe+58flXe36ayExi3YbAHSztvzemefMHi1X
	 Q4Mpja/2MjyBhvTdZ7/7Y4MFuc2xAUP1R9O+0Qxv4pMtFUzeQCmlk+wdYktXj1On7QHkF
	 Olck0hFocIfgq3IVnIxg4yCKePrHJJhZ6WyVAc3WHxX5jqITkiBj0idHQsXz9WLpiQdvB
	 nJ293qMJDrDgNRrrZNB8hbQqM9e7MNhEO+w3rk1wYvNCDGZtx3vsqHSyuSyd/7wm8aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=NeXkZ2oS;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=1RiGQrJV;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325D060A262F
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 20:04:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 325D060A262F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=NeXkZ2oS;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=1RiGQrJV
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGJXJZV3840663
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 15:04:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=RP1w
	f1hEuo72YiQL0ApBaCY3IcmJDKYfBXmWsofzDvU=; b=NeXkZ2oSCUmIAaaLYlgD
	uI0urTFRReiqOS0PvsckuTfbI6O7HzwGF99O13+Ri3hvgUi04VyxO/eE/d+9Q0rv
	VBcdlKKP9zpqDVJIsDK6v0hi4ZGLRkpfxN0r2Z26rQfS7wWQY3Q6m8jDuLNA+tgt
	jar/IbiMngx/UXHys2m9quPZl1HFs9ujU6TIAXHJAPANcOmNwjzw+JzZL14wGO49
	jBf/4XOtLGZUY88++QHpxYrcktVlaBRwCsVOJj3d3jj+GFBd/Jtei0DpLMEmlDae
	IDzJhFjzLEkuKdedu13llpY3cU6zUGvCHSXMgTXWNe8d9T/IreVwKLXITU+rBxgg
	cw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4j059sj3wm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 15:04:29 -0500 (EST)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7d65ae19133so2554826137.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 12:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794859468; x=1795464268; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RP1wf1hEuo72YiQL0ApBaCY3IcmJDKYfBXmWsofzDvU=;
        b=1RiGQrJV2n06j/R/EZz/5BjVtYw2+kNMUvNm24O1OhsW+L1kbfPaVsuK7m38cxBDsl
         QxHU5OEYiNUFvsKdYy6ddZ625+aRs3mHCLMZFOrTxfMzGMsRgcLcjBySjPEimdQlcqix
         Snj4LFuoU2fRORu8n0rrxlT9j7ktx5z0b/UIs24jPsuCJs06fyzfgWrgoe7r2hSHtgTb
         P7RhDQQJT2ACIoSBmAPqbob73/S04Qy9MAUJoG0hS4S9SOAgT9jSxzQvrkbnNlnknNj4
         beoB5hKyafHbdjShDf6eiQ8CMqzwJDXFYFYmrju/O/BAn+tXb/SJ6NS0zY2EEW7QtMDG
         gieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794859468; x=1795464268;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RP1wf1hEuo72YiQL0ApBaCY3IcmJDKYfBXmWsofzDvU=;
        b=c7MtDbVzAqVJX9xqITBdpV21JD7vsxMVtYOwuRi+992lf+y3w6i3IB550CmNFQePQE
         OvtJX7q6trqijt1dnZo09CZz2o0Esb0HaJ3JaqIMVUbE2wJOxIxieTwVE9vgWrxEUBBo
         a6Xq8IldpFs/nH0igl4ow2NuChywAgRczW5uVLRawnJI2hBD+5f2r27SiKNjuTzRafRi
         OQ5tFeXKk/ysIPDfzZA4cvBaoqUTKDB1eR4pIsp/Ye1wSabXgv42cmUfiKprHEOvgrWx
         SF1RT4pEhWg6mfG2GsY8VavFMvOUj1FJimsRKHUuek7/TvXSTPplAFr2W0UvImjpfVLQ
         4SzQ==
X-Forwarded-Encrypted: i=1; AL+hErF8qvkGY+BeGyQsBFGaovJGqt7lJehErnw6W3csN8wraEv9pW30GFY8NAP2ACKnPqPQ529CwXs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8BMKI/UIyPiYEnqrZVjupWnarXJVxsGbAckntDytnk+w53/uWq
	1dMp5Xc0IYNNlYXhdD3KyvV5hvgkO1OJVdCsa2ZZYyhxVmWTrVjyrjDIAT5JZbaapY60IBkcZ+O
	0YjFgl1w1grFuAXQ/roMeBumnGrDOkVPeAPhKxKsqUuqzPzqRkQDHLg==
X-Gm-Gg: AYBFou02G1S4/L0pK6/zhb74pML+GJ5q+uSNp2bjMmyYkfYnARvuUzmRwbDcuzYkH6N
	B3gjAuCh4irRKYjVsaWkVnGgOUyK65fczAraN/E2/cDGiSLK1jKruCLEB4oHruicGxF6Pj2vWry
	znSz9ruxgRylSEgaxUpMg0YaolhVlfutZBPHXkXbc43mJsJbHS48KzU6/CQwQBJdUXP8/GMikyE
	n/98PA+qdSorh04bTonlYdpNmofewLKBySqeWj8M17tkTug/5pETVetzkr8Hiqxq9si8xw3C869
	Yv+9X+1ouAtNx3JJkfQcE+rJ1YzLw7o8fDisXkDgYq9RQWn2iNlB57Icm/VMru0nBukzr6dpYbk
	qJWKbBygF0ATXgfISNVjqmc2IHON3N8eaS5/2IE9SANJppHftXl+bZTFe1w4ULhAjh2H32I2A1V
	oM3QqJuNRzR9TIki8ZlylJ
X-Received: by 2002:a05:6102:6051:b0:7bf:74c1:b607 with SMTP id ada2fe7eead31-7d64daf59f9mr3933629137.34.1794859468271;
        Mon, 16 Nov 2026 12:04:28 -0800 (PST)
X-Received: by 2002:a05:6102:6051:b0:7bf:74c1:b607 with SMTP id ada2fe7eead31-7d64daf59f9mr3933565137.34.1794859467689;
        Mon, 16 Nov 2026 12:04:27 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-176-174.net.columbia.edu. [128.59.176.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23efa2edsm93065426d6.15.2026.11.16.12.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:04:27 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 16 Nov 2026 15:02:45 -0500
Subject: [PATCH v2 3/9] fs/proc/task_mmu: downgrade writable migration
 entries in PAGEMAP_SCAN write-protect
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-uffd-state-fixes-v2-3-4397a0196479@columbia.edu>
References: <20261116-uffd-state-fixes-v2-0-4397a0196479@columbia.edu>
In-Reply-To: <20261116-uffd-state-fixes-v2-0-4397a0196479@columbia.edu>
To: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
        Peter Xu <peterx@redhat.com>, James Houghton <jthoughton@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Balbir Singh <balbirs@nvidia.com>,
        "Liam R. Howlett" <liam@infradead.org>,
        Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@suse.com>,
        =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Andrei Vagin <avagin@gmail.com>,
        Muhammad Usama Anjum <usama.anjum@arm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
        Kiryl Shutsemau <kas@kernel.org>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        =?utf-8?q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Breno Leitao <leitao@debian.org>,
        stable@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794859460; l=6344;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=hGDNR/WqM/YeXKLh1H2S+/S9/vDNdjLF5ztTsvussOE=;
 b=QTpWpJnwJIh+mIuTvkIO3+HUHJtrN24GfR7wSh+FX2cPRK20cyW4QzZaaZbm1LdVowblm2J1W
 y50qXyD7ao0CafbW2U7VPMkfpKDGgMVpA5rsNKJ42d4IZB+tSvUSyUX
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4MCBTYWx0ZWRfX6eiFrLjbKtEs
 HlYkT+4kxyCRSmgUwtoLtgb/sBu6xuP4s9iLobHpnVvTU65/L4PhYCE6+bB0B3xQOMqvZ75P9ot
 DgZIBJFZoDuU6If1u6gB5DrgY/n7KE5MEtMADTlLE3ysEymopxca38hQAwhg5/PRyrHskgRjntd
 zbfydOXjsc71fXYkhezs6ARWhg0KI49U+mMH/KaMVE7pFDt5rQVi0a5WHNj/pyKw+0zUBQBiICX
 QRwGe3GxjVAn1YHLEXIR+IPFmvjrg5rZHP5glGWJ2SwN8gft2wtJL1EUqtLOgZ8uEUq4I/w+xk/
 m32K1vKnC3GIuq4CgEZo987wPbXawO45NiK9qQTlNnhqXXhE81Qxhoh4XfkTIuGlqjXMzeEKdOW
 y/fJdL1KsoTzG/MfBhi7eCiGn9MyouI2QL0wNVdxCbS0LhEQawYaCmjHrE8fhYl5xODgk8zRGhO
 87N8wdWDZiPPQxkTjUA==
X-Proofpoint-GUID: lR2P8DXT97fO2hywN1qm1PmpYBvx9zPF
X-Proofpoint-ORIG-GUID: lR2P8DXT97fO2hywN1qm1PmpYBvx9zPF
X-Authority-Analysis: v=2.4 cv=X6THu2Te c=1 sm=1 tr=0 ts=6afb61cd cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=KPY1cyGZ6h6m4ASiENTC8Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=xNf9USuDAAAA:8 a=tHa68p0SAAAA:8
 a=lA3VTUfxpHkutY0wpvIA:9 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
 a=ufIsyHvWW7FwcMbVRpPq:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4MCBTYWx0ZWRfX5vYqSJ1Y1gPp
 iw9EF9+ciAD9puJHV4iBe9/UtLqfZ66Pgv3a9otZBwoTfW6N0fgVC3qgTF7lfyLqUCaVz5MoKKU
 8G02dmQxzQ63EEB6ANDoYqNixBx96xovbeEbE3oZBKsyoLu9ur2X
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11968
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 phishscore=0
 malwarescore=0 impostorscore=10 bulkscore=10 spamscore=0 lowpriorityscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160080

PAGEMAP_SCAN with PM_SCAN_WP_MATCHING write-protects pages in a VMA
registered for async uffd-wp, and sets the uffd bit on non-present
entries as they are. An entry with the uffd bit set must not be
writable, so that the page is write-protected once it is mapped again.
change_protection() therefore downgrades writable migration and
device-private entries to readable ones first, but PAGEMAP_SCAN does
not.

For a writable migration entry at the PTE level,
remove_migration_pte() restores a writable PTE without the uffd bit. So
if a page is under migration while PAGEMAP_SCAN write-protects it, the
write protection is lost. A user tracking writes with async uffd-wp
sees the page reported as written on the next scan although nothing
wrote to it.

With CONFIG_PAGE_TABLE_CHECK, setting the uffd bit on a writable
non-present PTE or PMD also triggers a warning.

To fix it, downgrade writable migration and device-private entries
before setting the uffd bit, as change_protection() does, at the PTE,
PMD, and hugetlb levels.

Add softleaf_is_writable() and softleaf_mkreadable() to leafops.h for
the downgrade. The open-coded copies in change_protection() can be
converted to them separately.

Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
Reported-by: Breno Leitao <leitao@debian.org>
Closes: https://lore.kernel.org/all/avNEgmvYdoukt6MS@gmail.com/
Cc: stable@vger.kernel.org
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/proc/task_mmu.c      | 40 +++++++++++++++++++++++++++++++++++---
 include/linux/leafops.h | 51 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+), 3 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 164b4efc5e09..ee7f509d376e 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2405,6 +2405,25 @@ static unsigned long pagemap_page_category(struct pagemap_scan_private *p,
 	return categories;
 }
 
+/*
+ * An armed entry must not come back writable, so downgrade a writable
+ * migration or device-private entry before giving it the bit, as
+ * change_softleaf_pte() does.
+ */
+static pte_t set_uffd_wp_softleaf_pte(pte_t pte)
+{
+	softleaf_t entry = softleaf_from_pte(pte);
+	pte_t newpte;
+
+	if (!softleaf_is_writable(entry))
+		return pte_swp_mkuffd(pte);
+
+	newpte = softleaf_to_pte(softleaf_mkreadable(entry));
+	if (pte_swp_soft_dirty(pte))
+		newpte = pte_swp_mksoft_dirty(newpte);
+	return pte_swp_mkuffd(newpte);
+}
+
 static void make_uffd_wp_pte(struct vm_area_struct *vma,
 			     unsigned long addr, pte_t *pte, pte_t ptent)
 {
@@ -2418,7 +2437,7 @@ static void make_uffd_wp_pte(struct vm_area_struct *vma,
 		set_pte_at(vma->vm_mm, addr, pte,
 			   make_pte_marker(PTE_MARKER_UFFD_WP));
 	} else {
-		ptent = pte_swp_mkuffd(ptent);
+		ptent = set_uffd_wp_softleaf_pte(ptent);
 		set_pte_at(vma->vm_mm, addr, pte, ptent);
 	}
 }
@@ -2477,6 +2496,21 @@ static unsigned long pagemap_thp_category(struct pagemap_scan_private *p,
 	return categories;
 }
 
+/* Same as set_uffd_wp_softleaf_pte(), for a PMD. */
+static pmd_t set_uffd_wp_softleaf_pmd(pmd_t pmd)
+{
+	softleaf_t entry = softleaf_from_pmd(pmd);
+	pmd_t newpmd;
+
+	if (!softleaf_is_writable(entry))
+		return pmd_swp_mkuffd(pmd);
+
+	newpmd = softleaf_to_pmd(softleaf_mkreadable(entry));
+	if (pmd_swp_soft_dirty(pmd))
+		newpmd = pmd_swp_mksoft_dirty(newpmd);
+	return pmd_swp_mkuffd(newpmd);
+}
+
 static void make_uffd_wp_pmd(struct vm_area_struct *vma,
 			     unsigned long addr, pmd_t *pmdp)
 {
@@ -2487,7 +2521,7 @@ static void make_uffd_wp_pmd(struct vm_area_struct *vma,
 		pmd = pmd_mkuffd(old);
 		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
 	} else if (pmd_is_migration_entry(pmd)) {
-		pmd = pmd_swp_mkuffd(pmd);
+		pmd = set_uffd_wp_softleaf_pmd(pmd);
 		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
 	}
 }
@@ -2557,7 +2591,7 @@ static void make_uffd_wp_huge_pte(struct vm_area_struct *vma,
 
 	if (softleaf_is_migration(entry)) {
 		set_huge_pte_at(vma->vm_mm, addr, ptep,
-				pte_swp_mkuffd(ptent), psize);
+				set_uffd_wp_softleaf_pte(ptent), psize);
 	} else {
 		pte_t old_pte, new_pte;
 
diff --git a/include/linux/leafops.h b/include/linux/leafops.h
index 4c1476ae3234..4c016fc28690 100644
--- a/include/linux/leafops.h
+++ b/include/linux/leafops.h
@@ -434,6 +434,57 @@ static inline struct folio *softleaf_to_folio(softleaf_t entry)
 	return folio;
 }
 
+/**
+ * softleaf_is_writable() - Is this leaf entry writable?
+ * @entry: Leaf entry.
+ *
+ * Returns: true for a writable migration or device private entry.
+ */
+static inline bool softleaf_is_writable(softleaf_t entry)
+{
+	return softleaf_is_migration_write(entry) ||
+	       softleaf_is_device_private_write(entry);
+}
+
+/**
+ * softleaf_migration_mkreadable() - Downgrade a writable migration entry to a
+ * readable one.
+ * @entry: Leaf entry, softleaf_is_migration_write(@entry) must return true.
+ *
+ * Returns: A readable migration entry for the same PFN, which is exclusive if
+ * the folio is anonymous.
+ */
+static inline softleaf_t softleaf_migration_mkreadable(softleaf_t entry)
+{
+	const pgoff_t offset = swp_offset(entry);
+
+	VM_WARN_ON_ONCE(!softleaf_is_migration_write(entry));
+
+	/* A writable anon migration entry implies AnonExclusive. */
+	if (folio_test_anon(softleaf_to_folio(entry)))
+		return make_readable_exclusive_migration_entry(offset);
+	return make_readable_migration_entry(offset);
+}
+
+/**
+ * softleaf_mkreadable() - Downgrade a writable leaf entry to a readable one.
+ * @entry: Leaf entry.
+ *
+ * Returns: A readable entry if @entry is a writable migration or device
+ * private entry, otherwise @entry unchanged.
+ */
+static inline softleaf_t softleaf_mkreadable(softleaf_t entry)
+{
+	switch (softleaf_type(entry)) {
+	case SOFTLEAF_DEVICE_PRIVATE_WRITE:
+		return make_readable_device_private_entry(swp_offset(entry));
+	case SOFTLEAF_MIGRATION_WRITE:
+		return softleaf_migration_mkreadable(entry);
+	default:
+		return entry;
+	}
+}
+
 /**
  * softleaf_is_poison_marker() - Is this leaf entry a poison marker?
  * @entry: Leaf entry.

-- 
2.39.5

