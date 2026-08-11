Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD03445ACE
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 13:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786455448; cv=none; b=qNPdTx4GDXiYcYNtCsM8GC37hy/FioR84nC4FSrctz8SmlA2TTxslrfyKFdc0wNL8hI9nW3y3Fv/Ab07hs8W2huXPEwcBtDuLQM/UEzUyeP7bWnhuMB6PXs2a0z116SDbFdPtF3AOJuysOiahWkz6K+fWm8gmBtxpHRPKQuB944=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786455448; c=relaxed/simple;
	bh=IAOvDtGnQNoiVyuA9NXEv1/6YstVUHQq1mMWJ7zVRho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qv4HIPIEIZdZy54pY0TUYEfxITSf7mBNE/HZeChZ3goiMzZa8u1LzklUuCYYmi+dvijoJVgoB0Awu6nRpZ1sonF1DzRl0XRk6vrtxWJD/7jmV2ni2aYiYq6SGMXjeqpFAcJ7VO78ezOfCtUFaOEaSFCZbmo9q9L6iRfOPHdrlqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJt6DZ+2; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJt6DZ+2"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cf52d15d88so27783675ad.2
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 06:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786455428; x=1787060228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kF2VF2U/hL6reW1X2jhuzR2siNy4Ft7Ohusar6d2kSg=;
        b=YJt6DZ+2rFEIfuUxwMJN4bcziWX/WgdDcZyRAqxfxhb4LKjj4Uer1wBUdcoZyVUfVe
         MeE+iktBR7IV1X34LnoPUXSnldu5B6H0My87TngxuBCEoqAGiLUneU3urgKP8SmsuySX
         eTPIngMCXo31sDQD6D3MWLBFphFWXJOMUVWTeoeWYCoVzLcc2fSyxaXY814cuH/wM0hQ
         3h9/KO/IwMAo78hNJiH7QEhrcpWS+MaDYRKu5vPKIr9u+ENLoV547Z0ve8YCHO5dfhxj
         6wIyuwpglUo9xQ889GQKed84+Q63lr4btOxoOW3Vkt9MK3NrfbAS4rar4MHkMRVd64he
         VTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786455428; x=1787060228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kF2VF2U/hL6reW1X2jhuzR2siNy4Ft7Ohusar6d2kSg=;
        b=c3l7/fdQ/mjkSU+SDAQqs8js7KLHmH7+P4g5Yt0ucFwucFB7ssgGXbHNtFqXeVoIaN
         8lqZz4T1HWoIOVM4dGKqlY3QB8NueqJSfkb4TM9k2vHIu1E+jPlZMUsySR4OauF8BN6q
         6+0l0GxpUV1G8qVCswHIV0wBUTnmIonYPWZM/Bsm4o8X151LWs6n1Y52nIRnxIr4Ao6R
         gZsf7C7ixibWvftFJj+lysYLIqvlSSF0sYKrWu9yLLHlrgHaNGXKlv8RFZtYvd3dJduc
         Hg5y0aJGISwEN/upi13TO0Oerr2l31DxSWkKU/VXMOi21xJ2sthzLRLs7UuMlroyDbXI
         vk+A==
X-Forwarded-Encrypted: i=1; AHgh+RpRN9jgWCYrMkrM+rIIE7eIU+wrlAXVr0SG0/ororaG51i0T3U5a98fdAWr711Rpq22WQWQ6ME=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgtwXGaFdhwKZ3xuGUxQm1oCZBop2k2QUtcneq2Wi/56Lhi7Zp
	uX6xCD45yXKSUEg6Dj5H7xrlZIq3mBXzDLfgewKW/lYERgVbKI1bjHCg
X-Gm-Gg: AR+sD11NPJVIXJXVHdJsM9xk+UGJr3YbJldlxqUuxLIYLsEcV8bxpQd3Cv4kMLpUvEX
	5n+I/BRELG0lS9edxGaLyercxDJkIirANj6Ong30Ke9bzfWE0U035XO5JUuLxufuCDsMl7JGIXo
	Fq06ogy+sPjCFyQjwOspFpcRjOCDGXEkJnAhNwsdHzhzXZ7psvCZNcobWJOHGiGu8UrfAjQmaH6
	+w3QdPW27+Cw57Sop+WNQUgRvH6m5jkCBiD6GyWpm4kwLJccnL75sjt2ppomIx2YvAeVEyaATy+
	yE/KF6Vi6OyBkMwtRPbPdf6LgG4Tt9PRsJlszzjhj13vtB3A4Md2+VKoFU+oDn1AooIk9cYlASs
	xV6UY0RNqQc7G461pfWqyXAQZkBrWtrlv3Q7YR3G014qlQ0zKeqaFfL56LkLyk3xjFkHemmNFug
	mTxjOuR5Fhtos9ARJZpxLQg9abCGkNOj1ZbpDsF4+q1SrIcz66mau7r14aweFdr/ZjILonOScc
X-Received: by 2002:a17:902:ea0d:b0:2cc:aa36:c04c with SMTP id d9443c01a7336-2d317785a86mr39329385ad.1.1786455427722;
        Tue, 11 Aug 2026 06:37:07 -0700 (PDT)
Received: from localhost.localdomain ([49.79.111.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3160ce732sm8179385ad.38.2026.08.11.06.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 06:37:06 -0700 (PDT)
From: Vernon Yang <vernon2gm@gmail.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org
Cc: nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	zokeefe@google.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Vernon Yang <yanglincheng@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] mm: khugepaged: don't pass swap entry value to trace_mm_khugepaged_scan_file()
Date: Tue, 11 Aug 2026 21:36:55 +0800
Message-ID: <20260811133655.267739-1-vernon2gm@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vernon Yang <yanglincheng@kylinos.cn>

When the swap entries found exceed max_ptes_swap, the loop is left via
break with folio still holding the xarray value that encodes the swap
entry, not valid folio pointer.

That value is passed to trace_mm_khugepaged_scan_file(), which feeds it
to folio_pfn(). On FLATMEM and SPARSEMEM_VMEMMAP, the page_to_pfn() is
plain pointer arithmetic, so the trace event merely prints bogus
scan_pfn. On classic SPARSEMEM, the page_to_pfn() reads page->flags,
dereferencing the tiny encoded integer and oopsing khugepaged whenever
the trace event is enabled.

So set folio to NULL before breaking out, the tracepoint maps NULL to
scan_pfn of -1, just like exhausted scan naturally.

Fixes: d41fd2016ed0 ("mm/khugepaged: add tracepoint to hpage_collapse_scan_file()")
Cc: stable@vger.kernel.org
Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
---
 mm/khugepaged.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 617bca76db49..bc0d04c9162d 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2696,6 +2696,7 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
 		if (xa_is_value(folio)) {
 			swap += 1 << xas_get_order(&xas);
 			if (swap > max_ptes_swap) {
+				folio = NULL;
 				result = SCAN_EXCEED_SWAP_PTE;
 				count_vm_event(THP_SCAN_EXCEED_SWAP_PTE);
 				break;

base-commit: 075b74841bd0065a3bda3440873c747938e69b68
-- 
2.53.0

