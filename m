Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795187403;
	b=F9fKNpPZPDgmMonyEBDG5w84hTp1BXaafySaEKRP4KqCWG/Y8Tin4ZrXHErohDdgGl8f
	 JxtNSdobjRQJiydKnvp729Z521LVuq+OW0XMIfxu3tjGP4afSGjvyx4wzYbRQIZ1qrYoW
	 wkbi98Bcc/f0V1imy+QZSzy0XcDqvrJCPViyaCOZlTz3+qXypL0RTEfuXbrVZZ6UMg+TY
	 yxjk9ott/5kMRPgzC/z441qHwz4t/Sj/811bT0cTqyur838eqFmZie2u5nrLJpUQ8HFJg
	 VHFjFAIzvferaZ9ZVeKuv5CAK9l3yW2XbDyTL7mgaH1UsHi6PUj+tv0lFb2q2kyntpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795187403;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=kUpp3qHcaoqYe6Oxe72jvoVM6sTucTkiCbMI/ubBdR0=;
	b=Lpa+aqSAmJV8gRHmqlGSxRZ+h9sCFT9gLMFGZajAkEcm8i0j000dEkCrcyF/rg0N3UJH
	 Aw+0FSxs2LDPW1qgZg/2cMvqo57mfHyO6plV/e9HXovPBmmaWD+P6Qr0LhhvxFNrCehES
	 WodriCwxMo4yQCBporH5fJ38i/sOLVtp4i7cgsnZpu8AWISGr9wZycyDYGkll8GqFEFg+
	 vBDPlXDphvEARWecEioNsWqJMxf0A5qIR6/lXOcJ/X/broROiAAIy+XQEHRADgpIcpFMO
	 rpe7+14pucVYYgKhcv4i/DsfYCIuF/PeI/vpNBG+tN7FN3ZdF8Pq13pO1CEInYjSQ8A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qkpFkXFy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D44D606A332
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 15:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D44D606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qkpFkXFy
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso585262a91.2
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 07:10:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795187402; cv=none;
        d=google.com; s=arc-20260327;
        b=NYfu4KpmVrh0cwFUCKSh1QobpNK/vm/gvKx5zqh09ziw1Pfx26BLVr1bE/RVY8+qFX
         yamdRhFcMv+kCdFmMzwuTu22m2/hTDeWLTcXr4J2H/oRZ1SdJ3UjtpLwb/4hNW4RqqkZ
         XhKUG7BL6z48uGErykhtsa1vqBQcJRugLutX4cJb08naEo7O0i8dwoz1WtITvOjL4jTN
         EqD5w28vTod1P0tgceFN/4ovjccII+c9pL1J+IEjTKVbQ7bNQM3/dOujUWCP3COmlDcS
         71Xzds8MXCDBXOILHPL7uX7pernwJKRDCdTQTOUXWbyYc6BiDQcWiSzXFN/uMz5D734U
         AW6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=kUpp3qHcaoqYe6Oxe72jvoVM6sTucTkiCbMI/ubBdR0=;
        fh=7NbXctnBxR99+KEwui/r8OyOrQ9j1udVzw1dhs3Z100=;
        b=qSWQzPhW59YxNfCACSMyDSe+AXTD/VY0XEFpP/fZysfXaGoZiVm99zIbxDHa112O5h
         PgjkbvS4t4j2hOFLvuxleljlZH6AXEFs6FeiQM1w+6EQL2ywNhwwg/pCiO0Yjg27eS5e
         yVZGwgRgYKcny+wRnml99ORJsMFz+QgEAoA4LB0UZphI1VzHIQ4jy9sTp9cKni0VTEds
         mD6P5whTn8QhNYgpTKqJdEbqKaFvlmCHb7cZe2qD66ONjpXlUUcHl9FvGgWkgTp5b2uQ
         qnhijdiF+1FUYyTut5gtPZF1h/Wmu8qaJ9S7pe7/O7AbnKeczdCtq6N053XFTD+Z39cq
         1/TA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795187402; x=1795792202; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kUpp3qHcaoqYe6Oxe72jvoVM6sTucTkiCbMI/ubBdR0=;
        b=qkpFkXFyXIEotYNu1HZlWsiL3YsoG7En0GO3i2de+ucOQDWPedxNZKQo4HsYq94l/C
         8kbzdi4s3QxHs04Ry1xrpJi1KLHAR55FpS2bjKwL74+DSyHgZo0fHpB73ODAJ47G2/74
         dTP33cZ2/SJQsbfmAqiRybp9BLaqUh7F7Y9LiRoUuAJqTXUxyiOqk2SY50vfUiFeA2P0
         FyGQTwW+JRL15vPeWIV1BGaRxSC1L3fWf0P03rNYA9/LFJoORfwqgjSwnjpAY2fLukr5
         8hfDn7/kvcsi2b2OQhrzKl06wSSUFIDdswPJviLo6CCXVXg/gXOp2czpIPjB/J8deF1D
         4qFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795187402; x=1795792202;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kUpp3qHcaoqYe6Oxe72jvoVM6sTucTkiCbMI/ubBdR0=;
        b=gm+Hw5eYKjIfGI3n1hNxiT/2aHEkDl9G8kZucoYVxOqcjnk/vgsRztZ9S7fmmrlttZ
         N3dFPx8jI0PiuLvc4ACWqyGOkNRojGJ0h1oLIahs8QZOxbo1jXgC22iAsvAeQG7v+gYn
         iYsCJlCekceT5e9t4O0tJsp3Kl0oGhNCFYtvBZ7MVsvma9suRjteqemctRu82+1Tul6Y
         9W+iSXzXRQBw4DMEjqNXQuweTrrEOYSZKHoRS7QJsZ1w+a6j3ykNSSF8Ct6pxALUC/GH
         NSTJncsRtziiXdNOr5q7PsatjtcqlKQoiqDmW/Ta65FOYrJNG0y2QA3c2mrnSrmuHyWo
         ug2A==
