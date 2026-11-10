Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273536;
	b=FySCtKZ1LHV5TceLouUVKnd7iNiA/BnhVQ0wqdAVWsQl/Vtg2SvS5GbYZQOepEbIgszO
	 SmjJajSLs1bkvngc+PA0yj8fTyb3g3XKr87wuJtV5u+bTK96NCPhYci2hbGoj+EEPpTNH
	 A0p6+sfGBQvPRrQjk+RER7rF6Dv8b8cDqzV9rnNqyOIkPMCcMFHmLmdi7l8LYXGMtWdBV
	 AZXge5Cm4TYUiCStIJjH6yeREzkqEkgOKf0cxJY4zjMvnAEYn3Lqis2CMeWS1Neu8983L
	 D03tkyUK8ICoqxzcUBCCFxp6KMO5GjA+swDm/h+5+RXzIFyi3tq5OSHHPaPIU1bWzNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273536;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3RK3b6FR4Za/q0DMp4ipuYArI2jxDsTiK7AdJS8CuJI=;
	b=5thpH0kMBQ1fw71I5Z0eC9saQK5LmGb8wsCKITQa9qCfg7+kcVjMVpq0w5TZAjb/Tttb
	 ksg9Cf52OUwBzVhCGj7oShqMbf2qS6veLKjHrKBltLq/WHcO3CzMX2hK2DiF6q5j0Bc1O
	 AgnZmezssSY4ssokHCiwmPCH1bhHn1Nv2cUjwoZtJnylJA9ccbsnSIvfQtsfnvJQNHlHx
	 AdTYW0bIVxCFgJMJMwUw7qOdAQHvUuuZN28zUgW/kT63Dho1tccxzNKysEDYBqdBj/g9K
	 oh0ukwJkW6zNQYVno16XFY5JYpW68foSQ0osF56QqjcJUUPvJ5Sta+SfojfVQvxHpoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PPKgl6ZF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0804D606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PPKgl6ZF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133771F0089F;
	Tue, 10 Nov 2026 01:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273535;
	bh=3RK3b6FR4Za/q0DMp4ipuYArI2jxDsTiK7AdJS8CuJI=;
	h=From:To:Cc:Subject:Date;
	b=PPKgl6ZF1EndlUFvHBTE0zCNYgZz1RNqCNw5GIJSw5+143It1EtRXUFQ6gBV2wu1o
	 bIPR1gZVuhNA3vCChjtgqFXzq72XGtJVSgzRmOY8qORtx1+0BoY7sEvPXSpSGol8lh
	 hYYqxwtRaqJaOfPdrgoCbUMKz5hiIBXYYEkL6RbyFIAo0uAdaAE9pofidaEUoqLYM2
	 Mkv0CVqwbdOh6OOObYuZhOBJlJ/U+brCitIUkgJAR/83dVxewYiym0ZYY8Eg6qRBfS
	 HJQTBfhFEdc3frDSVp4rDbCWM+20gBfW9S3uSU0fDMZaSWu+O4nH/+zV+ErSBk53nZ
	 Uky9fjXiQiEcg==
From: Sasha Levin <sashal@kernel.org>
To: david@kernel.org,
	josef@toxicpanda.com,
	ljs@kernel.org,
	pfalcato@suse.de,
	harry@kernel.org,
	usama.anjum@arm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/vma: don't leak the charge for stack growth" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:18:53 -0500
Message-ID: <20261109201853-failed-6.1-b1ee87802111@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x b1ee87802111156e27557e82acc31fa7dfc76e2a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201853-failed-6.1-b1ee87802111@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b1ee87802111156e27557e82acc31fa7dfc76e2a Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:40:13 +0100
Subject: [PATCH] mm/vma: don't leak the charge for stack growth

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
---
 mm/vma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/vma.c b/mm/vma.c
index acdf00346cda5..695d0be85ac86 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -3391,7 +3391,8 @@ static int acct_stack_growth(struct vm_area_struct *vma,
 	 * Overcommit..  This must be the final test, as it will
 	 * update security statistics.
 	 */
-	if (security_vm_enough_memory_mm(mm, grow))
+	if (vma_test(vma, VMA_ACCOUNT_BIT) &&
+	    security_vm_enough_memory_mm(mm, grow))
 		return -ENOMEM;
 
 	return 0;
-- 
2.53.0




