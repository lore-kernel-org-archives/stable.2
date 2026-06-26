Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24E7358378
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 18:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782497321; cv=none; b=moDH+nq3P2VPlPhhIBqadElURX1G4E06OHGBrbf99vruR91qUKchrwtoD9Q/lWCu9CH9WpSvpGwXMeW0BOqYUm7cADtHY/xuKuib0gPbBNfPgduocA3R2TKzYeX9mhX+GuDxVHVW7CQt/sEW5Y2mAiN0Q76TrBlaZtsFiNHz2BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782497321; c=relaxed/simple;
	bh=2PiZn9SRQDeperRfDJVT6Knomjm6hgdo4VmiUanSiOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LhfgW4/kD04OHakqGtszpT2tcDWAyXVyfiO2sGFYRJulCGfeL6fRwwlgFKL6yuJBXO705iVyg7vl+FikSIQpmH/INbsTdrJRHIN1PL/V+qnPN86zwtenlAvQ0e5AWcThj0J/PIjHkPRer3xuPLiVBFIxlLWBxJYZBEyM/aYgoiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=NjbteysU; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="NjbteysU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782497285;
	bh=WPMa62+ZEbyp3pnV8JluZueKwkcDo0WT7AM20gDCKFI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=NjbteysU2C1TfbDVXEenMLDIhsdQ+FE3QIeMoPdFpu1R7N5Q+zX9Aj/sk8pc57QSh
	 I9UBLGIfZHMVe/mt1E05CYMhpRXQgxS1kkgUCPTPaRr+Dr5sXWOkjuakYypfpy6e4w
	 Zydi0P9kVkDrHdW9RkjzdLP37LxcdgaPWUQ+o/U8=
X-QQ-mid: zesmtpgz6t1782497266t07f861fa
X-QQ-Originating-IP: w7qfIEx3L5MvPkJaIiTBwNMJJUVdeNgkanvBvEP0rzk=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 27 Jun 2026 02:07:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11784246193811835986
EX-QQ-RecipientCnt: 17
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: 2045gemini@gmail.com,
	davem@davemloft.net,
	dcaratti@redhat.com,
	gregkh@linuxfoundation.org,
	guanwentao@uniontech.com,
	jhs@mojatatu.com,
	keenanat2000@gmail.com,
	kuba@kernel.org,
	pctammela@mojatatu.com,
	rajat.gupta@oss.qualcomm.com,
	rollkingzzc@gmail.com,
	simon.horman@corigine.com,
	stable@vger.kernel.org,
	toke@redhat.com,
	victor@mojatatu.com,
	yimingqian591@gmail.com
Subject: [PATCH 5.10.y v3 01/10] net/sched: act_pedit: use NLA_POLICY for parsing 'ex' keys
Date: Sat, 27 Jun 2026 02:07:26 +0800
Message-Id: <20260626180735.297017-2-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260626180735.297017-1-guanwentao@uniontech.com>
References: <stable-reply-item001-act-pedit-510-20260626@kernel.org>
 <20260626180735.297017-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: N+LlU1kgSOwKIW7WZxsh8sIhzzPd2546IFOzQnL/Ai6EWiDS9cSNo1G6
	XEXQedtRe/HepMH4GUVouv6eNM5cDnm7QcNm9cuiIR8iSe6/UAly7yWs1fC7R1nAdZeySC2
	UO1HU4fpeW9LoQk981xTgiXTIbdE1VUTgE2PZpIQM1vRXtSclAK/4ZE626zxYX10SO57NqH
	2gtkouVrIZIzCXmtCMEOEQ/PjrPeF+p07zZdApObT+iTbf0LNk7Teo0ml/rFLjY97EUqoOq
	joAqD2c5OAhPznkfBZGhcZDS4wAJIzrK+kbgEmXfQfmbll7PLwhUaE1ZniIeqXY5CG7a3/z
	NKrGfcFPG745YnrcBWeI6e2tRsFb+97LaRUOmLi1kKi37UVlkj65KSUwSHmfu9HZJLjZRyK
	Sl4wYKN/ktucHikstHPPx34qjlo9NNrshjUUZooZmzEXnlzW0XVaV9Sygp5dU8GbNnBNV7U
	TYMmFAw6wUhfnxuu6duW6xxT2SjNgt9MeN7yWV48SqnBRAgLZuWRqDeY50TTNJd369zLapY
	OkbMxWT4T3pNgRnuJVfWJ4w7x2l4SmJumO9vNhGYPclD9V+8DKC8FxDn9qtrME+5x1eYSL1
	NCeFHsotxmdUv7vEw2xw73gZdNa8nBpa5DD2em8U4lP865Bu5hGd7Dn89Fh7hno1hmO6g6l
	e1vhyxde26Ws7g/uaZvlvkjjRAlnlJVZpG3jntU9IgToJ92rlqYgUU6u5uVQfKTE55kGmuo
	N+SiHFUNcEclcWz10UcQop80xaKF0j35A4+m7EVQSuOtvgWjmneaRpkCtbJKmuqtiAU3I+a
	dCUn1BvsFUAI7oHigTgliSEcfx25yw0M44HywxGpV0yLBc8ZRpGDSbbACmyc9QcnauTtuRg
	AEFzBuWjIxkMcv0aNbJJA7MCfeUBHRwY0bPyQt8hyUQ4BPoDgJBTzRyJwIFZIdWdpW8BOx/
	LYqUWLsRhxvmbtNgpqbGniCtAqChU7qNCe44SN62loJ9q1fB8/u+doXzgjhVdWLBmE3GvT4
	MHsN2FvZ8V9BEaV1lAhoUcxiDthYR/H/vcudAnS67mFqpYwoeemrrH2V4UPYepc+z1P5Cxu
	A==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
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

