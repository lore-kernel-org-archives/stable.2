Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAC04A5EAF
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790002644; cv=none; b=ao95FF4Cvx3fu7VF9iDP6SMbmaiE/+8v2izwTtxyQUcj49KhswyQoY7DgpA9cNzBRUxOaGzmzjkgtcOkelj3n4u03TROV5dlVFdZ6Eh4A+h1KID9+xvO93rTitWdgSf8UlHznxnGlLE2EsK+eHOCXeREuasmSUUN2V3c+lsw7Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790002644; c=relaxed/simple;
	bh=h/e4AULhjSmntZab1cGdfq7OkJUisqf0YdE9X03GDLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SgW21XfjaXZlIePlDs2Xy6bbiG0n2e6Kb7kJQxXiFNU8UifvM0ywOqSbG/UTGj5Cz75y5tMrbYNPCLAW28W4J+iXNYCaJX5OuWrawWoh+lfEjd+xoSspbF5OTdfJ2IPGdIvEgceyQrr6E6zceFGIZyHesktQaGqnOSQG1DFX+Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49e6bd65693so20716455e9.0
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 07:57:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790002637; x=1790607437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VXSW6q1NZ2VUKtjXQJBrCrLariG7HqyHLR8Ed7NC5Gs=;
        b=OFJdZtHiQibfvxNhGxkhV/XQcVpcgRtmiF0wjAQnqaKjIDTVQJ9lnEEYkwp1QH92rr
         OEOW65agR68vD4JYLspXb6o25TFppLkMkXVpAsJyUF+P52VBgEK1MwcELg1rQepNBlG+
         yQvnCPW+KycfF6z0NmQQKQCmWAniISbjSAbe8KMIdF1cXFYH6rvaITLyW/NHJf5FoERh
         h18bMtOMWeaGctEFvVRSq9mqMiy0dSyE+xxkSoYRHcXcF/tviW8dWk26icBlDz6rno63
         lQe0ExQpi3JEXXXchU5D2NHGBfLvdyx3FNyWoAcyaOlZL4JZzHFUzdBsKKTg59jhH0AU
         upMg==
X-Forwarded-Encrypted: i=1; AKwUvBw0233EczJIbmD51cwyR2X37Qx1rOUK5x4HWNCylq1HJOZz1eAWNqNoISSnKIZ1btFEiJRqXko=@vger.kernel.org
X-Gm-Message-State: AFuF++lBzyQ8VyU9XvDLTK129HfkSk817BNh2jnTnG0w2Pl51CJCv4UB
	lyUov+sk7cJiE3wBB9SnJDHq1myPOG1yFBRKwd+UF51ZpFdCMamr9d/I
X-Gm-Gg: AYBFou27P6muXX7b9n383uI/SkXiTqdc4+/imUhkAGlAtHJ9XmQR/VLyVuP5gX9k3gw
	dJMkHvEr8JtPyhcPerCb6+215uAo8X155F8vK0jTEDJjpI27OlMGoxZY66tVyY1K8QHpeC8nI1i
	SrOAhFvJKWthxjLXoGyClbKYabq11gZFWiOHs4d0LhkFhqdSTyM/2NyQkX+D/JYrVzmEGYbf6F4
	fURmmSxCvq7zbJ5CzxdbByBbPQzPvtH1JmzlwusXiobxYLzvNPjASm6dM6/xCmzn29uuvPcHNpz
	yiF7nbYYgLoIgmRz/cmpEL96PicvZZwcDlVzEvUGuB8hseFYlEc0pWQv33DOI85KNIhe/+SIU4O
	vHvmgBna0+h2r/bOrKtBQUg0fwftY9yj6sYehqaB24TFxliKVYR8Q8qiHnSMhiyVLLy5XD9OowX
	IF46BMmn18LnP5V5OlaGPzCb7l0M7Ftxg2bARf6O7GTeK2JaOXFpv00g6+y0W1NBlchL6vT+/ur
	R4moFQRRZQalP6CnTA/jsFtEo8th/qKaLkB/SB3137/pes4/dbf
X-Received: by 2002:a05:600d:4453:10b0:49f:cbf1:e77b with SMTP id 5b1f17b1804b1-49fcbf1e9eamr90041305e9.10.1790002636893;
        Mon, 21 Sep 2026 07:57:16 -0700 (PDT)
Received: from im-t490s.redhat.corp (78-80-107-225.customers.tmcz.cz. [78.80.107.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd0eabfcsm243153905e9.3.2026.09.21.07.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 07:57:16 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Xin Long <lucien.xin@gmail.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kernel@vger.kernel.org,
	dev@openvswitch.org,
	Ilya Maximets <i.maximets@ovn.org>,
	stable@vger.kernel.org
Subject: [PATCH net 2/6] net: openvswitch: conntrack: remove 'add_helper' dead code
Date: Mon, 21 Sep 2026 16:55:44 +0200
Message-ID: <20260921145655.3167436-3-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921145655.3167436-1-i.maximets@ovn.org>
References: <20260921145655.3167436-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This variable can only become 'true' when the connection is not
confirmed, but it is only checked when it is confirmed.  So, it can be
treated as being always false and just removed.

Fixes: 3c1860543fcc ("openvswitch: add nf_ct_is_confirmed check before assigning the helper")
Cc: stable@vger.kernel.org
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/openvswitch/conntrack.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index a733029c28dd0..c20f096eef40e 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -778,8 +778,6 @@ static int __ovs_ct_lookup(struct net *net, struct sw_flow_key *key,
 
 	ct = nf_ct_get(skb, &ctinfo);
 	if (ct) {
-		bool add_helper = false;
-
 		/* Packets starting a new connection must be NATted before the
 		 * helper, so that the helper knows about the NAT.  We enforce
 		 * this by delaying both NAT and helper calls for unconfirmed
@@ -811,7 +809,6 @@ static int __ovs_ct_lookup(struct net *net, struct sw_flow_key *key,
 							    GFP_ATOMIC);
 			if (err)
 				return err;
-			add_helper = true;
 
 			/* helper installed, add seqadj if NAT is required */
 			if (info->nat && !nfct_seqadj(ct)) {
@@ -821,13 +818,10 @@ static int __ovs_ct_lookup(struct net *net, struct sw_flow_key *key,
 		}
 
 		/* Call the helper only if:
-		 * - nf_conntrack_in() was executed above ("!cached") or a
-		 *   helper was just attached ("add_helper") for a confirmed
-		 *   connection, or
+		 * - nf_conntrack_in() was executed above ("!cached"), or
 		 * - When committing an unconfirmed connection.
 		 */
-		if ((nf_ct_is_confirmed(ct) ? !cached || add_helper :
-					      info->commit)) {
+		if ((nf_ct_is_confirmed(ct) ? !cached : info->commit)) {
 			int err = nf_ct_helper(skb, ct, ctinfo, info->family);
 
 			err = verdict_to_errno(err);
-- 
2.55.0

