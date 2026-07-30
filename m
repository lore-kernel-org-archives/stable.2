Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9CD46D08D
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 19:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785440338; cv=none; b=Mf95nQjW+rcQL9vt5ugJuFHN4kWuapNqfmWU9Z27+OTzR1LHC8QXvRUBBrPr4r8XDqHN9AtTEne9/fd/Tz8jJcnblkd/3njSx0kw2Uoz0p6dTibvUYiN94cERFfZJ6aaG0Vd1Ne70myFZM+afj8rnI2EYUyKa4oy3xxD52OBUxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785440338; c=relaxed/simple;
	bh=oFfrya4E4S4mlKgyu2KjO8bWDontvmVBySi261njvQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZWh/WkV+ZkyoJXAQcvSL264A4LpC1XW5N8ldiOYMPuzltEmyB2uIy1jCHChHUtfTUqGLDGMp8xuSWtonRL9KC7mxKr7oTy1Lt80tZRhDvxsJ988xCJyPyMyGk4mFOP4TvnhjsoBHMhNPcDCQJVOPA2Na09kWrkhFevvGLsqTZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-49557073245so400795e9.1
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 12:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785440330; x=1786045130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a3LIqDo3Oq4INDiJDlEzQ7Ja8ZVUe8Gi/iFKBRWmawo=;
        b=e6rFlSNZIHHRHb3DClYRwtfI/6VHK5tv9khWCt2tMp+bFmdjP8jIixrzpAMGbTX+B5
         BFyilD0eiQSazqLiotlNz5I+0on2wZ+8nYaJQ12fla7HMlSCp3j+jw9sfavdpGD0Iii0
         PTI1FTC0sT16ob2/bvdxv+L6NRnV1zfzg74Qu4EYlV4nTUhFe9+PWlrYfjJPA/PsdVJo
         AU41jQRoQ6JP4T6daGESPEIDGjd5ojJLUZOxWnfjBEtokCX69y6MJURUwomNRXrpZVM/
         GXWR1Z204l3gxJscLG0truc5hes2zFYt91TWNJEKYuUHVNy/dJDlXeOQhpZ+hRRBjnVc
         IHLg==
X-Gm-Message-State: AOJu0Yy+jQa7vklyKUeodH5sTl0KKPcrgZVBBUaj7pDjN2fMLetXQZdF
	JkQ26VFMNaMHmKnLwg0ymZs51EDdQxoxjnj8j/xCmEelXMKMSBrucSSEMOmGW3TxHBI=
X-Gm-Gg: AR+sD11bl9HX2pkZ6YUQRZXaFMBkdgfnjYVswS6OExefF/OXljmqiTxlF2sLGiZhUXE
	TehtmhFXb14TNxN+sbV9aDJgVcXJeEYURPMulZeD0P+7utC+rYQVzJDLy1OW3hXO28Lfwz9Qzym
	JGaqsBLDysjBKYyivPIePQg9w/3A3xJbO/rJNDxllu1jmzafhhoerZt0rA12/dcWhJ/RrvYPmVZ
	/4hCBM9MjAKf7EDCAaz0o2fhRCKyjrCLEQEVTY8LdDMBFLSddsW0nRk/HW74ST08ALf+y0ZCcwl
	XqZxU0dxM6MrGKzbExJ4+FUNEZCk77nj5i/lFBlvewirUHRUS2xZwG4c0R6DJpeF+a2C31z+Pkz
	z0A8mEV4lWFNGwqUjSgcKzukZBDKTVWN6kP9ig1PBeW2DsNT1vmGc54q62XA7UX/+I6UGpAuAGh
	dnh9W9I0+WcR6bUZJJLcy9YIHeSZO1zhEK/Z1k+3tMcDuNCLuSZ+UACzss52TUhPFOPvN77gx3u
	x+y1/JQN1iztmhP2XQAvc/XeK3HFw==
