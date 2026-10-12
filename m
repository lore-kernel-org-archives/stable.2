Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E394E7807;
	Mon, 12 Oct 2026 20:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791836132; cv=none; b=nFTbUUAidBr5dZFkZD9f7/UB1TvU58GjZuuTbLJrHLJQaCHKt03KwNm4EgnqgM+hfRbtYdVnae+8x354JolmCpDRDnULsr1gZufPXfzda5XAMYgpr6S3KHcuBBBpSfHk6ch2olH+TbRnswIODQhMQaJDusvI58Ap/HedsZZhxf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791836132; c=relaxed/simple;
	bh=tTVHVkVcv+la1edaxZDL80B63dWguM2dX9eUL9oDyl0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=blBtJGfpx6u9YHcsefomfxg4wal21rW8FUqvMP6DhrHqEaSadwnqBMwNfRQbFfuSSXXdUW3zQX2NrR0eWmy8njYfaCTp7aeP1HA5reDU3hMhnGXd/7MVwZflNnnqKYZnuXAW8MFu4gwoUB36kBErmUR9/UuJPmtstNjzhTCSROY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=f7fN/SJa; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="f7fN/SJa"
Received: from mac.lan (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id BC0FD20B7166;
	Mon, 12 Oct 2026 13:15:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BC0FD20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791836126;
	bh=/Jjp0/gGGD1R8hah3x3vcyoIOYd0SLonWaZGlFpBVzw=;
	h=From:To:Cc:Subject:Date:From;
	b=f7fN/SJaeBrD6ryMhc1A8CdHsRQsj5TeJyVJCm/h/gqumLVE1HBcJI++s6ocOTDZ9
	 GDr24FY9OxuSCX3Fmzs70Bx4moJopzZ/A5DB7wSmWDFBtXlLgWMI3Yu5b7GSJRWdnt
	 If10IRPgNtDftDcQcVphI1sj3VPP9Y6dmHfRyIXA=
From: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>
Cc: Peter Xu <peterx@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	Cen Zhang <cenzhang@linux.microsoft.com>
Subject: [PATCH] userfaultfd: fix UFFDIO_MOVE livelock on large folio with extra references
Date: Mon, 12 Oct 2026 16:15:14 -0400
Message-ID: <20261012201514.97015-1-cenzhang@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To move one page out of a large folio, move_pages_ptes() first has to
split the folio.  __folio_split() refuses if the folio has any
reference beyond its page table mappings and the caller's own, and it
reports the refusal as -EAGAIN.  move_pages() treats returned -EAGAIN
as a transient race and keeps retrying the same address, holding the VMA
read locks the whole time.  This is incorrect since in some cases
userspace can hold such a reference indefinitely, such as by
registering the page as an io_uring buffer.

An unprivileged user can trigger this with three threads: first holds
such a reference on a page of a THP, second calls UFFDIO_MOVE on another
page of the same THP and spins in the kernel forever holding the VMA
read locks, and third calls fork() or mprotect(), which takes mmap_lock
for writing and then waits forever for those read locks.  From then on
every mmap_lock user of that mm hangs, including other processes
inspecting it through /proc/<pid>/, until the process is SIGKILLed.
The hung task detector reports the blocked tasks (third one), and with
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
caller of split_folio(), when the split fails. Thus, move_pages()
does not retry -EBUSY and the ioctl drops its locks and returns to
userspace instead of spinning.

Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
Reported-by: AutonomousCodeSecurity@microsoft.com
Assisted-by: LLM
Signed-off-by: Cen Zhang (Microsoft) <cenzhang@linux.microsoft.com>
---
 mm/userfaultfd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 74f04c323c50..500962be1162 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1663,8 +1663,12 @@ static long move_pages_ptes(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd
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
2.55.0

