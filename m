Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D871244D686
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 15:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625286; cv=none; b=fvoHTeyTjDgfYz8kG1uHYKiWn0HXk2aleVzCU84s9XKib7psyZIw69MVWC4iH34GfGhq0UVGKoeSAHmRtbmUD9F5MSnuCZzqd9XE/iglRu65/ynijNk2T3lPtaCIDXAlbfmmFjFZIK52eI7fcLKxBqnWdqWz5d/95JQXcshImzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625286; c=relaxed/simple;
	bh=+NHP2A8hyzBPxHhvrbuHNw4+RIK29O3rqT+1jqbtMR4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L0g6QJp+B2Tw3xyl4w0gHMUjJvjRQXx7OJoVabwMttRLfTqNsUvBYwF9l3ILMcA5XLPza6hdMPiO47TcSVN4coTYGVdNKthK/6FgKngm9+Wi9o2w5kAuThP4UIhdC1rwM83k6BMs5f3qshAVb9MIiJuQKhJK87ia/ZF15YLxOdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kpberry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lt0N1/XB; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kpberry.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lt0N1/XB"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c354050c34so43686735ad.3
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 08:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781625284; x=1782230084; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5EguuTmVPWnBcUwaQON+HkNjJ9ZSa/SQ/uo4GYdcbzc=;
        b=lt0N1/XBvbYRAzb7kSDrXb89UYNvr7MngkaPeEUnpF/eGnAoLEGkQC8AHyWatt5OVc
         WsUxM/JXphKP9V90ynGtR6df209ywYYxnxo1+qfcQ8qzURfUzXRky6ilYLj3447HrNGp
         xkBfraRJZtM+L7/0Mjk3MohD7+wBcG7zpUYSkX+jPAHXw4l6Xt4Okv1qpfP94EdnHvBe
         la50MR7Do+GdWMpKQQ1q1/jegldi/+rVsdlESQWfCBkiMsNg3Uik8sHQZ0V/9GsiHSxU
         8V9x6krR6tszutAl71Hnvt9w+FVtK1tfI8zvAGklVjFG7Z9aFP1PxRSp62KPsnR36yRJ
         bJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781625284; x=1782230084;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5EguuTmVPWnBcUwaQON+HkNjJ9ZSa/SQ/uo4GYdcbzc=;
        b=sJA1f1q7pAUog8/ACs41iTyJBlGQIiTwhEFWfUctNeP+dkrQkY1TLjK/KG6XzzIYTd
         qpxVL/BSsPq2vgBM/nGLbXVtkpDev7CQdY+Cba43OgR5g+1Ht5e0R1AGVDKc8M8c0xFS
         eBvqHSyQ6dhcK8UiBaVszY5fd3YERAAzgJaXcUZPZzbshkB9/3fv0VD8/SbcytWkGGgg
         emCRumaPfQN+cOznIy2VL4L3CyFFdFv77EW6CH0ulWWTN2k16CdqBB93pIjbIzJjuVD0
         rJ6SnN7tlthMq1P7a7YoQACXAHkTRKHGUEqphRaxFMCZwGMKML6YyJrdpyuQn3cNk5WQ
         nLiQ==
X-Gm-Message-State: AOJu0Ywf5Jbb2u7E+o4g6lWRZYZfJpEYsVqkalhHRkxD7kSPVDwwlDYT
	+u2zUCfLkEET/CZClL4GxF/BwWre9yXD+hZV/4aSVubWEtbDzZgYdUQNDHBs+b8qr4PB7Bpkg98
	7ltUvLCi1dfZxuH+Z16FxLWoK9aZ3nAZJ4c9FcmzLLwtZs2bC6JjzPH9u8+RsWFCOgjj2mWKGEV
	1ldF5Gkm1/w8rlIfH7O+ifMHRyncmYbYCYVvNnslD5Kw==
X-Received: from plec9.prod.google.com ([2002:a17:902:f309:b0:2c6:a409:859b])
 (user=kpberry job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b4e:b0:2c1:6020:7398
 with SMTP id d9443c01a7336-2c6641efbc2mr180781775ad.12.1781625283685; Tue, 16
 Jun 2026 08:54:43 -0700 (PDT)
Date: Tue, 16 Jun 2026 15:54:26 +0000
In-Reply-To: <20260616155432.2093908-1-kpberry@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616155432.2093908-1-kpberry@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616155432.2093908-4-kpberry@google.com>
Subject: [PATCH 6.12 3/7] bonding: add support for per-port LACP actor priority
From: Kevin Berry <kpberry@google.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, bestswngs@gmail.com, chenglongtang@google.com, 
	joneslee@google.com, kpberry@google.com, pabeni@redhat.com, rnj@google.com, 
	sashal@kernel.org, xmei5@asu.edu, Hangbin Liu <liuhangbin@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 6b6dc81ee7e8ca87c71a533e1d69cf96a4f1e986 ]

