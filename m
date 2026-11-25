Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795623881;
	b=sW+2073T65pACMnNRPsTE8I07sXEvRFUi56AkVQgh2MnMvXcXNsHHhyeIQwJL4BOSROG
	 L9y1JRvsZTCURqMPleqJHVg/a0MAUftiO1JSldIsyTl3l4JXuhfJj5NYtZr20NcxGJT7I
	 JNQqeynWGg7/dhDYUL27VlRVxqt7DVyQPFAt5lDi9etahaXdTWQsQjZNJjE1GP+e8rxWm
	 6jPUn+gQNDkLsRzZtunf0vXTrpihOsWPdLC+dtjKOM5wXxn1D+AAq4PTfbqAmBDV7L/2q
	 bWZUUPi4TRBWUFzBplczHyNLUtBgEIqU/PZeZDKO8WWynye5xGy4nOV6mqoKdgihCKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623881;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UB4KMTUqgAtUcs4s8Mkqp4mQfzyfdlqv05Qlv0+Mj3o=;
	b=K4QNSe+VS8Li8j1p7QlqwvwCVhQCocVLuX86EwfASQ80xkhmLhY9ETrDFX81UnbCNk8F
	 H+OMocq45OhfS+SHYHgjd5EyfMuzRjTlmQVOyP5XTsOvact6CyO7iaHo1qkmLQg7Cn/qF
	 VKLuXUMH3g0EUHgGmQ0OQ4n4PoZP538S/UwUlxiGm4N4AwZQhETO1BMSiyg86FkUxiYk+
	 omes4dFtlyZNYnJ8r28mtfxRaifzf3Rdgn26izzsgrao/9DMEEIGHTGVe4vno8gLzWD4w
	 x8Hstzu5fPgrCMZSXDOWMANyZZzgzK4J7w7hCIfNdfJwDBTnP80ilMjCzxvPk5YVwgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gx6P0Koz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7E1606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gx6P0Koz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7421F000C6;
	Wed, 25 Nov 2026 16:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795623880;
	bh=UB4KMTUqgAtUcs4s8Mkqp4mQfzyfdlqv05Qlv0+Mj3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gx6P0KozpyB69WxOxRTYhR2GudNJLS9SNUnuN0PHT5OOEKRTpjS+jNDFt1jSlygep
	 l/BEti2blSOofrjiBet1ZjyxhOjGb6cElVtBc3ccbcIhqVmvsUX2GkJT8wMWlQQPQH
	 cF/BD6LHTPktvGBlYXV60jI7QETin+d4KLMsC/7fkijwi422zksVJ1yj8LjB9oHrkk
	 ynRJERq5abJTDsrP0FWg9r3T11oDZtU+mqR/LHELuQuRj/1tWoyqC0kldzsrAKFj+P
	 fYcKZnNLjGd0ruIrYyyuMq9Gf5Z6xGlQ7uFEPpPhbtEMhMXpArtF4Ixbcg6R13ANTI
	 tm8Iscgu/iIiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cheng Yongkang <teel4res@gmail.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] fs/splice: clamp an over-reported write_iter result
Date: Wed, 25 Nov 2026 11:24:38 -0500
Message-ID: <20261125162418.787897-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112546-remedial-underdog-3741@gregkh>
References: <2026112546-remedial-underdog-3741@gregkh>
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
[ sashal: Replaced the upstream call that goes through a kiocb and ki_pos with vfs_iter_write(out, &from, &sd.pos, 0), so the surrounding context differs while the clamp logic is unchanged. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/splice.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/splice.c b/fs/splice.c
index 7f826452e494a..e320dd64cef79 100644
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

