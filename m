Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DF250C280
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904558; cv=none; b=PPL6Hemj/WMNS4J4XEK6A8TUuMW2K6cYdAYDM9RIsNJj2DF+7kfC8TI5e+IR+CdTXc/giWhk7+d/i84VCNZl1GqodHU2YZOtTgkJAilJBtMlXPGCokDg8d+LaTNV1xgrUSrx1tHvehWypY6oYcnaLxj0yg495KVnyVTNeKMA5Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904558; c=relaxed/simple;
	bh=tIjS8tSSnWQFotaPmbtiP/26PbUEJZXrdx35RB35IcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HR8wz9r3lk9nAuDw23ch/UkN2J+bkUM7UZhFBfLvJrTObu6jzCMe32SYsWB0DTr2synqVSg3hZLJYfwaxxcMSA5K8h4xiCia8dWW0gRADGPfbPVWu3vew5Xjr10upzK/vPYNljqrEvdo173foa+j+4RVacabDlepsQBX6ZSu5+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1q63H0u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1q63H0u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FCE91F000FF;
	Tue, 13 Oct 2026 15:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791904557;
	bh=Z+MG3ortekisAXSQp5GcQjvORQHLMHkrdgJp7FzHg1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J1q63H0udruc4KKf8VycAnbyX+6DWGyxRzsEvRm/c+bsV/p7TH2tEdIDFmCWxrMWo
	 CZ990KkcvtAZLWcpaEB3MjK2hMP6Eq8T95HNg+x0Md7jVpTt897HuQDZjWNQVO93a7
	 1wzRH14qxmbq+u+1ft5hlk4KaYOlEKGg/qWy4MFYAq88LvmQRIpCSlvCDtzfe2nSrK
	 xd2XjoKZA+9ZCNnLMzVXMUbJEhDhlqQGX71pNNUMHZSdF4mPR3TAarY85VAAxnxJZa
	 wMYHXUMitc8F/Bhmz8AC66uOp6zG8Nin4988vKFNzdIWzkIPnuT+YFM68TbIv01OTI
	 kDl/PXnq37c6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marc Harvey <marcharvey@google.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] net: team: Rename port_disabled team mode op to port_tx_disabled
Date: Tue, 13 Oct 2026 11:15:52 -0400
Message-ID: <20261013151545.72467-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013151545.72467-1-sashal@kernel.org>
References: <2026101202-slimy-extrude-989f@gregkh>
 <20261013151545.72467-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marc Harvey <marcharvey@google.com>

[ Upstream commit cfa477df2cc62ba53cb936669886361152b594a7 ]

This team mode op is only used by the load balance mode, and it only
uses it in the tx path.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Marc Harvey <marcharvey@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20260409-teaming-driver-internal-v7-3-f47e7589685d@google.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: b7454f1940c5 ("net: team: stop reusing skb after queue override")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/team/team_core.c             | 4 ++--
 drivers/net/team/team_mode_loadbalance.c | 4 ++--
 include/linux/if_team.h                  | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 7d14acaadd616..ac0df5754254b 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -968,8 +968,8 @@ static void team_port_disable(struct team *team,
 {
 	if (!team_port_enabled(port))
 		return;
-	if (team->ops.port_disabled)
-		team->ops.port_disabled(team, port);
+	if (team->ops.port_tx_disabled)
+		team->ops.port_tx_disabled(team, port);
 	hlist_del_rcu(&port->hlist);
 	__reconstruct_port_hlist(team, port->index);
 	port->index = -1;
diff --git a/drivers/net/team/team_mode_loadbalance.c b/drivers/net/team/team_mode_loadbalance.c
index 00f8989c29c0f..3ca419884185b 100644
--- a/drivers/net/team/team_mode_loadbalance.c
+++ b/drivers/net/team/team_mode_loadbalance.c
@@ -658,7 +658,7 @@ static void lb_port_leave(struct team *team, struct team_port *port)
 	free_percpu(lb_port_priv->pcpu_stats);
 }
 
-static void lb_port_disabled(struct team *team, struct team_port *port)
+static void lb_port_tx_disabled(struct team *team, struct team_port *port)
 {
 	lb_tx_hash_to_port_mapping_null_port(team, port);
 }
@@ -668,7 +668,7 @@ static const struct team_mode_ops lb_mode_ops = {
 	.exit			= lb_exit,
 	.port_enter		= lb_port_enter,
 	.port_leave		= lb_port_leave,
-	.port_disabled		= lb_port_disabled,
+	.port_tx_disabled	= lb_port_tx_disabled,
 	.receive		= lb_receive,
 	.transmit		= lb_transmit,
 };
diff --git a/include/linux/if_team.h b/include/linux/if_team.h
index 31a4f13ab2986..06fec0a78db5a 100644
--- a/include/linux/if_team.h
+++ b/include/linux/if_team.h
@@ -121,7 +121,7 @@ struct team_mode_ops {
 	int (*port_enter)(struct team *team, struct team_port *port);
 	void (*port_leave)(struct team *team, struct team_port *port);
 	void (*port_change_dev_addr)(struct team *team, struct team_port *port);
-	void (*port_disabled)(struct team *team, struct team_port *port);
+	void (*port_tx_disabled)(struct team *team, struct team_port *port);
 };
 
 extern int team_modeop_port_enter(struct team *team, struct team_port *port);
-- 
2.53.0

