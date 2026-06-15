Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF6C3E3143
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533190; cv=none; b=jvsPy+WqT9IxOF+M4sHQ8cy4lWobzAMtvxNV0mxevMqoElIG3mZGWE69aC+hFPtkO5OpzrEA3WZ0Pi/cf1OO5ZqRILqS4++EtDkriht0rBA7w81/EoR9mXb2p9heu+w7NYD+kBqsL7NFOYKUgyfH5yj61VUsl858uZEA+ZfH03Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533190; c=relaxed/simple;
	bh=i/3WtNBTL+70G7ZcT284aS1VpmYLPB8bw3ScYirnNVI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dHaX9fLQSKLBnuT2bfwB0Wap05vHrUs+0Wvexi/31V4mHK/AB7vWM/dFzXbhEFXoMwWhhkAHyi0oOzwAeQelSJGRw1N381hMebFmyM4NoTbFUR0ZuBEfVu8T2XQCW/zV1XmGf55XqNacNNUt8Og78xCOV9dem60fLLsE3+Dg5lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rzNN0FVO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rzNN0FVO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001221F000E9;
	Mon, 15 Jun 2026 14:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781533188;
	bh=AtKhOdg4kVVRSUWgh6gx98nSENUafYuRDm68pg9S4P4=;
	h=Subject:To:Cc:From:Date;
	b=rzNN0FVOyC5nidaU7kZ3zBzaU3Y5ouEG8UsQT78aIVo/drdLXVSMwuo3XRNbnaW5u
	 qU3VoRatyPWiYgPsTgPew7M0ziujb0aUpgupxNM5ddUwg1UbkntDjc+XgEVyFbZ7p1
	 LuUdV0Ta/R9KYE1ZPebnqAKOtqcIIhOpVqoabmMQ=
Subject: FAILED: patch "[PATCH] io_uring/kbuf: don't truncate end buffer for bundles" failed to apply to 6.12-stable tree
To: axboe@kernel.dk,federico.brasili@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:18:26 +0200
Message-ID: <2026061526-unroasted-disbelief-650a@gregkh>
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
git cherry-pick -x 70f4886bcbb929e88038c8807f1daf7fc587ae7c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061526-unroasted-disbelief-650a@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 70f4886bcbb929e88038c8807f1daf7fc587ae7c Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Sun, 7 Jun 2026 16:05:47 -0600
Subject: [PATCH] io_uring/kbuf: don't truncate end buffer for bundles

If buffers have been peeked for a bundle receive, the kernel will
truncate the end buffer, if the available length is shorter than the
buffer itself. This is unnecessary, as applications iterating bundle
receives must always use the minimum size of the buffer length and the
remaining number of bytes in the bundle. The examples in liburing do
that as well, eg examples/proxy.c.

If the kernel does truncate this buffer AND the current transfer fails,
then the buffer will be left with a smaller size than what is otherwise
available.

Just remove the buffer truncation, as it's not necessary in the first
place.

Link: https://lore.kernel.org/io-uring/CAAEr8jbY60noGj1fw_k91UJRBkyiRVoS6=nLhZ7Svwidjn4CAA@mail.gmail.com/
Reported-by: Federico Brasili <federico.brasili@gmail.com>
Cc: stable@vger.kernel.org
Fixes: 35c8711c8fc4 ("io_uring/kbuf: add helpers for getting/peeking multiple buffers")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index 63061aa1cab9..926254b6898f 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -305,7 +305,6 @@ static int io_ring_buffers_peek(struct io_kiocb *req, struct buf_sel_arg *arg,
 				arg->partial_map = 1;
 				if (iov != arg->iovs)
 					break;
-				WRITE_ONCE(buf->len, len);
 			}
 		}
 

