Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273523;
	b=TWik54gKkDsp2lCgFyc/pyVOOBhLiQAlw8RRXJfZX/Y6SPFGxQCwIxiVokTvdXhpvmqr
	 2jiwlxRM6JoYg5VrqPSf3o0mTnkqmCxUbOy4qOMCkWKVrSaMkKlN6sPvToLL0kFOylBKf
	 E0C390lN2LNIWgbU0SboEHwTmQLWN+4Iy9cUlFcGMeDq3p14t/2NU76b1Dqugg3Fu/tHb
	 4uzuIjX/Pml9WSjdVzql5Has2ph40hZHeANrr813qoivtkAfL/HZqpLPVvpIXfPHm08Tx
	 oiuyJBsl9DFahbKALPTObDv7yKDTN6KZ240PMkxCTofV+Vn0hYqXWWbPmdEUMRwDKRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273523;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YRzLo2vim+x16bSb1Nxsgn4V8pnixkO7kQrri3QooTM=;
	b=4HcJC+/QdyUX4WAoYKMzrE31aB39a/enW9FlWXxL7OegqdwvRzwDofWF5/HOc0MQM7J/
	 vSTNLeA3LiqQ3YvRFfj1vE/377R5qEyHkJAwcbDDyDR5EhGqB7zQkTq6jo30o10ICrm/v
	 xAmuDOQhoFSlpD0VlvPy4nPdWQoaGOCOrjAMDw5Y8nYg45jsfyKTEFnZgWWsz8hkFY8i5
	 RetX1vrnjmx0a8FJ2aHCFelfHrHISC10fzdtUDQfse/80xTS+/2mblbepUfLUkmXa8bBc
	 oobxSaDauyRmZGpiyVEWfqKDH4pQ0ESP+/axStzqwkQtBe2vX2CXizFUhGebcbScx1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oe2hF9UI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725D1606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oe2hF9UI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B501F0089F;
	Tue, 10 Nov 2026 01:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273523;
	bh=YRzLo2vim+x16bSb1Nxsgn4V8pnixkO7kQrri3QooTM=;
	h=From:To:Cc:Subject:Date;
	b=oe2hF9UIjFjgi70g9MAZW7WEh6ap/fm6KhkYFgXaEoxEskBdkPmXcVJDgElEV2e81
	 M7pDN3Zn4aZHESeYtE1Ernp/jCcZaVjXOH5n3ufK64Y3YYENX7ToZFMinAsZZfXyTo
	 0Abe4BA5JZOMVlFfCoFxsg5hFMhvF+al4qkVR+9NKQS5XkUpSVlXrTc0VYsyxPbb49
	 qxyR4oR3ST21vtFHUZJxTwsAtpG54HESdUHcZhE2Wgij6lUmJG1IeDW875VbnOl4Ln
	 SMzqNrh04tu09LUI4wHO2zJGtNg9taesWL1YuI11Y6i/OvkS7S4gl6wh7fwoHxy7q9
	 6rPUQcujSfHxg==
From: Sasha Levin <sashal@kernel.org>
To: mason@kernel.org,
	ljs@kernel.org,
	pfalcato@suse.de,
	usama.anjum@arm.com,
	david@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/memory: reject remote COW faults on PFN mappings" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:18:41 -0500
Message-ID: <20261109201841-failed-6.1-8db6921cc07b@kernel.org>
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
git cherry-pick -x 8db6921cc07b74197a3866d62ed262b68aeadcf3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201841-failed-6.1-8db6921cc07b@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




