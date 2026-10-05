Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE5843B6D3;
	Mon,  5 Oct 2026 10:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791196141; cv=none; b=W0eutdl9kP3bNXg3CTo8d23xZCXQ7UQW9kJAHfSRxjjEUT9tAK9LCGYCvFpnO/57eYPG5QBpskdNWVac1NYAfj28uRXdZD8i9U9hjHJrZr0IKWIZDa4Q3IrNErWoIHXu/34CgqP2Ovc5gl8IFM0cH/8HJ7L5en8y611eBOwlDLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791196141; c=relaxed/simple;
	bh=4GB93BZ3m0ejP+9+J9rKoHZDQNWeKjDF/7OtrCxtGcQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=M2euE9odWoPelolKaHvla0EkvF5mGPQhVL9FQHTEKJguhgH+3GZh2Ce2g16rTuiTGv7XLM+OszT014JP473w1ub2kjciHxPOwm/wBccJzhLO5MgVd6j85ayG2+iPd8L//dIyOm+U+JkNT/wwo1HbDKOJTGSVc2sZBvBHy+dJc18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lKaz9Mzv; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lKaz9Mzv"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 22D6F1A116E;
	Mon,  5 Oct 2026 10:28:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E93CA604FE;
	Mon,  5 Oct 2026 10:28:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 918B1103306E9;
	Mon,  5 Oct 2026 12:28:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791196135; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=d1yko/D9Unw+OoKWobC2nRzpYBVog/0L29C3kVKTnv0=;
	b=lKaz9MzvggQwJOT1PvKcMe9qowHQG1WMoI3y+OW+Fe9zuXFck+i1u8N69lrJwbfCPqTYzV
	MJwWwAqT4gPF1HM03Nf7W2UkKqoNoit/R/g8lbKwbwhzyCZtSdBkavnMoNDygu6J0ly5tI
	IidNHsXTeLpGsUmDSMjCZr6Gu10iaGHaC51SKAEK+IuXSdzxPa+sWoUFZOF7RU6guIpVAQ
	FJV2QYwcQW0mx6wD5ti/zHn9CRykxkiZBalhlLKWudfvxAE+Dj25VZf0g1qm+IPfrSnp+y
	ckfupUNLGtX4NaM9A0Ct44/7f3YuE8x0s0SDeOJ9rq1qhgs75D5wnoUdpy44Nw==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Mon, 05 Oct 2026 12:28:46 +0200
Subject: [PATCH 5.10.y] net: sched: cls_u32: Undo tcf_bind_filter if
 u32_replace_hw_knode
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-cve-2023-53733-v1-1-d716b944802c@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMyw6CMBCF4VchZ+2QDpPWy6sYFlIHHRdoWiQYw
 rtTdfmd5PwLsibTjFO1IOlk2Z5DAe8qxPtluCnZtRiNawI75ylOSgVCXvYiFLg/iA98FA4op1f
 S3uZf8Axfs6s/aP97fncPjeO3hnXdAKOI2DB6AAAA
X-Change-ID: 20261005-cve-2023-53733-61f835619316
To: stable@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>, 
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, 
 John Fastabend <john.r.fastabend@intel.com>
Cc: Benjamin Robin <benjamin.robin@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>, 
 Pedro Tammela <pctammela@mojatatu.com>, 
 Simon Horman <simon.horman@corigine.com>, Sasha Levin <sashal@kernel.org>, 
 "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791196129; l=3598;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=0CbcvlsOexrkd68Qr7xxfnDtNQ7kXFHKUKqoqna7G98=;
 b=Pk7d37YUVyF9pN6g2idrWk4YFqOrGba/A9seqTXor4+3Me/fuarzigBxsEnxSV0PrNoYfwfEx
 jb6dv6EiCRyCBUlqy0Vfqm3s1K1wrGFjUXuFw4YUnCyVxd1rR7qP82D
X-Developer-Key: i=miguel.gazquez@bootlin.com; a=ed25519;
 pk=k/2KI9jkmayaF0ghZ8QYUH9Wm/kFHDhl8QoZ0RHbr4w=
