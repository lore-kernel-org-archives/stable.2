Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417169;
	b=YaopmKbL9xdo0VFpAF0+yFgK8ueYyhrk1Rg/vn/UHEhHMwmkdOdkhBT4wZCLBEPWYuUF
	 dcas3kC7VLRbGYFQR2ZA7pAEqX3Bqy2jBW3SX6Ka2Ishbt1iEJeHFVsqWHXqrx5/KGqW5
	 pzwd4zPMc4x/3EWv6U7SqlQ3ghuhjKUzhUwli6kEZXl73P4kNpXYjOjXI6OrRZM1limFl
	 6Vz/SVDxrz1W09eiT9vGIJ3YVrs1MH/uP1C3Gt/bIWI0YVTai4nL7lKC7utHQNKmfLNe7
	 GI160iFxQbdyOAw4GUEr0UZywAd/8bagb6isVoN8/vw9d/EOA2kLyVfupFE9xbhhPUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417169;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LhVi4qvP9uaWjnIiRzhAKKFuuvigP6LT6uR9dPOGM5k=;
	b=Ps4vaaFu0q6mHYLnVHvF7/hVnnyLRMYxv8Y9/y5d6f0eUH4xJrN+9DEr5/7WaU3cTLDZ
	 QlojattS9VUxk1lY9PErTJlPS/l50/OyMeJmjcjiUOZBsatnncqDx/m8c0gbyaLenRGq8
	 THzPtm2jHkPXc1sULCgdBRtaYcYGpgoYO2Rz0YSrMM6ofr7CMp14ESBNUiVYLelj74pyi
	 nXOa2kQw4nfe3mle75vi73rcb+OPi+IexzwLo5jXl7Tl03zQHCVfviRbnytPuGkEL5mWc
	 s0PUtVH15BPfDgVpp5/oun89g7ZoiGibv4V7/rpwGrShjpPQatLV4jAOCUxFIMhCq6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wx2WXqhH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ED4606A333
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wx2WXqhH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6971F00A05;
	Wed, 11 Nov 2026 17:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417169;
	bh=LhVi4qvP9uaWjnIiRzhAKKFuuvigP6LT6uR9dPOGM5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wx2WXqhHYsGJMHhM0yAs6rR4f1mqF6UfpHFQKQuQQxaCzgLiL27gvbKRg6u0sgy6B
	 ZvEt2V+Sh85LYdgge4ZsX6DSyOnNzVG/aHjBCb8UuKTX9IWLaXLlh+v8DrxRACgsZm
	 ThOCNecn8V8kjOWdEUthVN3ZwxM///tUIo+8+VTSqhH4AgEtvcAOw+wTKa8BBoTEij
	 Ur7g7+It2QMhhxqz82Xm4vAQQWrPP8HUnBQYL7/j8sOY48kUvJ9teuqYHdtNKFkBMw
	 pHQkjS+EzICeF2MXDtgEvK6cZT0NPFUJnqociFVVsBWV+tO+hel9kjZwt3ghgATifM
	 xBmMuzfX59IVg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Brian Geffon <bgeffon@google.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm/mremap: correctly uncharge accountable VMAs in error path
Date: Wed, 11 Nov 2026 12:12:47 -0500
Message-ID: <20261111171217.3506051-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055443-failed-6.1-65e722a74df9@kernel.org>
References: <20261107055443-failed-6.1-65e722a74df9@kernel.org>
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

From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>

[ Upstream commit 65e722a74df992719676ead85a9e93fb2b5a0983 ]

The mremap error path is a fragile and unwieldy beast - it reverses the
page table move then updates vma_remap_struct state to swap VMA, length and
address between old and new VMAs in copy_vma_and_data().

If the mremap() operation didn't specify MREMAP_DONTUNMAP then its caller,
move_vma(), invokes unmap_source_vma(), which unmaps the new VMA rather
than the old one.

For accountable VMAs when MREMAP_DONTUNMAP is not specified,
unmap_source_vma() unsets VMA_ACCOUNT_BIT during this unmap in order that
only the delta of a VMA expansion is charged (performed by
vrm_calc_charge() earlier).

Therefore nothing uncharges the expanded VMA size, and there is a permanent
leak in global Committed_AS.

Resolve the issue by uncharging when MREMAP_DONTUNMAP is not specified.

Link: https://lore.kernel.org/20261019-other-mremap-charge-leak-v1-1-d94477fe6545@kernel.org
Fixes: fdbef6149135 ("mm/mremap: don't account pages in vma_to_resize()")
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Brian Geffon <bgeffon@google.com>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: <stable@vger.kernel.org>
[ sashal: adapted vrm_uncharge() to a direct vm_unacct_memory() call with an explicit VM_ACCOUNT check in move_vma() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mremap.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/mremap.c b/mm/mremap.c
index ec66e7be8afea..9a53eeb2191f5 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -692,6 +692,19 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		 */
 		move_page_tables(new_vma, new_addr, vma, old_addr, moved_len,
 				 true);
+
+		/*
+		 * The new VMA will be unmapped rather than the old one.
+		 *
+		 * When an accountable move is being performed, this unmapping
+		 * will not uncharge any expansion, so do that now.
+		 *
+		 * A move is accountable if the VMA is accountable and
+		 * MREMAP_DONTUNMAP is not specified.
+		 */
+		if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP))
+			vm_unacct_memory(to_account >> PAGE_SHIFT);
+
 		vma = new_vma;
 		old_len = new_len;
 		old_addr = new_addr;
-- 
2.53.0

