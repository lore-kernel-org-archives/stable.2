Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866727;
	b=xVYXe7AdRCXvAcnwoL0M8j3OB4ecKLi/k+yZIjjiY77CMK4CF/PEiKbwC1cEfFZ9f94n
	 die7Qw4nSFlTAiXbe/0Vc5qMINVAoOaJ2S+TCYk2RCZrC22qFN3EPUd65XidyWQjNfXol
	 RHBFW+AojrBEEDQgTREQbrDaVXTkKmWTAe7OlBfeI1cyzfdKWQtBPoenQoi/3nnDKQlQj
	 iGiU26zH2LTrBFOWRuCK+bA5UFAg+ji53Rgd589YF6ztVYrJZ1ChuSihQFid/WtAXjZZn
	 e0+Mdc0yu6zwpBUH8zpKVCA1N7NxTz+AGBk8810pWxpypWwEcPOtkyNCk5kjNm6pZyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866727;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=v1ehsd1h1KwjntsiObgsijntLBW7FiKbRqCPJkhAIr4=;
	b=uhO0Kdnh86hVRmunT78/WN+xYj0QbqJaJgfRSN1RDIUv9CMcUXKkZ53jtMYs8LDnrSU7
	 XMLB6375d0rFRTCNyvzyIkgRkrX299NDEfuqtA9R9zZlJrVNqel1Wg0Onh9F2sPrDaeXT
	 lTvGf2Y7hhuXcodgLlzn1eFYjKm2TsAzEQAz/Hey7GcRV9V30Pc/80Kw5R+KlHR4qriZ8
	 8NEZHjF7MG2A7lxQWmfm6jgN5LKFdy2cEfrM4oGfRTgTdP/WjwsYcZ6TXXu3JzAPMIfZh
	 ZQO45JTGW7yFX7HfO5mhUyM0BMxAAsqUqTf2eOdhkz2XtwJuM5OFhQmnqwwCKCjnqEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h2oYDKFy;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qaZCRfaJ;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A318C606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 08:18:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A318C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h2oYDKFy;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qaZCRfaJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793866724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v1ehsd1h1KwjntsiObgsijntLBW7FiKbRqCPJkhAIr4=;
	b=h2oYDKFy4VokWwcZHkZm7hVsT8DlklQqDVn2BNp3a7Qf5iiM27Bos17m8OLQ1BgOSwx1Rh
	75y9cqPBzuareqoXkWq6rIGqYETVOP4h2GwyLO0iarYgORtjjgbQvAVNjBjC0GjJ8QgAEV
	dsAacHQXpv+ok6AtvN/OOzI2Kgbo1+k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-yx_8JpLoObiDeZIqASaXXA-1; Thu, 05 Nov 2026 03:18:43 -0500
X-MC-Unique: yx_8JpLoObiDeZIqASaXXA-1
X-Mimecast-MFC-AGG-ID: yx_8JpLoObiDeZIqASaXXA_1793866722
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4aa7a73b799so2637315e9.2
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 00:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793866722; x=1794471522; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=v1ehsd1h1KwjntsiObgsijntLBW7FiKbRqCPJkhAIr4=;
        b=qaZCRfaJRdcwewF0Vrcz2q4qGrUreiSzsZizsYrydbiO07bBNCcKYRpCk3kpRWU3Ju
         DjO2N+XEtDgHK7RMEKVX4iajlBNyF9DJEUonvPZ0atqV5m8LbL9Lv/GEQD0Wq25A6apq
         UwDuBaJA1OY5fkIPSccOBzNpUBA5Zs6wzx8MMGazszrZBR3wcOEWSanarLzao41+vYS4
         lsIbnUmq3yNemCK6PL32rp3AT9E9zsG15lHBwKJzeOob+IMRa2wAO7ORX8mO9H0e8RP7
         0izHWziThSfjlH7ttE38zwA5QMbJK80BwbS0MhG96AVmNSgRTaEBNUdd02AE4KbZFiVI
         68WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793866722; x=1794471522;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=v1ehsd1h1KwjntsiObgsijntLBW7FiKbRqCPJkhAIr4=;
        b=SVeAbrv5Czxt78eCH9PcoFMbveQ7l3t5HXcje9ndQp9xu/zXsW9YeIE/kVz7t8qwEO
         K12xTpGLXR0Zs5NVKmPXaFLOGNsuF306yiHtgJLfdcbDPAucidWDs5H+HiEqh7gQz0fB
         fD2LIUGs6RBgLuz5ChQVHVipHU5rocFhnEUjMHov7TOztNzZOCTER75mFdGvz60wnWfb
         cOhGJbpeDVfl7POvWe+Sm7hKwGDki12C7/nV/3vViGnwa1FozzyRrv7GowlAc3Xh4PZQ
         cFCM7P5mb7y24spySf8Ytbz98Zh8ybuOWPfukQkG3YsGWfbommCQtPVZkW6sx+XXzxuS
         AfOw==
