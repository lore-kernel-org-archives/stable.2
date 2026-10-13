Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADB653163A
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906554; cv=none; b=uFKEzUGSuVK2ZEDFdwQlwbIgcaliWASCkU8/YqdlTHrrpnNQb9Z7wBXs/MlroS6/Vp6EIH/2j7zfVb/ZC0W+MEVIW1mssinpXIn8ThCxJ+zAL3/yhkP3FW6xDjgkxOkOksL7aMRnSd4urQWpn7H0g5ovXp+bm9kbji4KEyj0QUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906554; c=relaxed/simple;
	bh=ni3kuKN6d8NPiQMY7j1G/cfcIsp6e/0XmZiAYUsqqLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QWopOGsvZ7pttUU8Qdnacjrhd68forTnFfyMlGvDP+jlWKFsZB+lOlmxYFWMCivzjGw2mniCCN+DQTT470zr3yygQWbvGiAOjPgmPzDsHfIsxuysZyfuG1770K7LstvX9lTkKcGnmXXGlWkdU7o9Nw//fv7p8Pt22mYpySwTHSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yn+QBz+l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yn+QBz+l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696581F000FF;
	Tue, 13 Oct 2026 15:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791906553;
	bh=LnV5jbqpc7hqxviIBrVS6GwXIlRW/JP5K+6Dr4Wtt6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yn+QBz+lQD/6ic3V+mKxqFWUjazLlboqTd6JmWi3zc1coSP4tIeJ0x5bOtIIXlIfy
	 I9FCTggsM78jjRTEti7wQoSpyKbdaY8ff5LrEpzkegpSLqWDdz94OzBiDfs/P38R51
	 99t3DfAAOM+4gVaMIIAK1oCbsvtdPJ5RokOQgtCSymecmk5NN9uJvgU/xT8smLSQ2J
	 66ARxh2t1M0WCzsSX310M9Jze8iU2SrIgEfsz8RvOf0/87kssOsHOTlHCuI6WrEL9N
	 822wkQ6nTCwqajdB/s+7H/vbduyxqHQavCyXsoqvDQbrVjXV9CJM5FK8u6+KMPfN1J
	 DAW/UsBJ9xKhQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marc Harvey <marcharvey@google.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/4] net: team: Remove unused team_mode_op, port_enabled
Date: Tue, 13 Oct 2026 11:49:08 -0400
Message-ID: <20261013154903.332547-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101204-giggling-uranium-405b@gregkh>
References: <2026101204-giggling-uranium-405b@gregkh>
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
index af5dbdd8f138c..98500e76f095f 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -940,8 +940,6 @@ static void team_port_enable(struct team *team,
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

