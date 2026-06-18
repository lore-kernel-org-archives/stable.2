Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE102D0C7B
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 04:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781757419; cv=none; b=ucu7qET+cLBt+dsIVubilg/7CG5GrCLQdESqwlAWq9wtV1nAmDfBcHrPUyDQbFZK6G/KAKQ2j3rTqhalmsgpkAh6jB0nYrabJp7SVqkQYvPzq8A5Qww5+3Es/Ir6rnt6nU1rurWeVt/5rmuCQcKxuoDRMTLlzf96CaYIF/HQgow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781757419; c=relaxed/simple;
	bh=uo1XAmEbUH5irHyhYLerz6z1b1F9GCGmTodCMf2dpf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OkbEPHJV1rLlAzdHeHcrNIE+7sUngB/KCmcs6m0VOBCieMPqIajQMj/h5eHPVRNLviY+ZR3vodn/a4K5mCys+3bv/zGGWeZwYYIK64O7OmbVR2hVyCIW+jnysC7iHdRKEzLWUCRZBREpFmAXy/T4dEGzTcW6zIu5foJdfbwJxiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=SCE0apLL; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="SCE0apLL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781757390;
	bh=gMpDRy0OuCwJAYu/wVeFV4tLWGcqaI0mrmihromf0ac=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=SCE0apLLkS+0zEn1JhO5ASvqk8rlWHEQXwsfmBq5cLHS4uMq/BU1REhZC6qoHn/BB
	 l9T0JZ0HzpG+Amu6THXXv62BYGIf+fud/okyXVDvIAsKd4W1OQIZyCl5CxCXru6ej9
	 m0zgKUfTzWy0I/eE9PNa3WMtHzJ9cSJckcuvN8fI=
X-QQ-mid: zesmtpsz6t1781757369t88b398c9
X-QQ-Originating-IP: Wu+7fEA5dC81A5pHvHBfJzqCY+cLTHARBoQMmkq1Vuk=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jun 2026 12:36:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4877917839465811428
EX-QQ-RecipientCnt: 17
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
	yimingqian591@gmail.com,
	Pedro Tammela <pctammela@mojatatu.com>,
	Simon Horman <simon.horman@corigine.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.10.y 3/8] net/sched: simplify tcf_pedit_act
Date: Thu, 18 Jun 2026 12:35:35 +0800
Message-Id: <20260618043539.1557035-4-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260618043539.1557035-1-guanwentao@uniontech.com>
References: <20260618043539.1557035-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: M9j7+QidRYx1Saa1icNRSUZe78g2G1QSD3+bhOTSxowy4y0HVQxvDRDJ
	LptZKil1ozqeEgLdoKlHi6KkUDPmAHpJ4yHxfIZ0QThhjRKFdgK71g914ePMT0ZCH4jTTbq
	QVxqHDyGg+OTCTFV57/1V3Iym9YrjSSmCuvQlqhGqKLDYP954noEFWZfGB1vLBHQ3ryB93q
	DuYRuR2eXrBT1WTkfDeKHNjfajpojwXzaih1YOTXsNho7bKwK+oons0dMnf7VcxT1QC1+A6
	ZewpTEp919gqCEfJM2lbz/yE1JLcHsf8KJfbj6MKG6P/+L+2H2AIel2K3NERL9jJpUdAMG3
	9lzB8ri0TrL1ZyFdfzfa+GymATvz0UvDCEUzboOfBI8KW/WSUaiNQ+kJFD4VU4aUmumm/z+
	yzBGQzSpbMins9QbVuZN9zBCrXFE64OVjkNe0TjSoq2tlxP47jIkBobpFjP4BfO348DkAh7
	NoLaqt02FJ36aTP5WG7XWks0y4zT6Utn4tB7/yWlFHJehXmAZtSIRFW0PcfnKvGSwwX78t9
	WqTpzlS0eBc3LjCAcbRmdNiRmns5bdo9TaUeiw0sXwQKazs9kY92ceg5Znkf4x75hYxD0FS
	+SpLw883yarusCkJKp3lAsyvipJ3zyKMkHs5ojTHHqAkgVZ86xDFKtfMUMa+UPVwOdNoelG
	gw1o0l6aoAglv3rgNnFFYlOIvHGqydAD9+f6zAF4R2ximnJyeHBUNS3RRmCLATa01RfD4fQ
	yY8wcEljaRJ6wY+oV0FKRbMWGkri8sSjvQaCSfyRGSw5ACfoiEYa6jZeZUm9pMiBSVrpUfD
	RWmzVRsL9P0OKO9xXA8a0WqofGqiKnloe81OrIeTII0yopw8fakxa8482RU666sgcs2O+1L
	kxokTp7N+stkDaGiouKf2nr6AL1LXg3S3ajGkyNVbuMXtZHa9vArq/eD/X18uf8R5MlsiIJ
	vgtOIbjbB+GorWssquFM5g9TALOjnxMszfEbxgithB1OiEnmiZDcfW5yAtt7rhF7HTnWM4S
	BGnr1hLwMppgPfR9HMTB8vmnzw7vpiECHNN2aaQz8xa5QxGjTq/XOnRZCKsWWjebZc9mlE3
	rvPH2fzuU9PXNijYjpW64QMegdJPJ/Z8A==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

