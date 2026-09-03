Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FFF4B0CA4
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443362; cv=none; b=pflzfIAmsJwZPC3mu62ss9npTIJi7ZeJGkxS9OHg7ucXNEVltCrfmE0HtBvM2K1gViJGITNXCVHSx9RNMk8QQP3jr5RXi0UjdGA5j1uxhvuHyGTNZS/7CNrDCCzxIxHZvPE6n+Mnp3ngbC8dRt8GiIy4LmCRgRv5cpaGIehdM/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443362; c=relaxed/simple;
	bh=VQ2/Zm+YWOkoPlodTaY+lIAbI0ARUIb+8Jgway9dT7U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KIB98QJTIEpowEWpfHVhdfIZ8ql5YtB8ynKSrtrIW174U45x5+0HgxdstzbYpq1RNcDNTWu8iVbqNjYVLx6Q7qjc33gtt+SaxYxq1RrJv2Dr9vd7JcLp718xIFlnRhyZb7t+KPOj8gysDlU0WsH9WnYIyGTeWLVIhTCpJ1WTIRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2tNJ2kqR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2tNJ2kqR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963381F00ACA;
	Thu,  3 Sep 2026 13:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788443350;
	bh=Ki/xiqw4ApMNdb9N0k7UlHxhFO8dPyNgp9akPIHZacQ=;
	h=Subject:To:Cc:From:Date;
	b=2tNJ2kqRcIadEvYdUtQse2NjsvJOM+4Y6rUd5HYUWzs/dcdvC1mIwIDscPZEmPirc
	 eHZqCFaDzRoPjS+NvO1YgPx3uuVmV+XPoiyR/Q0zOArKCnlAeU6DOFQVybKEhkaTQe
	 lxXefxYgjJyja72IeEIMXC8CbnmPxuqce6+rCnzo=
Subject: FAILED: patch "[PATCH] smb: client: fix use-before-check of ReparseDataLength in" failed to apply to 6.6-stable tree
To: sorenson@redhat.com,linkinjeon@kernel.org,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:27:14 +0200
Message-ID: <2026090314-shower-guileless-2d4c@gregkh>
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
git cherry-pick -x 05f78e6cf34ea3a285053bd5999e08e8ac298bd5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090314-shower-guileless-2d4c@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 05f78e6cf34ea3a285053bd5999e08e8ac298bd5 Mon Sep 17 00:00:00 2001
From: Frank Sorenson <sorenson@redhat.com>
Date: Mon, 17 Aug 2026 12:16:57 -0500
Subject: [PATCH] smb: client: fix use-before-check of ReparseDataLength in
 reparse_buf_ptr()

reparse_buf_ptr() reads buf->ReparseDataLength before checking that
count covers the full fixed header:

    buf = (struct reparse_data_buffer *)((u8 *)io + off);
    len = sizeof(*buf);                          /* 8 bytes */
    rdlen = le16_to_cpu(buf->ReparseDataLength); /* offset 4, 2 bytes */

    if (count < len || count < rdlen + len)      /* check comes after */

struct reparse_data_buffer has ReparseDataLength at offset 4.  If a
server returns OutputCount < 6, the read at offset 4-5 reaches past
the end of the received data.  The off+count bounds against iov_len
were already validated, but that does not protect against count being
smaller than sizeof(*buf).

Split the check: verify count >= sizeof(*buf) before reading
ReparseDataLength, then verify count covers the data region.

Fixes: a158bb66b137 ("smb: client: optimise reparse point querying")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index bcaa44814b71..98ea5c6c34af 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -41,9 +41,11 @@ static struct reparse_data_buffer *reparse_buf_ptr(struct kvec *iov)
 
 	buf = (struct reparse_data_buffer *)((u8 *)io + off);
 	len = sizeof(*buf);
-	rdlen = le16_to_cpu(buf->ReparseDataLength);
+	if (count < len)
+		return ERR_PTR(smb_EIO2(smb_eio_trace_reparse_rdlen, count, 0));
 
-	if (count < len || count < rdlen + len)
+	rdlen = le16_to_cpu(buf->ReparseDataLength);
+	if (count < rdlen + len)
 		return ERR_PTR(smb_EIO2(smb_eio_trace_reparse_rdlen, count, rdlen));
 	return buf;
 }

