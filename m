Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273526;
	b=eBDs9DwzrgrdoKPVWAFdUx08cI85IOtuEu54DGqnKcrFDgkJEZHNnN2PMQO71fkd14N6
	 /ZxbQ+rQTRTYBz0VUpQROCIshdwmdy1sWWdzaWPGjCW0YUECZj1kSSWfBWPcoVrqMmv5i
	 rgXvr/9R87Qdw2xXOxdIQVfOEevm2PHBui4trABKIYUcxfRuse7lodDzjWrJWahv2mz+M
	 rdfHXMOZ4bO3ugz8rS9reFqaw7pGpDQb8aLSMZzvhQ+QLU8k+GR+NIiU/XxlUjBR/EFJc
	 jZRjAvVmUcLVAhmqsEX824USJQV9I/gYObBi/+I3OWG5yntJKOB8Q30AvWbkSNtoBRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273526;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qADCaUCHUyrv6J6sKrklxk8CWquIiPmVq9H7+2pr340=;
	b=E8lvqWuGXEX4zOtJZnJ0k0SlVlUuxWTHhX1ErcKmEvHjMQ+a5riiIYh6trfh9Z5vAyVD
	 c5nzrpwnELJ5K8pdJrQqW3MvF8SpKa3/KiQX7Tvo5Hk//C9/B9P3/3WUasZ/BiYcNPzbx
	 /Mm9BYu8hJk5MvxpzGki9/4zbri3lfJB9djeQQwPpkOddHvITEZJieodKORks0mzQS74T
	 GYWcVGOltvkyKgW2Z3UbAqEjwLumEsgxvhdUIHUdjWSigc3c3isePZ3aKysfv5zQmnGUk
	 kH8DERJRmuMRn1gEuBgXZ1imByPITWXsXuPaoal/vSlNpalGSVrQuiSI9oWwgGkpmKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FCBiavPA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041FF606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FCBiavPA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E631F0089F;
	Tue, 10 Nov 2026 01:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273525;
	bh=qADCaUCHUyrv6J6sKrklxk8CWquIiPmVq9H7+2pr340=;
	h=From:To:Cc:Subject:Date;
	b=FCBiavPA/nqTxa4fZY8e5LatNOH3t5qzG0SYsHsK0KHvnrBFzqeRGe/RkyHCwGhVk
	 HVUcMeWHKb4/NYGLx/sb2G1x0/go1IlMlL4zhLvoZMM+91FnzvITxYFHz0vFhZK60d
	 9iO7MmgZ8/tcm5QFu3CS29JYHQBOipQIx0Ga4I5QbA9ZExie0doVNR/aVtIrMABgjX
	 IlL3dLKivUt5jNSjO6Ax+tCOOkgW8OLwX/i+VnSQV2DCI0eMQYKI5ANAa3autCoE+G
	 vjqiMefzY/lNZye5hnizVhoi2l3UWOuf276QUGgP6Vybw+NZUFP19P90FD0GiJh4SX
	 U6ajaRdws85UQ==
From: Sasha Levin <sashal@kernel.org>
To: david@kernel.org,
	josef@toxicpanda.com,
	ljs@kernel.org,
	xu.xin@linux.dev,
	usama.anjum@arm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/madvise: fix data loss from MADV_FREE on a KSM page" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:18:44 -0500
Message-ID: <20261109201844-failed-6.1-22d043c1da48@kernel.org>
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
git cherry-pick -x 22d043c1da48d6c7274f9dd900714b6d58b7b9c6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201844-failed-6.1-22d043c1da48@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 22d043c1da48d6c7274f9dd900714b6d58b7b9c6 Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:40:03 +0100
Subject: [PATCH] mm/madvise: fix data loss from MADV_FREE on a KSM page

MADV_FREE can clear the dirty flag of a singly mapped KSM folio. The
folio remains in the stable tree and can gain new mappings without being
dirtied again. Once marked lazyfree, reclaim can discard data that those
mappings still need.

KSM always marks a folio dirty when converting it to a KSM folio in
try_to_merge_one_page(). Marking a folio lazyfree clears PG_swapbacked
but leaves PG_dirty unchanged. Preserving PG_dirty makes reclaim restore
PG_swapbacked instead of discarding the folio. This also protects folios
that were already lazyfree when KSM converted them.

Skip KSM folios before clearing their dirty flag, checking under the
folio lock to serialize with KSM conversion.

Fixes: 854e9ed09ded ("mm: support madvise(MADV_FREE)")
Cc: stable@vger.kernel.org
Reported-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Xu Xin <xu.xin@linux.dev>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-34-d6437171ecc3@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/madvise.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index 75b409e97dbf2..a16e3cb256b7b 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -756,6 +756,15 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		if (folio_test_swapcache(folio) || folio_test_dirty(folio)) {
 			if (!folio_trylock(folio))
 				continue;
+			/*
+			 * KSM folios can gain new mappings at any time, so we must
+			 * not clear their dirty flag.
+			 */
+			if (folio_test_ksm(folio)) {
+				folio_unlock(folio);
+				continue;
+			}
+
 			/*
 			 * If we have a large folio at this point, we know it is
 			 * fully mapped so if its mapcount is the same as its
-- 
2.53.0




