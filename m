Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416381;
	b=XHdQJHRQZL20mMvRP/CRTQKvRWVekGXthO4ydw91Cd2/JoZHeLvxveb6hsKliOikM+UK
	 nXCLXVpKtbOw0d6Cc7dyEXZ88lTRLYZ04FzM9wjJ8986BYQ0v4AMqTmB7XSIJjFINCJdx
	 ozCbqAbbfQWi6hTrgJ2M7WfvRAmoAjCF5oikg5Y4GTM4a+ero6ZPtzpV/M32lEuG2JcCg
	 vgoqlnO/UuYT446A5hkFp5Zo+8UVX1bxQ59NaHPLspyUEOEHTGaQM6bqqtip9JpiacCRh
	 0/obNpkGxV5gVknEXrepevOsoKBRUuluwqhWsluK06fyLIfQRQ4zp/6iT+lYs0WSXag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416381;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HnnXLSSCb6z6j8p68eS8cPvW4ibeNufMDoNY6CBv7+A=;
	b=WAho/a5mHx7oFXAuZ03DHyV/Rj3LSDgEtPHRmpXEpIPNW+zV8yJ/5MK7zwZVT+5Qn0Tb
	 gdNLvHaBfzV8Sq+egpurKBY1qsQdeirtw9l+8K6ZA5hZpFq7z1yQE/CKU8WA2wSPYocJo
	 XMvT5WJYf6t0eDymcWs6ijbgb8O/IB4a5BML+NzyCVKAV4GIfjZ8bvSup98YOFVKl8H34
	 M9stgCrp9iecyRqq03z76LOrojYWgXuy3dBMXj02pQqeSJfK0I2paIZZjJtOuDlnAWh8x
	 CqqDdBSymTx+GrRnBFTf69azLEusf1mrVgneSHFdtIMfLfzz15sxDR2fKaXR6UQq5ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n4rFAF2z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A378606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n4rFAF2z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80D81F00A05;
	Wed, 11 Nov 2026 16:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794416380;
	bh=HnnXLSSCb6z6j8p68eS8cPvW4ibeNufMDoNY6CBv7+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n4rFAF2zB7T0lmlQWwhZdyOS4SsNEGk5PoUwSO7UflcvPK57K5iYUZM0kkyOqkOMX
	 9MsF/Twih0pDZq4lBTCog49XhO+2rqioqDSiStcsXnClaMiGKyNBk78K0daB8ZCKr6
	 EUqP9DJ+JI9F3GsxQGu6qjcxmRHnuBArXkqKwwoSn45azwhoQe/Z29ecT3SzPyS2cI
	 bnNpqi+ihImngzadlaSW2v0RfOMH4KpxDKONGJId242GP5cIbk6TlAwaq0d504uOaD
	 RSZZdT0p1uaEHh80CY30YhmbOvRZTqZ/2tZ5IrmhMWFc7PyVtOXXzpD0ylkUFjTddw
	 QJzetVXD4ZkVw==
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
Subject: [PATCH 6.12.y] mm/mremap: correctly uncharge accountable VMAs in error path
Date: Wed, 11 Nov 2026 11:59:38 -0500
Message-ID: <20261111165921.3384488-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052619-failed-6.12-65e722a74df9@kernel.org>
References: <20261107052619-failed-6.12-65e722a74df9@kernel.org>
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
[ sashal: replaced vrm_uncharge() with a VM_ACCOUNT-guarded vm_unacct_memory(to_account >> PAGE_SHIFT) call in move_vma() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mremap.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/mm/mremap.c b/mm/mremap.c
index 8b507e228a274..d4666f1ab5939 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -782,6 +782,21 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		 */
 		move_page_tables(new_vma, new_addr, vma, old_addr, moved_len,
 				 true, false);
+
+		/*
+		 * When the error path completes, the new VMA will be
+		 * unmapped rather than the old one.
+		 *
+		 * When an accountable move is being performed, this unmapping
+		 * will not uncharge any expansion, so do that now.
+		 *
+		 * A move is accountable if the VMA is accountable and
+		 * MREMAP_DONTUNMAP is not specified, so only do so if the
+		 * latter is true.
+		 */
+		if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP))
+			vm_unacct_memory(to_account >> PAGE_SHIFT);
+
 		vma = new_vma;
 		old_len = new_len;
 		old_addr = new_addr;
-- 
2.53.0

