Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289D751AEE5
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906013; cv=none; b=u5xKmxKJ24NZvu9uku0fUC+zqpnWrvma93UtQUTAB7cNqJ5/NQuIlTb/Vb7+ShepPqf6nMJhYsadoFuGoyEca1lxheoJ8E9CaaEH9I0f5slFsWSsQlL5Y2smZRvCpUDy1oKM7B8lSYkM9M71ym4guylADcNXAKbdNhvDwD+LO8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906013; c=relaxed/simple;
	bh=azt15MeTLko6561NNz1h87GE/Zt5uc3Ng22G6lgQqg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=beMIdZixeZ5CLReDxvMRKjse473Z/1QguXS8xdHjqxG8QQ/stPm4HbRNNay0fOeawqL1rQxI/yF744gI3rLr9RzfaAlj1ZV6L0jI5tNVPKcxwjItn4jmdA+2OrLVDpFDaqQJOHLHj6Whr1Zt4z1X0VDFhm963vwRX+gQbObOsDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7eXw7qL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7eXw7qL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E81F1F0089F;
	Tue, 13 Oct 2026 15:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791906011;
	bh=jUzl+d1Emr1yjmJfCUnvDue/zxs+q4cvNgv7FPuyW2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h7eXw7qL5p7mAsUeDoXQ3P1ckssFsJBEkr27Gazvg3SSCn/MXaNLniWyZKSrB+s/K
	 iOLTp2I3+M/royVDOMkpxpzIQhOfVvvre0LF9Uy0vIgB+6FqU17j5aqZuD7AI1mqZm
	 S599k9THfgOljK38kS90YIqXExmw9kh1/dQUvRX82vzaMn+keZPbv+a8nAEIzrnq3p
	 qkNdHxmliuGQ1V2cwNuVuWXdMsI/rJoeaZ3zljzY/CnGngtuDjq2y+Uft5wCYbHwPK
	 Iiz1sDJTA9UcTm79OlXQfM7D8+HSInJZFvMOzXF2BYYKeMO2zzSQx+R8HukwwcTwPf
	 nEJqJ7v3wMfqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marc Harvey <marcharvey@google.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/4] net: team: Rename port_disabled team mode op to port_tx_disabled
Date: Tue, 13 Oct 2026 11:40:07 -0400
Message-ID: <20261013153957.280683-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013153957.280683-1-sashal@kernel.org>
References: <2026101204-platform-squealing-b6e9@gregkh>
 <20261013153957.280683-1-sashal@kernel.org>
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
index 32ca12211e7e6..b552c79411254 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -969,8 +969,8 @@ static void team_port_disable(struct team *team,
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
index 1e378d3a7eaa0..7a69cd251bfb3 100644
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

