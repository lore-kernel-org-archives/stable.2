Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799368;
	b=pewda4l+/ZxyI9FDA0K6WdFQ9weIqEdbRXCT957/Mf5oYvMzvuec2ND5e1vsm6S/NrtJ
	 Zqg7HKHkQAxfmVqHaYPuwN1jfPZgeHwW38TSs37pNFygS2LY6jWloTLwpQSGm+IskosAf
	 DQD78OMOg/xxAsYWY8frqfznkJOFIdlNhJZevN68kQEBZlF5Vp4ehVTBUa5SJP4/W9vOl
	 fqKz2xlBsEEPLciuVL9I+kru9/Ye1wPaivQmKBDYmHnvfaElOBx0IblWZSNrzgJ9MyIAS
	 RqONmwD2zVzi/C/nFHYKmSZwK/w0LLcz8Rp6jHlodW0hTsHctysw/uQ1twNaKrwRoxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799368;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=OUmV1OsF52Jx0UMGwnICGLj+MBuANNm8xRyXnRabIDc=;
	b=BkrLXo8BW7GcX4Xvf1sWPiGpVsv1I0j3yCvWnfsZl+sHxcj4ysFdisBFZAaNlpNjbWnH
	 PteZ1+QEPU3RW/cNK2KTTtlGAJaPNOu4aOaH6khLgeHBdT9DBvWCmld7G5pl8yQzx2uco
	 /nTm2KmgA2c86aUBGV2DFf+q6IqrYKINc/z3jYd8Y21e/+epFoH4e/on2dJ+pp590j7T/
	 1chYehjj6hFD0kFBfaTIJynczKKuF491YIhDQtGW3vJfPHGeQCx6+d/JbV6p/PUjPya4h
	 F1fs26GigYb9mPQoQxw0OBKBll35H5jL+4439upyZaQKnEhP3oVbiCchP1JOTVhRc1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=q8OONo8p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E743C606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 13:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=q8OONo8p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB8A1F00A02;
	Wed,  4 Nov 2026 13:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793799367;
	bh=OUmV1OsF52Jx0UMGwnICGLj+MBuANNm8xRyXnRabIDc=;
	h=Subject:To:Cc:From:Date;
	b=q8OONo8pezFLMHV9hpwOzYHwunMb1AaV1oDTkZlIRjYYSrr4EIKu1E5QHJ8WPcaUl
	 eMoaqSUdYnQX6N/FbOlhn8aYPBEV/lDgBV9emREiTZ0mz0iWAQf4Vu6xDII14DjGlV
	 edqAKLxn99bq9U8LJgxwCW6RRx3/bR4aA8wwmm4Y=
Subject: FAILED: patch "[PATCH] smb: client: fix use-after-free infoleak via the readdir" failed to apply to 5.10-stable tree
To: diego@bynar.io,dhowells@redhat.com,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:36:04 +0100
Message-ID: <2026110404-moonrise-gnarly-7268@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 59131dd72f62b198fc9ea1489ad9d3573154f684
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110404-moonrise-gnarly-7268@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 59131dd72f62b198fc9ea1489ad9d3573154f684 Mon Sep 17 00:00:00 2001
From: Diego Oliva <diego@bynar.io>
Date: Tue, 29 Sep 2026 10:16:30 +0100
Subject: [PATCH] smb: client: fix use-after-free infoleak via the readdir
 resume name

CIFSFindNext() copies the resume name that cifs_save_resume_key()
recorded from the last entry of the previous response into its request;
psrch_inf->presume_name points into the response buffer that entry came
from, and nothing ever clears it. find_cifs_entry() records a new
name only from a response with a usable last entry, and cifs_readdir()
only from an entry it walks to, so a response that carries no entries
and leaves last_entry NULL, because CIFSFindFirst() or CIFSFindNext()
rejected LastNameOffset, refreshes neither and presume_name keeps
pointing into the previous response. That buffer has already been
released: by CIFSFindNext() before it installs the new response, or by
find_cifs_entry() when it rewinds the search, which does not drop the
name either and can then fail in initiate_cifs_search() before a new
response replaces it. The next CIFSFindNext() then copies up to
PATH_MAX - 1 bytes of the resume name out of the released buffer into
its request and sends them to the server: a use-after-free read
that leaks kernel memory to a malicious or compromised server, which
can provoke it with a single FindNext response that carries no entries
and a LastNameOffset above CIFSMaxBufSize, which is all the existing
check rejects.

