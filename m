Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274099;
	b=r3+wV75sguk6cFNozvaUktLoH3xuTs+7Zsv0CQ2syxHttijUt3qxT0pOB9gIcPHh2dJU
	 4tZeiUe9dQVrRLJCEI8xTjJvXirCkC7nPrEzLqNt2oaLkU9QT4FxipV34Kg3dHjXBLmeK
	 wBjLKBc5WqmfFLFcQkg3M5tjET9otmF7i5lciVH/y3Qwxw3FLlvNhDX3GDIFWn6RmpSbc
	 PQEfAv37N/TacbvcEwWlOYyeaJZXKsQdAJkDAg2DTpIPWQA55pT+Fy9+F1Q+3RrHt8+t/
	 0XgGr3TscITOHBg6jb8Mjhkj6jaHVAIurCuWkJjW55l4d13uiUfbHRxZBfl+oTaRBIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274099;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5PS2Muh5uqOFlr3TFtTApMpv65WV7xg9VEttDGhxKQE=;
	b=iJ43mKgaCpLCmCqSgaHcn0eTWRYMT2MlmZaARmhia4FS1Ih1MD1Id8Hv2d/G7kJBeFMj
	 tpB0D+F+212jALUbd76CGdrlIUMiADOI0V8QZphpTbLvKFuD5hAz7p/D7ESRpESycal5G
	 cpIKURgVwvUwIgXWXDqlYeBSJGdnQhBQO5kJMMgovxqHrmjmmc+9BrpotcyxotbXTdiel
	 jj7p1QeCfNbgu/CvTmqEqWegkfmXehNZHkjryWBl3BTd4xjfaFrpd5MjMGNUjKJZNMtBi
	 PZm+GPoTWNIbZl6Zj47hMSC6NQpJpCpZLZe0/loLBKKQaw36kxdbe7NW31xDmsgN+8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LdJOMYm9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B195F606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LdJOMYm9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD4F1F0089F;
	Tue, 10 Nov 2026 01:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274098;
	bh=5PS2Muh5uqOFlr3TFtTApMpv65WV7xg9VEttDGhxKQE=;
	h=From:To:Cc:Subject:Date;
	b=LdJOMYm9A/jQ7XDnvth8+tCS8M9QLgDsUjy4tGImonzGxaR3h6E0kaFPsMm4n0siB
	 Tc72C0ZtmIfHqwledjkF7z4Ch5fTNVj20p0FHjcjZs2JDxGfA4lMyBFpGg2CUoJmCr
	 vvgDPBGz4EeHqn5msU/EG8bGXafo7wrHxcapnn5nsmuPqC88+ArUoV0KG7fteeyjc1
	 SOhWptv83c+1JIHF6Ew7ZLPbvDtGHFgr2bdOgAHrg+rhwLozxLvf4U1wqBvbLiSLi0
	 Q2zgk2Xm4HuP3eEmqdt0YoQCEQSBCBWNOjqUuZl3XEDcMWLCthe8h0aNyrkkNvGCeO
	 t9udgXjAE/JFg==
From: Sasha Levin <sashal@kernel.org>
To: mason@kernel.org,
	ljs@kernel.org,
	pfalcato@suse.de,
	usama.anjum@arm.com,
	david@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/memory: reject remote COW faults on PFN mappings" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:28:16 -0500
Message-ID: <20261109202816-failed-5.10-8db6921cc07b@kernel.org>
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
git cherry-pick -x 8db6921cc07b74197a3866d62ed262b68aeadcf3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202816-failed-5.10-8db6921cc07b@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8db6921cc07b74197a3866d62ed262b68aeadcf3 Mon Sep 17 00:00:00 2001
From: Chris Mason <mason@kernel.org>
Date: Sat, 31 Oct 2026 10:40:04 +0100
Subject: [PATCH] mm/memory: reject remote COW faults on PFN mappings

When handling a COW fault without a normal source page (PFN mappings),
__wp_page_copy_user() copies from the faulting user address. For remote
faults, this accesses the wrong address space, resulting in wrong data
getting copied.

For example, user_events updates an enable bit in the registering
process's memory. If that memory needs to be faulted in,
user_event_enabler_fault_fixup() calls fixup_user_fault() from a work
item. Placing the enable bit in a private PFN mapping can trigger this
remote COW path.

Reject these faults with VM_FAULT_SIGBUS when the target mm differs from
current->mm: remote faults. Ordinary (non-PFN) mappings are not affected.

The user-address copy dates back to commit 6aab341e0a28 ("mm: re-architect
the VM_UNPAGED logic"); likely, actual ways to get remote faults in
there on COW PFN mappings appeared afterwards. But the fix is simple and
straight forward.

Fix generated by an LLM and sent by Chris Mason in private.

Fixes: 6aab341e0a28 ("mm: re-architect the VM_UNPAGED logic")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
[ david: simplify comment and description ]
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-35-d6437171ecc3@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/memory.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 5392bcb1d24d6..ae8d567bc6ba3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3761,6 +3761,13 @@ static inline int __wp_page_copy_user(struct page *dst, struct page *src,
 		return 0;
 	}
 
+	/*
+	 * __copy_from_user_inatomic() only works as expected for local faults.
+	 * Reject remote faults.
+	 */
+	if (unlikely(mm != current->mm))
+		return -EFAULT;
+
 	/*
 	 * If the source page was a PFN mapping, we don't have
 	 * a "struct page" for it. We do a best-effort copy by
@@ -4086,6 +4093,8 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 				folio_put(old_folio);
 
 			delayacct_wpcopy_end();
+			if (err == -EFAULT)
+				return VM_FAULT_SIGBUS;
 			return err == -EHWPOISON ? VM_FAULT_HWPOISON : 0;
 		}
 		kmsan_copy_page_meta(&new_folio->page, vmf->page);
-- 
2.53.0




