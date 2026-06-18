Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B5A2D0C7B
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 04:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781757429; cv=none; b=DRC9/3Pn6WlQwh6pe/7/lRsbt0ZNgflLjhI7oVftrbIA9pT7mVhUFw63XzQnIXBVgPws5Lhb8/bGSmlWD+VkO5YYAMkXRuidYazVb82PElflVmqc6dif8xjvCU8aBXyWmUVIL86cxtZu+ybUAeI7ohRha2oGqVfNQOc5O7nwFTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781757429; c=relaxed/simple;
	bh=SjBkVVw+IAQyWt5bom8Ak+pHFc2daWHIjbO401eyfj4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uwNoUoTDDsp5B/LEUMKC8zX0CdFLoARtGV5VaonAwc3X6PoIRI5x1qagqTykguNNUmTHDOaI/l79jWHBV6ZGM2nFYqNPKacsIA+/LRO7JodFdYqGGIyIrxdEt6dMRbb75t/2Y56ffTBHR5okBA8XmsxZcnc6y+Sjx5vpdjv2dMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=fDp7HUru; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="fDp7HUru"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781757394;
	bh=k+lffcjWg+fbI8s+PI3QqaVEqU7N0qp2i5MNuacjGqg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=fDp7HUruCr+f1mhY8Ml4Yu3QwWlAYKs5acBEaUqlSUnd6fOvJbaYFN9/GhrNQBpBZ
	 HVb/+6qx2J5nZCbqRaQokVZSpOWdmzNmJ2xvEIkFft9ZsQc7KlyXW20luKnqnT+PAu
	 E8yOYwu4qj1Te8YucTGSY8PmadvYoWpFjg97xYfc=
X-QQ-mid: zesmtpsz6t1781757375td10c89a8
X-QQ-Originating-IP: UewxQl9RH/0mQoRy9dzR1j7qLdMtSywClcsU57M4J/s=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jun 2026 12:36:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10096679989806132392
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
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH 5.10.y 4/8] net/sched: act_pedit: remove extra check for key type
Date: Thu, 18 Jun 2026 12:35:36 +0800
Message-Id: <20260618043539.1557035-5-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: ODjDenAULtPfKRePd/3ebwkKgom7YlFsbd4dRQxmdEJjoXAGh+rPZgyR
	KVGIsEZzYtj/03EiEq4wG+SbLk+lkPOxpSH62G6asnTDMQxPvjbW9rTRpJ/YqWgmUcQZ/b9
	r7DAMMnD/ZLW7/KnzywFngCCL7Dxke6nOD7XFGbcnXPNBRcN/H61fJgzzLoJF+AD39GdKN6
	XNkBHVfqfQWHThBukYDFGUndX7MLEUhsdmCTVgCtnlo8jCyhq+/I/4Z5NZ+ljW2bA4Bu+Oj
	CLb+UmGyG03bZcAeEmKPBZxxFulDSoggvWNr9ZGiU8OIIQy925Ar/wxbWutsmrrW2YuvkD8
	7SwIjN3/lYYuWjGWXSSrq4s17OzzSl0BbKslrB31L0KPxwXTS/Hh8azsIqN66euWllMTHZy
	Y2zbwUReKz8teGwZwCBc0ljImYvIpYUb4mRhyU2Fo+jZbyn/gInMGP8kfgZN3K6a1Q/8WR6
	p529AeSOM+4NMrjzemWO/lClu43aaIHW9npjkReOtwMW+d8tZpOo4zwkNM/ZrU0nGAgwAg/
	fbU2c21MV+5YnptMiXN5vn9RGFS/CEzjfJ+jNOF02cBfVPPV/RWJut7lo4ZevYy7COaYoLl
	1Nr8ABO3KPNe6vhZ1OuOCfNhtujxrl40DGehMWnC5j6jSkxa90J+jrTulN1m+yVF2N0N6oy
	VsZV0aPzterOFH+DuV22VUIxHWNzvYIdQBDrhLnv+ysIz4Ffk2KQ1Ar0T4DK9GOWrlUDDhs
	G1Bb5hzVpYyH0KFXHUrTTyFxMvgjP7vKNibGv99Sef+O+cX9H8xaosqY7uYF8Ha1Dii3mll
	agQ6ssWTJunPpKPrw29trk7bOKCdeu6R7XJc8b1czXRMBU+9kZmIu83MMnkvJ0CTuDpKTOE
	ODa31wtEJipvSX9sK5xlPl6/nZbCVp+xjiSqtBXAz87hb8ZARpkBs9ksLjzVEEOwYnkp6Ue
	7MUSBv/abskRr+bHvziaKC9+kyrIaKC2dc9ut1fKo+tuiCIOfcU3HfG0G31Psjnw2/QVoEo
	LrMuXcszHfWOETLjxzwbRYpcgs3GoxXmLmzt4WkioyTirhu5+KjpFOfwFP6fYbHpl5tR/eX
	lOBQ5fGhVJtQS1B9jQHsMRkVpyBdCcQvWDen43E1xpiLtYT10wTD+g=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

From: Pedro Tammela <pctammela@mojatatu.com>

[ Upstream commit 577140180ba28d0d37bc898c7bd6702c83aa106f ]

The netlink parsing already validates the key 'htype'.
Remove the datapath check as it's redundant.

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit 577140180ba28d0d37bc898c7bd6702c83aa106f)
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

