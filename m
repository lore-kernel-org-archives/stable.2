Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126CD51C061
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 11:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792064290; cv=none; b=O7OmtdsYLbZgaNEKwChS27JvtbbqPlwtJjXNEWpOUM74BpTl9zglMyTlN716ffq0iIoO22FrReK/bD7dqCG+ByaMV45HA1bQOTtPNsAZk/XkNjJ46nnxq/JoUtYM3tGk0QuOlK3x/QuFaF2mAivdpDRLy5cX/LuCIvMBbvIle78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792064290; c=relaxed/simple;
	bh=9kcBr4qy1GjOghurCmFMBqZco2fiNT7SlRTN/GBR/t8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oy68Sp4SRi5IqlUY2yccA7AphcB+89ugrS2v+DzqLDDD1z7FjuOU6W3pUhecU/ZNsn58HfjgqEfwRGKX6+SmnKMRI9ZYSrxORDgvUw3H+BFloQtA/zv+7cNZ+UE77xSvKZJT9nv6mamwiaBgQwY5ReCeRhz7ttIqx6GmbdmzocQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RBz/cmBY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RBz/cmBY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792064278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MZ97wBggcb4AZnAp8JyxdnSo+z3EENDs+SXWKghbgJM=;
	b=RBz/cmBY5VexH5zRpXv891qsSrt/H0UDQ9r1t2vQSMkUG+4ZMyVpgF0/EQ4ZeaHMLkRi8m
	rX9I/FMbYCRe0hRf2LDxZaDcNdiiIktiXHJOsP1I2U9tWfwfJYYDjY16QBNcPtiVFY3cPX
	wkWaq/J5ZXSCCtsThb/dxcmp1UUoJeg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-P3_sEh9lMb2egh4ePKniRw-1; Thu,
 15 Oct 2026 11:37:55 +0000
X-MC-Unique: P3_sEh9lMb2egh4ePKniRw-1
X-Mimecast-MFC-AGG-ID: P3_sEh9lMb2egh4ePKniRw_1792064274
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D8E6C1956060;
	Thu, 15 Oct 2026 11:37:53 +0000 (UTC)
Received: from F43 (unknown [10.64.240.22])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8CA1C7D5;
	Thu, 15 Oct 2026 11:37:49 +0000 (UTC)
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
Subject: [PATCH v2] clocksource/drivers/nxp-stm: Register sched_clock once
Date: Thu, 15 Oct 2026 20:37:38 +0900
Message-ID: <20261015113738.435986-1-juhee.kang@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

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
Reviewed-by: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
---
Changes in v2:
  - add the comment
---
 drivers/clocksource/timer-nxp-stm.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-nxp-stm.c b/drivers/clocksource/timer-nxp-stm.c
index 6fe098a4a33f..23b2d44e4b78 100644
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
@@ -473,6 +469,15 @@ static int nxp_stm_timer_probe(struct platform_device *pdev)
 			return ret;
 	}
 
+	/*
+	 * STM counters run independently at the same rate. Use the first
+	 * probed instance for sched_clock to avoid timestamp jumps.
+	 */
+	if (!stm_sched_clock) {
+		stm_sched_clock = stm_timer;
+		sched_clock_register(nxp_stm_read_sched_clock, 32, stm_timer->rate);
+	}
+
 	return 0;
 }
 
-- 
2.55.0

