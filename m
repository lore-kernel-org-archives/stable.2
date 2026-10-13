Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBDB472074
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906012; cv=none; b=fih9SFe9JcXifQPLcacOAW3fxJvTbutmHLawmGJn0L/PJdT7kcOHcHn/dswz6h+jJsAXiIkP2A60L26fVEK/SVUcIPZuIsPb0Mm/f5Ion+sVnjjOxZkHuyT5rjKxTVUrVGd5qzJAsOC4axK6mn5kHoJxjADfTTezRkuZDSdT9MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906012; c=relaxed/simple;
	bh=wpI/9WgA4KbjRMwiiQsOW9BgxJ0kpAnEKSC0EcgYu3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROXnEXHDNT8OmskpzvzK/yipcklWJdIGlFO3V5MAy08vQJVhTVQv4NNMJGpNmHSz55txkQ4pT5uJrqKU22j6wF1yXeMNk4CXHeHiwXQubAiZT4v2ASw6reZKXyurBmIV/22zFAAwcX8MxZgcif/5YoiEtH5ZRtdY72BneOG9dxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fywio2Qf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fywio2Qf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 520171F0089C;
	Tue, 13 Oct 2026 15:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791906011;
	bh=1Cz43tD+6E90XK1RXVW30EJ+2s1LzzdP/8Mhu0FZ1OE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fywio2QfYNMvEWwVJwlqM8og22v4vRQ0cjTxJAxH7vCiF+qvmvLt+1KJ2sC7iBvP8
	 NRDuS6dCOsnL5LmWlSl/hIEweoiG19I9ygGCNJX5l3sAtx0K0jtZ580/dX7umi5EgB
	 e83OXyZu+ZA1hmSeLAX7SZLuOXropG/2OjnxlVFwul6Ex7llSItMG7eY4YYj6jLGD9
	 0y6hNtCY1cFvIiYzm1/QKBPjfYLaHpcUEk6Hs4AKnqB2FVzA/mHVn36Po06yq6hpTL
	 JpfI+lpf5cODf4RF2tIjSy/d+/bLSNTRxdrlDhCylxeIwxGMaAmONfzrG+WMqO5HBb
	 KqGHyFHrfysHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marc Harvey <marcharvey@google.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] net: team: Remove unused team_mode_op, port_enabled
Date: Tue, 13 Oct 2026 11:40:06 -0400
Message-ID: <20261013153957.280683-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101204-platform-squealing-b6e9@gregkh>
References: <2026101204-platform-squealing-b6e9@gregkh>
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
index ea2a7cea3f6a0..32ca12211e7e6 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -945,8 +945,6 @@ static void team_port_enable(struct team *team,
 			   team_port_index_hash(team, port->index));
 	team_adjust_ops(team);
 	team_queue_override_port_add(team, port);
-	if (team->ops.port_enabled)
-		team->ops.port_enabled(team, port);
 	team_notify_peers(team);
 	team_mcast_rejoin(team);
 	team_lower_state_changed(port);
diff --git a/include/linux/if_team.h b/include/linux/if_team.h
index 34bcba5a70677..1e378d3a7eaa0 100644
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

