Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6921230C16E
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 03:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781755033; cv=none; b=E8FrwISvUtqzOfDjGPRtK8YEIQeVYmYbROaoPvu+24yi4u32/lJo3s+EwO9OMdHAGgBSMozJL9GaC2wH70kUnnFRxEdfxXfBlDLJclVi4QUGjvCSCEAi5/zXDyhrQpiTDUeJGvfldRIuGssJcsWK/L7KUJ8NRwQWdFcsABm7F6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781755033; c=relaxed/simple;
	bh=m2CfOEH2dcs2cCxVQNkxWKmVMOzT5cEKOyN9/iT+9Oc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IYYeRBiaoo92OL76VhgIqKXRri1KYfpCrEvvYqKMkmXJ2k1jeSLuuKbDB5RjM5iBnAbU3XRDEJMWkAeiWNaRL0xvYm4o0B/42sw5u+wEL17zqnRTXO0D6K/Mmb7gYRolNi71ye8yM9Jrg65w0P1D2gt3EYQrjMpv6BhplnoLypk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=TtpJCIZG; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="TtpJCIZG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781754966;
	bh=nCSYbJ4ZRoPCIzdcsZjyNGy3VDpGbcLWsgBo8pGQak4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=TtpJCIZG8SLfiNY0BY1pOUeCEW0h2cshLhf//zh0tyFx9+qiUsRKoL+uAvI6p/hwn
	 ZxMGR8qTgCww3Tdbhw8st9ikoUnSMOKuqKwqDcGNuRzPoHEeexYGjcHfFKne5vAOQ7
	 gkBp/M9SKpkGWM810A5EDCjTtEcKGuvFFnFSA/bg=
X-QQ-mid: esmtpsz20t1781754945teda77c14
X-QQ-Originating-IP: 2omPS5I0CJ6P58fEPdKtPySsizV7Xv3CL32C0OVnOBI=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jun 2026 11:55:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15025449948935894828
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
Subject: [PATCH 5.15.y 1/4] net/sched: act_pedit: check static offsets a priori
Date: Thu, 18 Jun 2026 11:55:04 +0800
Message-Id: <20260618035504.1536870-2-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260618035504.1536870-1-guanwentao@uniontech.com>
References: <20260618035504.1536870-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MkHEDmObRV0iOHD5yezVVeaEbNC5yTTVzfdnaauzdMhlEN/W44/q3mRT
	mrSXXNt5o5QOxoldjWlV3cQTCDKuR2M4W94HkojEcwwt7d5OXAwUm2Oy18Lbk7pE+qiwyp5
	7r7WQH7Buqgs6odo1HnMFlgU43cpvz/tK4OLPrxI3TnyXmSFK9e1xPNQEHUGM47VrFE5ic4
	Etzb/PdMNfYvZX0UIx7p/ippWRGjjlfVevcomJOHZqY+QUE07Jij7/18S8JHnnR9DvIH/Ud
	8swZxSIgdyt43qORYW7dZRx+0VQZRSdkdqPKh6RV7SaPRDHaoeRfY/4eJmq6i6+Pqe86uk6
	HT266LYWzb9z+hiRbhaMQ932HRD2KwW0kAMGsrtYp8fFYD+LsbZrkegiUuLVsJtO7S8OJcD
	81mEmKYiTHvvii+gZoayNmhLL1g2lIlWXEtydlCIkkCy/oBj5MNqLTgsQvLKsvPV3lJISEe
	n1WWcgoTKXmCUH4A+yrgNs4gU2Z9Z7NG1JnzdqKSsveM+ZTk0mnuylSnrTmi7XkGodVhxJU
	0OwPMAEQPvgDu1dhRH6r6aAHZpYNc/6kQ9iDUFiqAV75hiWOOfNcK4wzAvyk9Wv8WU3kusv
	iUn0FQEPkwqnZUpFJxUOHU49QqvWkSEQW5Vi6pvR1mN1Wnti0lG1HjKS4MdLBF34d3vloWV
	NesKw5n7j/MkCQ9sMl4djkwiuXt54RiS7EoMYQth7Uk7B+/iK8tqWcY9DhypIaEsnPUFMuq
	E3FPFJn3nkUxpjZTCM/I+V/DsuUxYWKkYtj9zJAItyuvirm+fof2bxvTWcAi0FyMu7+cnu2
	/OUcepQGe8G+BdqK1UTO/FIo0d1+QaXPe9LrPMN7kr4KekczX/lBadJ4C0La0+29sLvfjkT
	jCBXNwyimvxAsMhwLRgJ7mZ8ApME4jO3iyWzoZ85Ua2DgLIVX/YuTqiAZB4srX7t/BB/YSZ
	z39EdmZbHNRzhuVWFWjs6oRYex5Ptz/3/G8f7bHpjsXmAF6MlHrPvyWdEGpYjl6OM69TW2G
	s0/+YFcUIYuFke7bczhO8sKGkFB2J3aGeFXzE565LNl4ZwrWLhbUCrwb2/XsAT+0V8vunuF
	eIFlwbHRRHsFbCqK8lMIwu5zn1sPdSHcpbKO/y/5rMR6s77k1H7y1iQa9c7heYB9Dae13Wh
	zO7wQtFrcqcnJS4=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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
index e77da0545b553..8679e87d774d3 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -250,8 +250,16 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
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
@@ -260,7 +268,7 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 		/* The AT option can read a single byte, we can bound the actual
 		 * value with uchar max.
 		 */
-		cur += (0xff & nparms->tcfp_keys[i].offmask) >> nparms->tcfp_keys[i].shift;
+		cur += (0xff & offmask) >> nparms->tcfp_keys[i].shift;
 
 		/* Each key touches 4 bytes starting from the computed offset */
 		nparms->tcfp_off_max_hint =
@@ -429,12 +437,12 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
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