X-Gm-Message-State: APuU4Z9eFYyLpoLzuAn6apst3JgqNOrx84rkIj2CIblPz3kiRXorlvW0
	U0k/DK8NH30yP0cE1udA5ywbkgDhp2pigreHZdiDBmbuErtoCGu8sZK7QknGKPJhlcZ1sVSmujC
	tQbmDzmAPS6Tzw+rj01s8Gkks+jBgDnnZ66vV
X-Gm-Gg: AZFdTZenTvKfVyXitLoj2+6RIhpJ//5v2UBZ9Pj20uaXhUb7bynyI4ZOn87BfjEST8n
	Mm7LnQdgvNlfj/OQwWLBKw0sMVd0MAyiOUv/c6ZJEE+0wYIIVs8fQTowXhDMLx36BpT3ZMUst2r
	KTGbwSSVouK8bnQP7y+1Oob5EXtdFUeg3nbn7AruFx6in88SXwnVryDaq+tnfdE2KBEiuYxsY33
	AJaxaQEoNXizk0X37hmel0PpqmMp9AzjPX6XcpOrwsP6I4TPhpHstqE2Xs5PyDI6n67SeF0KJwG
	8sU31syCDMunu34tvmYwX7PaTVSt3g4AKD1CeZw2Lc3kaJXDGWwxqcOYR9J890qlMQHuPf/I5o6
	/jv7fc75gUGM9oyMUNAxt3TZbNWEHuDlEZPyza34zcWyoDADLFZ3EG31Ns/LKmG6rUpY=
X-Received: by 2002:a17:90b:3a4d:b0:3b0:91ce:6726 with SMTP id
 98e67ed59e1d1-3b41c8db487mr3145864a91.21.1795187402472; Fri, 20 Nov 2026
 07:10:02 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Florent Carli <fcarli@gmail.com>
Date: Fri, 20 Nov 2026 16:09:51 +0100
X-Gm-Features: AclHuK-zBsB39c3smGA1HgYvvn2IKUa7TGYhpz-IYPnNRniIYEWx37QeH8vS3OA
Message-ID: <CAJuRqcD2=42CTQk2PSHofSmt+=H=qKT-x-ZXD76TwVshaepBAw@mail.gmail.com>
Subject: [REGRESSION] 6.12.y, 6.18.y: fair server runs SCHED_OTHER ahead of
 SCHED_FIFO on an idle CPU (fixed in 6.19)
