Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792763286;
	b=XD+h3NBL9uP/ERDnkiLrz8EVm/i2aRN0BsrlCFpRjMAzZnVTpfLGngjsbhMv7gOODbYk
	 bcfsprffg0Zies7cgxruSS1fR5P8laJj5dSSlW1XCKQy1J94c9xeWQirubEJsy3r4t0Mn
	 eKfkff662y/OI8A/GtrxP7fduYAocFrR4nFZhCITKSlP7nPXnJVfqMW66JVC6+bnyGyPs
	 mE5RfFoVqarBXcjb7TwuanquMRTl66jaZTmEc9S6t3kMPwTaTMJdOhLJ8mO/qanrYY6NF
	 u9GD0r8UA7a4uzr2L+dCSTAiklNBnt5Cm+ZkNbYeRJX8UVAwjjkJmASLhxjTxLP1QCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792763286;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=7Ij0mwfZKNK/iHnKQbkQjE2lD9tsPVCKzLil0h8xoKc=;
	b=5sTkRw3FqZf2nkPJfclBYG+KDr9VTKzbsnLlNIKsXh4ehqe9UpbF9mnDy8fcC6ZklhKR
	 tnbd89s85Eh+t70wHvXqz574Zecw+yyNnS4gJN81XTEcR2EiOT7UAL5lmhwv2lQ51Zuv2
	 7DSFjVT3jCNhydS+KHDw+IkOHK3mQTaaxAWpwtXTz1P/eRiQpsmk11A5Bv5VIErK1GiMi
	 h3P7raPzVXSKKFUewKRaX67EH59bAB13O2L9l4jKi/DU7taYAfBJC6BXZlNmf8JRbnn5B
	 esCsi+xdtuD9cgxe1CCd5K3sBxG5MHG9SpQd198sFMx2IGKZyulCs4NhwPUy+hXUP7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oFGtCt+G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD6A60A2607;
	Fri, 23 Oct 2026 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oFGtCt+G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43FA41F031E7;
	Fri, 23 Oct 2026 13:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792763286;
	bh=7Ij0mwfZKNK/iHnKQbkQjE2lD9tsPVCKzLil0h8xoKc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oFGtCt+GgQFOTdE3OqLHpv+WzwpO5SENfJKSSmxHTpxpGG5JcsA5xd3k8tqDqM6Uw
	 NMEOQVo5FMVjp92q6GCu5MZlOe6jB3mu6EbmeOd9LpLoFpyfEBGf8WLsmkk/dYRjMA
	 c5NjKIGX00hxSbXe79Mf/T/SW7frhQUnnXUl1V7V0rkBEBYtNd8A/aPLcuPJinwViU
	 /SIbwMBGpk9rx6TrnEAHmqm7vkOy9/c+2LthUqpseIf2GwJZLIuFBwGCqWhsWAXBby
	 2LvN/rEYWxcnEECFSUWBbY6Dw7bI8LM8CrEp3f329IUAcCc3XC/nSeqvW1dNbr0CrS
	 JsH2s8daLPerg==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Fri, 23 Oct 2026 14:47:29 +0100
Subject: [PATCH 3/4] mm/madvise: preserve VMA_SOFTDIRTY_BIT when changing
 anonymous names
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
Message-Id: <20261023-fix-vma-atomic-v1-3-8ff4fae1fc85@kernel.org>
References: <20261023-fix-vma-atomic-v1-0-8ff4fae1fc85@kernel.org>
In-Reply-To: <20261023-fix-vma-atomic-v1-0-8ff4fae1fc85@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Davidlohr Bueso <dave@stgolabs.net>, 
 SJ Park <sj@kernel.org>, Kees Cook <kees@kernel.org>, 
 Colin Cross <ccross@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1763; i=ljs@kernel.org;
 h=from:subject:message-id; bh=+8zMzgPcLWkBMrp2HQCx5OthBGMujXI4JiuFV5MjM6k=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJup7asPWgxuTRpFeeuyyEmfqXRK7qPdC+fXBrvdpvZi
 kOaZfWkjlIWBjEuBlkxRZbnX8T3B4mEzeu84O8GM4eVCWQIAxenAEwkh5OR4R7vItZTfy9nbBXN
 m7N+7kbrC9MfMfJJTSotaLjv2Dxd4yXD/9pLn/efZpO/nnLmX4vZnldH9Za6LT0qsTHLVbtX+tc
 1YW4A
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

From: "David Hildenbrand (Arm)" <david@kernel.org>

When changing the anonymous VMA name, madvise_update_vma() calls
vma_modify_name() to possibly merge with adjacent VMAs. We don't call
vma_modify_flags() and consequently don't obtain the new VMA flags.

Later in the function we update the VMA flags to the stale new_vma_flags
we obtained before. This can result in us losing the VMA_SOFTDIRTY_BIT
flag set on a VMA we just merged with.

There is no need to update the VMA flags at all, so just exit early. This
skips calling khugepaged_enter_vma(), but since the flags didn't change
this is fine.

Fixes: 9a10064f5625 ("mm: add a field to store names for private anonymous memory")
Cc: <stable@vger.kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
[ ljs - Minor edit of commit message, rebased ]
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/madvise.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index b2e00efcaa54..e9fa4f71efea 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -177,6 +177,9 @@ static int madvise_update_vma(vm_flags_t new_flags,
 
 	/* vm_flags is protected by the mmap_lock held in write mode. */
 	vma_start_write(vma);
+	if (set_new_anon_name)
+		return replace_anon_vma_name(vma, anon_name);
+
 	vma_overwrite_flags(vma, new_vma_flags);
 	/*
 	 * If the vma become good for khugepaged to scan,
@@ -186,9 +189,6 @@ static int madvise_update_vma(vm_flags_t new_flags,
 	if (vma_flags_test(&new_vma_flags, VMA_HUGEPAGE_BIT))
 		khugepaged_enter_vma(vma, vma_flags_to_legacy(new_vma_flags));
 
-	if (set_new_anon_name)
-		return replace_anon_vma_name(vma, anon_name);
-
 	return 0;
 }
 

-- 
2.56.0

