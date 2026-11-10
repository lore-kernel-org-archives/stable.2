Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272722;
	b=Jsh23xj2NTfkLQy0IcY9DLr6Jbv9ymvwQLB16T2A385uXT/GCqnHrPE5AbRfoDPUibhE
	 l31GxB8ETRGFZeaeGOxlMRybQY4PICSOJE/xZapwZovML2TxGcONnJRpRr2ObegDwcv7+
	 nxz0pJgp8bjYf7otNVb/BhasskDqkjrv1lBS2EtIVdw2KGj/gjS+MeMw91NbElVPT3yTR
	 ZIpJY8/J1twDOrr71d27cQH2VICURfbruxvvOVYAtTuU4xDl2fjygvzSjiJ2FPprsi0Q9
	 FLWj4P8l7YoIH5vyRA0km9f0pOhy7sTCtchXV6YVq4mRdI35mWeL1bt4SiqkdvnEW+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272722;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xYcuFIbhHkf4bQKgoZSLQSz/RgumiBREPm54yjBNwy4=;
	b=IvRfJX0lfQd2DLhB5TPlj65RwDth2ADRZtbRQ8ddP6NLN1QcpbnD+z/FpzBmryqTN6oF
	 KoCa1X48dj+F4qzMgy0de38bBYhp3LQbev9ADJcMP4oyGPfO1aB9DhCpvKWDPj3RFi3ES
	 h2VdzVFRKiGQ7glWhvDV+2dZdU3gaqi1t3LzGqM2eyUu2s6xMbLJFob8xP7n1ron4jWdF
	 CL1yYfS7CC+z5HdEPSbj6Vms105Pf170NwPMLqbOxwKkZm7nHS7z8SgO8ektTRD6pNDP/
	 ziNy7N5iGolSK6MgVcnYUcFqi0zywclbN1698Cau5SX8pDVnmeN0EaD/HJLiBiVDKHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HHkbIpE+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF03606A333
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HHkbIpE+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7F41F008A5;
	Tue, 10 Nov 2026 01:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272722;
	bh=xYcuFIbhHkf4bQKgoZSLQSz/RgumiBREPm54yjBNwy4=;
	h=From:To:Cc:Subject:Date;
	b=HHkbIpE+yo+zdyo6ETq1hWG98yJGUf5QTdKMok9X8pfLbJo/oCncGfnqqX94egYz1
	 JU8y9u9XjcZ6dBv10YhhmbWXb5yepoNPXzI7lPQAKWWjVPniWFCTFWwwwvRcmujqK5
	 MTdT+C4cGkIxjd1B0ne4CXt9foc5nU2/2P+CrakLVfxP5UUvNs5ldEhI3ui1yD0Lou
	 ByYyhhNnmjPDMJBHn7WXgvwxvgvZpo2HK73O8gFpzLq+AxAvzF5dZKhEvE71EapV15
	 ZnyON3pOnRLCPveE1RDYoFjh6l5veSbrSzS9bUewyJpnkJxVv62bODhE9JSXWLRqJV
	 o6i/h9VoDHG1w==
From: Sasha Levin <sashal@kernel.org>
To: david@kernel.org,
	josef@toxicpanda.com,
	ljs@kernel.org,
	pfalcato@suse.de,
	harry@kernel.org,
	usama.anjum@arm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/vma: don't leak the charge for stack growth" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:05:20 -0500
Message-ID: <20261109200520-failed-6.18-b1ee87802111@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x b1ee87802111156e27557e82acc31fa7dfc76e2a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200520-failed-6.18-b1ee87802111@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




