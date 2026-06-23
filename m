Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AE62288D5
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 10:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782208951; cv=none; b=tB0ZUk+MVMoYFV87woSphKHroXXPOUtCwIqjAFIr7mExqf0UpBUGf7xXzgKW3WXMCaFRs3CGFgntdW3k64oPVP3rjebSrbl3MWxvKzBNl/3f7xGa49VL+yREiV6k50fOLHintSD1Ww1hfnltTHI49Qx8KHJ3C1eWPag9jTO8Hms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782208951; c=relaxed/simple;
	bh=hxbHZbbylOHmXhBe4UEAQXkcI4ZtL9RDBlz8pB0C/7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mCp/J26Tv8n50EY1w+Dn5sUoHwYS0vhfq0e4+uwfHmqSlRcsV4SiucBIuOjcqCa2AzDfUyWLVX/Ys7bs1o7ZNuQNbQIUcAIH+55nJpaNXSgXqlFAC1RU8NlMu/Q/1dYpJpqXi17485Dh29IaY45Y+DU74GDz4u/X4/BJI5FtWr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=hPXtl+yR; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="hPXtl+yR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782208926;
	bh=w4qEXSa8F60PrFWI4cV9j6SAkcOANobZpWI7o0ogaHM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=hPXtl+yR16PzPA0zOpGb1BB9HPA+BYSslzNHea6KoTCchHzQJbv7tBPhxY8MzvqSh
	 YRUeBBLimNy62uGQFArXunRTGcqRScFMbSmpg4fA3Pqoqst2DvyesDa9HWUUI2soCI
	 69Ag3pUwNjDOEOogFnOgEfhLBSJg+3TDTooOeADA=
X-QQ-mid: zesmtpgz7t1782208905ta2b2e5c8
X-QQ-Originating-IP: dJOWx4UBInGMKu2FuZvFbEY58R2y2nLM6UQM5oiah+Q=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 23 Jun 2026 18:01:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3163887534398705854
EX-QQ-RecipientCnt: 17
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: 2045gemini@gmail.com,
	dcaratti@redhat.com,
	gregkh@linuxfoundation.org,
	guanwentao@uniontech.com,
	jhs@mojatatu.com,
	keenanat2000@gmail.com,
	kuba@kernel.org,
	rajat.gupta@oss.qualcomm.com,
	rollkingzzc@gmail.com,
	stable@vger.kernel.org,
	toke@redhat.com,
	victor@mojatatu.com,
	yimingqian591@gmail.com,
	Pedro Tammela <pctammela@mojatatu.com>,
	Simon Horman <simon.horman@corigine.com>,
	"David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 5.10.y v2 0/9] net/sched: fix pedit partial COW leading to page cache corruption
