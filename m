Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F27B3AE71F
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 18:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782497344; cv=none; b=TmIbEKT2pq2szbB7sQWC/1hnLiyEQMHtfHbhkdUi3r+tK3HS3L/0A0PcBdVybMQ0/yUvWhQDElFsT4WH7BpnECHjUhCT8gpvxu2KwILmz6OybUZWwKSh+ZcSo9Uqi00gYSeUa3nr95qmSqrDQNLot/+DT06L31D0l7DTaRlQw+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782497344; c=relaxed/simple;
	bh=iNpfBfAoz8GS6C7jzygopmtIMsmx9k8ngRxrJHcrIyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PWHyQXS3Q02ZEfkcAr+IKGKaoydwDuz3dr/zAagHQUCUvJndvebmNcjGhjfxIyb41R6x6Zncgh6zXCjg6qzGPR11jMHRQYtJbpWPGdzu8HQGd9l556JMKgbjYobYlYDr/Du0RqQ0aU0RWPhD/SXeHaWZiYyw7d7TK/er/iDLzz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=l4wEcqwZ; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="l4wEcqwZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782497323;
	bh=3DeybM6o9o6UbawMVbIHKh36wz1osYZe1E4mk/ENzhw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=l4wEcqwZTTylYRar8sz1fdQl3AA31z+Dk2wCn5Bx0ANwuoMltB+FXlGEjVg0P6Ieq
	 PRdQ40tKSWovLHT9bWnkFam1WWw807P9pd1YY+ubW0wQCHc0MNL6IpMU8kcc0ey4Fd
	 V5dchobw9G+t7D6qIZNnLYT+oUsLBjSyjQeX0Siw=
X-QQ-mid: zesmtpgz6t1782497305t39bd202e
X-QQ-Originating-IP: j9NvO0UgAWlgF3B0uIvF8WeVjceBSLGYmb8RKu0eB+o=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 27 Jun 2026 02:08:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17009071771391386434
EX-QQ-RecipientCnt: 17
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: 2045gemini@gmail.com,
	davem@davemloft.net,
	dcaratti@redhat.com,
	gregkh@linuxfoundation.org,
	guanwentao@uniontech.com,
	jhs@mojatatu.com,
	keenanat2000@gmail.com,
	kuba@kernel.org,
	pctammela@mojatatu.com,
	rajat.gupta@oss.qualcomm.com,
	rollkingzzc@gmail.com,
	simon.horman@corigine.com,
	stable@vger.kernel.org,
	toke@redhat.com,
	victor@mojatatu.com,
	yimingqian591@gmail.com
Subject: [PATCH 5.10.y v3 08/10] net/sched: fix pedit partial COW leading to page cache corruption
Date: Sat, 27 Jun 2026 02:07:33 +0800
Message-Id: <20260626180735.297017-9-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260626180735.297017-1-guanwentao@uniontech.com>
References: <stable-reply-item001-act-pedit-510-20260626@kernel.org>
 <20260626180735.297017-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MaKS3GnkkUATXPVAU3RNeuF12FJVGNiBOWtG4i8fgMuGLun1i7wy+vJP
	RFrWEMOKn8eu9FrNEqKolzegRioVHja1g8W4r0E2rYnFhE54/OkDpBRnOiPHiZChdi+g6R7
	GRChMV4D2FKJ1xx0PqfEWd5sagZeSpLLqdroHcJ2DzC+KUn2zT/DXrcotBx7NTA9qfXgZ+0
	0O5IJZrBzyWTErpSI26tn4xVHn4yqAE2fzxH4Nz1MyODarrn38l8vFi8pxL4po0K73vp7Dh
	9ZofY0H5sbrLUG8ONpNu/CZ6Wl+ZxnhQlnfWZzLZCgBgswN0xDZBtP2mhImNH3/k6rCi2gm
	00U2ptmI8g6I952syj5PX/rMHU/j+slWSqUpnyBKL8KjT3kKGP/eavM9vcqZ6AtwANZpTgh
	ttw+++BTQPovjtG/FjVXHqVnu0P0L1BAlnMJhxu3tmvdVnsRhkFbkcZMzgFkL8Nmu3PnS4/
	s0Xdn6VCKfuerWOLHsbe+w44jzyxxCSQI5AfJM3Z6OHusG8HnQzrIrfgem3IENirU6HAiC6
	8IuCC3rObFska9VcqZlR/ye5l+Hpi8VHTQ9crgINY8uiSQkhxYs4bhXheniCyJ6mgudnU/e
	98MCD78Jdzm/yDRpo/7mQAFeZ7XCijQGaAVNTtpQq6fa0qnIk2Bp9ogX9kkduiseXgWl9kL
	0jc5Gkr/IM5sf4P2fZhEj6d1MUfTbSt8dglaYHvV1dmyTuywDtW4zMQ2AQtwvTZoPnJm9XT
	iMW2besfp7yn/Ol4vL+/N1CUBVAmL2ZhM6eNSlPqnLPMI2BnBVmUPw0exzsyMxb9Deo7JFh
	Ktdua50yDUNMhRFfd7ava8DNlfvGRmo8RxVos6BKVvrXKZ2f9AN9m417U5ZV10RJpYYIqs7
	109KETO0KP01MFs2gYJoAgFKNmNJZtyIimbsoc9Mh3kOtnJa/ZTHIGq/NqXCSSjEutDa7IO
	UQVahrm5GcURJHOqWXSRXqPAAgQlB4kwZ6k9ugUk4PN3rWji64kYQiFsQl40lsO29RNd1T1
	f+UEtpVXc4ATEGkrEqcHM43inMB6PjJK0LDVxsQ9Vvmp1HgaZ8iIrFUOs8NyZLXNa+MGoiR
	BkofD3TnUwQ/WiS3rfqWitf4hXlnkhkGf3vfPIRFUO9zzpMMgHCmxQqDXfL0wxVZm67xjnA
	GpmCohoGO76rfts=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