From: Pedro Tammela <pctammela@mojatatu.com>

[ Upstream commit 95b069382351826c0ae37938070aa82dbeaf288d ]

Remove the check for a negative number of keys as
this cannot ever happen

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
(cherry picked from commit 95b069382351826c0ae37938070aa82dbeaf288d)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 net/sched/act_pedit.c | 137 +++++++++++++++++++++---------------------
 1 file changed, 67 insertions(+), 70 deletions(-)

diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index 0fbffebfbdc9d..84152d3a49246 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -341,8 +341,12 @@ static int pedit_skb_hdr_offset(struct sk_buff *skb,
 static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 			 struct tcf_result *res)
 {
+	enum pedit_header_type htype = TCA_PEDIT_KEY_EX_HDR_TYPE_NETWORK;
+	enum pedit_cmd cmd = TCA_PEDIT_KEY_EX_CMD_SET;
 	struct tcf_pedit *p = to_pedit(a);
+	struct tcf_pedit_key_ex *tkey_ex;
 	struct tcf_pedit_parms *parms;
+	struct tc_pedit_key *tkey;
 	u32 max_offset;
 	int i;
 
@@ -358,88 +362,81 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 	tcf_lastuse_update(&p->tcf_tm);
 	tcf_action_update_bstats(&p->common, skb);
 
-	if (parms->tcfp_nkeys > 0) {
-		struct tc_pedit_key *tkey = parms->tcfp_keys;
-		struct tcf_pedit_key_ex *tkey_ex = parms->tcfp_keys_ex;
-		enum pedit_header_type htype =
-			TCA_PEDIT_KEY_EX_HDR_TYPE_NETWORK;
-		enum pedit_cmd cmd = TCA_PEDIT_KEY_EX_CMD_SET;
-
-		for (i = parms->tcfp_nkeys; i > 0; i--, tkey++) {
-			u32 *ptr, hdata;
-			int offset = tkey->off;
-			int hoffset;
-			u32 val;
-			int rc;
-
-			if (tkey_ex) {
-				htype = tkey_ex->htype;
-				cmd = tkey_ex->cmd;
-
-				tkey_ex++;
-			}
+	tkey = parms->tcfp_keys;
+	tkey_ex = parms->tcfp_keys_ex;
 
-			rc = pedit_skb_hdr_offset(skb, htype, &hoffset);
-			if (rc) {
-				pr_info("tc action pedit bad header type specified (0x%x)\n",
-					htype);
-				goto bad;
-			}
+	for (i = parms->tcfp_nkeys; i > 0; i--, tkey++) {
+		int offset = tkey->off;
+		u32 *ptr, hdata;
+		int hoffset;
+		u32 val;
+		int rc;
 
-			if (tkey->offmask) {
-				u8 *d, _d;
-
-				if (!offset_valid(skb, hoffset + tkey->at)) {
-					pr_info("tc action pedit 'at' offset %d out of bounds\n",
-						hoffset + tkey->at);
-					goto bad;
-				}
-				d = skb_header_pointer(skb, hoffset + tkey->at,
-						       sizeof(_d), &_d);
-				if (!d)
-					goto bad;
-				offset += (*d & tkey->offmask) >> tkey->shift;
-			}
+		if (tkey_ex) {
+			htype = tkey_ex->htype;
+			cmd = tkey_ex->cmd;
 
-			if (offset % 4) {
-				pr_info("tc action pedit offset must be on 32 bit boundaries\n");
-				goto bad;
-			}
+			tkey_ex++;
+		}
 
-			if (!offset_valid(skb, hoffset + offset)) {
-				pr_info("tc action pedit offset %d out of bounds\n",
-					hoffset + offset);
-				goto bad;
-			}
+		rc = pedit_skb_hdr_offset(skb, htype, &hoffset);
+		if (rc) {
+			pr_info("tc action pedit bad header type specified (0x%x)\n",
+				htype);
+			goto bad;
+		}
 
-			ptr = skb_header_pointer(skb, hoffset + offset,
-						 sizeof(hdata), &hdata);
-			if (!ptr)
-				goto bad;
-			/* just do it, baby */
-			switch (cmd) {
-			case TCA_PEDIT_KEY_EX_CMD_SET:
-				val = tkey->val;
-				break;
-			case TCA_PEDIT_KEY_EX_CMD_ADD:
-				val = (*ptr + tkey->val) & ~tkey->mask;
-				break;
-			default:
-				pr_info("tc action pedit bad command (%d)\n",
-					cmd);
+		if (tkey->offmask) {
+			u8 *d, _d;
+
+			if (!offset_valid(skb, hoffset + tkey->at)) {
+				pr_info("tc action pedit 'at' offset %d out of bounds\n",
+					hoffset + tkey->at);
 				goto bad;
 			}
+			d = skb_header_pointer(skb, hoffset + tkey->at,
+					       sizeof(_d), &_d);
+			if (!d)
+				goto bad;
+			offset += (*d & tkey->offmask) >> tkey->shift;
+		}
 
-			*ptr = ((*ptr & tkey->mask) ^ val);
-			if (ptr == &hdata)
-				skb_store_bits(skb, hoffset + offset, ptr, 4);
+		if (offset % 4) {
+			pr_info("tc action pedit offset must be on 32 bit boundaries\n");
+			goto bad;
 		}
 
-		goto done;
-	} else {
-		WARN(1, "pedit BUG: index %d\n", p->tcf_index);
+		if (!offset_valid(skb, hoffset + offset)) {
+			pr_info("tc action pedit offset %d out of bounds\n",
+				hoffset + offset);
+			goto bad;
+		}
+
+		ptr = skb_header_pointer(skb, hoffset + offset,
+					 sizeof(hdata), &hdata);
+		if (!ptr)
+			goto bad;
+		/* just do it, baby */
+		switch (cmd) {
+		case TCA_PEDIT_KEY_EX_CMD_SET:
+			val = tkey->val;
+			break;
+		case TCA_PEDIT_KEY_EX_CMD_ADD:
+			val = (*ptr + tkey->val) & ~tkey->mask;
+			break;
+		default:
+			pr_info("tc action pedit bad command (%d)\n",
+				cmd);
+			goto bad;
+		}
+
+		*ptr = ((*ptr & tkey->mask) ^ val);
+		if (ptr == &hdata)
+			skb_store_bits(skb, hoffset + offset, ptr, 4);
 	}
 
+	goto done;
+
 bad:
 	spin_lock(&p->tcf_lock);
 	p->tcf_qstats.overlimits++;
-- 
2.30.2

