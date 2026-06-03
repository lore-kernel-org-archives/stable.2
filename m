Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED9344DB7F;
	Wed,  3 Jun 2026 17:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.112.246.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780506129; cv=none; b=TI487THfdT2dWfquWMY5ZZ64RFCdzWO5CBf3q8wLi7GrysnLWvSdznvuhUHYJxQCyD+ENTTumUmyZ8Iu0vPl8LkXIokZ2RL5KrWPIrNdUAmHv5oJkK8UIsFkeZgC9jYsVbq6m4g8yxwRGtRW+42G7fZ1iJO41oOESw0CWehkx84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780506129; c=relaxed/simple;
	bh=vyxV72Xde3NfM7cPEw157P0ophAUzkgPptrsD9bjhBY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kal4DpswdkLaGpDeX10EI+h+OnMzClDnh7KcFmJ17HaZr1dDVBupBExvoZU9TAGPL+ZKP+T9W4OsSkCpQ+CyCZ8u895aJlGB2ih3ZfZONkLyROStfgHMKdseVRkpVPEYLfw6so+6X1VTevXJCWr9o3sa9pjiDpbZGNkMiwYqw7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ghtZl58u; arc=none smtp.client-ip=50.112.246.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ghtZl58u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1780506127; x=1812042127;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XngADyn825wAjD6rAWJauXvbN6mxASYmV9T8rSA1jvA=;
  b=ghtZl58ulNCWdDq5P9N3iNgi8Qv4QwVf7PrLqnWYVGovfN0JZZMVTxV/
   18N3pA4Hl15Xbl7+TU+iLaIR4vEMMBoBs/LVC6fpWQ7+lBG+feT7Zd8ED
   b4sJO+EViAQ6jk49/f62I+ECa7EnXVqz6PbzbnW+kmaCMLPDUcW3fGFBK
   0Ri8c1RIUaVOi1r35QfIq6RcdLBEU1lWW3DCJBHP8efoR+mf05EyVr9A+
   9W+mwdBh1k0kYR7q0i9fnrQnneWtg0ECy06WeneH6oPfsNpGwpkpK0w0I
   12RvsmdM9xPpJy83P14z6eIsvEV63hRX3htRIwscHwHj0IoJ7tBV7UB4n
   w==;
X-CSE-ConnectionGUID: 3pUlOvFURfWyjGYQGvboEQ==
X-CSE-MsgGUID: 89DIDO+vSUutyf+gjF4v3w==
X-IronPort-AV: E=Sophos;i="6.24,185,1774310400"; 
   d="scan'208";a="20835435"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 17:02:03 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:20138]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.91:2525] with esmtp (Farcaster)
 id 19e22491-2216-4526-a523-e7283103e6e3; Wed, 3 Jun 2026 17:02:03 +0000 (UTC)
X-Farcaster-Flow-ID: 19e22491-2216-4526-a523-e7283103e6e3
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 3 Jun 2026 17:02:03 +0000
Received: from dev-dsk-amitmat-1b-39b05222.eu-west-1.amazon.com
 (172.19.67.200) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Wed, 3 Jun 2026
 17:02:01 +0000
From: Amit Matityahu <amitmat@amazon.com>
To: <tglx@kernel.org>, <anna-maria@linutronix.de>, <frederic@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<dwmw@amazon.co.uk>, <jonnyc@amazon.com>, <abaransi@amazon.com>,
	<alonka@amazon.com>, <ronenk@amazon.com>, <farbere@amazon.com>
Subject: [PATCH] timers/migration: Fix livelock in tmigr_handle_remote_up()
Date: Wed, 3 Jun 2026 17:01:39 +0000
Message-ID: <20260603170139.33628-1-amitmat@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB004.ant.amazon.com (10.13.139.177) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

tmigr_handle_remote_cpu() skips timer_expire_remote() when cpu ==
smp_processor_id(), assuming the local softirq path already handled
this CPU's timers.

This assumption breaks when jiffies advances between
run_timer_base(BASE_GLOBAL) and tmigr_handle_remote() in the same
softirq invocation - a timer expires after the wheel ran but before
the hierarchy snapshot is taken.

The stranded timer is never collected,
fetch_next_timer_interrupt_remote() keeps reporting it as expired,
and the event is re-queued with expires == now on each iteration.
The goto-again loop spins indefinitely.

Fix by calling timer_expire_remote() unconditionally.
__run_timer_base() already returns early when there is nothing to
expire, making this a no-op in the common case.

Fixes: 7ee988770326 ("timers: Implement the hierarchical pull model")
Cc: stable@vger.kernel.org
Reported-by: Alon Kariv <alonka@amazon.com>
Cc: Jonathan Chocron <jonnyc@amazon.com>
Cc: Akram Baransi <abaransi@amazon.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Amit Matityahu <amitmat@amazon.com>
---

Questions for maintainers:

1. What was the original rationale for the cpu != smp_processor_id()
   check? There is no code comment, commit message explanation or anything
   in the original patch's email discussion as to why
   timer_expire_remote() is skipped for the local CPU.

2. There seems to be a design tension where a CPU can have timers
   visible in the migration hierarchy while simultaneously running its
   own local softirq. Is the expectation that run_timer_base() always
   drains everything before tmigr_handle_remote() sees it, or should
   the remote path handle local-CPU timers as a fallback?

 kernel/time/timer_migration.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 1d0d3a4058d5..298c34c942ae 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -978,8 +978,7 @@ static void tmigr_handle_remote_cpu(unsigned int cpu, u64 now,
 	/* Drop the lock to allow the remote CPU to exit idle */
 	raw_spin_unlock_irq(&tmc->lock);
 
-	if (cpu != smp_processor_id())
-		timer_expire_remote(cpu);
+	timer_expire_remote(cpu);
 
 	/*
 	 * Lock ordering needs to be preserved - timer_base locks before tmigr

base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
-- 
2.47.3

