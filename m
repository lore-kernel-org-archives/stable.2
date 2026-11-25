Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795623622;
	b=ZIP6zQ4WuQSOZe3Oq9aqVRl+Xenifi15Pxlm1Wqcia8ywvVL3wj1KNHdTfGI1oSv0Otm
	 mEgESr4E0hSKTIVazPeoe06mBezw5el6qnq/ymjHKhu+SphF1+i9oGny32txpaEVCC7AN
	 PLwqQe/uQE77q/Mvidcum/Uduj9ySLbIfKl3e2/lmFgIWeo4vsR1q0n3E6zN9emNGOdJ1
	 MisEvQdxAiQMEa7Y7Juef3hJsJVNnAzPtMQoSmIsLBBt5rYby9HnovLc01yuZCcv4XAs+
	 C7ci3ZG6brBLJVHdHQwr8HRwGuFKopkf/7REuME312qQ6rjz/l9AVwyab+RiCma2j8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623622;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QjPkHM/kOguYZhoZF/tMExtz1uKUC5vM+ra91+4gT+s=;
	b=lq88rUQfFVlJ4T+YUltWC4ZAnNdgIWzqXdL2aFZk4sFtwgwHy/E/7bQgjGwXQ1Puk7av
	 gWDp8odONAy+QomQQh3RZpeuJN5aEg3QcpRJ2JRj6dFVYw8HBS6YkUpt4P9MlrakaZ8ZV
	 HdvA7mQQkL1JYQDPa62r9vBzW3xLwGWWf7fERDzWmB/mhQItVQ+nj5S33Lm4X/LSGbQcD
	 +Vl+f6RWKd1LGYZgsuknYTeAgfkw9kldl+fjJffJVY8P6Wa1+EQUn8vtujqxMbBN6Jpec
	 QtDYmdl2HqU7yTwlXItAkM1TiBoI1E9+9/7p0ifrixj0uJN0m0FjO18PpzxjQZzwMIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C6VcaDhJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8945A606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C6VcaDhJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0B01F000CA;
	Wed, 25 Nov 2026 16:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795623622;
	bh=QjPkHM/kOguYZhoZF/tMExtz1uKUC5vM+ra91+4gT+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C6VcaDhJdJRMF0UirA/r8US/IJEcWWnPyIgG5q07nAbjw1c1O/SycjGG7YyERwyKQ
	 A1a67QGIxVEjY/jCjvlcg3BjP+tT8+CVOzdmZioaLJoKNUyVLS/z3gXYkNRLS6FvrK
	 KkRgyN/6vyBGEK3vn9UdpYebM2kAShTBMsYxfMLlsHkuPO5gaqtrZJLaJvdQD2ekGa
	 X28b9Ha6WIp6P99+zxctdPQp5PTnWMua8Lx+lbAn7z3efKZBGYtNEEsk2DUwAuIzxU
	 9AuojzvAKhvUgFLC7ZF/+gSq/lMFHftdIfAzDAYRwn5NxlqNZDxcAq4wXfW97V9zIZ
	 ARN1lEOA+fIyA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cheng Yongkang <teel4res@gmail.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] fs/splice: clamp an over-reported write_iter result
Date: Wed, 25 Nov 2026 11:20:20 -0500
Message-ID: <20261125162000.768655-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112546-patronage-comfort-c01e@gregkh>
References: <2026112546-patronage-comfort-c01e@gregkh>
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

From: Cheng Yongkang <teel4res@gmail.com>

[ Upstream commit 2d956723e82cddae8ff8e9da99a666217b02065f ]

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
[ sashal: Adapted the call site to the older vfs_iter_write(out, &from, &sd.pos, 0) interface, so the context differs, while the clamp and the WARN_ONCE conversion are unchanged. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/splice.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/splice.c b/fs/splice.c
index fb149d15c2bc2..120a6307f06d2 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -690,6 +690,12 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 		ret = vfs_iter_write(out, &from, &sd.pos, 0);
 		if (ret <= 0)
 			break;
+		if (unlikely(ret > sd.total_len - left)) {
+			WARN_ONCE(1,
+				  "Splice Exceeded! ret=%zd tot=%zu left=%zu\n",
+				  ret, sd.total_len, left);
+			ret = sd.total_len - left;
+		}
 
 		sd.num_spliced += ret;
 		sd.total_len -= ret;
-- 
2.53.0

