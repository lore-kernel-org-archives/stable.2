Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794444644;
	b=oaGyGOA1UqHeWEgajMxC2nzvLNKSwTU93XHZFVt8fR2JzH78AnPDC/uqX+JB4OHRbqgp
	 2y2YMyzHI8LRW6MWk9nSyyssjpUYmagYtvkZZ28norJ7lcrVFWAVMhSb7MNRYG69ZHYdZ
	 dsmMGnSvOz7FpdSzcIPRc4EpVMlVblHGZYCrUk0vr5uNWwkzVs7/+4LphcWVPDQSM+0zv
	 E7hSb9umAzjc4N+tsHSnYSCiT6QXHA9UO79odPyozAkGJj2vbVlMwwwL0B3GQvO8iuchI
	 /tdex08fMVmxFLDZd7KGiFIl+tLC9peil5+p7zaLNNAEzZLQ9DCrXkG9fFFv1i1m/vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794444644;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CKCgvKC1EVo3K5cTJfvbp6FtPhrlED0a4M7wVowEPAM=;
	b=xkAX7Kgzn0Kz7RNxT3lThjXpJhZBktLKpLV7YOZ0wBi03Hy9ELTaojqPkVFE+KpNyUip
	 7PtaQvXJ1Tn78JQnRkU0kZW4wFB9j6Vp+UvjJYFQPsrCSOUNEHaU3/TlaT1ZWfWPRECT0
	 1JA17OJ4FzFQcs7mE2Lt2m/cspmGGxtsS42zQNOdjao5XFtUWU5i14Quh69vaLj1WWUIO
	 m2Pm18t09uFjz5cWpjkNBStgxkBFqMmJdnaF/3xbH7gIuM07fWXGdFnLjxdmy2NORrNZx
	 P5BTdnMXbk8V4rBsmgTXQJtFphJgdaRiKom/KqIAnV1TXJUQ9wGwHH4dQOObapSwy9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q9fGA8Uc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392BD606A326
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 00:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q9fGA8Uc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560D51F00A05;
	Thu, 12 Nov 2026 00:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794444644;
	bh=CKCgvKC1EVo3K5cTJfvbp6FtPhrlED0a4M7wVowEPAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q9fGA8UcNSjcJX0WfeEV+QRooFnIBzOdU8xbOXsI4psiTcql69GmQwIn28+dsCP6c
	 VY39+J6s2G7NlM3jPplq07shs9gTgmDF4H2NRB9D/P35LzEknezqMcS1ZFxCgNSq3X
	 3PEviQZ5cddGFjI8DJ9Swu0fn/xBqtPbluWanjX/2loIDsEtVY3v4L+3YTlxQzO01c
	 N4zyXWouyUFEkqDs//nY0r1N2ZmXr1Brah+89sPpPufBTnGtMKVs3hLmp3S4f3YD6y
	 aGlSD+q+7sL06OWnc7TjdaLBPiujKMATu6GusvMZPi32JoWAm3DDZzsFfTipWf82mK
	 7BecXeT1BWQ5Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	"Gregory Price (Meta)" <gourry@gourry.net>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mm/userfaultfd: wake waiters when registration modes are removed
Date: Wed, 11 Nov 2026 19:50:42 -0500
Message-ID: <20261112005020.916583-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202806-failed-5.10-4eee9c389b07@kernel.org>
References: <20261109202806-failed-5.10-4eee9c389b07@kernel.org>
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

[ Upstream commit 4eee9c389b072e161549d46dcb1ae10b0222717e ]

UFFDIO_REGISTER can replace MISSING or MINOR tracking without waking
faults that are already queued. For example, switching an anonymous
range from MISSING to WP leaves a missing-fault waiter asleep until
userspace explicitly wakes it.

When a registration change removes a UFFD mode, wake waiters in the
affected interval after updating the VMA. The VMA is write-locked at
this point, so no new faults can queue under the old modes and woken
threads cannot retry until mmap_write_unlock(). Waiters for retained
modes in the same interval may also wake and refault.

The hang reproduces for MISSING-to-WP and MINOR-to-MISSING transitions,
with both read and unread fault events.

Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
Cc: stable@vger.kernel.org
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-25-d6437171ecc3@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
[ sashal: replaced unavailable __VM_UFFD_FLAGS with VM_UFFD_MISSING | VM_UFFD_WP ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/userfaultfd.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 6773227fbe889..21c32d941f4a9 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1394,6 +1394,9 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 
 	ret = 0;
 	do {
+		const bool any_mode_removed = vma->vm_flags &
+			(VM_UFFD_MISSING | VM_UFFD_WP) & ~vm_flags;
+
 		cond_resched();
 
 		BUG_ON(!vma_can_userfault(vma, vm_flags));
@@ -1442,6 +1445,16 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		vma->vm_flags = new_flags;
 		vma->vm_userfaultfd_ctx.ctx = ctx;
 
+		/* Retry faults for removed modes while the VMA is write-locked. */
+		if (any_mode_removed) {
+			struct userfaultfd_wake_range range = {
+				.start = start,
+				.len = vma_end - start,
+			};
+
+			wake_userfault(ctx, &range);
+		}
+
 	skip:
 		prev = vma;
 		start = vma->vm_end;
-- 
2.53.0