To: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

As I understand it, the fair server is deferred: it should run
SCHED_OTHER tasks ahead of RT tasks only when RT tasks have kept the
CPU busy for most of a period (about 950 ms out of 1 s), so that fair
tasks do not starve.

On 6.12.y and 6.18.y, I see it run SCHED_OTHER tasks ahead of RT tasks
on a CPU where nothing starves. My setup is a PREEMPT_RT system (Debian
trixie, 6.12.117 rt) with a time critical SCHED_FIFO 98 thread on an
isolated CPU. That CPU is idle most of the time. The thread wakes up
every 300 us and runs for a few us. From time to time, a SCHED_OTHER
task that wakes up on that CPU runs ahead of the FIFO thread, for as
long as it wants to run: a container health check (bash) delayed the
FIFO thread by 3.4 ms this way.

6.19.y and later do not show this.

My reading of the 6.12.y code: about one second after the last fair
activity on the CPU, the zero-laxity timer fires and replenishes the
server with dl_defer_running = 1. Idle time then drains its runtime,
and dl_server_update_idle_time() clears dl_defer_running after about
50 ms of idle. A fair task that wakes up inside those ~50 ms runs under
the server, ahead of any FIFO task, until it sleeps.

Reproducer, as root, on an isolated CPU with nothing else on it:

  CPU=22
  python3 - "$CPU" <<'EOF' &
  import os, sys, time
  os.sched_setaffinity(0, {int(sys.argv[1])})
  while True:
      time.sleep(1.02)
      end = time.monotonic() + 0.003
      while time.monotonic() < end:
          pass
  EOF
  cyclictest -m -p 98 -a $CPU --mainaffinity=0 -t 1 -i 200 -D 30 -q

--mainaffinity matters: cyclictest's main thread is SCHED_OTHER, and
when it stays on $CPU its activity every ~60 ms keeps pushing the
server's period out and hides the problem. Any other fair activity on
the CPU more often than every ~950 ms does the same.

Results, sleep between 1.00 and 1.04 s, 3 ms spin. Max FIFO latency,
and wake-ups later than 500 us:

  bare metal, 6.12.117 Debian rt         3001 us, 10 per 20 s
  (10 ms spin instead of 3 ms)           9986 us
  KVM guest on dedicated host CPUs:
  6.12.117 Debian rt                     3000 us, 10 per 20 s
  6.12.118, vanilla PREEMPT_RT           2900 us, 8 in 270 s
  6.12.118 + v6.12-rt queue              3000 us, 14-15 per 30 s
  6.18.15 Debian rt                      3000 us, 10 per 20 s
  6.19.14, 7.3.4 Debian rt               < 25 us, 0
  all of the above with
  fair_server/cpuN/runtime = 0           < 25 us, 0

The lazy preemption patches of the -rt queue make the window much
easier to hit, but vanilla 6.12.118 is affected too.

The fix went into 6.19:

  e636ffb9e31b ("sched/deadline: Fix dl_server time accounting")
  f5a538c07df2 ("sched/deadline: Fix dl_server stop condition")
  1e0a2ba7afb1 ("sched: Provide idle_rq() helper")
  ca1e8eede4fc ("sched/deadline: Fix server stopping with runnable tasks")

None of them carries a stable tag, and only 1e0a2ba7afb1 applies
cleanly to 6.12.y or 6.18.y.

I have a backport of the four to 6.12.118, with small adaptations
(rq->donor does not exist in 6.12, so rq->curr is used). With it, the
reproducer shows no late wake-up, both on vanilla 6.12.118 and with the
-rt queue, and the starvation guard still works: under a SCHED_FIFO
busy loop, a SCHED_OTHER task on the same CPU still gets 4.7 to 4.9%
of it, as without the backport (0% with the server runtime at 0).

Would you take this series for 6.18.y and 6.12.y? I can send the 6.12.y
backport as patches and prepare the 6.18.y one, or leave it to the
authors if they prefer.

Until then, writing 0 to /sys/kernel/debug/sched/fair_server/cpuN/runtime
on the isolated CPUs avoids the problem.

Thanks,
Florent.
