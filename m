Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794633843;
	b=xOf44F50q27vzDifQeKDyvOAZlOErNnJpHG07A8cuxCgh3BSBRvG9/JfIjiKvTIJmMKJ
	 XI073FVCBE5Lox8/OKzHsgP7UAsuarc5AbQ1qZW96H71idvhQ+4P9DAIhv6v9d03+esGj
	 AjmLRoSeo7VMEUyFIWNwhzmIYP3OpPbLQy8wyzxJkrBHlhMXIEoqFls0Aq5DxVoDV9tGg
	 2rAxICwVN9w+xqa2J7f01I8mHX/BQ2i/h0gILFt/9ScnGkmh4uBdudQgrSY/u+gPJAtF7
	 4GQjcUnC9+u5VP2DXzlSLT9vSreLv+4r6Atq8A49Pdw3ugpzmCOgdzTVX5pEOl9eoDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794633843;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CvaDJI7KTecklybYVl7VHjGAGY0cWOCLMu2135GNS00=;
	b=2Iqx0DZrq7brRgRGZ3lArwtiYPj7SURrygn9E6+yDpYT/+HYsZBr3LHLDqJcSlvgbGys
	 dsILhbRTHVehVSe6rPcVdQnj55XVizzSER6lp0wWMtvezKRjapKp0bqysGbTvDq9I0GrF
	 yYIIqxgGUWNjJv4S/oyIT81SVBAEy5j+1n+I9q31reLR87R/opuSvEpOLCq6ydIZTWMKK
	 BBf128OUUhpss6OIR+eeLeAtzCSCmNDdVcw0avnc4ZOuJlhIKax5r6sPnu5fUQ6Yq3gUY
	 RyAZWZ02y80Mg9H6DEkKudwD17LJHBPvv50zBNg5QddQFdlaKgD4Rg69gR1wRTTnU2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NV2Ql3kp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82709606A327
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 05:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NV2Ql3kp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700DC1F000C4;
	Sat, 14 Nov 2026 05:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794633843;
	bh=CvaDJI7KTecklybYVl7VHjGAGY0cWOCLMu2135GNS00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NV2Ql3kpphhiyYmLIiDzAjYKRhip0zOPbn5zdU94v86mzyddH9mgjKa60F5Ekt6hn
	 KDeW2ZvRnPp2uoKOviehHQiRPOQe0F32LjD+flgDuxhzy5Nr1spzt254rQ8sBLYvzp
	 ML0jVy+aS9g6usf9kq720/sio7QVJRcyLKXdPP4KMqPvJIbC30HL/X6UNlD5HoTj0s
	 jEGzk89Y5vpKTMZN8/HuN2jfRsr5UYjGlvTmacnF7WhOv6w1sQxnxeC1npJ6qO1buT
	 vX2UPw1HNTOitcb+Vr3Ox4xwXj+oZZpXd/wnWn7TRKTtBs26eUQLEw59q5dbkug4rM
	 T4MZC2WzlZqjA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gregory Price <gourry@gourry.net>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm/userfaultfd: compare exact registration modes before skipping
Date: Sat, 14 Nov 2026 00:24:01 -0500
Message-ID: <20261114052347.3103878-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201828-failed-6.1-05f64f211a25@kernel.org>
References: <20261109201828-failed-6.1-05f64f211a25@kernel.org>
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
[ sashal: replaced VMA flag helpers with a direct vm_flags bitmask comparison ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/userfaultfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 7a23fa700ffd1..00690ada9c7b0 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1464,7 +1464,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		 * userfaultfd and with the right tracking mode too.
 		 */
 		if (vma->vm_userfaultfd_ctx.ctx == ctx &&
-		    (vma->vm_flags & vm_flags) == vm_flags)
+		    (vma->vm_flags & __VM_UFFD_FLAGS) == vm_flags)
 			goto skip;
 
 		if (vma->vm_start > start)
-- 
2.53.0

