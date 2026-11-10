Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274106;
	b=mocinu37wCzT2t4yBNchhJagi5ucbGdaII4RCWYxsaXoc3QOrpg+uUEvY9xTAI1+10Qa
	 BqsTokl9BElwJQ3jsfvKEZQJsl7oMGrpTGDOwvdozL92NVhbfw4a/V7IM28Idpye2Yhf1
	 5nAAJx6zx2y6dYDs4kCOMMv4Ysph7z3+i9PRivelC+yHgZO/htWt46dWSgTkVAwFYYAWp
	 2WGzlnnwUiQsIZEfpiCaW7d8qqQOaOhEQiQIivHbhxNBkt2tECG0ZH31ambSEfcaYBHaL
	 hPvmOrZkuVeLrWCwsKpIyoO/7+HViwrBHGrG3FKKpO2IvJHD7CXj954myV5P5uOpg0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274106;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+pOy7T8N6D5dRNMtvfZ6dgNACA849NCQFGiakeuUhaY=;
	b=O7QzFopeJ7CQ/Bcu0W34n4SKcKEowP7YttJpjOO61EBQtvL4HWH7Sc+iDIb07EfW64F5
	 V663WNnZQ+cMhNrNLKH6AUpkBIR54p0sOz38joEiJyVJ/mjd+kjJQEV8a8SkwAA1FtyQd
	 NEoXV3FTTzU8R41oyz/ij8J2QUFqZHvvzmPVJgZVWRA/6e6aUbHcwJgW3d7buUU+UhC0H
	 hwffK/WPOnewVsb255SaKjap/49rRS5FBc+OCiQOt1rdxE46Goa+GYqd7O/oesunButaB
	 3Ye6hBX+H8NiKqYADpj/jDpDZrrtiO8dQcofRFqRgTMtLlNfIY+1Q5viSkbj2VPjuzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mI8sTGp+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8D1606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mI8sTGp+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485761F0089F;
	Tue, 10 Nov 2026 01:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274106;
	bh=+pOy7T8N6D5dRNMtvfZ6dgNACA849NCQFGiakeuUhaY=;
	h=From:To:Cc:Subject:Date;
	b=mI8sTGp+ZQgskTL99miWWKEfP3kbhf5NbuRLBy25N4+TOYRyX/tztWfcmfNg5F4oV
	 RQQdvGnZXIp6iIemfABXDWtTr41n8pC1FTi90A4lxwbUjiX4u3RuvIFo+jv1YUp28R
	 tMFxMF9vvhbIwzeDJfqRL5409O/ElcY97V6aTGceuJ9PFeVAMh1RJiD8LcpOo0RA1H
	 F/bt8c0PChUzvacgqqAFIZK3qy5CXtc0TbzYYIG2RDlL1OsW5UqHnqG+90ZiJqHkOn
	 j1Kp5FHOCgLWOHeajdwSlUpSzJyKX0d92n8U1+PfKtRMmYCG7RpE88taFyW1Pey05O
	 oUDO+p0PT4TcA==
From: Sasha Levin <sashal@kernel.org>
To: david@kernel.org,
	josef@toxicpanda.com,
	ljs@kernel.org,
	pfalcato@suse.de,
	harry@kernel.org,
	usama.anjum@arm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/vma: don't leak the charge for stack growth" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:28:24 -0500
Message-ID: <20261109202824-failed-5.10-b1ee87802111@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x b1ee87802111156e27557e82acc31fa7dfc76e2a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202824-failed-5.10-b1ee87802111@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




