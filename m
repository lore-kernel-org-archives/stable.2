Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437547;
	b=XOnDNreD3CjyGQM/7jJrQzfNMz1Gc+cCXCKYfKK3Q9yq7qNhFyduIi2x1j4diK3wc8FO
	 lwvhhi745uLKrXDVLHwgdbuTfOlQWOpLXFNipcXEmOjmKn5Cf4PUAMP7GMdDUb2AHRZ16
	 bsMgsdnxqISeJxxhKlD0FwgX6XGsB+sgRfh6Qg99+EPOBv0yZjrASY3OyxE4070JqcLiA
	 McJ6/piMK66e8XZxHqCCtsefCigZGkb6h0/xYXLj520ENV5il81f0QuTuolUC6S8itcHd
	 GqCftd1fM0ZQz8UzbGkFmIaYNu0Xb5fYURznNVfw3ngpj4meIj1MRELtGIzB75Nyj5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437547;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sNpSffDMfnK0EMKoFbblPU3BUIX/0dJHNTDdUIe4CEg=;
	b=3YKRUHwTY9XEbMUhCna5MvClH5Nt+VMeZhWpBTTJyp66Ks8NUc2XRxHB4zE0DfY51Zkn
	 Iy3NmdCjhhXOCpGPpxGie22oP9kiyuncpCy1dq8XKvfhwiML8xbk2QJ67BHgxf7KTZN9h
	 D5tBVNhmhXRMrmS3FnzT7jfrK7R4e17gVwYU1laYD4jIKYUNVreZJt0gcOwAY9+ZRRqqi
	 zsFOqV9x6Y2AYK6dOoMni50ZJoLnwnnbvN55uoPfdtHqc17iX54zapUh11PN7rC98C4k0
	 7K4RVtHSUgqL/EwrlDZTiqaUTeXYOPTjad1N5FeD4/aMuTBfTySbBZmIPEvuBzfLU5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JCw54q7r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83165606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JCw54q7r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455FC1F00A05;
	Wed, 11 Nov 2026 22:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794437547;
	bh=sNpSffDMfnK0EMKoFbblPU3BUIX/0dJHNTDdUIe4CEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JCw54q7r2ltqj7KPtUIo379eR6tmNJN1ttbVEjxbG8VbNoPtrHBjOd6h6WSMlWvWP
	 8yCDoP+VdER3bAJ7BC890x8bHAXwGzQboQF3TpZEo7aBiPabES9HRNCEePYkrRrErU
	 bC/Q8kzKYkjHEzUwtARCvi4ccX6eBJPJoe7+WvuL6pcx+BLBAU4G511jCyOrdUvvom
	 6qJ5HMCaNro024prI8oIPlZIC8BKUsMoAKtgVckm/7xVROtlbOYY2NtZJ76QR8QoJm
	 jj8/Nv/izxKX3ZJD5o2l4HrXedPS+XfQH+NC9diHmf3mWLfcwaFJqQD9tGu7DwitXi
	 2t4u6kDVFIPNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm/userfaultfd: write-lock the VMA before waking waiters when unregistering
Date: Wed, 11 Nov 2026 17:52:25 -0500
Message-ID: <20261111225201.293327-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200905-failed-6.12-35f7ecd55ce7@kernel.org>
References: <20261109200905-failed-6.12-35f7ecd55ce7@kernel.org>
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
[ sashal: adjusted the patch target to the older file location of userfaultfd_unregister() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/userfaultfd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index cbd9d610c54bf..59f01cc7c5ace 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1513,6 +1513,9 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
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

