Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272647;
	b=tu3a/IVvuyUKlvFx+v3yBrxdUmv7Q57SiXPtvSaRLjvfMdHljFiJLxSBTwmhDgvAFV5x
	 U1JPI2Lhg5ajOxQWztaU4fKYtaiw+RSkjV2jDK9iYie1Chy1Vceuc9rnxFrgu8Hc2hJiI
	 TX3x+tAMcqXb0voZV80bVPQpMHFhgksD5WnBMGJ7lZQtHMqbWw5d+v8TtuJZJSbpbXVp8
	 Tj45VcGW6iY+ZQnajItWkHIY101YoRHgLmOz8GZOnlAlxX2LAwAnRGXxCwXdXUcdcrPyD
	 BZ2vYv05IP4abw5/3qyE+1d/SaRCXARJgWXZMkQSfAXrmgBWSGa3LGi1F0oc0Kz53Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272647;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=PnkrPffOmTguio2LSDPraf0BaOEDXq099gcn6b7UVnI=;
	b=UdLszBID5NDCeKhtvDT0yuWaFMjwNGhKjkSmSN13cwC0hnXUQplEqzHlIOC0N/HGQ9In
	 RR/4jpIlB8ARvUDoBxBmCKWKx3XCjTgTphV4zukKID/53nwslSfcFulQEFYqUC3sqtg8M
	 q4P63+21qpqR7Thdc9FlyCInmR+puuDr8AD6K3fZKftbBD/N0mCFH9OOiNJLyklOzQ2Qa
	 5mbpTcLwgueYhVnzEm6Fm4CpZSe2wGvRYSnD6KYOsULIPhnXx36QErlP286orW3bCwJW+
	 t7CbjDQkJn6i9iyo+Mf+qabjVdZTALlODD6aFzIV1589OO0K4Ggfx6795hYbpwJ6XjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Owampi5i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60323606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Owampi5i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775F71F0089F;
	Tue, 10 Nov 2026 01:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272647;
	bh=PnkrPffOmTguio2LSDPraf0BaOEDXq099gcn6b7UVnI=;
	h=From:To:Cc:Subject:Date;
	b=Owampi5iLJ27h0vws/h4KL6uxj+2AlqOFngIQBS489BM+2BciKDyJZm1gB2vVKHrT
	 JDD4bkBhNy1XR9JlCtZL3Fnok4cbuvZvOBgeKbFRFGNOc6BexRVIRV11IouAZU21oO
	 /09T6DO8Hj8TIQ9q3mAAk/h9vYNOKLiWdNR7tiHXxMAKX3oBZti6gnX1dFu2N8uZFx
	 jtZIYVDh//3+EkbM3VYoU6o4bd0uBD6BrmulH4WavESpUbo1/a6u2ybJH+bNiiYOCV
	 n/UvL2EBCIWGnfQBj1b59kDPNOByoF8/op1tdn1/RNRmktFLuNPV3eysi6gWZG6FG/
	 6s87P1beM99Dw==
From: Sasha Levin <sashal@kernel.org>
To: david@kernel.org,
	ljs@kernel.org,
	akpm@linux-foundation.org,
	pfalcato@suse.de,
	gourry@gourry.net,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	jannh@google.com,
	dave@stgolabs.net,
	sj@kernel.org,
	kees@kernel.org,
	ccross@google.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/madvise: preserve VMA_SOFTDIRTY_BIT when changing anonymous names" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:04:04 -0500
Message-ID: <20261109200404-failed-6.18-652f15be3c11@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 652f15be3c11415725694ccea317c51e35c0b582
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200404-failed-6.18-652f15be3c11@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 652f15be3c11415725694ccea317c51e35c0b582 Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Fri, 23 Oct 2026 14:47:29 +0100
Subject: [PATCH] mm/madvise: preserve VMA_SOFTDIRTY_BIT when changing
 anonymous names

When changing the anonymous VMA name, madvise_update_vma() calls
vma_modify_name() to possibly merge with adjacent VMAs. We don't call
vma_modify_flags() and consequently don't obtain the new VMA flags.

Later in the function we update the VMA flags to the stale new_vma_flags
we obtained before. This can result in us losing the VMA_SOFTDIRTY_BIT
flag set on a VMA we just merged with.

There is no need to update the VMA flags at all, so just exit early. This
skips calling khugepaged_enter_vma(), but since the flags didn't change
this is fine.

[ljs@kernel.org: minor edit of commit message, rebased]
Link: https://lore.kernel.org/20261023-fix-vma-atomic-v1-3-8ff4fae1fc85@kernel.org
Fixes: 9a10064f5625 ("mm: add a field to store names for private anonymous memory")
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Jann Horn <jannh@google.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: SJ Park <sj@kernel.org>
Cc: Kees Cook <kees@kernel.org>
Cc: Colin Cross <ccross@google.com>
Cc: <stable@vger.kernel.org>
---
 mm/madvise.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index b2e00efcaa542..e9fa4f71efeac 100644
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
2.53.0




