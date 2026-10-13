Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482DA531613
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906555; cv=none; b=I3YKkEICuaApLiawTo0VXlIebrU1Cg4oE9m0ian5W+EYTkn+zcnTGgccUxjaf/LytlwhttyJ0/uiR9sOajWKJ+YxDLT7RkvKXWNffXAHpVwageRVbcCWZ3ShDc8niuvNAxVhvnBHfcJ8mFDlcotvvlU8+IEPeGe7OQHOEN+H3R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906555; c=relaxed/simple;
	bh=/e+40pR43NU37ZRt0gOTcyUwoGmas6T3+pMa2rfFBZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFj10sAR2Y0r8ubBDMRLP5GWUw0VeS6KZQI3A2qzkLArY5MAVxnWUbjwIA6rIK9zg1erwhc5J2xJNbMW9IbcdxicfD4EM1A09sQr8+wHrACtCnCFuJRmr8q80WbNAgmSppUUvVTCPgc8w4cFYGeafcsyEtKa3vK+s/3/PWvRg7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HadQYfJf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HadQYfJf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F981F00893;
	Tue, 13 Oct 2026 15:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791906554;
	bh=S25VenCveEHJ3/60Aw5mwCVgFGe5ZQSmJr6M9Io8iwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HadQYfJfFlLbVJzltUSBZ1jaVdaLtS566q8s19bUk8IsvW/1Zi0GPjEJCiNSXVxh5
	 +AKVVV4K2Rdbl2gR9tYeLNv8t4PHleVkVx+l61uL2+vDGAJzUgAGh0w84qvYGotGcz
	 UoA6KCK7Qhq48EQ7OsScO3A8v46eqU2mO/hSml8IccIlLF2RhPr36SGSGQVUw/s8MR
	 1aYIeyjG/q8bRF9c4nhm/gZXRep9Q9cHSnMcFhPicb7RNuRDrVUvZkwG6jMx9ApqC2
	 6uFexnpbMWQthL6YDFGBoPSSRYC57MYP3cjBJ6Gd7nMkAaOt9KcWEPCfqrWhWpkUlv
	 0aVXrorYweoVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marc Harvey <marcharvey@google.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/4] net: team: Rename port_disabled team mode op to port_tx_disabled
Date: Tue, 13 Oct 2026 11:49:09 -0400
Message-ID: <20261013154903.332547-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013154903.332547-1-sashal@kernel.org>
References: <2026101204-giggling-uranium-405b@gregkh>
 <20261013154903.332547-1-sashal@kernel.org>
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
index 98500e76f095f..0d2fd43fd00a4 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -964,8 +964,8 @@ static void team_port_disable(struct team *team,
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
index b095a4b4957bb..89ee6bee049c1 100644
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

