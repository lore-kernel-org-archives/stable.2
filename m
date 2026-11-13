Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606459;
	b=aOuEjQ2YoiWpmt9BvpFQGZp4XQ8SVYaOo5ybStJgea/VwYLpLdKT8dwOHcGzZfqhHBOT
	 WGKRKKi4A4CSsHdHeCzkx0jADZJ90Iz9OH5ss4Q7OXQG2cuA8RO7g2zsQig4L8GT5D5l8
	 FjHfHV3fTidwQh+9G64HIiWA6dmKAkgXYN2GAZRT76rMHaJ/WI/ACRwrg5bp0E3YkQIfk
	 oYAKrpfA4IAS1R3hGSKwRT0ftCRoX4FrydxjBrIOjKSXi7IA8TYewvSSvM6vmaIzWHug/
	 POiJBmgLFhipJzlC2WwmMGaWugqI/TWddnFKxVAKPKJI426JA8hkTnrCEppnh6m51XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606459;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=EVGtKF6FKpBC0GQJpLurENXUpqk/PqZHogG9Hp2Cj40=;
	b=aBuGEqY6CUboNjqOLqys4To3XqURRrLHy+aO3JgxQ7K0kQlunpiKyrFV6qrNV8Af8AQ7
	 SPAHbCnhLx8tOo0gorQsqaswd+OH5enaDeOZOrPhr6wenE00x0b0ZGEEN74VdqDFsLuGF
	 odQjDNsz0uXUeq9k9noPxu9qIFEZIW4sSjCTOrydqzUNbvTjmdzTRj+ABvRSmvIOG6qDS
	 HLCadWgHROlg5fmQFPX84lev2pWkk9pPthkLZfc3tBLWVLYXe4B1N2PQC68HIpL8/c2k7
	 xja1n41j5fb5EJdt0ekBfMiooh3iIAXVQ2uQ7mxDzxkyrpQfcyq8Fahy//JRXBdZLkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="F/SJxPUK";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEBB606A884;
	Fri, 13 Nov 2026 21:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F/SJxPUK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00381F000C7;
	Fri, 13 Nov 2026 21:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794606458;
	bh=EVGtKF6FKpBC0GQJpLurENXUpqk/PqZHogG9Hp2Cj40=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=F/SJxPUKsWw9KwD6IhshhUpHjW6DHQkRPGFOfRnB+uMTJCuqi3lh9o8CkpYnXqZ5D
	 kzK+WAmMR3/5AyZ6epsw2P4kUpiADuP3MqDbhkDChfX94ogsgCcIXm+xuk3fT49aDq
	 yAztse6uk4GBW0X30ShIdtgRBoaB8FbeX4Oefc55jdTZAnQEZJfVp7A0yyMQKn+okC
	 3Uq9JEJrEBNEV6yCYnPGGf3NPFg8+YsRlA2crfzjYVouGPx6BAu8qB2XPJduHjxzaQ
	 XOzJrI0DtOUksjmqflimCbau3dGdkpMDFnUzzdspcWdQ3YT2fhiGdFw2vkMcC8ZnfC
	 GQMK0vB6NFb+A==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Fri, 13 Nov 2026 21:45:30 +0000
Subject: [PATCH v2 12/13] percpu: search the whole reserved chunk
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
Message-Id: <20261113-mason-migrate-et-al-fixes-v2-12-50a2ed382b61@kernel.org>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
In-Reply-To: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2143; i=ljs@kernel.org;
 h=from:subject:message-id; bh=27veALNSCwRMr36dOVr3JSTW+zu8/EiCuojiMwW/dj0=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK+t/zKvKyy4bL4m7Alhqfv7PI/mJL01mCltpBt4Z3jN
 5nN9vhKd5SyMIhxMciKKbI8/yK+P0gkbF7nBX83mDmsTCBDGLg4BWAi/y8y/A9e6Cy0vjXu4a+s
 My/VnQszmGKvzg4Sai/i2PXyd/BdIWmGfwqsNqEhyXFcFs/WlW484dUoGi1vav7cR/vbJrPa4Ge
 /OAE=
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
Cc: stable@vger.kernel.org
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
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

