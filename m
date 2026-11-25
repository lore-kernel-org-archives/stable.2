Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795623417;
	b=NJ81LyJqT9RPhw2M3f66VvirV65tm7pHE62P18EpaZPyR5ap08W1D17fsxgSMMExxHWL
	 P8KD5JwZ4/ImSZ5esIm2jZoGPtT76B2LAt0JTKoQugD5Z53J8SMQgxCZDgSZdpg6awuXq
	 kFBjFsPjeH4jSAf06lheU4dM4PJQuojHzdwABMIEOBt5m7fb2dCei3tbqpGgxWdRaZaEN
	 ozpP9PM1jWwO9YA0VcS4X4x/b5oNMPU6qcciNS523PqR7Q/ujOLtZ6YOgTtSWg4cDecfL
	 kQqZI+aGhgPYV1a2enYVlHHUGaTNBo6LPBlSEIz/4K1bvWgpFPoLa7TK6OiHEOSmA5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623417;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vOV0arImjQKd1ZRPfRYmf4Vr8oosuyftDiD/5X9gDyY=;
	b=1Gt6WQf8GPR3WdwGW1x/wVXw5UkiFXfrli5DoMjKXfAnRp+CSVx9y1krzPPuXGnTEzJZ
	 2g5ZKpwnyE1H4micWosBv44S36RgWVpLJcIfQYzRvOYkLCGvc0YDgWCi6NSHzYynQWcpE
	 OedP1MImOnqCxV84ZNh9nYWTu2eJV/ksIUcZY8Hcb/uZ33e13Ajsi7t8rtKGfKKIbIT0Y
	 yR7LgOjROR/S8wSfMlLaaeHakq0jZ/KgLoYwR6ubAcd6iv4fj4wZb3o30cF0De3z1DVcw
	 RjVWWcvnCOWRzmDbxinU4IRc7NRfXslkHUvn0sOSg6goSKqRXYEP1EMxjvnTmrRYasg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="OU5Poj/M";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDE4606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OU5Poj/M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A4A1F000C0;
	Wed, 25 Nov 2026 16:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795623417;
	bh=vOV0arImjQKd1ZRPfRYmf4Vr8oosuyftDiD/5X9gDyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OU5Poj/MEIL5gf2RDWk2YjuUWXXvwKciIhtFCtrjY90BLYzndPP/1nr+6TAkRQnwm
	 EDT9848HSvHtZvSIvNH99nY/0BPAXlgO0YbZMeblVC8T3P9DWdKEn0GMi3Q2MLTza8
	 Xny3Q7iT/WkICsDAzlmmTrY8EL5ufFKZaEKIOPFaR/aOZZ5onDtd3pD567bi7ZxOrM
	 H5nFGbPNsxWyi6blhf+D99F1D0LgR8c8cVev18l4vmUbk01zshjBsGG3Ejj4a4TDoM
	 6lUpmI6WE4aCgYqxh6HD3kosHJHP3F4S+3VXLO78jxLyw7OVo6RQAoKcjIVjgcrCB4
	 yt17X+guZfK4Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cheng Yongkang <teel4res@gmail.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] fs/splice: clamp an over-reported write_iter result
Date: Wed, 25 Nov 2026 11:16:54 -0500
Message-ID: <20261125161636.749610-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112545-thievish-curry-bd88@gregkh>
References: <2026112545-thievish-curry-bd88@gregkh>
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
[ sashal: adapted the splice write path to the older vfs_iter_write() call instead of the kiocb-based write_iter, so the clamp is applied after that call. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/splice.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/splice.c b/fs/splice.c
index 26824470af974..0141a847aca65 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -686,6 +686,12 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
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

