Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198808;
	b=boe3L72Oegqbp3O6CZVcSbKyS8MGUgh6fjoUCJib+KWpE0Q/zVMrbi0Tqdm3djOvXRVn
	 Nea4Bzm6hZq8+RnOlVxD/3ohCaOtT5O5R2yUdDtq4+xUI07SxU1a5gFtYVqp92QqfVEoR
	 obIQMXcaACUMsBPghQXVeCYcq4Xhh1wiYjPkRgaTNSxkoHfH9a5Hjw7YHrantczJFaOJE
	 VcjJwURujGB4T6siTskgIhOOWttO1rP9EdXrbkYMOnt3vQmKMy0uM79S6py/75uBGObyD
	 gZLHdSpcDs4Q8vIaj6AJdpS/aiLCIVNVArNqToC3UngBVF+iGmAn8Orm0qfCb6MjPZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198808;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Z0Ms4EWmpH8O95SfcyZ1/RL/Upfl9qBeaFcIpXoItCQ=;
	b=zTVUUbmvLRE+xv7B1btI1VYdwRkZq5mUm7T0F6rcFpdFPf693J7US1jo/6hC46DrRMrc
	 hLv5IW/GTnhxaNY8g3w2DjNx3f0OmoJtQkst+D8HDLR99HueVX2HRoaIdLmCBBF6ADPQt
	 gkFV9Zze2Emv/5csZLj1ExZD9LrzvCACiUj2pkmSsF3n/AmOGmZhsT1dGUVImS63ewc7W
	 fRyRrapwQX57trUh9izWJBx6oqJYDJpIUrUMBPa3detusy5olRzdyDoi+eRU7DsxLq3y5
	 rlmQwvkQCFaJhWWueMGP2CTosE+Wd/ecf7pHh4fDE/ojcBwTO6Vtn/9g8FKsG1rTPcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TwWop+l8;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5896B606A8A6
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 18:20:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5896B606A8A6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TwWop+l8
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso1057616f8f.2
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 10:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795198806; x=1795803606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z0Ms4EWmpH8O95SfcyZ1/RL/Upfl9qBeaFcIpXoItCQ=;
        b=TwWop+l8PNa4D1dwENFcUvehnaprPSLedFZhwVNrUdqzfG/sQ3MKhgtAv861M7H9UW
         RfnSZWlgXh6tJQbOKpQLOiHh/FQGkFEUJLtAm/MJVGaEk/isxhg3RlsAfss5Bh3Zb5ar
         bEAMtTY5Xr07JC3pYyFbcs1K1iDKjKGQCgT119BCXVBa7Y7KTqe1cz5iFH+np0tVr/z6
         hjgr+viQSW7TXQo0F++SdnmEFglafGtUrWfxN8DGSHYDrT1dDUOSCstDhJI/rprErbqa
         SfERl5r4RUE48KeCGb4c6lE87wVdRbl5eH0ufF/FyPWeAVneGjKG+C6HYDc9SuoWR7A6
         LrKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795198806; x=1795803606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z0Ms4EWmpH8O95SfcyZ1/RL/Upfl9qBeaFcIpXoItCQ=;
        b=eyrd3gjVF8R69VWtMR3wvoDLYzrKAQFL5a08DLpGFk0OyZEI6r0ZQFPJ9mzTW/3mPS
         SeVnD6mMOpFNB2ToY2tWoDHNqe1suH+b4BGHme481PkmXDARMgAeGQiloPrtIavgSgEO
         2ibDNZJHiC5ObkP+XIKxntakru6dErwXFbwm7lKQwxppNOkJVyotzP/qJuRyfnetCzWS
         pOgscUxz9DfQ+1YyQWAzSXcyqCrbTb2dOYJDHVUsGKCC0pjr7UKEzpw1V/eL7wXkkz4i
         LIfB8zaFNFQwVqWgTkKsevghkhA3uXryUJFLuWPbuE6sFkWN9yxvx9DudY6pfyQ4WTLg
         KDPg==
X-Gm-Message-State: APuU4Z9finfTtIbk18le8qsXJE39Zm29abx4iAgDc+pcu3h8jr9zGjwM
	2+OVzh1z3opf30Q8m+475j+7BN1ToMu0Uzd7nL4FQtQDG/ZySo16kvt3FjJKFA==
