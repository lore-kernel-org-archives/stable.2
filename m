Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5FA2D0C7B
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 04:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781757432; cv=none; b=P/AKpyOzn9foC+wwsSb3e2D5VdQ2QIsZJezgRNyVMFXoN7LvXnvf3R7mAFM36YFmLBkWT8UBY35yWU+mU9/uNrSQE3JqtdTQhdNYgGBVE0gfiVvqabxAhnBSW3QuC/WmAMAlsaOeWFTSqQRL5320bi5kYDVDDet2DFkZ2P+0C8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781757432; c=relaxed/simple;
	bh=0hltCFlSBPXhyMhrZJ/sCsKb1LY4OYdD8VUJqz8w0j4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t7yiXRXRoW/+KWNbK7SMVurBIr2XuGql1vua80BVgF0UmA5qAnM/iUAYKJVibhDiEtfQi+8zc0Fxjh63S/Yp/6lV1GstZKNm+lh8qcc0Y5YidbndIzbNpiGn9CT3SN7759q3hYmbcctxDuc7TwySQOKI9Ui0I0bLX7h9FwQK9dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=K7vVp9Wj; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="K7vVp9Wj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781757399;
	bh=o4poxYtUOYE2l1sQPuAEtsNHEjyYTorbHkMOOZObEI8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=K7vVp9Wjxm10an+lrWijIyd+xCCc0heNSdiyEQOjJq+h3V7D0RYV4WmSTxuip+QWS
	 3bWPQvWUHsNGo9MGrhR1Bzwanw3FLkupnPmL9dU92GUT+TN8YI2r6kUiAwK6tV/a4g
	 T/7seAHvjdBqFHW4S6sTOJpl0aovxYGiyp0SO0QE=
X-QQ-mid: zesmtpsz6t1781757380t99091fa4
X-QQ-Originating-IP: xLKNI6dPn2w5TQC+rins4LRslXEkK7DsR8+QSUyQy7U=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jun 2026 12:36:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 800683848351104429
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
Subject: [PATCH 5.10.y 5/8] net/sched: act_pedit: check static offsets a priori
Date: Thu, 18 Jun 2026 12:35:37 +0800
Message-Id: <20260618043539.1557035-6-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: Mhp0nwbEYw1JzU4IrswvxQAwL0P+hfWwroMXyF4jklz0HVuVZBPPwH3M
	xki5Md0YpNZ9/e5PxjhD6PVKrnhTAXM64r6lG6qxeD39jtIPI8nagegKKabpZDTCgwWrZxS
	uLWRGu4trnxPKWdGrRrkLlAOhXGtTennek8w9jlaiD8pqcgjgtLsN/dxLkbFT+VC0+h2Ud/
	w7e+BmD3R0uGS6gagnx6qVbH9Cl6XOWqtN7aSD6Vm0QB9I25QHggSbBJsMaEYdWXBD4Sfvb
	clPZNfDzPDDNu+8RNtrmiPZghhNC+rXWHNPcJnd9IqgVRpulZPDIq2eNGPFVyftC6UZLEoK
	rB2BxXi1LPX1CJzCQZakiVxgMBNYxb8eDMnzSdPCN1NqIB6wVYzNynVr/FBsaojVfOucmyE
	Ir9wa9NA1wj5V/fRsCUjWB0m1KomTmbEp741gfj8NiCDD6W74G2VZMaRmPQoauAYIurYVZs
	pjqgx2HcEYiY5A51d3vaeP2ct0QBg3WIgZljXUGASm931W3dBRRPc4e/JmZMpRaKtVkFH0/
	AyJ9/4q4ReLMeVYjKUaUrXqDcpCoYenfzz1kV16Ue/OjhjBXhpkFcXmt0JYu7K2IbXX+XjS
	InMQXRpG7RE6LBSndoEAADg8dOMDhaCO5K1b/z3+f4Qu5vhYegq/BalE4qMkLiTqIE9aXm3
	KgQhG0PLG+6TsPH8XxSKo/ta2pLWo6DUqmp2claC+wspaaWlLynyUSdBBlbPjnL5UH0cSdJ
	SsJYQ5O9sePb76Z2Et3UtvB8566ccLKgTIm1HaZeOLanjDr3uLj4f88yCBsuhIdNBKafod0
	f6gH31GSQtwknr2vIaUjodhgDZ7uctE5EkPfAZpkZIMkVmzc4le7vM2iIzIx58NuCAJXWaS
	OwPMoFjp2iYxfMHZdeasSODAtDctdui5m9pgG/pUIeBTCJNrpr3P1kjM2RSITEECZTUlZpU
	q0PCRroUPBx8c3Wmqm83pJklxCPe1/m3Ps/Rv7QJ5q5JvJaVNCiu5IcjXaNd9jP3+FnD9e5
	qIR7hVHG+uDaY0pPJjGHcTRj8Ju1OnQynaiGKfPh7VI/FRh/eWSSGl133Jqr2Y/H+q6Tj0H
	CTwHjEXcJfJLxyDYiZgb1lYGNcW4uXQP7c/TMfuR+BJeblAYqx9M+3U6YN2WKLCMAXzCS+A
	gtZyxW3pTDBxDuZuI8N8GSGCcK73S2jDrogUq0td3y9Inyp3C+URg/jc9A==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

