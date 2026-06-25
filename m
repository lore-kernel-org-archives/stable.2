Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9AD3DE424;
	Thu, 25 Jun 2026 12:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389110; cv=none; b=iSUo4SKcMMF5vyYkluIhMqP9sqY90+rM1lpfco6oTjXbIrrNw3PuOVAVfkifFGcu2yH1/po/2cD7WnON9/tSUNx4aLbin5+iDX2HK4kjD5JY4GSTzKglKSUaZ3sm7DOb4pQ083tbVw4mWa8WB9IhbBHEwyBD7384HOy4HXZON+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389110; c=relaxed/simple;
	bh=wuXWvfKfQYO6/citvaczuoT2qoF6dfMJdKsHw1NA4bM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZkhmWJ7IQRAdRe6wRFHPQvNfdaZA3bGL5my6GDyWB/UGkIbCTi6tIyn/Vj+rNrgFLE5vZSWbBFvkwsvmPLGG6I7yXfAy9PYmOqxRZ9FBagmA0dd5JRYCBVgSciqu7YSqv4Lb4DJyh7WEnkcaKV1887Deuw1a4tP0+edFJsJy/cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=wCtbi7UM; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="wCtbi7UM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=dPExcujj1dHzdJJh0v6ZWHvfvO26Hkf8IPiLlz3Negc=; b=wCtbi7UM8Xz8QDx1Zah6+1hiYH
	5JoOaJm4E+lJW+e/xhrk1Vcle3v/umsexA6PwCyxUw+1USnZaZ0yunL4vMg9W/gBxjy+NvuVEPZUo
	vBIn3uVRJFJFveuCq7DDDzKnfIZ+Rs3kA8kU+Ra5tL+yIhIhZlaIhUHbosZqWFDTH21Y1d2lrHgIV
	eiiJX8u0FCyCBE79vBiubu2y3ra9fMmkeL1mZz/IB/+QxEZRrSYzJOlRYNabJRR9SEAjZCRFdmBef
	xryDl/8t5I8bN3/xlQq265xrif6dFn/s6oPcphR1T7mBmfoU6ow9o69XCyCbv2TW51S0c7ivQPGzL
	Nr3NTjaw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wcipF-003BVH-2X;
	Thu, 25 Jun 2026 12:04:58 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 25 Jun 2026 05:03:18 -0700
Subject: [PATCH net v2] netpoll: fix a use-after-free on shutdown path
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-netpoll_rcu_fix-v2-1-0748ffac1e98@debian.org>
X-B4-Tracking: v=1; b=H4sIAAUZPWoC/3XNQQqDMBBG4auEf22KmaK2rnqPIqJx1AFJJLFik
 dy94L7rB987ETkIR9TqROBdoniHWlGmYOfOTaxlQK1AOZV5SaQdb6tfljbYTzvKoQceq96yobz
 qkCmsgUc5LvENxxuaTGGWuPnwvS67udJfcDfaaFPYOz0KfhKXr4F76dzNhwlNSukHiUBZFbQAA
 AA=
X-Change-ID: 20260622-netpoll_rcu_fix-def7bce1207a
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Amerigo Wang <amwang@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 vlad.wing@gmail.com, asantostc@gmail.com, paulmck@kernel.org, 
 kernel-team@meta.com, stable@vger.kernel.org, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3294; i=leitao@debian.org;
 h=from:subject:message-id; bh=wuXWvfKfQYO6/citvaczuoT2qoF6dfMJdKsHw1NA4bM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqPRll6A/GhLZbgzzU1BjhCa4B/AtI6Vv4X5OWX
 3Ketjz62QiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaj0ZZQAKCRA1o5Of/Hh3
 bbSJD/985V2K94Ml5Hzs3D8owCjx7heHM/WiQKJW6MsaDTuZXFjTWeLQPtuMIhhBYVVIXiR1eS6
 rjXHM1CB5F1ZKJZn91mjt1SG4pHIMl9+jzZSJn623DidgT9yPuLpb440VNyi1tjt7nMwHX4m6LN
 d8D5bXFOzTZ/aRmJ26AlZ93wXfVu5/RryP9fEFbFlq//Sn8rGBrazprpK48JvaP1haozEtSNWLi
 Yy6eEgdYdf5W6OZ7IJOvkugpUn2FHxBCsmtwnVd9fgm8SETu7uXR4ircdqhE2Tz6ZpFxe86sa1I
 1HBC1rnJOLD7rdq+1G0WuSZjrBVUcke+oC6t+vk7aHvDl4PzXA7Yk1w8QZop0ZT9m+yOkjBaQol
 uerG1EFISg0BmfCkB64ZzYmZKM+Z7+A4bc47dCKj+oMeLVLVpaIcQIlHio4SH2ylCjZpnbcRLoZ
 W+0pNbdN32S3jXAaCvwJLqlaIemfRxe3l6AUtDNngtxAvexVx0HTS3qhlLEvZS9rEA1OERI550+
 faU+IvIxiTyKh0jy0KS/VydLXSWGSHPiXnxq+kNoDNzvZ4TzXY69QnUyw/mUXnJ2qpLU11n+rA4
 Mun3fCeyUaby3Cuoig6utiXLUdpIgHfBYJL4U0ndWtHvHcGPybgp0mb3w03JG8COMFCaC3B83Yt
 E39rzpjAklNjclA==
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

Use disable_delayed_work_sync() to ensure the worker is completely
stopped and prevent any future re-arming attempts. Once npinfo is set
to NULL, senders will bail out and not queue new work. The disable flag
ensures any in-flight re-arming attempts also fail silently.

In the future, we can do the cleanup inline here without needing the
npinfo->rcu rcu_head, but that is net-next material.

Cc: stable@vger.kernel.org
Fixes: 38e6bc185d95 ("netpoll: make __netpoll_cleanup non-block")
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Remove the synchronize_rcu() and keep cancel the tx_work
  before call_rcu(). (Jakub)
- Link to v1: https://lore.kernel.org/r/20260622-netpoll_rcu_fix-v1-1-15c3285e92e6@debian.org
---
 net/core/netpoll.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 229dde818ab33..96d5945e6a30f 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -633,14 +633,6 @@ static void rcu_cleanup_netpoll_info(struct rcu_head *rcu_head)
 			container_of(rcu_head, struct netpoll_info, rcu);
 
 	skb_queue_purge(&npinfo->txq);
-
-	/* we can't call cancel_delayed_work_sync here, as we are in softirq */
-	cancel_delayed_work(&npinfo->tx_work);
-
-	/* clean after last, unfinished work */
-	__skb_queue_purge(&npinfo->txq);
-	/* now cancel it again */
-	cancel_delayed_work(&npinfo->tx_work);
 	kfree(npinfo);
 }
 
@@ -664,6 +656,7 @@ static void __netpoll_cleanup(struct netpoll *np)
 			ops->ndo_netpoll_cleanup(np->dev);
 
 		RCU_INIT_POINTER(np->dev->npinfo, NULL);
+		disable_delayed_work_sync(&npinfo->tx_work);
 		call_rcu(&npinfo->rcu, rcu_cleanup_netpoll_info);
 	}
 

---
base-commit: d07d80b6a129a44538cda1549b7acf95154fb197
change-id: 20260622-netpoll_rcu_fix-def7bce1207a

Best regards,
-- 
Breno Leitao <leitao@debian.org>

