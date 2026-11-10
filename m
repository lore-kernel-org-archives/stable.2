Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272502;
	b=Sc3OVuUHfTbLzE7mepSKcDrPItxYxyoN0GyrPTEsIwxtrDoCyozvl7BntC+KWksfzEsi
	 TzzmqrO3mjf0OFKPW8L+YQIjlKKZ/uiAZoC7GdanIrhvytoRosne/CRQZmEoPvxjOcexh
	 oyJx1vUrR53aBDT507puejzXiNaqqVF0Y5Cn4wE3/1XZkjWlmS88zSlKeOdqqg/hZFquy
	 e0nZbRNPPDrtet+NpGAw26k/bOURMXUoGSzwCEfofPboRcsgdX609vUZNZl7T4Pf3G/lf
	 DOScSappuxqkaKuQ9T66FPpBc11p8hxBOqUj3gdmeX6P8R0J+XG/karohCiSjoRxN9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272502;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=V6QI+dRSgg2JgnLCUtGgato343/dqRjVKycgIyYaLho=;
	b=nfImlpJSPmM+sGWzQrlImNhSoB/Z1CBtmam+cERau+o0hyefUPOoImMO53DxAuXzwmWv
	 MkkRLEbkFb1padKQpkr6hBhrD7IebllMdT9oCg9dDbQeVmpwV9f5ZSZ/rAqAdh2w5W66E
	 5v9yzZ1cui74hvPr71Bskdyfy1krcEP5g4ObNNtjrht4wkOu7VERF87MTadu5tfEzKyVI
	 Ov42mIDGG6AnTTFX/d7o0AkngZgaCr9/T03vV3fLlWlb8u2iF9WC2MvJwZwLrp+99qA9u
	 zzaXf2jiPnU7jyQtiFBvzySyAljlpXlL9Kx7VzMNcFA7+zBtNE58Uo8DJa6DBVnUOaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DrhEklUt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2F6606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DrhEklUt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8231F0089F;
	Tue, 10 Nov 2026 01:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272501;
	bh=V6QI+dRSgg2JgnLCUtGgato343/dqRjVKycgIyYaLho=;
	h=From:To:Cc:Subject:Date;
	b=DrhEklUtoFmLP3bF8wb05VtJN9CHojhzo5Tj2vqCiJks656dLgB8zo/lJr+SO5Elp
	 hJu5lBpeYbFFDIS3dEsQISyEraiIxGvEGK/4UQ3/kuMCi5xhYXZWZ3FQLsYJaqR2YG
	 azVgvfHrb0Dc79YHyKh5PRujOiU9J3uThLTzflR3gxn6MEMSkWVqnQkBV6UwTDo3Y0
	 tRPZyxeobzEQH1BXe6j73Y8fCE6HZpySZVAq/vglGwgYKh7kkOjPhgpS3RHNqh6X1u
	 DuBP6RaYufJC15ttRgNmH9HsYncBG0erBATAJCQjegj/oHfYvC70SUwHsYqj60Gz5f
	 F9Fem92olRtyw==
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
Subject: FAILED: patch "[PATCH] mm/madvise: preserve VMA_SOFTDIRTY_BIT when changing anonymous names" failed to apply to 7.3-stable tree
Date: Mon,  9 Nov 2026 20:01:38 -0500
Message-ID: <20261109200138-failed-7.3-652f15be3c11@kernel.org>
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 652f15be3c11415725694ccea317c51e35c0b582
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200138-failed-7.3-652f15be3c11@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

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




