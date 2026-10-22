Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792651257;
	b=aghrEF3kM7MzjIdHkGiAZ3deqU9E4PLff/HlF2T/0EpIag2x7IxTxpHsY9jzcJ7GOUVT
	 ZIJAOGfRoMRXjwe8ul39HsUAEKVNZb6dMkc6ufl62pG2r73ohHBYy0++IqtR2vnk9Du3Q
	 RNa0XBKOMVnuKYlWNuBYKJ3/T4b706JGL7PQ5ns1t5ceOG/sXc5JvBx+DsIpnNMfLTC5t
	 WyGkDPLIarcGJkIT3sI5A2igFYuX44uYj2qEjYaBtWJ2dknbXxrbP+OnitFwxhaRgJ9Gv
	 /LVaNY09CZbkzd398irWEOKYkiPCD+6oPPNatiUzcXFkHbp6vHyaQ4M2MfRf5uGF5Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792651257;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lV6h8VIDT1TbL9SfQUtkSx+4DLKVcJKpZhEIxfkxe5A=;
	b=H3arnXyeFUur6zNH2dpHfNlqu8EvOZIUQMgFwrb8B9DAzVngec938GGZyECKWDXGgeQr
	 QYKufGp7AktTwrfPd+8Q2aoyG8aMRDmkppBAjNzF5vS9mAefooNWozK1u3Wk7eYKTD0pq
	 Ex4FqqgLLcVhH+HG/xWm3GNYOvJiHl7UgnkgxW1EXQB9NeRiY9hMN/Qj10mEDQprdCWh7
	 irJltANAKqszCVjvL6JXD+1761g2kxcZm63s0iS0/KyO22obtCUmGwwomjfL8L9N+1LhF
	 ZplugIFhtHn5XlV3IcVjsj/yMls3N7eBaVbNwz3tSFKQganfb4nSlEfnt8ICnOBtXnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KQNdv1MS;
	arc=none smtp.remote-ip=115.124.30.110
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D85606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 06:40:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36D85606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KQNdv1MS
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792651247; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=lV6h8VIDT1TbL9SfQUtkSx+4DLKVcJKpZhEIxfkxe5A=;
	b=KQNdv1MSDSBxX0hCDrqp+e4hMxRXigxBkOci0rLkm70nZWKUrxRQi6PEmETPIdaTbmaT5c/PiSZC1GgRfgvh3pUJECQQpMd3Jht2mOiiJ0aKNXZRZw03nfBRIAAnfKXLFpXp5+IzCaeSAEOd7oIO8yL1PAJo097oFrUbNPxbqDY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0XDIPYLb_1792651246;
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0XDIPYLb_1792651246 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 22 Oct 2026 14:40:46 +0800
From: Joseph Qi <joseph.qi@linux.alibaba.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Subject: [PATCH 6.6.y] eventfs: fix SRCU read lock leak in eventfs_iterate()
Date: Thu, 22 Oct 2026 14:40:46 +0800
Message-Id: <20261022064046.4048143-1-joseph.qi@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
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

Commit 25d27d5fa864 ("eventfs: Use children field for rcu head and add
memory barriers") added an early bail out to the ei->children loop:

	smp_rmb();
	if (ei->is_freed)
		return -EINVAL;

Upstream wraps eventfs_iterate() in guard(srcu)(&eventfs_srcu), so that
return still drops the read lock. The 6.6.y backport instead brackets the
function with srcu_read_lock() and a shared "out" label that calls
srcu_read_unlock(), so this path returns while still holding eventfs_srcu
for reading.

The unbalanced reader prevents the grace period from ever completing, so
the call_srcu() callback queued by free_ei() never runs and the
eventfs_inode is leaked. Every readdir that races with removal adds
another reader.

Set ret and jump to "out" like the other bail out paths in this function
do.

Fixes: 25d27d5fa864 ("eventfs: Use children field for rcu head and add memory barriers")
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 fs/tracefs/event_inode.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index df1d571144d6d..8efb9c467b7d2 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -740,8 +740,10 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 		 * Matches the smp_wmb() in free_ei()
 		 */
 		smp_rmb();
-		if (ei->is_freed)
-			return -EINVAL;
+		if (ei->is_freed) {
+			ret = -EINVAL;
+			goto out;
+		}
 
 		if (c > 0) {
 			c--;
-- 
2.39.3

