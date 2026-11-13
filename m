Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597855;
	b=NrF4KTk3FugF4qvRK3Tx2RRaa4Y5mPRWNvOKhv67VPf6yOyVotKAdZbGS6XeqGvoSm2Q
	 lxF77dfNoWLdg94esIMyCnAZPl7d3u0PQfA1AjyDR4ReIS0MIvrNoRfuHMFZXRewNEQFL
	 KCoBwSyJLok+3fSM30xGluLvu0XNYKSVyXholjMJGvJLX+swtGp81LFRt2o88cN5Qe4VV
	 UBPp5JMQVC+JFa3mR94ATt8Or/Qp4K//GFNDeJCpfjm2qeM28l0I9ZY6lFeBpFmrJcrvB
	 loaFgWmf6b7Lgu+w/JHiJxZicAxf3Wd/znnztTGM5fgt//NcPra/ddtqlGEzz3iwzaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597855;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=g+jxHAD5tqvDWhn11Lc/6Dz/S9DUj4iP8SRne6Ayzik=;
	b=ZhEPSziBQt4KvMTW0CJHiHhkOAzzP95gXBPMOnbC5lb9qjxvI1jnRFGoSZ5ybwHuN4oi
	 N5thNF16tukhXjvAwb5zmgV7McuX2AfZt7gzJXdETsQ5LZHI9yM4oS0w8w/euGGpxsO8k
	 9TTVPMO7VWrTx71XsTGo816G5wdYXX3uxaF0UGb7yDXfZTjYrp6uMxYkIjOrlwtIVVbI2
	 bSessfySEdTIDDZsHdJAq7CgbE2wjllShqoY6GokKBTV++NgQvbYu5l+HIbC1s1GkcRDq
	 si9epp8jNvqOCSQBkYKPHRjVfa7LsCM7cMIp2YZvJb5hI3MTg00uq8Asm+Nw/+1g5eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bWWQtrWs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDE9606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bWWQtrWs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B346C1F000C6;
	Fri, 13 Nov 2026 19:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597855;
	bh=g+jxHAD5tqvDWhn11Lc/6Dz/S9DUj4iP8SRne6Ayzik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bWWQtrWsijskNl+bNWGGDNYsI7Ytyy2/8K0sqFw6+gXHVfJgN/TDeDmiKfXOxjArp
	 OwabXJCxddrxA2N22y7RV3RtGIwTSWxtiYGPZmtHsNzFt1z4Q+lT0/HJqBj8jvRA2r
	 NH98P9jx4fZlC0yFsbHvWW33ESkKrEY9g6F4hf4Y0nf/yha8ZMDTjkIHyPKLUum5QF
	 wXSDil/PpsH77qfOj7Gv7SKGczhtaIr32hsZ4LbnmDtoTQozEy2q36XGsxPxVANgwR
	 BmlrGZiBJdBwfsemePQnzOLBHaGdCWeS1AaTszmbermcd0Df8TH+o9+x3Cd5VvkhKJ
	 brmnR7pUPCmcQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pedro Falcato <pfalcato@suse.de>,
	"Gregory Price (Meta)" <gourry@gourry.net>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jann Horn <jannh@google.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	SJ Park <sj@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Colin Cross <ccross@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] mm/madvise: preserve VMA_SOFTDIRTY_BIT when changing anonymous names
Date: Fri, 13 Nov 2026 14:24:12 -0500
Message-ID: <20261113192402.2278376-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200404-failed-6.18-652f15be3c11@kernel.org>
References: <20261109200404-failed-6.18-652f15be3c11@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "David Hildenbrand (Arm)" <david@kernel.org>

[ Upstream commit 652f15be3c11415725694ccea317c51e35c0b582 ]

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
[ sashal: Adjusted context to match vm_flags_reset(vma, new_flags) instead of vma_overwrite_flags(vma, new_vma_flags). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/madvise.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index bd0a5093a2df2..c500f1cbd4987 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -176,6 +176,9 @@ static int madvise_update_vma(vm_flags_t new_flags,
 
 	/* vm_flags is protected by the mmap_lock held in write mode. */
 	vma_start_write(vma);
+	if (set_new_anon_name)
+		return replace_anon_vma_name(vma, anon_name);
+
 	vm_flags_reset(vma, new_flags);
 	/*
 	 * If the vma become good for khugepaged to scan,
@@ -185,9 +188,6 @@ static int madvise_update_vma(vm_flags_t new_flags,
 	if (new_flags & VM_HUGEPAGE)
 		khugepaged_enter_vma(vma, new_flags);
 
-	if (set_new_anon_name)
-		return replace_anon_vma_name(vma, anon_name);
-
 	return 0;
 }
 
-- 
2.53.0

