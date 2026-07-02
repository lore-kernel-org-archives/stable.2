Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0912E175F
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 15:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783005988; cv=none; b=FTWQ7iMjybO0ap0q7dZ+58V/YMupiwPRrx537PQa5jAg2WZIQs0NMvTfxrXwvkmL4xJQNXaERO1ckxsA9Ma3pU9RPG47JiYF7YrtTrsTmaUapx4V5KS23T/F05qBAOJAID/dQBIgBR/fJS9X8XYWNS7znNnV1bauFdVBok1vJfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783005988; c=relaxed/simple;
	bh=LMnVYRtZuQMI1iVd18ywwvMQiuRwLiPYXXzLUZc1Hlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ogmTg6gnG30rGouCvJP+Eq0EO/C129nlGlNNVJnvuTNRqnE4gIZ+StzeWvR9eBVum18dAzI6jcjNMWyssMwI+MMtQScd9owuOfnBWXUDPsM48n8VD/O9wGR7Vclb+/7BPgCVIyTbzc/c9HJJ/203qJO2z5pGe09aWuHaXt+prdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETrP2NBb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETrP2NBb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4BA1F00A3D;
	Thu,  2 Jul 2026 15:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783005986;
	bh=WxVgq7pIfQX4sb7c11Y1HD5NgWY7tsmCLDUuxum+9P4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ETrP2NBbNXfbKbxIHkeddM9HC1ldLk8oVPlgtX3Jx7TVbj1TGRcVnvvgV3Vl1ijg7
	 eUoFeNgRZOUMSMhWmJSGQFgZCzmfNJabk/xiRZd09Wcl11cZZW7nEuU9DQE3fMEVI2
	 57+UfF/C998ri+p/rsbW8E8OIMKLOqcHBYBuSjeNEBCJnQ9axTMXq7X4y2m05C1Qy6
	 x2GMJxDjtrUIBEjDM9TWmK4+CG4nIk1Dcg1zEnThHZkTElRsGYA5jig2xSb2BByLIh
	 JTw7xdVUY3WQmsfVmCmq9MB9+75wQlm8NwzbYlUqRt9a7ISAt5psh/TH9uuKZug82M
	 fzbD5a56Uejig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yiming Qian <yimingqian591@gmail.com>,
	Keenan Dong <keenanat2000@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] net: skmsg: preserve sg.copy across SG transforms
Date: Thu,  2 Jul 2026 11:26:23 -0400
Message-ID: <20260702152623.3530248-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702152623.3530248-1-sashal@kernel.org>
References: <2026070246-backer-dating-7275@gregkh>
 <20260702152623.3530248-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yiming Qian <yimingqian591@gmail.com>

[ Upstream commit 406e8a651a7b854c41fecd5117bb282b3a6c2c6b ]

The sk_msg sg.copy bitmap is part of the scatterlist entry ownership
state. A set bit tells sk_msg_compute_data_pointers() not to expose the
entry through writable BPF ctx->data. This protects entries backed by
pages that are not private to the sk_msg, such as splice-backed file
page-cache pages.

Several sk_msg transform paths move, copy, split, or compact
msg->sg.data[] entries without moving the matching sg.copy bit. This can
make an externally backed entry arrive at a new slot with a clear copy
bit. A later SK_MSG verdict can then expose sg_virt(sge) as writable
ctx->data and BPF stores can modify the original page cache.

Keep sg.copy synchronized with sg.data[] whenever entries are
transferred, shifted, split, or copied into a new sk_msg. Clear the bit
when an entry is replaced by a newly allocated private page or freed.
This covers the BPF pull/push/pop helpers, sk_msg_shift_left/right(),
sk_msg_xfer(), and tls_split_open_record(), including the partial tail
entry created during TLS open-record splitting.

Fixes: d3b18ad31f93 ("tls: add bpf support to sk_msg handling")
Cc: stable@vger.kernel.org
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Reported-by: Keenan Dong <keenanat2000@gmail.com>
Signed-off-by: Yiming Qian <yimingqian591@gmail.com>
Link: https://patch.msgid.link/20260610062137.49075-1-yimingqian591@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/skmsg.h | 15 +++++++++++----
 net/core/filter.c     | 27 +++++++++++++++++++++++++++
 net/core/skmsg.c      |  2 ++
 net/tls/tls_sw.c      |  4 ++++
 4 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 1e041bc2ce8e3b..f83f6341d4912b 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -4,6 +4,7 @@
 #ifndef _LINUX_SKMSG_H
 #define _LINUX_SKMSG_H
 
+#include <linux/bitops.h>
 #include <linux/bpf.h>
 #include <linux/filter.h>
 #include <linux/scatterlist.h>
