Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8967423C512
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 03:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781582360; cv=none; b=PjkZ8s0LJgrU8eYUsGWAXbmcIBsI9tJvJSH1M/vyv31OSZVhmrQ7coH0sKdnFW0V9/J8f0G5sO7ZOFCGFc7FBpbGi1hdmb8j3dTeZkYDOmZiDSApmNiuECzBdFuUEC34LEeyUJgwi91wWXAmtD1Va5zn0L7pD+230TjLRLB4LDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781582360; c=relaxed/simple;
	bh=L34TZaG1CUVgkDV70qyr7WmbibCSp0fzLCwFbSIScKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pRObUG9VSTQW0Qbp8qhbDXc91oqemLuN/FXnFOR+URw5Y1iH/B70s6b+vCQlq5L2J0KuTPiqdmTue1C2ge+9BFYZt5+thssXbJw+sGLvxNcfHo807eVMjBwyEUBHI5JQyEVpehW1/TbUt8Kelhj8/OdOD/d0J0MZxgBWU/POLXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JiWb7Sbl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JiWb7Sbl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36891F000E9;
	Tue, 16 Jun 2026 03:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781582359;
	bh=1816sFV7Tx9wVvSCP7UoL0prADHo03NdjfpXZs4w48M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JiWb7Sbl4L1ZOE0DljFrnFjdujpbFjM+BLQCdFD/pBGCxdykDeWvB9sVaWT4NS6CZ
	 2Mlw/NYEsu2U0moeevcnQX2jjMsYvEMZOr3pjI41Q0RKnwORNtltnFOQ2ohzuzql4E
	 L7WwkPhHB/KmLu8wxPvOajeD5esuZCsAbKsSGrXlZiurh477LM5OEEvjAUZVxYsAgJ
	 SWNhsLYaBErLh7Q7pdWVSyW0gJ//GZymgCoJpQ9QeG4ToZhH6oHdMdx7GvOoqbm7dx
	 NNFYJkmWN2TAEDv4f3tJ5fmyfHrwjZ0IW3OSbsKu04UPccfEpg3lcjThNx9xR4cEl0
	 Lk3TUUhdXYgFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mptcp: fix missing wakeups in edge scenarios
Date: Mon, 15 Jun 2026 23:59:17 -0400
Message-ID: <20260616035917.2802898-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061537-frostbite-collide-666a@gregkh>
References: <2026061537-frostbite-collide-666a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 9d8d28738f24b75616d6ca7a27cb4aed88520343 ]

The mptcp_recvmsg() can fill MPTCP socket receive queue via
mptcp_move_skbs(), but currently does not try to wakeup any listener,
because the same process is going to check the receive queue soon.

When multiple threads are reading from the same fd, the above can
cause stall. Add the missing wakeup.

Fixes: 6771bfd9ee24 ("mptcp: update mptcp ack sequence from work queue")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260602-net-mptcp-misc-fixes-7-1-rc7-v2-1-856831229976@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 38550c44a20193..ccda3a7bcfd401 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2242,7 +2242,11 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
 	}
 	if (ret)
 		mptcp_check_data_fin((struct sock *)msk);
-	return !skb_queue_empty(&msk->receive_queue);
+
+	ret = !skb_queue_empty(&msk->receive_queue);
+	if (ret && mptcp_epollin_ready(sk))
+		sk->sk_data_ready(sk);
+	return ret;
 }
 
 static unsigned int mptcp_inq_hint(const struct sock *sk)
-- 
2.53.0

