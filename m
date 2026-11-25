Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598800;
	b=4Bb+vDGEubwxYt1WggYC24RGn+ivCLUksodj4Zt/JHG5KzmpEsamzFviW226Z67QNZBX
	 KgR1IY7LSwfCHrraI+ix7BDZNWxXV59g2I5PDHHsrMBI2QgAq0BkW+rTgnRzTGsO5GREu
	 SQXJ4M7xHMk8NeH8wvETopVlxM3VDT9GVA2+aDxKv6Kz3ctnMhP2dyvLkModwHsQLl6RH
	 0KhmotXBzh8PPYLRhUrZoKIg4C7xFPlQWklnNJ6ZfwKXp15rTI46iKNcVGbY8mRcgDXhL
	 ccEhiRshiABZdCgHxGwK2PsGTWQq3PlLATQJdd2Fb84lY+2nqdTw+SoPSpEWmwLqI0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598800;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/0vucanVqXZeR/Ckv5Wt00n5vzveuv/Q+2+2EI7QIng=;
	b=WPtxHDh9/xQ1jl7xbfkszRs7CtTW1C0Z6s0j02mjmXXXR7CtYdHVaOrUEwkvKsmnBsOv
	 xW7PYmAZC0yB11FXajhjv9Iinpa4xKROGUqPbsjXUP8Wb/zge/5TsOyZc7+C7hMqY8+QL
	 OkwnzssDytSX9vYXQdY3sMQuxy67EC0EBbpUdaKgqt7fNvB3/8/nN+QVPnZ6U4kZFBdzZ
	 VCsQtH7d6FS+2SxQujurxk6OkBdoZnSTqUAyy7ZjBeSwjjlB0SeG4/oDxGhts2y54HBF/
	 eRqLg2Ilh/kk6ntjr4X2Ee3TBvp3k8E8MBLhKKwwd0FwCXHihLi9R2ZevxlIu3/7GSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=EvdgVED9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF94606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=EvdgVED9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B871F000C0;
	Wed, 25 Nov 2026 09:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795598800;
	bh=/0vucanVqXZeR/Ckv5Wt00n5vzveuv/Q+2+2EI7QIng=;
	h=Subject:To:Cc:From:Date;
	b=EvdgVED9VCjSB1N1yOY7U5dSmcc+ea90TBLCeFarYMR3c0qVRX6vKo4/2iQ5YIZFb
	 XKzIcaqPYZYQSdR35vzZQnmORggdDQ5TVIhEaNK7aJWrEeyaF/sZsrFXL8aiu0Au9n
	 Yvm9wWnkAKqIJ2NpCgcwSQ2zur/fRVhOa8U1DAT0=
Subject: FAILED: patch "[PATCH] fs/splice: clamp an over-reported write_iter result" failed to apply to 6.1-stable tree
To: teel4res@gmail.com,brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 10:20:45 +0100
Message-ID: <2026112545-thievish-curry-bd88@gregkh>
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
git cherry-pick -x 2d956723e82cddae8ff8e9da99a666217b02065f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112545-thievish-curry-bd88@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

