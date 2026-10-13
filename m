Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F374847A878
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791907494; cv=none; b=ZJF8kTgXt86e0Eh2jD9PSh6gnyvLPMJWWsGRKHFdrmvAjnFCSI7zcuuaGDLr4m+cXQwl4I/PIGL6uKtovAfnG4LyB0c4dBnQmwE+qanehdB541xx3daS9LJ3fFpugE/gKORBI+wgQyXA7qaZaCCAGv/txVPQCcRTc4vDo/x/00o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791907494; c=relaxed/simple;
	bh=WLcevuekxwWIzBqV8CwEBFqwXcUxi71s2RJliyZMmnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6Z2LXdZuQGeEl/fQj8VCVL3W/CS6wHUSMMx3vYopNKIiT4je7PNYVjRWeU4j1DLN6ctIk5O32W5adOpZ7L+PWOZQx4wt/1TbtVSgRZgM1QcrkHpEQf+lQsWCiGoAqbv9Hr8BCa0YiWB3JIZptE8e0HnUWDeoZ2AW8GlM4tvh30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4WYku4t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4WYku4t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360061F00898;
	Tue, 13 Oct 2026 16:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791907491;
	bh=AuzNPhq5FVrcojQGGEIlwws5U64VF44dqbw877qIrrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b4WYku4t1FXsgQhKsGNkmFDrYzniCRkQcYoXeFlv1daV1LpQhwqPZFhr2wNGsj35G
	 dhFfs4b7EFWE4K0kcFxVnfGEH87OhGHR2AmaZMYZV9dNCCNmrULzep+Dg0XVDjhOWh
	 L5402JAdsNEP0U5NTahOjGYEMFHOE8Y8NMQapzrWiUJt3AqcsddsLp2V2IX2ORR8GP
	 o5byafkw81Na57GgzkGkqKGtEAZWghTCxdB1Wq+frn3SnfJ3TuLwf/O3BboJFy+B1X
	 XE7FRCaPD/1TfWY9kCf9za21rqo3LwpYoLW6dbLqCCZcxEl/y0hFukfrbKn6t3P4Ci
	 RfOFdt7LPaBkQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marc Harvey <marcharvey@google.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/4] net: team: Rename port_disabled team mode op to port_tx_disabled
Date: Tue, 13 Oct 2026 12:04:47 -0400
Message-ID: <20261013160440.383603-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013160440.383603-1-sashal@kernel.org>
References: <2026101205-aluminum-trading-cda4@gregkh>
 <20261013160440.383603-1-sashal@kernel.org>
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
 drivers/net/team/team.c                  | 4 ++--
 drivers/net/team/team_mode_loadbalance.c | 4 ++--
 include/linux/if_team.h                  | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 58dfecea5ef96..c91dbd5262643 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -963,8 +963,8 @@ static void team_port_disable(struct team *team,
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
index 32aef8ac4a14d..161b70981c0b0 100644
--- a/drivers/net/team/team_mode_loadbalance.c
+++ b/drivers/net/team/team_mode_loadbalance.c
@@ -672,7 +672,7 @@ static void lb_port_leave(struct team *team, struct team_port *port)
 	free_percpu(lb_port_priv->pcpu_stats);
 }
 
-static void lb_port_disabled(struct team *team, struct team_port *port)
+static void lb_port_tx_disabled(struct team *team, struct team_port *port)
 {
 	lb_tx_hash_to_port_mapping_null_port(team, port);
 }
@@ -682,7 +682,7 @@ static const struct team_mode_ops lb_mode_ops = {
 	.exit			= lb_exit,
 	.port_enter		= lb_port_enter,
 	.port_leave		= lb_port_leave,
-	.port_disabled		= lb_port_disabled,
+	.port_tx_disabled	= lb_port_tx_disabled,
 	.receive		= lb_receive,
 	.transmit		= lb_transmit,
 };
diff --git a/include/linux/if_team.h b/include/linux/if_team.h
index ef1f566b90a05..a1fadb70dd52e 100644
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

