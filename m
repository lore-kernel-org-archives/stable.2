Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B5530C16E
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 03:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781754987; cv=none; b=toMO2djli7Oun832734HFnbpAnapqPwL244MKEu1sPPOOgiGCAWWkdzMNC5XBvTiTzh4EYYZB9MsSrCX4apFzqpfXbaGIQN5UcdOxci5Gv/aP2AW6AbC0bUs6uJn4opLzAhG3j+I2Oya6c/Q+NBVIchQkW0dVCMeJv2+sHsl9Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781754987; c=relaxed/simple;
	bh=mtEiOFe3kjGVe5R6D6J0+B++Em/gnf5a1/k/N2tBwI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uMtmOeRHdc24B9SrGR8JsQkFeQ77K8pYJJDo4tOWSjuqAIk4ixReq4vzuuFFrYUIyBYPLUgwA3IYlh3m6Tuz9OZxceIW+A0EaA5jAX8eR3JTPg2j37vWfLyObdoHhSmKflG1+O0qDNfBMvqU83vb/z6aDPRJ7f31cp5fLcfqKNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=oJfct4dm; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="oJfct4dm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781754974;
	bh=DjH7f2Pfer0jIvgK0rolhudWngRgwYN3S+2M3roVzO4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=oJfct4dmEkcYdoOOlzymJAODjPFOQJ9AOOXG1NFk7WmDhmUj6tZLWMyLtzfXc6zQH
	 rgroR+KLOSvWOEPl86SQeH8Ztqsrs9LP19jfKfF3/8qZE3JtG60+MB15k0b4oLqDlL
	 k+YcduYektitNtzYFfayfCoi/BCnPTv1CPHC12N4=
X-QQ-mid: esmtpsz20t1781754969t8c608ff2
X-QQ-Originating-IP: fhUaaSSsvTZdXQL4eWwtWKy7p4Bas67g96BYLjpe3hs=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jun 2026 11:55:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7261180316134589788
EX-QQ-RecipientCnt: 14
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org,
	gregkh@linuxfoundation.org,
	guanwentao@uniontech.com
Cc: stable@vger.kernel.org,
	2045gemini@gmail.com,
	dcaratti@redhat.com,
	jhs@mojatatu.com,
	keenanat2000@gmail.com,
	kuba@kernel.org,
	rajat.gupta@oss.qualcomm.com,
	rollkingzzc@gmail.com,
	toke@redhat.com,
	victor@mojatatu.com,
	yimingqian591@gmail.com
Subject: [PATCH 5.15.y 3/4] net/sched: fix pedit partial COW leading to page cache corruption
Date: Thu, 18 Jun 2026 11:55:08 +0800
Message-Id: <20260618035504.1536870-4-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260618035504.1536870-1-guanwentao@uniontech.com>
References: <20260618035504.1536870-1-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: MIZzEYJg5KaTXMfYCG17/ufk76X6iGGNK/GrI+hGr8KCcwozEP9DQyCr
	Q+0ViazoxUB7ArrnAW4/voU4fkejLIoDRsWQwLyYm8lpzf54arvi1qhVfiuoYjHpPf0a13L
	i1Vfor50sKfE1DD8iKwFq5sphOkheKrIqsSvfklWAYk6OEoK0BUUHqe6+06YCwjxa60ECez
	GnWHbiMlxsyf82r/PwY77Egk2vtGlVuYnge+xXQaM9ET0OMNM2WB+ia+DTxA//TJw8fs91v
	uqXJq7Cb1ScOc02gcuX/hBDM957gA/FNzup0cFd19+yc3C6JzqqQDU+O43RvvTFa3x55LsA
	J/brLGDImL2BCwbmuRkIqTWCjqEAyvS3VI11cwoUslxSx51y3oMP255gzMLwCTUwJ3r64gj
	K6N1k4u9EF0bRCeWmf4vpCZ/ufRoXIUK3HKATUSfFoFawn3Ymg3ddgem7lHXVgCYaPKv0ll
	WIKZjhnzVVoe4DlU/8opATb0X/Ms+MlncampkBXt7mzCYAzhRE8j9PfKYz5L45bbM7vsQDp
	dVUFfa0FOs8wc1lxob/WB5JdqBIrKwWr/y7wEFnolssq+rkuIvwg/NdDvZM55C11J1gKEeE
	AcLXP7q/YDMonTVye+x3tdaaMp8FfdLpGnGR3By1e0fCcRVHsuH4nbx5H9fimhy8OGmxg3O
	htXe58QxpdUt+X1+Res1hNz8gH4WOoAUy0rqGmHK1T1xuR2/7vmvpIRvAH8IGHseo8VHIws
	NHTdSDdPWZoFvP65Hz5TN4ZO1kON2Zevu0fNt+YIKruG4uoEIn08moerYTsW9yb5IEsiO9D
	3BbV7FBxZX2qopHQUOaNcnMEN17sYUHG2CKRXXakfhTNuxK9mnhSn2Kp8sYWeSnGJfWsqP9
	oHPQvmnG9caY+58A3VOHmEng0Hjyz4hqlBm5d11yUEW0eMDdZRbvJYEocDGW1zg1XlyKX+e
	A1TktZyrDOLBkX86Dq4POiPEuymImv3+bKjmA8rV+P5QyyZMKEVtUClvbDtyEnFK2Yg2w6c
	BzROjA58Q3Q44j0jpVkjyhh/RTrsrz7g7Zu2rsJmHHcZqrEUqfaIWAELDTxdgW2NPFOmMsC
	s0S0Lxvr5a6il6OP9CGLtJa+R8k4oVrJo6ApQ6KoXxpcujvqNJwiT4AgZ7tfwSnyFKxxDRM
	bFi6d8O/XhZLytFY/iGU3u9VJm0/nSJBZqqp
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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
index 46436b7641c14..8f50cbdd5aff9 100644
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
@@ -237,7 +239,6 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 		goto out_free_ex;
 	}
 
-	nparms->tcfp_off_max_hint = 0;
 	nparms->tcfp_flags = parm->flags;
 	nparms->tcfp_nkeys = parm->nkeys;
 
@@ -265,14 +266,6 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
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
@@ -313,15 +306,12 @@ static void tcf_pedit_cleanup(struct tc_action *a)
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
@@ -387,18 +377,10 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
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
 
@@ -406,10 +388,11 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
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
@@ -427,13 +410,15 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 
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
@@ -445,31 +430,51 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
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

