Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875C13A8755
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 18:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782497325; cv=none; b=UXfdoXKDuWjM5dtxiCUNAWTMx5yJeYOIIeIwa4iCD4N/4JemB2h1JMhoR22EyJtxTXHQ3KmBuQUTcrPFY9vvEPfVmPa4RZ2aYmd1SVK1e77grPVtTbfPbsbtEuS8afYGSVFMP70XURMxl6MX+4o7ZcLiF64a5V84RRuS+P42PXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782497325; c=relaxed/simple;
	bh=lf7gCt4JvwgPZLAIcz+/BuuF8UKNLHkFcmNnzYnIibQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zx6c1e3batujw6QUgT5KcJKC/2mRKSPLnLu1z3dByF5qHRWyAUCmbfCZPqYjhqVzJoDzm0N76BqRW4tRgy8RW9YFbdbG9Z/M5lpzoju8ntpq32i4JiQcmG8nodOAziyZOr1nQQTS24upaIJcdrTx/9j2iGDEjiiHAovIx2B8jz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=FrNHXWa0; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="FrNHXWa0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782497302;
	bh=XHZDzlXJFPduKF5+7NaJ9ixoUF88W9Qnjgr+DXyETOA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=FrNHXWa0Aoie5qjmV+1015OD5Ic4UOxQ+G65n3L9u2O1rXpiNqDvwOdYi0PvZ/jnR
	 OQijI9COeHchz6gl4nmhWXQ43RQj5XJFePhfiy4t6ud22POIv3wCJ/5mNbkYk0ltoZ
	 +gFIjEgObq83MOUd52psi2ovNHU2zN1PntODrWt4=
X-QQ-mid: zesmtpgz6t1782497283t382e25b4
X-QQ-Originating-IP: oUnkhoqAzq+GfIeMtddsZyDpGZLxVOHrF3aUiGKqTy0=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 27 Jun 2026 02:08:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11786072418164360325
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
Subject: [PATCH 5.10.y v3 04/10] net/sched: act_pedit: remove extra check for key type
Date: Sat, 27 Jun 2026 02:07:29 +0800
Message-Id: <20260626180735.297017-5-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: ObFHHlrAm440e6KhvyZdyOTeX9Q6mXEh9CyKBUqjXuYmCe4yps9nSO04
	k9V/FBx6M9KtOmxkROMOqN6JmKx/OQfe0PP2qC1yy9B8frCbJDAuB9yIn40HVKF0J6s8aSr
	G11GmKW9ROhGTdexh5Y5QWfRKBqNCLPan79QkrQSzcHHjlCcZSsC2UKCa9LZd+LX1VDdIb+
	d0yPK85qiL3lP/Z8vj4JI0gaRc1r7pUsWqtHuhhnZ0AAwZpiaK08kWyok91IjH/syrfW4dY
	rk3rqcytdZqb4sJSX8KK0+lv/mfVRvye9Cq5yNDLx1USm/YftFFmF0Pov/5mUcvZHquNUkt
	uvE4dEbPP8dE5j7qDM1Tu/JRKFY2xTnJ3zfkDRDoLlFyN3kDHnT4t8+YeqsTZ6o2cjnXMLd
	P0+wu/jSXJ7q8Sa5eft8ns7+Pd2PXJ2T2fQLkERgiq5WCWTJOdwydQxYFaZAXqkMmHjY9Le
	5TZ7eLFzQkfTKJSKIg/zS886BICsnHqWVAQlM8X+Lkm0rV9+9CO/27MsGLIM4RHclARthi7
	qBxLxL9fJsyCY8REDpWbBcl7ZWDUuSAgzBs2Hme16tYJWxPLL9eqjH7yv6pUpaWzcouMX8g
	vY3Ovw0mmDJM/YOiUggwxglSbZ2DkENlYeDuGZiFLX3uoqN/gzUZ9vvkHnfIdINMGS6m1h6
	lNCg9tx7WVpWDdN0kSHTQTNC06n/7guej6Gd9AsOyhbAo9O0bhhTP9Vw+kBMR9sMykPrtF7
	QS/JwWpOMdibcWQkz3DjHMV6z616ihZfzVL4UYCNl75x9YCGGsmcCGESeaLk2IXP6looogP
	jancSNvHN6/HIRqG1JgTvq6ZQgAbA7w+u3MI1pxYF3v+czkwtCqcYZ/T/Sx/f9uxBWVZdVV
	LObHJ/3F7POP0zZZFYNZgy8EnZFRIaUGeXR3jzR0zuJo7dFVH14ZgL0/Yb9ln6cKLJiU7vJ
	tA2nT+Fadze6ryEl+AFOdR6I6rINBNJ3PQwZIWqUxNinSxiPUh+KH78DKeS+PJEGhKxhi/L
	xrnfg+9JARMEojXbgaC7F6hiu4pu46J4zGql3INgqYDqmgAn7TlQWO/LN26gtzmPtnV6IGP
	E3vn1SRE9IaJTPDtFZL5jU=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

