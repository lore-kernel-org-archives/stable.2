Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2A3551987
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090059; cv=none; b=ZCCEAatTYz+MX/fdSz8WSBt6CSbsdmry3jDlICZpuLP6LFdhsB47XbSd++9jM1kEVoCAM33jb62s6BUffTLL1qVDv5WFmevSwMnos32JIKi8bq7SciM4kJzbESi5HRt7NrG49ypceQa54Pu7III6cAUkqVs0Xme98foyV0TkrkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090059; c=relaxed/simple;
	bh=+2wsvXErNYpZ+/xU7EIboYL3jB0tbiatArYS038mJFw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZoNmU8ymMGIAUfmqze354zFC0ytMHnvAR5npgYVCel/d+9tXumxN4dzjx8GetxfC0exAstOv5DPqK8DdNCpJzJhGNtFKBMJ62UHvVCcPjSzf3HvC8P9DUTV/ku74MgdzVCrwkkEdfpkkvoVkoaBuK+7e50+qlMRALlYmVKsoqo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RoDCSlXS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RoDCSlXS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF781F000FF;
	Tue, 22 Sep 2026 15:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790090058;
	bh=oCDjxJRTF0LZACHp0pWs5gSrPJR/zq5fJgcyst7RvRA=;
	h=Subject:To:Cc:From:Date;
	b=RoDCSlXS28pvlinYl1Dewubg6on0/ETnC1/aoqD63mBj1ieguiq4Z/AbbpQtXaXVY
	 dD3fW/eyD56ove8QWD9SS0lxnClGwGrvznbCN276mKicBT6nbrxuKCzDS8SrAoyQBh
	 ok98ODa1zFplqz5dY3fDgzIOYBM9ecbahqIUHZJc=
Subject: FAILED: patch "[PATCH] smb: client: fix reparse buffer bounds in" failed to apply to 6.12-stable tree
To: sorenson@redhat.com,dhowells@redhat.com,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 17:07:58 +0200
Message-ID: <2026092258-electable-undoing-fab9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 5f0306e731e2f46e91419eae57eee3a241c055e0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092258-electable-undoing-fab9@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5f0306e731e2f46e91419eae57eee3a241c055e0 Mon Sep 17 00:00:00 2001
From: Frank Sorenson <sorenson@redhat.com>
Date: Wed, 16 Sep 2026 16:34:00 -0500
Subject: [PATCH] smb: client: fix reparse buffer bounds in
 cifs_query_reparse_point()

In cifs_query_reparse_point(), the start >= end check before casting to
struct reparse_data_buffer * only ensures the start pointer is within the
response. It fails to verify that there is enough space remaining for the
fixed 8-byte header of the structure.

If a server provides a DataOffset that leaves less than 8 bytes remaining,
the check passes, but subsequent reads of ReparseTag and ReparseDataLength
will occur out-of-bounds.

Fix this by ensuring the remaining space is at least the size of the
reparse_data_buffer structure before accessing its fields.

Fixes: 56e84c64fc25 ("cifs: Fix validation of SMB1 query reparse point response")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index f9aff0712794..6dddbd84b93b 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -3080,7 +3080,7 @@ int cifs_query_reparse_point(const unsigned int xid,
 
 	end = 2 + get_bcc(&io_rsp->hdr) + (__u8 *)&io_rsp->ByteCount;
 	start = (__u8 *)&io_rsp->hdr.Protocol + data_offset;
-	if (start >= end) {
+	if (start >= end || (size_t)(end - start) < sizeof(*buf)) {
 		rc = smb_EIO2(smb_eio_trace_qreparse_data_area,
 			      (unsigned long)start - (unsigned long)io_rsp,
 			      (unsigned long)end - (unsigned long)io_rsp);