With KASAN enabled, a server that answers a listing that way gives:

 CIFS: VFS: ignoring corrupt resume name
 ==================================================================
 BUG: KASAN: slab-use-after-free in CIFSFindNext+0x8ca/0x14c0
 Read of size 4080 at addr ffff88807c823f98 by task ls/83

 CPU: 0 UID: 0 PID: 83 Comm: ls Tainted: G    B               7.3.0-rc4-00457-gf14572c203d5 #69 PREEMPT(lazy)
 Tainted: [B]=BAD_PAGE
 Call Trace:
  <TASK>
  kasan_report+0xdf/0x1a0
  kasan_check_range+0x10f/0x1e0
  __asan_memcpy+0x23/0x60
  CIFSFindNext+0x8ca/0x14c0
  cifs_readdir+0xf51/0x29c0
  iterate_dir+0x1c0/0x570
  __x64_sys_getdents64+0x133/0x270
  do_syscall_64+0x109/0x5d0
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
  </TASK>

 Allocated by task 83 on cpu 1 at 13.497119s:
  cifs_buf_get+0x36/0x90
  smb_init+0x4f/0x110
  CIFSFindNext+0xf7/0x14c0
  cifs_readdir+0xf51/0x29c0

 Freed by task 83 on cpu 0 at 13.584018s:
  cifs_buf_release+0x41/0x80
  CIFSFindNext+0xfce/0x14c0
  cifs_readdir+0xf51/0x29c0

 The buggy address is located 16280 bytes inside of
  freed 16588-byte region [ffff88807c820000, ffff88807c8240cc)
 ==================================================================

The same memcpy() first reads past the end of that object while it is
still live, a slab-out-of-bounds read that the following patches
bound; that is the taint the report above carries.

SMB1 is not negotiated by default; reaching this code requires an
explicit vers=1.0 mount.

Clear presume_name and resume_name_len whenever a new response is
installed and when the rewind path releases the search buffer, so that
the name never outlives the buffer it points into, and reset
resume_key with them, since it was taken from the same entry and would
otherwise be sent with an empty name. A response without a usable
last entry then continues the search with an empty resume name rather
than a stale one; CIFSFindNext() skips the copy of a zero-length name
so that it never runs on the NULL pointer.

The next patch in the series leaves last_entry NULL for a response
that carries no entries, and bounds LastNameOffset against the
received response rather than against CIFSMaxBufSize. Responses that
are given a last entry today then take the path fixed here, so that
patch must not be applied without this one.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: b77d753c413e ("[CIFS] Check that last search entry resume key is valid")
Cc: stable@vger.kernel.org
Assisted-by: Bynario AI
Signed-off-by: Diego Oliva <diego@bynar.io>
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 6dddbd84b93b..95f339f48ad7 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -4543,6 +4543,9 @@ CIFSFindFirst(const unsigned int xid, struct cifs_tcon *tcon,
 	psrch_inf->entries_in_buffer = le16_to_cpu(parms->SearchCount);
 	psrch_inf->index_of_last_entry = 2 /* skip . and .. */ +
 		psrch_inf->entries_in_buffer;
+	psrch_inf->presume_name = NULL;
+	psrch_inf->resume_name_len = 0;
+	psrch_inf->resume_key = 0;
 	lnoff = le16_to_cpu(parms->LastNameOffset);
 	if (CIFSMaxBufSize < lnoff) {
 		cifs_dbg(VFS, "ignoring corrupt resume name\n");
@@ -4607,7 +4610,10 @@ int CIFSFindNext(const unsigned int xid, struct cifs_tcon *tcon,
 	name_len = psrch_inf->resume_name_len;
 	params += name_len;
 	if (name_len < PATH_MAX) {
-		memcpy(pSMB->ResumeFileName, psrch_inf->presume_name, name_len);
+		if (name_len) {
+			memcpy(pSMB->ResumeFileName,
+			       psrch_inf->presume_name, name_len);
+		}
 		byte_count += name_len;
 		/* 14 byte parm len above enough for 2 byte null terminator */
 		pSMB->ResumeFileName[name_len] = 0;
@@ -4662,6 +4668,9 @@ int CIFSFindNext(const unsigned int xid, struct cifs_tcon *tcon,
 	psrch_inf->endOfSearch = !!parms->EndofSearch;
 	psrch_inf->entries_in_buffer = le16_to_cpu(parms->SearchCount);
 	psrch_inf->index_of_last_entry += psrch_inf->entries_in_buffer;
+	psrch_inf->presume_name = NULL;
+	psrch_inf->resume_name_len = 0;
+	psrch_inf->resume_key = 0;
 	lnoff = le16_to_cpu(parms->LastNameOffset);
 	if (CIFSMaxBufSize < lnoff) {
 		cifs_dbg(VFS, "ignoring corrupt resume name\n");
diff --git a/fs/smb/client/readdir.c b/fs/smb/client/readdir.c
index 9530e5b01564..6ab4e687c3e4 100644
--- a/fs/smb/client/readdir.c
+++ b/fs/smb/client/readdir.c
@@ -752,6 +752,9 @@ find_cifs_entry(const unsigned int xid, struct cifs_tcon *tcon, loff_t pos,
 			cfile->srch_inf.ntwrk_buf_start = NULL;
 			cfile->srch_inf.srch_entries_start = NULL;
 			cfile->srch_inf.last_entry = NULL;
+			cfile->srch_inf.presume_name = NULL;
+			cfile->srch_inf.resume_name_len = 0;
+			cfile->srch_inf.resume_key = 0;
 		}
 		rc = initiate_cifs_search(xid, file, full_path);
 		if (rc) {