X-Received: by 2002:a05:600c:4747:b0:495:4811:d71c with SMTP id 5b1f17b1804b1-49800e7592fmr54968535e9.13.1785440329779;
        Thu, 30 Jul 2026 12:38:49 -0700 (PDT)
Received: from im-t490s.redhat.com (78-80-108-129.customers.tmcz.cz. [78.80.108.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498011e5edesm79157655e9.2.2026.07.30.12.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 12:38:49 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: stable@vger.kernel.org
Cc: Greg KH <greg@kroah.com>,
	netfilter-devel@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH 6.1.y] netfilter: nf_conntrack_expect: restore helper propagation via expectation
Date: Thu, 30 Jul 2026 21:38:18 +0200
Message-ID: <20260730193826.880405-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <ee95f6ac-181e-4315-a2ae-e4d1388c5e69@ovn.org>
References: <ee95f6ac-181e-4315-a2ae-e4d1388c5e69@ovn.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit dcb0f9aefdd604d36710fda53c25bd7cf4a3e37a ]

A recent series to fix expectations broke helper propagation via
expectation, this mechanism is used by the sip and h323 helper. This
also propagates the conntrack helper to expected connections. I changed
semantics of exp->helper which now tells us the actual helper that
created the expectation.

Add an explicit assign_helper field to expectations for this purpose
and update helpers to use it.

Restore this feature for userspace conntrack helper via ctnetlink
nfqueue integration so it is again possible to attach a helper to an
expectation, where it makes sense. This is not restored via ctnetlink
expectation creation as there is no client for such feature. Use the
expectation layer 4 protocol number for the helper lookup for
consistency.

Make sure the expectation using this helper propagation mechanism also
go away when the helper is unregistered.

Fixes: 9c42bc9db90a ("netfilter: nf_conntrack_expect: honor expectation helper field")
Fixes: 917b61fa2042 ("netfilter: ctnetlink: ignore explicit helper on new expectations")
Reported-by: Ilya Maximets <i.maximets@ovn.org>
Tested-by: Ilya Maximets <i.maximets@ovn.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
[ Minor conflict due to an extra pr_debug() in init_conntrack() ]
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 include/net/netfilter/nf_conntrack_expect.h |  5 ++++-
 net/netfilter/nf_conntrack_broadcast.c      |  1 +
 net/netfilter/nf_conntrack_core.c           |  7 +++++--
 net/netfilter/nf_conntrack_expect.c         |  1 +
 net/netfilter/nf_conntrack_h323_main.c      | 12 ++++++------
 net/netfilter/nf_conntrack_helper.c         |  5 +++++
 net/netfilter/nf_conntrack_netlink.c        | 18 ++++++++++++++++--
 net/netfilter/nf_conntrack_sip.c            |  2 +-
 8 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/include/net/netfilter/nf_conntrack_expect.h b/include/net/netfilter/nf_conntrack_expect.h
