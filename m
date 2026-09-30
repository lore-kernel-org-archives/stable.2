Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A799C3EA957
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 19:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790796091; cv=none; b=mF2YP/rrp9fJ0j2BdDGfSGima1UnaPmCy3QJPRyB0sfLsxVJ9X9gV+tTZOS/C6g3NnJtT8NY2NRSe2hVlheDRGRk3jj/Ln7AIRtuIo8EfgF53HPI+bkhhpIwJt/4YTtsrkPeHL19KlQI8z/H29g8kanhRzNq9uC5ZdJT0lMQCiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790796091; c=relaxed/simple;
	bh=uZKo3LvjIw/jQo2DcJhlrJtg2qwhUGJRKYHVpUos/Og=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rXfjEiNUJOtOB/ftyUhS7EmZB5PZBM2fdwGQaWaTwH0wCGOYQX+Pf32JL4q1HeMnWysiAJku+65ZpFaLXGvYxU6RgpaVeNjhSbvY6OVul/A+QN7rhwu4pshgEr+72INeZeWJ60ycO+y1fhrm3pFywyuiDH9NVTBR0Sid3AwCsPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hqnxm1dA; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hqnxm1dA"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d822dso42642005e9.2
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 12:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790796088; x=1791400888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SbYiN1Bd29zaEpgdDuLGxrhXKVFH4VSvfh3sFDNw4+w=;
        b=Hqnxm1dAEAEa677uYh+YJ43K0Mn++1DKoDK4qXLcbbuWcS+jlZ/m34iUXIFccGiZjt
         4j5yeLbpr66Aga2ReLQa/nI+9X/B26YpfT9z/Xn7C6NZ64HlzNmrl8S3rHC6X7Lc6cop
         HGeOYc46AGQFIDS+2dmMz4pQ+r1T7jx+RSCfLLLvTN+Bgj4lbOON8xXqPTg1fxkrvpOg
         7U8c2QAYD7eljHuCtkTfb/mqarM4XloSEt9uxNr4ctl0xYZ4Sn7orXfa/QIgFOnlbFCH
         2TyrlOmmO4NWytRCCaS/dd4dAmhRGY7Vjker+yAxZ+lo6GQAdA96Yr1AxgfKd8Mbr3sU
         e/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790796088; x=1791400888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SbYiN1Bd29zaEpgdDuLGxrhXKVFH4VSvfh3sFDNw4+w=;
        b=S+2Ia50hfsqChrfRWoQpT9Z3+pmwcS9EgqM7ZaBI6kb9SyAsA4vUd8t9xNJLPFbU3G
         1QmSOX1X7z2dwax8l0ndQwIaMF8OJ8ym6NAxHG3dIVh8wsDu2eGa8WUsaO1slRY3sBGa
         KeqexLb0L2TZ9BQnAlmDc5qrkcq1263uNlEvbevEHskFE3lOvxw3E+YI46/8R56YGwfq
         xiOa8CeY8WLH91yR9obj51dhj9p96xKFPyNmzdIZEtKExX8sIAERdCSUixAQS3+JQX3M
         G160D92QoAEmqsD/DmJ0RLOKrFNnhUSVtgQWhaIDeYLH19vVcH+bAmc1dEmHORf9SvDt
         GYSw==
X-Forwarded-Encrypted: i=1; AKwUvBy7Py4phQuehVM1uUYYhTLcFvhn+Z1/yM6Ri8Z1uDbMF2l9/foIJOU5cieC6fkCCNPtaXIx328=@vger.kernel.org
X-Gm-Message-State: AFuF++k/xyVN8fb+WF+NjFpH3xMgriaYivwPSA2xB9gn+fvFCpKGLkeA
	JQwc6PwucnUD0x6AXDsOjbojjhENnCAIG7VZfY0znvvzy+dN+J0UhFakYMawL2wm
X-Gm-Gg: AYBFou3DzWiFql/FyMlzw8Fw4/6gLZfmonyoYdoa8YSphuB+RhK2c/sisI1srxpyj7L
	kKiNCime0A+O+zBcUIFlW+VeZcUF5ijOtZu5r35BFV07TxjYXYcw9D5DrrWvMkgOvwpndoCOjys
	POuoAonICGR0u2nJeY3OtYyxA/AJAvrrXo5WelpYXzMTHD0aWZicDRbd1LARdz0MlgPEQrB/es3
	EZyeJWlyb/iC9kNmV2N+xogsYnAZwB5JAMroMqak/fa1ypor+8nKcav7m/6DOl4J1SAFSmT7q2z
	1fnyCF2tUz1RV2txrJljZkt5oNhmkTyviqnUxTTb0/lIh1VYI+rj1RRLLvRuOGQ8Z6HV8qGegNq
	iPbRZ6OmhbPehBwvd9deBs999RPd9J0ND59h58yuClcsPLapSFBMmV8h0OccbBuTxU3gjvvZmUe
	gyXUJEj/bsdfxaAiAag9KrjC8wV2xiQJncbaTk814hplunZLPN+23hT5xS1z0VroPtGoF0lVmy4
	yNmkWh5Srt+lEyFBb5g8bvDfQAFJBxlUTL2S0EyZlaz8SIulfRf+Bdd++Bc5o7EMsEFU7j3QGMf
	h11Vdg1XZOGJP9ia1rhMPo1CJz7djMrUzI+AfjxDGWsR9ImN2qdhVUtA5IxVFbi2xGj28FFmX9w
	c
X-Received: by 2002:a05:600c:4687:b0:4a0:3a3:33e2 with SMTP id 5b1f17b1804b1-4a01adde08dmr42117895e9.5.1790796087622;
        Wed, 30 Sep 2026 12:21:27 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b2b3-0101-b51c-a607-3dcc-3979.310.pool.telefonica.de. [2a02:3100:b2b3:101:b51c:a607:3dcc:3979])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f9248ccsm3513165e9.3.2026.09.30.12.21.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Sep 2026 12:21:26 -0700 (PDT)
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
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH net v2 2/2] netpoll: avoid blocking on the transmit lock in queue_process
Date: Wed, 30 Sep 2026 21:21:03 +0200
Message-Id: <20260930192103.62973-3-kmehltretter@gmail.com>
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
back at the head of the deferred queue, restore interrupts and retry on
the next tick. Keep the longer HZ / 10 backoff for a stopped transmit
queue or a driver which returns busy.

Fixes: 3640543df26f ("[PATCH] netpoll: fix netpoll lockup")
Cc: stable@vger.kernel.org # 6.12+
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 net/core/netpoll.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index e0cfcb05468e2..8d8e3c33cfdfe 100644
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
+			schedule_delayed_work(&npinfo->tx_work, 1);
+			return;
+		}
 		if (netif_xmit_frozen_or_stopped(txq) ||
 		    !dev_xmit_complete(netpoll_start_xmit(skb, dev, txq))) {
 			netpoll_txq_queue_head(npinfo, skb);
-- 
2.53.0
