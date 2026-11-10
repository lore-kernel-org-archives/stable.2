Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272877;
	b=veftpiNeDqdMX/5clEnWGRURqSeUnRTBwLc1vLEnsE9SXMTZesybdaqUQLRQ1vKB5rZC
	 6Ab0JczUiyomieUp2wIqP98+WJ1BEs67QC5Y8u198ZvI5AunYnC8rr3adbYnsjifQfFsY
	 ibXDo5n90TxakSmnD3eDoc+iekObJTMKUMCI9g96YpcnQx5La0sVmrkE/5jYZICwXKeUS
	 F6Rjob/Fav9aHRaciQb8hxgf9+MGSj6Nbshs36KPW97VaO1iN6FVBIV6BG4QsJ9HpJWpl
	 jZtSLn4uJ4bD1N7j/96tl7EkePVAgmM5fWVn+Q+CBFiOEF8mRcgUZkKF5yfOzBK52OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272877;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ONihIr5ov3b8ieAzpgLNjV+21iG37j8crPf4B8HHtsE=;
	b=lIkljX28+2VcXeCW5pYCTarJaWJXgJe1h2viFippQ6y37SJY4OfRSoQkXDRxZ+OfC7Mi
	 fW2x5pCG0wP5i7LiueqY5O9bCjcWFYV5MLJGypcRhkIqX4AoLgKG2+UefOQE1d+1c0Yhn
	 68WZU6vgiZVp/FlXm0gdnARPnUvZMOE0LoqqKI0umDKHB2wnHU2RBrBeP7twKUicMM88S
	 r4o+iHPaRJiX+8HCHGHK1ali/2KQmTF4utgZxwN9Kw6XL2nAuGf6RzQQjov5Y5VOKqxn1
	 2RmIV3dhYB/ydiJFvmsIGWa05Rbd8K7kU/Wm3nJZ8INSIZf9uOwbV87fYlQWmzQhdMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F6IRxuVN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A569606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F6IRxuVN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32AF1F0089F;
	Tue, 10 Nov 2026 01:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272877;
	bh=ONihIr5ov3b8ieAzpgLNjV+21iG37j8crPf4B8HHtsE=;
	h=From:To:Cc:Subject:Date;
	b=F6IRxuVNp0P8DSsEdvL8B7ukytl11vMWdnf08dUi9EiQFn1IKdJBPCoR2CKDZSt4f
	 mtTCEppHeMg6kRx0aNdt+J4yb3wiNOQS+SrVNbmv9xNTboPsWOldb8XFBNdNXJ1hCT
	 XiiS3//1KCPKu0oh52apBoBz3Ylj6ElCQHGwTCeWGtglrTMEdaPPThg5qDV4iUPy4R
	 hH+6h41kJB3pIPwgSKAmL5daq+RsMxIFah1gFUM5JJHNuBHIrU417qnESASzWV3fWr
	 V4VkWFyXHRBM/D7lg6fDUTvkc6VARw60ZmEbmWe72WK7gfD94vn9subks2dxT6530x
	 53wqZ3xUF6IYQ==
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
Subject: FAILED: patch "[PATCH] mm/madvise: preserve VMA_SOFTDIRTY_BIT when changing anonymous names" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:07:54 -0500
Message-ID: <20261109200754-failed-6.12-652f15be3c11@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 652f15be3c11415725694ccea317c51e35c0b582
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200754-failed-6.12-652f15be3c11@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




