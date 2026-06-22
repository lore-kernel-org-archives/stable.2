Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA34C23B61B;
	Mon, 22 Jun 2026 15:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782140512; cv=none; b=uQDkLmhQcV2dSRvItdBrlFfFkGsOKjFN2/j88xKDfRVUxCf5vLm/RAiMnBJG2LFX1xPe7sY7B51FcsoNOrZqL20W4HHudIIoG+2+Rm1s1L3zkto/cEaEsN7G9XxSZAUPbAXtTNELBq3GyfoOIdzspfARIUV4VKRnCMFPmsFn+Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782140512; c=relaxed/simple;
	bh=fi9OKxumYq8MA8wVF41Gx0pkkHxM1ZJyBBe9VTw0fwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IYDoC6EQkCm94/2La8qNeLULyOIpMgfhFlwWY3giZ6trPUXMmQVpiX30v26MUAQhRiL/SBYsluDH/mZSFldWqBf42tc5wAVokH2kYrWJgVEqEQ03bPBeBQo1MHvVt8145Qdcsq/rP528Hdt7lwKT1+9FAmbMQXRf8DftCWWbjzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=kt5UdAiU; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="kt5UdAiU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=St9tHSZzfDXYzrB/rouWzdlJkubowTv6NS6nJVEwL8M=; b=kt5UdAiUnjIBcVwIWrpGXNvvLx
	z7/KxNQU1keZTR8uquNUHY0vi+vbQpbby0SseTjpcxOFp4hxLLEilQfgpltLCMONymrOLGHItRwWY
	nBXYzM3IYHSHy5d4Wt1Do1ePBmxvgzsD4pEQy5b7l/e6+a6MhOznp/9Wuhl/jb1O7pQSFktgjqGdO
	n5r1S+BSIcrxAd4VQ5Bg64RrYEOtCorC21E8j0bN7vRMq174J6RT9F7i+td6aBYaiemt4N2Bk21FG
	yMZs9tGwkXJY2+EcbKm7/N3NE+JtmTSswY9HPFjK9wooylt1RqbEWHBbWiRskXjvpo4d5w76b0Cv1
	TrlkNJyw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wbg9Z-000xIZ-24;
	Mon, 22 Jun 2026 15:01:37 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 22 Jun 2026 08:01:23 -0700
Subject: [PATCH net] netpoll: fix a use-after-free on shutdown path
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-netpoll_rcu_fix-v1-1-15c3285e92e6@debian.org>
X-B4-Tracking: v=1; b=H4sIAEJOOWoC/x3MQQqDMBAF0KsMf20gzkIhV5EiNv7UAYmS2CKId
 xf6DvAuVBZjRZALhT+rtmUEaRtBXKb8obMZQaBeO9+pusxj39Z1LPE7JjvdzNS/I1v1/YRGsBc
 mO//jgMwDr/t+ADPsJ2RmAAAA
X-Change-ID: 20260622-netpoll_rcu_fix-def7bce1207a
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Amerigo Wang <amwang@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 vlad.wing@gmail.com, asantostc@gmail.com, kernel-team@meta.com, 
 stable@vger.kernel.org, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3308; i=leitao@debian.org;
 h=from:subject:message-id; bh=fi9OKxumYq8MA8wVF41Gx0pkkHxM1ZJyBBe9VTw0fwY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqOU5M1vUuFcVLU5pEzknj66KcmxTFGJceBHXHy
 nsbpaqI1ZaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCajlOTAAKCRA1o5Of/Hh3
 bY9iD/9ERNCq4R8zH2Hnm5Xf/vyAOl6FfVGKCS2slx/brhTK5UgDle6pnuLzfnoir/0tLgEMEqf
 lhu/Ddwir7rSuo+mbHBLZKWwQ4tzgdkOw5ji2K7knJUFeyosNI/4gZQmOjHgTTZMTpw3jaXMoxW
 bm8EDpkfPUnyurX6DZ1xToYeM+emH2qrXILjVpZvaTATLW+uHBRecB1MFKbViutRxM59XpNc87q
 SKPivPxsohNuquGN8p88PDYRw1jPkkGjeLokshWIJ04SfyceIqqZFRP8KjQ1GOHfK9P5YLWS6Ok
 DI02amb5C2YWHbz+NOC/Y7nUhJvnWOQVxxZ5QAEtXurvONnA+uvqNz996YamLcqxUnHSvgdbbr/
 0cSwkxuEBVnutQDiyFgjwGYZtjyFzjZtxQGqSZSsQnMX4yMshJghAAuLs7O9GLnSJr3h2bsG8yR
 4y+SHmr5adhmztXPvAkQ/AS4IEnr6ZkGOw0ud9A7mJDk8r6oEaXIxs9AdLYyq9otPfMOkYnuJ0h
 thEEVw71wBVb548ZLmRSLTVFKyNVgECpUjFOoZI4sAkFVvdj06JAqpGAhLbnte4KfVLNz5Fl4TJ
 A7oBOAmqDOWmtiQD5GgRNkkI6E6NUp4mO+exJsWj6NiEezcjKGBiSrcKWWUy1Pv73dU1zQVEGyZ
 MSDLVx2IRaYNBOw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

