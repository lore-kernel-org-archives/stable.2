Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793902616;
	b=LlQSATc57ANTd4QNClrWZkO6HMIVXqlpdOF/7iPtcmDSO2pMEnBovm0GM7WdJP8MpY0h
	 3vs6Qpde5SWZu0EZn8VOWgsUKeQFuM+9Q2bqLNzxuy4vx7nv3w9qoA8RdFFYC25ZFRrZ6
	 YQPscA/Kg695NA3Y5YT/lForJUUpgYJoH+hb9t5zXORdTO+KxGdJIEs0ON2OTjJlEn8aU
	 Wq7gWb/SdxBXxmNgRwA1XN+6KTOe8KE3Azu+mdXmzfsElOsng3OHkrvr4ggMLldUNPGjP
	 wEFkHjQ93QRqJGHJOT6J/gO9HCtG6GedQ16QVEcmegrYtiYU6T1P+DS03uzQh1Xm/GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793902616;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=vMpWvkjgwpvMMa7+syhmsy3PKYx+lNXAcu0o7qMwcLg=;
	b=CRCAZ1kQhFus0iwhEdQk0y++BlcgyJy60hozP9qVbfmIXA61zXkMZO3n5drYH1TMPm1e
	 nLR3yuOcNgYWpF4Q3JWCkK+0LsfENGWG94P6AHiPT0vTQeZlB8sqC/Xp7S+LeRv8KCEke
	 4K53gym1ZKK3+0kKTT4XYCRFNXNQvdm9exp/ltl7KcYZD/LF0R1fSSvaGeL1d2C/pU95Q
	 TzCevCpM0ZVwP8XqH4Zx5yMjf+Slh0wQWIq2DO0xUZTh3GYgX5G/bPcSBwgbuPBUmII8O
	 R/JFmXJQTlQ8Sca7AaXMpJCf+KBfEzQdy0wdcmTrcPPSaS6MmkGPvu/XZ6osnP5ihdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zce8u9kf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D43606A326;
	Thu,  5 Nov 2026 18:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zce8u9kf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6775A1F000C1;
	Thu,  5 Nov 2026 18:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793902615;
	bh=vMpWvkjgwpvMMa7+syhmsy3PKYx+lNXAcu0o7qMwcLg=;
	h=From:Date:Subject:To:Cc;
	b=Zce8u9kfBUlYo6KPIi/Kk8ohVlE7iAqICTrnuxM4OKaYJT8CbiOb+lNyAvDEfG1zo
	 hjnQd9+iJlRqJieiLQaQ8FHaRzreH1IYeiVkIVs/7L0vdncoo4akHf/VCrGyWyqevH
	 uafdMf2itzKtADBAlzNGtQzKM0R6rbKZyDFUT49/eltsfUq/viuVCDVsyET7gxubUB
	 ifLonotA7eXw+8MFA0l25QnuqbtDVG5ixTQGTCJP7MYDAhPH5a+lnMKUqChCn+6mnx
	 FvJ2lGsBuTLNTSbMLHV4slSs6uJWnTRppiyrPmZQ47NdPAwVivq79Dc6LkUzAWWb6I
	 FUP4nD4UrGwyA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 05 Nov 2026 19:16:44 +0100
Subject: [PATCH] mm/khugepaged: don't map folios that are not uptodate in
 MADV_COLLAPSE
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
Message-Id: <20261105-set_huge_pmd_uptodate-v1-1-a78d8a1b7117@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAvI7GoC/yXMQQqDMBBA0avIrBuYRGqrVyklqBl1CmrIJKUg3
 t1Ul2/x/wZCgUmgKTYI9GXhdcnQtwL6qV1GUuyywaCptMa7Eop2SiNZPzubfFxdG0nVXf00WOJ
 jKBFy6wMN/Du/r/dlSd2H+vifwb4f8usBZ3kAAAA=
X-Change-ID: 20261105-set_huge_pmd_uptodate-9b9820307f30
To: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Hugh Dickins <hughd@google.com>, "Liam R. Howlett" <liam@infradead.org>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Zach O'Keefe <zokeefe@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1539; i=david@kernel.org;
 h=from:subject:message-id; bh=4vPRQgFKZMvkn+yRb7hUHK9P1W7c8xgEacmzWiDG098=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLenBDYF6dT1ebwouDdmfDrT5l/yqdorLYTb9qf9uJBx
 M5Pz6ovdJSyMIhxMMiKKbIEBd83ePlyXW21Gx8zzBxWJpAhDFycAjAR/WqGP7y3LZzkeI4/rtvC
 c09x08cjapfurVeL8DBW9bzbrLBWeAkjw23meu0ZiwLt81acetgfvmEH11qxjII83SPfTLrdD6b
 uYQMA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

madvise(MADV_COLLAPSE) can map PMD-sized pagecache folios that are not
uptodate. For example, shmem fallocate() can put such folios into the
page cache.

collapse_file() already refuses to proceed with folios that are not
uptodate. Let's just do the same in try_collapse_pte_mapped_thp() and skip
such folios, leaving handling to the page faults.

Note that collapse_file() effectively clears shmem folios through
shmem_get_folio(); let's keep this fix simple and simply let the page
fault path deal with that.

Fixes: 34488399fa08 ("mm/madvise: add file and shmem support to MADV_COLLAPSE")
Reported-by: Chris Mason <mason@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
Once reviewed, I will pick this up in a timely manner.
---
 mm/khugepaged.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 8d9f05a39afb3..db135b3c44ef1 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1900,6 +1900,12 @@ static enum scan_result try_collapse_pte_mapped_thp(struct mm_struct *mm, unsign
 		goto drop_folio;
 	}
 
+	/* Leave any uninitialized folios to the page fault path. */
+	if (!folio_test_uptodate(folio)) {
+		result = SCAN_FAIL;
+		goto drop_folio;
+	}
+
 	result = find_pmd_or_thp_or_none(mm, haddr, &pmd);
 	switch (result) {
 	case SCAN_SUCCEED:

---

base-commit: f44fd601f72e09e44c667b9234c9cd469856679c

change-id: 20261105-set_huge_pmd_uptodate-9b9820307f30

--

Cheers,

David

