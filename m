Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3650238B154
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784387606; cv=none; b=MgUEf4h2Yyt1qNebEkd/kNAiO8iLucxa/PNpA4aHzJI+iR4+SP9guU3Q4AsKyoUqnmSHfe8IXCKfGcZu334VER3CZbGjOx4s9sHoBuuqkw8TVcGrfLSytP1H77gI11o6jB0WCfdvVj+0DQrPOKw7BpSYL298QDpQgH5w0IpXo/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784387606; c=relaxed/simple;
	bh=4A1o4x9UjEljGg6dBgvgjJ4vercl7MWAhHhHn2w6wG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qd4LU5oAywflRq+YR/F/a16vFzxvwnQ9yjAImvVha+wFJ7+MGer99bXGtbesGswH2mQ27X7PN9auZSODTVEY2qYbfC9YNpITzE1FE8w+USEKr6IDbwyzw4QitwJWTlAiijup/D+BI3FSyJ62b0FryN3DkOlrjib7wV+Qhp32SsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNGTQhXI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNGTQhXI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D791F00A3D;
	Sat, 18 Jul 2026 15:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784387604;
	bh=MRRBolTeT/lt0281LlHciV+URoSWYVCXELAhEYqmiyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lNGTQhXIh4tbemUOweQW67L+Jy6Waop/z5n6qaDMAmc9QOxnmBlxYbBod22WFd6p3
	 FCQ+vSY7ze9rbn+h7VXk1XaJ3sOzuo2FEYosc2idk7rLSE6x8FCagRR+IQM38vMZZ5
	 BoxlMenNqQHY4KBue8jzpI77wUTXbE6KabHpJvMmLM1DyxFmz6zFgHIpiflPFtK8BV
	 auycsD8D1B73MvPolnHvzID85XyKteX5G58YRmNSqQtIOYYjF8xxnacCxso+cb0N1k
	 z8eIpjtE4dMo7y2vD+KgBY5RlsbI5pSPW7okZEL5BtR0dNfubgrgTADikhmsclVbHn
	 6Ub7ZS6FfpkOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Cen <rollkingzzc@gmail.com>,
	Han Guidong <2045gemini@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] bpf, sockmap: keep sk_msg copy state in sync
Date: Sat, 18 Jul 2026 11:13:21 -0400
Message-ID: <20260718151321.3270833-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260718151321.3270833-1-sashal@kernel.org>
References: <2026071404-skirmish-glider-a33e@gregkh>
 <20260718151321.3270833-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Cen <rollkingzzc@gmail.com>

[ Upstream commit 2ccbc9a3874620c9623419034f572e4507c33e4f ]

SK_MSG uses msg->sg.copy as per-scatterlist-entry provenance. Entries
with this bit set are copied before data/data_end are exposed to SK_MSG
BPF programs for direct packet access.

bpf_msg_pull_data(), bpf_msg_push_data(), and bpf_msg_pop_data()
rewrite the sk_msg scatterlist ring by collapsing, splitting, and
shifting entries. These operations move msg->sg.data[] entries, but the
parallel copy bitmap can be left behind on the old slot. A copied entry
can then return to msg->sg.start with its copy bit clear and be exposed
as directly writable packet data.

This corruption path requires an attached SK_MSG BPF program that calls
the mutating helpers; ordinary sockmap/TLS traffic that never runs
push/pop/pull helper sequences is not affected.

Keep msg->sg.copy synchronized with scatterlist entry moves, preserve
the copy bit when an entry is split, clear it when a helper replaces an
entry with a private page, and clear slots vacated by pull-data
compaction.

Fixes: 015632bb30da ("bpf: sk_msg program helper bpf_sk_msg_pull_data")
Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
Fixes: 7246d8ed4dcc ("bpf: helper to pop data from messages")
Cc: stable@vger.kernel.org
Co-developed-by: Han Guidong <2045gemini@gmail.com>
Reviewed-by: John Fastabend <john.fastabend@gmail.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Han Guidong <2045gemini@gmail.com>
Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Link: https://lore.kernel.org/r/20260615021959.140010-4-jiayuan.chen@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/filter.c | 88 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 83 insertions(+), 5 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 5874ecb192098c..8f2ddec10be0f3 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2622,6 +2622,38 @@ static void sk_msg_reset_curr(struct sk_msg *msg)
 	}
 }
 
