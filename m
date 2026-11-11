Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416958;
	b=IkKuhi4shAXsjVkGXA8WBcFraNOVEbPvAkYvRFV6KgA9A7xVz6Y8wQ+Mer3hGm7yUmRq
	 a6DBFIlmtqI6AKktDlDIxPwNuiQPlE2hTC5cQ9k8E0ffY4gY3QSfV4Dt0TEnpWVxiQ21C
	 kTXmmpg9dvM+3u7O8+04kV5zqenXDygN1INJbwr6TaGyU0Rt2b+872hIW0OFBUiUyNZx5
	 7/pWJby//fqlA70c7bpf4tYfsVmVFli2SZvdFBQIDkOLP4GBhFgEw627KcgFaMq+kIRBd
	 YdFHCF2lBCA2Oy3FemWIQ0q8CZZ9cYTtJzyYawgWmA0MCqTN6YLZe2Xn+cWSq27zpjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416958;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=urDA6C1JjTDAH2WHQRgpAUYLXru2Vn1kByj4L4mX4Rs=;
	b=Ho6aUt4v7lKl/OKkJZTL4UqtVzBLydyDm52FOUAT1mN21gXflRbWTMsNdcr9lK6EPBlg
	 eR9bpOZ88ARENcVnXpT6GfPVuuIdaOXXEIdnXfbG50YnW9kfFC9y7IxuUqF4cgK+7Mgis
	 rbtnw36Yv467OOpYpm/0sVMS2Lw1Ac87Og4cFwJ03FTyYuvVWMHJQ5m+LMC5eO4l6wpKZ
	 /FbI0AbDJ2Xpii9q5yRlTUYqqgoUnUz6jwujmIBe4sypUJucLsxF2W0TJeWpWBlBBf2YD
	 lqPst/jSgBgAY13okcIrg9Ud7ZcXtqJxkxhTREq14KB35sQNQEgTBnmo58cZrGBP9kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C4lHOxgH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F0B606A32A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C4lHOxgH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6989B1F00A0B;
	Wed, 11 Nov 2026 17:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794416958;
	bh=urDA6C1JjTDAH2WHQRgpAUYLXru2Vn1kByj4L4mX4Rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C4lHOxgH475ehW0g8TsXwdSD2n0p5NDjWA+THO82OYJu1rLXbt38XduTuzLLRtq35
	 wOtEkDgCkK89bJgkWV84J1ZN39uvJiSj3dAY9km0blS4Wc2Jzo4k7JC5T4Yq6cCtTu
	 QpLFZ4iGhAWJ4fyKuSImckQnK19vEn7c+yhafWBTTsV2/NHzRN6SoGYCh5XSHdPr3/
	 ZMFy2VA+Yf3/aVfw7qSwDBIwY1k1/c+Q9c5mo/GJ8Vf10P7t1oLUjx8uuFln9F6xRr
	 eBDq6PM9dWd4ksJ9wEJjoeKdyD6ASPNUHVkk5Nbkh4s2saRECBHddKEMe58pUzqT5C
	 6Y5d/687tNLWw==
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
Subject: [PATCH 6.6.y] mm/mremap: correctly uncharge accountable VMAs in error path
Date: Wed, 11 Nov 2026 12:09:16 -0500
Message-ID: <20261111170857.3427359-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053909-failed-6.6-65e722a74df9@kernel.org>
References: <20261107053909-failed-6.6-65e722a74df9@kernel.org>
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
[ sashal: Replaced vrm_uncharge() with a VM_ACCOUNT-guarded vm_unacct_memory(to_account >> PAGE_SHIFT) call in move_vma(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mremap.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/mremap.c b/mm/mremap.c
index 0739a31b54eed..26d3cb46f6ec1 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -715,6 +715,19 @@ static unsigned long move_vma(struct vm_area_struct *vma,
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

