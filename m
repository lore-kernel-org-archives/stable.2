Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794901989;
	b=VBCkIM1WH5WA2H+hwARcvgQbix4ag4WCY6BiZH9cjSGIzRbmuiojLJzLdKEuI2Jw1+cj
	 FbDABHIrb4xGN35dYUgRXAZ2i3ouMBHlCpTwMxB2rX5GjweMcREBGOcykOqQnJw/Nv0vc
	 6QsALqlD1pM30KzPmlYP6kLC7qGJhkZix6EMK5D3z1uE+zsIW2eNqfjqpaDgj5Kcrh2Kh
	 Lx823MCfWJjoxZYLj7CXI+m09PeM8m/kiuPwTgAIfRNBXGyJRX6Rz2juVEeCB9yrERBLy
	 gg4SCPJZcUe/2XQ8AlmWnrD1yG74IJwQSVWzyP1DNuSGauO4nPLkMzAN18XJaQy98dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794901989;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bIaB3xViS8vRwH7p7m0nqayQxCVJVBaNFTxNi69Cb5s=;
	b=AARsg0LX7vxNi07QRzU6LcCpqw4O/2njNHYITkciOz7S6ptlL8oHYUy6Xa90jZhV0g9s
	 Bvmx9+hY5UX560lX+7uvlGOt2JCj/q+g1qtsnMZSiKlGBgjQrQjhoAzC82q0eCWI+KpUh
	 LXtBdqp72ny1soiLAmb7LBWfel6JS4u9hwYepQcQ4kU1SauS8YwH7rT+xfAK90+bsm8jb
	 w2hRfITEZOz1vPf3P5fBE2HjC4OAO59SKqJpQx2b7rvJx7zsgYYFR7/mBx6hh5AE2R7bq
	 Hu+iAM1uR3fZT0aQ7ir6dMex9/Lb8nhRmjHMgDErMEs5xGcoubZ7wMV1hm1vD8cDrRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pE1wQF+f;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CB5606A323
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 07:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61CB5606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pE1wQF+f
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b37951a397so2135710a91.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 23:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794901989; x=1795506789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bIaB3xViS8vRwH7p7m0nqayQxCVJVBaNFTxNi69Cb5s=;
        b=pE1wQF+f0cxdZaR+U+ZOkQyj3e4yuQVMr1T5T6YWyv9LVF6myLSDjq/7ZAotA8+OTa
         ED0jpGyxM1pkNhqNZeQPfRoPfywRymYhMEmW40BAjbcP6hqICKAvZQizypmkTgmG36Xb
         ifhmARwDauooTrtB3NZ9og9Kvy0xWMND8+h7mIVhPQterIo2P5MDCYmD76RwAZMbtAFZ
         HJGgVHnH0+7C+1LpkG3mIoHdQbXHXqQUydQoeUuh2jLuYEtEfiTm7oKlLB2vivcBTYN1
         633SujJnFAAYJ9VfZSt56fJWtUvKLtlnVLb7vbTMaoMqmioG0z/RzZD3QK1LH/ZvagT0
         EhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794901989; x=1795506789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bIaB3xViS8vRwH7p7m0nqayQxCVJVBaNFTxNi69Cb5s=;
        b=NJg4JGrLwop4q4OqQP2K92inLUtosgFZjqN64mun3ExNuQN1sYm8dBxgHIlYpIzCQW
         tixnPrs/XrqREGLNevWcZzsbiSQg2bXFqLJ0XK1VfFe/dIdI/Qu/B4x+obQaDn2SRQ/+
         7bKjj4iWarwz62A9zkN8ZWfvH8IIWLhteJLrzq8o+ydooeZZINHTCJYaHPyA8ngH1A+F
         y50HJdmGQ+UOXvzOXlrRIrjtB3j6osCDpBIGGfR23EScHVIubUtxHdr0slhxa756Zzfa
         SPcct8fB1FE/l+tJFaduksChSLYkpdad9JPesUbBPHs47u79tLzrFL1Pe2PzNJM6Z2sh
         eQWA==
X-Forwarded-Encrypted: i=1; AL+hErFkggUc4tOUuPT5OX76jhb9V4cy/K7FWgjyJl4Kt3cDA3HemWxnCFPB90Yk8f7fRFrqtOJNQ8o=@vger.kernel.org
X-Gm-Message-State: APuU4Z8TNzS43CtuhhHd/+Q/2VFGeYLhIGOiZkTj0R1PcM3B/Ed3jvGm
	/Z4oZrFIH8QH+nY1hJpimWFR5sfeOEH+BlKfF3TCMxr8RHQHCJ3J6baHMWlqeGhBaw3rN9Mq
