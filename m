Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420965;
	b=KrMV0WKMz6w88cdygYga6dp49hupZ+f77CH4NvMmnzarrO1LnbGZdefh62q7TZQ29zlT
	 rdowDKZHwHs4kDC1hRaoXNyt4gsKGLZ3Wg6wMgjyxFiyoW2QrjsPYWiopdwhzqWqFy4VS
	 pzDFzsKLp/DFWrh3vD7SXv425DIXRXO9OpiAmSQkqAnqPEBGut2rfL3sTMCjyWLB8EgVL
	 ijSVLNv38CRE4OeAuAsiaFH5ZhdAS1Pj+q+zm/UVTA3sXVjnqt9aOqAIeh0InDqXC+L7o
	 q1VusbFfo3s88mVVaJsgX+6jX2C6iI0LvP/dsXyRANVs8KUhKyu03UzpXaBuOOPqO8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420965;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=gHQXVCC9s15eyiaLxte2ARwnnlUvLG9Bk/OUsLlsEak=;
	b=YEVYAvcbLjQDoKzUy6vWyrvM9ll4slhMRkp22CvX5DNT2dXDgmpkAcBGzRy6oxCS2HRi
	 0v9Mjvia7KLG8uS7s9WotZwBIJwghTJvd/BNgfi0gtNSlXAKFFloPp91c+qPjNWnMEajt
	 UT1nZpuk74FLiAMlEkwCMdANV60KRtPIH+2L6KmnNPFv5vxfgeaP9cJfCWDLjG1WiiG+9
	 stLFdS1rk6ewLUxp2EtvG8LfKtAgcCJuwm6Qep3nGB7UVttuX+kQcI/ekI5uDauGdKTS3
	 u0iIYbW2hHcnM0SNUjhrvBKHNcSEyWpeNyhMpln7vnEnLPAOw/MWkVr0BoXdyHT9YNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oFTd4a9V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDD2606C14F;
	Wed, 11 Nov 2026 18:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oFTd4a9V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A861F00A05;
	Wed, 11 Nov 2026 18:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794420964;
	bh=gHQXVCC9s15eyiaLxte2ARwnnlUvLG9Bk/OUsLlsEak=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oFTd4a9VLa/XwtT0kQxj7lvpK4i/1fxXPbecoEMAvVIDgYsMPTiVKKBucxg2HEYFp
	 wUyl6A/5anWyc6q5NthqrAV2XVkBI2tS+r++2MosPsBrOU0VXDkao2WN4QHTgYerij
	 uXQnryga9lfBQn3+lg59uiJIDMRijhwACUOOz9XE17Hf6BYwM/3a1zN9MTvIvuWJzA
	 40rswyF/GfrH8DmaYzkUvpMfNbw6Hi2WONuq2sI/BC9FnhJe3L+PhzZsNO49s8u9Qa
	 Taa5ZzcPou3juDjdpjarC5yG6d9a//zA8fZtrkM1emoNDeCmrm2uenAAkzvtLa3fAq
	 Qj54gU8+Gb1VQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Wed, 11 Nov 2026 18:13:26 +0000
Subject: [PATCH 12/13] percpu: search the whole reserved chunk
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
Message-Id: <20261111-mason-migrate-et-al-fixes-v1-12-3d2454362e8d@kernel.org>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
To: David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
 Kairui Song <kasong@tencent.com>, Balbir Singh <balbirs@nvidia.com>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_Glisse?= <jglisse@redhat.com>, 
 Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
 Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
 Chris Mason <mason@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>, 
 Mark Brown <broonie@kernel.org>, 
 "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2037; i=ljs@kernel.org;
 h=from:subject:message-id; bh=NPnEzGMSeLqUdofRcE8Jqf5+1JnDIvID6zGRo42zLpI=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK+bMgRf6apwd2T+DEpp6PsRke1ZUEeB9uMRV8+iW348
 tC58bp8RykLgxgXg6yYIsvzL+L7g0TC5nVe8HeDmcPKBDKEgYtTACaivpSR4Ub0pGmOiwQvnmKq
 FSlb03lbp2vFp+nlxZFMl4M3Bck33Gdk2KB7gfv2mpsyWQ5XhX8Wx0bl2PRcKXl76HTAZdVJ3Jt
 suAE=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Loading a module with static percpu data can fail with -ENOMEM even
though the reserved chunk has a free area that fits the data.

pcpu_find_block_fit() does not scan the allocation bitmap, rather it
tests the request against hints, starting with the contig_hint of the
chunk, which describes its largest free area. If that area is too small
once aligned, the search gives up even if a smaller free area fits.

Consider:

    request:      256 bytes, aligned to 256 bytes
    contig_hint:  260 bytes, starts 4 bytes after a 256-byte boundary,
                  so 8 bytes remain after alignment
    also free:    256 bytes, starts on a 256-byte boundary

Ordinarily this is fine as the allocator moves on to the next chunk or
creates a new one, but the static percpu data of modules can only come
from the reserved chunk.

Fix this by searching the allocation bitmap of the reserved chunk
directly rather than using hints.

Reported-by: Chris Mason <mason@kernel.org>
Fixes: 13f966373f92 ("percpu: skip chunks if the alloc does not fit in the contig hint")
Fixes: b4c2116cfae6 ("percpu: update pcpu_find_block_fit to use an iterator")
Cc: <stable@vger.kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/percpu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index dfd3ff0a1ac0..f87813e6ad73 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1771,8 +1771,11 @@ void __percpu *pcpu_alloc_noprof(size_t size, size_t align, bool reserved,
 	if (reserved && pcpu_reserved_chunk) {
 		chunk = pcpu_reserved_chunk;
 
-		off = pcpu_find_block_fit(chunk, bits, bit_align, is_atomic);
-		if (off < 0) {
+		/* No other chunk to fall back on, so don't rely on hints. */
+		off = bitmap_find_next_zero_area(chunk->alloc_map,
+						 pcpu_chunk_map_bits(chunk), 0,
+						 bits, bit_align - 1);
+		if (off >= pcpu_chunk_map_bits(chunk)) {
 			err = "alloc from reserved chunk failed";
 			goto fail_unlock;
 		}

-- 
2.56.0