@@ -187,11 +188,14 @@ static inline void sk_msg_xfer(struct sk_msg *dst, struct sk_msg *src,
 			       int which, u32 size)
 {
 	dst->sg.data[which] = src->sg.data[which];
+	__assign_bit(which, dst->sg.copy, test_bit(which, src->sg.copy));
 	dst->sg.data[which].length  = size;
 	dst->sg.size		   += size;
 	src->sg.size		   -= size;
 	src->sg.data[which].length -= size;
 	src->sg.data[which].offset += size;
+	if (!src->sg.data[which].length)
+		__clear_bit(which, src->sg.copy);
 }
 
 static inline void sk_msg_xfer_full(struct sk_msg *dst, struct sk_msg *src)
@@ -261,16 +265,19 @@ static inline void sk_msg_page_add(struct sk_msg *msg, struct page *page,
 static inline void sk_msg_sg_copy(struct sk_msg *msg, u32 i, bool copy_state)
 {
 	do {
-		if (copy_state)
-			__set_bit(i, msg->sg.copy);
-		else
-			__clear_bit(i, msg->sg.copy);
+		__assign_bit(i, msg->sg.copy, copy_state);
 		sk_msg_iter_var_next(i);
 		if (i == msg->sg.end)
 			break;
 	} while (1);
 }
 
+static inline void sk_msg_sg_copy_assign(struct sk_msg *dst, u32 dst_i,
+					 const struct sk_msg *src, u32 src_i)
+{
+	__assign_bit(dst_i, dst->sg.copy, test_bit(src_i, src->sg.copy));
+}
+
 static inline void sk_msg_sg_copy_set(struct sk_msg *msg, u32 start)
 {
 	sk_msg_sg_copy(msg, start, true);
diff --git a/net/core/filter.c b/net/core/filter.c
index 878b79529a006f..0ce845d58f09a4 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2718,11 +2718,13 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg, u32, start,
 		poffset += len;
 		sge->length = 0;
 		put_page(sg_page(sge));
+		__clear_bit(i, msg->sg.copy);
 
 		sk_msg_iter_var_next(i);
 	} while (i != last_sge);
 
 	sg_set_page(&msg->sg.data[first_sge], page, copy, 0);
+	__clear_bit(first_sge, msg->sg.copy);
 
 	/* To repair sg ring we need to shift entries. If we only
 	 * had a single entry though we can just replace it and
@@ -2748,9 +2750,11 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg, u32, start,
 			break;
 
 		msg->sg.data[i] = msg->sg.data[move_from];
+		sk_msg_sg_copy_assign(msg, i, msg, move_from);
 		msg->sg.data[move_from].length = 0;
 		msg->sg.data[move_from].page_link = 0;
 		msg->sg.data[move_from].offset = 0;
+		__clear_bit(move_from, msg->sg.copy);
 		sk_msg_iter_var_next(i);
 	} while (1);
 
@@ -2779,6 +2783,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 {
 	struct scatterlist sge, nsge, nnsge, rsge = {0}, *psge;
 	u32 new, i = 0, l = 0, space, copy = 0, offset = 0;
+	bool sge_copy, nsge_copy, nnsge_copy, rsge_copy = false;
 	u8 *raw, *to, *from;
 	struct page *page;
 
@@ -2851,6 +2856,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 			sk_msg_iter_var_prev(i);
 		psge = sk_msg_elem(msg, i);
 		rsge = sk_msg_elem_cpy(msg, i);
+		rsge_copy = test_bit(i, msg->sg.copy);
 
 		psge->length = start - offset;
 		rsge.length -= psge->length;
@@ -2875,24 +2881,32 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 
 	/* Shift one or two slots as needed */
 	sge = sk_msg_elem_cpy(msg, new);
+	sge_copy = test_bit(new, msg->sg.copy);
 	sg_unmark_end(&sge);
 
 	nsge = sk_msg_elem_cpy(msg, i);
+	nsge_copy = test_bit(i, msg->sg.copy);
 	if (rsge.length) {
 		sk_msg_iter_var_next(i);
 		nnsge = sk_msg_elem_cpy(msg, i);
+		nnsge_copy = test_bit(i, msg->sg.copy);
 		sk_msg_iter_next(msg, end);
 	}
 
 	while (i != msg->sg.end) {
 		msg->sg.data[i] = sge;
+		__assign_bit(i, msg->sg.copy, sge_copy);
 		sge = nsge;
+		sge_copy = nsge_copy;
 		sk_msg_iter_var_next(i);
 		if (rsge.length) {
 			nsge = nnsge;
+			nsge_copy = nnsge_copy;
 			nnsge = sk_msg_elem_cpy(msg, i);
+			nnsge_copy = test_bit(i, msg->sg.copy);
 		} else {
 			nsge = sk_msg_elem_cpy(msg, i);
+			nsge_copy = test_bit(i, msg->sg.copy);
 		}
 	}
 
@@ -2906,6 +2920,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 		get_page(sg_page(&rsge));
 		sk_msg_iter_var_next(new);
 		msg->sg.data[new] = rsge;
+		__assign_bit(new, msg->sg.copy, rsge_copy);
 	}
 
 	sk_msg_reset_curr(msg);
