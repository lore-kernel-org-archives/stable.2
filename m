Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272702;
	b=oMWcjsmu+hIJQJf5Mbvx6BZOgPWohrCxU+ZF9i/OfTQs+Hfhj2pCKX0YWNr5bprtFS13
	 kZqqt1z0rihgVSgQ8t82CDsIxRzK3drEqwJ7uL1zqZj1f4tXapzTF4N5iEbeQHpkcT2rS
	 L2pWiev0HJ/pHbPYbgBrK/tjsMX8EwLkuikO+B7PXo3QylGCsFM2UXNd6tKyQJ7OcEoLM
	 Y35x2cqC4Uzxz9AdstTJTaRpc8scZ//OnnWJzousqKujkCwk+Gw+4tzoiTrzpcsYu9Efq
	 354ay7rwKFo4lnWdRRMsyV7bwnpanN1kwbdLgVVHxUzzalIdN5gt0xfT2UmgsNdJejQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272702;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=zvkiQ63aMW/ySylvoN/JocbmSuuZYXxoG0ehqQixAvA=;
	b=0NbKXMPy0zNSyC14G6XY2IjupzosvlElEiVJwSeyKH4MqnwsJnV0MP22b7058GPxZaDX
	 AGAtRNXwJQieeCH5SotH/OZml28wNF+CYfboscvEu5lx4V3u8g7QdimUBpWLqGpkc4sFQ
	 R0JfT+XhqJc8v42zmSK1vYq7cDxh9VA757iy02dTs1GwcD1mwxQvp3QyzUOKGN4g3J0Ih
	 YYBK1E6rcsyihQm8O7yUS5+I5VwNO2hooqN3y8NlkfgLipZ0J83u/tDHv+Z0o5QsA6DaQ
	 c4Tb1h+Z8zFGLpcaSiQROQR3rFzAiqFa6F/SK0pAVh58Q/l2W6Nxkm4NTnoF3ur21Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fFwyT8OD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF45606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fFwyT8OD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D64C1F0089F;
	Tue, 10 Nov 2026 01:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272702;
	bh=zvkiQ63aMW/ySylvoN/JocbmSuuZYXxoG0ehqQixAvA=;
	h=From:To:Cc:Subject:Date;
	b=fFwyT8OD6otg+0vV5j6zVRx/2D8y1WSIk6FXysH01EmUWiYtiKE824N2vpQ2geOlM
	 /u5hvvOGanXS7WzM7zOp4C2TBTyo+E1JcSaXaWQufcORrvWFGoUy8QFgjwfSRlOIwf
	 u7Zlkl08XU9UW5iUywFc/BQdvNI96VY0h7kYlRYZzcBRFPNCOmjF1G1wGltZa/X4pW
	 wFEND5r88Ufk4pB3jCwNPRM/et4IPZNmFvA7NOfM2qjOX1ISaBCPoEkOpguCOdMQd2
	 TYKxNJMy93pGhTC7FfUOR0wYv/m4Pb1/2yhAE1lGf9oKlPCEiOhjAw1wDykf9VPzRP
	 U+4i5kagjAsFA==
From: Sasha Levin <sashal@kernel.org>
To: david@kernel.org,
	josef@toxicpanda.com,
	rppt@kernel.org,
	ljs@kernel.org,
	surenb@google.com,
	usama.anjum@arm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/userfaultfd: write-lock the VMA before waking waiters when unregistering" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:05:00 -0500
Message-ID: <20261109200500-failed-6.18-35f7ecd55ce7@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 35f7ecd55ce7e51cb6d5ef49e6dd51f3c80f61e4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200500-failed-6.18-35f7ecd55ce7@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 35f7ecd55ce7e51cb6d5ef49e6dd51f3c80f61e4 Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:39:52 +0100
Subject: [PATCH] mm/userfaultfd: write-lock the VMA before waking waiters when
 unregistering

userfaultfd_unregister() wakes pending missing faults before clearing the
VMA's userfaultfd registration. With per-VMA fault locking, holding
mmap_lock for write does not prevent another fault from queuing after
the wakeup but before userfaultfd_clear_vma() write-locks the VMA. That
waiter can then remain asleep indefinitely.

Call vma_start_write() before waking waiters. Existing fault handlers
queue themselves before dropping the VMA read lock, and new readers are
excluded until mmap_write_unlock().

Fixes: 29a22b9e08d7 ("mm: handle userfaults under VMA lock")
Cc: stable@vger.kernel.org
Reported-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-23-d6437171ecc3@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/userfaultfd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 928ad95eeb2ba..3ca04b582329f 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -3991,6 +3991,9 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 			start = vma->vm_start;
 		vma_end = min(end, vma->vm_end);
 
+		/* Prevent new userfaults from being queued after the wakeup. */
+		vma_start_write(vma);
+
 		if (userfaultfd_missing(vma)) {
 			/*
 			 * Wake any concurrent pending userfault while
-- 
2.53.0




