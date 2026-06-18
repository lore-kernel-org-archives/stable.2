Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEA92D0C7B
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 04:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781757411; cv=none; b=Cqje1t/TplmBnRxxBd2ZPpD1oEzEr+AteM9fKeGYjr/OcW43Yik2cxYFHDRNqdeBv57wpOLnA68YnYipYgmNITTEyrjXOF2xEwRqb1kbvAktZ9VKgWkYRluGmvIwhh1XmtdbQwgWikRgjA/GMbMMIPXdM7z+YEEr5TgmDaANHZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781757411; c=relaxed/simple;
	bh=wdf+rXznXZNDTv5ZJFXbXqpt33joiwj9yqIBa4R0G1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qHcnmzjRL6SLU8E/5+nhXX7WktcVEWLJRL1do6r3C1aOmgv+WaZdznZSWsW+IjFpJEACJmkg6X2IZa46v6gVDQ16OI5TujeoFOqhWZZYnqBqD04QOpJ/eWjqMFHknGyhacRXBB9PeoFQqAwfLpWoNgtANBy/COn9fwfu6ryldYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Bf46RUE/; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Bf46RUE/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781757395;
	bh=MnefkohG4c0xDrVpUWDXL5gvGrSQKUWA+hcyK6JHJT8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Bf46RUE/EILPQ4IHQ9zG/wYmNcRym6ZoWwRJInYlYnUG4F+LRyOK/DnK+qWZA+dEG
	 btghycRXcZM2T4devfeHJg8KqzNVIuAIjurjFuf7nixUi4kaG/QoOgz6V4vvfdE5eY
	 q/2UFhttmosQ1UfY+0Vp2pA8TEwZmyTA8JkQ5ilM=
X-QQ-mid: zesmtpsz6t1781757390t268869b1
X-QQ-Originating-IP: dSRwpbLmnS1Ik2Bd1Fp9FLzPNsuOICo+oeA5sAk181g=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jun 2026 12:36:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1755222019539035511
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
Subject: [PATCH 5.10.y 7/8] net/sched: fix pedit partial COW leading to page cache corruption
Date: Thu, 18 Jun 2026 12:35:39 +0800
Message-Id: <20260618043539.1557035-8-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260618043539.1557035-1-guanwentao@uniontech.com>
References: <20260618043539.1557035-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OCe9AHS8pZALL+Kfoe4sPy0YUkjaAGOmbMELKikKlk+qvOuHY47js6I4
	82ew68wbCX4ZLQuSOmwgTHiXyuZFrVIXyveyusgoBUjnXWC09/5FtjRKGBj8WwoJVbPEZNp
	kQIVBXR81FdCLcanUvM8I8lDENjVYQmxJsAK5pu3JrFHC1SPLQtiQQUgOFn+sbF3qNBoXNN
	q+msoBDZ1nvNupLpKO7WZUsBfn9Pcq6g6HzVWQwvQqXBAvG3XENBe4iXJapJLgnO2j5603j
	qFBraofFuh13ozh9qQD2BIrh7+neVkwD2zm32Tuvs2B4Xs3yz9G+qJtByAEeiXmsHtGwfpH
	zg4tzVFS/kpW+1Yi1BFYMdWj/vRh3f6ZBARyZIbIHCmG0SLQBFHOI4KPoViHhItOiamPLQX
	buOMxaoAdPTnvweSorMgDCbA2lAv4hTd3rMJoOHLJfyaBax36C/JQ/GP4FQz6mQS3ybzgGV
	vo2lSCSrEiLU4NHol8JpHJYHC+PrzBiOGlKTjhVcancwDEqZ+6wXNs16iRcE7x+2Z0iRGVJ
	2ixTH8p8WDWwYUbJ/n0mlK7cCd53EU6ndIClEtLU+JOxrNFmWHSRzDwB1gkdH3YZwzLKFuy
	XSudfSTIqT/bW3ukodkuKrJD8hFcZuGRjv+Vb/jGQH0oiAzDj8gJIsdV3k2Kb65X3pINTiD
	0HEcMJ2ec+djam96ps2CDUqjuZfJggq9aWsdp2BDm1XXiEGCOy8TxdtusgG/ctaq4KS0sXR
	LPx33MFkISrDvZ5EHGVX3DnJ/QMlpltceIiIRFmODbC76a0OMTTF9Pvn9Agb+avDxtc7HTM
	Dy6RwyBNhbK6WowTmzymPnkqP7EKl+jA+G/se55SF/gseTxLuPMZIN56J5eFmarb3+1TYxE
	bpXwRtspxnLxvF1/6fOE0GeChdlrdalNKgVE/bo5XT6ccHsX9se1EJLDSVWY1FuWj92ICcd
	fKPV5J0nPQNzjHXcfhbCLEoPIMFc1RPYZ3FKNxZGg/3d/XlI+5dTAGXON09Sa7e2ztCObK2
	fOgZOzJhH+bZ7ZjsjJys1Lrr6/xy3RUAzTvwNBy22eE5tExGcNljsAI/irO+ny/inXg18Iq
	M9u4Vg503xQe5jaB7ytiu38Xta6WaZnjhEBq0H4yAcf5PI1zGDDm+dd0ob7bwo7E2UYR4DI
	4LOMqWzCjKBMJu2Z03P+7H69wc9+4ieDtR2xpYiEdBqRDWI=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
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
(cherry picked from commit 44e1ecb811c3e0823a20854735cb9b2a4e71978c)
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
index ecad6fc39dc3d..250f4ffa48371 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -14,6 +14,8 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/overflow.h>
+#include <asm/unaligned.h>
 #include <net/netlink.h>
 #include <net/pkt_sched.h>
 #include <linux/tc_act/tc_pedit.h>
@@ -226,7 +228,6 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 		goto out_release;
 	}
 
-	nparms->tcfp_off_max_hint = 0;
 	nparms->tcfp_flags = parm->flags;
 	nparms->tcfp_nkeys = parm->nkeys;
 
@@ -254,14 +255,6 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
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
@@ -302,15 +295,12 @@ static void tcf_pedit_cleanup(struct tc_action *a)
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
 
 static void pedit_skb_hdr_offset(struct sk_buff *skb,
@@ -346,18 +336,10 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
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
 
@@ -365,10 +347,11 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 	tkey_ex = parms->tcfp_keys_ex;
 
 	for (i = parms->tcfp_nkeys; i > 0; i--, tkey++) {
+		int write_offset, write_len;
 		int offset = tkey->off;
 		int hoffset = 0;
-		u32 *ptr, hdata;
-		u32 val;
+		u32 cur_val, val;
+		u32 *ptr;
 
 		if (tkey_ex) {
 			htype = tkey_ex->htype;
@@ -381,13 +364,15 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 
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
@@ -399,31 +384,51 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
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