@@ -2933,25 +2948,33 @@ static void sk_msg_shift_left(struct sk_msg *msg, int i)
 		prev = i;
 		sk_msg_iter_var_next(i);
 		msg->sg.data[prev] = msg->sg.data[i];
+		sk_msg_sg_copy_assign(msg, prev, msg, i);
 	} while (i != msg->sg.end);
 
 	sk_msg_iter_prev(msg, end);
+	__clear_bit(msg->sg.end, msg->sg.copy);
 }
 
 static void sk_msg_shift_right(struct sk_msg *msg, int i)
 {
 	struct scatterlist tmp, sge;
+	bool tmp_copy, sge_copy;
 
 	sk_msg_iter_next(msg, end);
 	sge = sk_msg_elem_cpy(msg, i);
+	sge_copy = test_bit(i, msg->sg.copy);
 	sk_msg_iter_var_next(i);
 	tmp = sk_msg_elem_cpy(msg, i);
+	tmp_copy = test_bit(i, msg->sg.copy);
 
 	while (i != msg->sg.end) {
 		msg->sg.data[i] = sge;
+		__assign_bit(i, msg->sg.copy, sge_copy);
 		sk_msg_iter_var_next(i);
 		sge = tmp;
+		sge_copy = tmp_copy;
 		tmp = sk_msg_elem_cpy(msg, i);
+		tmp_copy = test_bit(i, msg->sg.copy);
 	}
 }
 
@@ -3011,6 +3034,8 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 		struct scatterlist *nsge, *sge = sk_msg_elem(msg, i);
 		int a = start - offset;
 		int b = sge->length - pop - a;
+		u32 sge_i = i;
+		bool sge_copy = test_bit(i, msg->sg.copy);
 
 		sk_msg_iter_var_next(i);
 
@@ -3023,6 +3048,7 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 				sg_set_page(nsge,
 					    sg_page(sge),
 					    b, sge->offset + pop + a);
+				__assign_bit(i, msg->sg.copy, sge_copy);
 			} else {
 				struct page *page, *orig;
 				u8 *to, *from;
@@ -3039,6 +3065,7 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 				memcpy(to, from, a);
 				memcpy(to + a, from + a + pop, b);
 				sg_set_page(sge, page, a + b, 0);
+				__clear_bit(sge_i, msg->sg.copy);
 				put_page(orig);
 			}
 			pop = 0;
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 8680cdfbdb9dad..d409ae4d48ac99 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -65,6 +65,7 @@ int sk_msg_alloc(struct sock *sk, struct sk_msg *msg, int len,
 			sge = &msg->sg.data[msg->sg.end];
 			sg_unmark_end(sge);
 			sg_set_page(sge, pfrag->page, use, orig_offset);
+			__clear_bit(msg->sg.end, msg->sg.copy);
 			get_page(pfrag->page);
 			sk_msg_iter_next(msg, end);
 		}
@@ -185,6 +186,7 @@ static int sk_msg_free_elem(struct sock *sk, struct sk_msg *msg, u32 i,
 			sk_mem_uncharge(sk, len);
 		put_page(sg_page(sge));
 	}
+	__clear_bit(i, msg->sg.copy);
 	memset(sge, 0, sizeof(*sge));
 	return len;
 }
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 1b8e003d5e70b9..1732e3549a5782 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -564,6 +564,7 @@ static int tls_split_open_record(struct sock *sk, struct tls_rec *from,
 	struct scatterlist *sge, *osge, *nsge;
 	u32 orig_size = msg_opl->sg.size;
 	struct scatterlist tmp = { };
+	u32 tmp_i = 0;
 	struct sk_msg *msg_npl;
 	struct tls_rec *new;
 	int ret;
@@ -585,6 +586,7 @@ static int tls_split_open_record(struct sock *sk, struct tls_rec *from,
 		if (sge->length > apply) {
 			u32 len = sge->length - apply;
 
+			tmp_i = i;
 			get_page(sg_page(sge));
 			sg_set_page(&tmp, sg_page(sge), len,
 				    sge->offset + apply);
@@ -616,6 +618,7 @@ static int tls_split_open_record(struct sock *sk, struct tls_rec *from,
 	nsge = sk_msg_elem(msg_npl, j);
 	if (tmp.length) {
 		memcpy(nsge, &tmp, sizeof(*nsge));
+		sk_msg_sg_copy_assign(msg_npl, j, msg_opl, tmp_i);
 		sk_msg_iter_var_next(j);
 		nsge = sk_msg_elem(msg_npl, j);
 	}
@@ -623,6 +626,7 @@ static int tls_split_open_record(struct sock *sk, struct tls_rec *from,
 	osge = sk_msg_elem(msg_opl, i);
 	while (osge->length) {
 		memcpy(nsge, osge, sizeof(*nsge));
+		sk_msg_sg_copy_assign(msg_npl, j, msg_opl, i);
 		sg_unmark_end(nsge);
 		sk_msg_iter_var_next(i);
 		sk_msg_iter_var_next(j);
-- 
2.53.0

