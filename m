Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94BD3A83A9
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 11:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786187579; cv=none; b=PNukgD2eYLTleXrrBo1u1x7pr7HIc6FU3ConfUAzos+SUhRuS2Is9kv53Tet+bxI+V72fZDqbMoel98NwhXQJFWywLCgAZJy+OA3+3p0DmuCMqvHQTpuZqefRBeZtTgG9D8H4O8KNP4VhjTxfHjcRTjJLhVtfyBRtAE06dbCQgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786187579; c=relaxed/simple;
	bh=2CNqm61ioCY5MXqPRX6TLyue3WGr+2s5q/p9nWGFaXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lv2hWbmvkA5N4YWUG2AQLBTnmB5JXWvemvQG1QzKycJzyGtbAMsoeBGzVDXywj89hUy+NFThtYPMuTqlqrjEG4jJPvwvfcfKGI8iiUinzPkeo67kG5sbq5SXViHU5x48PJ6XwMRIN+7aFwEWG1KddvbYVoiaYWam6AwJNqBQEgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MprTW64C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MprTW64C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC2F1F00A3A;
	Sat,  8 Aug 2026 11:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786187578;
	bh=wVuzTt/gVPmfBf+TmcSLftd+tIag9Qy+057H/UhysGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MprTW64C2eDyHuddUqq2ZnuzTHE1NFu39a8Bqqe8GUhpTUtfrhVd32gytWcec9S/k
	 yLC/YYtBNsXZpWAd2D9j2v8iwFVV/O4VWk1NXnkNivRM9ljfTfoDKRMAC8lDZ7nc7M
	 fdI5ECkT4wQFvXDXvPbWZIPiMWWso2Bev3cDW81Z3hlsYEhum2DuN3k62IepbWgQmg
	 KqK1X40vytmhds4tvadaq2ZEeOUwWExms2OfRlPToL+2KE9eJO+V/Jnbx8PihOb9Gr
	 eEo9cOX5H20bdBIJr54hXvN123Zk7lmOvu266/mNnGwwX6+IXGHJmIy7yU0h/RVlRE
	 pIZgzcTGhLvew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	vova tokarev <vladimirelitokarev@gmail.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] userfaultfd: prevent registration of special VMAs
Date: Sat,  8 Aug 2026 07:12:50 -0400
Message-ID: <20260808111250.94416-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808111250.94416-1-sashal@kernel.org>
References: <2026072906-plank-status-52f6@gregkh>
 <20260808111250.94416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

[ Upstream commit 3c58f641e813c3c71039f8fd4d4e2a3aab713288 ]

Vova Tokarev says:

  userfaultfd allows registration on shadow stack VMAs.  With userfaultfd
  access, you can register on the shadow stack, discard a page ... and
  inject a page with chosen return addresses via UFFDIO_COPY.

Update vma_can_userfault() to reject VM_SHADOW_STACK.

While on it, also reject VM_SPECIAL so that if a driver would implement
vm_uffd_ops, it wouldn't be possible to register special VMAs with
userfaultfd.

Since VM_SPECIAL includes VM_DONTEXPAND which is set but hugetlb, exclude
hugetlb VMAs from the check for VM_SPECIAL.

Link: https://lore.kernel.org/20260618095017.2553004-1-rppt@kernel.org
Fixes: 54007f818206 ("mm: Introduce VM_SHADOW_STACK for shadow stack memory")
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reported-by: vova tokarev <vladimirelitokarev@gmail.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/userfaultfd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 82aeaa936f019..99438f0950e3c 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -894,6 +894,12 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 
 bool vma_can_userfault(struct vm_area_struct *vma, unsigned long vm_flags)
 {
+	if (vma->vm_flags & VM_SHADOW_STACK)
+		return false;
+
+	if (!is_vm_hugetlb_page(vma) && (vma->vm_flags & VM_SPECIAL))
+		return false;
+
 	if ((vm_flags & VM_UFFD_MINOR) &&
 	    (!is_vm_hugetlb_page(vma) && !vma_is_shmem(vma)))
 		return false;
-- 
2.53.0

