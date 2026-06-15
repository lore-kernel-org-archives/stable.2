Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299DF3F7AB9
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533183; cv=none; b=QgXFe+v2FwvIoVqKRsqWoYpbehdcQXWmczpV4k/EnY26G22wH0Su0xuSfHODbE9VKaOARQOMyIC3S7c6vVwLqWkgqY4BiojnF8uLqSDN8EflEAM7REbXPjJ3oJSLpSy+bLdnB9oHE7FUKLG/SIjf9MwtBSrPDfZgvMr4jrCnAxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533183; c=relaxed/simple;
	bh=zQ0phzbcNmdXXJE8Irgr468xKYY2HmhDb6gVJ8devz4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nhC5On/l44deAdCViiiqnSJi/tqTbMeWrlpQrDVJLPCaZiXX/nKN6IH6JxHXchaiXR8LPQMIaU2xweOpfOz8NBbpjz5BrcEh6cWwVykZun/3MVQgj5K2MHdp+38blbUwyKXSygdDk0hnv1bwmwKjWuCywpL3x6+4ft38MoYH+KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mkunJTFJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mkunJTFJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E225E1F000E9;
	Mon, 15 Jun 2026 14:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781533180;
	bh=P5TKMKpGsbemUBh2Q+vEWuC950sjTsmBa7ZzJlvL6DI=;
	h=Subject:To:Cc:From:Date;
	b=mkunJTFJgcBCBWbBrckKtJkOdR/80kOdrDxEznMMCezyWUzPdxn2j+lFE8nE6D/vM
	 eXaU5w1eiEuI6OPtTd9rck9mu7WFBczc9u60wKk6Weexn6F7701K2zJrH+POSwvoHB
	 KZjn1sqveDFmz7IbZ9YjYIm6y1T9VIDU4bo3Dxb8=
Subject: FAILED: patch "[PATCH] io_uring/kbuf: don't truncate end buffer for bundles" failed to apply to 6.18-stable tree
To: axboe@kernel.dk,federico.brasili@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:18:24 +0200
Message-ID: <2026061524-overtone-renovate-0e4d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 70f4886bcbb929e88038c8807f1daf7fc587ae7c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061524-overtone-renovate-0e4d@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

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
 

