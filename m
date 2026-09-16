Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BA54C33EF
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577237; cv=none; b=CXxpq5ak59E54YDfXuAy2/jgxI0mP2Szizndwem7WOGemzqTc3eUzkE+hROIhAsGEYxQDSkJRp3MNcz/Y5MQFM7lMP6KRIOs0f2xTvBE2U2zzTDMrMPODWzRUFa9mdW7GRtd1A84YdJR7fRf5nKWVspWXQO0nqHvSAQas/BLVkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577237; c=relaxed/simple;
	bh=BVVJ+f4rNbR2qSbgEC1bu3ajjeoVfOFXFqdgYEziENU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PLk6xjLDpHUIITWyHrBJsX3Ia53zjfb7MhGJXLWD5K2V6vb/P5ympMmKv23hJH1GsYwP0TlbAxQ4OQTHwYadDGtsK0I/TLqtnSv/FjuCgwZx3oYCXy4uHLbYDB5j11d5utY9uoyVAlL2UyjpJfGwnZIANoetLlIyz1DOk/eWeRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rqQ88zNY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rqQ88zNY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8266C1F0089A;
	Wed, 16 Sep 2026 16:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789577229;
	bh=QPuSxshz/A23FHMqa0CCmAnf2iUq4p409t0bM9G2nB8=;
	h=Subject:To:Cc:From:Date;
	b=rqQ88zNYZCW9Jf7rguqzBBQ92giz99qeMVgIYKb5u6xIvua4lHTb5uZX6alowe7tg
	 Hrk2jT4XSpPsuIwxSTTKl4KQiOle/mbK626FY0XgL4U6aVL7C6poWol3KLf7r/iHg1
	 fMK8VQi7tXK/i6VgZvounZ0U1SGUudaDu15HN9Mo=
Subject: FAILED: patch "[PATCH] smb: client: reject short READ responses in CIFSSMBRead()" failed to apply to 5.10-stable tree
To: diego@bynar.io,dhowells@redhat.com,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 17:40:06 +0100
Message-ID: <2026091606-quickstep-handstand-fba1@gregkh>
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
git cherry-pick -x e6142a8bfc230c7263eb8b0475249c958ce49367
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091606-quickstep-handstand-fba1@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e6142a8bfc230c7263eb8b0475249c958ce49367 Mon Sep 17 00:00:00 2001
From: Diego Oliva <diego@bynar.io>
Date: Wed, 2 Sep 2026 11:42:06 +0100
Subject: [PATCH] smb: client: reject short READ responses in CIFSSMBRead()

CIFSSMBRead() reads DataLengthHigh, DataLength and DataOffset out of
the READ_RSP returned by the server without first checking that a
whole READ_RSP was actually received. The length of the response is
recorded in rsp_iov.iov_len, but nothing constrains it to be at least
read_rsp_size before those fields are dereferenced.

A malicious or compromised SMB1 server can return a response shorter
than the READ_RSP header, so that parsing the header itself reads past
the end of the receive buffer. SMB1 is not negotiated by default;
reaching this code requires an explicit vers=1.0 mount.

Reject the response unless it is at least read_rsp_size bytes long.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Suggested-by: Paulo Alcantara <pc@manguebit.org>
Cc: stable@vger.kernel.org # 6.19.x
Assisted-by: Bynario AI
Signed-off-by: Diego Oliva <diego@bynar.io>
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index f8aa9e7b4bc6..be13ab37039d 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -1719,6 +1719,14 @@ CIFSSMBRead(const unsigned int xid, struct cifs_io_parms *io_parms,
 	pSMBr = (READ_RSP *)rsp_iov.iov_base;
 	if (rc) {
 		cifs_dbg(VFS, "Send error in read = %d\n", rc);
+	} else if (rsp_iov.iov_len < tcon->ses->server->vals->read_rsp_size) {
+		/* check that the received response can hold a whole READ_RSP */
+		cifs_dbg(FYI, "%s: server returned short header. got=%zu expected=%zu\n",
+			 __func__, rsp_iov.iov_len,
+			 tcon->ses->server->vals->read_rsp_size);
+		rc = smb_EIO2(smb_eio_trace_read_rsp_short,
+			      rsp_iov.iov_len, tcon->ses->server->vals->read_rsp_size);
+		*nbytes = 0;
 	} else {
 		int data_length = le16_to_cpu(pSMBr->DataLengthHigh);
 		data_length = data_length << 16;