From: Pedro Tammela <pctammela@mojatatu.com>

[ Upstream commit 577140180ba28d0d37bc898c7bd6702c83aa106f ]

The netlink parsing already validates the key 'htype'.
Remove the datapath check as it's redundant.

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 net/sched/act_pedit.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index 84152d3a49246..957ce9017c3f7 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -305,37 +305,28 @@ static bool offset_valid(struct sk_buff *skb, int offset)
 	return true;
 }
 
-static int pedit_skb_hdr_offset(struct sk_buff *skb,
-				enum pedit_header_type htype, int *hoffset)
+static void pedit_skb_hdr_offset(struct sk_buff *skb,
+				 enum pedit_header_type htype, int *hoffset)
 {
-	int ret = -EINVAL;
-
+	/* 'htype' is validated in the netlink parsing */
 	switch (htype) {
 	case TCA_PEDIT_KEY_EX_HDR_TYPE_ETH:
-		if (skb_mac_header_was_set(skb)) {
+		if (skb_mac_header_was_set(skb))
 			*hoffset = skb_mac_offset(skb);
-			ret = 0;
-		}
 		break;
 	case TCA_PEDIT_KEY_EX_HDR_TYPE_NETWORK:
 	case TCA_PEDIT_KEY_EX_HDR_TYPE_IP4:
 	case TCA_PEDIT_KEY_EX_HDR_TYPE_IP6:
 		*hoffset = skb_network_offset(skb);
-		ret = 0;
 		break;
 	case TCA_PEDIT_KEY_EX_HDR_TYPE_TCP:
 	case TCA_PEDIT_KEY_EX_HDR_TYPE_UDP:
-		if (skb_transport_header_was_set(skb)) {
+		if (skb_transport_header_was_set(skb))
 			*hoffset = skb_transport_offset(skb);
-			ret = 0;
-		}
 		break;
 	default:
-		ret = -EINVAL;
 		break;
 	}
-
-	return ret;
 }
 
 static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
@@ -367,10 +358,9 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 
 	for (i = parms->tcfp_nkeys; i > 0; i--, tkey++) {
 		int offset = tkey->off;
+		int hoffset = 0;
 		u32 *ptr, hdata;
-		int hoffset;
 		u32 val;
-		int rc;
 
 		if (tkey_ex) {
 			htype = tkey_ex->htype;
@@ -379,12 +369,7 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 			tkey_ex++;
 		}
 
-		rc = pedit_skb_hdr_offset(skb, htype, &hoffset);
-		if (rc) {
-			pr_info("tc action pedit bad header type specified (0x%x)\n",
-				htype);
-			goto bad;
-		}
+		pedit_skb_hdr_offset(skb, htype, &hoffset);
 
 		if (tkey->offmask) {
 			u8 *d, _d;
-- 
2.30.2

