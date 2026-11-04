Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802847;
	b=3wGH1dOKzPGV+ZwuMiNv8netUAbl5VugpPrZbwOsXMgTc4M7c8EBfERT4wMnU7GT0N6X
	 dtnhx4wrtRRY8loYdjKE2HEKmsL/eJdLeG572qqeo9d1JhBKYQplsLk7EVCy+ra/uSlKq
	 GZ/ihwTI4vNSRezFosen6jP39SxoKZYeMsduh0ifn39XKT/xbViGBOmuNgxhEeG0+YYll
	 lwN0LDchJ5appNOzYMnXmoqpGURJ6dCgxktej/TjNkqwhC2KFTmieD17dlA2x5535nUMt
	 fzlIkaU7sxEOXGkoM7D1XUbQwUMpHibFDP8FQYp9wji038O4VJ9pMLHQFFDsKL62+wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802847;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=jSQkROlsCIFefi4e0uwODPsSf78dKKCA2mL801Uk6gc=;
	b=nfUZIaebg6P2YtFWxSDcTFrWBhb/sJtVwdYJ7Nn0/K5VhXpfo4ojQLqQRRyiCppfZN0T
	 rYm4Fqlal4ljo5iAoRH2HKdd320pIb9ihk6pU1n2Boti9rUfp+/5JaHoVNmnW4ux3JZbe
	 WYHt6AzC0jxl2sWeTCQGzGdvf/3gzvzFgkLvtPNGw72rMj5UillLa0y3FurON4P/lRlDy
	 hanwGOtshRXQxsKECBn7XGDLh6UZ1Tlc5LTwyxF8gbkg0dvmxntnBQZ87PFeUXXf+hp9f
	 opifO8C1MFaDQEHIVWQC62shHjMZKbM9+B1RXAAJNwQQFcVPp8uODxTKSv0cxFDaSLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=dbxWsvxx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A53606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=dbxWsvxx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C321F00919;
	Wed,  4 Nov 2026 14:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793802847;
	bh=jSQkROlsCIFefi4e0uwODPsSf78dKKCA2mL801Uk6gc=;
	h=Subject:To:Cc:From:Date;
	b=dbxWsvxxUcheA5vamAfoJm+8hWp/oOWfxjoHge5AeVwEJa/lwOWjwZMtS4m6X7DAP
	 rC0PQVhlKk2VLlksA/K2+9lY7hbv7AsY/cf8umJ4akg4F/7CTkJ3R7FcSVF26S8AxH
	 dGdugWGVrXy2AJtFzWp22PhEKlIvVJ9SfC2b36yQ=
Subject: FAILED: patch "[PATCH] smb: client: fix OOB last_entry pointer from unbounded" failed to apply to 6.1-stable tree
To: diego@bynar.io,dhowells@redhat.com,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:34:05 +0100
Message-ID: <2026110405-silent-unveiling-d1c7@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 570c783a96f054dd3ac409a92772e9afb705d21c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110405-silent-unveiling-d1c7@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 570c783a96f054dd3ac409a92772e9afb705d21c Mon Sep 17 00:00:00 2001
From: Diego Oliva <diego@bynar.io>
Date: Tue, 29 Sep 2026 10:16:31 +0100
Subject: [PATCH] smb: client: fix OOB last_entry pointer from unbounded
 LastNameOffset

CIFSFindFirst() and CIFSFindNext() locate the last entry of a
TRANS2_FIND_FIRST2 or TRANS2_FIND_NEXT2 response by adding the
LastNameOffset of the response parameters to the start of the data
area, and store the result in psrch_inf->last_entry. MS-CIFS 2.2.6.2.2
defines that offset as the offset of the entry's file name; the client
follows the reading of NT and Samba servers, which point it at the
entry. LastNameOffset is only checked against CIFSMaxBufSize, which
says nothing about the response actually received: validate_t2() lets
the data area start up to 1024 bytes into the buffer, and SendReceive()
copies at most CIFSMaxBufSize + MAX_CIFS_HDR_SIZE bytes of a response,
16468 by default, into a cifs_request allocation of CIFSMaxBufSize +
MAX_SMB2_HDR_SIZE bytes, 16588 by default. The pointer itself can
therefore be placed anywhere from the end of the received data to 820
bytes past the end of the allocation.

The read through that pointer is far larger than its displacement.
find_cifs_entry() hands last_entry to cifs_save_resume_key() after every
FindNext and after the FindFirst of a search rewind, and
cifs_fill_dirent() takes the length of the name from the entry itself: a
__le32 FileNameLength for most levels, a __u8 for
SMB_FIND_FILE_INFO_STANDARD, and for SMB_FIND_FILE_UNIX the result of a
scan for the terminating NUL over up to PATH_MAX + 1 UTF-16 units. The
name is recorded as the resume name of the search, and the next
CIFSFindNext() rejects only a recorded length of PATH_MAX or more before
copying the name into the ResumeFileName of its request and sending it
with the resume key taken from the same entry: up to 4 KiB of memory
from past the end of the allocation leaks to the server, and for
SMB_FIND_FILE_UNIX the NUL scan runs about twice as far before the
length is even known. The entry does not have to lie outside the
response for that either: a maximal response ends about 120 bytes before
the end of the allocation, so an entry in its last bytes with a name
just under PATH_MAX has nearly all of that name copied from past the
allocation.

