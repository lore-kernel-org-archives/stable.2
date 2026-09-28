Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD1244AB62
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 06:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790577786; cv=none; b=X1727gKO4QPLxdlidIUrVNhfjz05XSQk2cPRzqq+sXGkzF+0u8fJMWPJYmjP45ikUCuuYlPe7EGDiChJk9okJDlBJ9OaZSjZZ0JCNA/m8Tyqu3BuS2/Gc9vMb101P7RFrPPWh/jvDcbIjanbMe3oFgD+nqAraXGal3S/AMOiHZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790577786; c=relaxed/simple;
	bh=y/c3vuZT9JK4EGUVD5FlxfoGZhyoXAmopRCdzFOZeII=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ir00y/YZMwbNdtqGkha88MQz/khMoQaolADlMARp+6hAUEUk3jmBvu+eJHx1vfU6aQXqqE2Lur5c9zFHHYQvXsoh06uq9kncf4mQ/gCazyTV6UGvA2dH7SrDaDip6tQ+Opw0oMUlAoa+p+d6gj/AERwNLEY70WZpnE21YJZ5C+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SseIMWDQ; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SseIMWDQ"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48884b0219bso992779f8f.2
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 23:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790577779; x=1791182579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EleACgwDvShW2Hh8e1MDeVc2Sd39pZcCSkJXUD9MqEw=;
        b=SseIMWDQCk4kbVZrH/rV6/+CGE5BhaLjdwGVG+9R1HAqLdyJ6V03zEbK/S6i9QSM50
         ZvE+wCWkUbleTzjlW8exzYCPUhyJba0aXfODulFcCUdNIy11aqbMCV9GE0H336wP1F5d
         yP60YRUZ+nIM8+JBfHuJXQ4xj9EoJiwwDMxcwyZHIQ581Nzpi30XLWHGb+v5mWfDx572
         VwbsKI11Vm1KydrdmvWJvNXMhRhwYcpCLjpfuZatGkITvEC4GiJswp7IeZFVR464MLqB
         TZH3Q41rV8XO1obfUJDpNNiNDrvCUDD5SZWmoizO+Q2kz736lvyOyT1X0XqWz5h4kwkT
         9Vfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790577779; x=1791182579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EleACgwDvShW2Hh8e1MDeVc2Sd39pZcCSkJXUD9MqEw=;
        b=YH/x2zPKgk/CjSYGa+dM9H+ZrvZUtRoeREaOf1KydPnpPtq29mQwOh9RxFlF2FGPDe
         Nfn8CSeIIdHvooCa0ObJmZwtYKA1a9IKTH2z5QVQbh1tCgL2siKrtkWcRpAVZGSXO9Hs
         xJvrhejm/nI0XnnqQofScFVkxkXm0lHc2djt4w0gcxYX/jlikuUKhEkUdVzX74tr8ucX
         h3RXntdpjtmwRU5NvR/qpTpAU6QecOuxPXzWHsBYSc1/B5qEfPMg+rtn5VoDAhItuy2x
         EMsa6ELNcsBGXIykH4q5pnFRwh4KT/KgdHy8FPMdl5SlNwM3W1zNA6UY1coLCFAz0U8Q
         9fkA==
X-Forwarded-Encrypted: i=1; AKwUvBwbRTSyZjubwmeDy1LIhjoeTSp4AV5aRZGcgB0qulEzq1FxT8bkd2qXkHMYMnYsS1jJdeIyQgE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKBGmqwff5hPhRAL4hGjNj+5C0vqxdwOHzjlfNLFnK6biW41CIq
	aXaaHCXy/IWkP/VdQX26CRlk73WZFK9r+emrKu+yVXd6isCPbGKPCX27
