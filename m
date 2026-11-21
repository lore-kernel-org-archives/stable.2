Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795277009;
	b=VPbpy97YSj4JNkfGN4tZG/MctvYY5UfDL2LQQ6WUDfKO8hio6EkMpbHCzaOVLXetXJlP
	 yD4tKsfqOmfOHU/cNj5gGK5nQJpnBRG0i3/jfjbaajL+BjlT+xYzkUEOwrkS+tqGfRtf8
	 LGLtmxc+JwQkxqYNGEbTmKmjHQPOoChwkgwokrG9mR6+/l3jLi3pW4cOFZtWp+QLGld+E
	 OJR9g427R19etLie4ozYMPdjabn2MUGGmVrBuUL4M6V5EPlm2wB6CIFc2TRKglul4+S+K
	 0eGQBRzWnXLdKfyhq9kzt6wQjNM4xfpUIm3tfpGC8kX0TpH5J5oM3rakzt3bONg9WCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795277009;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=gBgp43T//fAyhbIagABTzJUOBXpFMWAcovwgcCINvMY=;
	b=hMV2YU9RxkkhRA2gh/6mgKSTo5dHLQhavkrojXbnCnQ82kY6hkmBMtaDXFOtH/Qprfsh
	 dLD9ojnLmi/RVdpO/YGKrfQ9MSxSpmCTqgoxhkzxYXaEwjhq+1CesWfAPjpMMS667qpuW
	 nDO2DYUyJ+x73IPs9wyyN6hc4yY5Ht0faHlxHHtDlIEVJjWo+/d3AIvUJ5LbLF749+neS
	 Z9r9ogsnu+wHVtCLEAHXQyvsPavt1jZU8Aa8uxh44N4FfA4ITw/FAezpKiQVu8JD7e+k3
	 fyeg4zNp6B1UoJPLL7eSLexpBc85vexbwpJ7DV4wDZtbTxF3ThYqhgdFS7y/hbRg02g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ak006B3p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F39606A320
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 16:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ak006B3p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69631F000C6;
	Sat, 21 Nov 2026 16:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795277009;
	bh=gBgp43T//fAyhbIagABTzJUOBXpFMWAcovwgcCINvMY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ak006B3phr9aYX1dvUEK//5L6VTHWrdhu9WnRwm2fYmRWlUHoS1ePI+w4EvWAekDZ
	 pfEQvPaBb/8y9ySRdfFXJXiji/6965/4iQuc450ZgdpA4eRPkVIpJprJ9HPjsEWtWC
	 iBKyW7ogSWyQdjceZD02Gn6MoraSsAVHGzeVB9ko8IneoEbiQBjfigplDV+e5fjG/+
	 3+zuJ6HN5sRBsHvCed+BsSgeDlCcaPCic5jXJ+VS5HbniaOT+pJQ+d7wuPwCi7toWD
	 jHXyC9gdXzxbmCxy0knaNiUvWgZ05c1ax1L0TxPQIT4FV20+hcprMuTfgqkvQKAd32
	 ANfUwy2ENl7TQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Sat, 21 Nov 2026 16:02:29 +0000
Subject: [PATCH 3/7] mm/ksm: only interrupt unmerging on a fatal signal
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
Message-Id: <20261121-some-more-ai-fixes-v1-3-236e925d9b64@kernel.org>
References: <20261121-some-more-ai-fixes-v1-0-236e925d9b64@kernel.org>
In-Reply-To: <20261121-some-more-ai-fixes-v1-0-236e925d9b64@kernel.org>
To: "Liam R. Howlett" <liam@infradead.org>, 
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Pedro Falcato <pfalcato@suse.de>, 
 David Hildenbrand <david@kernel.org>, Jann Horn <jannh@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Kees Cook <kees@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, 
 Ollie Wild <aaw@google.com>, Adrian Bunk <bunk@stusta.de>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Hugh Dickins <hughd@google.com>, Joey Gouly <joey.gouly@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-mm@kvack.org, Chris Mason <mason@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2738; i=ljs@kernel.org;
 h=from:subject:message-id; bh=QhRySLL1rZVazQ5Q24cttAAXFpF2eDQxUeouxBVErqQ=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLIZD2x/fP3tM6svkwPnLRZP8HzoZMqlGCP06fyNO5E9K
 a5H1Sc6dpSyMIhxMciKKbI8/yK+P0gkbF7nBX83mDmsTCBDGLg4BWAiFb0M/x0a7duW1MstOBZ/
 N8aoe37L8vXVTZ3HODwMii7dfrt5y0FGhnee3bcnXz/C/8F1iR0f1/L62bVdd99mzj7/qtWuaon
 9Zi4A
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Commit d952b79136a6 ("ksm: fix endless loop on oom") added a check for
pending signals on KSM break, so that a lengthy unmerge could be
interrupted, with the system call then restarted via -ERESTARTSYS.

However, it assumes that the callers can always restart whatever system
call started it in the first place (the commit message questions whether
this was wise).

Well, it turns out that it was not wise, as this baked in an implicit
assumption about system call restartability, and it was and is not safe for
mremap().

mremap() holds an mmap write lock over the operation, which an -ERESTARTSYS
drops, meaning that the restart is not in a consistent state.

This was made considerably worse with commit d23cb648e365 ("mm/mremap:
permit mremap() move of multiple VMAs"), which can result in data loss if
you encounter this issue.

Consider an mremap() specifying MREMAP_FIXED | MREMAP_DONTUNMAP of two
KSM-mergeable VMAs, where a signal becomes pending part way through:

    first pass                          restart
    ==========                          =======
    unmap tgt1 range
    copy src1 to tgt1, move page tables
    unmap tgt2 range
    break_ksm(src2) = -ERESTARTSYS
                                        unmap tgt1 range, which now
                                          holds the data from src1
                                        copy the now-empty src1 to tgt1

This results in the user observing a successful mremap() but with src1's
data missing.

Without MREMAP_DONTUNMAP, remap_move() would find a gap at the start of the
range on restart and fail with -EFAULT there instead.

Fix the issue by only breaking out of an unmerge if a fatal signal is
pending, returning -EINTR when we do. This makes KSM unmerging consistent
with many other signal checks in mm.

Target commit d23cb648e365 ("mm/mremap: permit mremap() move of multiple
VMAs") for the fix as this made the issue significantly more impactful.

Reported-by: Chris Mason <mason@kernel.org>
Fixes: d23cb648e365 ("mm/mremap: permit mremap() move of multiple VMAs")
Cc: <stable@vger.kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/ksm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 623a2cdb3924..5d320a200951 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -627,8 +627,8 @@ static int break_ksm_pmd_entry(pmd_t *pmdp, unsigned long addr, unsigned long en
 
 	if (ksm_test_exit(walk->mm))
 		return 0;
-	if (signal_pending(current))
-		return -ERESTARTSYS;
+	if (fatal_signal_pending(current))
+		return -EINTR;
 
 	start_ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
 	if (!start_ptep)

-- 
2.56.0

