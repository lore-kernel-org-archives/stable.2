Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55606279DB6
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 18:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782497348; cv=none; b=f9uBTTZ/HNiXDZELQxbtmh0RlEDWrXwyke4Ke1Qzr9hYQpVLZ/H+DKcPcSz8w8Wq1IVYNo/fZB5iJ+IUqwHOj4/DfwmqqKlZO9SrEdS/AzakmW0xzBrhlnyNil9Nz3EkcKFXMXSGEJ6BdK1OaspO3dkvHISSdnN/h29zgYCAXD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782497348; c=relaxed/simple;
	bh=VzxwC6LjYA1r1icIhS7e2m9Dwcrlv/j9Yoh0rglOw4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l19h0yn39jR0UeEGs0WUXI5I2U33LR6oqhw6bvDBDjcpbQxK6xX1l/dKC+DIr3b7GIbALp/C65LzRO0cZImGbyqa2KLtuj9e0yRbydIiIRBntUyX8uvW2SAf2Zl1K+yZbhyKpYD2EJiT8EcPoca8sS4cL0xcgimWfs3uLgYtRA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=SIso6R1v; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="SIso6R1v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782497297;
	bh=Mk9VVi6pK6El7JWasCx51yOfsSjJZfJte2wpeSg/tHk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=SIso6R1v2vuh7Y6GHnqU9Gy1f+hYHaMeA9JxKIizcFrEs+BYiGlbwsDosOvygcCt1
	 TlLMhH+G0hnCfYKAn3o9Rjnap1kgqpQHxbLm1gqRBh+P1tkv3YsFX5NYLw7dNHx95i
	 bNB8mglbP0y3tzk4fkdlw6NvXQKuMO1MZ35mztmc=
X-QQ-mid: zesmtpgz6t1782497278tbc13ac83
X-QQ-Originating-IP: YvoAWya6+OnNBY8t4P+9N6Umt10rkG+rFLRLAXseZUk=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 27 Jun 2026 02:07:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11732115969738422752
EX-QQ-RecipientCnt: 18
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
	yimingqian591@gmail.com,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.10.y v3 03/10] net/sched: simplify tcf_pedit_act
Date: Sat, 27 Jun 2026 02:07:28 +0800
Message-Id: <20260626180735.297017-4-guanwentao@uniontech.com>
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
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NWth7vBa++Gd3WzN8N215hSnmj5VpDwWUqX+itgHZnVqaWYKQufTSvL6
	OouSFTualgG+3y+GCRJV/NvEo4WvvzUHvCNNCB+zlQRTpAUibTB1lHlJzcBU37TtiMJOkAG
	OPg1/x6LYua+vDnvwtYGZgQ8vXaSVjIMahk1G5WKn7JJu/nspYA403hAT1idTAN3GBfRsWP
	7LcKDL65HKTKXqvsRrtN8XhkgP6stDthGluzf283QHuJFt7/2yq9920nwQ9+WFNlzaDid3o
	9UCfqJNnEDV0JG6YKoBsiDCZ2FC+y6SzCIBpX53Uruv/sdo0S7BkmR99elYGT7RpvzRehmo
	9KRCEJx3CA3lqds9jFs/Tzpe25EoVG21y45qnKXgyiFWfZYG9BfZtaPGLNELMzLnJq73v+9
	WmFMQvvyjG0N4RrsgUmunPIxPTnmFtfIPJXNLYCvB3aGgPv5FUGUxntRaZQBfYd3NB0uDT1
	hxyNcvHfVvvVZtnxqPH9wqrOBR0H2hjWVEBNz7hUzybnnV+ctLSChlYlBqPWWSeTcTmP07n
	tIcB5wi6kfpnvkfcXs0Ke802M258vUIBS42vjDB5mpzqUeHHzV5k/MIDEdgdG/vbSDIGmhD
	q1PgccBIF7Rpf7TWFecQUUwwaUcv9fyZIAviPV72v59ElsI5NsdXDfOD5aJSTHIijv4EhN+
	/RJnZThGLpAwbVp58ZRQYI8LdDyHGpnzVbIBQVMOmj+KdfXIewBJhfqZDHZsmhEuLQMAxWm
	MbxCTxyuZOzFoKefkt0zcUqC3WYaE9h/GJd49ZPxo/LQluT+jgXSaEcxliDIiSvc8MAtxJg
	G/ZgXbD/8oDjP/cgcHNgvlazzGdkzBklI2+7ViMfJ8/7u6mh29JpF2uM8ReZ7GLO+apzL2o
	7quYSgdpZW+5pBkOwzk0bRYmrWA+AufOsQp1DvqDPy8fsav1I3y8Vopzdgk4ZBUaoDGLGjw
	++aretq5XRWt//ZIEm0Ev1dijLBDM495uT3+3ecv1Z+DdbWp+sROQmln4Jw0i2pkIilGnIT
	DREflLVA0v+Y/dksCRb7N6djEmJP/v7aQwv4lE7FM9BAd6kBIPtNkhIvZ8tgmUb+h1qc107
	IejpGmdwqNP91pKalajyTg=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

From: Pedro Tammela <pctammela@mojatatu.com>

[ Upstream commit 95b069382351826c0ae37938070aa82dbeaf288d ]

Remove the check for a negative number of keys as
this cannot ever happen

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
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

