Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA992D0C7B
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 04:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781757398; cv=none; b=LpRvr0bd2EPYU+vFZNdYx9JSfFvfIrybOWXOBNE153VCZwUp6mz+8+Gzb2CAWsq7towDG/jexmEouJEVTmpFXfOi/CwV6FAD8pvuRibzLkC9ybS44/wuxEHkSxYQfdZlWX+aiUz5WrupT4yBXqjzbvv1feSn579gaXQ+wmiMq04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781757398; c=relaxed/simple;
	bh=11Ar4NDtq4srogwyVX48qlpYSqbpY21yAnOr5aKkHlk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qNwDGJtrKZK/wdGzrdASj9xIf5SoeQtRyhB4Jeb/xrmhy2CuEGqwBRu5/zPWa+iaHK9vbRskrqkFwn3mOf09cYJySaEM+yfCzhZS2Re8CqwP+j7bOTUuV71TGrANWLCAgz2UPieP3Qo3X4aX/1T1ps++bGZCqSFkZEZrePA4TUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=m7L5KzPF; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="m7L5KzPF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781757372;
	bh=5cYCtWRP+F1LP5ygZoFjh73oobI5dGWfLfh3h6q61uE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=m7L5KzPFq8SYx+uGioQQqvoTgwcFY/DzP0MHQcXTvS7VpZuhlmpmaDQVQkk2JdJFC
	 iyNCqBkZCClYy7FfE/eXTEB3NL45qprHMPrWBwQT5niqauR/rPfKQJusCyBeLeq7Aj
	 B48dPyE6WBt0tjNSgXN57beppX2BGmd0w8u0mhRo=
X-QQ-mid: zesmtpsz6t1781757351t2f57eb58
X-QQ-Originating-IP: R9xZaZvg0lmQkOaiTjareUrDDidtjbuJUhzUYlKoNgE=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jun 2026 12:35:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5125543435396223975
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
Subject: [PATCH 5.10.y 1/8] net/sched: act_pedit: use NLA_POLICY for parsing 'ex' keys
Date: Thu, 18 Jun 2026 12:35:32 +0800
Message-Id: <20260618043539.1557035-2-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: M2/0JsNFwYZ6pe08CNDMndI5O5d99vvaTEwZc+mkjlfh0xvqzE00z/lZ
	UeVU22QHo4sftPdw7uyHIVLyz9USscZ/+QEoPeESIzTLueYOcrIzcz1SFDtp7RWwiOo1CpK
	/kaFK9a/Z2ldVWPFb9bMwLCYrFnQf61+4hhWcUpwEv4ej1xS8tzwg3Z8xqPrC5ljDFO6bol
	8cI9qIuKfVV19cA2kEzBqCcbxsR/KAsQaJWi1Ta2nwP9LbXlzx2Y3m+xrsqh3N0TDf23XUb
	jaADD+E4Obzp0H66xUjA0irHLpetl1Se4SZQvSqgV1/76lwarG2+7H+4YlxoUXfQOLRZbJl
	9OCuRJWf0qqG/Fc90xhypMarHFjtTP6sNMZmExcE9E/BZkclxMG+TYfwrU9+nC5tc3H/hqU
	2MKD46PDrSUBaB59W2AEtuVTouSsT7zIeUs3cRqJb73dz9NiqJL+43VB30rQryZNwJWlb7m
	iibxGNaT/qBDGEoxfcFNI3S0OD9sYp3Ss58QcENZir5xHb/TjjNawjgvaiECMhw8pHq9rc7
	zkkilwhIxX2QwhPtR+QPGHJq7w81Tje2NVakJOTzyr2erWNab3sHtM2oYgZDzsqc9eIiY9/
	8HFpqKrgiO5Day93vbu+W9/h3JKBpk755o9QusJRlD5Um+Byuho2sjcUdVqd6sE3MjuGdWz
	RlsqpPrcZguaqf+LW7tN9BpY9WhsWj7lq4TYC7U+Q5KRA1COyewOVAJN7mYLKVyiSxb3c9E
	GmRE5KgTjLxtP3ab6/0ouiS/DA24PSrJRYhEOYjP5GolejWDre2fQ3zf1pZFd2O1k4aqwXa
	5QmAzx8RXEpy/BWl48EQO/8un/UNU5pKF3F7+nCeZehzRrIXN0RFVUpYN9i1+kF6cYJEID0
	lNTgr/3RSmd76+Ixdeg9A6Dh5GYMkc1Pc3+yk+r7Vu+9Av/H7bT86NPidEK8bk9fj52qR8o
	pp/pkkICIO+vjmEzoyYlkloKfsYMnPxOcnHWv6qpXLdwl3DJT+9HxmNZMcPaSaaPmuwbQVL
	YTL1zC5pJD2VF6j1ncnq7vmW7XtDd6VxZo3qyETIff7D6oOWlObOBwJRe3hSCC+EnS56mFu
	WD6GmENYJ4Y+d+zkzDE9oSvX/3FE1+3PQ==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

From: Pedro Tammela <pctammela@mojatatu.com>

[ Upstream commit 5036034572b79daa6d6600338e8e8229e2a44b09 ]

Transform two checks in the 'ex' key parsing into netlink policies
removing extra if checks.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit 5036034572b79daa6d6600338e8e8229e2a44b09)
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

