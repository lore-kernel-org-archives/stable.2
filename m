Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152603DF01C
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559935; cv=none; b=PWk8HVkvOYYlMi/pUE+P7mweDU4qZe+j3s00yNFdf7fEYXlUT+bwmoxKpkq01rBauMLjt2VwuBr7v7K+qfZOktf9a7qpU4/uKFVrJsxxDOosR2EIdTdpwSYoM4GaBbj+MHYPNVvefNEivMgaBBo0sHrGDkK3Tpslha9RkFMKueo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559935; c=relaxed/simple;
	bh=x6U4xUoacM0AddvxkOeVKNxmlNdKBqHFRFIwUonsCKU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=c6WYPV089lImKhPDyOS4sCxpopnyLpm59vpQywazHO82XPWxwynPz2LrzmRt0w5VpyHuYM31RhQdI1Pjr+44JekQU8mRO06qgmvk/nlLMo9AKmpEAekP49hI5t3ikqGC3MUJKDbqEY4qzX6BlYJMdB64Eg6h0tK8f4LqLy25unk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R63xYO/A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R63xYO/A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C581F000E9;
	Mon, 20 Jul 2026 15:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784559933;
	bh=krjsefMmOMJpXSB73RxbRS3QX/lxwF+TNw9hn+BTb/s=;
	h=Subject:To:Cc:From:Date;
	b=R63xYO/AcFx2bqfV7KwOaF+9jswFmimltp7LCeX8I9HV0mfV94Kbc1Uc+MG7TSrfl
	 oHin7NeFNuXEbG7mMd8M8ggeLOg0GGoTbamqxLoa53cH4BoXW1CRIYwmtyw9HF7DOI
	 vkqLnzyWok7vkwIujvW+4Y1ONIqjXs060vwB/lUs=
Subject: FAILED: patch "[PATCH] ksmbd: fix integer overflow in set_file_allocation_info()" failed to apply to 5.15-stable tree
To: security@auditcode.ai,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:05:24 +0200
Message-ID: <2026072024-headphone-posh-4ed4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1c0ae3df692ea2a4ce992f786346154e75a3f0d5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072024-headphone-posh-4ed4@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1c0ae3df692ea2a4ce992f786346154e75a3f0d5 Mon Sep 17 00:00:00 2001
From: Ibrahim Hashimov <security@auditcode.ai>
Date: Thu, 9 Jul 2026 17:05:30 +0200
Subject: [PATCH] ksmbd: fix integer overflow in set_file_allocation_info()

set_file_allocation_info() converts the client-supplied
FILE_ALLOCATION_INFORMATION::AllocationSize into a 512-byte block
count with:

	alloc_blks = (le64_to_cpu(file_alloc_info->AllocationSize) + 511) >> 9;

AllocationSize is a fully client-controlled __le64 field; the only
validation performed by the caller (smb2_set_info_file(), case
FILE_ALLOCATION_INFORMATION) is that the fixed buffer is at least
sizeof(struct smb2_file_alloc_info) == 8 bytes. The value itself is
never range-checked before this arithmetic.

When AllocationSize is close to U64_MAX (e.g. 0xffffffffffffffff),
"AllocationSize + 511" wraps around mod 2^64 to a small number
(0xffffffffffffffff + 511 = 510), so alloc_blks becomes 0. Since any
existing regular file has stat.blocks > 0, the function then takes
the "shrink" branch and calls:

	ksmbd_vfs_truncate(work, fp, alloc_blks * 512);   /* == 0 */

silently truncating the file to size 0, even though the client asked
to grow the allocation to (what looks like) the maximum possible
size. The trailing "if (size < alloc_blks * 512) i_size_write(inode,
size);" restore is guarded by a comparison that is never true once
alloc_blks == 0, so the truncation is not undone. This lets an
authenticated SMB client that already holds an open handle with
FILE_WRITE_DATA on a file silently truncate that same file to size 0
via a single crafted SET_INFO(FILE_ALLOCATION_INFORMATION) request
advertising a near-U64_MAX AllocationSize, even though the request
asks to grow the file's allocation rather than shrink it. This is a
functional/data-loss bug, not a privilege-boundary
violation: the same client could already truncate the file via
FILE_END_OF_FILE_INFORMATION or a plain write.

Fix it by validating AllocationSize against MAX_LFS_FILESIZE, the
same upper bound the VFS itself uses to reject unrepresentable file
sizes, before doing the "+511" rounding, and rejecting oversized
values with -EINVAL. Bounding AllocationSize to
MAX_LFS_FILESIZE - 511 guarantees the "+511" addition cannot wrap,
and that the subsequent "alloc_blks * 512" values passed to
vfs_fallocate() and ksmbd_vfs_truncate() stay within a representable
loff_t as well.

No legitimate SMB client asks for an allocation size anywhere near
2^64 bytes, so this only rejects a value that was previously
silently misinterpreted as zero.

Runtime-verified on a v6.19 KASAN test stand: sending SET_INFO
(FILE_ALLOCATION_INFORMATION) with AllocationSize = 0xffffffffffffffff
against ksmbd now returns -EINVAL and leaves the target file's size
unchanged, where the unpatched kernel truncated it from 4096 to 0
bytes.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
Assisted-by: AuditCode-AI:2026.07
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index b73167785e87..320b46db9377 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -6781,6 +6781,7 @@ static int set_file_allocation_info(struct ksmbd_work *work,
 	 */
 
 	loff_t alloc_blks;
+	u64 alloc_size;
 	struct inode *inode;
 	struct kstat stat;
 	int rc;
@@ -6796,7 +6797,19 @@ static int set_file_allocation_info(struct ksmbd_work *work,
 	if (rc)
 		return rc;
 
-	alloc_blks = (le64_to_cpu(file_alloc_info->AllocationSize) + 511) >> 9;
+	/*
+	 * AllocationSize is fully client-controlled (the caller only
+	 * validates the fixed 8-byte buffer length). Reject values that
+	 * would overflow the "round up to 512-byte blocks" conversion
+	 * below instead of silently wrapping it to a tiny block count,
+	 * which would truncate the file to a size the client never
+	 * asked for.
+	 */
+	alloc_size = le64_to_cpu(file_alloc_info->AllocationSize);
+	if (alloc_size > MAX_LFS_FILESIZE - 511)
+		return -EINVAL;
+
+	alloc_blks = (alloc_size + 511) >> 9;
 	inode = file_inode(fp->filp);
 
 	if (alloc_blks > stat.blocks) {

