Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.117.225.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095889;
	b=lfVXLHcosE8Ka3bTTzrhKhVoK/HwDwgHUyiyI0qVex5p6KrCaT0VtYvYWNa62I75JLC0
	 u47DiaRCqbNqeHS8FnlM5Pw81RVndCADqExWS6p1h/VDG843a4vxX3Mb+i7s8JK0MQr9S
	 SiYiVxkgN5pq6HiIOt467IjqctAC978i96bWiYgbChUT6hJtt9efYI2JBIhOaquQg61iA
	 vkYkst2du4RIskzxrUWaEw/ZzigzHk+J91EFwv4PXVtJ0LVB6aySWlYgEgFbYIQ5tsUVx
	 llcdpEEffM2gR2ZUueFXghw1PjnYu+S8CkP8i3QtvX3/ROPMxia1Fh9kkOMfB1Mt02Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095889;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Avwvbw5yVGFVbipl1tuQaWsH+u0bWEZomnuCQzaz/wM=;
	b=fZRmuOW0Gx2ve4KB8qqyKKYXCVJZlnjBS03v+7WTOaiABUIW2Q4NF2Gnaw1tzaPwKrQn
	 cMyufAvmufDMwjxUq6Ed9Z9LLq/mnAy6t2Vvo/bKZANC2A17ZLd00/rieXz65awOqDnW1
	 71WPuyCNtRFYF5wfk/40+PonU+PcdBDrSj004FD6SK3nPm4AnARg9k98rf1ns1yV2epgU
	 EIWvoZQLZcKK2QZvOh/ud0YGrAqLwVxoaPR/EJi4dG+vSF03+qJzIqZs5N8Et8SKvOctf
	 9jPe74RIFXShy2ih8IReW2Ko2nKx1MwPEeWLpmJFQO/Sp6ffMKc1+60Z8AzBSKm18nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=virtuozzo.com;
	spf=pass smtp.mailfrom=virtuozzo.com;
	dkim=pass header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=relay header.b=nJUV7HiT;
	arc=none smtp.remote-ip=130.117.225.111
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DA2606A334;
	Thu, 19 Nov 2026 13:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14DA2606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=relay header.b=nJUV7HiT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=Message-Id:Content-Type:MIME-Version:Subject:Date
	:From; bh=Avwvbw5yVGFVbipl1tuQaWsH+u0bWEZomnuCQzaz/wM=; b=nJUV7HiTdclgnbZnBV+
	xGN/fk00ik+jXN9tHPLxJfjZW66pMws079Bt37EGbYHTV5T+1BLAZbtosglwm6ghIog/SQaviMf8/
	+ri0Zw71iVlBcEkSXcpU6cJdX3mWnJ16CXrIv+bsCE6DytUHWo0nNOJ5hHyCtSOVj5vi0ZvHCI1we
	580ZgAq14CFZohYZw9Q/8BP7iXXehnCXkAipiYHtZgHEw7DXw7QM/EfKZ9mO9TE/5ZH5/OjO+b+Er
	EWHkFhwPwdab50WF/GBK7KAU9UdLu+314KuxAnY/FzM/p6YR+jHL2vM/s0UUxXOeuh7ZYgpXzcUEi
	wmqN1//9ZlaxGhg==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=f0.sw.ru)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1xU2R5-00FBqZ-1q;
	Thu, 19 Nov 2026 14:44:23 +0100
