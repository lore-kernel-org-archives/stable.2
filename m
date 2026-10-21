Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602809;
	b=m+nrfaUXEGIGanb6M6VlYkPtnZV13fSiVBMCnzwWRREFjk80UlfvrJv06g9iC2aXX80q
	 60VVpokB119Czyb1mDPB3Dt8ug3KUA1pvJ/dBQpatEe6r+T+7n8ugipXudHwZ1Ja3OJ7H
	 d8s4vOx8r0YIAKZ2kLmR+gNX+N+nnA+tyr7lTzJGFYZposRtgTIwixfnneBaZwhlRftqC
	 UrZ4YK6eug6AUgzOgTuiA7XS9yqkQO4qLQwAo65xs4F2BbKGW3Bvhr4rdEQdqRs8kYWnp
	 HrDzMtam+ntMZ9DVMww5gxikVMoXOGvz0Fx/RtmAI0+TFGHAbjdw+ksbRJERuYm0FJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602809;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TFjFXEQ8daX1SDzZ+zKTu3JqP3e56krBVno7avFksg8=;
	b=hWCoduKouvRJjJhZq+YU4xf0QWlcMPqscf4Bk1ALbqpiimOXqr5hT/w0uGeiRsPnmQDu
	 dsh7lFbF+dmArYj65/CGE7oHmmLgdJJtOn0k1Syi7vEgYaYlmt/paNISW4vVJ135DKnOC
	 hVbPV1B3ABiFSZheSqzUa/kozVbnDS67x0833oBeHcIf+rAdkYSzmeq6xXVPI0vD3klTq
	 N6jcGzlkhQ0ifMAB8FlESTaInxKBI1tehsjwMbuKXK8Qv2DSgR3EqnuYEGGCH0XaK6tR2
	 1fQExXwojOn5RNitdSK5+TayMunx5mEclDG+W5cd6uEhhDAvpvxxeu+OuhAC2piFMmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=soWqeg8C;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830DC606A326
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 17:13:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 830DC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=soWqeg8C
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36681e85e87so1929377eec.1
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 10:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792602808; x=1793207608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TFjFXEQ8daX1SDzZ+zKTu3JqP3e56krBVno7avFksg8=;
        b=soWqeg8ClTWjGsUdU6T/pu3svwM0Pfxg2zZh/n9lNcDLCmLtKefWVOKifpL0zHAq1Q
         D6LtACxIh9ec8/1K2mp5qmfBvdxKMULxhe/jNV/dPtt5jFHja1SYX0/Qk340szBict3V
         QuZ38mRsn87CyEawQEZkkBVayuKUAZhkj9wst3LID72z3mWvw7f1HlpsHuR4B29d+rrF
         xNjBWHfVxPKiYyPiUwPc9mgdKoaBp28JqcNrF0lORvsQqW6BEXnCaE6rPU0vEBprTg33
         XKoK9jeF5X1sV46+j/eReNTBzPEMozvHY6FOKd82RD7CTFY/OSL1i7R6qF84ZAZO5HpP
         YEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792602808; x=1793207608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TFjFXEQ8daX1SDzZ+zKTu3JqP3e56krBVno7avFksg8=;
        b=0mZUtD+SdrlNY9AhMpweuCnkNYoyeLW/8zfxcMTFcvx5kYAYxRI5h09nlzlFSLQvrq
         0L55nD41cVlSTkmUxxabC/+CFy08MkD+lgBtsw3lsVHMA6XL0sfZrt1dQiElCIf++DKy
         8ME1/EwoqwnxKm5phVO11iRwE/V9xeXZoyRyqpCOLn2mvAFyxujB/87rXIvL2nYFVcVm
         0yWYhfU14Wz8Bx/7fQU1FyRj9VNgKFpRNs6spk/TkK84n7mwoaoZ+Ha8YI8FE4FSbqGZ
         XcyPaQV/JU8gu4syPIlOolSwXhXI95u2ZrqG1HCWFvACToM71c6mbSwobeza8rlmtg1s
         NNGg==
X-Forwarded-Encrypted: i=1; AKwUvBwQTLCPaJAYGuz87s5MJQI7G5TFOVq3JkrJF9lC6g/o2BDPFBQ9I7pq48EbOQ/u59gvTy1Bcuc=@vger.kernel.org
X-Gm-Message-State: AFq9FYI4vs8rmSdguoeE/qOkX9m82zHSrkZVLVxEr+nEtH51ElhZFeHr
	bjS9Hz1M1Okqpk8vhyI/+po/5C9WVcoqGJ/iJzBCG3q1+tCFnUuebfmjUynF7t1QjT5zrA==
