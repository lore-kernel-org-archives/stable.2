Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C170833F8CA
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 08:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782980867; cv=none; b=c4LMigRvzy9T1p0IgtyfYiR/7Tv5Q2phIFHYfv45SwhokoT4j5ks45SW+J78+p09PoTG5Bl3daQWU9ndWyY/arcu/uONVQ6B0qv2sJnGgnJ3ciNkJh0+DXltcB3Sb4S48syZWPgZUQHsj4f9vJiPvcMop69V93OOxSD2zuqn8S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782980867; c=relaxed/simple;
	bh=dQoyrXRTjdpGgCQ4vGNdPA70gv+L37O5ZFi6pSVAZSk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fu4QSn9fwQN9lUft5xVMziDW3LKxfdL0T9drS3FqIheosHPxBSEiX3yKXC/7CSW4XcFuvIU4/Cxv47Adcdp4V/FwLdHHjPB9KQVwwrD9LocGEUu7Ns2ROYI0G5O3jEai84jE9L9rBpQ4QVQUGUyz9dl8j4gctMxVKIuHkmegnbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RtK62EHB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RtK62EHB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92581F00A3A;
	Thu,  2 Jul 2026 08:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782980865;
	bh=pKK5MHHVEwyPAVNYowWwoSBr1SemS9dGA/oxGjl1FyE=;
	h=Subject:To:Cc:From:Date;
	b=RtK62EHBX3T6L7IQl/uhEP4clbZ+4jTLzk3V/UiVgkeCvexOcS3h2IRknFrolpIFa
	 Nkf3NC6US2hkC5vAdPCw1MEmLJQvnxdXkMhKMprF7jUr3Jw7BLi2x8hDr9Z7bwQLBS
	 bzMA7+92I3btTlWTX6aFZ1Vbs8OWQdd8BNINQzqk=
Subject: FAILED: patch "[PATCH] net: skmsg: preserve sg.copy across SG transforms" failed to apply to 5.15-stable tree
To: yimingqian591@gmail.com,keenanat2000@gmail.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 10:27:45 +0200
Message-ID: <2026070245-deviation-chaffing-97e7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 406e8a651a7b854c41fecd5117bb282b3a6c2c6b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070245-deviation-chaffing-97e7@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 406e8a651a7b854c41fecd5117bb282b3a6c2c6b Mon Sep 17 00:00:00 2001
From: Yiming Qian <yimingqian591@gmail.com>
Date: Wed, 10 Jun 2026 06:21:36 +0000
Subject: [PATCH] net: skmsg: preserve sg.copy across SG transforms

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

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 19f4f253b4f9..937823856de5 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -4,6 +4,7 @@
 #ifndef _LINUX_SKMSG_H
 #define _LINUX_SKMSG_H
 
+#include <linux/bitops.h>
 #include <linux/bpf.h>
 #include <linux/filter.h>
 #include <linux/scatterlist.h>
