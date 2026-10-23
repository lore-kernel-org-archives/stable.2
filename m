Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.72.0.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792737832;
	b=YHgYS77rT3KrxwcpMfERSEKMsAos0UF7msLdO2XPJddfGDeun+jfLE33gOSNV9LPJdht
	 evZb/KccLLKcZ7Mjfc1GQFoo/FNj38X5pViooaPICMFBz/RlUBIQoJEEEAyeI/apDAA/2
	 zlUd2ZLdZHOQOWUYKXRj+3NDbHwKgPAsAiDRiuGExOXa7/4W5XlfXkSE7dGu+OCmgY1Qd
	 1ugze9rKoA4/pg96lvOS7MZNTf9lgSxts+xfvRRYruAX6FGHc/mHZBuT0idnMuhgSv3N1
	 b8QW42zXdkpABEdqRQr6WES8MYgyn4ePj4Cvs6VLl8gXc49VNCTOrWOUfjz9xNfAyVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792737832;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=bfgXKyJwwF/nfGtCyOlS3xPYMWC1c0JLZ2eQ5Uv2UcM=;
	b=bXHIoa25ifYmVjeVaUjg/KWhrF0ARI0CjA4CNfioMhNchIbUGQPEap0yHh2oslWrGZ8G
	 BKMF65IgbZzh5zjkrv8f8b5xlNxJGncT/oRNKq5LKJBNNxTsi4zOzFMHha33kxFj8uSpY
	 B5BfyJN8lGP0dUvzSJ69yomKf/ml3WwKs/5AL72JCfUki8g9rxKT58lAf2cLu2G8XA0+r
	 JEy/x31EBUjxh/UrUGNqs3aYhzpmm1kyQvYHrdfEMbe2quR0T7axPjN3d0eSv/XUOzyEW
	 AYoigZiDMcuHmuq/O3ipxLXaruj74XokpIYsjMDm/o9yl59xcwnsI78e2NSvLhZ51zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gentwo.org;
	spf=pass smtp.mailfrom=gentwo.org;
	dkim=pass header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b=Jl9PyvKQ;
	arc=none smtp.remote-ip=62.72.0.81
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D10606A31B;
	Fri, 23 Oct 2026 06:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9D10606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b=Jl9PyvKQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1792737831;
	bh=ApygcX8wvo5BhNbhfSWDu9hHkemTxweY5H05LTIOMyg=;
	h=From:Date:Subject:To:Cc:From;
	b=Jl9PyvKQi/iiZHL/mLsUABCk85OXeLxFFY3CAuwJxeqKEG8Y6cGMsNVmt+kMRGPEQ
	 LbC5pTO1dqEJMQFA8DecMAdTSVyowIaR3K/z0PF6LT0FOvVXLiZkZ13ULnnSF5ObgK
	 o7RpZcwQfqlaCL0N9ke9pd0mrrLurFeml2IGK4C4=
Received: from sut02sys-r112.scc-lab.amperecomputing.com (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTPS id EF764401A2;
	Thu, 22 Oct 2026 23:43:50 -0700 (PDT)
From: "Shubhang Kaushik (Ampere)" <sh@gentwo.org>
Date: Thu, 22 Oct 2026 23:43:47 -0700
Subject: [PATCH v2] mm/vmalloc: reject overflowing vm_map_ram page counts
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
Message-Id: <20261022-vmalloc-reject-overflow-v2-1-0db7a20c53f0@gentwo.org>
X-B4-Tracking: v=1; b=H4sIACIC22oC/4WNQQ6CMBBFr0Jm7Zh2sCS68h6GBZYp1CBj2qZoC
 He3cgGX7yX//RUiB88RLtUKgbOPXuYCdKjAjt08MPq+MJCiRisizM9umsRi4AfbhJI5uEkWZFO
 TNaZxteugrF+BnX/v5VtbePQxSfjsR1n/7P9m1qjRuJ6VOpFz9/N14DktcpQwQLtt2xdwn0Sbv
 wAAAA==
X-Change-ID: 20261022-vmalloc-reject-overflow-e532c556f3fa
To: Andrew Morton <akpm@linux-foundation.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Shubhang Kaushik <shubhang@os.amperecomputing.com>, 
 "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, "Shubhang Kaushik (Ampere)" <sh@gentwo.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792737830; l=2414;
 i=sh@gentwo.org; s=20251010; h=from:subject:message-id;
 bh=ApygcX8wvo5BhNbhfSWDu9hHkemTxweY5H05LTIOMyg=;
 b=sWycU1BHCOHtw8daozCzYfO25cHs4g8ar2Cxr8a1AFLY6WYa/z7XiqMu0fn+r+o2hiGkeEI1I
 noANPfedynlBP843L13bK5Dm/GemSOs54ibXM3JQrhnTs/EeROQWcmv
X-Developer-Key: i=sh@gentwo.org; a=ed25519;
 pk=jc8YIRvxPSyJaBRe5y+a4N0RXKBUEcAh8+OFhlROXPY=

vm_map_ram() accepts a page count and must either map that many pages or
fail. It currently converts the count to a byte size with:

        (unsigned long)count << PAGE_SHIFT

On 32-bit kernels, this conversion overflows when count is greater than
ULONG_MAX >> PAGE_SHIFT. vm_map_ram() then allocates and maps only the
wrapped byte size, but returns a non-NULL address to its caller.

For example, with 4 KiB pages, a count of 1048577 wraps to PAGE_SIZE.
vm_map_ram() therefore returns a mapping containing one page instead of
the requested 1048577 pages.

If a caller uses the successful result as a mapping of all requested
pages, it can access beyond the allocated mapping. Such an access can
fault. If the accessed virtual address is occupied by another vmalloc
mapping, it can instead access and corrupt unrelated kernel memory. In a
userspace-reachable call path, this can result in a failed operation, a
kernel oops or panic, or the effects of corrupted kernel data.

Return NULL before allocating or mapping anything when count * PAGE_SIZE
cannot be represented in an unsigned long.

Fixes: db64fe02258f ("mm: rewrite vmap layer")
Cc: stable@vger.kernel.org
Signed-off-by: Shubhang Kaushik (Ampere) <sh@gentwo.org>
---
Changes in v2:
  - Use check_mul_overflow() to validate the page-count-to-byte conversion.
  - Describe the short-mapping failure mode and its worst-case effects.

Link to v1: https://lore.kernel.org/r/20261022-vmalloc-reject-overflow-v1-1-5fde0042ffb9@gentwo.org
---
 mm/vmalloc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index bea9f76ed7e74247d4ce919250c2f02dd5c36483..8a056e424a4f2c037c10f736002839014f1f57dc 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3083,10 +3083,13 @@ EXPORT_SYMBOL(vm_unmap_ram);
  */
 void *vm_map_ram(struct page **pages, unsigned int count, int node)
 {
-	unsigned long size = (unsigned long)count << PAGE_SHIFT;
+	unsigned long size;
 	unsigned long addr;
 	void *mem;
 
+	if (check_mul_overflow((unsigned long)count, PAGE_SIZE, &size))
+		return NULL;
+
 	if (likely(count <= VMAP_MAX_ALLOC)) {
 		mem = vb_alloc(size, GFP_KERNEL);
 		if (IS_ERR(mem))

---
base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
change-id: 20261022-vmalloc-reject-overflow-e532c556f3fa

Best regards,
-- 
Shubhang Kaushik (Ampere) <sh@gentwo.org>

