Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134651632E7
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 09:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790413252; cv=none; b=CtToOFABe9MRinivFKANd+b7DDUJi7L06uXXdUOI5cxt0c8UE3uGv2E2tvcMM8srddMVxWmV6XfvF1TLEXfRqr60DB8BXvo23YVeHrnRmVCdLNdkx/p0PMK5HK0n3jpDtxVf3PXTDW/nRaFZB1rY6K8XQi2O5JoBGS6I0Egjk88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790413252; c=relaxed/simple;
	bh=4cRsFsDt6Up/vvP7T3bPTI/3VbP0v8lPFsiVG9KdPO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kolMOdaBqDjk53SLohJc3JDTAhoaEBHEnK82ifpbp14+UkUfaNgRTJVNthACxYl8USpNMKBvNs6EUjaxVwVqNFtawEv+a0SrY+nfmZFzqDGLLtPFOGG2HMKHQHs0AE13kCkrmMDvi8FrdafMfHU/n1oVEaRkNtlleAxFxrz5D7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkpadKvA; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkpadKvA"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-341d0522b4dso2065778eec.1
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 02:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790413250; x=1791018050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=quXvg9Bk9ON8ryc8ejCwrUBsOB74NdxZSH8xzj0H2yc=;
        b=OkpadKvAC5w4gJ1eoVlH3NdcPtjOZ5BfCKZP+SC3eFrD6XvH1OBE4mFOODfGAV0Rx2
         4jt205/YhPyVbV5Bc0TY/t1zC7DEPIM6fKPsvMyYuGJgqmKDb2BlWrLxhX/ombG/5dto
         9kYztlEyR8MByDsnoQylWln1WFTnxAhWUzZ44UGe4/yTTB04KAvqSDgWBeMU3O9mpAsF
         k8p/QFhYKacsASdSMsODBFeQ4BeJz0Ybpdqqwcn3XbXGfwuzL+H/TZgo1qkLGi2PQr12
         7VeOnw71T9u3SRW2yFg97x6kq9pJzOcwJ5SGrnlLw/OVhcPVn8KCHc2Ra9C+MCdwSM5z
         b2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790413250; x=1791018050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=quXvg9Bk9ON8ryc8ejCwrUBsOB74NdxZSH8xzj0H2yc=;
        b=nkb7m0p10XwVzeHv/xFme8NfkNifUwoXQyrqOALMTxAKt20xqvNz0353D8Rl4Bzxdw
         0jP1MjMyuEdxfZTAPvSfUN2kAlcqAviNx5tzoF9ZGf6LO8iLQZc+Fjw9+g1I8PjcVUaX
         Jfb0qRpMcrGxlsnKISAyzrJLselQZrQ3xsjl6tVCwQS4fe5fGJQSCDBJJNsx1ctpIAG2
         UuzGlqxKsV5+Tj9GcDOeDNo+LQ5o4E8/KUVEwJYraXcKMWdDOmMve9rkoOj4dyn3jmLA
         dF22VJ9rO+ifi/NIKUA8B+xFMT04MRW2NkzPfmaIp9DkITNsXuH5ShXOS5FAdYwqLYOM
         BYlw==
X-Forwarded-Encrypted: i=1; AKwUvBygyrYxNdtRZyWqxbYPbNU9qEsHglkaJJjyYCQU51GDvB/tFw4nGMKVec6koK6RERuRD5ILhU0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKN7x/kvbtPRsQktT1JHUqv/wye9436Ahb4M4F5OVn4LxJLq7JL
	MHeEFCSLW5+DRvWnCDH8sS6rtrrZ/N6EaREV3MMC9ClZvZzEZjz1gHEp
X-Gm-Gg: AYBFou2UCeP7BdcpqSJW5QxbT4ohli38P78fNVSmcNxVAomZEFHf/oGpREmy8SyoAgm
	VI5zg70n6ASLt602eMqpFW1ckPpD4NbnboM8pbpRI25V/8MBJs2+sB63k8QWFlIIVVIpqpD63dT
	Se6toU2gZN/BXrtCm7Ixy1VVmTym4UJvTppJ39YGtfH8LJd7pyiUlCpkyEsMjO4K1xFWJBLD0To
	gLoPcN6HWTpsHYf3u3L3q7gZNkAgoT/4FRMqCIJTFfdgTk3lBdh9YMHPFb3CpMDxiVYrC4tUt+R
	lC1LmDaWkBnYD5nbGKAS2o4djcDqXcR83cTJMFTpmyqMrQQDPllFzFr17cK4uNpSQG0eFNEBXRc
	l3o875P7J6WpZU/Q064GNtdM2/NHU9DaJitVMfyqw8VtDHP35of76Ezj5jRqR/AYIBANyQBKXYW
	jF8npni1YDcg5MsA2MceMh/B8llLPgvvmHCBi6MSDmuTZB0EnykAxyjItTak3eT+oCftZMM+moq
	SpU2VdpCBfsyclriblrDbN8w/LRthSI
