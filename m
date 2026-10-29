Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793269126;
	b=GqlV4X5u3Cv926xwBQEYiaFzx2dcoPeW0gYmZROA9Mp8atEJxWUVgt53YCAV4TN/PRZx
	 dYoDNIIEgiyD+GlHL9oSEDGLcv/MzcL5lrP0dC87CxFY7g8RkhwhAv589JPLX5SbXhHqy
	 wHNIbqpbO8qi3As9Mn0gdyGoUAEDHbN3ovLhziMNXU1inhgOExw46n4R9ibQqjbCFcUUn
	 8MDN9B9dFIEbOa4LnfHfky9HIs2Y1qK5aZQ7ooE+H3hgiboS1OV9+et6O8oIgJ/+jz+KW
	 4muXqkxIYThqgna4aomHf1Y2w5R7PE6e12S0UjF32OsdAbDmOsKWCOaDHA+OyVPWQMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793269126;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=xBpB5rqMwqaO0EiguVkBI+vJ38Q+R+hHBLQGHSLh6Io=;
	b=ft05M0n+xiOR+PLMQc80w0UnrbOGkLUhFWsDgaOHFKfK7jma8WoIXFqUyaztT8GIVwjo
	 iv50niLUM23Ymjtvyx6vFED0/DuPq/o8XNGntlgpC4AM6RCc+zlyNurIFzA8+dy6aIJ8B
	 G3kETekwq+0acycTEtsCo0evFKCmT0TyGCL8VDM0pvZZLb5TN4G4zh0NnlFHEGoRGleWe
	 4rRE3ub2Mb4rTfEIO+9Y28NJk3Q1gYoX+iJU3GiFeugQR8tVKsRzvorbIC70OlohB4xLU
	 JE1PUWQ/HACkdzNpzPzQkLMzOHfVkoZdUfqTQ1RLpS+x/ZJe3x7NUjtZsMkNtJ/yfxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mjH9b6uf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D98360A2634;
	Thu, 29 Oct 2026 10:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mjH9b6uf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5275C1F01828;
	Thu, 29 Oct 2026 10:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793269126;
	bh=xBpB5rqMwqaO0EiguVkBI+vJ38Q+R+hHBLQGHSLh6Io=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mjH9b6ufQ0uFKdPmq2bt3uv53CEse22aWsgSGvW0075uoTXX8hxJoXpO67N855U9H
	 BBTD4zayPyW0W8Cy+vHaZJgzEz6sLHK9kiuSKnwBTpdr9ONtLXpC9yBHXrbrynDzHW
	 wggNJAF2pDgRD//fEt397LEDRpDQsuhOqUIJJBKGWXiL0khRSoW33GjxELcpHRZ5u8
	 Q7ApB9GtBMe3vFYB2uutEzEWI/aM7RH9lxkCOYuOu3VmQnjqhclH9Gz7ydWwuwpN0t
	 AALQfkdt9earHQHN8sbQrNCvQD42YzZ6qHwhgB4Fw4wOz0b9I38zRPcwuAh1yDpIyk
	 SWDG12pDuFP3w==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 29 Oct 2026 12:18:37 +0200
Subject: [PATCH 1/2] mm/cma: accept memory of multi-range CMA areas
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
Message-Id: <20261029-cma-multi-v1-1-2cbced8b5cb7@kernel.org>
References: <20261029-cma-multi-v1-0-2cbced8b5cb7@kernel.org>
In-Reply-To: <20261029-cma-multi-v1-0-2cbced8b5cb7@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>
Cc: Kiryl Shutsemau <kas@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
X-Mailer: b4 0.16.1-dev

On systems with unaccepted memory, memblock allocations accept the
allocated range, but when cma_declare_contiguous_multi() uses open coded
allocation of multiple ranges, it reserves them with memblock_reserve()
and they are never accepted.

These pages are released to the buddy allocator by cma_activate_area()
with __free_pages() that does not check for unaccepted memory, so the
first access to such a page in a TDX or SEV-SNP guest is fatal.

Accept the memory of each range when it is reserved.

Fixes: c009da4258f9 ("mm, cma: support multiple contiguous ranges, if requested")
Cc: stable@vger.kernel.org
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/cma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/cma.c b/mm/cma.c
index a10ea37a261da..0035efb1130a5 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -678,6 +678,8 @@ int __init cma_declare_contiguous_multi(phys_addr_t total_size,
 			break;
 		}
 
+		accept_memory(mlp->base, size);
+
 		pr_debug("created region %d: %016llx - %016llx\n",
 		    nr, (u64)mlp->base, (u64)mlp->base + size);
 		cmrp = &cma->ranges[nr++];

-- 
2.53.0

