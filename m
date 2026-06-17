Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B3743C047
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 14:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781705583; cv=none; b=EDM3TorLlh0riWbJtnENzc1CMFmiAZd1s50e+heHAvPQERa2SROCIRTETu/ibYxVxxebCOgwFVdfbnKYnhK/nUSqZlQo1tnkO8Jmx01Z00d+BIXDarsGZk9R8z8i0BWgGESRKCsH77mogSAfOisEx2FiHKPoTeNvqA/duup8Kx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781705583; c=relaxed/simple;
	bh=TazGMDyi5Zu+TaA95JJ0iJboeSNkc+uNfta8+r6jBDo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Ewi5DRoG4Cpl09VFqd28CkOn7/MgRiMQiu5f8m9FHz6TmjfeRSlg9F5OOBoSemgDqNDsAMWjTAj2/hp83pda3Dn0Q3Zg3vKVNBu+VIuoepsn6igkooWLGX7pYSsTYkxWNvqy+4xZ+gYnAYnrTU6SN2z1vfzB0r2PW+v3TULkqkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=LbrWSQvu; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="LbrWSQvu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781705474;
	bh=SiZgZl+KXpioHUA33Rqr93q8kFRyubtG1N80/wEGa7s=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=LbrWSQvuUHgLYL9c5L7gwxGuZ+Mjks+eDz/bNIUj1AjckFKExPOemDwPZ4nR4Y60I
	 EyXaFhNjGiWy9gGxqz48zH0BGWODs57B1FlHRi3okQll1VfYazLD6SLXu2KtCGaS0T
	 pa1aPVEoC7ZJa8FhAIpmQwyX4c6OKasGG3dohRaY=
X-QQ-mid: esmtpsz18t1781705466t4e2364d7
X-QQ-Originating-IP: hX9LQuFrGhm+LF+Vy7DbrWn5BPlylRUHRRYp657FlVE=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 17 Jun 2026 22:11:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11941053900533370531
EX-QQ-RecipientCnt: 14
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	Rajat Gupta <rajat.gupta@oss.qualcomm.com>,
	Yiming Qian <yimingqian591@gmail.com>,
	Keenan Dong <keenanat2000@gmail.com>,
	Han Guidong <2045gemini@gmail.com>,
	Zhang Cen <rollkingzzc@gmail.com>,
	Davide Caratti <dcaratti@redhat.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.6.y] net/sched: fix pedit partial COW leading to page cache corruption
Date: Wed, 17 Jun 2026 22:10:35 +0800
Message-Id: <20260617141034.1441139-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OYAyLqXFB1msE8gYFfazHxTHuXPVEhn5sRQEdRYDuNKcpKmzu5eQn4rq
	hweAp18HfSaKpXSthnMMce3nnEtrp/Q9lkdZeGgvGfIRb30cBxQJWvN6XK/xzMQCWLsCmu5
	+G7kiMiV7TY0eIgxCtweOW8KCxkfAFa1x2uCLlsWRlzTJVav5LJ1n6U6skQ5mcXBPTmF7ou
	2RZ1qrFuHhzw9wn8Qpdp6DMQZhwEir0FeB7hsijdwr1Daat0y126b38+ExeO5tM6LDKqqgN
	JMWrn5oku17/byzhPD11seipJ0PmWzGdnKWYuuMpFAByF4OpmGEsGvJCW9AuZC99xZAkPk4
	gwvq9U1ATkuPbgXZ91W4YkbLVOvEpdl4V6c368zlQ+zcJX/YeJ8i9lAPiHD80vtyj0TT0B4
	DyPCc51Bn64pgJopHvI/zPunVHzrnJGAE5qnbADSJjCLyUkp1oEQYVt1bTzjiV2NgWQc5sk
	KbgQIAIWWbJhr23t+HxuhmB+GeZjYqNVJa2z0Elr29DcpLEvlue9Y5NDWYEaxGdcWkaj5Mo
	29ijGuSfjL0fWd0oTPGwkvw4lbHjrT2BK9v5eNaqf8g+bsA9Mo88yR9Llnk5BTOBmGQOcj1
	G5SQYt+Y+kQSrpaCE4O0+0VlknIx9L8AuoBfgeI/gOSqq1qKQTUwlk/YPLDaOCrLdykTIZb
	VGEZ2RTiTrElrttXS3EV1PIajxm4Ju/Z8GTScbnJkC1ptEN7yJ4kybp3yu0GXiNQhMOpeCq
	Cj+RJZFfhJm4twExQzMt5GE5aIsgbLvoadtrWKV/FrtzjU0/tqTR4hVZJ8/9OHnW8GSnCp/
	sIwYif/xGY19pKDeFGWJGjaHjI0RwvRQV0NSjDFGBNaySkLpQnhsGWTqeNVAho07i+4mYhF
	VBW05DWa9qLChkxJqlS1xioVn+b0TLapEBsRYjNawOg0NBF2vLLroLYacT9NjoZO8GOCTyR
	F6Gt3Cc8V/e42Ys4vN/MYV9eGbCSIyc/Z5IO2SZZWsPVFiQSa13yrItz1VLPHHyrHbBScNW
	MiLHdT6UbtJiJU6A+rPjIaym0bIPcLvL6Kn3Znmvx3f9rcEiln/bztpftmh6PTFjmy8O8hZ
	Dm35nusp7qL41/PHknkwqGyMcfDEO5WVdaDFR+wK/2qaZQb+jjXCQU=
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
index 1ef8fcfa9997d..80b2a1e9d5ceb 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -16,6 +16,8 @@
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/slab.h>
+#include <linux/overflow.h>
+#include <asm/unaligned.h>
 #include <net/ipv6.h>
 #include <net/netlink.h>
 #include <net/pkt_sched.h>
@@ -242,7 +244,6 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 		goto out_free_ex;
 	}
 
-	nparms->tcfp_off_max_hint = 0;
 	nparms->tcfp_flags = parm->flags;
 	nparms->tcfp_nkeys = parm->nkeys;
 
@@ -268,14 +269,6 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
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
@@ -318,15 +311,12 @@ static void tcf_pedit_cleanup(struct tc_action *a)
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
@@ -393,18 +383,10 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
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
 
@@ -412,10 +394,11 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
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
@@ -433,13 +416,15 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
 
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
@@ -451,31 +436,51 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
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