X-Forwarded-Encrypted: i=1; AKwUvBx6iZfZpBjwiwC0/Hdhnnj1JMOgZGx8v7WTo8pL7WO1jx313sNatyYlU8zQSlNFDGMP+QKV9qo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8kEIzp2UCl38sLIvXTpqBDMbhGTb06z0zxRO/DK0FqXTj70N6W
	6qICzqKAOy8hJA0dxOvoCU59laONrtHpkOJ/SHWg0/9k4rHg9L1C1j4ZbgzSlq+zk2GM5t31sUw
	1HKeR4LsGhYTSvlCO1jJBzZsoZS06aoZ+x+i5p6f9C2l6ueG+mxoDvHUe3w==
X-Gm-Gg: AYBFou1tf0jXxzdgOiSpyBcFU1kmXpQ1vYxTZLX21LYlzCvgsZAzJi/aALytXsmItgf
	gBQoFnUmuYNW0QD2WXjIZT93GClthOfHeCZBkip9bIEqE7FQ6XR7hQ5kFZMszaF1QTM9n3PcViB
	Cz2UklVtk1GZQfi+cDmat2uScYe01e7B9UcefEnURaiyO5bD8fmNUGQaGnojBzlkv4gNbhMKIpB
	8JHZky4rbv9RYAuLjekhnNUOuMOXXEVE8Zy3jiCyh0uIJVvLstcaRrh8pbf5Mcbc8XuQzInjeGL
	LMNCOn6B9bf32q1I8fnjlzr7JPeZT4QpYX2QRfsQ6RwjNnKNmle50PqmFcqPv6unu8+m/XAlFM4
	ZCDZlaAnJRa3dGVdbLNMgCMcgu+SnW1Am9Hjuk4XWxlmvjNOf9pX0COot+lUvpeGFlxafuSROva
	NQ0N2uaBzaqL9f6w==
X-Received: by 2002:a05:600c:a293:b0:4a2:417:7db5 with SMTP id 5b1f17b1804b1-4ac17d19a54mr262872495e9.2.1793866721836;
        Thu, 05 Nov 2026 00:18:41 -0800 (PST)
X-Received: by 2002:a05:600c:a293:b0:4a2:417:7db5 with SMTP id 5b1f17b1804b1-4ac17d19a54mr262872155e9.2.1793866721314;
        Thu, 05 Nov 2026 00:18:41 -0800 (PST)
