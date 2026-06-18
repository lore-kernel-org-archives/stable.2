Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE3435898
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 03:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781754284; cv=none; b=BsgDSWX8wWjACbC8p9deu2BM442fMq5xHc8kDMdhCFVUHGFea1/e4/RLBF99/hfklct+8ntgTJMmtG+pGol6rpqrLEeUtFZ/AHb1DSdzaK/ZAWZW8vB2eh2WHcOOyaGUFIC3r4wFPmT/90PCE/idQMinTuw6Eq5kbPU5ZswfKIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781754284; c=relaxed/simple;
	bh=0/o5265vQcObSYJMlLwxMPFqjO3w9uCaIcwTnKsuvXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GYIrmI9utz5nL+KQKr3+QvDNkjM4WU4GQLz/uGjDQHlKhw36GM2dfMmpoGqXCZJ+sKcDIhVuk6f/soSRBksT6IpUUi3sbTaQm+b2bkHWBjCc2IpTzMs+V6cygKMRQ0nxPZQwd2x/FMWPRnK5V4d4EdS7VK0Zu1hXnx3zCBDaPKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=kWbAOy+T; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="kWbAOy+T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781754202;
	bh=b/LlPpwjYtM22GZXCQ5lP2V6/hIymaxfc1h3lZ5SqnU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=kWbAOy+T3gZMd7kvLQ+OQ2v06a1BnDSVsL6X55Pk0jZf1K8mSGaa1PbQOKyUPZ04o
	 skiDse+BnBH+ir3OYhIbaXUyWmPUKq0RmdFsJ87MeXacSTe0vh6zBgUgI7nDWfj3eG
	 uP2jnxFN4HJ822mzUlPzOPc7KmR/uzmOB0lHIA/s=
X-QQ-mid: esmtpsz16t1781754183t6819f6da
X-QQ-Originating-IP: kTmWeZg4IVQ51Aoy9oLHKT1FQAwuMXN3hcSEan1qAYk=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jun 2026 11:42:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8461035864353927015
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
Subject: [PATCH 6.1.y 2/3] net/sched: act_pedit: rate limit datapath messages
Date: Thu, 18 Jun 2026 11:42:49 +0800
Message-Id: <20260618034250.1525454-2-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260618034250.1525454-1-guanwentao@uniontech.com>
References: <20260618034034.1525175-1-guanwentao@uniontech.com>
 <20260618034250.1525454-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NEuxXjgkfD8wV5PaJl4w+RwWks10rdaBHWv6geRq1C143LAJfwBGPdFd
	c5eZKHCDzI5fGzY0IYu1UStSn8+bX3bxiJIeJ61EClfoVU+4AgA4f2Z9ARjQgVDVpUXo6Tt
	c82LVg3PcKQIg8RBfNoYGank8IMXCtnLyqrcDC2tHkcgd707qCVH0amD0zFJeHuy5QDnHxv
	tCWhwakLJpc7w71Z2EwDL17CkiJPC6VQwHiR3FOpyDp1ik5/B4g0pI7W3NvKI1mzNkG5bny
	AiHzOhA+LnTsv7ZzLye0MbzKPXNagdjI3ua6kRe2DvJaMVZmc6glUwkXk6m+wDw+5suie0M
	S0IkMSmCD+DxSymtKEp4dv1AkAy10f0icaySn+5FlnmNan1qGiiM3gHdj6r5VBEUtNFBbr7
	ZZI74YJrne2L/oUOvojzZQD2DcjSAXY4mXX/riBljwA5AuLKaMair1Ohx/qb+e8IY59jp0J
	BkKP3Z6HVXg3MD0894d23t3B2uOqiReG34hR4XfsUXVgKwPUhuuQ7Vs/HHHPExqedJ6JMrM
	bDuQSqKgjexvgiRn1TN4+3d3Qjgn4Nl3JBSwilEjjuS/bW0xOnrJk7N6lJU9H/SV+7ZRvx6
	fYV9/BTtOWBdLISdFxn4G8ePf59V9W1kdnhHTpLSkf1wc7ZicUqEzV0kMmv3LgvHffGifb2
	p7UhzpJBsFMQBFc+KerVzuyKCvioMIRrqj3xM0FIYtEmzhalHEx0aYlN/ydoblyTcYc8gMs
	Y5egZJ9VmQ+ChQJLKvpSOISfcRsTNLp+arD+KQZF0OKvIl7iSMQ70xcgIZony5atE597JFm
	4ZJhM9hIqVdhrbfh9+gcL3wJsOtI/PR5n5aAKUTLO9BViYbbOumOB+tHUvwqKAR61BiabV7
	wSQA0jZzJ1bxehYqpjXbev+kZ6FVa3qFWZCep83aSMZiVUeZd8849b7kaUUgnR4mmvFBVPt
	slJ7qhIaDFoDQAWSutgdSSl3538urxnvkKO1FhcuAGW9+kWdZlP+2ctATO4J2ueUbv+iNRd
	kNSSK+6r+xwbd3wcTtp62SnfUIcmLpZDtLUEqWOUY37glv3bs9JVe8urB/UQepus801dW8L
	KgW45+yRfC6zUJWjoPXm4yR7Ibz9UFFr06NVsuEbidq
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

From: Pedro Tammela <pctammela@mojatatu.com>

[ Upstream commit e3c9673e2f6e1b3aa4bb87c570336e10f364c28a ]

Unbounded info messages in the pedit datapath can flood the printk
ring buffer quite easily depending on the action created.
As these messages are informational, usually printing some, not all,
is enough to bring attention to the real issue.

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit e3c9673e2f6e1b3aa4bb87c570336e10f364c28a)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 net/sched/act_pedit.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index 2bdc44efee779..7ba460fda1f4e 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -429,8 +429,8 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 			u8 *d, _d;
 
 			if (!offset_valid(skb, hoffset + tkey->at)) {
-				pr_info("tc action pedit 'at' offset %d out of bounds\n",
-					hoffset + tkey->at);
+				pr_info_ratelimited("tc action pedit 'at' offset %d out of bounds\n",
+						    hoffset + tkey->at);
 				goto bad;
 			}
 			d = skb_header_pointer(skb, hoffset + tkey->at,
@@ -440,14 +440,13 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 
 			offset += (*d & tkey->offmask) >> tkey->shift;
 			if (offset % 4) {
-				pr_info("tc action pedit offset must be on 32 bit boundaries\n");
+				pr_info_ratelimited("tc action pedit offset must be on 32 bit boundaries\n");
 				goto bad;
 			}
 		}
 
 		if (!offset_valid(skb, hoffset + offset)) {
-			pr_info("tc action pedit offset %d out of bounds\n",
-				hoffset + offset);
+			pr_info_ratelimited("tc action pedit offset %d out of bounds\n", hoffset + offset);
 			goto bad;
 		}
 
@@ -464,8 +463,7 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 			val = (*ptr + tkey->val) & ~tkey->mask;
 			break;
 		default:
-			pr_info("tc action pedit bad command (%d)\n",
-				cmd);
+			pr_info_ratelimited("tc action pedit bad command (%d)\n", cmd);
 			goto bad;
 		}
 
-- 
2.30.2

