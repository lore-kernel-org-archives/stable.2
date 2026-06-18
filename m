Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124E42F7F06
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 04:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781757421; cv=none; b=FKxUSNGu/TZzUYXjIVsYJzjvcAxWgL0w9Y5mFf2ieIy/QcY8IlI8x5aD6LvALadVKBYh3oqCKOBEU7xp20ejTFcNEMoz7s2IDplwp7Exg5Nj6SQ5H44ON88WqITDv9o8YJpYpN6gLWZdPs87ab2pqUA76BHTL3QcV/GC5FCzGMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781757421; c=relaxed/simple;
	bh=j5g8dVqaqSuKvgOqTrairofKT4IZZIehRk9DU36v1tY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YRuW+E43XpphFMSGpzLP1+rsoDeFOxXxK+ECPD5SwnfR5HoR90gAx86xZ2lvK8GUNv7H1TDzd5J78aVeIcJlqQ76xIg9l731XqB9A7I4ICh6B6cgqHqtZT29ja6QoEOLeeFWKmR8y1+IJSVvb7R7ITs+G3Q4SwsK+Zr8N/SELeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=cq/2uyEh; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="cq/2uyEh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781757404;
	bh=1iM04kA9xD/Tp1X10hfbsdrdGEUX/5GE15+rSZ2vGlQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=cq/2uyEhuMyjnSXf6Rznio5NoLTseCkjnsQbm/vx4wFJmrn9WDzap/ybJiYmgX1lr
	 12euIdCzZSt0HZn+4B6eWmNtJYEtlpF7GtkOhwRBUGqiQv8olWljt+FMiFqalV16KN
	 3TsMaNHUamVUWQJeTXiewxPPPK/1IVTx1kPPGIag=
X-QQ-mid: zesmtpsz6t1781757385t78b70c22
X-QQ-Originating-IP: C4vrKU27GualLdts/rJ3qUpAZUlYqpfAI/S4QjiS+WQ=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jun 2026 12:36:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10969982639606645568
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
Subject: [PATCH 5.10.y 6/8] net/sched: act_pedit: rate limit datapath messages
Date: Thu, 18 Jun 2026 12:35:38 +0800
Message-Id: <20260618043539.1557035-7-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: Nyju35pICpZdKliuhzEfRHKmELJAbfM3JH6C+I6vYnb1ZDLXKCTy+0Xv
	D4yPq5E/1qejQ8DU5sSuWYk5u4z9jbIFmndy+vz5xUM/0M5hlHhsbgOBT4QPW4MYQifCJ2v
	8NpjiNfIAMDie3lP0xu8kKMv2PpYLbxo/xY+jmGceyDyi7pGImltXF36ZgPeOefFJB2vshv
	DLhWZSOrAiNk9/z/Z3cbfYpYDeqPY7DbEY4Nmlyko6r9bh89CkV5GWYwBIBKlLiX8MS4ab4
	sW1dQsP9IL1alh1tdDZ4VQQ5uwxpIER3DQoFBbiE3b1Qse0K4sO4FAquvm6bbsQcQ+GwetH
	aLzT99oZkKuuKBZIgPq5SuXItIs7X/90arid250FTgdLVfZvODywwWxKJPGRQSLCK/rN0Tb
	O/enHAejGusNaDXM4iIhG8/DYEvN6FEAEJAEah/ZLPKtnBJ+elx+hZq9QK3pR/lMldjAFn3
	MoTHzvzCblcOSRpVzO3nELyTbXNIqSZ/0xpayx0ZKVzLdPDHztFM0E9gyhn7XU6++Kxikxh
	vQA3EOWHRmmOy1yq67EcOERcNfEQEWcoNJ5yRpL/WSoxQv3fabnYTjuZSNfSgYCyWSur87U
	H6WmN1H8CKgVpNs2cu1vWgsaCdULfDuQLK/imTwBnIHmBz2C+NFCDsvgM7pQ5Z3glhBB4O1
	dtqTGjjoTRtvnbYbOEQw9EzRt7rQoOgdsvikP97SyaPQ8iB3a4qMjn3Hgh/+kjGJC76Cg5I
	0lzy/E8H0glm0Wg6ctMiWDTlp4Ay8sHMJDG2PnNYt+FlEWB0TLjfc+hleqPxdyicdFP1UPu
	IExXsLk1tjWTkeYLEisR1qQ4dkZpyNqa/7rKALYbn9Y8lQ/I97On7ydWas7RmxbFSLf+hY4
	5WoJ5z7SvZ2f3xdRjgYYTyKig4Zgumv5RKQfVm9rhVowtxf0kzc1/fzhKjuR4g2ljMKeYXf
	mo+noYAhh2hvj1kE+0tLqU+O/jf8H5CX1U4XSRxweGcCPcpF0z8swisjw2Ohp3nkjeAm82r
	aYU7Yr58ylpCuXM+nQiUz++CevfCBGTr76y/lNaexs9ZgGq+ZxuUbitJjsbMt2lDUEY55RY
	0iwPzLSVC+P0CeRA8dLW1AzwGOZ3HsaJL+InCKT5oECkKOLshxPfg5b4/wdCIDIHRoUj7Qd
	Sr/MgJyt1fhMwVAmDGfHAxdO9AKSpPdT4fRDiH+N2WAZKb61jI3UzZAW5l5tzK/31w/1
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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
index 95ae885ecba16..ecad6fc39dc3d 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -383,8 +383,8 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 			u8 *d, _d;
 
 			if (!offset_valid(skb, hoffset + tkey->at)) {
-				pr_info("tc action pedit 'at' offset %d out of bounds\n",
-					hoffset + tkey->at);
+				pr_info_ratelimited("tc action pedit 'at' offset %d out of bounds\n",
+						    hoffset + tkey->at);
 				goto bad;
 			}
 			d = skb_header_pointer(skb, hoffset + tkey->at,
@@ -394,14 +394,13 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 
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
 
@@ -418,8 +417,7 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
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

