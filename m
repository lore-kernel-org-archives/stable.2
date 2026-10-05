Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4298E478E39
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 10:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791197304; cv=none; b=Ggza3DKX/z2hnGqIn7qj08l3fl/q0eWvy3FUcvluY9J5HIvwaI8T0tbkIPs5RnrW2iaPbHf6qio5qrw9DKhUOjnNEPLSKBWMGb/SL8NbOpvUoAquWRWFS99ydW8Zwn7LSd0FQ7q02AzxZQ14EA3wq9oPjGl3l0TRiJcsBwxMPlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791197304; c=relaxed/simple;
	bh=SoIpKiCi8AjRfRbdlbcOF35l7PXRzMjd9I+cr0oMA24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=njfQUI4HCOa1hB5MUkuJaOBD0rk7qV57X9oZeAwCsxX3EmZAdyVYxGEKa/7AyOcKWyAznyNjeeLsOa9z4PKfDHx8/yao7vbGa9PpKDNRVGDdqjFgRHhx+KX+jqmTH1bJ//0x7KOAEW5IpmElZoNOUXLCjIKSIVIWHii6zym7Hwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dW6Bvjjm; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dW6Bvjjm"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 856D71A112B;
	Mon,  5 Oct 2026 10:48:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 55C25604FE;
	Mon,  5 Oct 2026 10:48:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7D58710330764;
	Mon,  5 Oct 2026 12:48:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791197297; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=oobK+U8ONIFu0Yqr2NZfLK8gYWnLurpU4xBiBDjHtkA=;
	b=dW6BvjjmKgGnTYyWKVsevZZNV3WFLqooayo+kwnW7XrMaHwQieZFlJxrjmqYaN5wJtokfe
	gxI4C+ylelKQhT03lgrda/a3jtGyYyX5G9ZpoYvzI98zGTtc9+cmmU6NAz2UVrOyB8XsdN
	2A4+8cOAZc2twQ/V4veukTFJ2a/BKUHjdRKkkWmFyYoe/TavRwnyw7d0wUm+Z+NpeQ4ic/
	lvESWtan/TBa3p3U1wYqK4IQDUE049YYMOu4H9Ro/StAaZ7ZzT6nfpfJoqXoYo8z4+0iWZ
	PvAvI0vpRjzDprHRmDOt/A3jMn7AkBunFvt12V5xs8oIIIdSeV6Zhz8s6KRTEQ==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Mon, 05 Oct 2026 12:48:00 +0200
Subject: [PATCH 5.15.y] net: sched: cls_u32: Undo tcf_bind_filter if
 u32_replace_hw_knode
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-cve-2023-53733-5-15-v1-1-caeaaf7de3f5@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMSwrCQBAFrxLe2g7zsaPJVcSFM7baLqLMaFBC7
 m6rmwf1oGpGlaJSMTQzikxa9TYa+FWDfDmMZyE9GiO40HnnmPIkZBCJ4ybakmdyfb9OnWxDjgl
 m3ouc9PWr7sCt5/aN/f+vz3SV/PgmsSwfSUJNkX8AAAA=
X-Change-ID: 20261005-cve-2023-53733-5-15-0994b6e82c3b
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791197287; l=3623;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=4QDJlcyfXKSWgy6axAo7H09lYM292QlvkWfT6PxkboY=;
 b=P/eU043cJf/0FAk9q4MsRwTKv4wTvVAazKmIlrSttbsI1LtibQ/sLg04tPPllyoEYs7qbydPC
 NeNPZapIbxgDBHHLnv1/Aifwp+TXj17uw5yDLWWCrkPVyiVcaQB+eQ0
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
 net/sched/cls_u32.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index 23f9e2b5f3b6..b36eced10ff4 100644
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
 			 struct nlattr *est, u32 flags,
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
@@ -898,7 +909,7 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		if (!new)
 			return -ENOMEM;
 
-		err = u32_set_parms(net, tp, base, new, tb,
+		err = u32_set_parms(net, tp, new, tb,
 				    tca[TCA_RATE], flags, extack);
 
 		if (err) {
@@ -906,8 +917,12 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
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
 
-	err = u32_set_parms(net, tp, base, n, tb, tca[TCA_RATE], flags,
+	err = u32_set_parms(net, tp, n, tb, tca[TCA_RATE], flags,
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
base-commit: a051a4bf909f76f470ccb3761ee0cf6e2395616e
change-id: 20261005-cve-2023-53733-5-15-0994b6e82c3b

Best regards,
--  
Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>

