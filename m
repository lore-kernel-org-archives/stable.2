Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0C638BF7A
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784388009; cv=none; b=nZ4wV5alJBvo2zu6irTZv8LhDqM2Qm9EivZn6IEk/4b2UidYFBhRKSxMVJhIBWg1KhtyzU5OD4wedk5E2Nr18QWajWxRnt3fGYdZL7Ijd6Kq2ZJjDnXIzKdNVpJIpeflfltd33TBIb6ucCg9I6CJbCvg3lXRTcw5m9x67t/LKcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784388009; c=relaxed/simple;
	bh=OkEvF45dxV5H2Dp5AUIKcBP4gIttmecfyaUXLQqB8SY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JAaavOoyKBxHX/QWJQPQ3RsirZT6ZYLr1rgASpu0GZvwIqOzfxFWUcXpTDRTIrMMNtEw1NoR59bifkBNgpXK7v6Gd1yMn1GvOYdqtsHCsPbvIsbjY9t0rZHmjN/M39RWrt5u23yflKDzPEoaXTCIfE0+Fh1r2YVt0nUeRkXCRnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hj6JY0wx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hj6JY0wx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4571F000E9;
	Sat, 18 Jul 2026 15:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784388008;
	bh=orzKjhjX8NbOMs50vC+yxVasZNg0+xg0hNpYyq6+4VY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hj6JY0wxxsiGjSC18LSPYdhO4xCRPU2m7gVtUQsVniTNQe8qw6lhUyXvKZQt9g02g
	 4Ksgkb3AaX24dVdSQ1wUYBzBlTsoZlAUi2LknCJTQoMJ6XNlClVCDjiiwXdynpBYqD
	 B0HHU+FiCkZmiMyiarPWp/swv5MYZpm5eRYm66eIUBrXm89q+4oohR9P6MwvUqMRnt
	 FNncRDUa13OYme7Du4uopN0Z/Jfn23Ye1nJv9ZT1TS3T2J9SuAGxTUIMKG7y7zEMhX
	 W4AT/0CPM3avtJ0KrMFuenSomxSN3u7W6d0MdFE4odTt0XvjKJLImSAmAReLA0MFNm
	 YIOx8K2Odec2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] skmsg: convert struct sk_msg_sg::copy to a bitmap
Date: Sat, 18 Jul 2026 11:20:04 -0400
Message-ID: <20260718152005.3278231-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071405-duo-banknote-b789@gregkh>
References: <2026071405-duo-banknote-b789@gregkh>
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
Stable-dep-of: 2ccbc9a38746 ("bpf, sockmap: keep sk_msg copy state in sync")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/skmsg.h | 11 +++++------
 net/core/filter.c     |  4 ++--
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index e9e9fabbfedd89..1e041bc2ce8e3b 100644
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
@@ -235,7 +234,7 @@ static inline void sk_msg_compute_data_pointers(struct sk_msg *msg)
 {
 	struct scatterlist *sge = sk_msg_elem(msg, msg->sg.start);
 
-	if (test_bit(msg->sg.start, &msg->sg.copy)) {
+	if (test_bit(msg->sg.start, msg->sg.copy)) {
 		msg->data = NULL;
 		msg->data_end = NULL;
 	} else {
@@ -254,7 +253,7 @@ static inline void sk_msg_page_add(struct sk_msg *msg, struct page *page,
 	sg_set_page(sge, page, len, offset);
 	sg_unmark_end(sge);
 
-	__set_bit(msg->sg.end, &msg->sg.copy);
+	__set_bit(msg->sg.end, msg->sg.copy);
 	msg->sg.size += len;
 	sk_msg_iter_next(msg, end);
 }
@@ -263,9 +262,9 @@ static inline void sk_msg_sg_copy(struct sk_msg *msg, u32 i, bool copy_state)
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
index 27550e8b05a655..878b79529a006f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2677,7 +2677,7 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg, u32, start,
 	 * account for the headroom.
 	 */
 	bytes_sg_total = start - offset + bytes;
-	if (!test_bit(i, &msg->sg.copy) && bytes_sg_total <= len)
+	if (!test_bit(i, msg->sg.copy) && bytes_sg_total <= len)
 		goto out;
 
 	/* At this point we need to linearize multiple scatterlist
@@ -2900,7 +2900,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
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

