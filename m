Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA764F5DFE
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791907492; cv=none; b=t8yI4d30GXDOTv1p7RoBffwBlv/kZ73y/3wHalWWTQWGqdPrrzK/7cpdlXtZgKcglc5HvWAq5lIfUjchECzyXQ1ftjAvMPpEXYBBvVKOBjKP7vYiXy+ojHts9svxabSl2LaotY+tfN4PPdUEqqktgdh5xBJok6HOMwOVLtHmu1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791907492; c=relaxed/simple;
	bh=VdEJmCEh+Ty6Mm4cAu73JzgTOG8R/5fXqJWHVjEM6YM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kv/C9yGddDxIvXZfeY/Vn8OZC3vzuAyvgIJDpaXmVvb1khtkinT7+3izoCMAk6q8+CJ0BS4DQqHuAjrahcmO/2oNlp17pt7/pU1WfRQA4hPuuxOGX8mbZFmZ7ac30jpGMaFd7+Kbb4R55E+bN6IqW4m1uyZ5N8Hnfea+k2GLzbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0w6O6F3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0w6O6F3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FC51F000FF;
	Tue, 13 Oct 2026 16:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791907490;
	bh=9cvbttadbSrTArsQwcNzqHsZdw84Lrx6prIuM6+YQd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F0w6O6F3jwCa85k/WASt1+OmQkV4u98EjKvFqBaF9hvzS7ix3UIKP6C8M9mGpCrX0
	 HdfbqWCzNz+gcuGmjUXrv8tYgx/NZGB3ksadaEDU/QGAQZecRp+2AGwheSwbqsRABw
	 IPstJEU14wxFEQlMtHyjtOP9toE7RuxRFjdax6W4CFyTYlwgxq4VjHSeWBRmdh0zXK
	 toCHigFH6XVIKaK2/bMpR/S92txuIuLc+3mJ5TvmrGjfVbCK0LnoBUEBIx4WXnuzVb
	 uxygssY5nK5UGzrKqu7A0TLXr/Oln/QPlgiYwFKVb7xfSjyneQodV1o3rUKC3wXsmw
	 ppQMutRCS/loA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marc Harvey <marcharvey@google.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/4] net: team: Remove unused team_mode_op, port_enabled
Date: Tue, 13 Oct 2026 12:04:46 -0400
Message-ID: <20261013160440.383603-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101205-aluminum-trading-cda4@gregkh>
References: <2026101205-aluminum-trading-cda4@gregkh>
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
 drivers/net/team/team.c | 2 --
 include/linux/if_team.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 0b62e204c7bb1..58dfecea5ef96 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -939,8 +939,6 @@ static void team_port_enable(struct team *team,
 			   team_port_index_hash(team, port->index));
 	team_adjust_ops(team);
 	team_queue_override_port_add(team, port);
-	if (team->ops.port_enabled)
-		team->ops.port_enabled(team, port);
 	team_notify_peers(team);
 	team_mcast_rejoin(team);
 	team_lower_state_changed(port);
diff --git a/include/linux/if_team.h b/include/linux/if_team.h
index 762c77d13e7dd..ef1f566b90a05 100644
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