X-Gm-Gg: AYBFou39+FGSv+CQbyhMVzAOuoYLluQSpXYnTB6P5nUcZZVRixGitO9YaC0CT/spKX/
	egWZC0YcnnzzKAUl0Ge9JL5WkbSrWawpPBuDz4LkOmKZ95ielyTcwBegpCp2gmDerh/S0/eHBeV
	zCssyByYUIyZi/hVM192o/RY0v4zbIz+HHJc5f/htgh/P3c8I/wFlZbpgFRxITdGv3cbTY7Xq0X
	00wWEG9dVNEE23dz3JGet8PSD3vcUVfWfBdeJBJuJBUoM+e/lqHFFgLslq4FXFHoWOGQMqbnBk0
	PJuuyE/07xydgCJwsjvDKqTD0FbHMNKmeCFvzyQTWCb9AmlZiTrZnI9ph8PrP4F2GLE8iyNxphG
	HHpBAf6swkxfON7yM5JQrShEFlTaHhLOFMOQdgkvbaKHdyDL+pUCTR8pKxfNrPmYPvyVRupax6K
	JqapiDA536WZaM1cWEHqapvGTg1Y6m1OwQVuemfw6/4OumWA+nsuu+ukh/ARWHQhEIRIQuQx355
	PscZqqzy+o/IBd293p+fqzRV+6eZ/PL9IBvXQeSwJ0giXap7BMimwDGVykdfkV3QzjvZFT6CYMu
	WZJLbNgVQZ0fb1AgATDHepRyXGvT/wEitU12fnlZ+gyeSmom3ddg3tfwqK/nU3kiyYRu/9L6py5
	NAuA4HNwMvLgRbiI2Il9oayMq6Q==
X-Received: by 2002:a05:600c:4e87:b0:4a7:6bc7:f778 with SMTP id 5b1f17b1804b1-4bb88938d38mr93238985e9.30.1795198805501;
        Fri, 20 Nov 2026 10:20:05 -0800 (PST)
Received: from mbp-de-florent.lan (37.170.0.109.rev.sfr.net. [109.0.170.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb895eec06sm34789565e9.2.2026.11.20.10.20.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 20 Nov 2026 10:20:05 -0800 (PST)
From: Florent Carli <fcarli@gmail.com>
To: stable@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-rt-users@vger.kernel.org
Subject: [PATCH 6.12.y 0/4] sched/deadline: dl_server fixes from 6.19
Date: Fri, 20 Nov 2026 19:19:45 +0100
Message-Id: <20261120181949.7528-1-fcarli@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <awB-5usPb2QZXt37@jlelli-thinkpadt14gen4.remote.csb>
References: <awB-5usPb2QZXt37@jlelli-thinkpadt14gen4.remote.csb>
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

Hello,

This is the 6.12.y backport of the dl_server fixes discussed in the
parent thread: on 6.12.y, the deferred fair server can run a
SCHED_OTHER task ahead of SCHED_FIFO tasks on an almost idle CPU.
The same four commits are requested for 6.18.y, where they cherry-pick
cleanly.

Adaptations for 6.12 (noted in each patch):

 - 1/4: rq->donor does not exist in 6.12, rq->curr is used.
 - 3/4: rq->ttwu_pending only exists with CONFIG_SMP in 6.12.
 - 4/4: context conflict in dl_server_start(), which still
   initializes the fair server in 6.12.

2/4 applies as is. The series builds and boots on v6.12.118 with the
Debian 6.12 rt config (PREEMPT_RT).

Tests, KVM guest, reproducer from the parent thread (3 ms spin),
sleep 1.00, 1.02 and 1.03 s, 90 s per run, late = FIFO wake-up later
than 500 us:

  v6.12.118                      8 late wake-ups in 270 s, ~2900 us
  v6.12.118 + this series        0 in 270 s, max 15 us

With the v6.12-rt queue on top (as Debian ships it), which makes the
window much easier to hit, an equivalent backport (same code, the
idle_rq() helper added without moving available_idle_cpu()) went from
14 to 15 late wake-ups per 30 s to 0.

Starvation check (SCHED_OTHER task on the CPU of a SCHED_FIFO 50 busy
loop, 4.5 s window): 4.9% of the CPU with this series, 4.7% without,
0% with the fair_server runtime at 0.

Thanks,
Florent

Gabriele Monaco (1):
  sched/deadline: Fix server stopping with runnable tasks

Peter Zijlstra (3):
  sched/deadline: Fix dl_server time accounting
  sched/deadline: Fix dl_server stop condition
  sched: Provide idle_rq() helper

 include/linux/sched.h   | 16 ++++----
 kernel/sched/deadline.c | 89 +++++++++++++++++++++++++++--------------
 kernel/sched/fair.c     |  9 +----
 kernel/sched/idle.c     | 16 +++++++-
 kernel/sched/sched.h    | 31 +++++++++++++-
 kernel/sched/syscalls.c | 32 +--------------
 6 files changed, 116 insertions(+), 77 deletions(-)


base-commit: b869a5313cbfe7102873d3de318ddb68675146d0
-- 
2.39.3 (Apple Git-146)