X-Gm-Gg: AYBFou1SST99bUZZMN6hL3h7RyDgXrvi513RSbUxas9Rkj4oQxvzIMnM4SyyKEKHNkW
	rY/rXssX0aaZwjkBeljemhl213bhV/r1talRvPAyUSXkxbj/n8+3PQve7Rh/+s0MhHM3DcX1tFC
	JRWuBC91IdfpsGe2Jh5BaeMFNe8hxc3ACqVEZJevaWGQgzNQQlbi4eCZBAvWgwd4ni+H4ELz7pC
	UQ/7Yd8BbqDC8Ezn8zc8Osj8KxCsTW+FWAawGjLN967tzX1Btc2Wsb3XpyIy6klHFo5rNPc8rHy
	I6lR/AkHS/Ez5ASdq3JR1WDfKIrFDOG+uBmVSTw32OdyGswW7cJ3SAq6kF8YG1VWzyuikvg+ISe
	LvvYx5rqPN2jnJAQYuqTHilQ7EexwyDlqaXad5Ma8HlpLNvNkexKa8F8AjR6XPtefbFCSqdjhRd
	T3sqfxiDK1FAE9e/Yc9uLCvmg5UThT7osdPvkSaZHPFXfSVQeBHAtEx0Vt6O+uTd/h4e06188H0
	urHBHyBvA3ErAKQdI+tqO1O79frdh0hNIHStazCUmrWSRGRfNhGBpadEZ3s66tyFWUFk1gMVzVz
	u5H7PCuAvKlWsG6HJqO42PeGKKBuoQ==
X-Received: by 2002:a05:693c:60cf:b0:353:8205:8558 with SMTP id 5a478bee46e88-3674b82ad86mr4897440eec.5.1792602807507;
        Wed, 21 Oct 2026 10:13:27 -0700 (PDT)
Received: from Terra.tail0ac356.ts.net ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3674198f1d8sm12947635eec.24.2026.10.21.10.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 10:13:26 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Ursula Braun <ubraun@linux.ibm.com>,
	Karsten Graul <kgraul@linux.ibm.com>,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net/smc: reject CDC messages after connection teardown
Date: Wed, 21 Oct 2026 10:12:57 -0700
Message-ID: <20261021171256.166870-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smc_cdc_rx_handler() drops the link group's connection lock after looking
up a connection. Concurrent close(2) can then set conn->freed and release a
registration-failed receive buffer before the receive handler obtains the
socket lock. The handler subsequently dereferences the released descriptor.

KASAN reports:

  BUG: KASAN: slab-use-after-free in smc_cdc_msg_recv (net/smc/smc_cdc.c:376 net/smc/smc_cdc.c:431)
  Read of size 4 at addr ffff8881064a4720 by task kworker/u48:2/233
  Workqueue: rxe_wq do_work
  Call Trace:
   <IRQ>
   smc_cdc_msg_recv (net/smc/smc_cdc.c:376 net/smc/smc_cdc.c:431)
   smc_cdc_rx_handler (net/smc/smc_cdc.c:503)
   smc_wr_rx_tasklet_fn (net/smc/smc_wr.c:445 net/smc/smc_wr.c:459 net/smc/smc_wr.c:498)
   tasklet_action_common (kernel/softirq.c:961)
   handle_softirqs (kernel/softirq.c:645)
   do_softirq (kernel/softirq.c:546 (discriminator 19) kernel/softirq.c:533 (discriminator 19))
   </IRQ>

  Freed by task 209:
   __kasan_slab_free (mm/kasan/common.c:285)
   kfree (./include/linux/kasan.h:235 mm/slub.c:2748
          mm/slub.c:6508 mm/slub.c:6801)
   smc_conn_free (net/smc/smc_core.c:1244 net/smc/smc_core.c:1283)
   __smc_release (net/smc/af_smc.c:322)
   smc_release (net/smc/af_smc.c:361)
   __sock_release (net/socket.c:735)
   sock_close (net/socket.c:1526 (discriminator 1))
   __fput (fs/file_table.c:512)
   fput_close_sync (fs/file_table.c:617)
   __do_sys_close (fs/open.c:1560)

  The buggy address is located 32 bytes inside of
   freed 128-byte region [ffff8881064a4700, ffff8881064a4780)
  Kernel panic - not syncing: KASAN: panic_on_warn set ...

Both smc_conn_free() and CDC message processing run under the socket lock.
Check conn->freed after acquiring that lock. Discard messages which passed
the lookup before teardown. This keeps the existing lock order and prevents
access to receive buffers released by smc_conn_free().

Fixes: a6920d1d130c ("net/smc: handle unregistered buffers")
Cc: stable@vger.kernel.org
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/smc/smc_cdc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index 32d6d03df321..499a2473b79b 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -428,7 +428,8 @@ static void smc_cdc_msg_recv(struct smc_sock *smc, struct smc_cdc_msg *cdc)
 {
 	sock_hold(&smc->sk);
 	bh_lock_sock(&smc->sk);
-	smc_cdc_msg_recv_action(smc, cdc);
+	if (!smc->conn.freed)
+		smc_cdc_msg_recv_action(smc, cdc);
 	bh_unlock_sock(&smc->sk);
 	sock_put(&smc->sk); /* no free sk in softirq-context */
 }
-- 
2.56.0

