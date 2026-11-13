Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794603720;
	b=MdTH4RDEarAPcS3NKsbwiW5TTbWxGMEi10ZbuiEwYhLc49eUwYZZNsQx1z8yEEH3tv5d
	 v0fXQ4fs/Og4n+T2k86jMJYAGBuS9YAA9380nhcFr2IWadcUYzu/sICU3mDOzq6sfuNjM
	 wJmKXyPqFReIN4sHcdjoqu3wv5R+OgQPwhoHylKAN9DvT/lWBnLRmNnDOZit0sTIRGVV4
	 uMaNoytiF6No1moG62yq1aDa3GmRHwgSd1v3PUy/Y+jE39rfVv0ZE2QazMsONf9+ft8M6
	 Kpq7GucH5/tuGzbBuGqxOyGxzsFNXLXZZhXwaxhifyGagldAG7HxOAeHBI+dHSoVsbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794603720;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OdFb2CISyTt2bJfUX0cO/FELNTV+1/KNJ103zgslpw8=;
	b=cHXMNqfIRF6dAkjnvcEvHIfMH3Ra/b1ief2c0fwxcINJInRez6+LkqajAEFJyNEA1+cR
	 /T9AFFBqfhllldS47JZgQ8HxJXwjngSbnHOpsMKgjlNgV94jH6PEGa0Q/+cPlX3Mjbc74
	 CIttfyDjaceJgW7GPjWVPGMfIDoOvCAO6qn6y7c/3mrf4d6G9Y37RatlMkIYzW9wt76IY
	 r9oeh+obo/sFM22U4eY5hZLtl2zuGSIwwXmr2E/VzavbVAV4JvO9DbwZCnP0aVAv73mse
	 qZ/6uL7C5T4w0GZ6O4OSLST6FZnHObmcpOTXYNsYVgD14HFyQCF8iozRJHNn2l7zx7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FkJpmUMP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8FF606A32D
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 21:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FkJpmUMP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045B41F000C4;
	Fri, 13 Nov 2026 21:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794603719;
	bh=OdFb2CISyTt2bJfUX0cO/FELNTV+1/KNJ103zgslpw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FkJpmUMPXARDp9wAreXM11tH3dMVsN79BICk8NJUn6v1ZixokXgIRVubnhMGrOcJo
	 ut2KRon0NRQIbGCRw9v7Gep1ie7+kcaYXpETpEoXMhCiYbSHw8iPYADFCJOoyqS7vh
	 73UPqntwutCXHo6JjGs4GslEel7Qqhyz6wLfoAl3RqqHvIYjvXbIOlnlQSuwOpnb+w
	 QkW8z/Ln9egSyU4VNwgVdRmgDknQ0DiNZ63LHF5wI7lWi7s0Ffl1DROlBKmoIplvKL
	 whegUay+vqMJsQPzofVfW5MwdjJHC5+3rUA7Hb8FzpWPL6stYlsojwlUcYj0dqKD62
	 W+jiE6XBbkyLg==
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
Subject: [PATCH 6.1.y] mm/madvise: preserve VMA_SOFTDIRTY_BIT when changing anonymous names
Date: Fri, 13 Nov 2026 16:01:56 -0500
Message-ID: <20261113205809.2527579-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201658-failed-6.1-652f15be3c11@kernel.org>
References: <20261109201658-failed-6.1-652f15be3c11@kernel.org>
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
[ sashal: inferred name-only operations from new_flags == vma->vm_flags before merging instead of using an explicit name-change indicator ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/madvise.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index 77dfca84d27ae..15d0e10ea400f 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -143,6 +143,7 @@ static int madvise_update_vma(struct vm_area_struct *vma,
 			      struct anon_vma_name *anon_name)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	bool set_new_anon_name = new_flags == vma->vm_flags;
 	int error;
 	pgoff_t pgoff;
 
@@ -179,6 +180,9 @@ static int madvise_update_vma(struct vm_area_struct *vma,
 	}
 
 success:
+	if (set_new_anon_name)
+		return replace_anon_vma_name(vma, anon_name);
+
 	/*
 	 * vm_flags is protected by the mmap_lock held in write mode.
 	 */
-- 
2.53.0