X-Gm-Gg: AYBFou2LBzgKYy/BZgKOQiIMxR8R5bMawhhvaBYWLvQlRjQKplLpQkiVI9IqiR9Cmoe
	JPqwuhbmW4V4EQHLqSHuXeLdiQfq3vXXYOFpN96Sl/rpAEQypwODvzVLzyy9Jxx59YuirFIGipl
	WFIplinShPAnb8ujMCm4QxdyG1QDW27jP3jnOPuHV9dhmfyZPsCuyasiO7FIKU/ThPH6pkGefu5
	npePHBHQFS77cMnJudBGV7EM8y0db9yOEpL2GkshyixOV1XAJbgqYus5ps1bIGgtqt0pC/O/m87
	Ax16/lp6doIx1eXTd2unaoES43i2kb4n3lMGRo39o8OeVHHwx4CALtYofhx6x4AuysdBoTzq6cD
	kN0CWUnynBKYYn48NO1ZMyg81SQ7UX8MrNk6vlJI82fv9uWAJnNFZgW5H3XFjlHEtKso1w/NNH1
	CggfG0JdVY7MJ7U8rCkAF/ga1O94fqzqrUZD9vpeSQYJO1wj4HKnm1xJwPnHdUGK5wkmFkIwaMi
	nFJzippT4EVhwG2imvPcI8x1QkrifuVOTnqDkSPiEnuo1rbNmBQLTRkDo1g5L0WyJvLAr1YTSkN
	KTnZSFs2Eyeb8Veq12fR/o0FlKNT3nNh9K7DRU5JDJ9FHOC8gUb5gXi/eIFmOLkYCCxl5vzfFwk
	04EJ3IQ==
X-Received: by 2002:a5d:6f1d:0:b0:487:1102:d697 with SMTP id ffacd0b85a97d-4887d9f99d4mr17976537f8f.8.1790577779202;
        Sun, 27 Sep 2026 23:42:59 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-acba-a601-4494-3582-465b-0eab.310.pool.telefonica.de. [2a02:3100:acba:a601:4494:3582:465b:eab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a30b1dfsm26283196f8f.4.2026.09.27.23.42.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 27 Sep 2026 23:42:58 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: netdev@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH net 2/2] netpoll: avoid blocking on the transmit lock in queue_process
Date: Mon, 28 Sep 2026 08:42:39 +0200
Message-Id: <20260928064239.32456-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260928064239.32456-1-kmehltretter@gmail.com>
References: <20260928064239.32456-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

queue_process() disables interrupts before taking the device transmit
lock with HARD_TX_LOCK(). The lock may sleep on PREEMPT_RT:

  BUG: sleeping function called from invalid context
  in_atomic(): 0, irqs_disabled(): 1, non_block: 0
  Workqueue: events queue_process
  rt_spin_lock
  queue_process
  process_one_work

Use HARD_TX_TRYLOCK() instead. If another CPU owns the lock, put the skb
back at the head of the deferred queue, restore interrupts and retry
after the existing HZ / 10 delay.

Fixes: 3640543df26f ("[PATCH] netpoll: fix netpoll lockup")
Cc: stable@vger.kernel.org # 6.12+
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 net/core/netpoll.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index e0cfcb05468e2..a3c94f0b3f764 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -166,7 +166,13 @@ static void queue_process(struct work_struct *work)
 			skb_set_queue_mapping(skb, q_index);
 		}
 		txq = netdev_get_tx_queue(dev, q_index);
-		HARD_TX_LOCK(dev, txq, smp_processor_id());
+		if (!HARD_TX_TRYLOCK(dev, txq)) {
+			netpoll_txq_queue_head(npinfo, skb);
+			local_irq_restore(flags);
+
+			schedule_delayed_work(&npinfo->tx_work, HZ / 10);
+			return;
+		}
 		if (netif_xmit_frozen_or_stopped(txq) ||
 		    !dev_xmit_complete(netpoll_start_xmit(skb, dev, txq))) {
 			netpoll_txq_queue_head(npinfo, skb);
-- 
2.53.0
