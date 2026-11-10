Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272948;
	b=Rhsi8XdPhpe0sFsKfpKZ/gDW/bjbBO71CkWunexGMQeZqW/REf1JX/h+0/Nh2zhA5sUh
	 Nxv4Vy1IpH5GiWgwly6SBZbAe+8y+GrZeoLMLyQHvcQJxX+yZAySWD4ToHG+oga86/fBd
	 H8xsaUdUBUhoyXzoTM2/14LjnclquROqtv0GBiR5qcwYrR3ll3oe5yjT+vJxaDjFWCFWj
	 Xw/W8bc1B4C4dOUIAvsoJ1JpvsS/VLPfiukhlo+mlZuvzUreCiApLYLoHgSJn8SyIwzYC
	 9QDjHZv6HQKs3RrC2t17q8Md2Ia4JrXrOSyeoU+Nn2AmfQ9tE9Pu4ROIrW4b8zBtMRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272948;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1ZgP++7U1D5uNGrNu7HGK8sr20q9QV+NwvivNmfU2cE=;
	b=R4OFjZWnM920w22utEtGMk3oqESTLllJLPUvBRQnqwR2ax3fSK3xueBjdUUh/MuhIQO2
	 SK2NZrKVTc+MzugtTX5IvO1ItjJHoUBnpcHfiuIfrwmkhuh52fVIQeKH6f27/6v5/1GLL
	 3JhQ7qcx4em+kQjJbkswUlKUVNZuj1FKtqkd1tlplG8ao1SMbA53cB12ugLCQ9sg7GliZ
	 keb9aomGukltaHzUpEG7IZjP6aSglRJ9/lGsy0dNBAcoIgDhCHvkvI4/HrU2zhgJm6R1L
	 rviaTyj0y/wWJ0arvEfZVHBfcKu5MxDSe6dV3sO8aR94Qv363kbaLQ8wsdDMckKQtYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JW08M55d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1156606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JW08M55d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06971F0089F;
	Tue, 10 Nov 2026 01:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272947;
	bh=1ZgP++7U1D5uNGrNu7HGK8sr20q9QV+NwvivNmfU2cE=;
	h=From:To:Cc:Subject:Date;
	b=JW08M55dDxlpeQHg7OkWL5G617GbyvAPR/qY5zUK8l8lLqKkXy1ko0BrDlpm4SoQI
	 No6Y79dge9BgzTJtlJqVGOce2zWi7JRXRKAOqvIRrkK/iuIiFAmGFvpzQetsVyjX/J
	 r2UUZHOm11n9iSLzDjZ2dvzgjoJDc0tkIX2GA/sXLZbb65fl6C+FRVJ3h5xWYtkvrq
	 JHK1t1qtNBx8UFxqITwm7oN9fGmWMCuVdbopGSaDaS7I/D3kbNpOJARXqzjarLAP2v
	 mO3RdBuMHR/CtDBIEQXj23nEarjX8J81IzOtR/4pYht3hxkssDQmm9+0VkZa4wo200
	 sgW0e4DRw7p2g==
From: Sasha Levin <sashal@kernel.org>
To: david@kernel.org,
	josef@toxicpanda.com,
	rppt@kernel.org,
	ljs@kernel.org,
	surenb@google.com,
	usama.anjum@arm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/userfaultfd: write-lock the VMA before waking waiters when unregistering" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:09:05 -0500
Message-ID: <20261109200905-failed-6.12-35f7ecd55ce7@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 35f7ecd55ce7e51cb6d5ef49e6dd51f3c80f61e4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200905-failed-6.12-35f7ecd55ce7@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




