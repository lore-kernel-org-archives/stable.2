Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794634575;
	b=xISAiqDVsqGDIi5oGywiZwsaPHqxbjjaIoY5aKRBHRS1/dvigpA3Jy5y91/NCd2+rbd3
	 HIrUO0+o/CuDUAvO6TIS8TfLDU9wSJBZE6Gmg3cOVJKPZAEj/fzz9tC498N9keJTUgRMC
	 JiF19BAG65/G184WgwnrTGjRcRGPKWIaAIKZc44EYmVfbKxHDDiQV6b16LhGX6PmF2IBp
	 +xpNZ/13xxzks0EvdNJ/f25QBx+QS++zC7BysztP4uqCgENUDqPhfPqbRTOzY34JVUW/P
	 YoMdKmEN8BiK7QgR366jToV9s5Bu9kEEGbTvv9X1Q2VTzc6NgGK/2t8IMYgADEc43Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794634575;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bzHwAEpVdx+FuFW+fZu8YCHB73jlBCyQgjfWgRSrOVQ=;
	b=pOCg+wkNFkl229SOYFmh7Azacuhxiw+gUBC8gKMGfNok5XE02O2UP6IULuhXOOT9GYJe
	 F6dEgDRCofPiD9pgvb7Ff6M45f8mwx9o4JrAehC11L2pFiaL0hSqki1UfqeRVgXLHI7gu
	 eUUrJYYjZ4xlJz0QhhYyKmRAjJrmEBbsnNCGFbJEayJ1IWnXufLRBpYlufo06ZsZtwwBx
	 9OL6SHOopp//2boLq9uNyJB9jz8iO8fbZIXpc4m2Dh/Ex8w/7ZmfoT9gViHFt3Ynldq+R
	 zUIe7y0LAaIV8cHlXZauAc35dJ3UKvoxVAES0Jg8Wf3DEn3MT5ezjtnjNFmbkpiHSwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c8ajn0A0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B12606A32E
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 05:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c8ajn0A0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72DC1F000C4;
	Sat, 14 Nov 2026 05:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794634575;
	bh=bzHwAEpVdx+FuFW+fZu8YCHB73jlBCyQgjfWgRSrOVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c8ajn0A07CUHMxMSRcLUaLc41qXEKxOtTsRYeE1mYrQvloURAovuegq/1b5EaKvJ8
	 Kq9/Dw3fxNlIuJey7Sc9lwPLgipMTHollj5ziA5OFR0JadTVoWvkx+zxBpuhhGQXdV
	 ULjcQhSFAPncJW0kQXisWxSRKpGOX0HM/VJWhbVEyJza62xt7b5tGbO04B5h9/Ch9a
	 6jwyZY4WVrMNgvWOZVoucBYd/hrMeS/QyeufbKnZ6VOvp5pWuiVcNes4gQHHIiou3u
	 SWc1HXKUlrKZvkmgK8+8Ms8+RhQlKGnkdlK9l84463StiWITHw0FyKVyxIk/zN8AP3
	 Q4ivrdpIMJ7vA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gregory Price <gourry@gourry.net>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mm/userfaultfd: compare exact registration modes before skipping
Date: Sat, 14 Nov 2026 00:36:13 -0500
Message-ID: <20261114053558.3115760-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202758-failed-5.10-05f64f211a25@kernel.org>
References: <20261109202758-failed-5.10-05f64f211a25@kernel.org>
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

From: Gregory Price <gourry@gourry.net>

[ Upstream commit 05f64f211a25f7d9771d4fde109aad97174a1cf3 ]

Changing registration from MISSING|WP to WP returns success but leaves
MISSING enabled. The no-op check sees that WP is already set and skips
the update, so later accesses to missing pages still wait for userspace.

Skip the update only when the current and requested UFFD modes match
exactly.

Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
[ david: apply fixup from Lorenzo ]
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-26-d6437171ecc3@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
[ sashal: Replaced newer VMA bitmap helpers with an inline integer flag comparison using the VM_UFFD_MISSING | VM_UFFD_WP mask. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/userfaultfd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 21c32d941f4a9..23230321c7756 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1409,7 +1409,8 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		 * userfaultfd and with the right tracking mode too.
 		 */
 		if (vma->vm_userfaultfd_ctx.ctx == ctx &&
-		    (vma->vm_flags & vm_flags) == vm_flags)
+		    (vma->vm_flags & (VM_UFFD_MISSING | VM_UFFD_WP)) ==
+		    vm_flags)
 			goto skip;
 
 		if (vma->vm_start > start)
-- 
2.53.0

