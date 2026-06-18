Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BAD14884C
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 03:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781754219; cv=none; b=aJWpyAthbcitFE3oZsAHgIO8DnwKFKWAGn2aL9yeKlF2diIPLIppsqpHOsS+iVvpRwEqNSVwLdXY6jm5ep9Mz+akZ9Tobpxq8J/LTRCgdp0XZ2cZgaB2GabP+4jAYkXmTdI/LpGKATfsfE3QnKqX7CdRAsyfgzlrETmOtctnQng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781754219; c=relaxed/simple;
	bh=M/SY2oHM6heqUzd5oIg6bRcDLp15Xu/sq8tRBYhnyuk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o33H+WCAkk6IF4W9bx6Y2TwTfvkPLIbgCghaFJ5/pMc1hf67oaQgqekIk7PGlrxxEcwCz524Z2/ruD2LQNygYLFBprqwSKmqtueprgcockgaQzMDTQupODm7cUxnYrbZUawQ/2jiBGkYOmvl503RVcn9WNfqAoVIBEseEhJI7/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Xar4hgfl; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Xar4hgfl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781754195;
	bh=aKRH9vsLdSP6xszzoF1c3cSPDafELHO/23Y48eGZWAk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Xar4hgflGnDLP7Yi5sLh1G0XxU9AJDPSoxMlTwJMQsFKBbgRNBQSxBWRRp1N4mw3A
	 E6QPqK2lAyOl6BvbXk40Dwwf2EW/Qd6fYAdPq+b43pz0BfDUFeyi/m5aELMlM2MwSt
	 QlALQj6OYuJVwTa1xWJCCX3gdw0us6GiWhl3PBl0=
X-QQ-mid: esmtpsz16t1781754176t2cb8eb53
X-QQ-Originating-IP: ryqksIF/MZ9pwBPnAEH3OlDBJglMXN+2/sunf8kgwJU=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jun 2026 11:42:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5472547804747186854
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
Subject: [PATCH 6.1.y 1/3] net/sched: act_pedit: check static offsets a priori
Date: Thu, 18 Jun 2026 11:42:48 +0800
Message-Id: <20260618034250.1525454-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260618034034.1525175-1-guanwentao@uniontech.com>
References: <20260618034034.1525175-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NcdhUYIpzyYIAib7Z5TtV6S1PTChVUe0V5KCIykPFoZYHYdzqM/DgMR8
	x3jmn8/peMYFPPg2uUshn5c3JEYLZUrhjUssUDxLkp5X+D43OABOFGrYgpY4F1TgNdMon6g
	b1flRxNMelqTKpMNqlitdfqM3Wsv9464PAx8q4k9lvV+XcsBFj5AwwhXkkY/2ZKJDH+TAGt
	XBo6A1ZyE26s8Jv27SX5zwI/dPewnQjOZbLmQC07pr27PLzxD8/tYN3TGiY1pa6KN4yE6lA
	b18lKp6/uhyHK7T6u4lpJaNMjBsgXxkp2958V8Dr3BAuGSZjOHA9Vm0wB5SduXHNVRxuuPD
	Sm7p1bM71UfI6IAxq19IYB71GNssE8yaZH9LP87GBZ9VmPC5mI+RwqLfmP38tmsXrnlPdC/
	X4qf7Sgfr9lGS87o4CIWzWGWlM1g5kteppBJhhOYE58pipwdk5tTzr5cdf5y8TQyJsqqT4k
	JtSQIgJdW/TVbR+RY8uWwCa72hxHvqehodYUVAoiwrInQE+okhc7JrYk6Z40tTi++k8ZIVf
	SvYS35d8tAgykZWe2fgoyKEc+4NJ5XDyzTtJPO2TjWpbZzpOSdqLoHOx0NwYxFFLz9ACzSd
	s4ryHlDdcjSCKWFxNijCJi+svkuO9Mw1LdOvOCc8RX8Il5Dl2W2L7lNEUxAojTqgMQ4uuM3
	R6di/EThAmbq6lwYhrR459+ttrshAwk8CgGuybYbDtHuPc0M682ZiI4q4Jkzk3eETK0WVGi
	QKEEKJ3NHRdS1sqHCU9Xw+5rcZwYq0NoXR4UdR9wiPDWef8+/PaUHxJvQis0MJx65S7fmjS
	m3XQvk6mihIgu5RMdtOSFKI70YMM8CK32nL6Zxi1d0sU6pjmfYfX8Z2BQOys9fDT7oB94nI
	R8vwFTsILUatEFZRsuhObQswEdxFv1hxgwHw1d1KP+5fL9jMV6OZia/nz3EfBWZYLZFDbIY
	3CjsHwdWMsYm3fpvwMaVMLu+j7DsOS2tpyeh9wt+MTxEKswOYisyKxBJG98poYNqutDTlHk
	Bdw2NUynHDPhSl3bVtlFcEHKvf/x4esMAvcQIEF1zPMxCJWXjYuDfqTTne6MBIqYKl5ji5/
	cV4uLEP9mnP
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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
index aee2e13f1db62..2bdc44efee779 100644
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