X-Gm-Gg: AZFdTZenvSSVj0uH/8XFxIIJGj9nU21JFF24Hk6e3z9MhbF6mPYsewosOBNuKG9snFw
	gAFpYyalPAM7eTmjjlKCCKGzbDeI6VqBrh4loJuS0TrrUzqvAkj6nGEJ2h5u26uOnOYumIbEx8R
	uS7LSLoG3gKdqTaJreW9Xk8SQ0sOEn6kphqlQIcyxU/FvP1+HlZWuLsz6RQw1Lbnld3npsQlY9n
	/YkPh+WFjzsqtw4OZrIUYb+iOhNhFBgmwAgrn+61d546cMP5ruRuakAXqMVlySrEvLu//TXr3zX
	YpONWZVYbXOzbK4kIoe08I2Tq9w2csMdv9LYIoUJRGWiqrmfeIQ9qyu+clFX4xKjWTFejbqGhg9
	7JSLA7cLa0+etL+d51yzTKKBVWqk+I0TdNLulYjVV/6HryuAoxt2101Jeaf9MWOZNY+FnFp2Lwu
	TisqaiB6hLroFbEe9D4pm0mKYWAklED0orRxa6aeVCu2oxjy6seDxu6e3j0GloxIIOrysVisOZc
	Aj/6Bk9b9J+deQr+VU07XBBDGHi+iXbnuenDpMdrT/8ydlrz1+BHYUdkkxLbKVGrh7HXDEzg475
	hKTBxyZQrxYWuGmJrFeIiQpHanC8uWErTuEshKySOrxutZkRWWCiVlE16udnR18Wlj796ejGwGK
	PPRO6e3HajUtEsJB3Qvf0Auh33hcOs5KfwvKwuOAJkxELxsZFqpNYtfP0dRSjkcLJxkcPsQygkp
	zHraCTSrlAW71qgYGZhuvnsnF4qmEKlhtwDL4RrbKb6e8yp4FhnRTtYwOI9NgMzDP+wYSWAqSzZ
	DyuMedAcVioiDtNkhAe6qCI/R5TvnsAUPEkTHwtBbrMtWq0QzCUuHiaadHQwR8j
X-Received: by 2002:a17:90b:17ca:b0:3b1:fad:b1bc with SMTP id 98e67ed59e1d1-3b1b0d77ad2mr13468030a91.63.1794901988543;
        Mon, 16 Nov 2026 23:53:08 -0800 (PST)
Received: from localhost.localdomain (123-243-92-89.static.tpgi.com.au. [123.243.92.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3abe77179sm2791862a91.11.2026.11.16.23.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 23:53:08 -0800 (PST)
From: Daniel Wade <danjwade95@gmail.com>
To: David Hildenbrand <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	Kiryl Shutsemau <kas@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] mm/khugepaged: mark a collapsed mTHP dirty
Date: Tue, 17 Nov 2026 18:22:46 +1030
Message-Id: <20261117075246.61336-1-danjwade95@gmail.com>
X-Mailer: git-send-email 2.39.0.windows.2
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

When khugepaged collapses an anonymous range into a folio below PMD
size, collapse_huge_page() copies the pages in, but
map_anon_folio_pte_nopf() marks the PTEs dirty only when the VMA has
VM_WRITE and nothing marks the folio itself dirty. After
mprotect(PROT_READ) the folio therefore holds the only copy of the data
while looking clean, so MADV_FREE in one mapping marks it lazyfree,
reclaim frees it, and another process that maps it reads zeroes. Mark
the folio dirty before mapping it.

Found by static analysis with an AI coding assistant and reproduced with
a test program on an unmodified kernel.

Fixes: e22f2fe72c74 ("mm/khugepaged: generalize collapse_huge_page for mTHP collapse")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Wade <danjwade95@gmail.com>
---
Claude (claude-mythos-5-2) found the bug and wrote the fix, this
description and the test program, which is available on request.

Tested on b3dfbde62cf1 with KASAN and lockdep: as uid 65534, write
64 KiB, mprotect(PROT_READ), wait for khugepaged, fork, MADV_FREE in
the parent. Unpatched the child reads 65536 wrong bytes; patched it is
intact.

 mm/khugepaged.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4bbe319..8a81cab 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1422,6 +1422,11 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm,
 		if (pte_ptl != pmd_ptl)
 			spin_lock_nested(pte_ptl, SINGLE_DEPTH_NESTING);
 		pmd_populate(mm, pmd, pmd_pgtable(_pmd));
+		/*
+		 * The PTEs are clean in a read-only VMA, but the folio holds
+		 * copied data: mark it dirty so reclaim cannot drop it.
+		 */
+		folio_set_dirty(folio);
 		map_anon_folio_pte_nopf(folio, pte, vma, start_addr,
 					  /*uffd_wp=*/ false);
 		if (pte_ptl != pmd_ptl)
