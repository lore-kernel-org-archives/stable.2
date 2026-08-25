Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6F9270EDF;
	Tue, 25 Aug 2026 10:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787655097; cv=none; b=NYiCnU+0tg1XqXyltgU1VB0spFftmhYQv5LD0FBMiLsTiO4e+4msXQu7Cd4KTJP/92ABGsyobG+gqYqL+CTotGZ+jDEWzeTdRxgtjDwpYm7bQMif/MQJUBw8ZMIko86fY7gtvUnGjs+ixZA5tB3suAhia9g/PGRHFwHYQYpaPg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787655097; c=relaxed/simple;
	bh=fdFP3wC1fOQFHW1FA1xNTBhFjVz5KPeC/RA/brLqifw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=p3BeFMtHfygW8rMxNXE28Rk7fDOr5lRdzz2xzGR4ColRf3RShBiBR3WB2avB8M3mKwIfu7SeSeN6bEtdZjNwBW7uf1FroGwpu/LwMDZY+BVJfyv932JTCaP/b2dkSLFM/wkYriUhK+zSsYS9T/KGStyPgTKqJePGhzLCiYrlAs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=HySWiWuy; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="HySWiWuy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=ikAYs2pwcbpHInM8XsxAP8vYsZneA6/qPI55oerVaA8=; b=HySWiWuyzMATnK+BqhNRmn8Ll0
	3ogS2PF/KGgMHbnMum4JHT+qNpWMWgebXdckgjExJiyx9WGspcCQF6b3XRhpBvhrmNu7drRFg2YdF
	ik0nYY9fP8CkBEENDJtdvhoKZ/WlKx7n1Qfsq8D+CyzK1+/xnakVDu/URVxNYML1s7vGxFhAHlwhG
	jD7eied/vEZLUmscdP+fGPWmdFAaz79QqATLuPxJnX87tyyESCnV3IB8685I+aGLx8W3GZLIcVJkB
	O/2VEmuJBEUilTKaQlqnMAH6FRZEuEXY/MbLaXhJ/OAoMFbr23XQdN4+RbQyvGjVkdnfq/7V8Tykg
	yLBTRibg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wyokW-00EO1H-01;
	Tue, 25 Aug 2026 10:51:25 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 25 Aug 2026 03:50:10 -0700
Subject: [PATCH net v2] net: fix spurious TX timeout after dev_activate()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-trans_start-v2-1-286b4d6d70cb@debian.org>
X-B4-Tracking: v=1; b=H4sIAGFzjWoC/23NSwqDMBRG4a2Ef2yKCfE5ch9FSprc6p3EchOkR
 dx7wXHHB75zIJMwZYzqgNDOmbeEUdlKIaw+LaQ5YlSwtW3r3jpdxKf8yMVL0U3TUYgu9H3bolJ
 4C734c2l3JCqYK4WVc9nkex12c6W/2G600bUzQwjOdhSHKdKTfbptsmA+z/MHqEtUGqwAAAA=
X-Change-ID: 20260824-trans_start-557ecd4c8866
To: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, stable@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=2136; i=leitao@debian.org;
 h=from:subject:message-id; bh=fdFP3wC1fOQFHW1FA1xNTBhFjVz5KPeC/RA/brLqifw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqjXOnwKkCfwGy5himkx2H4YOP7SjprhUveA+kN
 TP02v1GGxiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCao1zpwAKCRA1o5Of/Hh3
 bScVEACeWQaYR/NOX1MCxCoWPBQN5PJnQ+OOFjTyCuUHf6t5rgSsjAS0HyPxiHww03lLtXTcbXl
 RVD4X/hl4d/xlV448lof+Kkc2AkWUXYVtDnCu5LBz2lcwXEi8is4NFC0DRyiFtbqygXa4Iljv6d
 RxVOzq/81ZEO+8nwVXivHY8Bl6sSMaHts4fVrcz9VKlKs4cLaed1ZY7Jry9e5R2D746t6n9V/j7
 n8aH9YdaGDXfAyfiFWJ1/xXWn09QLTtqBID4uWqOMxq6CKgw15v2u/qphD/MaWzHA+3I4S/qLvi
 RBuSQgPf99qjO0k2DKFEm9mdRw8WxyKqJHWx+TE5SHxkYrknEi4glF2jx8qNXiIMBapms/pF+US
 X0uE1dxhpngyB0MnIkVz6tx0z9+AtM9J+7w1Ya9GQaKInB30myyaMiR96EBJBV2WzMhKtyxjYoi
 a0lTu3WpigqHJzhwGWnd4Eb81FOWQLizf4LmdZDOKPYQpLnVph4PU8nj4H9m6r1KdbfHP6XAlzx
 pLGudG1TRC24/y+jXgcbXcRA5XKo6HricPNh2C8rMXhCqaAvG/dvWgKcWxNKc0n+HhZmEe1b25J
 15Ph5MyQAfbUtqUvnKAM0xUpt1RxKAhaEAgBMBTH/l13h9V6Ov7ZpBWyogyM5DQWyZJRTskAG0T
 AKF76AgA74TTn4Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

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
---
The redundant netif_trans_update() in dev_activate() that Nicolai
spotted is a separate cleanup, and will be sent against net-next.

Changes in v2:
- Fix the unit error in the changelog: 4294907392 ms is 49.7 days, not
  136 years. Also note the machine had only been up four minutes, which
  makes the bogus delta obvious (Nicolai Buchwitz).
- Collect Reviewed-by from Nicolai Buchwitz.
- Link to v1: https://patch.msgid.link/20260824-trans_start-v1-1-0419cc427ed9@debian.org
---
 net/sched/sch_generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index ef2b4bf515641..4539dc2c6d380 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1278,7 +1278,7 @@ static void transition_one_qdisc(struct net_device *dev,
 
 	rcu_assign_pointer(dev_queue->qdisc, new_qdisc);
 	if (need_watchdog_p) {
-		WRITE_ONCE(dev_queue->trans_start, 0);
+		WRITE_ONCE(dev_queue->trans_start, jiffies);
 		*need_watchdog_p = 1;
 	}
 }

---
base-commit: 0a0d1d55dad570724bf8c7ea83409639cfb4be9b
change-id: 20260824-trans_start-557ecd4c8866

Best regards,
--  
Breno Leitao <leitao@debian.org>

