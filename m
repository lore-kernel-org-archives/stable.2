Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437275;
	b=oh0LhxUUYkJ59i5Q3JnxFQdyChB3iOfQ/bCFL2WavOU0G6sm8zyP9Rfe4XXxzCowIIr9
	 p2JQbiSSGHlWykT0crIenMBrqZ2WROVOGUr1CGno3e58RF06zrQwbXnoTTV28embqliAf
	 t0TqHR7eQl69GZA3nUuwLX4KCZF6iHh2NV9gQ8UTjI7Pg2W06H55UDWzPO6Tkq0pu8oPJ
	 Sb9Jsk8UuUrlD+Y8fdfZLg8P4HMNBBuNo9TtRNVSeMlB5EnejKBIrli2eNcfkJl/8eENT
	 /ug1Bxl1mr13yKtwJrHrBrByXgWn1W7Zys0Sd+9LVRBFAmopT+rcz0daJA8iW14XsfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437275;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VV3ByiHNuhmw0eaPxB+R1D7h6NQQE3RFZNILSwd7QMI=;
	b=qRvj24tPme5k/2b5E7YnGq4MXZ8VS/At4gCgOE1wR98VcKKsm3OUSRUm6qaZvJ7mFvLB
	 36JRBd4sxl7ADYbEQ7aodG1nitvhD2IyTONiRsIbV0t3IV7aXZiQscSyLSiqEyv43cRQV
	 LAPCa6YbL3ivVM8ZBpyLmyKoJx/ECOrsAuwq4KsTNA18hGLr1KgTbP0XP0Clwk9VPrFhK
	 uWDSfWmPhS4wMYMPOY1S7kVDbNNnSKYEN1P2PNSsyIdOTj4+iWz87YviLoh7ND2d7AvoQ
	 NddMltyJmtq8xiOKgACo2yKC8k7fv67G9radmXNk9NoAOmtzl6dQCl6R8/o1xwfPyKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G48ZgfgQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1790E606E2AA
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G48ZgfgQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BFF1F00A05;
	Wed, 11 Nov 2026 22:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794437274;
	bh=VV3ByiHNuhmw0eaPxB+R1D7h6NQQE3RFZNILSwd7QMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G48ZgfgQqHqGp9uhO4MdCEizFBeZYB2gBKGmARfhReTXVbLtKv4/qF+whsBowXK7V
	 dG2t8s6DwgBa5DJklu7W2S+LARGdo33YgeQY0RYLxbExHM/2wfU5ZAkz35had+P6A4
	 79mylvJgkYh7wo+hCoSmMc4HXeag1WezApqh5KaHX5L4l/9y2pJTjxYWlgiuAbCzyM
	 VDBQAN5fVpkiqkNXBxx/BJZtilG1xXkSNP2QSNbkId5N2aRUobtVDbTIHDuC/6pb3e
	 38IdvDH5I3l2S6tOCZVAYroYFCw1bry+9GCEhKX5WAJ/cYaHuEcIQHIBLPp5lb7a1C
	 MgwjtG7uCj+Tw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] mm/userfaultfd: write-lock the VMA before waking waiters when unregistering
Date: Wed, 11 Nov 2026 17:47:52 -0500
Message-ID: <20261111224735.220928-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200500-failed-6.18-35f7ecd55ce7@kernel.org>
References: <20261109200500-failed-6.18-35f7ecd55ce7@kernel.org>
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
[ sashal: Adjusted the patch location because userfaultfd_unregister() remains in its original file before the upstream consolidation. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/userfaultfd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 7e40eb9131bd7..2b4e83cc0cb9e 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1524,6 +1524,9 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
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

