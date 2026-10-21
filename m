Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792597365;
	b=vErF1v9lhSUKq5q5hvseR+8VYB5O4e32zbDkcYyoAiM3Lss04/TUtdfdHxHAw7/adZo1
	 NK2v4J0zctDUZWwqWJb3tIIvX2Un2DkTMiBbRNK85gZ80clDb0hswKT5elAEx4YBNtaus
	 yaeHP53kwkiODsRPageAtPn31vnHzQBEWCGGsodbPrHI+yEwneO7j2NvnVEApW1P8fqXU
	 MiHbhuE92kJtjl0TN787+sChGXkWbbUk7pVvrfHvyrGIHROBBne+euQwNbIhVSKypO04J
	 AB8UOHLL/dxPPGUTIPZ8QEs+E8KpTQGfb/jpKT8Xtnj5osLDEA/ueiN8KJ3GmcwJddA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792597365;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zoFSiI2A+to+sHHd2fTP6tYoknTvQoEBWMuC9CNRE3Q=;
	b=p7DBD42P2XQMtcJL3cKSNdQMYBu8xgdNatJqo5KtZ7KSkUzg1/Jnz2bVa2lQopiLvFgT
	 I83BQEbvko9W4XhDjMNHEDDK/pSvdqGGlw5ctMfeDku+4H/MLGzTsuQgBwmmtpXYr5y9F
	 CEr+rGDapgSwowPSr96Dsce8mYnHGSV7slrHY3cWxIcrutzuWx0/ZYQSEAL2z9cG3WgSj
	 QF2yOKHhr5b3DIfW52Q+0lAkOrNBeuYnETId5skL7Gr6ASKwSlLtwYo8FjMXgP4uOlk9G
	 3tQZV2GndD+j/l2Fq7+GTisgSQAot477a359JePKHmjIbq/ZTd2Cl2te87PKr1ml+mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bQGXsIKa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BE7606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bQGXsIKa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BAE1F000C4;
	Wed, 21 Oct 2026 15:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792597364;
	bh=zoFSiI2A+to+sHHd2fTP6tYoknTvQoEBWMuC9CNRE3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bQGXsIKaL08IzOjTHz8V1QvuCjuZyg88lFslgUgSL635nUaWGaoXL4xUdjbPdZ+fM
	 iqZtlVzlwfs8J+MoBEnmt609I0YYUANhb4pPYI3K3G8CnCczJ2V8BwQ3AaY+1wDXaS
	 cHLFwSjtM/pNJsX0nV89H6yPumadDOAxl+903MkvPeJF3Jz8bKVLtajPGXrxTDhZWO
	 zv0P13BtmIoyBoW3v7LpZH0pNMLiHLaS70Q81XIC8GpL0ZyNaOyv2vUDzDA8SwIl9O
	 W2h1ECbo8VvgDyG1hKLdHvMG5MA7fDYwP0Nx9V/roHiR9/WeLJnjimvvlJnGIr13pB
	 zbImMzggHu7tw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] kernel/watch_queue: Use pipe_buf() to retrieve the pipe buffer
Date: Wed, 21 Oct 2026 11:42:42 -0400
Message-ID: <20261021154232.364295-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102121-dial-citric-080a@gregkh>
References: <2026102121-dial-citric-080a@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: K Prateek Nayak <kprateek.nayak@amd.com>

[ Upstream commit 547476063e123e73fc3aea8432104ab092ffea84 ]

Use pipe_buf() helper to retrieve the pipe buffer in
post_one_notification() replacing the open-coded the logic.

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lore.kernel.org/r/20250307052919.34542-3-kprateek.nayak@amd.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 5e531d62f1f8 ("watch_queue: Fix note pool publication race in watch_queue_set_size()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/watch_queue.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 17254597accd4..0840603c91e37 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -101,12 +101,11 @@ static bool post_one_notification(struct watch_queue *wqueue,
 	struct pipe_inode_info *pipe = wqueue->pipe;
 	struct pipe_buffer *buf;
 	struct page *page;
-	unsigned int head, tail, mask, note, offset, len;
+	unsigned int head, tail, note, offset, len;
 	bool done = false;
 
 	spin_lock_irq(&pipe->rd_wait.lock);
 
-	mask = pipe->ring_size - 1;
 	head = pipe->head;
 	tail = pipe->tail;
 	if (pipe_full(head, tail, pipe->ring_size))
@@ -124,7 +123,7 @@ static bool post_one_notification(struct watch_queue *wqueue,
 	memcpy(p + offset, n, len);
 	kunmap_atomic(p);
 
-	buf = &pipe->bufs[head & mask];
+	buf = pipe_buf(pipe, head);
 	buf->page = page;
 	buf->private = (unsigned long)wqueue;
 	buf->ops = &watch_queue_pipe_buf_ops;
@@ -147,7 +146,7 @@ static bool post_one_notification(struct watch_queue *wqueue,
 	return done;
 
 lost:
-	buf = &pipe->bufs[(head - 1) & mask];
+	buf = pipe_buf(pipe, head - 1);
 	buf->flags |= PIPE_BUF_FLAG_LOSS;
 	goto out;
 }
-- 
2.53.0