X-Last-TLS-Session-Version: TLSv1.3

From: Victor Nogueira <victor@mojatatu.com>

[ Upstream commit 9cb36faedeafb9720ac236aeae2ea57091d90a09 ]

When u32_replace_hw_knode fails, we need to undo the tcf_bind_filter
operation done at u32_set_parms.

Fixes: d34e3e181395 ("net: cls_u32: Add support for skip-sw flag to tc u32 classifier.")
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>
---
 net/sched/cls_u32.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index e501390ccd75..5221ce128526 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -709,8 +709,23 @@ static const struct nla_policy u32_policy[TCA_U32_MAX + 1] = {
 	[TCA_U32_FLAGS]		= { .type = NLA_U32 },
 };
 
+static void u32_unbind_filter(struct tcf_proto *tp, struct tc_u_knode *n,
+			      struct nlattr **tb)
+{
+	if (tb[TCA_U32_CLASSID])
+		tcf_unbind_filter(tp, &n->res);
+}
+
+static void u32_bind_filter(struct tcf_proto *tp, struct tc_u_knode *n,
+			    unsigned long base, struct nlattr **tb)
+{
+	if (tb[TCA_U32_CLASSID]) {
+		n->res.classid = nla_get_u32(tb[TCA_U32_CLASSID]);
+		tcf_bind_filter(tp, &n->res, base);
+	}
+}
+
 static int u32_set_parms(struct net *net, struct tcf_proto *tp,
-			 unsigned long base,
 			 struct tc_u_knode *n, struct nlattr **tb,
 			 struct nlattr *est, bool ovr,
 			 struct netlink_ext_ack *extack)
@@ -756,10 +771,6 @@ static int u32_set_parms(struct net *net, struct tcf_proto *tp,
 		if (ht_old)
 			ht_old->refcnt--;
 	}
-	if (tb[TCA_U32_CLASSID]) {
-		n->res.classid = nla_get_u32(tb[TCA_U32_CLASSID]);
-		tcf_bind_filter(tp, &n->res, base);
-	}
 
 	if (ifindex >= 0)
 		n->ifindex = ifindex;
@@ -898,16 +909,20 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		if (!new)
 			return -ENOMEM;
 
-		err = u32_set_parms(net, tp, base, new, tb,
-				    tca[TCA_RATE], ovr, extack);
+		err = u32_set_parms(net, tp, new, tb,tca[TCA_RATE],
+				    ovr, extack);
 
 		if (err) {
 			__u32_destroy_key(new);
 			return err;
 		}
 
+		u32_bind_filter(tp, new, base, tb);
+
 		err = u32_replace_hw_knode(tp, new, flags, extack);
 		if (err) {
+			u32_unbind_filter(tp, new, tb);
+
 			__u32_destroy_key(new);
 			return err;
 		}
@@ -1108,15 +1123,18 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 	}
 #endif
 
-	err = u32_set_parms(net, tp, base, n, tb, tca[TCA_RATE], ovr,
+	err = u32_set_parms(net, tp, n, tb, tca[TCA_RATE], ovr,
 			    extack);
+
+	u32_bind_filter(tp, n, base, tb);
+
 	if (err == 0) {
 		struct tc_u_knode __rcu **ins;
 		struct tc_u_knode *pins;
 
 		err = u32_replace_hw_knode(tp, n, flags, extack);
 		if (err)
-			goto errhw;
+			goto errunbind;
 
 		if (!tc_in_hw(n->flags))
 			n->flags |= TCA_CLS_FLAGS_NOT_IN_HW;
@@ -1134,7 +1152,9 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		return 0;
 	}
 
-errhw:
+errunbind:
+	u32_unbind_filter(tp, n, tb);
+
 #ifdef CONFIG_CLS_U32_MARK
 	free_percpu(n->pcpu_success);
 #endif

---
base-commit: 587461ddf5d522bfcb50ebd55078c0dac37be496
change-id: 20261005-cve-2023-53733-61f835619316

Best regards,
--  
Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>

