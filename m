Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047175;
	b=eJ00KWNwa8NjlZ56D5aDY8/Ec9cqwMlok8/TaSvOkO59rUEFwie2moe0XWcB8OsRbg9u
	 aenLPTQ15E1aYB2S/VrhCPARGutDLpwxj9cAK36icGowMKRiJm2P19jcw1/U7HA5IcYjJ
	 NH3bQSvt6iC9APe1pr0Ekj5XEmMWWLIPlnvoADIF74ZR6jtI6L/GbSjP+MXGmUH+WJVhz
	 4ZfpT7nycKchEJAD2Jk5QEmCv4KMdSp6yrmLvH+TCXmhBH1fgJPpOdIaMWedudxinSAXx
	 yDVxxj4pL6kBq4QjxRhCw7jGtLzjyyLkagDz0wNqh1xW+ISkdG9fB7krlISogcFQMOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047175;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=b7E5h9JDc+DnOUKjzmYExQgR3GlUbvGIR4YptbLJJZo=;
	b=kojRWL7VOMOg7IVRxHQejGjipbe6jqrrzcX5EnXlc2X+xbCJAAozDioYQKRyjXz6Inie
	 ZvY0s3vl/pEk5PTJKuUehox4aue7KtqT3VXkrPSZZ91/j6SeIC2WUJuL4nu3CtPPA4XiO
	 T+E+o4WbbjtG92Y4a7kbnYTBQRcKMKQRfqcaBJuX2gKEIoZNOxD1RI4f5DTWGf9Z6kY0s
	 D8dQK/5CIhtnLVZCc6TqNgYK6ac8XMhcaf6nych3KNDsE/pfsV/76EyuVjcs56DAwuapl
	 DXtpS2gLBrDaq/LcIGEX8AcRlrkBY/AIwrg2v37uzdqP8WAzer+OF39ayTfPFHmX5jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EMtbRZT8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0FC606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EMtbRZT8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2880B1F008A2;
	Sat,  7 Nov 2026 10:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047175;
	bh=b7E5h9JDc+DnOUKjzmYExQgR3GlUbvGIR4YptbLJJZo=;
	h=From:To:Cc:Subject:Date;
	b=EMtbRZT8N3n2oIOAHARPcBEfQ2ksbV07oG22TjS8Qe1QcUvB8Fqo/CmsUNmHiZR/c
	 dxaKKa0eqZkgqIOKwK4MKghxPXmMu6FL3CkkWm6569eUo1U5gM4b/LXMo7HDyFAER/
	 AYfNM8NlP2zONe5TjCrKbu+Alb8vJrzxswbq2jEg6HrE8KXZx9Payh8qw7CoNTFARK
	 MIPxe2WlNCbjXlXF4/OV4nd5F6DE1uTKN31gtC8rwMzFjoFj783lCIX607C9Cvl1ei
	 6NcGpqISYtJo4/fsHLfzpUkRmNHNqw93dwg8DOq4jBA3fJ/sz7YxRtECSO+D61hClw
	 tcX6wWj7WC49g==
From: Sasha Levin <sashal@kernel.org>
To: cenzhang@linux.microsoft.com,
	akpm@linux-foundation.org,
	autonomouscodesecurity@microsoft.com,
	david@kernel.org,
	rppt@kernel.org,
	peterx@redhat.com,
	surenb@google.com,
	aarcange@redhat.com,
	tgopinath@linux.microsoft.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] userfaultfd: fix UFFDIO_MOVE livelock on large folio with extra references" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:26:13 -0500
Message-ID: <20261107052613-failed-6.12-454143aeb4c6@kernel.org>
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
git cherry-pick -x 454143aeb4c6c85ca7d50df36d1a66a64d88283e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052613-failed-6.12-454143aeb4c6@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 454143aeb4c6c85ca7d50df36d1a66a64d88283e Mon Sep 17 00:00:00 2001
From: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>
Date: Mon, 12 Oct 2026 16:15:14 -0400
Subject: [PATCH] userfaultfd: fix UFFDIO_MOVE livelock on large folio with
 extra references

To move one page out of a large folio, move_pages_ptes() first has to
split the folio.  __folio_split() refuses if the folio has any reference
beyond its page table mappings and the caller's own, and it reports the
refusal as -EAGAIN.  move_pages() treats returned -EAGAIN as a transient
race and keeps retrying the same address, holding the VMA read locks the
whole time.  This is incorrect since in some cases userspace can hold such
a reference indefinitely, such as by registering the page as an io_uring
buffer.

An unprivileged user can trigger this with three threads: first holds such
a reference on a page of a THP, second calls UFFDIO_MOVE on another page
of the same THP and spins in the kernel forever holding the VMA read
locks, and third calls fork() or mprotect(), which takes mmap_lock for
writing and then waits forever for those read locks.  From then on every
mmap_lock user of that mm hangs, including other processes inspecting it
through /proc/<pid>/, until the process is SIGKILLed.  The hung task
detector reports the blocked tasks (third one), and with
kernel.hung_task_panic=1 the machine panics:

  INFO: task wedge:95 blocked for more than 122 seconds.
  task:wedge  state:D stack:12528 pid:95 tgid:95 ppid:94
  Call Trace:
   __schedule+0x596/0x1110
   schedule+0x36/0xf0
   __vma_start_exclude_readers+0x100/0x170
   __vma_start_write+0x51/0xd0
   __split_vma+0x208/0x3d0
   vma_modify+0x6a8/0x840
   vma_modify_flags+0xce/0x110
   mprotect_fixup+0xbe/0x480
   do_mprotect_pkey+0x2d9/0x580
   __x64_sys_mprotect+0x1a/0x30

Fix by returning -EBUSY instead of -EAGAIN in move_pages_ptes(), the
caller of split_folio(), when the split fails.  Thus, move_pages() does
not retry -EBUSY and the ioctl drops its locks and returns to userspace
instead of spinning.

Link: https://lore.kernel.org/20261012201514.97015-1-cenzhang@linux.microsoft.com
Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
Signed-off-by: Cen Zhang (Microsoft) <cenzhang@linux.microsoft.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: <AutonomousCodeSecurity@microsoft.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Assisted-by: LLM
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: <tgopinath@linux.microsoft.com>
Cc: <stable@vger.kernel.org>
---
 mm/userfaultfd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 405f2d72f204e..669f71d485d02 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1635,8 +1635,12 @@ static long move_pages_ptes(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd
 			pte_unmap(dst_pte);
 			src_pte = dst_pte = NULL;
 			ret = split_folio(src_folio);
-			if (ret)
+			if (ret) {
+				/* do not retry, extra refs may be held forever */
+				if (ret == -EAGAIN)
+					ret = -EBUSY;
 				goto out;
+			}
 			/* have to reacquire the folio after it got split */
 			folio_unlock(src_folio);
 			folio_put(src_folio);
-- 
2.53.0




