Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597339;
	b=SHcgkgcJAm6Ryux/D+atIfEhpoF5NQoP8DxUAXWpcDBkXZslOsONZkstcrvHR/eSNXeT
	 drP5A3FtkMrfPlq0ny+Uoewe0/1AQ3c8ereDNc9+WMTS5bpMRJx0DgowcvwrIdC7qJpS1
	 gYi5BQ9k+A9G4geWSesEWUmqT2S4CPOkQETIf+j0XssS2tyFWh8pQ7G4UkgdXvzdou43L
	 GFkH1Aak2dX+8FDslbkue68To5DXUFNdkLe2DCA8uWhT/WYb2VvX+BIFetgdoim/D0ZbA
	 x6ZnQOL6A1oJnPphED7gs9X6ncxiFEq1+8XG9V2FZ0pOsZCaUgp3w2YuwoLMUXS3CfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597339;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FUq6MCIKArwognRj3cxXOhA3B4ITT6AfCYBI735+Kag=;
	b=FKb2Lg7T6zYW+b3BosvZM/BQBc/LuRvytO2A8L0sD4YOLoddzM6pALm+4CnGCOKRw0QT
	 0/7JUJXmHin+Iq+SQZOBzHrSvW9XQgJOxkYf/0e+EAzQPNm7+YjTHex89vjIGLTBQ9EX0
	 V7DTVr0PPu5qNqyty2ytFTs4pexsF+402Jdbzatvc6hYhT6T0FozBP0KLUoBj5aums7DF
	 og2XBjQpvIwfZQTFM2wXsQISt4k/AdLbCdynO+rEfH+09sLTaLAucY48uhXR7R/z0vjOH
	 spUp+pAmeqG8xNSh8O/TPooEGNe5xrv1AKemCpnaByYYjyk5x8/yAbTRth6UmY6wveA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h2xC7MbD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE81606A327
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h2xC7MbD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20B81F000C7;
	Fri, 13 Nov 2026 19:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597339;
	bh=FUq6MCIKArwognRj3cxXOhA3B4ITT6AfCYBI735+Kag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h2xC7MbDCPRogo2UytAabKh2DhQl5EMOjRoNBNu5Zi4HtaB61feKZQCpjO7XPBhCv
	 jnLgGrVzX69FYxpcAXCLmua+Mlyg4JFZy+OCVbs6l5f8BMfEXUVcSAbe73pPNk9Uf0
	 +F3mpZv2vZ8T7+7t4CWTsG6UEaN+levO11YV/117DR4OBwOMTe0VYyBy/Ym26U6xSx
	 3JR20PMW6mgVF6nh67DFCT5AsSrH/9bzEScCFjnsZQeMm7BGIW6ZjDANiAm4ccjqbn
	 R3z1oGvVnabpRTgbIvqgGuSxFS8fF0jtGs+9QG+lcJB5hqUln/7qsVaQlEVK+ZSdGx
	 5SUzYRKQyLFGg==
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
Subject: [PATCH 7.3.y] mm/madvise: preserve VMA_SOFTDIRTY_BIT when changing anonymous names
Date: Fri, 13 Nov 2026 14:15:36 -0500
Message-ID: <20261113191106.2227436-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200138-failed-7.3-652f15be3c11@kernel.org>
References: <20261109200138-failed-7.3-652f15be3c11@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/madvise.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 9d64e15dfdb48..7291d03d66928 100644
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