From: Rajat Gupta <rajat.gupta@oss.qualcomm.com>

[ Upstream commit 899ee91156e57784090c5565e4f31bd7dbffbc5a ]

tcf_pedit_act() computes the COW range for skb_ensure_writable()
once before the key loop using tcfp_off_max_hint, but the hint does
not account for the runtime header offset added by typed keys. This
can leave part of the write region un-COW'd.

Fix by moving skb_ensure_writable() inside the per-key loop where
the actual write offset is known, and add overflow checking on the
offset arithmetic. For negative offsets (e.g. Ethernet header edits
at ingress), use skb_cow() to COW the headroom instead. Guard
offset_valid() against INT_MIN, where negation is undefined.

Fixes: 8b796475fd78 ("net/sched: act_pedit: really ensure the skb is writable")
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Reported-by: Keenan Dong <keenanat2000@gmail.com>
Reported-by: Han Guidong <2045gemini@gmail.com>
Reported-by: Zhang Cen <rollkingzzc@gmail.com>
Reviewed-by: Han Guidong <2045gemini@gmail.com>
Tested-by: Han Guidong <2045gemini@gmail.com>
Reviewed-by: Davide Caratti <dcaratti@redhat.com>
Tested-by: Davide Caratti <dcaratti@redhat.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Tested-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Link: https://patch.msgid.link/20260531123221.48732-1-jhs@mojatatu.com
[rename include file from linux/unaligned.h to asm/unaligned.h]
Conflicts:
	include/net/tc_act/tc_pedit.h
	net/sched/act_pedit.c
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 include/net/tc_act/tc_pedit.h |  1 -
 net/sched/act_pedit.c         | 77 +++++++++++++++++++----------------
 2 files changed, 41 insertions(+), 37 deletions(-)

diff --git a/include/net/tc_act/tc_pedit.h b/include/net/tc_act/tc_pedit.h
index 83fe399317818..a26d4cd3b8d6f 100644
--- a/include/net/tc_act/tc_pedit.h
+++ b/include/net/tc_act/tc_pedit.h
@@ -14,7 +14,6 @@ struct tcf_pedit_key_ex {
 struct tcf_pedit_parms {
 	struct tc_pedit_key	*tcfp_keys;
 	struct tcf_pedit_key_ex	*tcfp_keys_ex;
-	u32 tcfp_off_max_hint;
 	unsigned char tcfp_nkeys;
 	unsigned char tcfp_flags;
 	struct rcu_head rcu;
diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index df31b2b7b4225..35fa94ba0edf8 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -17,6 +17,8 @@
 #include <linux/ipv6.h>
 #include <linux/slab.h>
 #include <net/ipv6.h>
+#include <linux/overflow.h>
+#include <asm/unaligned.h>
 #include <net/netlink.h>
 #include <net/pkt_sched.h>
 #include <linux/tc_act/tc_pedit.h>
@@ -229,7 +231,6 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 		goto out_release;
 	}
 
-	nparms->tcfp_off_max_hint = 0;
 	nparms->tcfp_flags = parm->flags;
 	nparms->tcfp_nkeys = parm->nkeys;
 
@@ -257,14 +258,6 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 						   BITS_PER_TYPE(int) - 1,
 						   nparms->tcfp_keys[i].shift);
 
-		/* The AT option can read a single byte, we can bound the actual
-		 * value with uchar max.
-		 */
-		cur += (0xff & offmask) >> nparms->tcfp_keys[i].shift;
-
-		/* Each key touches 4 bytes starting from the computed offset */
-		nparms->tcfp_off_max_hint =
-			max(nparms->tcfp_off_max_hint, cur + 4);
 	}
 
 	p = to_pedit(*a);