From: Pedro Tammela <pctammela@mojatatu.com>

[ Upstream commit e1201bc781c28766720e78a5e099ffa568be4d74 ]

Static key offsets should always be on 32 bit boundaries. Validate them on
create/update time for static offsets and move the datapath validation
for runtime offsets only.

iproute2 already errors out if a given offset and data size cannot be
packed to a 32 bit boundary. This change will make sure users which
create/update pedit instances directly via netlink also error out,
instead of finding out when packets are traversing.

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit e1201bc781c28766720e78a5e099ffa568be4d74)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 net/sched/act_pedit.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index 957ce9017c3f7..95ae885ecba16 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -239,8 +239,16 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 	memcpy(nparms->tcfp_keys, parm->keys, ksize);
 
 	for (i = 0; i < nparms->tcfp_nkeys; ++i) {
+		u32 offmask = nparms->tcfp_keys[i].offmask;
 		u32 cur = nparms->tcfp_keys[i].off;
 
+		/* The AT option can be added to static offsets in the datapath */
+		if (!offmask && cur % 4) {
+			NL_SET_ERR_MSG_MOD(extack, "Offsets must be on 32bit boundaries");
+			ret = -EINVAL;
+			goto put_chain;
+		}
+
 		/* sanitize the shift value for any later use */
 		nparms->tcfp_keys[i].shift = min_t(size_t,
 						   BITS_PER_TYPE(int) - 1,
@@ -249,7 +257,7 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 		/* The AT option can read a single byte, we can bound the actual
 		 * value with uchar max.
 		 */
-		cur += (0xff & nparms->tcfp_keys[i].offmask) >> nparms->tcfp_keys[i].shift;
+		cur += (0xff & offmask) >> nparms->tcfp_keys[i].shift;
 
 		/* Each key touches 4 bytes starting from the computed offset */
 		nparms->tcfp_off_max_hint =
@@ -383,12 +391,12 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 					       sizeof(_d), &_d);
 			if (!d)
 				goto bad;
-			offset += (*d & tkey->offmask) >> tkey->shift;
-		}
 
-		if (offset % 4) {
-			pr_info("tc action pedit offset must be on 32 bit boundaries\n");
-			goto bad;
+			offset += (*d & tkey->offmask) >> tkey->shift;
+			if (offset % 4) {
+				pr_info("tc action pedit offset must be on 32 bit boundaries\n");
+				goto bad;
+			}
 		}
 
 		if (!offset_valid(skb, hoffset + offset)) {
-- 
2.30.2

