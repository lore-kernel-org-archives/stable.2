Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C0737205D
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 06:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781072517; cv=none; b=r0TY0dFfd1NjWst75NE5JCENkDlGwaUfrZOBWngaRa6MVimiDAMK8b6qwMCJ4N/TijkJq8gEaFSmgtklsFNsSDGimWKFU4wulooxElty+hFuqM49wNS21y0xQSawDP5R+ojnf3ZV1kXVKOwbgKzc0QwDQGaCSuR6R2Kp49MEayY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781072517; c=relaxed/simple;
	bh=Pe88eUAgT0wbmUNBsOs8zzWsG9xBnZCTpa0+FNgBMlg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c+FvYGyOGITZ2HM0pFUSvqhf7rVHiio3LevLqVin5h02m+fKLck5VWw8gVqVqxmgjnK7NUsz64f5MWnVcqAWQJFgmQCt47cNnhvXB5Ty7onnvIwzxcldq7UraQ3vK7r/ElriCPTrsuoTX1rOruHtxpCEuADCCDy/VvputvdR6ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rUtIXBfX; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rUtIXBfX"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84275887a3fso4593992b3a.1
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 23:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781072514; x=1781677314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lp8Xg7BLPbTEgIPBs+tIAGAGPHg6LJRApIau6bGcWZc=;
        b=rUtIXBfXGKW8/E31jLUIZ4kOY1pmfLDitWbwPOQmQLLBqGUmMJCdS/HLM+PO4TCJun
         +cHk9t9uX7xc6pzsb7PfkwPiIMe+NkUovVUFm/bAyxCZ6zCIMkug1+911tGafzte2Vp+
         Zh36y1dvgA1pyBzMnqGS+uCJF7ToQORq1DuP0D7zq8Ihn5rY0fu/u3+OvVSe2rwfgEIF
         tMIaBtYgvPygZzxkgLVcK3TtrJ1fjSxdykzdhsPxSAtuEfLe4L4Wh1J5IrIE+SkBYHRs
         kPn8LN7+nvU8odxAklMZrH4X08HMsCE0boWNv9yO9VwtR0WAWAWIKDZ9HF68EoOD9mkC
         qGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781072514; x=1781677314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lp8Xg7BLPbTEgIPBs+tIAGAGPHg6LJRApIau6bGcWZc=;
        b=aCqXn5PUyw78wLlVa+fjzqOJTln9TfpLgFTAxvkI4rHWFuV13ZfzT9Dut7v5+0qgLv
         EaIgV50r44K5fUyik+x+WRLtbs3s4kPTGN3Z3iBRSMzbCYP6qV9Gch4TKgxdsW9v2E6f
         +gDzFWfQw4ivpfH/p4qulsx756YftCyArygUNzkcKSJFHimEgGJwcTX2xmj2Y22SSzUy
         JJcNo8AObtUiQa23cYevw8jL0LVbpzMLIdESWFukoYiNBA1p8IGCvXjdJNz8zR/I3skA
         MRGayGL77o+KK6BBnxBQWnNy3A6wGN9S7Qq+XOWjki4oTzaF40nrroFjZrh6Mkz3LA1E
         zpxw==
X-Forwarded-Encrypted: i=1; AFNElJ+jC9ELTckwUeipEZiqhN6oAKZgGHn2Q8FwysKFe0HbyOCdwiKg6PidutrvkCyFPJ/bBjk0WB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwSQ2jHNDb1apwJRwZI+B8qhPVqOwepbkXjbuIN0ePlpXkAnHy
	hHLKm1Rxt5ivQieHmgVZ0tp0fbuW4d95jHBfGTR8DIhOK7Ni5M2jyB1S
X-Gm-Gg: Acq92OF2J1d2nsPnFYzIF5DK0ukSOBL5VdqDKlxBnq9jaUCR+ErgIu+Cy76uui0+WjF
	wdE5atSk0JdNjMrjcWhDxV/oGmpTdLtl0hWEWvbKEgxfM0uq1A5Zelq941etBHBSnDBb51N5wSv
	SPJ5qpVxyA0ALAmkpaSyr8WCk6VDwchGR/UFoFByLpXfy3yaBsxsd16hshOKfvHCjex77WBt7ZL
	zpngzK/cvQVoiVwEJcPz8O64uiY6In/w9/N78KRfP1i2vSBE0WGhhyS3cjmuMRCeudOJ637yJzc
	xGrJwLN+6xrmzjyH1R0O+TRJZg92GorIpRDHFSQFJbqQz76nWVOi279namPq4N/7YYXn6G7Yq0v
	D+XPQofNQ5KrT6B1PrvL4Q+VFBITodzmqyDfw6+fSRmjt5UIs6xKRjaJP7vlgGld1178KoKL6Pq
	dGPFUzVhFRHpcQ1M1PDVxSn5oWY8bP90i9OeaF7uo0yD1p1Zf9m0hg9lIIOW8ClA==
X-Received: by 2002:a05:6a00:1bc7:b0:83f:250d:5a5 with SMTP id d2e1a72fcca58-842b6787af8mr18982395b3a.16.1781072513757;
        Tue, 09 Jun 2026 23:21:53 -0700 (PDT)
Received: from kfuzz ([202.120.234.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428221c3e4sm24196986b3a.5.2026.06.09.23.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 23:21:53 -0700 (PDT)
From: Yiming Qian <yimingqian591@gmail.com>
To: security@kernel.org,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: keenanat2000@gmail.com,
	yimingqian591@gmail.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: skmsg: preserve sg.copy across SG transforms
Date: Wed, 10 Jun 2026 06:21:36 +0000
Message-ID: <20260610062137.49075-1-yimingqian591@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
v2:
- Use __assign_bit() and the _assign helper suffix suggested in review.
- Broaden the fix beyond tls_split_open_record() to the sk_msg entry
  transform paths in BPF pull/push/pop helpers, sk_msg shift helpers,
  sk_msg_xfer(), and entry allocation/free cleanup.
- Expand the commit message to explain why sg.copy must move with the
  scatterlist entry.

 include/linux/skmsg.h | 15 +++++++++++----
 net/core/filter.c     | 27 +++++++++++++++++++++++++++
 net/core/skmsg.c      |  2 ++
 net/tls/tls_sw.c      |  4 ++++
 4 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 19f4f253b4f90..937823856de59 100644
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
index 80439767e0eea..40037413dd4ec 100644
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
index e1850caf1a71a..30c3b9a2681c4 100644
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
index 964ebc268ee46..a47f6a1e2c77d 100644
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
-- 
2.34.1
