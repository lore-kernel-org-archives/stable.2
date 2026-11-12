Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493515;
	b=ZIu15VHXaB7z/pY7qXQXniGyRNNI3S9GnHe16EHSkpnfbkqN6zEL1Ag5SRFrGYQyM52O
	 3KheQx/RzQTUxI3PMCRMM1ZQRAyX5YqSqbSHe9Ait85V8PyrkCFYZUNkge/IuicA/PlD7
	 v41EYzOzYJvTXH6POvsyYou4CXap13FhMj0z+YMH824f4IjylBZpz4yJBLQpoZ33m8+ME
	 qS+PRf6/eQ57ir3QQgSZDuvR1ziYJvAJwwHmjWThmSQu+dFMt+7h+MZQSYN7O8A2el0oe
	 +1xr3RTD11Co+vUTFkfxbvmXebtuB2t9ShF4bD7inMSm3YU8OFkAbtnivibyyc+80eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493515;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=VaFyFdbYf37IpbzQa49x1rzy8WEarNi6kqPV3fC1o+k=;
	b=tnFl9An8Bjo8W1+hI/+Nbek8vDY5wi/jjh55wkvHkga4AistZckhc9QbcceL8qROSUJW
	 YgbzfMRurryqlxT+yhEPu+lqgc1oOxtNk8ySmR8HOVmnSTckEOLDQ188y6gcGcHZ3lN9b
	 2IgiadT7L4lvWcBYvuAcJBLNiPqEMon9JA90do10+5Fr3mqg9yB3xZaNdeTxAwawQK7Vw
	 pB0IficUlPeOoF8jxuL1eUOJ2EUSleAiImKrI8idsI2LN1tHhIqYeAt42PmXrBg9dp5nY
	 QQ+GFPJ8l1hqu96WZI9rZKnXztZhB3z38KapVv9twOXa1JNlNDVXimGieYDNOPq6kDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=UPVCyoPF;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487C7606A336;
	Thu, 12 Nov 2026 14:25:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 487C7606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=UPVCyoPF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=VaFyFdbYf37IpbzQa49x1rzy8WEarNi6kqPV3fC1o+k=; b=UPVCyoPFpPOx1HTruMDeJPJUAY
	3GdeJrv2jkYlO222oTZPECS/N9JbxkFPHVMXl/JHgQU/3kYvOQM2ak0aPBju3N/qUXqzA5Jw36Qw/
	rjs81UNilNMSCSH9jpcDrTn7Jc1j5co3Xn6qhlzZ4HlG3vvzHtvZYuufgKcOGhykanoHwODBfVczY
	Znh92751M4i5i3uov7axz2/sCFt40NbS43E/w8fJy6U6VpCXEXzBFMD74+o+kwbZorXrgbmifzXuR
	C9EaWjAz7wqcIaRVEvlyYX4l2DodAP6F0827LEs0JRnlA/yinm2+JAmFlzYvyK9Uxb3oNpnaKPANe
	VQajPi8A==;
Received: from [151.115.150.205] (port=59302 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xRVjm-00000005AE3-0HJX;
	Thu, 12 Nov 2026 15:25:12 +0100
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: David Hildenbrand <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	Kiryl Shutsemau <kas@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH] mm/khugepaged: reject shmem collapse ranges beyond i_size
Date: Thu, 12 Nov 2026 14:23:35 +0000
Message-ID: <20261112142335.2749597-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

MADV_COLLAPSE lets collapse_file() treat absent shmem pages as holes
filled with zeros. It does not check i_size, which allows one present
page to become a huge mapping that covers the whole collapse range,
including pages beyond EOF. This makes those pages writable. A later
file extension can expose their contents after F_SEAL_WRITE.

Hold inode i_rwsem in read mode while collapsing shmem so i_size
cannot change. Reject a collapse if its page range extends past
i_size rounded up to PAGE_SIZE. Keep i_size_read() outside the
page-cache XArray lock because its 32-bit SMP reader is not IRQ
safe.

Fixes: 34488399fa08 ("mm/madvise: add file and shmem support to MADV_COLLAPSE")
Cc: stable@vger.kernel.org
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 mm/khugepaged.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4bbe319..e20416a 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2251,6 +2251,13 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 	 */
 	VM_WARN_ON_ONCE(!is_shmem && !mapping_pmd_folio_support(mapping));
 	VM_WARN_ON_ONCE(start & (HPAGE_PMD_NR - 1));
+	if (is_shmem)
+		inode_lock_shared(mapping->host);
+	if (is_shmem &&
+	    end > DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE)) {
+		result = SCAN_TRUNCATED;
+		goto out;
+	}
 
 	result = alloc_charge_folio(&new_folio, mm, cc, HPAGE_PMD_ORDER);
 	if (result != SCAN_SUCCEED)
@@ -2682,6 +2689,8 @@ rollback:
 out_put:
 	folio_put(new_folio);
 out:
+	if (is_shmem)
+		inode_unlock_shared(mapping->host);
 	VM_BUG_ON(!list_empty(&pagelist));
 	trace_mm_khugepaged_collapse_file(mm, new_pfn, index, addr, is_shmem, file, HPAGE_PMD_NR, result);
 	return result;
-- 
2.47.3

