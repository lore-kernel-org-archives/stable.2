Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272968;
	b=cRdPet1xRL7KMzi9rX890bZplQXFPEaZDJN6IAk9UG4bgOJciwDQs3DZLwaC1xqsRIBk
	 Spcp35SySkAvOD5JyyJxkHasoHc0AgqxMYNtZcx3OwSrQaunNx63NBP9IOLcWE4qwPfoz
	 VqpNY99XEAnUSqTjGou2XznZSGOKekG5GYkMjhMdZRvPyhTv7+wnKmjdiC9hqFNZ+SVKX
	 lL04xXnszseNUMim3HLIhgup3R9ekcjCNnMEaRrwd+ydKALLlILvgfqIbc7GeLWUDKN/7
	 OpzowtUDTsZHC5C4BPNtlUABWmeDIYIjFcOwl2VejdM49Yn7QDNCn5BFDYqfcnC57Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272968;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=vBcEg4BHxx5gWGRBBqt/XFunpU5E8pvoXQLdzQ75e+g=;
	b=via7Zi1xILJVBQanLMJvK+Iunt3/NfE1bSXFdPgv/LBiq/4cslrzhp4o2sF1mV1Bllk7
	 huMFRewc4VkV3ivHUEeFHaMKo57f8hRE33Z9Jq1wG3Y5oHRMXT72RPGQRA8su+3OJZoMW
	 N8OIgT2sKiNh/LNiGrDvNeAiJyfjBXdFdg+eEWMeAYKpivpvL61WGn3U0HBDlgTEvBOU3
	 zS9QQG7RkQ5EQr1pAcbeyBGC9TxH9QN54RwH046VMKwBVWes/Qjzxqmj3vTfprHSNyeVe
	 kENm78GKsIprEfALqriiCVghD+vi+qbqyqjJ5YSe4mwunFfHryO82mYl1CSGan/wDBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cHkBPb5B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55623606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cHkBPb5B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66DB41F0089F;
	Tue, 10 Nov 2026 01:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272968;
	bh=vBcEg4BHxx5gWGRBBqt/XFunpU5E8pvoXQLdzQ75e+g=;
	h=From:To:Cc:Subject:Date;
	b=cHkBPb5BGPN7xRPUDZW/UJK3BIUVYMmz4k9lU8eA482tiKIfJBc7ScMRR378uPKz4
	 +QnjA6vVRuq5B7h4baFKi55klJTuQVxqH8EFUcfolN0tlJOyWSZ64bVILgwM+vF0v8
	 1Zjg1pMJpwZ9sjVPmttYBcqfHvM92IiA9U6xzkgUXVk7f6Tgdr430RPtlcFFy4X8Al
	 XoOiX0n7hhz/MQBnVo/fPBx81ymeHlFszaa3mp9ldEe6OV0V+rIWUF3PRbPkqO2OI9
	 4HWi+bIESwCkyeJkErCCyYiUkrfAf5YSihIEcpqBkazHeU0rHF0XQzDeRhO4F+xlru
	 c/bgnd1TglUMQ==
From: Sasha Levin <sashal@kernel.org>
To: david@kernel.org,
	josef@toxicpanda.com,
	ljs@kernel.org,
	pfalcato@suse.de,
	harry@kernel.org,
	usama.anjum@arm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/vma: don't leak the charge for stack growth" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:09:26 -0500
Message-ID: <20261109200926-failed-6.12-b1ee87802111@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x b1ee87802111156e27557e82acc31fa7dfc76e2a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200926-failed-6.12-b1ee87802111@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




