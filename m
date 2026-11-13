Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597334;
	b=BpcJk7FyOwK/CA3eyHLycI+/7oJLE/gFjnxgk4EPzJEPOwjbYddRbq52sBcPNUPTi3Pa
	 GpbDO0LbW5vogPcDwJcE8ms3dZ2hdu7zhbnI5lwMcN24eB2JxDm+utpS/SxykGGOgP++S
	 +CHf4fr4/El/duatDxfYSHq7CFUBSwlLiQ+Mb1hPJZDoAaWlBNzxMZnMCMMFZpLxsx6+H
	 FL9qL2zgVmpgX8qKKKJM3L/2seIRT3p2NNj9aIgSrc7gr2abn9Cpm4iuWQ9OQysTvNnEa
	 DBmaibunuf6/T9wpo8u8xCmHP8Kup1S9sBH8PEo9n09OicbJTMu4TNTxtLViOrmfQrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597334;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=t6gX1o9HnrJ68NCau+IAle+WU34oA9+PvP8lPYYjGxw=;
	b=CncHajCNlovKNexEK1Icr7y+1nQLG/ZXGISjXTeCqrwYZIVarnDVHxLX6HHAxsjTpU2N
	 Vd+l9xxT8YlUWIP4m+PtGEv58dHLCn0nIlk+3TDxq32mlY0CfaGvpZ3ZSb4jctiVVbbbH
	 IrIXNNRbflybHcmoZvmWdGncC4oXbnGWeVNjh5/PiGj/7w5Uh0P3SM71Z9sflvfjx0E9i
	 Q+UXHoIevhuwtf4YEl71hy+SEGzF/+wowq/YdAwum9b5DNL+VIdm0iBsYZMclLf0jWH6W
	 mrraPRKVTk+TzXWk/QH1bwBdcrSYgRyxhX4UNpyGCKdhwUsn9a98iWXZfB47+0IukTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yy0kvYDl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE78606A32E
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yy0kvYDl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226211F000C4;
	Fri, 13 Nov 2026 19:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597334;
	bh=t6gX1o9HnrJ68NCau+IAle+WU34oA9+PvP8lPYYjGxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yy0kvYDlfM63MV2tixIKqe6pIQ0ZDIF2RBuYdVFldgYhro2CmLX3OivpdvIBxvrK9
	 qHXQQLJNXBNTyKmhcTCE6EPPQZzWnRXMMMM8vvTOKObha2ALPEVUsGgzxyxLK6VyRh
	 MfxSyiJTfx1Cc4v40cRcvFzAdCFESRHUuz/5yFAeHQq4EwIbvLRoF24pGcYS7ZULG2
	 loAWCurTfkUCPSIWG0E4OxI50p8wiUwpw4n5If1nR9rARxiQFbODct8zP6Ij6iprzW
	 FDy/DzxvH3YvNmZgYP+MC/j6x0ohcREBX52vWZ1TtFAugKW6wVHVAKmLN0o+h91gI2
	 4wZoLI/rBGsaQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	"Harry Yoo (Meta)" <harry@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/vma: don't leak the charge for stack growth
Date: Fri, 13 Nov 2026 14:15:31 -0500
Message-ID: <20261113191040.2081132-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201404-failed-6.6-b1ee87802111@kernel.org>
References: <20261109201404-failed-6.6-b1ee87802111@kernel.org>
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

[ Upstream commit b1ee87802111156e27557e82acc31fa7dfc76e2a ]

acct_stack_growth() charges stack expansion even without VM_ACCOUNT.
This can happen for read-only or MAP_NORESERVE mappings created with
MAP_GROWSDOWN. Unmapping these VMAs does not release the charge, leaking
Committed_AS.

Only check and charge growth for VM_ACCOUNT VMAs, matching mremap().
Unaccounted growth skips the overcommit check while remaining subject
to the other stack-growth limits.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Harry Yoo (Meta) <harry@kernel.org>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-44-d6437171ecc3@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
[ sashal: Replaced vma_test(vma, VMA_ACCOUNT_BIT) with a direct vma->vm_flags & VM_ACCOUNT check. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 10d5e416e80d1..d1cabe718b63f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1957,7 +1957,8 @@ static int acct_stack_growth(struct vm_area_struct *vma,
 	 * Overcommit..  This must be the final test, as it will
 	 * update security statistics.
 	 */
-	if (security_vm_enough_memory_mm(mm, grow))
+	if ((vma->vm_flags & VM_ACCOUNT) &&
+	    security_vm_enough_memory_mm(mm, grow))
 		return -ENOMEM;
 
 	return 0;
-- 
2.53.0

