Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29CA2EEE61
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 07:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781769311; cv=none; b=PxEi1ev4fte0xnlrA+aOP5+FHAGcvaBnr3CjPhelU0MlSOmKpE7fQZay+1Q/3iitkYzB/ioINhLPw4tCWcUSF5Wwyu91aaGGY47t7RfKuwJWhVRPtJ8+pZiPxtWN2JEfEG4S/ctguzXvHASjKTl5iIeDjscCRQ/9qdWN+pb5Els=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781769311; c=relaxed/simple;
	bh=VzxwC6LjYA1r1icIhS7e2m9Dwcrlv/j9Yoh0rglOw4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qkkSIo4ccl9etIQOH0kBC6KrLnini/sp96f+aN/Q2enLBfj7b/1tDnKuq5HV4QClzkwKESRV7YdorYfKBci3D8AauXuMf97Ax4/VT6ofWc6NFVxX9/nBNJf5avByMH77SlzB8deRvpoHN2utJGmVn7l+UoEyJxWeoLBG/xrNKAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=XHDDa1Gm; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="XHDDa1Gm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781769279;
	bh=Mk9VVi6pK6El7JWasCx51yOfsSjJZfJte2wpeSg/tHk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=XHDDa1GmFvanjsZn75N81+yNeeRYzHCVmBvaqroPzqaepXyNKQx27MnScvmtXmvaa
	 /AYX52xmy6Bs9emMIUbkFaCpcLZ0inNjvv2Z6CEy2YYPgffmrLErhKKeoOzytJmYz0
	 xWNKXZmyUr16lE0gnYMYnNRVr5eB2NqDHssSPd1U=
X-QQ-mid: esmtpgz14t1781769259t802489b9
X-QQ-Originating-IP: +3BaqZ4hN8JHjUMRx1US1M1FVcVuxQxXLV4PtM8LlCU=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jun 2026 15:54:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11512508952445782829
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
Subject: [PATCH 5.10.y v2 3/9] net/sched: simplify tcf_pedit_act
Date: Thu, 18 Jun 2026 15:53:40 +0800
Message-Id: <20260618075342.1599593-4-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260618075342.1599593-1-guanwentao@uniontech.com>
References: <20260618075342.1599593-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OOH866owL+lwL43sHocnQE6Nne5NImbTtrYPyJCqiSYdobCAFYy9WVw0
	PoJX3vS2doQSdVURHmldT2pqj8hgOxc3vv2CiLHp4jvtMD3WAFEznIqEIegrBEfbAR7cdVI
	s3I/zKJfnH620bUFFSYTTVM/kIwgPjStsBT7ZRdQumlWmLVtANL0GZPBMA0F6e0wLwWvGTv
	dJJ36XZWMx8E/uj51V615shy2KM0Ssybol7HxWXh7aWkPgOGP3FSd1dySYlyNHpE6iFj5Xd
	b14+fhiTPa2cw0z5/NAMUmxUJIjLdHyKrSM2sZwII/eL+wejQz6RfOnOX4G2c/+u0PI7/mR
	faZBiEMqfySq0+D+aG6Blg1lpcKIxmqCkLJDlG5oJCFqR3mvWGIqdbfBIQuPAOhOFPvNA9U
	JXv/xzZB1EkJ8K/toVFxGne0CZjnFhdRa94rAlQ3ZxQOIXoNKeSUOOoL5M8sOOE6ab4TUID
	/osJnwEAYmPHr6aHRnkY3rmMJS+jcVnb70uh9GGCfZ1Gh7QXUahuol0Vi9Jle1Vn0aYEFrw
	8CxR7ae2WCH+gLSZ8Pq5d8TBBAhg0PtjyElQ3PH8Odh149pu2oL8zTDRApfLJcJ+sBnEEgk
	COK11SJQS3k+2jcP6xdRRYeXEhrTLZ/xel36+ckxMjNN+pmdh2xUiIu0N0MqCxrbalT2NNe
	crivXbzBZ/5PqodYkJrI6HUDhe1Dagdr/pKiqB/0Ymct9851DqhfsAzwBubnmqiJ+ICdZ4o
	Y4rtyEBAOMnOrstXMep8sYF4jsqsGmOUP34sPQJbNtkZE5HCw2eSl0BDH8v5dL8IReIioif
	vFcFZPcxkQwQ1At1jzQcg7QDRLvDD7u2aUh88x/A17MjGkKNjiLQsGGT2doytlG1/G5I3Ls
	SfPmSc0vdGqZXpg6xO/e8V7d5fksfMZI0qDoMr0+EaSfBaSGprxhn0OJ1nKDHD98dQHcePp
	HYrJZZcl+32MFCIu/UdYdhXcwgsCb9Tp5/IVmlbNQd688Cd9ZV28GDUDz9eE52Cx4bBrR9f
	PCzrRBgPc+WoosnGxsVdwNJWlJxcy/7b5qb8ViKFAb6h/wyTQG162BRU4WbwSgSizNfw+8M
	sMg+nRsEc8R
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
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

