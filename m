Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795623227;
	b=OufwJRgAiF2cUg7jUpOYvhrZbWBIAlD6EewGNTqU9rFU0ns7TLZP/9tlUoM+u4RSF8J1
	 30UPBo70kaoNc2r7AbNdc7e3iyhjoAZ/LlRaocq5TzSKUdTFxoBNH3f6/uQDYJa496EFM
	 NZrd/iFOeR1Q3+n5hrTcMCropsxLXp0BEwBRDbIY+OO+/wyGjC74mZvgIDKi7Sn5ot3U1
	 etsHn1X8Qf+Wkg3Nk8Hlg0BiFDcPolq+TO5N1TOqxahEIfwcQToudmiUK4tY9102GyTgj
	 e/E91FVWtvrdd+eP9FyCyiXZl6rniS4T5ZYnwMJZJ+AYXqrvp0aaNYX1y1njNGFKP3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623227;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=d1hlfiZ/qznxUjySXSSjZnls3ZrvBjIYwXcXFNyEqEY=;
	b=TV8UbJpgnOKr7NsLRNRRzIPbLLyn0Cd3m8yz0uTpC1LcLAGVqVEpOHLP2LcL23JM1lmt
	 Hs1tLJ0n9coYG7JbMg6/laR5eNC1MmKPntlBGOIX5B6NrkWXUW+h+3PTG/rJwVFkKLNW1
	 ZlZPLKrEWFAeJc4T1QN1Vocyv0u5f2+7GF9ZQud7BcjeiShA7a5fs6YxAIODuLuwZTS6g
	 jkdbwUwltn7/YIF2siHtonFShaIjW0mRDT20MhDPZXkyR9+gY+/mhpDI4bWKYsTI58nXX
	 tavjQda789dHYcswSbjFAVMnVABI63Ud9W2cTL9ulbAxUwRUXUd2hpGcjVNjZKxa6vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pqzfa1Rw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75510606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pqzfa1Rw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E263C1F000C6;
	Wed, 25 Nov 2026 16:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795623226;
	bh=d1hlfiZ/qznxUjySXSSjZnls3ZrvBjIYwXcXFNyEqEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pqzfa1Rweu/76G1M6r6MGg+zBCnE8EEMSeAxaklx3jKvebebAQlgIEVFHUEF7l0O0
	 qAkHdpjps4W66bFMFCOtT8e/ev+HIKYlHsj0zq6DfkgpE0vOHIM0BIKR0Suo3Z/9SL
	 rSd6dMYuHwQvAon6BhypPW8+ElOsCycDsuJXTnQ1DbiKf2O3LyB3euxjY9Q4vE3U2M
	 PJZoXny6fUoXyFD/stjcIi3rmnC1HqNEYf465QqMMhsauoISdDqC2rFVtxK7T2vvy0
	 3+K/K5eql5NIlJr6Bt6x1MUWZ6I9xVl8WmTsq/jm39qkcOO7ppRo1wGPsIKjKGKKMb
	 REL3O9pauK3eQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cheng Yongkang <teel4res@gmail.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] fs/splice: clamp an over-reported write_iter result
Date: Wed, 25 Nov 2026 11:13:44 -0500
Message-ID: <20261125161326.718366-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112545-provider-relock-0116@gregkh>
References: <2026112545-provider-relock-0116@gregkh>
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
[ sashal: Added the over-reported write_iter clamp as a standalone block, since the context lacked the existing WARN_ONCE line that upstream rewrites. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/splice.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/splice.c b/fs/splice.c
index 63d37481baa25..c673b31324c3e 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -736,6 +736,12 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
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

