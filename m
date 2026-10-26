Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793004296;
	b=za4SBTJoXzUQ03GwSlruishNezmSyni0KPU4oHq4kX2Ah2BNkh47cYK5HqFEeUZ5d10T
	 HIpB5HkxPt7k2vqxx3+F+Pu+J1vQ2sLV8OjctC7cu6GZoQ9f3UiyedSDxOSB3NAeE5p3J
	 +9W7o+jnEWOjV5X3FRYEqusFZJ5Y+Mda5cpuEDdz/V0v5T2KUfQU1nQmLturgm15mJbLy
	 rmQUIOZqBfqyZkJ/UQeW13J85p7reEerBaktwUHWfnAexbcbaGi4TS938UOjovosCNhdg
	 NkGXFxUjcjEfd8Xrdlg6Q6f0XVUH7LA00oZO8cB0mQZJHdDvaNyKipSpiFjYO0krfBg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004296;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=OAfgX65a/QFj4UirNq++xxNZC+ATBf+H1g6g+fmD/c8=;
	b=He1roGH0RbjG3P6tOlOmi40gVHrGp4JXQWIMxhTgTR5v57A+fSp7BzDn1Jgu9lRH57R/
	 ATtw6FYDcW2HHgNw6CA1/547NADItAFeQjtGNzwLTSuggLFFl8LIyDYscjwtggxkgboYW
	 GxsM+P3t+zwixNkM55JotRbvYXkmqI4x8d2Sq58fwj70MZ8yVA17mQz87GjJX3Y2U+5o7
	 So6VUQXSVgQlYWpsAA87sheUwcBfhcfXNUFrJ3EiZEKf4nrXvSN3GgqAWe5QFjz3+raWp
	 YjecmaBm05D1HJEfcKs0iSAadxs6of5Qe3QW+0JZvwuIJ/7FD8X1HmnqRTxsusCcp4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=blm2QrNL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FEC606A31D;
	Mon, 26 Oct 2026 08:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=blm2QrNL
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793004295;
	b=nZHRMhTQAuJTSe0cGidINg3rSUa/hzZHS0zfJVAu0uW509lmKO/taO2UrE6giSlpl5Zw
	 SbAVjSIGDiv57jFrQhfXifUOFHY9rSbkeMk1BY/SWOq09zpnLZFlB8dO60Z5cHsW1kRmz
	 LVFNfLLD6WqPKEclFwVPvLNMEV4PDdBVJeISL77owyWxJshG63nmgNx58j6w6VXXSx1Pm
	 d2oYNXaDC7EEPfRHt7aeEev7/ECTSSOgO6KvXYLuK1fu8u6DsP7NqdKaMLcBzlLAsWxtU
	 GIDsjjsoyzvM4d5+gpclOU5sb9VqxFuZBUXBoRhwwAOAZJustypV7xZpRbEnITkOMHg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793004295;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=OAfgX65a/QFj4UirNq++xxNZC+ATBf+H1g6g+fmD/c8=;
	b=XEEr4c+ITDhcNsRurfoiZUgKqdfGb6NPIulGAUXHOHif0ZqWgqnfDcONi/SVC3llWiot
	 blHAl3ADQC8kkFGGhCVePUaJ7F0SAD8xawNN/fKCnZ581cA3cTj7eWGd1e3MtbYoifQ18
	 Al8UpiPGhDzIyh+tZtmBwlJ2A1gfJgnljMWSZ7nU+5NaHHZbe+e6A/124uHV2B5XQ46yG
	 rxhw1dznDnO0Gm5W/3q5FMEwCmCEdoZuu6hUxJ/HI68jzxo4GV7wVvmeYenpQwM1uv4hk
	 O8q7TjxbbjbKKlU/hzi0SaHX+g0F2Dj2Vn2kLZWqaoncDZN/iyUvkV9cPXShoQonyWA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6D81F1F01829;
	Mon, 26 Oct 2026 08:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793004295;
	bh=OAfgX65a/QFj4UirNq++xxNZC+ATBf+H1g6g+fmD/c8=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=blm2QrNLI+uWsYx6tBxlwKMffXmoe49q8BhGH7WLXrPoEIvFckjCfbSpzL/Qbes9r
	 OQfQxmWtv0wiXqK9T+bMyeCSNv8rVat0ycemOmuGfqXPEDhXT/NL9A/VJhEdgCrvMZ
	 ItL4EUbHu118MW2AQ9z0uO9AK7MtNfaGUwMUuy3PA15ROXJJu/5MM9f9OMoMig5FUe
	 9SXUP9qQBIGi4sybNL+B4OYUTBd/bjxkmfTKN8RihCiIXzMfQqUfnRO3YmkOdh6aex
	 m3lWqdIrq8iYBXZgJTd10Hr01+Q1ToRZWJ3iDurFeei2UA2uMGq+AxbSLJr/XvwU9O
	 9z+65TiPjAAdA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BE33E44C6F;
	Mon, 26 Oct 2026 08:44:53 +0000 (UTC)
