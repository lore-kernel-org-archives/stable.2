Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793654201;
	b=hws+bTjKOJVDQcG2tm0t3SW0QDNDzDtDFVnvUlP34ui3/eWFS1Hmwxd1fIumKBRvdFGq
	 AwvNNnsa4OeIEb42D0y6TgH3RJXJrakwtHNoGcTO8mEcqwSFKipRjSDCeynIw1+7qDFck
	 5iEjjsH/DtTdKccroD81JkLywS6bMjsJRcQhto2QVN6D0SefhlKpPEn4Yz3JkkppH6uu8
	 oxGZDJKc5lIHFPOAxS8+QQ8Lcmgu6Ks6nO8RZhPIdwggbfNT40DihIGf3tM67dfQT2w20
	 +Vqm1XlbKTkwpMNKi0WOSmm5t2dPDKCYCepntSM4Yps9krikre2rdsNIRLU9NnbE/ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793654201;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=7/zHAAnHn2wJw4FI2Tztua6NqJ8mn1b/uKM41eMSu7E=;
	b=aZGjR6xCBnOIEinTtqt6zHZOZXolWlzJmTWd30z9by4/ucagZHTXg7x3EIYJrPBZhGYW
	 FIuebRAQTESj9cp3CzoGXOsfWRReUOA12xdhnong1yQcUmVM9SiUej1FaVlfiZJwAyKNB
	 fZk9PbMPqsTc//Tt5vk1bN7gzqebrzl9fpDbYAMBzk1wXk+NGoq4mtklt3re5gaqYI7G9
	 3fGuoHUYIylgo8gfCg6H6CH2WQa0q1riAhjjll65HTKkiC7E29P6MTSqToy9F1jxFGpkc
	 q3aca8wCs5Tfm/aTfxmAbh/W91LurBPPfrGkojj/5GFEi3RhAFgfebs6QWq7YShBgkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SEZkFhXo;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=k7LDOrPw;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F40606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 21:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68F40606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SEZkFhXo;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=k7LDOrPw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793654199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7/zHAAnHn2wJw4FI2Tztua6NqJ8mn1b/uKM41eMSu7E=;
	b=SEZkFhXopOGT78rLvSaabE2cfpalMhbPNddBpy+/zS1rzctlRIyMLSE0Yex2cJ+TtpG7b+
	BtshjeC9GXZmJ222CKwVsVXft15TDhfmt3c+0Owm7V/UBVyr1kmQSNLgUoslFnqG3ZlQuE
	bFs7r/Mg1YhmuYNKh0VoaW2mcUKfvXU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-oeQkdE5qMUux5RvDzOnsSQ-1; Mon, 02 Nov 2026 16:16:37 -0500
X-MC-Unique: oeQkdE5qMUux5RvDzOnsSQ-1
X-Mimecast-MFC-AGG-ID: oeQkdE5qMUux5RvDzOnsSQ_1793654196
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48df06cbfccso79128f8f.3
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 13:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793654196; x=1794258996; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7/zHAAnHn2wJw4FI2Tztua6NqJ8mn1b/uKM41eMSu7E=;
        b=k7LDOrPwt8qOLOj81CHmdylBjkQYJhkbdNV0DIIcBcXihpi40t9KlffGc3PE7FnPj2
         yqHfH8nO0kYQv1xx+ItPaIkt4HHyCJ+U+LIpxBJ/AFihfFhyRvGo/fboq361XDTcyw3q
         TgaykDub3VZI/CPqvDwmLxKyb1Y+3UvyyuGNhCaENdk0gQ+qsqSLh+aY4hzjJ4VPPm7o
         4NJC13IrpxMrLNzkIk+7XutG/GI5OHoLKTWj69TP08a5EsvaZiKmuMoIi1MiJfhskuDS
         9tPpIKVLwuVUDxjq5GVTAUqz89BpA9shaslIitY93efW/iESjum7XaGTdompHBvqiy9Z
         qW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793654196; x=1794258996;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7/zHAAnHn2wJw4FI2Tztua6NqJ8mn1b/uKM41eMSu7E=;
        b=V91uuO67GrOikVJ0yrQ0+Lcf5YmH50r+GYzahH42EUXzV5dBq+GM9zZaiHss/qbB9S
         hEdxu4Nsz1hyf0Q+WvLAI+vOZTQPIopKY6Q6zmz/EVIYR2EupxdEuutB4eCzZa2LUPBZ
         thbptcZe1Aiei1pTfE246Epeuueam1I2bk1LDRfI8dPdEd5m/wrnf2V5NwKI5n2cdN0V
         OFK75QLOMoeb8thSaAoXi+LYWgcyCYU5oZLP05KrrjqLz6pcyufnqIvq+G7hdUM/wEaM
         NrHg5UQuCWMX+k5yZh0EuE41KmF3vhjze2DS2QoPLyX7ZXc8ZjkDOxefKJfhH491FEAx
         JoSg==
