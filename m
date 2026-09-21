Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32B249E159
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 14:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790002653; cv=none; b=T3kSnpSw77Syz+6EhLzr2ZUhhDOvUa8pxL+sY/9X/9ZHuhMQgDNcdB6f8n2F/p1+NM7T6qh1veaK0Ur/Dey4O2Y7HDNYa2nU8cAkPbf14fg11LfOBD4a1Ahmru6GczYGNBYCB8Q447D9PlMDFB6Kh0rTpaQweLqr6ulPgJC6z24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790002653; c=relaxed/simple;
	bh=OK1hcbfhrRYnS7Fji50QexykkRH0sRg4CUWkyRdbGGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/XLBqa8EHvf5+Z8+aPe2eyo25zpToDpzf5wHPQmkk7z1mecxsvSn63NdshL6+jHiatM0I+GZgxmTPFipJE/JH13WZ7xhRzKp4MU+/YOm+cUAVUc3JY8WepCCTvv1QUaaQ1Qfx+sL26qUgPux6033CXilI7wPJYbtCCdfyrY/Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-49e8361492fso12427255e9.0
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 07:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790002643; x=1790607443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JPeqxpJkKYTQM9xCANZhikKMsVz4xTfivxM0gs/My1U=;
        b=ImFc6lBk8U/tZM+nZYo0yVm6wpn8Ypp/LKNfvOrthcwU6fAaYKcmGwN6XibNWZRZ7u
         AfLSF7vxbh0gL3JnftK19bjjljiGur1R1svCXv4AN6EuNnllKxPk5i6JENEUdho9zQD9
         Y4ITxcv7XdZGVY3ZEMfGGoKDOxEGgRE/elionCOSo80KfaWDHWh+u9AxA6lBeDnk3XSJ
         R795PpIIrM4+GYSFrpeTlxE4wbYdOZxGpTDoqohYpdWw+1SBV3rBLCF7qxfg/FZAljWS
         PHSSa2VV037uVlWnMdpv/QPpoL93ZOXXPc2wRPK2jrc7+oIdGPQprbZdRRwuFSveLi4/
         lGKg==
X-Forwarded-Encrypted: i=1; AKwUvBxT68+rNGkzikCPvXewV2T8vR+kpQklhdvzueVC9sub0SFmFjdX9z4Rt++fuscechLg38VhO8s=@vger.kernel.org
X-Gm-Message-State: AFuF++l4dJSTse4vSU5whlMLx2ohaRJ86L1TyHZ9PUX2ROtviA72ktZd
	jWAjVrd75/wW6oQTHnT5cgxRP16tNUUEtsJtnpY9Yz+qAxV2HWNezLrm
X-Gm-Gg: AYBFou336j03RzDYNZV3oWN3kk32d/oCBkiyZ/91V5I5ihNscyfZokMErJ2J7924RPn
	yVleRHctaa2MM/j2tCjt/e0hMwB9u8XDcPYufKqvQitO7pxX/vyIwazP0y3Fd2PyoJc9OHGTw5i
	lare2DFbDmSIOFrlBF/ZXzb00IMhOicOBds3Wje8TniPi7tWpVOqBwO3uKMAGrztR3QAYrkCzxB
	2Hn1+YFo/YHKVsDIPKCjEh7nieBPwD5E5VGA6QRJJIDXoIPdCpQ+ZWQbVMqkg9Ah6aHsSijYua2
	vG2MvxXA0ANF3s9K9ICjMPD2AcrEFDZGl2G+ilCTwkpxCjBfEjePBTwazmyeb8mlSSq0pA1DZMP
	vJ8NSieKoVv+s6lTrFJFXo46c1HQDKOlO811UuwCj3sydw2OIqFMGDcVX3QydtYkLI5nb7iCMPZ
	gfBby+UOX3HPx9+km+bEW+HyyIzxV2vbIC11ZDzw5tMagsIJ6E+BKPX9Q6clYvbPmYhKjieSqXT
	y+e31+m1wEeqfvLqfAJBuAVBmNbNKdndRUClF+BW+0hXiNa+HIw
X-Received: by 2002:a05:600c:138b:b0:49c:f89b:f82 with SMTP id 5b1f17b1804b1-49fc568f8dcmr139432395e9.12.1790002642660;
        Mon, 21 Sep 2026 07:57:22 -0700 (PDT)
