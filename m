Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794441091;
	b=zCAvnkUbLxQu+EsOZPXEkbWb6+rsFr+zlXbA6hoJebbiiL88Ge8JTIUeHyevUqCRxBQF
	 EMYv6wYxoZlzTjzOt3BYli/hkq6WIM02Ch59khvqj++2fdJzSlJzmntDHLnzsdGO2kp8U
	 WhVccb4Y6248O9JKG5GQwaZNN0vAG/IwRJ9vk+BrXW5mFx7WQ1DaUTDcDoqjjs7OjAf7b
	 xH+nFiAJcj/7saphCw90iIHYUOKA0N1YydZJO4Q4JyQhpx4stz7sUGiJ5Xj4butN1y8eQ
	 XJF0vNfJ+wui+lOpIcFHD17263NW3sIr2rvOgovMW+I3nKITcHoxI3xckqYaWR+WfVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794441091;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UdR8M71iloDlSCOFLWzcAf+uOGgX1xcxn/kg2mNFgVE=;
	b=EfY4Nxdn7pMH1pbARoYwXZlL2J2NiF/v8jcPVVpG62XbY9XWkwn5ZfW4/zSzGoZsC3nK
	 p/536Nf96kAehi3h/ryA79FQ/p53cZsajMkdc3q/WafCH+RW+duvH2TSyzHNOZDK05/lW
	 AfJgoW0r2fvMEqhWynaE2zd2zM2LVD3+n6Pa9dVpQq30+0jYyry6rXYDmW9ip0/1DH4A9
	 Zf+vbnuxJxspXbxN992k/HNbbcRwJJzPfIjvPRKhYjoJNwFpX8Q5Nu4fIIXCYd6i6u3mo
	 w6DeyvbH3n883kzZVDdiuHsMIuEaGhj/9BYXQLYjn0YD4C6WPvJiqd6ok2jdBaDc66g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=USzXQD+o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E78606A331
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=USzXQD+o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D961F00A05;
	Wed, 11 Nov 2026 23:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794441090;
	bh=UdR8M71iloDlSCOFLWzcAf+uOGgX1xcxn/kg2mNFgVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=USzXQD+o6bnRaoyn3cNVLXRt5Upj5mKzhLaSpSoCso43ih/XKcXRoo73YdsN3uQn2
	 NE99kH0qTF3Zttj+WZftCVFnvuaJ1nqEf5WC97UxjY6AiXUo+OXtm4n0J+wIGEYm1B
	 3GMjIEIQL74z0EMzOrE8LHhyoiAviqSMkuSG4Bu2s8WklGWesd8LVC5eBsEjFFDptp
	 Ab/RfejVUB0tTUeRSLovXfABttElt/i0vBY4Os/qFinrM25CN/7jDYcRH1/eNDDS0W
	 3saNDDcgeHNeISJA2q+d4y56kKwAxb2SMqkPFHM+jsQGmtJFiS+r5mlXpE53tMJ/Y1
	 VU0HiLr3d3y5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	"Gregory Price (Meta)" <gourry@gourry.net>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mm/userfaultfd: wake waiters when registration modes are removed
Date: Wed, 11 Nov 2026 18:51:28 -0500
Message-ID: <20261111235106.828557-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202331-failed-5.15-4eee9c389b07@kernel.org>
References: <20261109202331-failed-5.15-4eee9c389b07@kernel.org>
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

[ Upstream commit 4eee9c389b072e161549d46dcb1ae10b0222717e ]

UFFDIO_REGISTER can replace MISSING or MINOR tracking without waking
faults that are already queued. For example, switching an anonymous
range from MISSING to WP leaves a missing-fault waiter asleep until
userspace explicitly wakes it.

When a registration change removes a UFFD mode, wake waiters in the
affected interval after updating the VMA. The VMA is write-locked at
this point, so no new faults can queue under the old modes and woken
threads cannot retry until mmap_write_unlock(). Waiters for retained
modes in the same interval may also wake and refault.

The hang reproduces for MISSING-to-WP and MINOR-to-MISSING transitions,
with both read and unread fault events.

Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
Cc: stable@vger.kernel.org
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-25-d6437171ecc3@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
[ sashal: replaced wake_userfault_range() with a direct wake_userfault() call using a local userfaultfd_wake_range ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/userfaultfd.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 271ce399f6b6f..ea7e9db135eb4 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1421,6 +1421,8 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 
 	ret = 0;
 	do {
+		const bool any_mode_removed = vma->vm_flags & __VM_UFFD_FLAGS & ~vm_flags;
+
 		cond_resched();
 
 		BUG_ON(!vma_can_userfault(vma, vm_flags));
@@ -1468,6 +1470,16 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		vma->vm_flags = new_flags;
 		vma->vm_userfaultfd_ctx.ctx = ctx;
 
+		/* Retry faults for removed modes while the VMA is write-locked. */
+		if (any_mode_removed) {
+			struct userfaultfd_wake_range range = {
+				.start = start,
+				.len = vma_end - start,
+			};
+
+			wake_userfault(ctx, &range);
+		}
+
 		if (is_vm_hugetlb_page(vma) && uffd_disable_huge_pmd_share(vma))
 			hugetlb_unshare_all_pmds(vma);
 
-- 
2.53.0

