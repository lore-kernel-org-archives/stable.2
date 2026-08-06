Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E8D3DFC82;
	Thu,  6 Aug 2026 09:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786008830; cv=none; b=Uf+ae/UNUBhQomKTnjkNkRj2KhdHnM1LLLfb5+94wI+YjLbi48EYe8/MD7mQ0pqZSWP5v8/h5T4NiZZsEHLSVW0K78f9fHEjxgH+X8FUJrJ4GKhcmkc5sgIcOkLIQQu+ZY+c/ahnz0L8JH4ayR9kXwub3loO27QJlvgeK+PvQWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786008830; c=relaxed/simple;
	bh=HValyRbjfGqT4TzA8Gxf2MxjsQToiKVkJK4tfZHkFDc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e1qI841EqZ/dq90egV5Ja3XpD1FDnp214T1tyI5qILjN/diDuiHye6raeYKnUtpJ0uPhKs3l08C0VHQoxd4lWWWUuqDvJGJw9UFUfE894L5Pn/Tf3OnLtj73Z01KyQ/o2Kf/i511d+WWvo1wcxYo4HbL2iVd4lpbrJQNj3iHtms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=GBmTa+vy; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="GBmTa+vy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1786008829; x=1817544829;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+7JfohERnwjUAxnprJGAesVYf4mSMVwGYihrSYG9Md8=;
  b=GBmTa+vy9h0x4Q50gOQlmzBPR2NFyxu8S+GMKjMdqBVcJr+lcK0xQ4h9
   UMMQdJR/niE1KA8B0jwWK+RczUPCslp6QY3VrivWCDy4HQKuaEHxSOqu2
   pHVY9mMl+cM7B7eTTgS0rMqly15qJDJCTbO1eiPs5W2OJpcsrfz2Rn3PO
   nzQ0V35iprB+w/O3zOKTrzpg/Tsf/BjK0XmSfPdt4c2C/YrBMB4pYxA99
   EMxADXRobuX/OqtbD4oSlWB/J4wcVtr8Tn8m7PZm0nata7IyQH9pRNFDh
   KAvcQJjOipdRPPl6o87K874XVK6NNRSrbixeYRHy5SeMfTxTo0SSn/RA3
   Q==;
X-CSE-ConnectionGUID: VfnL0b6CS+SFiW68YyXuPg==
X-CSE-MsgGUID: NysPtpPpR0WRL954nPYp4A==
X-IronPort-AV: E=Sophos;i="6.25,208,1779148800"; 
   d="scan'208";a="25135470"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 09:33:46 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:26312]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.39.23:2525] with esmtp (Farcaster)
 id 9081b05c-e599-45b8-a05b-fae27c388473; Thu, 6 Aug 2026 09:33:46 +0000 (UTC)
X-Farcaster-Flow-ID: 9081b05c-e599-45b8-a05b-fae27c388473
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Thu, 6 Aug 2026 09:33:45 +0000
Received: from dev-dsk-simonlie-1b-ad174abf.eu-west-1.amazon.com
 (172.19.78.185) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Thu, 6 Aug 2026
 09:33:43 +0000
From: Simon Liebold <simonlie@amazon.de>
To: Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?q?Andr=C3=A9=20Almeida?=
	<andrealmeid@igalia.com>, Will Deacon <will@kernel.org>, Waiman Long
	<longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Simon Liebold
	<simonlie@amazon.de>, John Stultz <jstultz@google.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH 6.12.y 0/2] Please backport wake_q drain follow-ups
Date: Thu, 6 Aug 2026 09:32:57 +0000
Message-ID: <20260806093259.2778358-1-simonlie@amazon.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA004.ant.amazon.com (10.13.139.93) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Hi, please backport the following two commits to the 6.12.y stable tree.

After commit 4a0779145781 ("locking/rtmutex: Make sure we wake anything on the
wake_q when we release the lock->wait_lock") landed in v6.12.96, we observed a
fio null_blk throughput regression (128K / iodepth=1 / numjobs=64, Graviton3 /
m7g.16xlarge), because that commit makes the rt_mutex / mutex release path run
an unconditional

    preempt_disable();
    raw_spin_unlock(lock);
    wake_up_q(wake_q);
    preempt_enable();

drain on every release, even though wake_q is only ever populated on the
ww_mutex path.

After checking why we are not seeing this in mainline, I found that we are
missing commit abfdccd6af2b ("sched/wake_q: Add helper to call wake_up_q after
unlock with preemption disabled") in 6.12.y. Even though it looks like a
refactor, it adds an if (wake_q), gating the wake queue drain.

Commit 5ec58525a1f1 ("locking/mutex: Make mutex::wait_lock irq safe") is
backported to make the former apply cleanly.

Simon

John Stultz (1):
  sched/wake_q: Add helper to call wake_up_q after unlock with
    preemption disabled

Juri Lelli (1):
  locking/mutex: Make mutex::wait_lock irq safe

 include/linux/sched/wake_q.h | 34 ++++++++++++++++++++++++++++++++++
 kernel/futex/pi.c            |  5 +----
 kernel/locking/mutex.c       | 26 ++++++++++----------------
 kernel/locking/rtmutex.c     | 32 +++++---------------------------
 kernel/locking/ww_mutex.h    | 21 +++++++++++----------
 5 files changed, 61 insertions(+), 57 deletions(-)


base-commit: 833291ee77846538926c990bcb468f6f54e9af50
-- 
2.50.1

