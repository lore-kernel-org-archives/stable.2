Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F234156D0
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923736; cv=none; b=Xi1c9Fy6AhaKN0lmMMPuLZ/UZVkjXvvIQobirT7AlYDhkK2Wi9CSuwvPnC3rm6G11bLvAbA9PObDTz3TjGgZktSMzvks/2KM4pOQbQeiWE8BjyR9t3KdEE+6nzfiJSCVjp+DeXkATVmNZZ8iyJQ2uPP/gtGAyeR4VKMrEU8L3yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923736; c=relaxed/simple;
	bh=laFDajcbsTqcT6ZcbK37Ex1BDVWiUC0e7NghyynrKYo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i8sfaMj8LuRK+Z3yxTb4XxUrYVcY9EwfU9SvclbwdktrtDBBPrL3dcbsq3UPomGg3MK53gPY8+/s5fEN6qrWsDULpCzQd0xsUvBKBm6A+MQNPbl6kbVAT8cCF+nAmMZq45S9DpKSVs4unvlA8C3dZaVsTaNIlENPV+xHzcB5inE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBHKZE7W; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBHKZE7W"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84e3007a2b7so733471b3a.0
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 02:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785923735; x=1786528535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fkkkeE2AhcVlDMOIzDVMCAo0rWWKAmZ5F7iC5BAAoSk=;
        b=IBHKZE7WpBtkAdHl20jF9LUUG+uPFNT6tnMI/BEZaQPLEJtMs7JZJmC0RSLj6ytoAL
         lcqYOJJBl9xgDWQqMNNtLcGRlasHcqUHV3ckefSah50bETPe1HA5DLDUErjteVO1xJ0E
         z5CX23kpK09j+qf/qbfH/fmxRkE6XApdm/YyGE4MmJnYtNMUYsRiLJmLmguB33BICugA
         LHiFoLYGMaTtlWaPxQcS9DF96rZ87L+0xnc6itIJD94y9tb3ZcUdGhwFAyQ52P1eY/5m
         6g9fo7S5q1wk42772Z/W10vrbqcXlhc3qvfxR5eViIUCzI9zZHEzl3+9TNHGSWMWUyTN
         kC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785923735; x=1786528535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fkkkeE2AhcVlDMOIzDVMCAo0rWWKAmZ5F7iC5BAAoSk=;
        b=P9BCA1fwooW9rXv/B6/QBBWe0qGOnDwZZQlGtcPx9D3mv5peysBWwlensEsQy4ff5c
         kDXiHZQ4NWnvIXhGl9laYeL+WCSqMl2OWwOqD8PkUZofGstgxO4vZ5RcWUGfWjElpEGH
         vMIsba11/ZyGHLdgGFdYWmpUzV0fORNfhMSYSxB5DyDGrnwsckUYjZ5xB86uE43oglAu
         ujxADSt3cM2eZBtLUCFhGo1VZtUzHcSeXNCb3P4wuwGShztjmvPnFLUXSHh2cpM2iavi
         ZzuDhARQcm6IxqYPnZ666hkEPgtyt6hMHs/3wuSCyOpbfR4f7/WdLgBvSijfC8e9HPK6
         2aIg==
X-Forwarded-Encrypted: i=1; AHgh+Rr4OsLmCf5Fz8eu3Iob553R0k3oioq4I+S6JKF1mZUt2F76p7c9Ik3Ga8MeLkacO1ofmEP1kpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz303sL5jvN1tPhM4FN2qOkdADiUgd2NcuF2akfmfbdy2pwGJcX
	pylYWPBqGVei5DT0P8Pnv2NbhigqWsLj4x5MjgMiqoA+iWQ/1yKqb6Mz
