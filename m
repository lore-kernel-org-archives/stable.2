Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792768661;
	b=1hUK2+fIIurX9QSRHIspP9KCbnnv6e7Zs7LRNtP+li8RdoHI54kzaKAaa2/qNtHt6Bi7
	 Z+JTzV81siEAORUFf5MTvZ7BG+Tuc85q2rrps0nT7GCh7QF4Rv5yFJfGjxZ2rKLJVhfQw
	 nWpucyOulaAnvV4E6iX4Em8l+Gxhj1XbJZvZSxaZl7MtqVhVa5CaznJm1UUAmUp1mrJHy
	 +PY6BbRzg4CsPppgN5ZMfQP4FXBkPoPIEVSFQHqAWH8imH0tVMiPYA3z0/nwO5Fuuoh3M
	 Ns1XQLq/x3TEeBR+TcVz/82OATzcgb7BmDEKAqjxV/pbzjGnEvbpPUgSSlBnFvIsgTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792768661;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=9oPHb6UkUAuCeIoTZhGqRaYjHQ33ICgDmbmBczj7A+U=;
	b=GpOAwcSYPollOmEP9ekGU6A4gQtGC85CI2Z9/mO0gfjHxaRHxnBkmwKJbfPE2n2IQR2F
	 /Vgpf6YQtsTPy/wxL19R7xM1/txlM4bGFKc2xf8wagwxHvZqiLhwS/d9CaC+jJgkWQs6m
	 qZmHGUg0sBUnKQxrxbi/wbZwmlAxW5llO0ZUF4XcX+HzHiGGwSXUXdPWn1uEa/x43MSda
	 QT+g2JHwd59xbshgzcnT15mNQZSw7Ps4RCz5o2w4pXY6/J/JNmdZOVAzj5Yatu6WnQc+T
	 hXV0ibF8aChOgBkZ7tZAVMgkSSh3lByBpO2p+gOfnpSgWQQxHIhhHdWzb532WGIWqgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TSVb0oU/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81251606A31D;
	Fri, 23 Oct 2026 15:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TSVb0oU/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21221F01825;
	Fri, 23 Oct 2026 15:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792768661;
	bh=9oPHb6UkUAuCeIoTZhGqRaYjHQ33ICgDmbmBczj7A+U=;
	h=From:Date:Subject:To:Cc;
	b=TSVb0oU/0DYQRlWKzFZ1+M5bfA2fsQELDWZJ7ouo4RY+HG3qghgtFgLKhqqlv0q+w
	 jB4rnZVo6YJeBeCxsIDdByS+TqolKBBNMCYKJL+Wg9QpzxNmlkADIdv1OM9cMW1tHj
	 NEkDqxR6G+9DmGSlP6t3axYabc4WyRwFsDEZXaWFkrzSIKa6lA7iKMGvdEcrki9PUz
	 udtcCGV5Bh/Nxzv922razMhC95ZeyqgJwYiGq/txLyPgiMRNd5cUcwquHojkdaeNnP
	 i5CDcxvz+pf1v5NsqSIw++7RgdM3orkRbpc8nrbLZAYqA1uUMQCYkKZe0sp0P26yLa
	 qdbdTKswvKnFQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Fri, 23 Oct 2026 16:17:31 +0100
Subject: [PATCH] mm/vma: fix expansion of VMA_MIXEDMAP_BIT VMAs
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
Message-Id: <20261023-vma-expansion-fix-v1-1-6142baf1f46b@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAyNj3bLcRN3UioLEPJBK3bTMCl0zCxNjY0tDQ3PzZBMloL6ColSgMNj
 M6NjaWgBsDj5AYwAAAA==
