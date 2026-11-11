Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437777;
	b=o2PI+Oz1tNdNTT6ZzVCkXUw9SH1SNyFMrt3oAKbxeJV3Zc3TaB5z4ztthhyEmaQEdx/R
	 FQRY4pvHzmx0yO0redFuqGgvpZpIvO3qGQzseEN0ppXuH7IdzuNZolMWtwUAbNFlWAiIB
	 Z6VPaR/BQSK15FY/kgQx4fipymDQmpBO3Di+jiUq9p39ABQ/ue5rF3USuAFCPZw4GLmbO
	 jb4+ctPU5UrJBgmexIYuAqqAeVXII4A4S2aMNOrwlYat+0BFcB3B4j7x5RmfVxbe5aIXf
	 Q0jpo1xNFL2NMdUEil6SxZVcnYL33sSxx8eqRXIGPqjgzFoONlDzmgF+I4+u6fuaZSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437777;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FEL+eGoR5Bf91Q7O9GS2Ltk3dhvgcN9P/3+9Fd5tVy4=;
	b=M07tY4MKM8oq05LZGBAqkySH+ZiEoGawRl9eo4V7SxSzj5RYNPtUMa1dfQahA1KJvRPV
	 Xs9QJMWcvtcDRhWMzCxlBre3T1pSFSM2ebJvs0H8CVRBHS5/xGO34bCw+E6+Jl+1kBOXA
	 VpGRba/LleorNBm/N8PqmN03r7gAGhAcF+XxiVH17UaofGeH85f/xLQKocAcodmDbg5MC
	 jiLvvt6x3fIOgT/zAQkXfaFLD61t6/lJrOyr62MINOXyn7EaOFovhxJHU1QNLljgolBau
	 6wne/z9raADxxnWsvxgs1BC14XAyH16QlVI7hBt+h700lm9PHr4wehGKurFG1jQBAlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PMdryC7v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A71A606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PMdryC7v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10921F00A05;
	Wed, 11 Nov 2026 22:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794437776;
	bh=FEL+eGoR5Bf91Q7O9GS2Ltk3dhvgcN9P/3+9Fd5tVy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PMdryC7vHyWw2IBsx99mu/CGDiFSoq3Zl+4Cherc8XmAUmVXR3HkWSA03KV/d8BWz
	 Wg2qmkQiv9esrbmDNmHSkzokMU4Vy0lCc2cAgHYBft2ELjcSziPSBBQvzZ1tJbkTc6
	 tYQxyOCcV9ATEOUdA8iV+3vS691n3MT0CFOSllRnwGsirNZDpucfUS40GicF1+8jFT
	 2QwRlKrocIn3I0JhJ+SW3nrif1pFXaIgvxOgCLRkT7Mkwxaa8HGoB5fyjjixhHR5q6
	 1l4IaqDXPBcqpXdw3+LTZNWz3cepgXaG2ILiUKM9xYJXtC1lKhIVM3wS0ImfH4Tsji
	 qMbB3qoQtZGjw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/userfaultfd: write-lock the VMA before waking waiters when unregistering
Date: Wed, 11 Nov 2026 17:56:14 -0500
Message-ID: <20261111225545.347124-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201329-failed-6.6-35f7ecd55ce7@kernel.org>
References: <20261109201329-failed-6.6-35f7ecd55ce7@kernel.org>
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

[ Upstream commit 35f7ecd55ce7e51cb6d5ef49e6dd51f3c80f61e4 ]

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
[ sashal: adjusted the patch location because userfaultfd still resides in the filesystem subsystem ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/userfaultfd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index bd64d6b9cf899..11b4ed7efa5f8 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1664,6 +1664,9 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
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