Received: from im-t490s.redhat.corp (78-80-107-225.customers.tmcz.cz. [78.80.107.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd0eabfcsm243153905e9.3.2026.09.21.07.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 07:57:22 -0700 (PDT)
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
	stable@vger.kernel.org,
	Axel Mierczuk <axel.mierczuk@1password.com>
Subject: [PATCH net 4/6] net/sched: act_ct: avoid modifying shared unconfirmed ct entry
Date: Mon, 21 Sep 2026 16:55:46 +0200
Message-ID: <20260921145655.3167436-5-i.maximets@ovn.org>
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

In a case where skb with an unconfirmed ct entry gets cloned, we may
end up processing both again but with different sets of extensions.

The series of events:

 1. The first clone wants to commit and runs the helpers wiring up
    the extension pointer into the expectation list.
 2. Then it looses the confirmation keeping the entry unconfirmed.
 3. Second clone now wants to commit labels or run NAT and adds the
    new extension for that breaking the pointer in the expectation
    list causing UAF on the destruction path later.

While this is possible to trigger, there should be no practical
network pipeline where we need to process both clones without
modifications in the same zone.  So, let's just reset the entry in
case for some reason we got an skb with a shared one.  This doesn't
affect any known use cases, but avoids any potential problems with
sharing and modification of the unconfirmed ct entry.

Unlike openvswitch module, act_ct allows for NAT without commit.
Changing that would be a uAPI break.  So, act_ct needs to reset on NAT
regardless of the commit flag to avoid reallocation of the extension
space.  This, however, doesn't really change the picture for sensible
networking cases as there should be no need to run the same packet
twice (before and after the clone) through conntrack without packet
header or zone changes and without commit.

The fixes tag points to the introduction of helpers, since that's the
main UAF trigger for the sharing.

Fixes: a21b06e73191 ("net: sched: add helper support in act_ct")
Cc: stable@vger.kernel.org
Reported-by: Axel Mierczuk <axel.mierczuk@1password.com>
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/sched/act_ct.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 55f3521edb4c9..e72143d36b119 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -979,11 +979,11 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 				 struct tcf_result *res)
 {
 	struct net *net = dev_net(skb->dev);
+	bool cached, commit, clear, nat;
 	enum ip_conntrack_info ctinfo;
 	struct tcf_ct *c = to_ct(a);
 	struct nf_conn *tmpl = NULL;
 	struct nf_hook_state state;
-	bool cached, commit, clear;
 	int nh_ofs, err, retval;
 	struct tcf_ct_params *p;
 	bool add_helper = false;
@@ -998,6 +998,7 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 	retval = p->action;
 	commit = p->ct_action & TCA_CT_ACT_COMMIT;
 	clear = p->ct_action & TCA_CT_ACT_CLEAR;
+	nat = p->ct_action & TCA_CT_ACT_NAT;
 	tmpl = p->tmpl;
 
 	tcf_lastuse_update(&c->tcf_tm);
@@ -1046,6 +1047,19 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 	 * different zone.
 	 */
 	cached = tcf_ct_skb_nfct_cached(net, skb, p);
+
+	/* If the ct entry is not confirmed and shared with some other skb,
+	 * e.g., a cloned one, we can't just modify it with a commit or nat
+	 * as we must not modify the extension set.  Reset.
+	 */
+	if (cached && (commit || nat)) {
+		ct = nf_ct_get(skb, &ctinfo);
+		if (ct && !nf_ct_is_confirmed(ct) && nf_ct_shared(ct)) {
+			nf_reset_ct(skb);
+			cached = false;
+		}
+	}
+
 	if (!cached) {
 		if (tcf_ct_flow_table_lookup(p, skb, family)) {
 			skip_add = true;
@@ -1083,7 +1097,7 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 		if (err)
 			goto drop;
 		add_helper = true;
-		if (p->ct_action & TCA_CT_ACT_NAT && !nfct_seqadj(ct)) {
+		if (nat && !nfct_seqadj(ct)) {
 			if (!nfct_seqadj_ext_add(ct))
 				goto drop;
 		}
-- 
2.55.0