There is a use-after-free error on netpoll, which is clearly detected by
KASAN.

      BUG: KASAN: slab-use-after-free in _raw_spin_lock_irqsave+0x3b/0x80
      Read of size 1 at addr ... by task kworker/9:1
      Workqueue: events queue_process
      Call Trace:
       skb_dequeue+0x1e/0xb0
       queue_process+0x2c/0x600
       process_scheduled_works+0x4b6/0x850
       worker_thread+0x414/0x5a0
      Allocated by task 242:
       __netpoll_setup+0x201/0x4a0
       netpoll_setup+0x249/0x550
       enabled_store+0x32f/0x380
      Freed by task 0:
       kfree+0x1b7/0x540
       rcu_core+0x3f8/0x7a0

The problem happens when there is a pending TX worker running in
parallel with the cleanup path.

This is what happens on netpoll shutdown path:

1) __netpoll_cleanup() is called
2) set dev->npinfo to NULL
3) call_rcu() with rcu_cleanup_netpoll_info()
  3.1) rcu_cleanup_netpoll_info() tries to cancel all workers with
       cancel_delayed_work(), but doesn't wait for the worker to finish
4) and kfree(npinfo);

Because 3.1) doesn't really cancel the work, as the comment says "we
can't call cancel_delayed_work_sync here, as we are in softirq", the TX
worker can run after 4).

Tl;DR: queue_process() is not an RCU reader, it reaches npinfo through
the work item via container_of().

In reality, we can improve this cleanup path by a lot, but, given that
this is targeting net, just do the sane path:

1) set dev->npinfo to NULL
2) synchronize net / RCU
3) cancel_delayed_work_sync() any new worker (that potentially showed up
   after the grace period -- and should exit soon given they will see
   dev->npinfo = NULL)
4) then rcu_cleanup_netpoll_info() -> kfree() npinfo

In the future, we can do the cleanup inline here, and don't need
npinfo->rcu rcu_head, but that is net-next material.

Cc: stable@vger.kernel.org
Fixes: 38e6bc185d95 ("netpoll: make __netpoll_cleanup non-block")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/netpoll.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 229dde818ab33..5765015b40720 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -634,9 +634,6 @@ static void rcu_cleanup_netpoll_info(struct rcu_head *rcu_head)
 
 	skb_queue_purge(&npinfo->txq);
 
-	/* we can't call cancel_delayed_work_sync here, as we are in softirq */
-	cancel_delayed_work(&npinfo->tx_work);
-
 	/* clean after last, unfinished work */
 	__skb_queue_purge(&npinfo->txq);
 	/* now cancel it again */
@@ -664,6 +661,14 @@ static void __netpoll_cleanup(struct netpoll *np)
 			ops->ndo_netpoll_cleanup(np->dev);
 
 		RCU_INIT_POINTER(np->dev->npinfo, NULL);
+		/*
+		 * synchronize_net() does not protect the worker
+		 * (queue_process() is not an RCU reader). It fences the
+		 * senders -- the real RCU readers -- so they cannot re-arm
+		 * tx_work after the np->dev->npinfo was set to NULL.
+		 */
+		synchronize_net();
+		cancel_delayed_work_sync(&npinfo->tx_work);
 		call_rcu(&npinfo->rcu, rcu_cleanup_netpoll_info);
 	}
 

---
base-commit: d07d80b6a129a44538cda1549b7acf95154fb197
change-id: 20260622-netpoll_rcu_fix-def7bce1207a

Best regards,
-- 
Breno Leitao <leitao@debian.org>

