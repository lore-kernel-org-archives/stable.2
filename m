Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589E236F8F5
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 03:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785295758; cv=none; b=kUl2cT4U3wFwq7DlgI2WK2MkxqkZDBI7qr7cdrkJPh8WW4+TTAYyMDcDOLctfmuZWbi74jud/jqR9viJjJt06yTnrFkGkn/f07yEQsk1o2d3u+AkNWDcd5EUPvAk9uBIN+b2fqeRbiGvg0zlLNSejliHB+bMSck2OunQVUy1Te4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785295758; c=relaxed/simple;
	bh=0czioHS0PIOcwzTaEcIyg0NWJVoikoTVWTkPTu1Gjpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KdV5AGmu9yOnhgpWtQBk6le6T+1oIQDcRPtFBQJuv4Lc+KaaDTkdEpTqMN5ZHz4A9ixcWZ+h6bCHcew+FpdcRl7WrUuPo8cRLeqntVJcdxeGla2WI2384Au8sFzGv2t6kug1fMnDnIspcMsBg9wYxm/83ekfPIdY5lQ0rtcYCgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6HBnNJ6; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6HBnNJ6"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3811f512167so471702a91.3
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 20:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785295756; x=1785900556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RhKbpLX/FII2EUu5sbC4SSY9m0ly4BxD5e88w3AyYnE=;
        b=f6HBnNJ6LXpDVInTTErHOeStK9kUir1UW0lbXiGZVrtJDW+qP30YPdR6ehEF8I6Rk/
         P2aUiZVFO0UGjWU7BeirBBLjdfn40cOGsJsP18XLrU5/szQg3oa+KuxE6XUNzDDuldaq
         7xeZzLVWGoDffGxMMx9GpWLBj2C1PXYWhTU4JVyAoQq9c+lGgKRmfE/JhoaoWuyEkifH
         aH2EP04v8aXraU06lvr+ZWPdV93/asFb15jO4K1uUYyYlNcLI+KXMBYIJQrMLACYhYiH
         zmO/ybkPS7ZYneshstXqQPfIm/UjOomxwQPYD3F+6RcciwKq+nbXyaO8IcOiMUHTZhOl
         tB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785295756; x=1785900556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RhKbpLX/FII2EUu5sbC4SSY9m0ly4BxD5e88w3AyYnE=;
        b=GxoTFUATprMny7xQrQUVkfAa6AgHy67pT2FHqIlPOZrXPmpnp2RJodgz51fLv47e0l
         Osp57MIq1Gw1tFG1x5Pvla76I9Rft7E+RsEl8XgCTckbz8GhVE+QaCc9Q7z6bg55CMhT
         YYGi84ip36Y+9+u+m59AEmGkIN2rBa6LcPVp4KyRmvUxoC44aoBukFdjM/W/PxkpexaK
         vf9x+W9yeSPcvIKmcB5N8AOK+wmw2gSRdUVJtuHMalyktw2XB69AA5N7GxlSpBkcrRbQ
         rvAwrLGz0nWwFAV+Et+x5fh5JbPYcHqYei+9G/BQI4MnkS+adeym8lLDFhq8GS3LNAkW
         z9XQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro7CAK25vVekhxFdBwNKGYsA9YwLHBf/MOdusEISlpBinof/yf8XMGKsLh+/8TicX+XgvhelJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPMFQyZcbstvWxCDcZOO7V6/JJ7mMwR+JAmaQq17ijlzELieij
	rnfbXSDhvU5Qn4yLY9r8xE7FsO8DWiAeVjtCMhNAlBQ/M8W4k/P3RSur
X-Gm-Gg: AR+sD10r/9Khn+6Jtx+LdWIYjPPTZKf+m2B4ISEbLpp85x4ulvTWO8a0MSV0RsaNgcT
	HUMKcCsU5QHUnmN2BLBgZ65PsJBLVBxLEIdDbw74L0VeyHlLqvWrlb0ydlY+tz1DCuiYrvB6fzN
	5CUD1in0fts2Z1PRZ162crkog4MTVRC9MEFhAs4lrdXjgbdQ39u5Skq1DfzdwprZ68w2UUImqAR
	nojfCvLhQu8sIiRFjYOI2SM+GAj2KB+MOp8gUsnbBGjxX5liUKbqdtEmW9vnSOzIl/CbQJVeex8
	OWKL4M1KqScxtDFV8wbcYs8dy7vF0zfjibkErZp/DdTT48BR8DNZaFP9MGWN1TrySN3afptHc28
	t4jxJ1uQcbF76YTcoXbeVCssp0ly+lr7v5jmIVRrzZwNWVJai5AZzaHoN1Hr+OBplBD2ogYot6g
	5H99UdtJEqfEzXn+wnvNoVEMiTtY73aCU1Vy5hADf8mF/7YP0/Wtq+FAAvS+rUigT7TSl0giF2y
	sdkbwWxGVndA0XwTCqF
X-Received: by 2002:a17:90b:3b41:b0:38e:6aa7:68ad with SMTP id 98e67ed59e1d1-38f6a30c840mr5166952a91.5.1785295756488;
        Tue, 28 Jul 2026 20:29:16 -0700 (PDT)