index e9a8350e7ccf..80f50fd0f7ad 100644
--- a/include/net/netfilter/nf_conntrack_expect.h
+++ b/include/net/netfilter/nf_conntrack_expect.h
@@ -45,9 +45,12 @@ struct nf_conntrack_expect {
 	void (*expectfn)(struct nf_conn *new,
 			 struct nf_conntrack_expect *this);
 
-	/* Helper to assign to new connection */
+	/* Helper that created this expectation */
 	struct nf_conntrack_helper __rcu *helper;
 
+	/* Helper to assign to new connection */
+	struct nf_conntrack_helper __rcu *assign_helper;
+
 	/* The conntrack of the master connection */
 	struct nf_conn *master;
 
diff --git a/net/netfilter/nf_conntrack_broadcast.c b/net/netfilter/nf_conntrack_broadcast.c
index d44d9379a8a0..ef8a7ca8c116 100644
--- a/net/netfilter/nf_conntrack_broadcast.c
+++ b/net/netfilter/nf_conntrack_broadcast.c
@@ -72,6 +72,7 @@ int nf_conntrack_broadcast_help(struct sk_buff *skb,
 	exp->flags                = NF_CT_EXPECT_PERMANENT;
 	exp->class		  = NF_CT_EXPECT_CLASS_DEFAULT;
 	rcu_assign_pointer(exp->helper, helper);
+	rcu_assign_pointer(exp->assign_helper, NULL);
 	write_pnet(&exp->net, net);
 #ifdef CONFIG_NF_CONNTRACK_ZONES
 	exp->zone = ct->zone;
diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index f5c466ea1e7d..342627b0d32b 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -1800,16 +1800,19 @@ init_conntrack(struct net *net, struct nf_conn *tmpl,
 		spin_lock_bh(&nf_conntrack_expect_lock);
 		exp = nf_ct_find_expectation(net, zone, tuple, !tmpl || nf_ct_is_confirmed(tmpl));
 		if (exp) {
+			struct nf_conntrack_helper *assign_helper;
+
 			pr_debug("expectation arrives ct=%p exp=%p\n",
 				 ct, exp);
 			/* Welcome, Mr. Bond.  We've been expecting you... */
 			__set_bit(IPS_EXPECTED_BIT, &ct->status);
 			/* exp->master safe, refcnt bumped in nf_ct_find_expectation */
 			ct->master = exp->master;
-			if (exp->helper) {
+			assign_helper = rcu_dereference(exp->assign_helper);
+			if (assign_helper) {
 				help = nf_ct_helper_ext_add(ct, GFP_ATOMIC);
 				if (help)
-					rcu_assign_pointer(help->helper, exp->helper);
+					rcu_assign_pointer(help->helper, assign_helper);
 			}
 
 #ifdef CONFIG_NF_CONNTRACK_MARK
diff --git a/net/netfilter/nf_conntrack_expect.c b/net/netfilter/nf_conntrack_expect.c
index 379711ea5ab6..34324dece89d 100644
--- a/net/netfilter/nf_conntrack_expect.c
+++ b/net/netfilter/nf_conntrack_expect.c
@@ -344,6 +344,7 @@ void nf_ct_expect_init(struct nf_conntrack_expect *exp, unsigned int class,
 		helper = rcu_dereference(help->helper);
 
 	rcu_assign_pointer(exp->helper, helper);
+	rcu_assign_pointer(exp->assign_helper, NULL);
 	write_pnet(&exp->net, net);
 #ifdef CONFIG_NF_CONNTRACK_ZONES
 	exp->zone = ct->zone;
diff --git a/net/netfilter/nf_conntrack_h323_main.c b/net/netfilter/nf_conntrack_h323_main.c
index 791aafe9f396..c42547284f35 100644
--- a/net/netfilter/nf_conntrack_h323_main.c
+++ b/net/netfilter/nf_conntrack_h323_main.c
@@ -642,7 +642,7 @@ static int expect_h245(struct sk_buff *skb, struct nf_conn *ct,
 			  &ct->tuplehash[!dir].tuple.src.u3,
 			  &ct->tuplehash[!dir].tuple.dst.u3,
 			  IPPROTO_TCP, NULL, &port);
-	rcu_assign_pointer(exp->helper, &nf_conntrack_helper_h245);
+	rcu_assign_pointer(exp->assign_helper, &nf_conntrack_helper_h245);
 
 	nathook = rcu_dereference(nfct_h323_nat_hook);
 	if (memcmp(&ct->tuplehash[dir].tuple.src.u3,
@@ -766,7 +766,7 @@ static int expect_callforwarding(struct sk_buff *skb,
 	nf_ct_expect_init(exp, NF_CT_EXPECT_CLASS_DEFAULT, nf_ct_l3num(ct),
 			  &ct->tuplehash[!dir].tuple.src.u3, &addr,
 			  IPPROTO_TCP, NULL, &port);
-	rcu_assign_pointer(exp->helper, nf_conntrack_helper_q931);
+	rcu_assign_pointer(exp->assign_helper, nf_conntrack_helper_q931);
 
 	nathook = rcu_dereference(nfct_h323_nat_hook);
 	if (memcmp(&ct->tuplehash[dir].tuple.src.u3,
@@ -1233,7 +1233,7 @@ static int expect_q931(struct sk_buff *skb, struct nf_conn *ct,
 				&ct->tuplehash[!dir].tuple.src.u3 : NULL,
 			  &ct->tuplehash[!dir].tuple.dst.u3,
 			  IPPROTO_TCP, NULL, &port);
-	rcu_assign_pointer(exp->helper, nf_conntrack_helper_q931);
+	rcu_assign_pointer(exp->assign_helper, nf_conntrack_helper_q931);
 	exp->flags = NF_CT_EXPECT_PERMANENT;	/* Accept multiple calls */
 
 	nathook = rcu_dereference(nfct_h323_nat_hook);
@@ -1305,7 +1305,7 @@ static int process_gcf(struct sk_buff *skb, struct nf_conn *ct,
 	nf_ct_expect_init(exp, NF_CT_EXPECT_CLASS_DEFAULT, nf_ct_l3num(ct),
 			  &ct->tuplehash[!dir].tuple.src.u3, &addr,
 			  IPPROTO_UDP, NULL, &port);
-	rcu_assign_pointer(exp->helper, nf_conntrack_helper_ras);
+	rcu_assign_pointer(exp->assign_helper, nf_conntrack_helper_ras);
 
 	if (nf_ct_expect_related(exp, 0) == 0) {
 		pr_debug("nf_ct_ras: expect RAS ");
@@ -1522,7 +1522,7 @@ static int process_acf(struct sk_buff *skb, struct nf_conn *ct,
 			  &ct->tuplehash[!dir].tuple.src.u3, &addr,
 			  IPPROTO_TCP, NULL, &port);
 	exp->flags = NF_CT_EXPECT_PERMANENT;
-	rcu_assign_pointer(exp->helper, nf_conntrack_helper_q931);
+	rcu_assign_pointer(exp->assign_helper, nf_conntrack_helper_q931);
 
 	if (nf_ct_expect_related(exp, 0) == 0) {
 		pr_debug("nf_ct_ras: expect Q.931 ");
@@ -1576,7 +1576,7 @@ static int process_lcf(struct sk_buff *skb, struct nf_conn *ct,
 			  &ct->tuplehash[!dir].tuple.src.u3, &addr,
 			  IPPROTO_TCP, NULL, &port);
 	exp->flags = NF_CT_EXPECT_PERMANENT;
-	rcu_assign_pointer(exp->helper, nf_conntrack_helper_q931);
+	rcu_assign_pointer(exp->assign_helper, nf_conntrack_helper_q931);
 
 	if (nf_ct_expect_related(exp, 0) == 0) {
 		pr_debug("nf_ct_ras: expect Q.931 ");
diff --git a/net/netfilter/nf_conntrack_helper.c b/net/netfilter/nf_conntrack_helper.c
index 8e72c3d4db4a..efa080cb1709 100644
--- a/net/netfilter/nf_conntrack_helper.c
+++ b/net/netfilter/nf_conntrack_helper.c
@@ -422,6 +422,11 @@ static bool expect_iter_me(struct nf_conntrack_expect *exp, void *data)
 
 	this = rcu_dereference_protected(exp->helper,
 					 lockdep_is_held(&nf_conntrack_expect_lock));
+	if (this == me)
+		return true;
+
+	this = rcu_dereference_protected(exp->assign_helper,
+					 lockdep_is_held(&nf_conntrack_expect_lock));
 	return this == me;
 }
 
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index a3b18042adec..55bc5626b967 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -2628,6 +2628,7 @@ static const struct nla_policy exp_nla_policy[CTA_EXPECT_MAX+1] = {
 
 static struct nf_conntrack_expect *
 ctnetlink_alloc_expect(const struct nlattr *const cda[], struct nf_conn *ct,
+		       const struct nf_conntrack_helper *assign_helper,
 		       struct nf_conntrack_tuple *tuple,
 		       struct nf_conntrack_tuple *mask);
 
@@ -2854,6 +2855,7 @@ static int
 ctnetlink_glue_attach_expect(const struct nlattr *attr, struct nf_conn *ct,
 			     u32 portid, u32 report)
 {
+	struct nf_conntrack_helper *assign_helper = NULL;
 	struct nlattr *cda[CTA_EXPECT_MAX+1];
 	struct nf_conntrack_tuple tuple, mask;
 	struct nf_conntrack_expect *exp;
@@ -2869,8 +2871,18 @@ ctnetlink_glue_attach_expect(const struct nlattr *attr, struct nf_conn *ct,
 	if (err < 0)
 		return err;
 
+	if (cda[CTA_EXPECT_HELP_NAME]) {
+		const char *helpname = nla_data(cda[CTA_EXPECT_HELP_NAME]);
+
+		assign_helper = __nf_conntrack_helper_find(helpname,
+							   nf_ct_l3num(ct),
+							   tuple.dst.protonum);
+		if (!assign_helper)
+			return -EOPNOTSUPP;
+	}
+
 	exp = ctnetlink_alloc_expect((const struct nlattr * const *)cda, ct,
-				     &tuple, &mask);
+				     assign_helper, &tuple, &mask);
 	if (IS_ERR(exp))
 		return PTR_ERR(exp);
 
@@ -3509,6 +3521,7 @@ ctnetlink_parse_expect_nat(const struct nlattr *attr,
 
 static struct nf_conntrack_expect *
 ctnetlink_alloc_expect(const struct nlattr * const cda[], struct nf_conn *ct,
+		       const struct nf_conntrack_helper *assign_helper,
 		       struct nf_conntrack_tuple *tuple,
 		       struct nf_conntrack_tuple *mask)
 {
@@ -3562,6 +3575,7 @@ ctnetlink_alloc_expect(const struct nlattr * const cda[], struct nf_conn *ct,
 	exp->zone = ct->zone;
 #endif
 	rcu_assign_pointer(exp->helper, helper);
+	rcu_assign_pointer(exp->assign_helper, assign_helper);
 	exp->tuple = *tuple;
 	exp->mask.src.u3 = mask->src.u3;
 	exp->mask.src.u.all = mask->src.u.all;
@@ -3617,7 +3631,7 @@ ctnetlink_create_expect(struct net *net,
 	ct = nf_ct_tuplehash_to_ctrack(h);
 
 	rcu_read_lock();
-	exp = ctnetlink_alloc_expect(cda, ct, &tuple, &mask);
+	exp = ctnetlink_alloc_expect(cda, ct, NULL, &tuple, &mask);
 	if (IS_ERR(exp)) {
 		err = PTR_ERR(exp);
 		goto err_rcu;
diff --git a/net/netfilter/nf_conntrack_sip.c b/net/netfilter/nf_conntrack_sip.c
index ec31611b7a29..0af6ede4b92c 100644
--- a/net/netfilter/nf_conntrack_sip.c
+++ b/net/netfilter/nf_conntrack_sip.c
@@ -1384,7 +1384,7 @@ static int process_register_request(struct sk_buff *skb, unsigned int protoff,
 	nf_ct_expect_init(exp, SIP_EXPECT_SIGNALLING, nf_ct_l3num(ct),
 			  saddr, &daddr, proto, NULL, &port);
 	exp->timeout.expires = sip_timeout * HZ;
-	rcu_assign_pointer(exp->helper, helper);
+	rcu_assign_pointer(exp->assign_helper, helper);
 	exp->flags = NF_CT_EXPECT_PERMANENT | NF_CT_EXPECT_INACTIVE;
 
 	hooks = rcu_dereference(nf_nat_sip_hooks);
-- 
2.55.0

