Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54A2353A69
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 15:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783005065; cv=none; b=Q3CD2u5nbD/iC/PxFM3Xr1Sr7THwMwBEXoLR2QlJb3d7UGz4FtqCj6iyF4b/Wy+MHF7wBh+21PEPRdfO1yPPy2Tbza9YjzJjlWkaWqdk494TiT6+oZkoQQ2ZUFyLLTD5Pp7yvUQJcHo2dfEedkTxLrjYDGWSOs2Z91T93GrZJDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783005065; c=relaxed/simple;
	bh=vAG03MBYvHJE5IgkzCs3C7ANbeDjY18pKYskMZSB7ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=guNm+beQt8WYPJbDbc48L0Lat60tG1m+tLPq7FYmmWr/X65f2Trg+mEWcN+rwu9L/3IS9GvOhuqEUHmi+RKs9iOFW0dkr7lAL2fozM2g7MRDBRFcpOmd5a1HzLpJtkPiWJEd5FWHYWKUj1V6x3SpFQ2c86IIPZPT8o1YhB/L0UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4/0WsgR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4/0WsgR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C461F000E9;
	Thu,  2 Jul 2026 15:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783005063;
	bh=5s/kPvOBQCRzXej8TG9V4RwhJt2LosTe+m5DDuDN8cQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W4/0WsgRs6b/BnQcvrpqkicuBdgnRYwzAhAowueCNS4CC+P+QLtQ/DONg7VW5X+rk
	 xoK80P0TtH44++bKiG5HJWGwLmMBbWJa7fbdddXT+xXRYQtOcJuCagsR8nCdsq5I91
	 Sk06q7yUt2FjBYw6IQdXnZVbNX8w9/xj6JV9S6tTj7MVE7VFF6l2xfS16IY6tJwON3
	 eUCHFk6GHJ9lBVSS7vI3RnNA5hWl5Ga46v5rqm0PCpfs312r+9/xuLK3NJNOf/p++q
	 KydU2w+0giJdqCYHEGGZHE16PHGIJ776I1I1wtPhxZKIijmWYCO10/aP02aHGNWttH
	 IGHl69cAYPMdA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] skmsg: convert struct sk_msg_sg::copy to a bitmap
Date: Thu,  2 Jul 2026 11:11:00 -0400
Message-ID: <20260702151101.3512823-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070245-deviation-chaffing-97e7@gregkh>
References: <2026070245-deviation-chaffing-97e7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 5a8fb33e530512ee67a11b30f3451a4f030f4b01 ]

We have plans for increasing MAX_SKB_FRAGS, but sk_msg_sg::copy
is currently an unsigned long, limiting MAX_SKB_FRAGS to 30 on 32bit arches.

Convert it to a bitmap, as Jakub suggested.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 406e8a651a7b ("net: skmsg: preserve sg.copy across SG transforms")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/skmsg.h | 11 +++++------
 net/core/filter.c     |  4 ++--
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 5d3e4d4d9438e2..7bc66fd7fc58c1 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -29,7 +29,7 @@ struct sk_msg_sg {
 	u32				end;
 	u32				size;
 	u32				copybreak;
-	unsigned long			copy;
+	DECLARE_BITMAP(copy, MAX_MSG_FRAGS + 2);
 	/* The extra two elements:
 	 * 1) used for chaining the front and sections when the list becomes
 	 *    partitioned (e.g. end < start). The crypto APIs require the
@@ -38,7 +38,6 @@ struct sk_msg_sg {
 	 */
 	struct scatterlist		data[MAX_MSG_FRAGS + 2];
 };
-static_assert(BITS_PER_LONG >= NR_MSG_FRAG_IDS);
 
 /* UAPI in filter.c depends on struct sk_msg_sg being first element. */
 struct sk_msg {
@@ -236,7 +235,7 @@ static inline void sk_msg_compute_data_pointers(struct sk_msg *msg)
 {
 	struct scatterlist *sge = sk_msg_elem(msg, msg->sg.start);
 
-	if (test_bit(msg->sg.start, &msg->sg.copy)) {
+	if (test_bit(msg->sg.start, msg->sg.copy)) {
 		msg->data = NULL;
 		msg->data_end = NULL;
 	} else {
@@ -255,7 +254,7 @@ static inline void sk_msg_page_add(struct sk_msg *msg, struct page *page,
 	sg_set_page(sge, page, len, offset);
 	sg_unmark_end(sge);
 
-	__set_bit(msg->sg.end, &msg->sg.copy);
+	__set_bit(msg->sg.end, msg->sg.copy);
 	msg->sg.size += len;
 	sk_msg_iter_next(msg, end);
 }
@@ -264,9 +263,9 @@ static inline void sk_msg_sg_copy(struct sk_msg *msg, u32 i, bool copy_state)
 {
 	do {
 		if (copy_state)
-			__set_bit(i, &msg->sg.copy);
+			__set_bit(i, msg->sg.copy);
 		else
-			__clear_bit(i, &msg->sg.copy);
+			__clear_bit(i, msg->sg.copy);
 		sk_msg_iter_var_next(i);
 		if (i == msg->sg.end)
 			break;
diff --git a/net/core/filter.c b/net/core/filter.c
index 6a1210abe4625e..5874ecb192098c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2660,7 +2660,7 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg, u32, start,
 	 * account for the headroom.
 	 */
 	bytes_sg_total = start - offset + bytes;
-	if (!test_bit(i, &msg->sg.copy) && bytes_sg_total <= len)
+	if (!test_bit(i, msg->sg.copy) && bytes_sg_total <= len)
 		goto out;
 
 	/* At this point we need to linearize multiple scatterlist
@@ -2883,7 +2883,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 	/* Place newly allocated data buffer */
 	sk_mem_charge(msg->sk, len);
 	msg->sg.size += len;
-	__clear_bit(new, &msg->sg.copy);
+	__clear_bit(new, msg->sg.copy);
 	sg_set_page(&msg->sg.data[new], page, len + copy, 0);
 	if (rsge.length) {
 		get_page(sg_page(&rsge));
-- 
2.53.0

