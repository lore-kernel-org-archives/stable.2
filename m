Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046478;
	b=LXEIMBDAvEfKLHIdKQG4j5i2OPumjBEB1p2ajPGp6qXIngoNOYY25XEsfR3XNXTyo1wN
	 0svqzsdczhGGdhWaYpES/GCeh5J35Rygvjwuy4P5iMCRWwt182UCVmbVvL8XivDiDdqyv
	 bV9at2S21YpBJm/o5jvhtGsrItjWGTDD3Z+mKXPBZw2r6JHHoggz69gXTznzkQI9JfYa/
	 gX4WUVI82wKHtGAYn41Atz93HF3fmCjaqffuQ7W1VIWyVWnS6L6lkzREaRp3fyU32isPp
	 ohRPqcjrBLi9H9PdfgbUzBIBt3o9p/o9OMnEVkPViamiAwvnG6deWlZWBPprxiyDZMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046478;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=P81/MPp8NFT+uD5GV0ES09CF4hPLuwMMbf2Wiawxrok=;
	b=O2986JsseSkIRxaWhs3ACtDzXXHxsSbUP+TbKS4Fb6Yjqp0Q4ZlrjdWNsh0GO5VU/uqt
	 3woJ90gd17aZ8P684fWLPQ6ztOJWFRLSKHf+LUSFo3zNYml9PQy6cmtyqATkV0O6XJuoV
	 9Y5WpnS42cJKvhKcYX6jJOAZRYqNCXwvw+eeK5PC7lpsQqhJVYYyeimlrCLVZLChUqafG
	 Ik2W24V+YJ4Deub5cDCeiBE0XkEh8JUzQnnUni1QYvfpv14t2tcVfP1MJPio427XaKkF/
	 BnZEYidGIXWbpIGVjRtEiGc2+2nOkgp2NoRR2r6Rz6b0D0Ap6RTtQilxyribCW4hnrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="JoNmVa/A";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7A2606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JoNmVa/A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4BCA1F0089F;
	Sat,  7 Nov 2026 10:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046478;
	bh=P81/MPp8NFT+uD5GV0ES09CF4hPLuwMMbf2Wiawxrok=;
	h=From:To:Cc:Subject:Date;
	b=JoNmVa/ADZiUhO21T79649pgB5jSkKBK2bcg+ReHctimv0O6351cjqFCD/o9+N7Gp
	 FlTNcJ4LkYwf8U6n3gHwe3ldb/cYChvJxFdLWIzHlmg7f5TQDwsEeazV2yO+WENOBH
	 HZ3flToZB7ZvXmJwEknv0ymzjbcaJNlH0ypY1VwFZ8BORTaUiiZ1FbGTszl6rJx/uF
	 DjBLYuJAJIUszIMGBAUEjCe1Aq6oVt7i1r5QAyUeuKUnREW4IkUdMZYSVP6EvNb9pJ
	 jx/5EoTkLVnwaYzMrBLQYDAv7OSBqwgk2MivgSYUZgN4VaEP0mdfHqX81ldqSHUy3O
	 1wyIGssUdnTnw==
From: Sasha Levin <sashal@kernel.org>
To: ljs@kernel.org,
	akpm@linux-foundation.org,
	shawnq1@163.com,
	kas@kernel.org,
	gourry@gourry.net,
	xueyuan.chen21@gmail.com,
	liam@infradead.org,
	vbabka@kernel.org,
	jannh@google.com,
	pfalcato@suse.de,
	rppt@linux.vnet.ibm.com,
	peterx@redhat.com,
	david@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/vma: avoid broken uffd merge on mremap" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:14:35 -0500
Message-ID: <20261107051435-failed-6.18-68cb098eadda@kernel.org>
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
git cherry-pick -x 68cb098eadda190783f8f8bdf9fe764df59f7d32
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051435-failed-6.18-68cb098eadda@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 68cb098eadda190783f8f8bdf9fe764df59f7d32 Mon Sep 17 00:00:00 2001
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 20 Oct 2026 15:55:30 +0100
Subject: [PATCH] mm/vma: avoid broken uffd merge on mremap

Userfaultfd often causes unexpected interactions within mm, and does so at
the intersection of uffd, mremap() and VMA merging.

When an mremap of a VMA occurs, copy_vma_and_data() calls
mremap_userfaultfd_prep() to notify uffd of this.

However, mremap_userfaultfd_prep() simply drops the UFFD context for the
VMA if the user did not register it for remap, i.e. didn't specify the
UFFD_FEATURE_EVENT_REMAP flag.

This is OK for the VMA itself, as upon page table move, move_ptes() clears
UFFD page table flags, using vma_has_uffd_without_event_remap() to
determine whether to do so.

However, this doesn't account for merging with adjacent VMAs, whose page
tables won't have received this treatment, and thus latent UFFD markers
will be left around.

Worse, it'll break UFFD for any VMAs it is merged with. This is very
surprising behaviour for a user, who will then simply not receive UFFD
events for VMAs they ought to.

Resolve the issue by explicitly checking for this case via
vma_has_uffd_without_event_remap() in vma_merge_copied_range(), the merge
function explicitly designated for mremap() operations.

Also update the userland VMA tests accordingly.

Link: https://lore.kernel.org/20261020-uffd-remap-fix-v1-1-0f34fc181f0a@kernel.org
Fixes: 3cfd22be0ad6 ("userfaultfd: clear flag if remap event not enabled")
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: shaos <shawnq1@163.com>
Closes: https://lore.kernel.org/all/20261020110748.959870-1-shawnq1@163.com/
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: <stable@vger.kernel.org>
---
 mm/vma.c                          | 5 +++++
 tools/testing/vma/include/stubs.h | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/mm/vma.c b/mm/vma.c
index de5ebc57e7a58..1be613044b4a5 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1211,6 +1211,11 @@ static struct vm_area_struct *vma_merge_copied_range(struct vma_merge_struct *vm
 
 	vmg->copied_from = vmg->middle;
 	vmg->middle = NULL;
+
+	/* If not registered for remap, uffd context will be cleared. */
+	if (vma_has_uffd_without_event_remap(vmg->copied_from))
+		return NULL;
+
 	return vma_merge_new_range(vmg);
 }
 
diff --git a/tools/testing/vma/include/stubs.h b/tools/testing/vma/include/stubs.h
index be8f5161f92a2..f786a585caf05 100644
--- a/tools/testing/vma/include/stubs.h
+++ b/tools/testing/vma/include/stubs.h
@@ -386,6 +386,11 @@ static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
 	return true;
 }
 
+static inline bool vma_has_uffd_without_event_remap(struct vm_area_struct *vma)
+{
+	return false;
+}
+
 static inline bool anon_vma_name_eq(struct anon_vma_name *anon_name1,
 				    struct anon_vma_name *anon_name2)
 {
-- 
2.53.0




