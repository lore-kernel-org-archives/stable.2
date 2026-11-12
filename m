Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501483;
	b=Wqo9DcsFmseQD3D8rY5x4nuo/xvYLc5CW7aXf4a0FIRqnekSC67sR/AmPeT0E6aGS7Fq
	 ZF7ZLl5U/fAcfhSWjM9HYhPQrJ7hGFZrd4znXzO5MdfajMS9O4EZutFRdCfCrrBR80mhT
	 dPR28S9l6vavgBI7+xz46FgfOU6gkZbEeVF7z9g7Qk+dVN/xJEPI3iyxSE+Pl07UktNak
	 TA7xjrSzyyMDP2s6Oee8I7nYWhfsIcdEv0LLmxi1V3N8QmGa1DrU+uMz0FngiS5jOousK
	 Zf5SCETK5wqPdSVsA7YWqR2LLBaT+PvWoXPow64DFlG3fl7UVKY/eg7B6ZI6SkErzbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501483;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=P2GAXQL+CRALZ6ktolsI+wkJgETtKYVg5/S1WwdnjP8=;
	b=YW2E+VaWj/CEwa8AOBaNmUNlbTVmSmcIt9IPnRAIOklPFfZF3Zow1IKgmo6mw4srPBtw
	 kDl9Cy3IyB9Yph/l3DL5fuQAcKNRvE5zvZvsuorUsXWVV5lJ0LV2CrM/qG2hALrGth876
	 XoPvzjYLrZzU3KE+n+iwtjnyf3jkfM5BmQIfalB0ofhTCphoDvxHAkg4fI6d0IKnYhkMI
	 P/438XeD4FhTkoJ4XpD3YM82qSr6WKI5ez7BVzV12u5jTGtgoJWznnoupfrdDI8iZi0ep
	 B+UKKxZO3/DPfUBnmv6h0TASkaJaqYpx4RP6wraq6FTuEXgMsENk9XULnOUr1nSBwSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lCDGyKKY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66C6606A8BB;
	Thu, 12 Nov 2026 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lCDGyKKY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460611F000C6;
	Thu, 12 Nov 2026 16:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794501482;
	bh=P2GAXQL+CRALZ6ktolsI+wkJgETtKYVg5/S1WwdnjP8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lCDGyKKYBC8Fs6CZs83hFW2kfQvIWzrbx55R2xhY23bPVejs4jP03UhTMbPYwkdFq
	 6QnSYzu3WeVqWx+Ar0edjh2cqOYYgzZqe/DZ5+wO5as7ByI7SvXh6bulOXMCzm12Eu
	 kASOJRtSewIDlEzyPzzCY1AdAWX/EVv1Af43bEp/TzGRyu8tlqudESjSsVdhjFBpbc
	 gPakCksrVRPklHGcZFFoijOXgWwbOd12WzoiKbEcn8WBWaclGOUWPLB0E7xNqJ2ACq
	 pLxZ0JI0ySEeRWv9k3TGyTyi5fx1EhNiDCo/FW3wSZW06JeHOMYn6a8E5q27+Wxlkv
	 sJ5MuJnwBIRmA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 12 Nov 2026 17:37:08 +0100
Subject: [PATCH RFC 2/4] sh/crash_dump: check ioremap() in
 copy_oldmem_page()
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
Message-Id: <20261112-work-procfs-oldmem-v1-2-ecdcafd99265@kernel.org>
References: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>
In-Reply-To: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Breno Leitao <leitao@debian.org>, Chris Mason <mason@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, x86@kernel.org, 
 kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Hildenbrand <david@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1003; i=brauner@kernel.org;
 h=from:subject:message-id; bh=q6FpWygcFHpF/XYp2OeRsrvJ/y8aBzOdxnvKzJI5CUg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR9fR2ZXPfx+k0nz9UdCcufZi5bEfNP4/gkpZxGBe7ty
 U5mqhMMO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbCX8DIsO3Srhdppo67Nmsn
 CMzvSEg8stFmw5lYXa2tcWbPH7+Ou8Pwv/BN4KTdgsEMAr8vHor9ftTa73Deda0PH0/LeesVzJZ
 gZQIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

copy_oldmem_page() maps a page of the old kernel with ioremap() and
copies from it without checking whether the mapping worked. If it
didn't, the copy reads from an offset into the NULL page.

Return -ENOMEM like the other architectures do. read_from_oldmem() turns
that into -EFAULT like any other short copy.

Fixes: 4d5ade5b29c6 ("sh: kdump support.")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/sh/kernel/crash_dump.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/sh/kernel/crash_dump.c b/arch/sh/kernel/crash_dump.c
index 19ce6a950aaca..85c0e58f1a59f 100644
--- a/arch/sh/kernel/crash_dump.c
+++ b/arch/sh/kernel/crash_dump.c
@@ -20,6 +20,9 @@ ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
 		return 0;
 
 	vaddr = ioremap(pfn << PAGE_SHIFT, PAGE_SIZE);
+	if (!vaddr)
+		return -ENOMEM;
+
 	csize = copy_to_iter(vaddr + offset, csize, iter);
 	iounmap(vaddr);
 

-- 
2.53.0