X-Received: by 2002:a05:7301:152a:b0:339:7c91:21f4 with SMTP id 5a478bee46e88-34273252770mr2697961eec.34.1790413247517;
        Sat, 26 Sep 2026 02:00:47 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144173a2asm13336250eec.6.2026.09.26.02.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 02:00:45 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	co+2cf741c3005abc20@bugs.sh,
	stable@vger.kernel.org
Subject: [PATCH net] net: team: stop reusing skb after queue override
Date: Sat, 26 Sep 2026 17:00:39 +0800
Message-ID: <20260926090039.1714460-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dev_queue_xmit() consumes the skb regardless of its return value, but
team_queue_override_transmit() treats a non-zero result as if no handoff
occurred.  An AF_PACKET sendto() can therefore make team_xmit() pass a
freed skb to another override port or the mode fallback when the port qdisc
drops the packet.

Report the handoff decision separately from transmit success and stop after
the first override port.  This preserves the existing success and drop
accounting.

  BUG: KASAN: slab-use-after-free in sk_skb_reason_drop
  Read of size 4 at addr ffff88800d5e979c by task poc/131
  Call Trace:
  ...
  sk_skb_reason_drop (net/core/skbuff.c:1220 net/core/skbuff.c:1249)
  team_dummy_transmit (drivers/net/team/team_core.c:502)
  team_xmit (drivers/net/team/team_core.c:1869)
  __dev_direct_xmit (net/core/dev.c:4990)
  packet_xmit (net/packet/af_packet.c:286)
  packet_sendmsg (net/packet/af_packet.c:3140,3172)
  __sys_sendto (net/socket.c:800,815,2281)
  __x64_sys_sendto (net/socket.c:2288,2284)
  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
  Freed by task 131:
  ...
  __tcf_kfree_skb_list (net/sched/sch_generic.c:59)
  __dev_queue_xmit (net/core/dev.c:4353,4884)
  team_xmit (drivers/net/team/team_core.c:832,1867)
  __dev_direct_xmit (net/core/dev.c:4990)
  packet_xmit (net/packet/af_packet.c:286)
  packet_sendmsg (net/packet/af_packet.c:3140,3172)
  __sys_sendto (net/socket.c:800,815,2281)
  __x64_sys_sendto (net/socket.c:2288,2284)
  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
  Kernel panic - not syncing: KASAN: panic_on_warn set ...

Fixes: 8ff5105a2b9d ("team: add support for queue override by setting queue_id for port")
Reported-by: <co+2cf741c3005abc20@bugs.sh>
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/net/team/team_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index beffbe450612..59dd94271ff1 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -820,7 +820,8 @@ static struct list_head *__team_get_qom_list(struct team *team, u16 queue_id)
 /*
  * note: already called with rcu_read_lock
  */
-static bool team_queue_override_transmit(struct team *team, struct sk_buff *skb)
+static bool team_queue_override_transmit(struct team *team, struct sk_buff *skb,
+					 bool *tx_success)
 {
 	struct list_head *qom_list;
 	struct team_port *port;
@@ -829,8 +830,8 @@ static bool team_queue_override_transmit(struct team *team, struct sk_buff *skb)
 		return false;
 	qom_list = __team_get_qom_list(team, skb->queue_mapping);
 	list_for_each_entry_rcu(port, qom_list, qom_list) {
-		if (!team_dev_queue_xmit(team, port, skb))
-			return true;
+		*tx_success = !team_dev_queue_xmit(team, port, skb);
+		return true;
 	}
 	return false;
 }
@@ -1864,8 +1865,7 @@ static netdev_tx_t team_xmit(struct sk_buff *skb, struct net_device *dev)
 	bool tx_success;
 	unsigned int len = skb->len;
 
-	tx_success = team_queue_override_transmit(team, skb);
-	if (!tx_success)
+	if (!team_queue_override_transmit(team, skb, &tx_success))
 		tx_success = READ_ONCE(team->ops.transmit)(team, skb);
 	if (tx_success) {
 		struct team_pcpu_stats *pcpu_stats;
-- 
2.55.0