@@ -305,15 +298,12 @@ static void tcf_pedit_cleanup(struct tc_action *a)
 		call_rcu(&parms->rcu, tcf_pedit_cleanup_rcu);
 }
 
-static bool offset_valid(struct sk_buff *skb, int offset)
+static bool offset_valid(struct sk_buff *skb, int offset, int len)
 {
-	if (offset > 0 && offset > skb->len)
-		return false;
-
-	if  (offset < 0 && -offset > skb_headroom(skb))
+	if (offset < -(int)skb_headroom(skb))
 		return false;
 
-	return true;
+	return offset <= (int)skb->len - len;
 }
 
 static int pedit_l4_skb_offset(struct sk_buff *skb, int *hoffset, const int header_type)
@@ -379,18 +369,10 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 	struct tcf_pedit_key_ex *tkey_ex;
 	struct tcf_pedit_parms *parms;
 	struct tc_pedit_key *tkey;
-	u32 max_offset;
 	int i;
 
 	parms = rcu_dereference_bh(p->parms);
 
-	max_offset = (skb_transport_header_was_set(skb) ?
-		      skb_transport_offset(skb) :
-		      skb_network_offset(skb)) +
-		     parms->tcfp_off_max_hint;
-	if (skb_ensure_writable(skb, min(skb->len, max_offset)))
-		goto done;
-
 	tcf_lastuse_update(&p->tcf_tm);
 	tcf_action_update_bstats(&p->common, skb);
 
@@ -398,10 +380,11 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 	tkey_ex = parms->tcfp_keys_ex;
 
 	for (i = parms->tcfp_nkeys; i > 0; i--, tkey++) {
+		int write_offset, write_len;
 		int offset = tkey->off;
 		int hoffset = 0;
-		u32 *ptr, hdata;
-		u32 val;
+		u32 cur_val, val;
+		u32 *ptr;
 		int rc;
 
 		if (tkey_ex) {
@@ -419,13 +402,15 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 
 		if (tkey->offmask) {
 			u8 *d, _d;
+			int at_offset;
 
-			if (!offset_valid(skb, hoffset + tkey->at)) {
+			if (check_add_overflow(hoffset, (int)tkey->at, &at_offset) ||
+			    !offset_valid(skb, at_offset, sizeof(_d))) {
 				pr_info_ratelimited("tc action pedit 'at' offset %d out of bounds\n",
 						    hoffset + tkey->at);
 				goto bad;
 			}
-			d = skb_header_pointer(skb, hoffset + tkey->at,
+			d = skb_header_pointer(skb, at_offset,
 					       sizeof(_d), &_d);
 			if (!d)
 				goto bad;
@@ -437,31 +422,51 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 			}
 		}
 
-		if (!offset_valid(skb, hoffset + offset)) {
-			pr_info_ratelimited("tc action pedit offset %d out of bounds\n", hoffset + offset);
+		if (check_add_overflow(hoffset, offset, &write_offset)) {
+			pr_info_ratelimited("tc action pedit offset overflow\n");
 			goto bad;
 		}
 
-		ptr = skb_header_pointer(skb, hoffset + offset,
-					 sizeof(hdata), &hdata);
-		if (!ptr)
+		if (!offset_valid(skb, write_offset, sizeof(*ptr))) {
+			pr_info_ratelimited("tc action pedit offset %d out of bounds\n",
+					    write_offset);
 			goto bad;
+		}
+
+		if (write_offset < 0) {
+			if (skb_cow(skb, -write_offset))
+				goto bad;
+			if (write_offset + (int)sizeof(*ptr) > 0) {
+				if (skb_ensure_writable(skb,
+							min_t(int, skb->len,
+							      write_offset + (int)sizeof(*ptr))))
+					goto bad;
+			}
+		} else {
+			if (check_add_overflow(write_offset, (int)sizeof(*ptr),
+					       &write_len))
+				goto bad;
+			if (skb_ensure_writable(skb, min_t(int, skb->len,
+							   write_len)))
+				goto bad;
+		}
+
+		ptr = (u32 *)(skb->data + write_offset);
+		cur_val = get_unaligned(ptr);
 		/* just do it, baby */
 		switch (cmd) {
 		case TCA_PEDIT_KEY_EX_CMD_SET:
 			val = tkey->val;
 			break;
 		case TCA_PEDIT_KEY_EX_CMD_ADD:
-			val = (*ptr + tkey->val) & ~tkey->mask;
+			val = (cur_val + tkey->val) & ~tkey->mask;
 			break;
 		default:
 			pr_info_ratelimited("tc action pedit bad command (%d)\n", cmd);
 			goto bad;
 		}
 
-		*ptr = ((*ptr & tkey->mask) ^ val);
-		if (ptr == &hdata)
-			skb_store_bits(skb, hoffset + offset, ptr, 4);
+		put_unaligned((cur_val & tkey->mask) ^ val, ptr);
 	}
 
 	goto done;
-- 
2.30.2

