Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2439052ED54
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905247; cv=none; b=gtFHI0E3E/t3+YCc9GTjYFmwG5JCUW9h+wuEWukVJvMnp5D7e3EwiYMfc/gOYrNSQRl6ikKUtC5deZ2XU7/IMn6scK6bTpskYKKluo34wEOWQNn/v8mPZKrNCb9/YT+Rw3KGdxO8GruMEUrsJcs902EdTjxqjeUYMl+8ybm9jL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905247; c=relaxed/simple;
	bh=hjBO2t1U8YQSol7JAZjJ9kYCmUL+ewbQaGJY1hEBQKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RvjWfFgeJecvO8scB3CoaOO2OpTeaHzDUpEl971ogwiabI5zRuJnU4r5Dpe/r4a3EnCW40Q5fEO0Lcy8Xak53ko3UEZMbt/EDv54JWev3Jo9kU3NOtj09O91l81c2xJ+2/WZzF9VZjcAsUDZp46e/lhZ9SP9RlJA1QcnXbBMueg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjTw1Emt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjTw1Emt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 273C61F000FF;
	Tue, 13 Oct 2026 15:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791905245;
	bh=zl3GjSYv6F0wfl/Kk724DF6PlP2P9o2M6yJCzE2Pmno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PjTw1EmtWsxVUXpr/SI4ayz0i9bogkRWPNZYCNMpfCK8SH+qcCf8jcqhvYbcryH3H
	 LEpAXHmBFsoSYMvhEH+exoePZPUu8O283aat89TJ5YnfTX45hUKrdD6VM/Q4ARhb/7
	 U1x/Bk5LZYp5sObrwfreWUh3S4AxyD8bbd+C9wuZ1VSB0aERwxTZZRYJltsL7BeNZi
	 2DK+yr/4Tr8cXBS5liEYpTHf9ee5kmipyr8cExVd6twO2Tlrs7e9BJA0BZAws4XddK
	 TeO/oLxuYTSNmOBdpq/6syw36Jarqca/iM0xPoMPLf/0U4ZN7mXD/MwfjTG05t0eTh
	 tYYTn2jwTnEWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marc Harvey <marcharvey@google.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] net: team: Remove unused team_mode_op, port_enabled
Date: Tue, 13 Oct 2026 11:27:21 -0400
Message-ID: <20261013152713.222800-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101203-kennel-comprised-be30@gregkh>
References: <2026101203-kennel-comprised-be30@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marc Harvey <marcharvey@google.com>

[ Upstream commit 014f249121d73909528df320818fba7693d0ec92 ]

This team_mode_op wasn't used by any of the team modes, so remove it.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Marc Harvey <marcharvey@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20260409-teaming-driver-internal-v7-2-f47e7589685d@google.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: b7454f1940c5 ("net: team: stop reusing skb after queue override")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/team/team_core.c | 2 --
 include/linux/if_team.h      | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index a4bf020cf8e7c..daf12b362d034 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -943,8 +943,6 @@ static void team_port_enable(struct team *team,
 			   team_port_index_hash(team, port->index));
 	team_adjust_ops(team);
 	team_queue_override_port_add(team, port);
-	if (team->ops.port_enabled)
-		team->ops.port_enabled(team, port);
 	team_notify_peers(team);
 	team_mcast_rejoin(team);
 	team_lower_state_changed(port);
diff --git a/include/linux/if_team.h b/include/linux/if_team.h
index cdc684e04a2fb..31a4f13ab2986 100644
--- a/include/linux/if_team.h
+++ b/include/linux/if_team.h
@@ -121,7 +121,6 @@ struct team_mode_ops {
 	int (*port_enter)(struct team *team, struct team_port *port);
 	void (*port_leave)(struct team *team, struct team_port *port);
 	void (*port_change_dev_addr)(struct team *team, struct team_port *port);
-	void (*port_enabled)(struct team *team, struct team_port *port);
 	void (*port_disabled)(struct team *team, struct team_port *port);
 };
 
-- 
2.53.0

