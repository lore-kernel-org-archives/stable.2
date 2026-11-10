Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273212;
	b=3VTC4TJdGWItPf4hUPX0KR+uo0CsMNuijhonkDCKhPNEDeABA0kUM+lDlRdzU8wDmkXR
	 HcJLoxZGOp2z4X5v5EmRpvJu0QioXNpYFjFTmv4ZwaFUwXgns/ZWXlU4nuyPJyyP+q9wn
	 jjUDHdlEkLZEckH2xptMU10j91ZvjJjKVD70fOaFHyISQCXW5y4Qr+h1G9yvso53BipHu
	 BgrSAEKuTNy9/EscVtEvJ5DJxvx6wUjWOLOVGCPrh6tLTwlD2ORlFLiRSpNwN8mh6ho7m
	 Lj218/LKaoHzEm0FDhG5xk0KMZ0/BiWZKfSh9/X5yncOE4GFBHrQMd9yR9zIssdL2YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273212;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9nU557c0kDDCXR1md+W2gXlS+vjp4yxM4KBf2jRbexk=;
	b=dT2y1JSnX+YFQ9bdfPd3wro37xW+PS3m4ZwJGfZYlsH79Qj0PSUn6tWF+tN99B/nSPYS
	 QX4345V1vL9fr/3x3VfHQBuQZDDBD27QxUlPM8yxmIDo9d0XJ2T8x9RnQM9efDsayFJ8I
	 wujhih2Kod/Mx2Sx1Q5EJRiqFq3fEmRLuIrm8SSUEEbel4ZhwUaBxLg/c6nX4c08j+aZc
	 o0xSw3kVTfeFmeukBEtWcQ43rKpZhIFu14oSFFcrWfeF4uCVHxHcvT0k3MV2Iy6ow2Fv2
	 p665B3WJ2ETzDkBc237SZPgDEeBuDBdm0MErbEdF4M58PlA9Qg+EOv/z6IxZtJEZOMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cgGWXoaS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AC4606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cgGWXoaS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86ED71F0089F;
	Tue, 10 Nov 2026 01:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273211;
	bh=9nU557c0kDDCXR1md+W2gXlS+vjp4yxM4KBf2jRbexk=;
	h=From:To:Cc:Subject:Date;
	b=cgGWXoaSiZTED8vOzN+fhuJiEmWRsH/uM5nSG7p1Jd/KxELVqPBNLFXvPJae5CsYF
	 Q1HIGaXuHaVJ9Wuq8m7zddORSuJFvyd8l425zyrMRapPGSYDzUe+A3yEJF8oOPS1Qm
	 WBmrbrmY9Hc3dQjRFfNhFRlz9Abj93R2bxBV9mS9dxHx2y3LZzR+hBtMQjdr/GAhwH
	 vCY5CN6hKwss7ieneQKeNaAT2jAvljzYRD23iHOTa2ZQgj4VoP9qCs8uSrmoW5CysW
	 aMZACdmVTSPa1jGUZjNmX1foKv9PanGdtDM0Zu3plis1Pm6f425xa7gmXVwQmsTGeA
	 p4WkPJN4BXlSw==
From: Sasha Levin <sashal@kernel.org>
To: david@kernel.org,
	josef@toxicpanda.com,
	rppt@kernel.org,
	ljs@kernel.org,
	surenb@google.com,
	usama.anjum@arm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/userfaultfd: write-lock the VMA before waking waiters when unregistering" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:13:29 -0500
Message-ID: <20261109201329-failed-6.6-35f7ecd55ce7@kernel.org>
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
git cherry-pick -x 35f7ecd55ce7e51cb6d5ef49e6dd51f3c80f61e4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201329-failed-6.6-35f7ecd55ce7@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