X-Change-ID: 20261023-vma-expansion-fix-6843391177c4
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
 =?utf-8?q?Jakub_Mat=C4=9Bna?= <matenajakub@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, ljs@kernel.org, 
 Luiz Capitulino <luizcap@redhat.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3534; i=ljs@kernel.org;
 h=from:subject:message-id; bh=5ZqmiLxzSYfJofiKd8XjWTm3Ne0Gvwb77tpCkLEm588=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJuV/XP8VY5dce4c5ahhBbniy2r97RPebTxewuXi01+y
 XmBsoZ9HaUsDGJcDLJiiizPv4jvDxIJm9d5wd8NZg4rE8gQBi5OAZiIcxvDP32LqMqwvT8m+k7g
 Dk74+9X2QX6V2JT8hYe0b0Vy87/Tq2H4K+bKsElzzaLlmUa9rDbGspysSwJWbpPzitY1MhWdp1L
 CBAA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Commit ca3d76b0aa80 ("mm: add merging after mremap resize") combined
merging with expansion of mremap()'d VMAs, however it also unintentionally
disallowed the expansion of unmergeable VMAs.

Previously it was possible to expand a mixed mapping which mremap() had
already ensured was a legal expansion.

This is clearly seen in the mremap() logic, as it checks
vma_is_fixed_mapping() to determine legality of an expansion rather than
vma_can_merge().

Additionally, copy_vma() allows for a failed merge to result in a new VMA
being instantiated if MREMAP_MAYMOVE is specified.

However, this is not attempted, as a failure in vma_merge_extend() is
assumed to be an -ENOMEM failure.

Since vma_merge_extend() is used exclusively by mremap() to perform a merge
and/or expansion, resolve the issue by invoking vma_expand() for
unmergeable VMAs there.

Explicitly assert that the VMA is both non-fixed and a mixed mapping.
This provides double insurance against broken changes in future.

Note that khugepaged_enter_vma() (which vma_merge_new_range() runs) is
redundant in this case, as a mixed mapping is not subject to khugepaged.

Also update the VMA userland tests to add a required predicate.

Reported-by: Luiz Capitulino <luizcap@redhat.com>
Closes: https://lore.kernel.org/all/20261023023106.515365-1-luizcap@redhat.com/
Fixes: ca3d76b0aa80 ("mm: add merging after mremap resize")
Cc: stable@vger.kernel.org
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
Confirmed that this fixes the repro and passes mm selftests and the VMA
userland tests.
---
 mm/vma.c                        | 19 ++++++++++++++++---
 tools/testing/vma/include/dup.h |  5 +++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 1be613044b4a..88ef92ab24ec 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1851,12 +1851,25 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
 					struct vm_area_struct *vma,
 					unsigned long delta)
 {
-	VMG_VMA_STATE(vmg, vmi, vma, vma, vma->vm_end, vma->vm_end + delta);
+	const unsigned long start =
+		vma_can_merge(vma) ? vma->vm_end : vma->vm_start;
+	VMG_VMA_STATE(vmg, vmi, vma, vma, start, vma->vm_end + delta);
 
-	vmg.next = vma_iter_next_rewind(vmi, NULL);
 	vmg.middle = NULL; /* We use the VMA to populate VMG fields only. */
 
-	return vma_merge_new_range(&vmg);
+	if (vma_can_merge(vma)) {
+		vmg.next = vma_iter_next_rewind(vmi, NULL);
+		return vma_merge_new_range(&vmg);
+	}
+
+	/* Mixed mappings are permitted to be expanded, not merged. */
+	VM_WARN_ON_ONCE(vma_is_fixed_mapping(vma));
+	VM_WARN_ON_ONCE(!vma_test(vma, VMA_MIXEDMAP_BIT));
+	vma_prev(vmi); /* Reposition to start of VMA. */
+	vmg.target = vma;
+	if (vma_expand(&vmg))
+		return NULL;
+	return vma;
 }
 
 void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb)
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index f449129ea97a..e0eab4eca998 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -1727,3 +1727,8 @@ static inline bool vma_flags_can_merge(const vma_flags_t *flags)
 	 */
 	return !vma_flags_is_hugetlb(flags);
 }
+
+static inline bool vma_can_merge(const struct vm_area_struct *vma)
+{
+	return vma_flags_can_merge(&vma->flags);
+}

---
base-commit: 2bba28e98578de622ef307d00875aa8f8bca3d10
change-id: 20261023-vma-expansion-fix-6843391177c4

Cheers,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

