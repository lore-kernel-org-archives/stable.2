Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D81F28CF77;
	Fri,  3 Jul 2026 16:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783095517; cv=none; b=ncxrL/mbbK8suB9+jRjDjtC3wvrZjJI0EgRaNH0QRQ11ciAK2z10KcwU5WyuXJLbQBJGm2P+jU22DGB/zGE+BL7/mz3j3n3G/bGfIpTM6O7QUxksEOFvcSPsRt+U6pIKRl8VYjlVHzF65/e90otNpVORRbq/toaMct2HTzHoLEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783095517; c=relaxed/simple;
	bh=j/f/It8MuV1QCNInKTZPkW/5dyCCOZlsz+CJ6HqhMGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pc5/fIbvxLmBx30EpahBIhv398Mg+uMpdK2tH1O4vdxGfSsHLnvabx+cpOIJ/qPbYk3TpXVpNfG1Xzyz0O55oK9F6k0JquWI7yZYii61wq30toXTrNp8pUCsxw8Qlyb66/28av+s7cUfGVkoadNUvwi+NQxEqPlow+OWLSGkDWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=Jf/ZvnV+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=igCegrbz; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="Jf/ZvnV+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="igCegrbz"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 610717A00BE;
	Fri,  3 Jul 2026 12:18:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 03 Jul 2026 12:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1783095515; x=1783181915; bh=clDPqx1ziC
	3wm+v9Reh6feCWpBIrASQPY1r+hqGZOcE=; b=Jf/ZvnV+nDA3Srl7AyF1SzZNMs
	4S/urVtNATffjSPYpXuDPqEgq0lg6hmqrhuz0LjY1NWhPCf//eNIPWid2OUdrj60
	1usfIL+oPcAIMdGpN9fhOeEpXtbx2BGxX8UXccshfqQ+EIVoAwKFwIsB18NVfT9U
	Hp4vmiA84za/RBtkh/z8fXt6+cKTxCHdqS6nbRrUgn5ragQQGczkcUSPVbnU/gMw
	+7rxNyP1ZzaVAWvQdHInNv1TWNT+7rujr8DIrsDG4P8iO+e50JWwf20Ay8nbKMNF
	Vc7vsGwgpnMuiYVHjzJad5gen/KtH8zOl1neNRQI9TTgUUlWlc7P+IlFQ7Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783095515; x=1783181915; bh=clDPqx1ziC3wm+v9Reh6feCWpBIrASQPY1r
	+hqGZOcE=; b=igCegrbz/DgX372KAGDXNRJjlJ2kcBQSlRKTrsB8lspD0Xu2B2w
	+ilfvLJdSw5Ke+h+YONoXQijn9jYSIkC+HqfKOBNj1xTcuMmHpyGccrMj+Q3l3bO
	dIlZZf1OZGAK0KSveZ077jBvxiJ6MTcVXGTpIK5VBtohgqw7HoTPvSDRWjZPtWz8
	lquF588jhUG6hJQzmoo1w+7ECT4OLxqdmTY/HwRLMOwgDNwiOuAYGHxr8DIln7Ht
	UP+54NFhGLOlPIiqVMidZ4tASHPQZTvFsJ3v55yHGKRx7mi/C/jo301A9dyMUDmX
	cSTq2vqFNodqeK1FCYb6V4wB8HOsDvZBHbA==
X-ME-Sender: <xms:2uBHakaC9LCPmok1hi76C1pQ55oENwgw4_xnpcIDtJXL65VioDH4cg>
    <xme:2uBHaiddIwLPL7c9lcnHVtKg-jNTw45ehGT6cM3fgn47yQCQkGe6vDxUBw9zGpUc6
    GoLfVSUaXBfg1ZpzWizyxruZCtQUSiOivuzELdBBlhgFt2lx5uPVfA>
X-ME-Received: <xmr:2uBHapmL0bzeXio6Y7gMFJa8KhSvqG1DoWwG4rQ-YMS54XUaYbQ7oJovn07yyw>
X-ME-Proxy-Cause: dmFkZTFL9LKWT3Pov42M5rreNfDWiU0qs2150JDK0uhZc10GatYqJPGQglxOG7FLomA4Me
    6k34nS4NY7D+pvE4GthDq7JjRqsePaV2htcCoMUoEXhih9wWhvcJcXxjk+sh9C4jNhmoGL
    kXREkrbh4aTuyzXWpNnrcBWKNL5yiszUS1i4cLtlKtaFWD8+1nPdnFrrgjm0J9I1mXTU8x
    56QRwz7Rl/xI+MEhU+IJctiKOMbCFnOYXOKr5baYmfhwllP2hQxGVcknrBb7vyK54C8Kz1
    csAwift0xNOIeJU7THcR50bGKKeunjxUuJXYmWTtxuCDEqB4edMDoZ9YvN/S4c1c07olFj
    f31RNS/f40UIpUGzioKVFs4/cwWUfR3quZEZVMJ/fV0Cor5w/ygW00m9s1xmRmEvmLtn1i
    jUMEgNjNdz+kq7qTGHSFU7OtDKIZU44fC7/7qP4JLjMlRHBRQjdIZc5TT+W26wFA9XJBkQ
    aJ91jEu1cl7WvQTXpKlkqBiXcgUp6rmJm41uWJCD23qKLfKfkYWs/05GJL5QaSH1bAWOmA
    jnpGMGQLvmH0jJw/ltsGB7RKcGHgwfj1qc9xGnyM6+h2nUonJsgjy8cKfnk5gXMxXt7PpX
    4v/yjZb7xg/Xn8hGeth8LDAUSMB0ul/WnACcEHes8ztTGtz1KrT6c4g6/sHw