X-Gm-Gg: AR+sD13GOOu9NTS8M4zCvOzjDIIpLw8rLrnJk8Q9KtX309y1wDh0UWyqbIFvgoo7lOf
	SlG3YFJGWQ/2CO+WbCGWTVH+ZyfKsGA7a+RFyVQLAAPou8Zk3xR3Sb+kInPo43O68cl7ReXmwFg
	7nrSAh7PM/RvrG7aDTkulODDp0V0EELm6P1kbdoKzI8+bAC9pTlI8+vPVdvim8opuOYFonLLkpi
	b9bSqn60qqW/QExgDthHpMnHytOt/vElgS0vFB18iyh7qo9dbIQopyh/DzUtSScJ5KB3yib/hI9
	reI7Pk7ZmwEjT70NShK6uypVX76mX0nFAYCnjCpCST9a3NkkTKFeXYW6gHl4gVIWBUk4GkKiwrn
	FU+6RPGj+P9NLXyFeBHvHAvx9ss62oD8rwYNTYrqG6QO2UsBq081et98LudNZ7XzxJxAnzFyUkt
	Ztihb/w+NcsuEnKuZxj2NPhCMoMnVG8xPW2uUmefgzg9XccdXxvbdZJGMDedBvUjpEZ0X9YK8F+
	dcUGiGDynf6e7yEonoFkko5CWWPfi7HCF9vePM=
X-Received: by 2002:a05:6a00:b93:b0:842:5da3:9b89 with SMTP id d2e1a72fcca58-84f2e13a50cmr5858638b3a.38.1785923734663;
        Wed, 05 Aug 2026 02:55:34 -0700 (PDT)
Received: from BOOK-P74QMIQ7E8.localdomain ([163.239.22.31])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe708be545sm1189839a12.16.2026.08.05.02.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 02:55:34 -0700 (PDT)
From: hyunjungg <hj351016@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	John Hurley <john.hurley@netronome.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net/sched: act_gact, act_police: range check the fallback control action
Date: Wed,  5 Aug 2026 18:55:27 +0900
Message-Id: <20260805095527.204088-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hyunjung Ko <hj351016@gmail.com>

tcf_action_check_ctrlact() range checks the primary control action:

	if (!opcode)
		ret = action > TC_ACT_VALUE_MAX ? -EINVAL : 0;

TC_ACT_VALUE_MAX is TC_ACT_TRAP, so kernel-internal verdicts above it
cannot be set that way. But act_gact and act_police each carry a second,
independent control action supplied by user space that never reaches that
helper - TCA_GACT_PROB.paction and TCA_POLICE_RESULT. Both only reject
TC_ACT_GOTO_CHAIN, so any other value is stored verbatim and returned
verbatim from the action.

In particular user space can store TC_ACT_CONSUMED, which is
TC_ACT_VALUE_MAX + 1 and is deliberately not part of the UAPI value
range. That verdict tells every caller the action took ownership of the
skb, so nobody frees it: sch_handle_ingress(), sch_handle_egress() and
tcf_qevent_handle() all deliberately skip the free for it. The result is
one leaked sk_buff plus its data buffer per packet traversing the filter,
unbounded, for all traffic on the chain including kernel-generated
packets.

Both are trivially deterministic. act_gact clamps tcfg_pval to >= 1, so
with pval = 1 gact_determ() returns the fallback for every packet.
act_police has no mandatory rate, so rate = 0 leaves tcfp_mtu = ~0 and
tcf_police_mtu_check() always passes.

TC_ACT_CONSUMED was added by commit 720f22fed81b, after both goto-chain
guards were written (9469f375ab09 and c08f5ed5d625, Oct 2018); neither
guard was widened when the new verdict appeared.

Factor the existing range test out of tcf_action_check_ctrlact() as
tcf_action_valid() and apply it to both fallbacks. The helper cannot call
tcf_action_check_ctrlact() directly because that also allocates a
goto_chain, which is exactly what these two sites must not do.

Reproduced on v7.2-rc6: kmemleak reports one leaked 232-byte
skbuff_head_cache object plus its 704-byte data buffer per packet. With
this patch both configurations are rejected with -EINVAL and kmemleak
reports none.

Fixes: 720f22fed81b ("net: sched: refactor reinsert action")
Cc: stable@vger.kernel.org # v5.3+
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 include/net/act_api.h  | 19 +++++++++++++++++++
 net/sched/act_gact.c   |  5 +++++
 net/sched/act_police.c |  6 ++++++
 3 files changed, 30 insertions(+)

Reproducer needs CONFIG_NET_ACT_GACT + CONFIG_GACT_PROB and
CONFIG_NET_ACT_POLICE, plus CONFIG_DEBUG_KMEMLEAK and kmemleak=on to
observe it.