X-Forwarded-Encrypted: i=1; AKwUvBy7Hb1F3Qvmyi0Z4CbEHh1E+MWxoZ1mtFMp+vhTGgFgdmDbH7oyOeLfejEpCztJPP+fdPjoc3o=@vger.kernel.org
X-Gm-Message-State: AFq9FYLn95I0RX7o2jv3VH+bg78MXwR+eL7DX+Hbeg09RnxLMcLNH/pw
	5K6db1dDu/CmPRLxII4r8dxs3tjBXrFgiWLe/WodwhwzldF693go2eERZA7YvcpD28+nual+ORV
	xfr/wpkyi3g9SLSno4tbxsx2In2kBCSEkIXUvbJa2oIIB3acy/sAM/DboV15uE2gg2spK
X-Gm-Gg: AYBFou2AMsrUhuS6qcq1WZak7VUjWqFWGCI/vO79sTF0eIjzfbjrSMvPXluk+dxLZqj
	ULjuo3RnxYJQIjg23rVhQfR1NU6HNH0fD8uM5vcRpJEprvZskur9XqdRKtQk0F44ssMzRZmF8sm
	S2hOpM66nD0XyWsF37dRmDN4pIj5VG1hLgAzjxSSSgk8HEC1I+OjpDUuUGKTOLYrSGwtvBJF73x
	qMKdFyLCP/ubccmE9f9om0oNr3aBDL/ssGS7kK6FNYymDTajoumVzBhOeWyfthbGcPBywBiDb7G
	45KaRTf1vCZy1dOC9aZJUzUJ2Si5YBYcvuk4x3NGQ+E7gMhUldsWPbhFZc9+sIquW0TQGrWleFd
	P8DYKSNIrPDvV4g4wNU4y4ObyoV1DMBVPhLji4nyIb3TsnYllh8sDRkepvStxCVPp1luUrUGGUG
	s5qEFazEQQhu/PcQ==
X-Received: by 2002:a05:600c:1c06:b0:4a1:e015:6441 with SMTP id 5b1f17b1804b1-4ac12194311mr313422685e9.0.1793654196422;
        Mon, 02 Nov 2026 13:16:36 -0800 (PST)
X-Received: by 2002:a05:600c:1c06:b0:4a1:e015:6441 with SMTP id 5b1f17b1804b1-4ac12194311mr313422205e9.0.1793654196031;
        Mon, 02 Nov 2026 13:16:36 -0800 (PST)
Received: from localhost (119.red-83-42-172.dynamicip.rima-tde.net. [83.42.172.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ac09cc3e9asm127877535e9.3.2026.11.02.13.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 13:16:35 -0800 (PST)
From: Enric Balletbo i Serra <eballetb@redhat.com>
Subject: [PATCH v2 0/3] Fix NXP STM clockevent bugs causing lockups
Date: Mon, 02 Nov 2026 22:16:19 +0100
Message-Id: <20261102-nxp-stm-fixes-v2-0-8ca2706f30ef@redhat.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12MQQ6DIBBFr2Jm3WkAkSZd9R7GxVTHwkI0QIiN4
 e6lJt10+f7PewdEDo4j3JsDAmcX3eorqEsDoyX/YnRTZVBCGSlUi37fMKYFZ7dzRHoKadpO3tj
 MUJ0t8HlUpR8qWxfTGt5nPsvv+iuZv1KWKFAJMpo0k+70I/BkKV3HdYGhlPIBl1SLL6sAAAA=
X-Change-ID: 20261023-nxp-stm-fixes-ab0163517e6f
To: Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 NXP S32 Linux Team <s32@nxp.com>, stable@vger.kernel.org, 
 Enric Balletbo i Serra <eballetb@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793654192; l=5554;
 i=eballetb@redhat.com; s=20261026; h=from:subject:message-id;
 bh=gmcicsJfJh9puN//IBtAaBXqtgplRQNDdjIGjm20/xM=;
 b=+zeEZ/wMfETqYMhmzlR8m77smYNadIVe/c0BrSz54CSNpTYpH5yuWLg8cDgpUjMa2NAct50iB
 rOtIB+qBtXvA2bDG46ewrK3CJtu8L6RCxYCRJyCPgoABxZoitsh8tgG
X-Developer-Key: i=eballetb@redhat.com; a=ed25519;
 pk=5zh6xuAxTiQwglL2NXQFqWuyRPmCE8T5KPXLbNXhnKI=

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
Changes in v2:
- Update the code comment in nxp_stm_clockevent_starting_cpu() and the
  commit message: clarify that 20us prevents repeated -ETIME retry
  latency, removing the misleading reference to 32s wraparounds.
- Link to v1: https://lore.kernel.org/r/20261026-nxp-stm-fixes-v1-0-20a64a4ea454@redhat.com

---
Enric Balletbo i Serra (3):
      clocksource/drivers/nxp-stm: Fix max_delta overflow on 64-bit platforms
      clocksource/drivers/nxp-stm: Fix missed comparator match in set_next_event
      clocksource/drivers/nxp-stm: Increase min_delta to 20us for PREEMPT_RT

 drivers/clocksource/timer-nxp-stm.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261023-nxp-stm-fixes-ab0163517e6f

Best regards,
-- 
Enric Balletbo i Serra <eballetb@redhat.com>

