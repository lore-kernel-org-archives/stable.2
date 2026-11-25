Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598806;
	b=lPuR8qrde99lhqf5SgLKfwmVd93IP0OqvMJQqUgJ0o7qaNvRJsNcMROlZQFsy6wi17OC
	 nFtjoGwFp6TAUtnhh7+IkTa2+5+MpnyQYJw5A9y5Q5Ffq3wNZ9zMy/fOw6YZAwkz93Pve
	 ZIJmdtMa1Z8QRKEKsMDHc9Dzp3/KWupWkAcoyp7G5d3qW4aAClXuWlykVGzNgtSmJ2q+o
	 o7dvudPeiKzmMc0F17ul3FuNOOZ3RXkhYOlNwx3odGbsfnag+gWgn8Co9RmidpSTDi9KV
	 Am+DBkn5QOFktyz3Qo1xKtaXeVN1QOe2CjD3BKi5mbhppkFSH2mSbi/GjxxDtC4zRhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598806;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XcGJzwiACgQxC5aRTaIc7c7VOPrKC5746a9mLBdLJJE=;
	b=Xhb9R4oReI9ZskHKEY63LS8BzWQQT92v7J/edhwvX/6mLWzNLF07ERX8ZCf0fj6iq1gz
	 hbVzFVXvGkNyzanSEuQNxT20kHkVTrDKEz1yOLpU4Z+pdh/V3IL+xEt0ZzLjuXovhIhSA
	 Da5kHefHagkhh/bZjno5Kq7/rfZFTjpOgLtRgTjUZrK/WaPPCOgOM7PmG9NE5+D80Ytd7
	 Qax0t6SiNRcDOWXrNTcUFCv8lvZYOMmdgLhCGwzt0xGcAJMoYGD2qOXiRWp9fLg3RZVmw
	 doSm6Civzt/eRvs7EKIhS68tAk4LvI1b5aDx4c3vctDbLYR71h9U5OaYWCNqTzHSnrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=x5YgNUBZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62810606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=x5YgNUBZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CFBC1F000C0;
	Wed, 25 Nov 2026 09:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795598806;
	bh=XcGJzwiACgQxC5aRTaIc7c7VOPrKC5746a9mLBdLJJE=;
	h=Subject:To:Cc:From:Date;
	b=x5YgNUBZltrDrZydZ4oMF56zuOIW0kT8pxBy5EEyPZFaLyp7MeOwtQY6MFDIcEI0Z
	 u0pYX/hV8g0kJtdLkh3U8oJ2IDwjlZ4izjBTlUDI12LHlAME9rgGlPQtO2hIvW3ogU
	 gWnD4tmdLEMInn9Y2BiFkm1NtEzyVVmU1o9Biwfo=
Subject: FAILED: patch "[PATCH] fs/splice: clamp an over-reported write_iter result" failed to apply to 5.10-stable tree
To: teel4res@gmail.com,brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 10:20:46 +0100
Message-ID: <2026112546-remedial-underdog-3741@gregkh>
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
git cherry-pick -x 2d956723e82cddae8ff8e9da99a666217b02065f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112546-remedial-underdog-3741@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2d956723e82cddae8ff8e9da99a666217b02065f Mon Sep 17 00:00:00 2001
From: Cheng Yongkang <teel4res@gmail.com>
Date: Thu, 29 Oct 2026 07:12:20 -0700
Subject: [PATCH] fs/splice: clamp an over-reported write_iter result

iter_file_splice_write() builds a bvec iterator of at most
sd.total_len - left bytes and passes it to ->write_iter().  It then
subtracts the returned length from sd.total_len and walks the pipe
buffers by that length.  A ->write_iter() implementation that reports
more bytes than the iterator held makes sd.total_len underflow and the
dismissal loop advance pipe->tail past pipe->head, releasing a zeroed
pipe buffer:

  Splice Exceeded! ret=7 tot=1 left=0
  Oops: general protection fault
  RIP: 0010:iter_file_splice_write+0xb6f/0x1170

Commit a3de58b12ce0 ("netfs: Fix unbuffered write error handling")
added the warning for this condition but only reports it.  Clamp the
return value to the size of the iterator that was actually handed to
->write_iter(), so the pipe accounting stays consistent even when a
producer violates the iterator contract.

Fixes: 8d0207652cbe ("->splice_write() via ->write_iter()")
Cc: stable@vger.kernel.org
Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
Link: https://patch.msgid.link/179328314072.648427.13388575162083843840@gmail.com
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/fs/splice.c b/fs/splice.c
index 957e984512ad..03f1fdc4cfa8 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -737,9 +737,12 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 		sd.pos = kiocb.ki_pos;
 		if (ret <= 0)
 			break;
-		WARN_ONCE(ret > sd.total_len - left,
-			  "Splice Exceeded! ret=%zd tot=%zu left=%zu\n",
-			  ret, sd.total_len, left);
+		if (unlikely(ret > sd.total_len - left)) {
+			WARN_ONCE(1,
+				  "Splice Exceeded! ret=%zd tot=%zu left=%zu\n",
+				  ret, sd.total_len, left);
+			ret = sd.total_len - left;
+		}
 
 		sd.num_spliced += ret;
 		sd.total_len -= ret;

