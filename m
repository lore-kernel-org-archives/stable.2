Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148884DDB4F
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789659620; cv=none; b=i0BuSzupzZUaE5hw1YBAeHSXep4SPt5QOA/OJuBYnWOaVqiMY2uSCeq5UI5vi0b1Kxh2hxrBgvRaza763uJ7x9nQo81w3ub/SA0B4RQbsbL6Vv8kXxFkSUoC1zWxzEpkN2gzc7A9FtxdarbtfMq8JeAwAUkUQMxx9t9RRayqXwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789659620; c=relaxed/simple;
	bh=KzbsMfT9mDqqgshLhXJ1nuoPk1e2OxZC2YnocBIcZew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jqvq/cEY9ZLGntDaX9WHh0Lz0BsTnTlVprB7ewpD47eZnjBJzqUgUVcQ8nWAdF30NObvvF05rNL46WoGYo4GAWt/rqjhkf9kE3I+3NmE/nWRhk1by4UKvap9WlJAwIORwkXSPTvvyGkF25Ljsn4nnXUt8fQX7mCOND3N2amj5DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhKLrtlN; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhKLrtlN"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469e211a3so840636b3a.2
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 08:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789659609; x=1790264409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/BLueBpn8GLWCUZRyZrIy9LgmAKje6FNvcB8D0aXHBE=;
        b=AhKLrtlNwMOA/EVggQliESgZgQjHYLZZmJ7I8znC6UW8X8vdLAfJY5lRF54W22ieAh
         oEIJcbODiSTF060rx2ZLVIP+D34SByHxD0/nWyOH7qZrvq67fflbbVshzIsNGkuFC3a5
         Xuo2npM8sdAwMGQrqiPCkRLRDjdVU1yzqrR2oOiP4HcwXCuZgUbGzi4eNyWELsMrjEp1
         k0J4PbpNoCx/YuU4/VW+KCwXCUlFVfOrg5dqCtGHJT53QXPF2oq6EYBBpRmpqw6u5jBN
         vgWag+tmHW3/Mgoc+5cBUAVW2Jaf6cUCTqem8dXKz8WZGF1s8mqxSZ5js9JX5x11Z18d
         9ofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789659609; x=1790264409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/BLueBpn8GLWCUZRyZrIy9LgmAKje6FNvcB8D0aXHBE=;
        b=wpfcnZka+PhfyipJuP8t/KpqUhj4R/5P3yFXcn8lEf84XoQMMSmPES3lA0kHorbupA
         A0sHmPeQq7TbN9b2UOUJXBHnr0IdBf+p0z8oMZJPsUmxWtROwgjm4quLdfWhwHdEjId5
         QTssg4xKChxJI3oEeyENeUy+wd4Ahfx6taNMkanz+KG4FwMqWZu36II7R7gHGXn48UVd
         f3mvDTgCi0A/1jkZvtPcxZQiWV0WNHwVF28BKPhp41TjsLwCU++tUcIDBE1eKFSTfe06
         LOYi1cS59tQDBB058PKm/rwzVKj77Tf6J0Rs1MncaMUayulnxmqYlmBLLgiwDMLi6acU
         abnA==
X-Forwarded-Encrypted: i=1; AKwUvBwkgj3Ew4GOevvF7gz/7KRXF5oioVagnAnwBDrmu1VAf6ckyKomGTo+Li5bLBLRtL+WtuM8MA8=@vger.kernel.org
X-Gm-Message-State: AFuF++njdl4CNPcOlNcnGtP23wReCaeRyWcKrtjaoV6Uu3eUrvDEA4GR
	W1W4vhhR66WThgklUJV2dI4ZVFvbWer1OqY8JHCI7ZV3f4frRPY+AQK1
