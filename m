Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273137;
	b=OvrtKPacqoKYpCNTX6qspdOSfEAZrWStgIhZWOAWq5lQlCxErn/3XGppwEwl04fE7kVD
	 +2+zt7pdgo2dVRXS05qGUBeq88Im2698kCVVaZh4K9JInA0TCjTiNQtNNp3G6meby7OCp
	 NOqj7F8eRbPn7meUSgQ9OBG/NzhLoUkt8FJmpT8U3A8UBRtUF72H4nweBBdSYMW68YOdn
	 awFruUAjyuq3H6p40HRNBsyBFJZPIutywZie39CFAcmWINV0Kz342FpP/2OrqRiD5kkt8
	 UOharliJl5UWh/j5Z3tV1BSIwO22Py07DEGQT58oC9WOhksqE150a41QxyApJAoSD4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273137;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ul5rSqRxW5W2e8Bc/gm/SocArtN4OqqzFCN2G5ninWs=;
	b=cDLMxdAK9We7pAO1WajhETplVCJA5SlpuqKtPsTVDfTVDNBlR4zHD1P1nFe74dXnPZxT
	 wVu5tM8cyMbMZHluCB7U/vhJpIrgXs7zHxjvf4YI5Cba3TO1ONCR3F//Az94Tt7CUtRcn
	 Lg0HDkQ+FoG1c82Vq+Ondf5xl6FX1NP0QNWKyJE/TgwexWd/0iYOmggEWRxpO+BHnCXvu
	 YRoafHHUY3vz9Ce+W5Oi+7JI8sZy9MPOEFjUj9qsd63Hk05bxP3sizzK2GRQr98dp/dSl
	 kdhcbfp16yYQq86O+HuXua7Ixl4Rz8PsN8724LcsXQ3Begts+/ADTnYsgpHSPPKn+iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OEn4gq2q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1360606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OEn4gq2q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19AE1F0089F;
	Tue, 10 Nov 2026 01:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273136;
	bh=ul5rSqRxW5W2e8Bc/gm/SocArtN4OqqzFCN2G5ninWs=;
	h=From:To:Cc:Subject:Date;
	b=OEn4gq2qdgpPnkrG4WJD5T7oGsrIQXgJqibhHvZFBT6G6PnaHNaXlzv0+vUMhKZXN
	 ZnrIhRqm6mk/IwEbi4XSyiS6DUkmc8g6xb6oh1zAm2RHRqgcqxtEul3T9dTf9tlUeS
	 7v78ech8+bcxXOiGPLRor2rsqTIFUW6nKleIcG/1wTQcDGqYTKLSnI267mfFqU1xbM
	 dlO5W9CJakjhPH5FpeKbKVWjbrO2DxvjT8Pd53i/sIXCqyxtNYKRw+MJbQn2ELMJnU
	 9HhoJ4uRpW/cZP4/0srukzHB/8I3nGcSTc5Bl6b9z7nDjhCBmMZ/3CqFdrYGtVzDY5
	 PZJZvmTNhUFcw==
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
Subject: FAILED: patch "[PATCH] mm/madvise: preserve VMA_SOFTDIRTY_BIT when changing anonymous names" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:12:13 -0500
Message-ID: <20261109201213-failed-6.6-652f15be3c11@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 652f15be3c11415725694ccea317c51e35c0b582
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201213-failed-6.6-652f15be3c11@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




