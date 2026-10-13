Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FAE52D2B0
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905248; cv=none; b=vBzM+TXpY5fyqa5RqyyKJ0bkkuppqLNE5/YYUZwNTe3E2jwtSyh/A8kJHNFvxfZnMsE8mu6MmZ/cNt7Xzx6RRSFurkPTGWa6Wbkv3/ahzOJebIjFHUqKAAMPXRHXxKkfmLFkZsQez/Q4Ds0yj6CqI8AEOX1PHD59hhlV0ZHZtxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905248; c=relaxed/simple;
	bh=SPFpzg6Rf75LXFVYUUHkpDB0iOWz0HPPHQmOhmUAGuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TK3iTi7UqQtYo5ZboBSv3siMpHapVYvR39LJWzYOTj8qw/BNIUT5tLa97Zx4E1+5E96a1Gv9KqhuRXlkoaPISIrYR6TdLYbWndnQgtH2gSMqj7oVkcOUAkTjScZv+sChbvBp5JWh+qmwNqqL8PhDHSFrkky6Vat7TBGCcXnjCdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LG2KyyvS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LG2KyyvS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C421F00893;
	Tue, 13 Oct 2026 15:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791905246;
	bh=R3uzxkdbQIn3cjDa4m1RXavqiiFWfm9EL4GzOzSJ+b8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LG2KyyvS3Y0NPd02D3fFj4wUZY5cBl49n3PPsv16gNEPSsMQ3nDBVv7YaM950nMaU
	 CK16QzGQiRvNgisuiyeA0LswMHnmnVz8VaHVPvRZbqTl7V/KFCz0F3etJgFC/rxINe
	 cUN4trW0SRF0ho6z5QKvWQb0qMpEH6AY1CdsDId58QD6zXYelvkmEN8z2u2U1dE1is
	 jihiGiZ10ipL1PDvlicKcGel8FHS6Qpt5o8EzYlOzf2uM852yVNGzE2vLxgl8vZg1y
	 +WC0oev6DR8/jLZ6QAE21t8R/KgUiNifcxjO7iytnuolGnLKxZK9HiDCSDZxUPDMrS
	 RnqDOTwgEQHew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marc Harvey <marcharvey@google.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] net: team: Rename port_disabled team mode op to port_tx_disabled
Date: Tue, 13 Oct 2026 11:27:22 -0400
Message-ID: <20261013152713.222800-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013152713.222800-1-sashal@kernel.org>
References: <2026101203-kennel-comprised-be30@gregkh>
 <20261013152713.222800-1-sashal@kernel.org>
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
index daf12b362d034..89f33ad6a0603 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -967,8 +967,8 @@ static void team_port_disable(struct team *team,
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