+static bool sk_msg_elem_is_copy(const struct sk_msg *msg, u32 i)
+{
+	return test_bit(i, msg->sg.copy);
+}
+
+static void sk_msg_clear_elem_copy(struct sk_msg *msg, u32 i)
+{
+	__clear_bit(i, msg->sg.copy);
+}
+
+static void sk_msg_set_elem_copy(struct sk_msg *msg, u32 i)
+{
+	__set_bit(i, msg->sg.copy);
+}
+
+static void sk_msg_clear_copy_range(struct sk_msg *msg, u32 start, u32 end)
+{
+	while (start != end) {
+		sk_msg_clear_elem_copy(msg, start);
+		sk_msg_iter_var_next(start);
+	}
+}
+
+static void sk_msg_sg_move(struct sk_msg *msg, u32 dst, u32 src)
+{
+	msg->sg.data[dst] = msg->sg.data[src];
+	if (sk_msg_elem_is_copy(msg, src))
+		sk_msg_set_elem_copy(msg, dst);
+	else
+		sk_msg_clear_elem_copy(msg, dst);
+}
+
 static const struct bpf_func_proto bpf_msg_cork_bytes_proto = {
 	.func           = bpf_msg_cork_bytes,
 	.gpl_only       = false,
@@ -2660,7 +2692,7 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg, u32, start,
 	 * account for the headroom.
 	 */
 	bytes_sg_total = start - offset + bytes;
-	if (!test_bit(i, msg->sg.copy) && bytes_sg_total <= len)
+	if (!sk_msg_elem_is_copy(msg, i) && bytes_sg_total <= len)
 		goto out;
 
 	/* At this point we need to linearize multiple scatterlist
@@ -2706,6 +2738,7 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg, u32, start,
 	} while (i != last_sge);
 
 	sg_set_page(&msg->sg.data[first_sge], page, copy, 0);
+	sk_msg_clear_elem_copy(msg, first_sge);
 
 	/* To repair sg ring we need to shift entries. If we only
 	 * had a single entry though we can just replace it and
@@ -2715,8 +2748,14 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg, u32, start,
 	shift = last_sge > first_sge ?
 		last_sge - first_sge - 1 :
 		NR_MSG_FRAG_IDS - first_sge + last_sge - 1;
-	if (!shift)
+	if (!shift) {
+		sk_msg_clear_elem_copy(msg, msg->sg.end);
 		goto out;
+	}
+
+	i = first_sge;
+	sk_msg_iter_var_next(i);
+	sk_msg_clear_copy_range(msg, i, last_sge);
 
 	i = first_sge;
 	sk_msg_iter_var_next(i);
@@ -2730,16 +2769,18 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg, u32, start,
 		if (move_from == msg->sg.end)
 			break;
 
-		msg->sg.data[i] = msg->sg.data[move_from];
+		sk_msg_sg_move(msg, i, move_from);
 		msg->sg.data[move_from].length = 0;
 		msg->sg.data[move_from].page_link = 0;
 		msg->sg.data[move_from].offset = 0;
+		sk_msg_clear_elem_copy(msg, move_from);
 		sk_msg_iter_var_next(i);
 	} while (1);
 
 	msg->sg.end = msg->sg.end - shift > msg->sg.end ?
 		      msg->sg.end - shift + NR_MSG_FRAG_IDS :
 		      msg->sg.end - shift;
+	sk_msg_clear_elem_copy(msg, msg->sg.end);
 out:
 	sk_msg_reset_curr(msg);
 	msg->data = sg_virt(&msg->sg.data[first_sge]) + start - offset;
@@ -2760,8 +2801,10 @@ static const struct bpf_func_proto bpf_msg_pull_data_proto = {
 BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 	   u32, len, u64, flags)
 {
+	bool sge_copy = false, nsge_copy = false, nnsge_copy = false;
 	struct scatterlist sge, nsge, nnsge, rsge = {0}, *psge;
 	u32 new, i = 0, l = 0, space, copy = 0, offset = 0;
+	bool rsge_copy = false;
 	u8 *raw, *to, *from;
 	struct page *page;
 
@@ -2834,6 +2877,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 			sk_msg_iter_var_prev(i);
 		psge = sk_msg_elem(msg, i);
 		rsge = sk_msg_elem_cpy(msg, i);
+		rsge_copy = sk_msg_elem_is_copy(msg, i);
 
 		psge->length = start - offset;
 		rsge.length -= psge->length;
@@ -2859,23 +2903,34 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 	/* Shift one or two slots as needed */
 	sge = sk_msg_elem_cpy(msg, new);
 	sg_unmark_end(&sge);
+	sge_copy = sk_msg_elem_is_copy(msg, new);
 
 	nsge = sk_msg_elem_cpy(msg, i);
+	nsge_copy = sk_msg_elem_is_copy(msg, i);
 	if (rsge.length) {
 		sk_msg_iter_var_next(i);
 		nnsge = sk_msg_elem_cpy(msg, i);
+		nnsge_copy = sk_msg_elem_is_copy(msg, i);
 		sk_msg_iter_next(msg, end);
 	}
 
 	while (i != msg->sg.end) {
 		msg->sg.data[i] = sge;
+		if (sge_copy)
+			sk_msg_set_elem_copy(msg, i);
+		else
+			sk_msg_clear_elem_copy(msg, i);
 		sge = nsge;
+		sge_copy = nsge_copy;
 		sk_msg_iter_var_next(i);
 		if (rsge.length) {
 			nsge = nnsge;
+			nsge_copy = nnsge_copy;
 			nnsge = sk_msg_elem_cpy(msg, i);
+			nnsge_copy = sk_msg_elem_is_copy(msg, i);
 		} else {
 			nsge = sk_msg_elem_cpy(msg, i);
+			nsge_copy = sk_msg_elem_is_copy(msg, i);
 		}
 	}
 
@@ -2883,13 +2938,18 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 	/* Place newly allocated data buffer */
 	sk_mem_charge(msg->sk, len);
 	msg->sg.size += len;
-	__clear_bit(new, msg->sg.copy);
+	sk_msg_clear_elem_copy(msg, new);
 	sg_set_page(&msg->sg.data[new], page, len + copy, 0);
 	if (rsge.length) {
 		get_page(sg_page(&rsge));
 		sk_msg_iter_var_next(new);
 		msg->sg.data[new] = rsge;
+		if (rsge_copy)
+			sk_msg_set_elem_copy(msg, new);
+		else
+			sk_msg_clear_elem_copy(msg, new);
 	}
+	sk_msg_clear_elem_copy(msg, msg->sg.end);
 
 	sk_msg_reset_curr(msg);
 	sk_msg_compute_data_pointers(msg);
@@ -2915,27 +2975,38 @@ static void sk_msg_shift_left(struct sk_msg *msg, int i)
 	do {
 		prev = i;
 		sk_msg_iter_var_next(i);
-		msg->sg.data[prev] = msg->sg.data[i];
+		sk_msg_sg_move(msg, prev, i);
 	} while (i != msg->sg.end);
 
 	sk_msg_iter_prev(msg, end);
+	sk_msg_clear_elem_copy(msg, msg->sg.end);
 }
 
 static void sk_msg_shift_right(struct sk_msg *msg, int i)
 {
 	struct scatterlist tmp, sge;
+	bool tmp_copy, sge_copy;
 
 	sk_msg_iter_next(msg, end);
 	sge = sk_msg_elem_cpy(msg, i);
+	sge_copy = sk_msg_elem_is_copy(msg, i);
 	sk_msg_iter_var_next(i);
 	tmp = sk_msg_elem_cpy(msg, i);
+	tmp_copy = sk_msg_elem_is_copy(msg, i);
 
 	while (i != msg->sg.end) {
 		msg->sg.data[i] = sge;
+		if (sge_copy)
+			sk_msg_set_elem_copy(msg, i);
+		else
+			sk_msg_clear_elem_copy(msg, i);
 		sk_msg_iter_var_next(i);
 		sge = tmp;
+		sge_copy = tmp_copy;
 		tmp = sk_msg_elem_cpy(msg, i);
+		tmp_copy = sk_msg_elem_is_copy(msg, i);
 	}
+	sk_msg_clear_elem_copy(msg, msg->sg.end);
 }
 
 BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
@@ -2992,8 +3063,10 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 	 */
 	if (start != offset) {
 		struct scatterlist *nsge, *sge = sk_msg_elem(msg, i);
+		bool sge_copy = sk_msg_elem_is_copy(msg, i);
 		int a = start - offset;
 		int b = sge->length - pop - a;
+		u32 sge_idx = i;
 
 		sk_msg_iter_var_next(i);
 
@@ -3006,6 +3079,10 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 				sg_set_page(nsge,
 					    sg_page(sge),
 					    b, sge->offset + pop + a);
+				if (sge_copy)
+					sk_msg_set_elem_copy(msg, i);
+				else
+					sk_msg_clear_elem_copy(msg, i);
 			} else {
 				struct page *page, *orig;
 				u8 *to, *from;
@@ -3022,6 +3099,7 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 				memcpy(to, from, a);
 				memcpy(to + a, from + a + pop, b);
 				sg_set_page(sge, page, a + b, 0);
+				sk_msg_clear_elem_copy(msg, sge_idx);
 				put_page(orig);
 			}
 			pop = 0;
-- 
2.53.0