Date: Tue, 23 Jun 2026 18:01:41 +0800
Message-Id: <20260623100141.2383966-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260618-reply-item010-pedit-510@kernel.org>
References: <20260618-reply-item010-pedit-510@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MjyUMqv1ED0QQA+5ym0CL+UG+dLNoMrzdWqyFSUTuBSIsSuLias+9z6D
	tH5osFugB7jvn3Wf1m3JgX11SVg3V6IImhjv+Ac1V04NQFRCt+k7HC2eemwVKz5GdzqVq96
	yR/r/JYyxxbbI57lK/ctmG6TaMe8MaEoXaHhyvyzxk9+gXd9in0KNVDdYJfIycAJxZW/Z3E
	fDfIITQYBlRy65l1v72tgrlYOIEgloazROweU2N/1ArJuxMX1+wdA1uz6LhxVHjDaf8elkm
	RxCMVIDRTCt8B34MmJwVFIwHIAqdVlBFUbKSskVorY+TS0XYmXHOCpS7L0e5IGwlN8QlV3+
	ZBiOvwEH6FLKOWDNNDtYrR2sEnUSiNeaREvFiqtamQkvzSU5yqCHrifjuB8Q49kB8R9kkfD
	RGyjUzwrRi5c2QBIlw9RBPWJJS2bQzsrf9VP0TI2uaoVJ5o76NakA7cNtHGtE//NJdrBDfo
	8snmgX+fgxjdSI4NaGE4RTXWNBd072tkStZijcGKAFRARWBzyiDqs2Hj0B+HEP0V4koBbJ+
	DYLVxKf7BDLji8qrv/T0MKnlcZE5HQM8zkHT86TdwCVZiFIjABbvkCAcuCSVLsIU3pbCaY4
	qAH2mWSK6naPS56jYiXVjgBEwmk/bm1ozzX/xOexwGQ9+4/pjit2ugkHWjC95Ipk1/s71JA
	Bw76WXmGcvHXtrylavnZ2CjdJD1qK5pLHY4QPhrgPDautaByLrhLQU6lwokJYMO0aeZq5Gt
	tAaa8Wr+ERUQFRtS7o49S4iS96ymwYlV1iecV+3kLdDeyp6N1dBQHpwVdK4gh9JO84xiD6Q
	qaEteTXb3FMCdsSY9ccV5V1VijhQ2c9AZlupRSc3HXFKjROtzcQNuJYc5bSHwN1KCvF409O
	6F8HQGWDYTMx+lLnAVIPq67uUZ16Eq4WXJXM4ZC8Oh1j5ujPtu5qqnNEIMhX2Nv3O7kQkRx
	uF1poFqlwpC3t506aDCJw5sjIKQbecOmshwXMk+GC6uxRBq8S68MAi7Llj74LPUHpj/XQ5X
	ZAjAX14lXIgMkWyp9GZLutEZ9GasOwgYeFZGyjiUvFcy0SVulnM8du15wWzJE=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

Hello, pls add 10/9 backport ("net/sched: act_pedit: fix action bind logic") 
commit e9e42292ea76a8358b0c02ffd530d78e133a1b73 upstream to the series,
it also fixed the memleak in tcf_pedit_init() -> if (bind) -> tcfp_keys_ex leak.

BRs
Wentao Guan


From 78ecdf028f51269c2031eddfc7c970eb5dd43221 Mon Sep 17 00:00:00 2001
From: Pedro Tammela <pctammela@mojatatu.com>
Date: Fri, 24 Feb 2023 12:00:56 -0300
Subject: [PATCH] net/sched: act_pedit: fix action bind logic

The TC architecture allows filters and actions to be created independently.
In filters the user can reference action objects using:
tc action add action pedit ... index 1
tc filter add ... action pedit index 1

In the current code for act_pedit this is broken as it checks netlink
attributes for create/update before actually checking if we are binding to an
existing action.

