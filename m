Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AED74968E2
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332743; cv=none; b=ePKhJNgcqxY1acDqRGub7RqS4h2hWNNluKTn8MXbDolubhTx3kei43qw491l9AAJpvOvqD7mp7aMycvxxDlKg5L/lyCXCKZplbXtrD7dN5VDwdAbvVrpX4eL66NS1B3IN1xroTel/XDlyWDpeakcgVvBj9KyQToenkeAFewraxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332743; c=relaxed/simple;
	bh=p8E9/slh7CML0W7a3hTUU5U5UnQm/sOeTyNdQFTsLQw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Zlr6Q4+hn3e4ELkSg7j1iv653Db/mikIp+58MhpDgoC96PwPD4He83UZ1mL7qv2/IE/2t7xz6UFgRFI5Ym9IdsPrb2jOOP8LFw4TH5RxDCp42wJmMURK4pBEhgSWL2B0p6sx/3TmwsnKF7t8pFN3LBz49FPs2tMLCBqbrcG7Q6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vy2AO0h7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vy2AO0h7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B651F000E9;
	Wed, 29 Jul 2026 13:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785332742;
	bh=RLnJup3nCD9QtxQ65Ows09RWCcmgzH+AUkfZg03n2ps=;
	h=Subject:To:Cc:From:Date;
	b=Vy2AO0h7NrWtw0XMhF0igERLHS23cPB/VH4yVjcpKjTZ4H7OZgKB70z6XSylTW94E
	 NAxz1C4MFoDMPFDM7suwj1KvFksC99+CpJ2yZ0meIzGu0aPwHjE44/QJpZrD11vXiM
	 JJxiPUSQ45Mgcu/qR1egJTidYn3isjBVbnEIzgz4=
Subject: FAILED: patch "[PATCH] userfaultfd: prevent registration of special VMAs" failed to apply to 6.6-stable tree
To: rppt@kernel.org,akpm@linux-foundation.org,brauner@kernel.org,david@kernel.org,jack@suse.cz,ljs@kernel.org,oleg@redhat.com,peterx@redhat.com,stable@vger.kernel.org,torvalds@linuxfoundation.org,viro@zeniv.linux.org.uk,vladimirelitokarev@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:44:06 +0200
Message-ID: <2026072906-plank-status-52f6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 3c58f641e813c3c71039f8fd4d4e2a3aab713288
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072906-plank-status-52f6@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3c58f641e813c3c71039f8fd4d4e2a3aab713288 Mon Sep 17 00:00:00 2001
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 18 Jun 2026 12:50:17 +0300
Subject: [PATCH] userfaultfd: prevent registration of special VMAs

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

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 246af12bf801..c3adedaaf7d5 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -2111,7 +2111,10 @@ static bool vma_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags,
 {
 	const struct vm_uffd_ops *ops = vma_uffd_ops(vma);
 
-	if (vma->vm_flags & VM_DROPPABLE)
+	if (vma->vm_flags & (VM_DROPPABLE | VM_SHADOW_STACK))
+		return false;
+
+	if (!is_vm_hugetlb_page(vma) && (vma->vm_flags & VM_SPECIAL))
 		return false;
 
 	vm_flags &= __VM_UFFD_FLAGS;

