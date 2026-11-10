Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331896;
	b=4PHakKC71eco2NCmAPrJZe1r5gFIAsnoicrp+lX9C1bjvIZkGSr8H5jMEHQrPSElhYPn
	 67c18HSGUb5RkeYle15OPuxsVF3KVpuhJ8/kM0UpM/r34CsQTR+50ZgCPW4OG+ehCV6de
	 6nbTYv+VcRNVQnn746b4+bhoZv25GyIFSKKmhX0s5wKucoBX3Y94wYxmG5LEpjcH4aFZ6
	 vrEol1DuQueEslzvTqo3I10u9ekIyyYcCmiF7+JfLVtUhiS7XGlKK2rIWyANGvcJxF3Ay
	 WjEH3n2rzfBylay7P0+A7xtruWvW7B4Ugj9ZV1agxKWJ2XWwpWGVQRz15dQCItV1L7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331896;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Mk4WlG+NodPwapzSAKQzovJndQsKAR3vq0I/kLzROXo=;
	b=qoAcnDXBNCGZFtCwaBGBhuFH98YGUx0c2Qir9WoW8klYqBb28Eecm5icdG5nRRQhNPjL
	 eMpZmFf+bnZh/ayd3fNMsGGoFwMssqHchEg17q1RR0zowDLKFKrs8bQvJZx9MvdRrrhs0
	 5JoJMOCL176RNf33THKUtmltkRX8Hx1AMH3J0kwHgt9Vzl/ED3YZtI+bKTRUpIj2iby4a
	 VpEOL9Zd3I+WJiu223jMLT3QkHHYRcuIQcbTx4AiskYjeQpiUAEC99XF05KnKKYqqxJYg
	 hJYjbnNSRFdwizJhB643OH3lAwDChJqiyNmsJvTAZ24TFxLZbGPCIphng42pdO7+x/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GXESnRys;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE62606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GXESnRys
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008AF1F0089F;
	Tue, 10 Nov 2026 17:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794331896;
	bh=Mk4WlG+NodPwapzSAKQzovJndQsKAR3vq0I/kLzROXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GXESnRysGbZVwWza4btZjohDJa9iYwcYlaQ6pKONAHO8TVttgb3UXyjI/+XONNSZS
	 mgsUZUyr4PSUyw90g8mMONgatLUeIL64YXQFsd5WBH6nPDU39PE8DW7HtJ1J1e1DV0
	 IlwIWrADeslpxyGTAOYytckQAdCkLvXRXTcKNXU3nYGFt4qHoZzvlV8BVCTpKAtLb3
	 T3unAy6Y/wHF/Ob6SENr0lk7934ZVorHpGxIwR8a3fSsAVozBHN3pvgePzRycuFVBQ
	 WY5dqtPWQv1Js3omiZHFPiY87Z9xPPQ0xaKv54qW+72I1+VIg1eGTTfYuG7vFMdKSr
	 HaFAI/vz9b6Gg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	AutonomousCodeSecurity@microsoft.com,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Peter Xu <peterx@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	tgopinath@linux.microsoft.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] userfaultfd: fix UFFDIO_MOVE livelock on large folio with extra references
Date: Tue, 10 Nov 2026 12:31:33 -0500
Message-ID: <20261110173115.2915038-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052613-failed-6.12-454143aeb4c6@kernel.org>
References: <20261107052613-failed-6.12-454143aeb4c6@kernel.org>
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

From: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>

[ Upstream commit 454143aeb4c6c85ca7d50df36d1a66a64d88283e ]

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
[ sashal: Adapted upstream’s ret variable to the local err variable in move_pages_pte(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/userfaultfd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 9951b4f42c65a..e2cb788e6ad89 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1323,8 +1323,12 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 			pte_unmap(dst_pte);
 			src_pte = dst_pte = NULL;
 			err = split_folio(src_folio);
-			if (err)
+			if (err) {
+				/* do not retry, extra refs may be held forever */
+				if (err == -EAGAIN)
+					err = -EBUSY;
 				goto out;
+			}
 			/* have to reacquire the folio after it got split */
 			folio_unlock(src_folio);
 			folio_put(src_folio);
-- 
2.53.0