From: Enric Balletbo i Serra via B4 Relay <devnull+eballetb.redhat.com@kernel.org>
Subject: [PATCH 0/3] Fix NXP STM clockevent bugs causing lockups
Date: Mon, 26 Oct 2026 09:44:31 +0100
Message-Id: <20261026-nxp-stm-fixes-v1-0-20a64a4ea454@redhat.com>
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
X-B4-Tracking: v=1; b=H4sIAO8S32oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAyNj3byKAt3iklzdtMyK1GLdxCQDQzNjU0PzVLM0JaCegqJUsARQS3R
 sbS0AvhROTl8AAAA=
X-Change-ID: 20261023-nxp-stm-fixes-ab0163517e6f
To: Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev, 
 Enric Balletbo i Serra <eballetb@redhat.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793004293; l=5228;
 i=eballetb@redhat.com; s=20261026; h=from:subject:message-id;
 bh=08lTI33Sdf9zCMLJMIsZtZpCMAqAudngaQhHF26oVdA=;
 b=fRZeajCkMIRg/d5oo/VDVNqhfytHOA91B+qlk8sR8AMsv+Wz0lsO4ih2lq0sAXOSLBf2LmKTr
 RNHcShbeZAJAYWsVgWsHHoZf5IXffIxJuySdgxo1nTV8F2025ExDOX1
X-Developer-Key: i=eballetb@redhat.com; a=ed25519;
 pk=5zh6xuAxTiQwglL2NXQFqWuyRPmCE8T5KPXLbNXhnKI=
X-Endpoint-Received: by B4 Relay for eballetb@redhat.com/20261026 with
 auth_id=1324
X-Original-From: Enric Balletbo i Serra <eballetb@redhat.com>
Reply-To: eballetb@redhat.com

This series fixes three bugs in the NXP STM clocksource driver that can
cause soft lockups and missed timer events, particularly visible on
PREEMPT_RT kernels running on S32G platforms.

The NXP STM generates an interrupt only on exact match between the
counter and comparator registers. If the counter passes the programmed
value, the match is missed and the hardware must count through all 2^32
ticks (~32.2s at 133 MHz) before firing, causing soft lockups.

Patch 1 fixes max_delta: on 64-bit platforms, ULONG_MAX exceeds the
hardware's 32-bit compare register width, making it possible to program
an unreachable compare value.

Patch 2 fixes the overshoot detection in set_next_event: the existing
check only detected counter wraps, not the normal case where the counter
advances past the programmed value during the read-modify-write window.
Replace it with a signed comparison following the pattern used by
timer-imx-gpt.

Patch 3 increases min_delta from 2us to 20us: under bus contention on
PREEMPT_RT, 2us is not enough margin and the counter frequently
overshoots the programmed value, triggering repeated -ETIME retries.

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
  Modules linked in: nft_ct nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
   nft_masq nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
   nf_tables veth bridge stp llc rfkill binfmt_misc nls_ascii nls_cp437 vfat
   fat ina2xx rtc_pcf85063 regmap_spi micrel phy_package aquantia crc_itu_t
   ci_hdrc_imx dwmac_s32 crct10dif_ce ci_hdrc ghash_ce stmmac_platform
   sha2_ce sha256_arm64 sha1_ce udc_core stmmac ulpi phy_generic pcs_xpcs
   usbmisc_imx phylink ptp pps_core i2c_imx fsl_edma virt_dma flexcan
   can_dev s32g_wdt watchdog sch_fq_codel drm fuse drm_panel_orientation_quirks
   nfnetlink dmi_sysfs ipv6
  CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Tainted: G               X   ------  ---  6.12.0-274.el10iv.aarch64 #1 PREEMPT_RT
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
  x5 : 0000000000000004 x4 : 0000000000c1c684 x3 : 0000000000000001
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
Enric Balletbo i Serra (3):
      clocksource/drivers/nxp-stm: Fix max_delta overflow on 64-bit platforms
      clocksource/drivers/nxp-stm: Fix missed comparator match in set_next_event
      clocksource/drivers/nxp-stm: Increase min_delta to 20us for PREEMPT_RT

 drivers/clocksource/timer-nxp-stm.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)
---
base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
change-id: 20261023-nxp-stm-fixes-ab0163517e6f

Best regards,
-- 
Enric Balletbo i Serra <eballetb@redhat.com>


