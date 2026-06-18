Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4070A3D7D86
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 07:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781769334; cv=none; b=HqIq80Cveb/BuS7ky8ZpFg4xD9hTMIOa+TI438o2QhIsIpiFjNc11n38NcaPuLOC1L1xjPRtqEXmW9evG7wENTs9HOiLI/LFoIv4bO1RTCn70MKjR7UeTLHE+Xb6a7T3woAx5/Uzc3ONmEO7xObn+8Bp0xfPQfofipU0l8AL5+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781769334; c=relaxed/simple;
	bh=O/QYmmGM1Y8xuVRFrimdKn1X2zOedWIbB+b6DMfTK8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ut2cMFSNTQYttPoiuHKCYECwuLx4J0TP5N64Fi49BwhGt7Bz/zEwLknLYxOa2mW6LLheucjS4u23C9u7lubtzjDI6oAg+tlNs0MHyJPJfLQoBiDH3GpIxsBLgK+H5H29fqv/IJdXpErletrWKWBW8RepZVp8RJBt6PGM/6gdr30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=XmFzArxU; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="XmFzArxU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781769303;
	bh=5DxKKwjTeK/x72VejuOqwFnLkIznmy4QERL6IPhU3JM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=XmFzArxUdeRgtUVlnC5V0pAXTWv0IzjOle+RTkgbbXrjUylhngVN8FZy+1Zc/xEX8
	 7ZRVdSBRJhgruTDpTqE2o7L3Xtad1TohKX1GOpIOstUd2OeMbwWF7/zy3J/6fNADLG
	 949d5IxVH8QTqlUqawWyxW39NqRwW6NOK4ipMlMg=
X-QQ-mid: esmtpgz14t1781769284td3313f67
X-QQ-Originating-IP: cHM2vo5MAn/Bb1tIc5w/RkTktPO/ilz9p57EbjpHsTw=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jun 2026 15:54:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 896573733499436259
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
Subject: [PATCH 5.10.y v2 6/9] net/sched: act_pedit: rate limit datapath messages
Date: Thu, 18 Jun 2026 15:53:46 +0800
Message-Id: <20260618075342.1599593-7-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: NcVcyjPwlkeJVT0iYaq4xvy2FWKP7nmbm31aFvyrjjHOZjKJDjVhb1s2
	hae4SJrZC8VqZvvHth0M8B/VEygCydYj/z9AkJkBh0WVxPCKDIH3mWOR7SpB6o4YmazKP0G
	2S/Br3CUltaUTlUDLooYKac6bsZB4G93yMro5s3CFjjggFj/WGyviJQjrHSeTKuO6AbxWQk
	s2llMsnQZhZzz451HMUmZMHX71Cc+2GTlc6KKrnGmQE4Y1+HXX+ab2saYti+FDgdRvDIlDo
	4C/d8TheKuuDSuouX8C+gyma2fS2l/A8K8drARJxwgCOcaZe4kfkrOhUt/DRVw6p7/+CUko
	xdkiEEyUUJQBbCVIzJfgB58bf874eeLTYeaKs6oC9F+8DJ0EcCMqJYtq0Tz9F54VFFqqtpv
	J+qhhDzES8SY2TKI5X12ep+H2L/565WXqthr23jUXaa1aj5GL0bvo+9wpW1Ff1fQL0VCMxV
	KDimZnAvJdlF3tQKFF+PXtzAby2fk3ZuEh2FdtsYdXrTjAY0zDnLs+Q8QjbniuUXiUI2ZIX
	YQ9zkdr8nGuW8vtzdVUR/JDv/Q30ScO28oBp9lLZFP+lcQIBYZNz0t2+jDBEzakROpJzs5j
	+zgLPQ9HNeP38lMdxTuf/aeNq1kX90Eg/LCbe/Y/jcPTyHoST7CSi9ytxKAL0WC0lvNcNgb
	sjNXRX5VKGZ2GAyg6JyJDuclFzWD15+ztUHqRwYS5x97zPIMQN8glLu1acwbkK+cDBJ5OR1
	pKdkd105uNm4obxUti8G5pIvM21mNnXuh0r4A/FAaq/SHgCZWau6uWhe55ivEgWL23ic0MR
	WBmhk9375jFGUAlHJ01/Zb+ICAc3MD9JSyaN2i8B+ucOXa61mGM8pVFvhmEy4CX2h26a8xV
	MrBPk3MZFEdcfVB6Ei0AJeLZc9elK1ha3fpCZT9MnoYarAvQiK7M8Th0nh9OQrJM5SHpWnc
	aDpPZ8gwSa4domdm16VXhLxt0z52MJBh0kEeO3EhweIxaMMs/oKbKhOefCcgdcQ3JZVj/SH
	TnUEYjgk5Y2H5Y4SA/3futKsULODINiCB6VAArvDoXMTJj/o67HwQlcEE+qG5tY7jKRDGJJ
	aLDj4oJ+pVgF3+Tsejr8INo617kAvt745uyRlCMZGTKFVXOvIz3KhQoRdrJ2UXWZFnPJLfx
	5mfqITt1R6rlkyXlcLWyQTIpNkWWxlLvvJ9oTQPuZ6WZTxQ=
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

