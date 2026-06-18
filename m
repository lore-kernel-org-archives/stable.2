Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5603BE632
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 07:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781769295; cv=none; b=ni5PCfi0x/C58TgDStwHOrx376YkVNt/Uq2SGk8vPdznEJdKVZuufqMNr8SigacWtkPwANbqbF2kB9zygKm7zblRa6rUb26Bby5R3g4tvndtWTjBWcDrZjmVDMmwzrb4ilRVRj9NnGPiIp3cJttEse0K6ZLOWZkuezC1gbtX2zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781769295; c=relaxed/simple;
	bh=2PiZn9SRQDeperRfDJVT6Knomjm6hgdo4VmiUanSiOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BybOYCdVLSF1O3eXalwIfWEhPCRqWEZdAFfAzS5xqdRXTUmFHxTbQyJfdyapTPAXfI0ETr/XBfAPn5TSB2eG7+MTALynerkdEDBg/K60xC8itaQlY9S/6iZGTeIs0O6zeXaw29wSyg4eGx8OdCESrjd/Sb2v5+eg5+Hi2daIT2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=eweDyfXi; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="eweDyfXi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781769265;
	bh=WPMa62+ZEbyp3pnV8JluZueKwkcDo0WT7AM20gDCKFI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=eweDyfXiHX4C/MuwE/H6kztsDVA2kTfW3oLYRnDMlXjL7VX3iWaWHN8TygAIMkmOu
	 E4vMBqxzyMUJyqljnhCj1IsKVKvi/UtPQuWR1sles6pWyxXNAYMfRXkjUGpUdo9q22
	 cWWlBXiWGdUuCuH6fnZZHxS0nSSkKPLQ+fw8DcPg=
X-QQ-mid: esmtpgz14t1781769244t2f5646ce
X-QQ-Originating-IP: AAH2ecRszZcVnWK6++s7kMBT1+rR0/gSD5JMGBHe89Q=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jun 2026 15:53:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5244681131725819264
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
Subject: [PATCH 5.10.y v2 1/9] net/sched: act_pedit: use NLA_POLICY for parsing 'ex' keys
Date: Thu, 18 Jun 2026 15:53:36 +0800
Message-Id: <20260618075342.1599593-2-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: NdRGVRqcYnE4u+G299llEh0U8E0Jv2hv97Gs2GVRxnOy3wkJrbzCbOfi
	zny5NlAa595DvnH64CqYFMP+3tnXXTNSG2xfuQlp49mOJdt0BNFyTx+SbS50pL1MlyvMSc5
	DX3lSlu4XOgcpXpp9OQV7B9g+Lcgmpn9xSfJW74ChXuFx28ar7E7DzRZxW1MBXie/SF1hoo
	IxsDyIdndUQmgVWSHESsnuWqI/UUsqOY1607V32/E+twmXZXrDf/FQsHExVku2aZPjAleKk
	X+C9OcumYHS42avbKc+uxbtCmgnjj0mjS74cE97RHo5xEHF6RELL/IlOhdEFg2JuvIvh6JT
	wX6Pwa3pUE9dqai+rgSiOVDItX+9NyzqlK6pfKAYH8igPB0IStIYubjLuIXf/Tx1uOWagIj
	jdCmnKjuja16/ojqfEEfJHPld3SIxMyTIeALeTB1cxYA84y2VehL7ry9aJp94MxwjcDJGPE
	3AnsBvlX1aUIlVPMY9GosJTECkRf0lNe01TgcuMyek4Nh/yEju+2Kgzc7Q9J+X1uqF/Ysqw
	VSqFNEkgOi3gXZNXEUFvCW056c6TxseYj8Cb0blCUq+tLZBoN9q7zc1T1nQBMCFYG7/s9m/
	//XELHBvjK8yUCDP4WRneSwbwud3A2FhAw2Ck+Pm0BPzwc0TJ6HVdi1ygj7XaNmwxXRfqJ/
	nQ0/7aP7x+LvDG8r/7Haz9l0RwBsFAZwiFmwbPnu5tdPjQDbrCDFmHbgPJ6aJKlXFHS1InQ
	+ThR5XC5zxbf3IA9JJpuyw9QUUoB/UAhQNN6nGCMf0K0blxLPDUpEM+CNUmqN/q5wLTMQOt
	WOB9xkpoaSWCqZbRqEHEI1TkHXqi0r9MoFQtrbN0FD9FJFnHtjBz4UgWKY863H0YysSyrAQ
	3p26CRNr37uE7B7B/lISQk1rrbxMc3R/adsJzka9edjLJlzLCiAQOcAiGiC0+oqnfXrfxZX
	Jaga1lZcuWlc+q/IqU+217SfiGEaLCNVEFQ609jGKbW4bicFNIxFzT501RiWTeyILeu+cHD
	BjSp/QMpqHiLWOCDt53vGMa/HrzaJKtMGQFJPPGEiHG3e6cAX1bcn4xqFcWYonHGwWiNf+a
	A==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

From: Pedro Tammela <pctammela@mojatatu.com>

[ Upstream commit 5036034572b79daa6d6600338e8e8229e2a44b09 ]

Transform two checks in the 'ex' key parsing into netlink policies
removing extra if checks.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 net/sched/act_pedit.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index a44101b2f4419..510a3b5b8c0c1 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -31,8 +31,9 @@ static const struct nla_policy pedit_policy[TCA_PEDIT_MAX + 1] = {
 };
 
 static const struct nla_policy pedit_key_ex_policy[TCA_PEDIT_KEY_EX_MAX + 1] = {
-	[TCA_PEDIT_KEY_EX_HTYPE]  = { .type = NLA_U16 },
-	[TCA_PEDIT_KEY_EX_CMD]	  = { .type = NLA_U16 },
+	[TCA_PEDIT_KEY_EX_HTYPE] =
+		NLA_POLICY_MAX(NLA_U16, TCA_PEDIT_HDR_TYPE_MAX),
+	[TCA_PEDIT_KEY_EX_CMD] = NLA_POLICY_MAX(NLA_U16, TCA_PEDIT_CMD_MAX),
 };
 
 static struct tcf_pedit_key_ex *tcf_pedit_keys_ex_parse(struct nlattr *nla,
@@ -82,12 +83,6 @@ static struct tcf_pedit_key_ex *tcf_pedit_keys_ex_parse(struct nlattr *nla,
 		k->htype = nla_get_u16(tb[TCA_PEDIT_KEY_EX_HTYPE]);
 		k->cmd = nla_get_u16(tb[TCA_PEDIT_KEY_EX_CMD]);
 
-		if (k->htype > TCA_PEDIT_HDR_TYPE_MAX ||
-		    k->cmd > TCA_PEDIT_CMD_MAX) {
-			err = -EINVAL;
-			goto err_out;
-		}
-
 		k++;
 	}
 
-- 
2.30.2