tdc results:
1..69
ok 1 319a - Add pedit action that mangles IP TTL
ok 2 7e67 - Replace pedit action with invalid goto chain
ok 3 377e - Add pedit action with RAW_OP offset u32
ok 4 a0ca - Add pedit action with RAW_OP offset u32 (INVALID)
ok 5 dd8a - Add pedit action with RAW_OP offset u16 u16
ok 6 53db - Add pedit action with RAW_OP offset u16 (INVALID)
ok 7 5c7e - Add pedit action with RAW_OP offset u8 add value
ok 8 2893 - Add pedit action with RAW_OP offset u8 quad
ok 9 3a07 - Add pedit action with RAW_OP offset u8-u16-u8
ok 10 ab0f - Add pedit action with RAW_OP offset u16-u8-u8
ok 11 9d12 - Add pedit action with RAW_OP offset u32 set u16 clear u8 invert
ok 12 ebfa - Add pedit action with RAW_OP offset overflow u32 (INVALID)
ok 13 f512 - Add pedit action with RAW_OP offset u16 at offmask shift set
ok 14 c2cb - Add pedit action with RAW_OP offset u32 retain value
ok 15 1762 - Add pedit action with RAW_OP offset u8 clear value
ok 16 bcee - Add pedit action with RAW_OP offset u8 retain value
ok 17 e89f - Add pedit action with RAW_OP offset u16 retain value
ok 18 c282 - Add pedit action with RAW_OP offset u32 clear value
ok 19 c422 - Add pedit action with RAW_OP offset u16 invert value
ok 20 d3d3 - Add pedit action with RAW_OP offset u32 invert value
ok 21 57e5 - Add pedit action with RAW_OP offset u8 preserve value
ok 22 99e0 - Add pedit action with RAW_OP offset u16 preserve value
ok 23 1892 - Add pedit action with RAW_OP offset u32 preserve value
ok 24 4b60 - Add pedit action with RAW_OP negative offset u16/u32 set value
ok 25 a5a7 - Add pedit action with LAYERED_OP eth set src
ok 26 86d4 - Add pedit action with LAYERED_OP eth set src & dst
ok 27 f8a9 - Add pedit action with LAYERED_OP eth set dst
ok 28 c715 - Add pedit action with LAYERED_OP eth set src (INVALID)
ok 29 8131 - Add pedit action with LAYERED_OP eth set dst (INVALID)
ok 30 ba22 - Add pedit action with LAYERED_OP eth type set/clear sequence
ok 31 dec4 - Add pedit action with LAYERED_OP eth set type (INVALID)
ok 32 ab06 - Add pedit action with LAYERED_OP eth add type
ok 33 918d - Add pedit action with LAYERED_OP eth invert src
ok 34 a8d4 - Add pedit action with LAYERED_OP eth invert dst
ok 35 ee13 - Add pedit action with LAYERED_OP eth invert type
ok 36 7588 - Add pedit action with LAYERED_OP ip set src
ok 37 0fa7 - Add pedit action with LAYERED_OP ip set dst
ok 38 5810 - Add pedit action with LAYERED_OP ip set src & dst
ok 39 1092 - Add pedit action with LAYERED_OP ip set ihl & dsfield
ok 40 02d8 - Add pedit action with LAYERED_OP ip set ttl & protocol
ok 41 3e2d - Add pedit action with LAYERED_OP ip set ttl (INVALID)
ok 42 31ae - Add pedit action with LAYERED_OP ip ttl clear/set
ok 43 486f - Add pedit action with LAYERED_OP ip set duplicate fields
ok 44 e790 - Add pedit action with LAYERED_OP ip set ce, df, mf, firstfrag, nofrag fields
ok 45 cc8a - Add pedit action with LAYERED_OP ip set tos
ok 46 7a17 - Add pedit action with LAYERED_OP ip set precedence
ok 47 c3b6 - Add pedit action with LAYERED_OP ip add tos
ok 48 43d3 - Add pedit action with LAYERED_OP ip add precedence
ok 49 438e - Add pedit action with LAYERED_OP ip clear tos
ok 50 6b1b - Add pedit action with LAYERED_OP ip clear precedence
ok 51 824a - Add pedit action with LAYERED_OP ip invert tos
ok 52 106f - Add pedit action with LAYERED_OP ip invert precedence
ok 53 6829 - Add pedit action with LAYERED_OP beyond ip set dport & sport
ok 54 afd8 - Add pedit action with LAYERED_OP beyond ip set icmp_type & icmp_code
ok 55 3143 - Add pedit action with LAYERED_OP beyond ip set dport (INVALID)
ok 56 815c - Add pedit action with LAYERED_OP ip6 set src
ok 57 4dae - Add pedit action with LAYERED_OP ip6 set dst
ok 58 fc1f - Add pedit action with LAYERED_OP ip6 set src & dst
ok 59 6d34 - Add pedit action with LAYERED_OP ip6 dst retain value (INVALID)
ok 60 94bb - Add pedit action with LAYERED_OP ip6 traffic_class
ok 61 6f5e - Add pedit action with LAYERED_OP ip6 flow_lbl
ok 62 6795 - Add pedit action with LAYERED_OP ip6 set payload_len, nexthdr, hoplimit
ok 63 1442 - Add pedit action with LAYERED_OP tcp set dport & sport
ok 64 b7ac - Add pedit action with LAYERED_OP tcp sport set (INVALID)
ok 65 cfcc - Add pedit action with LAYERED_OP tcp flags set
ok 66 3bc4 - Add pedit action with LAYERED_OP tcp set dport, sport & flags fields
ok 67 f1c8 - Add pedit action with LAYERED_OP udp set dport & sport
ok 68 d784 - Add pedit action with mixed RAW/LAYERED_OP #1
ok 69 70ca - Add pedit action with mixed RAW/LAYERED_OP #2