@@ -199,11 +200,14 @@ static inline void sk_msg_xfer(struct sk_msg *dst, struct sk_msg *src,
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
@@ -273,16 +277,19 @@ static inline void sk_msg_page_add(struct sk_msg *msg, struct page *page,
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
index 80439767e0ee..40037413dd4e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2733,11 +2733,13 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg, u32, start,
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
@@ -2763,9 +2765,11 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg, u32, start,
 			break;
 
 		msg->sg.data[i] = msg->sg.data[move_from];
+		sk_msg_sg_copy_assign(msg, i, msg, move_from);
 		msg->sg.data[move_from].length = 0;
 		msg->sg.data[move_from].page_link = 0;
 		msg->sg.data[move_from].offset = 0;
+		__clear_bit(move_from, msg->sg.copy);
 		sk_msg_iter_var_next(i);
 	} while (1);
 
@@ -2794,6 +2798,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 {
 	struct scatterlist sge, nsge, nnsge, rsge = {0}, *psge;
 	u32 new, i = 0, l = 0, space, copy = 0, offset = 0;
+	bool sge_copy, nsge_copy, nnsge_copy, rsge_copy = false;
 	u8 *raw, *to, *from;
 	struct page *page;
 
@@ -2866,6 +2871,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 			sk_msg_iter_var_prev(i);
 		psge = sk_msg_elem(msg, i);
 		rsge = sk_msg_elem_cpy(msg, i);
+		rsge_copy = test_bit(i, msg->sg.copy);
 
 		psge->length = start - offset;
 		rsge.length -= psge->length;
@@ -2890,24 +2896,32 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 
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
 
@@ -2921,6 +2935,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 		get_page(sg_page(&rsge));
 		sk_msg_iter_var_next(new);
 		msg->sg.data[new] = rsge;
+		__assign_bit(new, msg->sg.copy, rsge_copy);
 	}
 
 	sk_msg_reset_curr(msg);
@@ -2948,25 +2963,33 @@ static void sk_msg_shift_left(struct sk_msg *msg, int i)
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
 
@@ -3026,6 +3049,8 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 		struct scatterlist *nsge, *sge = sk_msg_elem(msg, i);
 		int a = start - offset;
 		int b = sge->length - pop - a;
+		u32 sge_i = i;
+		bool sge_copy = test_bit(i, msg->sg.copy);
 
 		sk_msg_iter_var_next(i);
 
@@ -3038,6 +3063,7 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 				sg_set_page(nsge,
 					    sg_page(sge),
 					    b, sge->offset + pop + a);
+				__assign_bit(i, msg->sg.copy, sge_copy);
 			} else {
 				struct page *page, *orig;
 				u8 *to, *from;
@@ -3054,6 +3080,7 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 				memcpy(to, from, a);
 				memcpy(to + a, from + a + pop, b);
 				sg_set_page(sge, page, a + b, 0);
+				__clear_bit(sge_i, msg->sg.copy);
 				put_page(orig);
 			}
 			pop = 0;
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index e1850caf1a71..30c3b9a2681c 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -66,6 +66,7 @@ int sk_msg_alloc(struct sock *sk, struct sk_msg *msg, int len,
 			sge = &msg->sg.data[msg->sg.end];
 			sg_unmark_end(sge);
 			sg_set_page(sge, pfrag->page, use, orig_offset);
+			__clear_bit(msg->sg.end, msg->sg.copy);
 			get_page(pfrag->page);
 			sk_msg_iter_next(msg, end);
 		}
@@ -186,6 +187,7 @@ static int sk_msg_free_elem(struct sock *sk, struct sk_msg *msg, u32 i,
 			sk_mem_uncharge(sk, len);
 		put_page(sg_page(sge));
 	}
+	__clear_bit(i, msg->sg.copy);
 	memset(sge, 0, sizeof(*sge));
 	return len;
 }
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 964ebc268ee4..a47f6a1e2c77 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -623,6 +623,7 @@ static int tls_split_open_record(struct sock *sk, struct tls_rec *from,
 	struct scatterlist *sge, *osge, *nsge;
 	u32 orig_size = msg_opl->sg.size;
 	struct scatterlist tmp = { };
+	u32 tmp_i = 0;
 	struct sk_msg *msg_npl;
 	struct tls_rec *new;
 	int ret;
@@ -644,6 +645,7 @@ static int tls_split_open_record(struct sock *sk, struct tls_rec *from,
 		if (sge->length > apply) {
 			u32 len = sge->length - apply;
 
+			tmp_i = i;
 			get_page(sg_page(sge));
 			sg_set_page(&tmp, sg_page(sge), len,
 				    sge->offset + apply);
@@ -675,6 +677,7 @@ static int tls_split_open_record(struct sock *sk, struct tls_rec *from,
 	nsge = sk_msg_elem(msg_npl, j);
 	if (tmp.length) {
 		memcpy(nsge, &tmp, sizeof(*nsge));
+		sk_msg_sg_copy_assign(msg_npl, j, msg_opl, tmp_i);
 		sk_msg_iter_var_next(j);
 		nsge = sk_msg_elem(msg_npl, j);
 	}
@@ -682,6 +685,7 @@ static int tls_split_open_record(struct sock *sk, struct tls_rec *from,
 	osge = sk_msg_elem(msg_opl, i);
 	while (osge->length) {
 		memcpy(nsge, osge, sizeof(*nsge));
+		sk_msg_sg_copy_assign(msg_npl, j, msg_opl, i);
 		sg_unmark_end(nsge);
 		sk_msg_iter_var_next(i);
 		sk_msg_iter_var_next(j);