From: Konstantin Khorenko <khorenko@virtuozzo.com>
Date: Thu, 19 Nov 2026 14:44:02 +0100
Subject: [PATCH v6 1/4] mm/rmap: duplicate a PMD mapping as one in
 folio_dup_file_rmap_pmd()
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
Message-Id: <20261119-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v6-1-efa7817a2bb3@virtuozzo.com>
References: <20261119-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v6-0-efa7817a2bb3@virtuozzo.com>
In-Reply-To: <20261119-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v6-0-efa7817a2bb3@virtuozzo.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, 
 =?utf-8?q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Konstantin Khorenko <khorenko@virtuozzo.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, stable@vger.kernel.org, 
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1355;
 i=khorenko@virtuozzo.com; h=from:subject:message-id;
 bh=+iGJSVU2R69oAcxSbe2V0t1MH5H7H4D9RsN+PXcW2vM=;
 b=owEBbQKS/ZANAwAKAVGWCkf5YVwqAcsmYgBq/v02Zu43V/DlG+vTb7VK4NcMAFw3SzTFPDVM+
 +YbLiHc7l+JAjMEAAEKAB0WIQRWD23IPcXT0GO9CCxRlgpH+WFcKgUCav79NgAKCRBRlgpH+WFc
 KhVUD/4pdhUvXjEatrjVm+jK1BFrSOHbw9X0CfsIn+VWgL6wUjy6J6Enx/FE0MRtjtxUuGSP+rv
 LOu2pQQpRDBWsLf3rYPh4BaDE0/54hwlCxSOsShmzV/gd73uBUAms0Jtka4TPPqVhWjh52Z/1+2
 E7gevPrBJBp9AryoT+Uvv6igC2cbUumpyGl2uOtwOiehl9mnYM5hfHDFbNpPUsc2oLHdak53x29
 UlrTULEEPSZ89r1JWcyJvg4EoHRu5VpRSJLu+N4qrna6LP+7ZRuxUtE5LdvbSGvYaYwAc+iCOVN
 ZOv8p8SnQbUh7d5Veo+KDj7BdmC4PzAdFaiGj/JoLmT+u2NvA0pSmd/4tPK3B/tVlHh+hbp7lbu
 Dh2+uejGHvrz03qVU1Fu2XzqbbfDdkDVBSQq2XFOOwXrx1EFSPre+J+lHu6+QHO8MxxlLSAChCQ
 94YH9yJItBmMsKQsZM3kZIBkf3rychJwE5pqbSgu3twaI9TsYFliCL0rSdPAmpRvgwb+Tqnr9t3
 Vy1u/gNh+uXXx3itSQhJP/3RLqQcjIiRO3r1x7uXWqXBhiVgrI5Ff/H90QJpH6DpW1qYwKCf5DL
 r3FbC7ZmMGqI3wsw7OaKXZipJGYYBkEWj1SwNOTifZdBR2C3HwHqx/Fs4TTFGHUhP48Nj3qJfqT
 Xzfd0OUXQe+z+dg==
X-Developer-Key: i=khorenko@virtuozzo.com; a=openpgp;
 fpr=560F6DC83DC5D3D063BD082C51960A47F9615C2A

folio_dup_file_rmap_pmd() passes PGTABLE_LEVEL_PTE to
__folio_dup_file_rmap() for HPAGE_PMD_NR pages, so it adds HPAGE_PMD_NR
PTE mappings to the folio instead of one PMD mapping.

The helper has no caller yet, the next patch adds the first one. Pass
PGTABLE_LEVEL_PMD, as folio_try_dup_anon_rmap_pmd() does.

Fixes: d8ef5e311d7b ("mm/rmap: convert page_dup_file_rmap() to folio_dup_file_rmap_[pte|ptes|pmd]()")
Cc: stable@vger.kernel.org
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
 include/linux/rmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 52fff8dc74213..9f5bfa317a5cf 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -558,7 +558,7 @@ static inline void folio_dup_file_rmap_pmd(struct folio *folio,
 		struct page *page, struct vm_area_struct *dst_vma)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	__folio_dup_file_rmap(folio, page, HPAGE_PMD_NR, dst_vma, PGTABLE_LEVEL_PTE);
+	__folio_dup_file_rmap(folio, page, HPAGE_PMD_NR, dst_vma, PGTABLE_LEVEL_PMD);
 #else
 	WARN_ON_ONCE(true);
 #endif

-- 
2.43.0

