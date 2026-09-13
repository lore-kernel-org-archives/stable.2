Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957B73A5E78
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 13:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789306645; cv=none; b=c4OBd61Qqicjsf7gvv8/qe42ev3/dSNCgjI2Gkd/LWUgUI/D0NaQLwflbmoM0p6/ecZ5DUQtYzsxHnTK9h2OkbE3ChjmT3b1G2Pka1I15Wp0Sya2NR4osnrw7NMkU5hfPGzNNFGWvKaVmzIPkrHxnxGmACvze6fV6lvQJqSwgGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789306645; c=relaxed/simple;
	bh=et5AaVl1GGw7u21SrV5WZcepSMG5oem3/WgVlHyAmqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ez/2GyGXuzrMVsL6++ejQzY4HEUxbO4LuYEvv8ow267An84BHBFsKlC+enduwOxaLGiLM11Zd8ulC89dYtgEtThwF0Adw1kUqXROe5MS5RTsc8B99ydHc6/llm75DyzstdiJVdyX60mNdA7WQQbYJnaXf5ngbQkzZ3+tceBS/O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DCN144VQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DCN144VQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789306642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+NWO1Hub6RBRUSQmKYFmH/2juClvSCDZCkaUOtzmRRo=;
	b=DCN144VQy9PkyWfO7wAvMu5KsI//2V9Z7cku6OG06COo1cY70th7tUCBpxIsesdhLsUNbC
	wAOzSvtym+QQre+kuqNFpauNE7ySEAEDLi4ZGO7fyzzPVubf83IjkO6JoDFNNP2UTvLTPX
	1+JXoLQB8wGMKW6hG6R+Vr6KjiCDbsA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-TX1bL66jPCuDfPA-yerwnA-1; Sun,
 13 Sep 2026 09:37:19 -0400
X-MC-Unique: TX1bL66jPCuDfPA-yerwnA-1
X-Mimecast-MFC-AGG-ID: TX1bL66jPCuDfPA-yerwnA_1789306637
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 17026195423D;
	Sun, 13 Sep 2026 13:37:17 +0000 (UTC)
Received: from F43 (unknown [10.64.240.27])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8DC82180049F;
	Sun, 13 Sep 2026 13:37:12 +0000 (UTC)
From: Juhee Kang <juhee.kang@redhat.com>
To: Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>,
	Dustin Black <dblack@redhat.com>,
	stable@vger.kernel.org,
	Juhee Kang <juhee.kang@redhat.com>
Subject: [PATCH] clocksource/drivers/nxp-stm: Register sched_clock once
Date: Sun, 13 Sep 2026 22:36:45 +0900
Message-ID: <20260913133645.1102997-1-juhee.kang@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Each probe updates stm_sched_clock before calling sched_clock_register()
again. The call then subtracts the counter value saved during the
previous registration from the new STM's counter. If the new counter is
smaller, the subtraction wraps and the timestamp jumps forward.
(e.g. from 0.4 to 32.9 seconds below)

  [    0.403653] sched_clock: 32 bits at 132MHz, resolution 7ns, wraps every 16243448316ns
  [    0.404056] clocksource: timer@40120000: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 14456668980 ns
  [   32.890509] sched_clock: 32 bits at 132MHz, resolution 7ns, wraps every 16243448316ns
  [   32.890882] clocksource: timer@40124000: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 14456668980 ns

To fix this, register sched_clock once at the end of the first
successful probe. Clocksource and per-CPU clockevent registration
remain unchanged.

Fixes: cec32ac75827 ("clocksource/drivers/nxp-timer: Add the System Timer Module for the s32gx platforms")
Reported-by: Dustin Black <dblack@redhat.com>
Signed-off-by: Juhee Kang <juhee.kang@redhat.com>
---
 drivers/clocksource/timer-nxp-stm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-nxp-stm.c b/drivers/clocksource/timer-nxp-stm.c
index 6fe098a4a33f..7572cd20732f 100644
--- a/drivers/clocksource/timer-nxp-stm.c
+++ b/drivers/clocksource/timer-nxp-stm.c
@@ -211,10 +211,6 @@ static int nxp_stm_clocksource_init(struct device *dev, struct stm_timer *stm_ti
 	if (ret)
 		return ret;
 
-	stm_sched_clock = stm_timer;
-
-	sched_clock_register(nxp_stm_read_sched_clock, 32, stm_timer->rate);
-
 	dev_dbg(dev, "Registered clocksource %s\n", name);
 
 	return 0;
@@ -473,6 +469,11 @@ static int nxp_stm_timer_probe(struct platform_device *pdev)
 			return ret;
 	}
 
+	if (!stm_sched_clock) {
+		stm_sched_clock = stm_timer;
+		sched_clock_register(nxp_stm_read_sched_clock, 32, stm_timer->rate);
+	}
+
 	return 0;
 }
 
-- 
2.55.0