Received: from localhost (119.red-83-42-172.dynamicip.rima-tde.net. [83.42.172.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56ba6bc36sm51621395e9.0.2026.11.05.00.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 00:18:40 -0800 (PST)
From: Enric Balletbo i Serra <eballetb@redhat.com>
Subject: [PATCH v3 0/3] Fix NXP STM clockevent bugs causing lockups
Date: Thu, 05 Nov 2026 09:18:31 +0100
Message-Id: <20261105-nxp-stm-fixes-v3-0-8129b912e74b@redhat.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13MTQrCMBCG4auUWTuSTNJUXHkPcRHbic2iPyQlV
 ErvbloQsctvhuddIHLwHOFaLBA4+eiHPg91KqBubf9i9E3eQIKMFKSwn0eMU4fOzxzRPoU0qpQ
 VGwfZjIH3Ryb3R96tj9MQ3ns+ye36LZlDKUkUSMIabTVbXepb4Ka107keOthSiX48+yOnzC+1p
 UoYpwS7P76u6wf3KnF46gAAAA==
X-Change-ID: 20261023-nxp-stm-fixes-ab0163517e6f
To: Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rt-devel@lists.linux.dev, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 NXP S32 Linux Team <s32@nxp.com>, stable@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Enric Balletbo i Serra <eballetb@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793866718; l=8667;
 i=eballetb@redhat.com; s=20261026; h=from:subject:message-id;
 bh=sPmxboU+m8zF5VduzollnuV8Jw2XtblGq9zFKb/a2vA=;
 b=K9rmtzRsFgLDxGjLsE7RpTnOrpN9U4ySH3x+8+hEsb8lyUBxLPp4emqf+Oz0Y6kRGZ66d+uRt
 KPDIQQYkwJtBqew4RP7CiE5SKoRK1YLihAZ8IRqxnXkELTIOyYBOiwu
X-Developer-Key: i=eballetb@redhat.com; a=ed25519;
 pk=5zh6xuAxTiQwglL2NXQFqWuyRPmCE8T5KPXLbNXhnKI=

This series fixes three bugs in the NXP STM clocksource driver that can
cause soft lockups and missed timer events, particularly visible on
PREEMPT_RT kernels running on S32G platforms.

The NXP STM generates an interrupt only on an exact match between the
counter and the comparator registers. If the counter passes the
programmed value before the comparator takes it into account, the match
is missed and the hardware must count through all 2^32 ticks (~32.2s at
133 MHz) before firing again, causing soft lockups.

Two independent bugs made that possible:

  - The overshoot check in set_next_event() only detected a counter
    wraparound, not the counter advancing past the programmed value
    during the read/write sequence.

  - The channel-enable write at the end of set_next_event() lands after
    the overshoot check. If the counter passes the programmed value
    before the enable write takes effect, the check has already passed
    and the match is missed. No min_delta can close that window.

Patch 1 fixes max_delta: on 64-bit platforms, ULONG_MAX exceeds the
hardware's 32-bit compare register width, making it possible to program
an unreachable compare value.

Patch 2 replaces the broken overshoot check with a margin based
comparison following the pattern of hpet_clkevt_set_next_event(), and
derives the minimum programming delta from that margin.

Patch 3 keeps the compare channel armed for the whole ONESHOT operation
and manages it from the state callbacks, like the HPET driver does, so
that the comparator write is the last hardware access of the programming
path and is covered by the overshoot check.

With this in place, any delay of the programming sequence - however
long the accesses to the timer module are stalled - degrades to a
-ETIME retry by the clockevents core instead of a 32-bit wraparound
stall.

Measurement procedure for the overshoot constants
--------------------------------------------------

Both constants (STM_MIN_CYCLES and STM_MIN_PROG_DELTA) are sized from
measurements on S32G, collected with temporary instrumentation on
compare channel 1 (which the driver never touches):

  - A write-to-match sweep programs the comparator at CNT + n for
    increasing n and measures how far the counter advances between the
    ordering read and the comparator write taking effect. Targets
    within ~32 ticks are never reachable (the write needs at least
    that long to land) and the window grows beyond ~256 ticks under
    bus stress. No misses were seen at larger targets, so the landing
    window is bounded on this platform. STM_MIN_CYCLES = 512 keeps a
    factor of two on the observed tail.

  - Tracking the read/write/read round trip of set_next_event() under
    the lockup reproducer (stress-ng matrix/memthrash plus 1ns
    clock_nanosleep hammers) shows a worst case of 574 counter ticks
    (~4.3us at 133 MHz), against ~146 ticks (~1.1us) without load.

The minimum programming delta must absorb the worst case round trip and
still leave STM_MIN_CYCLES to the event when it reaches the check,
otherwise a minimum delta program fails deterministically and spins in
-ETIME retries (CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST is not selected
on arm64). 574 + 512 exceeds the HPET-derived 1.5 * STM_MIN_CYCLES =
768, so that factor does not cover this platform; use
STM_MIN_PROG_DELTA = 3 * STM_MIN_CYCLES = 1536 ticks (~11.5us), which
covers the measured worst case with headroom.

Reproducer
----------

The lockup can be reproduced on an unpatched S32G board with:

  # ./trigger_lockup &
  # stress-ng --matrix 0 --memthrash 0 & dmesg -w | grep -i "soft lockup"

Where trigger_lockup.c is:

  #define _GNU_SOURCE
  #include <stdio.h>
  #include <stdlib.h>
  #include <time.h>
  #include <pthread.h>
  #include <sched.h>
  #include <unistd.h>

  void *timer_hammer(void *arg) {
      long cpu = (long)arg;
      cpu_set_t cpuset;
      CPU_ZERO(&cpuset);
      CPU_SET(cpu, &cpuset);
      pthread_setaffinity_np(pthread_self(), sizeof(cpu_set_t), &cpuset);

      /* Request 1 ns to force the kernel to clamp to min_delta (2 us) */
      struct timespec req = { .tv_sec = 0, .tv_nsec = 1 };

      while (1) {
          clock_nanosleep(CLOCK_MONOTONIC, 0, &req, NULL);
      }
      return NULL;
  }

  int main(void) {
      long ncpus = sysconf(_SC_NPROCESSORS_ONLN);
      pthread_t threads[ncpus];

      printf("[+] Hammering hrtimers with minimal deltas across %ld cores...\n", ncpus);
      printf("[+] Check dmesg for: 'BUG: soft lockup - CPU#... stuck for 32s!'\n");

      for (long i = 0; i < ncpus; i++) {
          pthread_create(&threads[i], NULL, timer_hammer, (void *)i);
      }

      for (long i = 0; i < ncpus; i++) {
          pthread_join(threads[i], NULL);
      }
      return 0;
  }

The soft lockup trace looks like:

  watchdog: BUG: soft lockup - CPU#1 stuck for 32s! [swapper/1:0]
  Modules linked in: nft_ct nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft
   nft_masq nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
   nf_tables veth bridge stp llc rfkill binfmt_misc nls_ascii nls_cp437 vfat
   fat ina2xx rtc_pcf85063 regmap_spi micrel phy_package aquantia crc_itu_t
   ci_hdrc_imx dwmac_s32 crct10dif_ce ci_hdrc ghash_ce sha2_ce sha256_arm64
   sha1_arm64_ce udc_core stmmac ulpi phy_generic pcs_xpcs usbmisc_imx
   phylink ptp pps_core i2c_imx fsl_edma virt_dma flexcan can_dev s32g_wdt
   watchdog sch_fq_codel drm fuse drm_panel_orientation_quirks nfnetlink
   dmi_sysfs ipv6
  CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Tainted: G               X   ------  ---   6.12.0-274.el10iv.aarch64 #1 PREEMPT_RT
  Tainted: [X]=AUX
  Hardware name: Unknown Unknown Product/Unknown Product, BIOS 2022.04-15.el10_4 04/01/2022
  pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : default_idle_call+0x3c/0x170
  lr : default_idle_call+0x30/0x170
  sp : ffff80008011bdd0
  x29: ffff80008011bdd0 x28: 0000000000000000 x27: 0000000000000000
  x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
  x23: 00000000000000c0 x22: ffff0008803ac840 x21: ffff0008803ac840
  x20: 0000000000000000 x19: 0000000000000000 x18: 0000000000000000
  x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
  x14: 003369266b813144 x13: 0000000000000000 x12: 00000000000002eb
  x11: 00000000000000c0 x10: 00000000000010a0 x9 : ffff800080350ff4
  x8 : ffff0008803ad940 x7 : 0000000000000000 x6 : 0000000000000000
  x5 : 0000000000000004 x4 : 000000000c1c684 x3 : 0000000000000001
  x2 : ffff0008803ac840 x1 : ffff800081712628 x0 : 0000000000000001
  Call trace:
   default_idle_call+0x3c/0x170 (P)
   cpuidle_idle_call+0x1a8/0x248
   do_idle+0xa4/0x118
   cpu_startup_entry+0x3c/0x50
   secondary_start_kernel+0x124/0x168
   __secondary_switched+0xc0/0xc8
  hrtimer: interrupt took 7246 ns

Signed-off-by: Enric Balletbo i Serra <eballetb@redhat.com>
---
Changes in v3:
- Code review and commit message editing assisted by Claude:claude-opus-4-6.
- Rework the overshoot check following review feedback on v2: replace
  the signed <= 0 comparison with a margin based check in the style of
  hpet_clkevt_set_next_event(), and derive min_delta from the margin
  (3 * STM_MIN_CYCLES) instead of increasing it to a fixed 20us.
- Add a new patch which keeps the compare channel armed during the
  whole ONESHOT operation instead of enabling it on every event: the
  trailing channel-enable write was a posted write landing after the
  overshoot check, which no min_delta could compensate for.
- Size the margin constants from measurements on S32G instead of the
  estimated timings.

Changes in v2:
- Update the code comment in nxp_stm_clockevent_starting_cpu() and the
  commit message: clarify that 20us prevents repeated -ETIME retry
  latency, removing the misleading reference to 32s wraparounds.
- Link to v1: https://lore.kernel.org/r/20261026-nxp-stm-fixes-v1-0-20a64a4ea454@redhat.com

---
Enric Balletbo i Serra (3):
      clocksource/drivers/nxp-stm: Fix max_delta overflow on 64-bit platforms
      clocksource/drivers/nxp-stm: Fix overshoot detection in set_next_event
      clocksource/drivers/nxp-stm: Arm the compare channel from the state callbacks

 drivers/clocksource/timer-nxp-stm.c | 101 +++++++++++++++++++++++-------------
 1 file changed, 65 insertions(+), 36 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261023-nxp-stm-fixes-ab0163517e6f

Best regards,
-- 
Enric Balletbo i Serra <eballetb@redhat.com>

