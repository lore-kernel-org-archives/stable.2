Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598809;
	b=fiID7bOjKl/cZqXX391eVUUJvCbNPOzW6ualOu40DEHyNsmkXjEoJZ59oRI1Qm+advu8
	 gdEFEPjbOglM0NR8ttihWt3RPHxqOFdJu9knCJa8gFcbm/QMvj/6hmOoS883TNXndcfIH
	 UHLvIzXUZ9HssbWkQxqvDNk7lmqwJkMBA2GDUC1bjk1QOoH2E8/m7fD2aZqNnb3q5zGqh
	 ae2U1rC3OTj6r0xF1TbtqsNw6TlVDAVqLmv9pfZJTum+wHFH/MERsi8NsfEQAgsqz978l
	 uyNoQ94U2mtL/XnH0uAA8qZrhBCARlHCnt5CSrC/ajIQKqcFjj9ABnMOwvgqVvIGP4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598809;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=NrkxbIEyjz5qbjpGG7pRmyjvCEbsESBDFIHCmKeniMM=;
	b=iN3FI8ojSWSz3d8dqfV15fQiaK71a44T0dGaJsjNhgkeafPW72l/804BsOCrEod+vmt8
	 5FnhQeZBzk6eq77D4wbb+JPfouTe8iYAN578CqwB4blDNNmIduZck17dN0P5kwwzW5XFw
	 PT3266ytkud+WmZKw71BEHLNyXAZsNiAI0T3IT6/a7WKE7L8Gb33NroxKDKuGAHS/JcJP
	 odSgImeNUaFkQCrYnZJrG7Tld+BCaBMyw+UfkzrmptoiVlck+6DHLbF3AwP2hoRFpvic4
	 9LYmLUkykRSzzRLX1XLAAX4LLpg+NOByTtyn1qX13xogSePOyDHmohGu+hKZ9GSNrwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="u2Nee/Fo";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32281606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=u2Nee/Fo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528571F000C6;
	Wed, 25 Nov 2026 09:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795598808;
	bh=NrkxbIEyjz5qbjpGG7pRmyjvCEbsESBDFIHCmKeniMM=;
	h=Subject:To:Cc:From:Date;
	b=u2Nee/Foh5Lxwmw1ACE9GY631KldxOH8Os/XcYJ7YRWn3msEoLk9nnaDtnIr5zI2V
	 1SJSggnP4q91zBa2UVVFtppayZoPm3MFG8QTK81MuKgPQI85grrrnEcFoYI6mFcZMC
	 4RB5cO5YlZWaNUsLQ0YC2C2EDe/EWvg0dz1RWkHU=
Subject: FAILED: patch "[PATCH] fs/splice: clamp an over-reported write_iter result" failed to apply to 5.15-stable tree
To: teel4res@gmail.com,brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 10:20:46 +0100
Message-ID: <2026112546-patronage-comfort-c01e@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 2d956723e82cddae8ff8e9da99a666217b02065f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112546-patronage-comfort-c01e@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

