Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794634017;
	b=aEcsAo1c7jXodKG0qa5j86si9ZqGnNZPPNaYfZZV/a9nbCWugvA5BfLwbTSV/Ei0dMDI
	 Dvyt13+sG1ZIfH3oFV9B6dozbOGnjeNV6rqec4/8DssC7RIPLiYVvVE4yezqj4E7BynJT
	 0BpUDEJl8PKK5lmM6y18luyfYRG2dMnWvUB0Qyh7U1tqCKBMc+HlYJHb74GHUsJ0hqiDN
	 IC46B4W1usX9MWxOksqe+wLo1F44Fjr5MO+0plir8Rmjf5sFduDRFz1ZG0fk8Uxg8Fa7P
	 1Dy+oouz2P8mfh5E3qvBaMyXMipIwXPLdHNW1PSNXaQFp0mlp4CWmZEwLda9oTtKDvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794634017;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8T/256rNHvghw0fqhRXjLZCj3QCI0cjwH+bpfdpUC4I=;
	b=j8nH6fUQYTCRyhzjHMJGquiKRii2ZJ+9i6iK9FtwwOQ2EzdG52TcKT1v7BQwGYfGxXuU
	 URbPN8ORV+uMcKTZzNTpNFNjilq8589umNYiY8Txt+uy3/KHeCOuakvg9rLucSPRhxQCE
	 wzJMbmFhmhFFtNKNPddY43Rg7CQHytn9ldVhrLGrTUA2nlkaUb1vcMijx5/ZDMhjTWFSm
	 N5qy2sDArw0TMEg41CdwMEKBtECImNIQyTPI6s5Lf2OIN5uyHd1gFURB/GRc+BBH9aLzZ
	 6tLp8yXgbPa2twsKEU8wY1/WxXBdjtqNyOf7hoRcagBZ42OOdlRsv1LZ0r8+YpwDZiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PJXm8taX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBE6606A32E
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 05:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PJXm8taX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3E11F000C4;
	Sat, 14 Nov 2026 05:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794634017;
	bh=8T/256rNHvghw0fqhRXjLZCj3QCI0cjwH+bpfdpUC4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PJXm8taXAqlGJbWdTYGfUY2LwqWb6l6L8JRaSfEThmRjGQRI4I5rSRZPdOsCCwnck
	 evy3METz5gnRloWTZK04u9ZoQ3TG+cnAGeEiMeYYsaEaMTEh2kjD0VuDuokoOivz9S
	 tYDvmoLUZcNnn/4MLGFKwMSXysndPLokQC7La4JZTMDZPWFh6AN+odqTgCmJFKxCD9
	 USmgqscGSaJW9ahXk6lUgFg5IGPn8cnYOpPFd6oOnHU+a0jjdApObRI5SPLfZHEaIU
	 dVM75dM+FUwa9oJeZKfEgTeRLaTN/TQofowx7Yx634JVwu6CBXvj6mxFIKJ3DR9PGt
	 ySCd+vJL6vflw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gregory Price <gourry@gourry.net>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mm/userfaultfd: compare exact registration modes before skipping
Date: Sat, 14 Nov 2026 00:26:55 -0500
Message-ID: <20261114052643.3109491-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202328-failed-5.15-05f64f211a25@kernel.org>
References: <20261109202328-failed-5.15-05f64f211a25@kernel.org>
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
[ sashal: replaced vma_flags_t helpers with a direct vm_flags bitmask comparison ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/userfaultfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index ea7e9db135eb4..1c4b0cb54d878 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1435,7 +1435,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		 * userfaultfd and with the right tracking mode too.
 		 */
 		if (vma->vm_userfaultfd_ctx.ctx == ctx &&
-		    (vma->vm_flags & vm_flags) == vm_flags)
+		    (vma->vm_flags & __VM_UFFD_FLAGS) == vm_flags)
 			goto skip;
 
 		if (vma->vm_start > start)
-- 
2.53.0