The bad value cannot be set with tc(8) - iproute2 only parses symbolic
action names - so the fallback has to be planted over raw netlink:
TCA_GACT_PROB.paction = 9 with ptype = PGACT_DETERM and pval = 1, or
TCA_POLICE_RESULT = 9 with rate = 0. Attach either to a clsact ingress
chain and every packet leaks its skb.

Before, one sk_buff plus its data buffer per packet:

  kmemleak: 166 new suspected memory leaks
  unreferenced object 0xffff888103baadc0 (size 232):
    kmem_cache_alloc_node_noprof+0x2f1/0x3e0
    __alloc_skb+0xe5/0x860
    alloc_skb_with_frags+0x82/0x750
    sock_alloc_send_pskb+0x658/0x7e0
    packet_sendmsg+0x1833/0x4860
    __x64_sys_sendto+0xe0/0x1c0
    do_syscall_64+0x102/0x5a0

After: both configurations are rejected at netlink time with -EINVAL
and "invalid fallback control action", and kmemleak reports no
unreferenced objects.

For the same reason tdc cannot express the bad configuration, so no
selftest accompanies this patch. A self-contained C reproducer is
available on request.

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 20d9e55f8564..fd03f6319e88 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -270,6 +270,25 @@ int tcf_action_check_ctrlact(int action, struct tcf_proto *tp,
 struct tcf_chain *tcf_action_set_ctrlact(struct tc_action *a, int action,
 					 struct tcf_chain *newchain);
 
+/* Range check for a control action supplied by user space.
+ *
+ * This is the same test tcf_action_check_ctrlact() applies to the primary
+ * control action, factored out for the *fallback* control actions
+ * (act_gact's TCA_GACT_PROB.paction and act_police's TCA_POLICE_RESULT),
+ * which must not reach tcf_action_check_ctrlact() because they have no
+ * goto_chain to allocate.  Without it, user space can store kernel-internal
+ * verdicts such as TC_ACT_CONSUMED, which is TC_ACT_VALUE_MAX + 1 and is
+ * deliberately not part of the UAPI value range.
+ */
+static inline bool tcf_action_valid(int action)
+{
+	int opcode = TC_ACT_EXT_OPCODE(action);
+
+	if (!opcode)
+		return action <= TC_ACT_VALUE_MAX;
+	return opcode <= TC_ACT_EXT_OPCODE_MAX || action == TC_ACT_UNSPEC;
+}
+
 #ifdef CONFIG_INET
 DECLARE_STATIC_KEY_FALSE(tcf_frag_xmit_count);
 #endif
diff --git a/net/sched/act_gact.c b/net/sched/act_gact.c
index e949280eb800..565860cccba6 100644
--- a/net/sched/act_gact.c
+++ b/net/sched/act_gact.c
@@ -89,6 +89,11 @@ static int tcf_gact_init(struct net *net, struct nlattr *nla,
 		p_parm = nla_data(tb[TCA_GACT_PROB]);
 		if (p_parm->ptype >= MAX_RAND)
 			return -EINVAL;
+		if (!tcf_action_valid(p_parm->paction)) {
+			NL_SET_ERR_MSG(extack,
+				       "invalid fallback control action");
+			return -EINVAL;
+		}
 		if (TC_ACT_EXT_CMP(p_parm->paction, TC_ACT_GOTO_CHAIN)) {
 			NL_SET_ERR_MSG(extack,
 				       "goto chain not allowed on fallback");
diff --git a/net/sched/act_police.c b/net/sched/act_police.c
index b16468a98c55..ce08f6840ef7 100644
--- a/net/sched/act_police.c
+++ b/net/sched/act_police.c
@@ -128,6 +128,12 @@ static int tcf_police_init(struct net *net, struct nlattr *nla,
 
 	if (tb[TCA_POLICE_RESULT]) {
 		tcfp_result = nla_get_u32(tb[TCA_POLICE_RESULT]);
+		if (!tcf_action_valid(tcfp_result)) {
+			NL_SET_ERR_MSG(extack,
+				       "invalid fallback control action");
+			err = -EINVAL;
+			goto failure;
+		}
 		if (TC_ACT_EXT_CMP(tcfp_result, TC_ACT_GOTO_CHAIN)) {
 			NL_SET_ERR_MSG(extack,
 				       "goto chain not allowed on fallback");
--
2.43.0