X-ME-Proxy: <xmx:2uBHaq1dsuAnQsE-el1HKw3JTC_Pw7Pd7DOiRRAGE2f8yztXTlnC7g>
    <xmx:2uBHaqe5V-EKInJ9HU-HqlgGP_gGmpxC6JTrFB3REDPlgKxcNms7cg>
    <xmx:2uBHasYmjH2wVv5ZgCvXiJyNAf8qP418FdYwASDqu8dWzJLivRep4w>
    <xmx:2uBHanEohVulFmLAas5dh05y1TSTuY7yd9w61URDJGX8fvm3udNkUA>
    <xmx:2-BHav1z9scnlxI8iFy7VDkV3dAvMj0GuYxWKPvW0m6XpDn7YHw215vQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 12:18:33 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: akpm@linux-foundation.org
Cc: muchun.song@linux.dev,
	osalvador@suse.de,
	david@kernel.org,
	peterx@redhat.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	kernel-team@meta.com,
	kas@kernel.org
Subject: [PATCH] mm/hugetlb: fix swap entry corruption when clearing uffd-wp at fork()
Date: Fri,  3 Jul 2026 17:18:33 +0100
Message-ID: <20260703161833.57416-1-kirill@shutemov.name>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

copy_hugetlb_page_range() clears the uffd-wp bit of hwpoison and
migration entries with huge_pte_clear_uffd_wp(), which operates on the
present-PTE bit position. Swap entries keep the uffd-wp state elsewhere
-- the same branches read and set it with pte_swp_uffd_wp() and
pte_swp_mkuffd_wp() -- and the present-PTE position falls into the swap
payload. On x86-64 it lands in the inverted swap offset, where a
naturally-aligned hugetlb PFN always has the affected bit set, so the
clear advances the encoded PFN by two pages.

No userfaultfd needs to be involved: the clear is guarded only by the
child VMA not being uffd-wp registered, so a plain fork() with an
in-flight hugetlb migration entry (or a poisoned hugetlb page) corrupts
the entry copied into the child. Instrumenting the hwpoison branch and
forking after MADV_HWPOISON on a 2MB anon hugetlb page shows:

  offset before=120e00
  offset after =120e02

The fallout is mostly latent: rmap walks match migration entries by
folio range and remove_migration_pte() rebuilds the PTE from the folio,
so a within-folio PFN skew heals once migration completes. But any path
that re-encodes the corrupted offset -- e.g. hugetlb_change_protection()
rewriting a writable migration entry via
make_readable_migration_entry(swp_offset(entry)) -- propagates it, and
an hwpoison entry misidentifies which page is poisoned.

Use pte_swp_clear_uffd_wp(), matching copy_nonpresent_pte() and
move_huge_pte().

Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260703140011.99E601F000E9@smtp.kernel.org/
Fixes: bc70fbf269fd ("mm/hugetlb: handle uffd-wp during fork()")
Cc: stable@vger.kernel.org
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Assisted-by: Claude:claude-fable-5
---
 mm/hugetlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 571212b80835..a4e6dd3a82f4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4918,7 +4918,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		softleaf = softleaf_from_pte(entry);
 		if (unlikely(softleaf_is_hwpoison(softleaf))) {
 			if (!userfaultfd_wp(dst_vma))
-				entry = huge_pte_clear_uffd_wp(entry);
+				entry = pte_swp_clear_uffd_wp(entry);
 			set_huge_pte_at(dst, addr, dst_pte, entry, sz);
 		} else if (unlikely(softleaf_is_migration(softleaf))) {
 			bool uffd_wp = pte_swp_uffd_wp(entry);
@@ -4936,7 +4936,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				set_huge_pte_at(src, addr, src_pte, entry, sz);
 			}
 			if (!userfaultfd_wp(dst_vma))
-				entry = huge_pte_clear_uffd_wp(entry);
+				entry = pte_swp_clear_uffd_wp(entry);
 			set_huge_pte_at(dst, addr, dst_pte, entry, sz);
 		} else if (unlikely(pte_is_marker(entry))) {
 			const pte_marker marker = copy_pte_marker(softleaf, dst_vma);

base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.54.0

