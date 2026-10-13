Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960455221C5
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904557; cv=none; b=cxqp18GGlP/BALK/zjQQcpvEfbNjPwNYbjxYE+jh7tbwjClAv0609Nvx+fURqPymZockRxT5jgOD+rPaA1VVxsrFGeTEPzOfUkmYjm62zrafrzgupkhEnEpAbB3EbKDJYjwWjRuNIeLuiyk2Qxz72f0vBu8SvglmbwUfHi59VzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904557; c=relaxed/simple;
	bh=c364MlcWS22wqQJFFWb9AAqgLenz409JsdgnXFOMGwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJVJMx7tCvGnKefNVku642d7IaXNahe+M/tFUJbRpjbIuGRc4rYYEW/ZloXh66/IOHOGjicqkcqy28n56K36TV4P9/TU0MzVVyiNws8re+c/14Vr3sMO2oLmwzu6n8RWsxHP8XStv9GjHY+Srm05tGdpp1ba3Rf5X9I3i6N80KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1xWI7fV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1xWI7fV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6E71F00898;
	Tue, 13 Oct 2026 15:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791904556;
	bh=ckHTluPq00ykyuTw6vfVQcazcCChTVxdNnaVW1R87ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L1xWI7fV9vrPv3kJt6V/Bnfpe0UPeysenwsVZe+ZQS/IOjjyEtDqJCJ4E7sQkn+YX
	 /1Z9PCzBSFNKaK0bFNOLET3zfk2HAVn93gs1xoGS/d8MSc+kEAHVuDqjAzhfejybl+
	 WPJrt2zCPWDt6zEmW7aJgc8Lh+ITzhoM2wvnjQiP3d3tjHRMQbLavrWqFdiOhsSxu4
	 lxDoxRVz0502358U2Hx++lari49IoO/8CSLNkbuv8Ugu86QZmdUGrYP/0m3wkg43z1
	 sGx+LxWA4v445RwqgUctR/e9Im4iVvEal2nN+eT8hAMBITW5Bidaxux9cSSj+i6+wi
	 RfyZDqlagaEkw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marc Harvey <marcharvey@google.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] net: team: Remove unused team_mode_op, port_enabled
Date: Tue, 13 Oct 2026 11:15:51 -0400
Message-ID: <20261013151545.72467-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101202-slimy-extrude-989f@gregkh>
References: <2026101202-slimy-extrude-989f@gregkh>
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
index 3cbaee3ff5fd7..7d14acaadd616 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -944,8 +944,6 @@ static void team_port_enable(struct team *team,
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