It needs nothing unusual from the client: a FindNext response that
reports no entries and does not end the search makes find_cifs_entry()
send the next FindNext at once, carrying whatever was parsed at
LastNameOffset, and a search rewind can do the same after its
FindFirst. SMB1 is not negotiated by default: this takes a malicious
or compromised server, a mount of it with an explicit vers=1.0, which
CONFIG_CIFS_ALLOW_INSECURE_LEGACY (default y) permits, and a directory
listing on that mount.

With KASAN enabled, a response that places the last entry past the
buffer, with a large DataOffset and a LastNameOffset near the end of
its range, gives:

 ==================================================================
 BUG: KASAN: slab-out-of-bounds in cifs_save_resume_key.isra.0+0x7aa/0x7f0
 Read of size 4 at addr ffff88807b55c33b by task ls/83

 CPU: 1 UID: 0 PID: 83 Comm: ls Not tainted 7.3.0-rc4-00457-gf14572c203d5 #69 PREEMPT(lazy)
 Call Trace:
  <TASK>
  kasan_report+0xdf/0x1a0
  cifs_save_resume_key.isra.0+0x7aa/0x7f0
  cifs_readdir+0x1ed6/0x29c0
  iterate_dir+0x1c0/0x570
  __x64_sys_getdents64+0x133/0x270
  do_syscall_64+0x109/0x5d0
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
  </TASK>

 Allocated by task 83 on cpu 0 at 19.317556s:
  cifs_buf_get+0x36/0x90
  smb_init+0x4f/0x110
  CIFSFindNext+0xf7/0x14c0
  cifs_readdir+0xf51/0x29c0

 The buggy address belongs to the object at ffff88807b558000
  which belongs to the cache cifs_request of size 16588
 The buggy address is located 623 bytes to the right of
  allocated 16588-byte region [ffff88807b558000, ffff88807b55c0cc)
 ==================================================================

The four bytes read there are the FileNameLength of the entry, which
cifs_fill_dirent() takes before anything checks where the entry lies.

Ignore the last entry when it does not start inside the received
response or the response holds no entries; for a response without
entries, last_entry pointed into or past its empty data area and
cifs_save_resume_key() parsed whatever the buffer held there. The
entry is bounded by the response that was received, which is what the
buffer holds, rather than by the data area the response declares,
which a later patch checks against the received length. Record the
search handle before the last entry is examined, since a response
without a usable last entry still carries the handle that the search
is continued and closed with; leaving the assignment in the else
branch would drop the handle of every response without entries.

This bounds where the last entry starts, not how far it is parsed: an
entry that starts within the final bytes of the response still has
its fixed part read past the end of the received data and its name,
up to 4095 bytes, copied from past the end of the allocation, until
the following patch bounds the parse itself. A response without a
usable last entry continues the search with an empty resume name,
since the preceding patch, "smb: client: fix use-after-free infoleak
via the readdir resume name", drops the recorded name whenever a new
response is installed. This patch applies on top of that one and
relies on it: without it, every response rejected here would leave
the previous name in place, pointing into a buffer that has been
released.

A conforming server is not affected: the last entry lies inside the
data area of the response.

Fixes: 0752f1522a91 ("[CIFS] make sure we have the right resume info before calling CIFSFindNext")
Fixes: b77d753c413e ("[CIFS] Check that last search entry resume key is valid")
Cc: stable@vger.kernel.org
Assisted-by: Bynario AI
Signed-off-by: Diego Oliva <diego@bynar.io>
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 95f339f48ad7..d8b1740b50fa 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -4546,14 +4546,17 @@ findFirstRetry:
 	psrch_inf->presume_name = NULL;
 	psrch_inf->resume_name_len = 0;
 	psrch_inf->resume_key = 0;
+	if (pnetfid)
+		*pnetfid = parms->SearchHandle;
 	lnoff = le16_to_cpu(parms->LastNameOffset);
-	if (CIFSMaxBufSize < lnoff) {
+	if (!psrch_inf->entries_in_buffer) {
+		psrch_inf->last_entry = NULL;
+	} else if (psrch_inf->srch_entries_start + lnoff >=
+		   psrch_inf->ntwrk_buf_start + bytes_returned) {
 		cifs_dbg(VFS, "ignoring corrupt resume name\n");
 		psrch_inf->last_entry = NULL;
 	} else {
 		psrch_inf->last_entry = psrch_inf->srch_entries_start + lnoff;
-		if (pnetfid)
-			*pnetfid = parms->SearchHandle;
 	}
 	return 0;
 }
@@ -4672,7 +4675,10 @@ int CIFSFindNext(const unsigned int xid, struct cifs_tcon *tcon,
 	psrch_inf->resume_name_len = 0;
 	psrch_inf->resume_key = 0;
 	lnoff = le16_to_cpu(parms->LastNameOffset);
-	if (CIFSMaxBufSize < lnoff) {
+	if (!psrch_inf->entries_in_buffer) {
+		psrch_inf->last_entry = NULL;
+	} else if (psrch_inf->srch_entries_start + lnoff >=
+		   psrch_inf->ntwrk_buf_start + bytes_returned) {
 		cifs_dbg(VFS, "ignoring corrupt resume name\n");
 		psrch_inf->last_entry = NULL;
 	} else {