Received: from localhost.localdomain ([116.105.227.66])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f64130e0dsm2053547a91.8.2026.07.28.20.29.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 20:29:15 -0700 (PDT)
From: Yuejie Shi <syjcnss@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>
Cc: Eyal Birger <eyal.birger@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH ipsec] xfrm: do not take x->lock under xfrm_state_lock in the NAT keepalive walk
Date: Wed, 29 Jul 2026 11:28:16 +0800
Message-ID: <20260729032912.55800-1-syjcnss@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nat_keepalive_work() walks the SA list with xfrm_state_walk(), which
holds net->xfrm.xfrm_state_lock across the callback, and
nat_keepalive_work_single() then takes x->lock underneath it.

The rest of xfrm uses the opposite order.  xfrm_timer_handler() takes
x->lock and calls __xfrm_state_delete(), which takes xfrm_state_lock,
and xfrm_state_flush() deliberately drops xfrm_state_lock before calling
xfrm_state_delete() for that very reason.  The NAT keepalive walk is the
only place that inverts it.

lockdep reports it as soon as both paths have run, which needs nothing
more than a few outbound ESP-in-UDP SAs carrying
XFRMA_NAT_KEEPALIVE_INTERVAL and a hard lifetime -- no traffic and no
peer are required:

  WARNING: possible circular locking dependency detected
  swapper/3/0 is trying to acquire lock:
   (&net->xfrm.xfrm_state_lock){+.-.}, at: __xfrm_state_delete+0x60/0x324
  but task is already holding lock:
   (&x->lock){+.-.}, at: xfrm_timer_handler+0x94/0x50c

  -> #1 (&x->lock){+.-.}:
         _raw_spin_lock+0x48/0x60
         nat_keepalive_work_single+0x120/0xb60
         xfrm_state_walk+0x284/0x468
         nat_keepalive_work+0xc4/0x15c
         process_one_work+0x450/0xc78

  -> #0 (&net->xfrm.xfrm_state_lock){+.-.}:
         _raw_spin_lock+0x48/0x60
         __xfrm_state_delete+0x60/0x324
         xfrm_timer_handler+0x35c/0x50c
         __hrtimer_run_queues+0x1c4/0x5b8

   Possible unsafe locking scenario:
         CPU0                    CPU1
         ----                    ----
    lock(&x->lock);
                                 lock(&net->xfrm.xfrm_state_lock);
                                 lock(&x->lock);
    lock(&net->xfrm.xfrm_state_lock);

xfrm_user_rcv_msg() gates every operation on netlink_net_capable(skb,
CAP_NET_ADMIN), which is CAP_NET_ADMIN over the netns' user namespace,
so an unprivileged user who unshares a user and network namespace can
set this up.  When the two orders do collide, both CPUs spin forever --
one of them inside hrtimer softirq context, which also stops softirq
processing on that CPU.

x->lock is needed here because the data path updates x->lastused under
it.  x->nat_keepalive_expiration is only ever touched by this worker,
which is a per-netns delayed_work and so never runs concurrently with
itself.

Restructuring the walk so the state list lock can be dropped is not
worth it for a once-per-second housekeeping pass.  Use spin_trylock()
instead: it cannot block, so the inversion is gone, and a state whose
lock happens to be held by the data path at that instant is simply
revisited on the next run.  Deferring one keepalive by a second is
harmless -- the configured intervals are in seconds, and next_run is
recomputed from scratch on every pass.

Fixes: f531d13bdfe3 ("xfrm: support sending NAT keepalives in ESP in UDP states")
Cc: stable@vger.kernel.org
Signed-off-by: Yuejie Shi <syjcnss@gmail.com>
---
 net/xfrm/xfrm_nat_keepalive.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_nat_keepalive.c b/net/xfrm/xfrm_nat_keepalive.c
index eb1b6f67739e..7143c7a11c18 100644
--- a/net/xfrm/xfrm_nat_keepalive.c
+++ b/net/xfrm/xfrm_nat_keepalive.c
@@ -173,7 +173,19 @@ static int nat_keepalive_work_single(struct xfrm_state *x, int count, void *ptr)
 	if (!interval)
 		return 0;
 
-	spin_lock(&x->lock);
+	/* This runs from xfrm_state_walk() with net->xfrm.xfrm_state_lock
+	 * held, while the rest of xfrm takes x->lock first and
+	 * xfrm_state_lock second (see xfrm_timer_handler() ->
+	 * __xfrm_state_delete(), and xfrm_state_flush(), which drops
+	 * xfrm_state_lock before deleting a state).  Blocking on x->lock
+	 * here would invert that order and deadlock.  A keepalive is
+	 * housekeeping, so if the state is busy just look at it again on
+	 * the next run.
+	 */
+	if (!spin_trylock(&x->lock)) {
+		next_run = ctx->now + 1;
+		goto out;
+	}
 
 	delta = (int)(ctx->now - x->lastused);
 	if (delta < interval) {
@@ -192,6 +204,7 @@ static int nat_keepalive_work_single(struct xfrm_state *x, int count, void *ptr)
 	if (send_keepalive)
 		nat_keepalive_send(&ka);
 
+out:
 	if (!ctx->next_run || next_run < ctx->next_run)
 		ctx->next_run = next_run;
 	return 0;
--
2.51.0