Fixes: 71d0ed7079df ("net/act_pedit: Support using offset relative to the conventional network headers")
Fixes: f67169fef8db ("net/sched: act_pedit: fix WARN() in the traffic path")
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit e9e42292ea76a8358b0c02ffd530d78e133a1b73)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 net/sched/act_pedit.c | 58 +++++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index 35fa94ba0edf8..d40907e7771f4 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -182,26 +182,6 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 	}
 
 	parm = nla_data(pattr);
-	if (!parm->nkeys) {
-		NL_SET_ERR_MSG_MOD(extack, "Pedit requires keys to be passed");
-		return -EINVAL;
-	}
-	ksize = parm->nkeys * sizeof(struct tc_pedit_key);
-	if (nla_len(pattr) < sizeof(*parm) + ksize) {
-		NL_SET_ERR_MSG_ATTR(extack, pattr, "Length of TCA_PEDIT_PARMS or TCA_PEDIT_PARMS_EX pedit attribute is invalid");
-		return -EINVAL;
-	}
-
-	nparms = kzalloc(sizeof(*nparms), GFP_KERNEL);
-	if (!nparms)
-		return -ENOMEM;
-
-	nparms->tcfp_keys_ex =
-		tcf_pedit_keys_ex_parse(tb[TCA_PEDIT_KEYS_EX], parm->nkeys);
-	if (IS_ERR(nparms->tcfp_keys_ex)) {
-		ret = PTR_ERR(nparms->tcfp_keys_ex);
-		goto out_free;
-	}
 
 	index = parm->index;
 	err = tcf_idr_check_alloc(tn, &index, a, bind);
@@ -210,25 +190,49 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 						&act_pedit_ops, bind, flags);
 		if (ret) {
 			tcf_idr_cleanup(tn, index);
-			goto out_free_ex;
+			return ret;
 		}
 		ret = ACT_P_CREATED;
 	} else if (err > 0) {
 		if (bind)
-			goto out_free;
+			return 0;
 		if (!ovr) {
 			ret = -EEXIST;
 			goto out_release;
 		}
 	} else {
-		ret = err;
-		goto out_free_ex;
+		return err;
+	}
+
+	if (!parm->nkeys) {
+		NL_SET_ERR_MSG_MOD(extack, "Pedit requires keys to be passed");
+		ret = -EINVAL;
+		goto out_release;
+	}
+	ksize = parm->nkeys * sizeof(struct tc_pedit_key);
+	if (nla_len(pattr) < sizeof(*parm) + ksize) {
+		NL_SET_ERR_MSG_ATTR(extack, pattr, "Length of TCA_PEDIT_PARMS or TCA_PEDIT_PARMS_EX pedit attribute is invalid");
+		ret = -EINVAL;
+		goto out_release;
+	}
+
+	nparms = kzalloc(sizeof(*nparms), GFP_KERNEL);
+	if (!nparms) {
+		ret = -ENOMEM;
+		goto out_release;
+	}
+
+	nparms->tcfp_keys_ex =
+		tcf_pedit_keys_ex_parse(tb[TCA_PEDIT_KEYS_EX], parm->nkeys);
+	if (IS_ERR(nparms->tcfp_keys_ex)) {
+		ret = PTR_ERR(nparms->tcfp_keys_ex);
+		goto out_free;
 	}
 
 	err = tcf_action_check_ctrlact(parm->action, tp, &goto_ch, extack);
 	if (err < 0) {
 		ret = err;
-		goto out_release;
+		goto out_free_ex;
 	}
 
 	nparms->tcfp_flags = parm->flags;
@@ -278,12 +282,12 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 put_chain:
 	if (goto_ch)
 		tcf_chain_put_by_act(goto_ch);
-out_release:
-	tcf_idr_release(*a, bind);
 out_free_ex:
 	kfree(nparms->tcfp_keys_ex);
 out_free:
 	kfree(nparms);
+out_release:
+	tcf_idr_release(*a, bind);
 	return ret;
 }
 
-- 
2.30.2