Introduce a new netlink attribute 'actor_port_prio' to allow setting
the LACP actor port priority on a per-slave basis. This extends the
existing bonding infrastructure to support more granular control over
LACP negotiations.

The priority value is embedded in LACPDU packets and will be used by
subsequent patches to influence aggregator selection policies.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Link: https://patch.msgid.link/20250902064501.360822-2-liuhangbin@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Kevin Berry <kpberry@google.com>
---
 Documentation/networking/bonding.rst |  9 +++++++
 drivers/net/bonding/bond_3ad.c       |  4 ++++
 drivers/net/bonding/bond_netlink.c   | 16 +++++++++++++
 drivers/net/bonding/bond_options.c   | 36 ++++++++++++++++++++++++++++
 include/net/bond_3ad.h               |  1 +
 include/net/bond_options.h           |  1 +
 include/uapi/linux/if_link.h         |  1 +
 7 files changed, 68 insertions(+)

diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
index 1a9439488c53..94ef39457a62 100644
--- a/Documentation/networking/bonding.rst
+++ b/Documentation/networking/bonding.rst
@@ -193,6 +193,15 @@ ad_actor_sys_prio
 	This parameter has effect only in 802.3ad mode and is available through
 	SysFs interface.
 
+actor_port_prio
+
+	In an AD system, this specifies the port priority. The allowed range
+	is 1 - 65535. If the value is not specified, it takes 255 as the
+	default value.
+
+	This parameter has effect only in 802.3ad mode and is available through
+	netlink interface.
+
 ad_actor_system
 
 	In an AD system, this specifies the mac-address for the actor in
diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 4c2560ae8866..a897836ad21a 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -436,6 +436,7 @@ static void __ad_actor_update_port(struct port *port)
 
 	port->actor_system = BOND_AD_INFO(bond).system.sys_mac_addr;
 	port->actor_system_priority = BOND_AD_INFO(bond).system.sys_priority;
+	port->actor_port_priority = SLAVE_AD_INFO(port->slave)->port_priority;
 }
 
 /* Conversions */
@@ -2195,6 +2196,9 @@ void bond_3ad_bind_slave(struct slave *slave)
 
 		ad_initialize_port(port, &bond->params);
 
+		/* Port priority is initialized. Update it to slave's ad info */
+		SLAVE_AD_INFO(slave)->port_priority = port->actor_port_priority;
+
 		port->slave = slave;
 		port->actor_port_number = SLAVE_AD_INFO(slave)->id;
 		/* key is determined according to the link speed, duplex and
diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index 2a6a424806aa..f8fc6e5fd803 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -28,6 +28,7 @@ static size_t bond_get_slave_size(const struct net_device *bond_dev,
 		nla_total_size(sizeof(u8)) +	/* IFLA_BOND_SLAVE_AD_ACTOR_OPER_PORT_STATE */
 		nla_total_size(sizeof(u16)) +	/* IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE */
 		nla_total_size(sizeof(s32)) +	/* IFLA_BOND_SLAVE_PRIO */
+		nla_total_size(sizeof(u16)) +	/* IFLA_BOND_SLAVE_ACTOR_PORT_PRIO */
 		0;
 }
 
@@ -77,6 +78,10 @@ static int bond_fill_slave_info(struct sk_buff *skb,
 					ad_port->partner_oper.port_state))
 				goto nla_put_failure;
 		}
+
+		if (nla_put_u16(skb, IFLA_BOND_SLAVE_ACTOR_PORT_PRIO,
+				SLAVE_AD_INFO(slave)->port_priority))
+			goto nla_put_failure;
 	}
 
 	return 0;
