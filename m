Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD21390CAD
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788976326; cv=none; b=G4pC3f4COe1xM2nrKaKJ6CreDwGhCTsJLv6vWvU7VSiwxjImGMav1qbnyErozdE704Uz2tvg6SmmXfnuL39Clhzv5BJGCOrmzlqgv10i374hlRrwhJu6xFsoOBwnnEwFTekWun5QE31Fih0+JkUkkemXVCG2wh8rCPKp2evpNFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788976326; c=relaxed/simple;
	bh=QvsmRrnmXOAxyfeFpt3bfdpneffrGRWwmP6hYtVuhpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GAA28tI3I1PBrkVySQt68y+b+lUAzMf2tI5rCXfiVwRuO8kYlntB7FBvaN4ghkxAAq1nlOo2kpaddIAITeU0nG0/IThBr9CiOJiM0J06pWSXKLBWDyfUVsuBWAkdpsJkQoyRSO6Buv067DWw5959XvwfUrVyG/LLmqsHAnUuwCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwPwPP0T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwPwPP0T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1AC31F0089B;
	Wed,  9 Sep 2026 17:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788976324;
	bh=WEOMcHYKxt/fs/Dso3LtANlXGLygm0wdkeRSK0SV4vI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mwPwPP0TlBdD4T59/3twAIGHHGG4xVjazmgCWDbPpx1Spq15IXqPQHlu8O2iiUfqv
	 +n5Hcl/kDzEO005ylhGcQJNeTWk4dZZbGsDQ/q0ZsskQJstuwqUfOsMal8Qw9PLEBP
	 dZq3yCOtzNncQSdbk8JjuGGhXoEZVF2pZD0Q8jS/yCKuTtvrovhfDTrUGmVHsJJniS
	 rEQv2MLnQwfoBCjlAZHD/Fl6SWclUMnBpldAslk1sRqN/3I/bwR3EdauAYGPlbEs1A
	 bSuuee+2MeOwiH8snPeFooqFdR/x5MntWOTuIPGqBLS76C4GQLLkSvFde1lBGHZ5Sq
	 h3B34YJ/8LnBA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] net: fix spurious TX timeout after dev_activate()
Date: Wed,  9 Sep 2026 13:52:01 -0400
Message-ID: <20260909175201.3360823-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909175201.3360823-1-sashal@kernel.org>
References: <2026090352-dealmaker-grope-80e1@gregkh>
 <20260909175201.3360823-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 82aeed2400786bd3f79d88cb8b8f42e6127e5923 ]

While debugging another issue today, I found out that my TX queue is
reported as stopped for 4294907392 ms (49.7 days), on a machine that
had been up for four minutes.

    bnxt_en 0002:01:00.0 eth0: NETDEV WATCHDOG: CPU: 28: transmit queue 23 timed out 4294907392 ms

4294907392 is not an elapsed time. It is the value of jiffies at that
moment: INITIAL_JIFFIES is 4294667296, which leaves jiffies 59 seconds
short of wrapping.

dev_activate() runs transition_one_qdisc() over every TX queue, which
resets trans_start to 0, and then stamps only queue 0 through
netif_trans_update().

Stamp jiffies instead. A queue stopped across dev_activate() now gets a
full watchdog_timeo of grace, and is still reported if it is stopped
that long.

Fixes: 9b36627acecd ("net: remove dev->trans_start")
Cc: stable@vger.kernel.org
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Link: https://patch.msgid.link/20260825-trans_start-v2-1-286b4d6d70cb@debian.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index f0036693df9e6..2861473a118a5 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1175,7 +1175,7 @@ static void transition_one_qdisc(struct net_device *dev,
 
 	rcu_assign_pointer(dev_queue->qdisc, new_qdisc);
 	if (need_watchdog_p) {
-		WRITE_ONCE(dev_queue->trans_start, 0);
+		WRITE_ONCE(dev_queue->trans_start, jiffies);
 		*need_watchdog_p = 1;
 	}
 }
-- 
2.53.0

