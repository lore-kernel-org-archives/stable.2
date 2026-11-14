Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794633230;
	b=LPGF2hp2SZnqUdwsKJRr3qg3+0XUA/7qakAYfWZtmq42tvBQmdPF1XbRe+VnF43rxxqS
	 +zc4La76Bl74gn34D9bsZiP0dqNFJKIBMDoRhY1ZmG/kwH0zIzNiZBsI3hEoBCXMRajGj
	 0BaYhfMx73RSYb04PLK3T2fJwQ81HKC6cKoXLAYwRZj/kpUSbee/OUHZihCiWl0PztxdE
	 wy5304iNpST5R+X3Bpurm1z4BpxuEllTdR4f6rvgq6ekWppFieRy3ISY78qzcrWcB1CId
	 gglubcvPUFyyAa9SG9oOKatvOVukCO8MhZ3YG+5dM41ckpmE3Jy0s9Ff8vrbrt2QWMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794633230;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ml+bNfw5Z8U0R3bNexvw0F7bSXS4TpdvNjfIS+l1JNU=;
	b=aicWhovvPgFrcm3pzko0In+4nGTLeKVv3SB98reG2aN04Bs6Sp/e0pfmIzmbg9nmhOCt
	 FGUK1OQsWmvy1zX9tEypYZfCfRqqpjmmpY7SiKJt+FuYOuWUtaXlV2oZ74g9UuB/q1/YW
	 +ikQhMYEph5Gm8IvTgLufMBI7CBbKv9rJY6bLWU6OP7q2/qL1Ser5iwx9TDa4A5hgOGjB
	 g9cJJ2HnOOAx1ngXBJSyLnyJXVLqXLvVPuMOBmJIIQjA7JbKbEOns2EDeC170jjMSNTOA
	 sF2NQaCa/zJKajKdVgiKkvFu6/joI999H2m/0eZ/mrcK27ckb6S3JOHAxhT83pSK8mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jYSMdUIy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8725A606A323
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 05:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jYSMdUIy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732D01F000C4;
	Sat, 14 Nov 2026 05:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794633230;
	bh=ml+bNfw5Z8U0R3bNexvw0F7bSXS4TpdvNjfIS+l1JNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jYSMdUIyKxP3+ntAOXZ52lVetjehmNoOsxNUB5T0Ti5/52C5jT+mJ5PYgRfEGZZ+o
	 ns3a3xsZwVS9WU5zk1p343wPzC8ght88KQz7RpP8bBFnTqAaA8vYy5igqPidmWNzO3
	 MSOJbGQ6VoB423MmBHimbjxXe3eVRTjjYbiWdR4ofr32z6LujR/2dbDs2EdMk3NxTp
	 sjlsyTXAyE/1x6hF37BBsDc+mE77/XdecTwGVyv3x7kRxzJs6J6hpxN6Ed8TnoQLv5
	 Ter95sgLTchuyhmzlvPhK2OQQF6QdM8J2TuB2uysiaGp/0r7rlFSlATxJnfEY/Tl3q
	 wOTwPqNYwqXoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gregory Price <gourry@gourry.net>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm/userfaultfd: compare exact registration modes before skipping
Date: Sat, 14 Nov 2026 00:13:48 -0500
Message-ID: <20261114051339.3071292-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200908-failed-6.12-05f64f211a25@kernel.org>
References: <20261109200908-failed-6.12-05f64f211a25@kernel.org>
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
 mm/userfaultfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 10685c46f0866..6a575335bc6f0 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1979,7 +1979,7 @@ int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
 		 * userfaultfd and with the right tracking mode too.
 		 */
 		if (vma->vm_userfaultfd_ctx.ctx == ctx &&
-		    (vma->vm_flags & vm_flags) == vm_flags)
+		    (vma->vm_flags & __VM_UFFD_FLAGS) == vm_flags)
 			goto skip;
 
 		if (vma->vm_start > start)
-- 
2.53.0