@@ -129,6 +134,7 @@ static const struct nla_policy bond_policy[IFLA_BOND_MAX + 1] = {
 static const struct nla_policy bond_slave_policy[IFLA_BOND_SLAVE_MAX + 1] = {
 	[IFLA_BOND_SLAVE_QUEUE_ID]	= { .type = NLA_U16 },
 	[IFLA_BOND_SLAVE_PRIO]		= { .type = NLA_S32 },
+	[IFLA_BOND_SLAVE_ACTOR_PORT_PRIO]	= { .type = NLA_U16 },
 };
 
 static int bond_validate(struct nlattr *tb[], struct nlattr *data[],
@@ -179,6 +185,16 @@ static int bond_slave_changelink(struct net_device *bond_dev,
 			return err;
 	}
 
+	if (data[IFLA_BOND_SLAVE_ACTOR_PORT_PRIO]) {
+		u16 ad_prio = nla_get_u16(data[IFLA_BOND_SLAVE_ACTOR_PORT_PRIO]);
+
+		bond_opt_slave_initval(&newval, &slave_dev, ad_prio);
+		err = __bond_opt_set(bond, BOND_OPT_ACTOR_PORT_PRIO, &newval,
+				     data[IFLA_BOND_SLAVE_ACTOR_PORT_PRIO], extack);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 9d868a36dddb..ddb3f06cbb75 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -79,6 +79,8 @@ static int bond_option_tlb_dynamic_lb_set(struct bonding *bond,
 				  const struct bond_opt_value *newval);
 static int bond_option_ad_actor_sys_prio_set(struct bonding *bond,
 					     const struct bond_opt_value *newval);
+static int bond_option_actor_port_prio_set(struct bonding *bond,
+					   const struct bond_opt_value *newval);
 static int bond_option_ad_actor_system_set(struct bonding *bond,
 					   const struct bond_opt_value *newval);
 static int bond_option_ad_user_port_key_set(struct bonding *bond,
@@ -223,6 +225,13 @@ static const struct bond_opt_value bond_ad_actor_sys_prio_tbl[] = {
 	{ NULL,      -1,    0},
 };
 
+static const struct bond_opt_value bond_actor_port_prio_tbl[] = {
+	{ "minval",  0,     BOND_VALFLAG_MIN},
+	{ "maxval",  65535, BOND_VALFLAG_MAX},
+	{ "default", 255,   BOND_VALFLAG_DEFAULT},
+	{ NULL,      -1,    0},
+};
+
 static const struct bond_opt_value bond_ad_user_port_key_tbl[] = {
 	{ "minval",  0,     BOND_VALFLAG_MIN | BOND_VALFLAG_DEFAULT},
 	{ "maxval",  1023,  BOND_VALFLAG_MAX},
@@ -484,6 +493,13 @@ static const struct bond_option bond_opts[BOND_OPT_LAST] = {
 		.values = bond_ad_actor_sys_prio_tbl,
 		.set = bond_option_ad_actor_sys_prio_set,
 	},
+	[BOND_OPT_ACTOR_PORT_PRIO] = {
+		.id = BOND_OPT_ACTOR_PORT_PRIO,
+		.name = "actor_port_prio",
+		.unsuppmodes = BOND_MODE_ALL_EX(BIT(BOND_MODE_8023AD)),
+		.values = bond_actor_port_prio_tbl,
+		.set = bond_option_actor_port_prio_set,
+	},
 	[BOND_OPT_AD_ACTOR_SYSTEM] = {
 		.id = BOND_OPT_AD_ACTOR_SYSTEM,
 		.name = "ad_actor_system",
@@ -1819,6 +1835,26 @@ static int bond_option_ad_actor_sys_prio_set(struct bonding *bond,
 	return 0;
 }
 
+static int bond_option_actor_port_prio_set(struct bonding *bond,
+					   const struct bond_opt_value *newval)
+{
+	struct slave *slave;
+
+	slave = bond_slave_get_rtnl(newval->slave_dev);
+	if (!slave) {
+		netdev_dbg(bond->dev, "%s called on NULL slave\n", __func__);
+		return -ENODEV;
+	}
+
+	netdev_dbg(newval->slave_dev, "Setting actor_port_prio to %llu\n",
+		   newval->value);
+
+	SLAVE_AD_INFO(slave)->port_priority = newval->value;
+	bond_3ad_update_ad_actor_settings(bond);
+
+	return 0;
+}
+
 static int bond_option_ad_actor_system_set(struct bonding *bond,
 					   const struct bond_opt_value *newval)
 {
diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
index dba369a2cf27..e9188646e22e 100644
--- a/include/net/bond_3ad.h
+++ b/include/net/bond_3ad.h
@@ -274,6 +274,7 @@ struct ad_slave_info {
 	struct port port;		/* 802.3ad port structure */
 	struct bond_3ad_stats stats;
 	u16 id;
+	u16 port_priority;
 };
 
 static inline const char *bond_3ad_churn_desc(churn_state_t state)
diff --git a/include/net/bond_options.h b/include/net/bond_options.h
index 022b122a9fb6..e6eedf23aea1 100644
--- a/include/net/bond_options.h
+++ b/include/net/bond_options.h
@@ -78,6 +78,7 @@ enum {
 	BOND_OPT_PRIO,
 	BOND_OPT_COUPLED_CONTROL,
 	BOND_OPT_BROADCAST_NEIGH,
+	BOND_OPT_ACTOR_PORT_PRIO,
 	BOND_OPT_LAST
 };
 
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 2acc7687e017..1609450e5eaa 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1551,6 +1551,7 @@ enum {
 	IFLA_BOND_SLAVE_AD_ACTOR_OPER_PORT_STATE,
 	IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE,
 	IFLA_BOND_SLAVE_PRIO,
+	IFLA_BOND_SLAVE_ACTOR_PORT_PRIO,
 	__IFLA_BOND_SLAVE_MAX,
 };
 
-- 
2.54.0.1136.gdb2ca164c4-goog

