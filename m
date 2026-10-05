Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476182D8379
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211605; cv=none; b=TRMdPwMPOZrwNnflJsZqt/a3r1yQII0/cVz6KCU4TzkSvX0w2IOkrzfFCU8zGPsC1anPmbslSoonQQd8uXcw0MAwSzb8O2UTnSKHFUsHnjw4SpQCasG8/2iEJBY29VVUUOowUjgZSAVx51EbptmZC8Pk1a9gjGU4HswI6uZSECM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211605; c=relaxed/simple;
	bh=AqgTXStSWGbvQVFbc84HV0Cb27ss8v01HKFvpHaWIAI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jreQZ8c81EwJtn/fSrrDWDDvrIrDgYsNRsCn4923B8RLOfInR9MPOeUp2RhV8H7yRuVLvff+GI+R0KDHZMTJsM0HffQZq8r7he9tz51afGb40Fz0G4rk3+WsAzDBxz7aFqzOrvzNOszzMBvcD2AEJ2MixfhG9dv4O8HH8OxQnYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xv41FxGz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xv41FxGz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DBBE1F00893;
	Mon,  5 Oct 2026 14:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791211596;
	bh=WvEXaZR7vlVCrBMHMOYEujjuZ/tLEcbnHpAqXIsB7A8=;
	h=Subject:To:Cc:From:Date;
	b=Xv41FxGzsbCRVbCpmrv47hyoIX8WDaeADFxk6MgL0pm2ASawRsOncfO5S32N7E3hw
	 oIIpzB9br/UPopU9hyMu7LUf5/ArMHk4tbw02bb4T0UyTqLpWv4/I186vQfhpWFzC/
	 jlzkbMI5Ov8Ve6mKpYSwfjCK1+KloH6UrpzDhUHI=
Subject: FAILED: patch "[PATCH] smb: client: flush and commit data before querying allocated" failed to apply to 5.10-stable tree
To: pc@manguebit.org,bharathsm@microsoft.com,brauner@kernel.org,dhowells@redhat.com,linkinjeon@kernel.org,ronniesahlberg@gmail.com,sprasad@microsoft.com,tom@talpey.com,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 16:46:26 +0200
Message-ID: <2026100526-pogo-quirk-5c78@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x aa994489bd835547c191827acc460192e147032d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100526-pogo-quirk-5c78@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From aa994489bd835547c191827acc460192e147032d Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.org>
Date: Fri, 25 Sep 2026 19:35:12 -0300
Subject: [PATCH] smb: client: flush and commit data before querying allocated
 ranges

The mode 0 / FALLOC_FL_KEEP_SIZE fallocate emulation for small interior
ranges in smb3_simple_fallocate_range() issues
FSCTL_QUERY_ALLOCATED_RANGES and zero-fills any sub-range the server
reports as an unallocated hole, to force block allocation without
changing file contents.

This is unsafe against Windows servers.  Per the Win32 documentation,
FSCTL_QUERY_ALLOCATED_RANGES only reports ranges that *may* contain
nonzero data and is explicitly not coherent with recently written data:

  "a call to FSCTL_QUERY_ALLOCATED_RANGES [after writing to a network
   file] would not necessarily return a correct list of allocated
   regions.  To ensure coherency [...] flush the data to the file"

fsx (generic/363) reproduces the resulting corruption against Windows
Server 2022: a range is written, an uncached read returns the data, yet
the next FSCTL_QUERY_ALLOCATED_RANGES on that range reports it as a whole
hole, so the emulation overwrites live data with zeroes.  A network trace
confirmed the WRITE, the READ returning data and the query returning an
empty range list within microseconds.  Samba does not exhibit this; its
query is coherent with the written data.

Write back the dirty pages, drain any outstanding I/O and issue an SMB2
FLUSH to force the server to commit the data before querying the
allocated ranges, so the query reflects the data actually present.

With this, generic/363 passes against both Windows Server 2022 and Samba
over 100000 fsx operations.

Fixes: 966a3cb7c7db ("cifs: improve fallocate emulation")
Reviewed-by: David Howells <dhowells@redhat.com>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Bharath SM <bharathsm@microsoft.com>
Cc: stable@vger.kernel.org

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 849cfd2de705..1c41d3b24c6d 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -3750,6 +3750,24 @@ static int smb3_simple_fallocate_range(unsigned int xid,
 		goto out;
 	}
 
+	filemap_invalidate_lock(inode->i_mapping);
+
+	/*
+	 * Flush and commit the data to the server, otherwise
+	 * FSCTL_QUERY_ALLOCATED_RANGES might report recently written data as
+	 * unallocated holes on Windows Servers, and the loop below would
+	 * then zero-fill them and corrupt the file.
+	 */
+	rc = filemap_write_and_wait_range(inode->i_mapping, off,
+					  off + len - 1);
+	if (rc)
+		goto out_unlock;
+	netfs_wait_for_outstanding_io(inode);
+	rc = SMB2_flush(xid, tcon, cfile->fid.persistent_fid,
+			cfile->fid.volatile_fid);
+	if (rc)
+		goto out_unlock;
+
 	in_data.file_offset = cpu_to_le64(off);
 	in_data.length = cpu_to_le64(len);
 	rc = SMB2_ioctl(xid, tcon, cfile->fid.persistent_fid,
@@ -3759,7 +3777,7 @@ static int smb3_simple_fallocate_range(unsigned int xid,
 			1024 * sizeof(struct file_allocated_range_buffer),
 			(char **)&out_data, &out_data_len);
 	if (rc)
-		goto out;
+		goto out_unlock;
 
 	tmp_data = out_data;
 	while (len) {
@@ -3769,12 +3787,12 @@ static int smb3_simple_fallocate_range(unsigned int xid,
 		if (out_data_len == 0) {
 			rc = smb3_simple_fallocate_write_range(xid, tcon,
 					       cfile, off, len, buf);
-			goto out;
+			goto out_unlock;
 		}
 
 		if (out_data_len < sizeof(struct file_allocated_range_buffer)) {
 			rc = -EINVAL;
-			goto out;
+			goto out_unlock;
 		}
 
 		range_start = le64_to_cpu(tmp_data->file_offset);
@@ -3782,7 +3800,7 @@ static int smb3_simple_fallocate_range(unsigned int xid,
 		if (check_add_overflow(range_start, range_len, &range_end) ||
 		    range_end > S64_MAX) {
 			rc = -EINVAL;
-			goto out;
+			goto out_unlock;
 		}
 
 		if (off < range_start) {
@@ -3797,11 +3815,11 @@ static int smb3_simple_fallocate_range(unsigned int xid,
 			rc = smb3_simple_fallocate_write_range(xid, tcon,
 					       cfile, off, l, buf);
 			if (rc)
-				goto out;
+				goto out_unlock;
 			off = off + l;
 			len = len - l;
 			if (len == 0)
-				goto out;
+				goto out_unlock;
 		}
 		/*
 		 * We are at a section of allocated data, just skip forward
@@ -3820,6 +3838,8 @@ static int smb3_simple_fallocate_range(unsigned int xid,
 		out_data_len -= sizeof(struct file_allocated_range_buffer);
 	}
 
+ out_unlock:
+	filemap_invalidate_unlock(inode->i_mapping);
  out:
 	kfree(out_data);
 	kvfree(buf);