X-Gm-Gg: AYBFou0jEdFi2o+grSJlHzDNL1wbr4PaqaPjyLetRw+2KlNWjk5DP/2qx+kKwQnM03e
	GUrzhZ8R45saoDZSch65s2PkR2WVlOoYXCfGcaJZTeJVsihZ8EviZFyvFNKFQB53287hgCxrByj
	gCcenxqYgpyplzsM4yq8EmxgEitkCIQC4AvwbMmGpW7LyyHImNanKea9jjVdqG/fj7uAFr6GXjj
	8CB4rcKI1VMNEtCsyOE3kFUJAg1azVBBZjm1xkOfgc0B2c8VBtC74KujRkTsrmpq7D6TwvsYJEm
	Yaz/D30WmLn0bhjYrzPsFdwWnOlB/PzQxKtErFlR6zciuQyG9grAwV8PTFFaaplorqFWYHeHEUB
	HskOM+ygzwWnhZfUWQTMjpY39eziccBidP0bOGY3BtA4VKxU4GoXU0/C1uN42hiHoMzVEVjd0U7
	ptt5p0iCIqj3kw1DswPUCkwLEeowQdtO5tRVOSA6fvRMwXr3N3aRLct0jedqnyF43rwViGy1BfY
	pP8BA3xwZhc8LXBRREzjiSIgBmoqrOl
X-Received: by 2002:a05:6a00:1892:b0:869:4d90:a0cd with SMTP id d2e1a72fcca58-8723a5a7c3dmr15557312b3a.16.1789659608898;
        Thu, 17 Sep 2026 08:40:08 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50abb1776sm3467697a12.27.2026.09.17.08.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 08:40:08 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	co+65e5c76b187f08b2@bugs.sh,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] veth: manage XDP program pointers during channel resize
Date: Thu, 17 Sep 2026 23:39:25 +0800
Message-ID: <20260917153923.904124-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

veth_set_channels() tears down XDP resources for removed RX queues
without clearing rq->xdp_prog.  If the program is then detached or
replaced, those queues keep the old pointer after bpf_prog_put().  A
later channel increase can re-enable NAPI and run the freed program.

Clear the program pointer after taking an RX queue offline, and publish
the current program only after bringing the queue back online succeeds.

  BUG: unable to handle page fault for address: ffffc90000256048
  Oops: Oops: 0000 [#1] SMP KASAN NOPTI
  RIP: veth_xdp_rcv_skb (include/linux/filter.h:779
                         include/net/xdp.h:696 drivers/net/veth.c:820)
  Call Trace:
   veth_xdp_rcv (drivers/net/veth.c:941)
   veth_poll (drivers/net/veth.c:986)
   __napi_poll (net/core/dev.c:7787)
   net_rx_action (net/core/dev.c:7850 net/core/dev.c:8007)
   handle_softirqs (kernel/softirq.c:645)
  Kernel panic - not syncing: Fatal exception in interrupt

Cc: stable@vger.kernel.org
Fixes: 4752eeb3d891 ("veth: implement support for set_channel ethtool op")
Reported-by: <co+65e5c76b187f08b2@bugs.sh>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/net/veth.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 6ed3ee81153fb..ef7624bc2c0ec 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1247,12 +1247,15 @@ static int veth_napi_enable(struct net_device *dev)
 static void veth_disable_range_safe(struct net_device *dev, int start, int end)
 {
 	struct veth_priv *priv = netdev_priv(dev);
+	int i;
 
 	if (start >= end)
 		return;
 
 	if (priv->_xdp_prog) {
 		veth_napi_del_range(dev, start, end);
+		for (i = start; i < end; i++)
+			rcu_assign_pointer(priv->rq[i].xdp_prog, NULL);
 		veth_disable_xdp_range(dev, start, end, false);
 	} else if (veth_gro_requested(dev)) {
 		veth_napi_del_range(dev, start, end);
@@ -1262,7 +1265,7 @@ static void veth_disable_range_safe(struct net_device *dev, int start, int end)
 static int veth_enable_range_safe(struct net_device *dev, int start, int end)
 {
 	struct veth_priv *priv = netdev_priv(dev);
-	int err;
+	int err, i;
 
 	if (start >= end)
 		return 0;
@@ -1281,6 +1284,9 @@ static int veth_enable_range_safe(struct net_device *dev, int start, int end)
 			veth_disable_xdp_range(dev, start, end, true);
 			return err;
 		}
+		for (i = start; i < end; i++)
+			rcu_assign_pointer(priv->rq[i].xdp_prog,
+					   priv->_xdp_prog);
 	} else if (veth_gro_requested(dev)) {
 		return veth_napi_enable_range(dev, start, end);
 	}
-- 
2.55.0
