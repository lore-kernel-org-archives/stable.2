Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806964CB8B8
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 13:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788786039; cv=none; b=kl88dkWQtA4/vu/XCckIHSRNY8gYIuwPFcA7zBNTSOQihqPbWHWAaZkzE63Th50yb/QCu5DRXvmoc2b3xo16ASxO4gTJuK1ZXxAnopzDr9QQxndbgcHrwfW022dlTe49wsyzoYhAfYJH0T0RPMBFasUFhTfuL5cUwJ5csAU4+Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788786039; c=relaxed/simple;
	bh=MCzESXVxFmaGcGL1gkNk6NeKEQufHfHnkw8hzZGVrCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=leUvC09DWvL5JrvHfk/ZvErIpF6pWPl0kcMexR1HfvROeQwrVMZxdTwBQky7iGloYCBOyjDCFXqwGg3ugnSJAwZbvhq6SYh0DTXAdhHefCNQXBFsCoAZg6Ofa4F8kCtHeZmzRLaTA15ZWOFZhDA5XxgDMkfv5ETEBEuy0vyh8hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvjSkFUt; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvjSkFUt"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cfbdac7a1so865305e9.1
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 06:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788786022; x=1789390822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eMVNQCd6i4RG6aVc2yBHhkRh+QAlwsGwWBLxiEeQYU0=;
        b=YvjSkFUtSD6KJiVBazJasU2AQLZ6mQeoFXe224JtmLqpWUXLXale3U85j+AWq7HVmY
         YG5Hoq8XuX75p3eLM/XNHEdQzJq/2GE+A9ZeNE7Udt4jxOyZlGBWv/+Ca6bmF0fPje84
         9MUAcZiVpmpC0NNhrjY+J+zJe/rXHmqXRfw9JWcYPeB1j+tPDSlYdbutcTqYrXgos89a
         M6jlO9pGK0F6rlk5JSqtV37E/+oINOOiv+o8xuXjSPyjt09YeucshviDOQbt5OiX2Ru+
         xC3lF5+mgiTAYUhxC95QlwPlqKH0ZRfbQUZx6X6WzkJ9vYemfKo8APfmGT9uafO4Xtx6
         wxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788786022; x=1789390822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eMVNQCd6i4RG6aVc2yBHhkRh+QAlwsGwWBLxiEeQYU0=;
        b=tFN6GSg5vTP7jUqlSuB9aSta2jqdXZAny9BvbfD9f0/yk/WPSbre1NwmtEDXTyp/r4
         h3eF6g95kPN/7DejpUbMISXxV5FsaO/FZ+B6PhyDXv/KvG/Cd9n8xO39QThzDC4tQK5s
         45hEMak2tm5kQk4OcuupOyO57ccDtiPrc0Gwg5/OMGNCP3wmD9LozSM+6R5rx5D9B6j7
         28mYYh3F374NSeg84nkYP90VPUvTOp2bcsJbsrp5ywWl78PyPVgImczdwI3Tb1tQZ7/h
         6PBIOffIoBQBQblTiYKcg+MXyy413Afm3q/u+eUf7np9lPaTbI3l0afFQx4cWjL/h8QS
         bB7Q==
X-Forwarded-Encrypted: i=1; AKwUvBw8I8qCESbV+XfoiZMYFGtydBU6LFx+ThaI0nAvIebJupy62oYek0cYRfdCSlEM88SsPbtGVpg=@vger.kernel.org
X-Gm-Message-State: AFuF++l02N09C+YPOv4FvLKblhJrzf9ex/tRKaTRAUvD1LqWedVcAjDe
	rspfLg6FEY1fXzsmHeXYdGa/nUAssPqOS2aOLAptdiPsFrblTxBbpTUh
X-Gm-Gg: AYBFou2b0tmgp7gJeOJJJgG/P89On3cwA+7/d3KKXcr5QLAwRV/4Nkg+mUm2bQohjxz
	I6jwg0IkXDSObzHeCQQkxB6EpMHVdOCZ9AkUZH0V+jJ3YuMhamuLq7RFHkXhGV/1+qTwCrIrMP5
	qb2d0CVm9fxwGe9uM1eULOgh9QUQy14KWZ/vojH16INI2cmW6zwhmPnVBa/h/cU8nzZbzB3IdyX
	YbwTaZYqcAsGimK+nQ1FlS2b0UKb5sv739HZBqtOK++DePRMmPM9dtEY/qYAJqNJYOR7CCUFvST
	qmF2d/NcGW7BMB4jck6sI7nYPuRPf11WWo0783NFwOFbbsWWj6M0XUq5HHeQIRIQASLRU3uX9PT
	CWBwaayBCO6cyRaG1UL5Dx5+u8yVqOw6+A3Wuv4DRMi95EnyTCJC0DmKJLCQhXthKq+4VbKoKSq
	fmpBsOn3ivB+EbQXQSZ7OERPmtf8HL43uiDC26lHc9QgIfCqKA0Wd0Mac/q1IKupIWiENzcqf/y
	gf+CQ0VWA2/qKhullR+gaRdOt2ARWHg4LtuBet2grR9p/BEL0yg2as1BZxAGwdlt91cQrJBDzlw
	Sm35
X-Received: by 2002:a05:600c:3b25:b0:49b:910c:76fb with SMTP id 5b1f17b1804b1-49d01dd415bmr124724415e9.2.1788786021284;
        Mon, 07 Sep 2026 06:00:21 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME (20014C4E1B8822007B3AD9A87B9E27CB.dsl.pool.telekom.hu. [2001:4c4e:1b88:2200:7b3a:d9a8:7b9e:27cb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5533ffbsm318152775e9.3.2026.09.07.06.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 06:00:20 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Frank Zhang <rmxpzlb@gmail.com>
Cc: Igor Paunovic <royalnet026@gmail.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	daniels@collabora.com,
	dmitry.baryshkov@oss.qualcomm.com,
	heiko@sntech.de,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] drm/bridge: dw-hdmi-qp: Guard clear_audio_infoframe when PHY is down
Date: Mon,  7 Sep 2026 14:59:54 +0200
Message-ID: <20260907153000.hdmiqp-audio-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512103153.8861-1-rmxpzlb@gmail.com>
References: <20260512103153.8861-1-rmxpzlb@gmail.com> <b89a3039-05b7-4e4f-8306-07a37d2bd3c9@collabora.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Frank, Cristian,

Independent hit of the same crash, in case it helps get this one moving
again.

Board: Rockchip RK3588, Orange Pi 5 Plus. Kernel: 7.2.0-rc7 with the
Collabora dw-hdmi-qp HDMI 2.1/FRL work on top (so not plain mainline, but
the audio shutdown path is the same code). Userspace: PipeWire/WirePlumber.

At that boot the HDMI link never came up (the sink did not answer SCDC),
so every snd_soc_dai_prepare() failed with -ENODEV, and about five seconds
later WirePlumber closing the PCM took the same path your patch guards:

  snd_pcm_release -> hdmi_codec_shutdown
    -> drm_connector_hdmi_audio_shutdown
    -> dw_hdmi_qp_audio_disable
    -> drm_atomic_helper_connector_hdmi_clear_audio_infoframe
    -> dw_hdmi_qp_bridge_clear_audio_infoframe
    -> regmap_update_bits (read) -> SError, panic

Serial console excerpt (7.2.0-rc7, tmds_char_rate was 0 at that point):

[   16.597316] hdmi-audio-codec hdmi-audio-codec.7.auto: ASoC error (-19): at snd_soc_dai_prepare() on i2s-hifi   (x4)
[   16.601847] SError Interrupt on CPU5, code 0x00000000be000011 -- SError
[   16.601852] CPU: 5 UID: 112 PID: 2821 Comm: wireplumber Tainted: G   M       OE       7.2.0-rc7-rk3588-igor-claude-hdr2+ #10 PREEMPT(lazy)
[   16.601862] pc : regmap_mmio_read32le+0x38/0xf0
[   16.601867] lr : regmap_mmio_read+0x50/0x98
[...]
[   16.601903] Call trace:
[   16.601904]  show_stack+0x24/0x50 (C)
[   16.601908]  dump_stack_lvl+0xe0/0x140
[   16.601912]  dump_stack+0x1c/0x38
[   16.601915]  vpanic+0x4e8/0x5b0
[   16.601919]  panic+0x6c/0x78
[   16.601921]  nmi_panic+0x8c/0x98
[   16.601924]  arm64_serror_panic+0x7c/0x98
[   16.601927]  arm64_is_fatal_ras_serror+0xa8/0xb0
[   16.601930]  do_serror+0x3c/0x78
[   16.601932]  el1h_64_error_handler+0x40/0x80
[   16.601937]  el1h_64_error+0x84/0x88
[   16.601938]  regmap_mmio_read32le+0x38/0xf0 (P)
[   16.601941]  regmap_mmio_read+0x50/0x98
[   16.601943]  _regmap_bus_reg_read+0x68/0xd0
[   16.601947]  _regmap_read+0x80/0x2a8
[   16.601950]  _regmap_update_bits+0x13c/0x1e0
[   16.601953]  regmap_update_bits_base+0x70/0xd0
[   16.601956]  dw_hdmi_qp_bridge_clear_audio_infoframe+0x3c/0x78 [dw_hdmi_qp]
[   16.601964]  drm_bridge_connector_clear_audio_infoframe+0x2c/0x68 [drm_display_helper]
[   16.601993]  clear_infoframe+0x5c/0x128 [drm_display_helper]
[   16.602016]  drm_atomic_helper_connector_hdmi_clear_audio_infoframe+0x70/0x110 [drm_display_helper]
[   16.602039]  dw_hdmi_qp_audio_disable+0x28/0x108 [dw_hdmi_qp]
[   16.602042]  drm_bridge_connector_audio_shutdown+0x38/0x80 [drm_display_helper]
[   16.602065]  drm_connector_hdmi_audio_shutdown+0x28/0x50 [drm_display_helper]
[   16.602086]  hdmi_codec_shutdown+0x68/0xb0 [snd_soc_hdmi_codec]
[   16.602091]  snd_soc_dai_shutdown+0x60/0xe0 [snd_soc_core]
[   16.602123]  soc_pcm_clean.isra.0+0x5c/0x1f8 [snd_soc_core]
[   16.602151]  soc_pcm_close+0x40/0x80 [snd_soc_core]
[   16.602177]  snd_pcm_release_substream.part.0+0x48/0xf0 [snd_pcm]
[   16.602193]  snd_pcm_release+0x68/0x110 [snd_pcm]
[   16.602205]  __fput+0xe4/0x340
[   16.602209]  fput_close_sync+0x4c/0x138
[   16.602211]  __arm64_sys_close+0x44/0xa0
[   16.602215]  invoke_syscall+0xa8/0x138
[   16.602217]  el0_svc_common.constprop.0+0x114/0x140
[   16.602219]  do_el0_svc+0x28/0x58
[   16.602222]  el0_svc+0x48/0x310
[   16.602225]  el0t_64_sync_handler+0xc0/0x108

So the asymmetry is exactly what you describe: audio_enable/prepare check
hdmi->tmds_char_rate, audio_disable does not, and the read-modify-write in
clear_audio_infoframe hits the block with the PHY down.

Today I could reproduce it on demand, with the in-tree module of the same
kernel: disable one HDMI output in the compositor (KWin, so
atomic_disable() runs: tmds_char_rate = 0, PHY off), then

  aplay -D plughw:hdmi1,0 /usr/share/sounds/alsa/Front_Center.wav

open succeeds, prepare logs the usual "ASoC error (-19)", and the close
that follows dies in the same place, this time as a synchronous abort:

  Internal error: synchronous external abort: 0000000096000010 [#1] SMP
  pc : regmap_mmio_read32le+0x30/0xf0
  ...
  dw_hdmi_qp_bridge_clear_audio_infoframe+0x3c/0x78 [dw_hdmi_qp]
  drm_bridge_connector_clear_audio_infoframe+0x2c/0x68 [drm_display_helper]
  drm_atomic_helper_connector_hdmi_clear_audio_infoframe+0x70/0x110 [drm_display_helper]
  dw_hdmi_qp_audio_disable+0x28/0x108 [dw_hdmi_qp]
  hdmi_codec_shutdown+0x68/0xb0 [snd_soc_hdmi_codec]
  snd_soc_dai_shutdown+0x60/0xe0 [snd_soc_core]
  soc_pcm_close+0x40/0x80 [snd_soc_core]
  snd_pcm_release+0x68/0x110 [snd_pcm]
  __arm64_sys_close+0x44/0xa0
  note: aplay[52181] exited with irqs disabled
  note: aplay[52181] exited with preempt_count 1

(x19 = 0xffff800081ca0aa8, i.e. PKTSCHED_PKT_EN.) One more consequence of
the non-fatal variant that may be worth a line in the changelog: the task
dies while snd_pcm_release() is still holding the PCM's open_mutex, so
every later open() of that PCM blocks in D state until reboot - the card
is gone for the session. The reboot after that hung too (soft lockup in
rcu_exp_gp_kthread, a CPU never answering the NMI - I don't have a clean
causal chain for that second hang) and ended in a hard reset.

I read Cristian's comment on v4 - if you post a v5 that reuses
dw_hdmi_qp_bridge_clear_audio_infoframe() from the write path instead of
open-coding it, I am happy to run it on this board and reply with a
Tested-by. I have a serial console attached, so the negative case (PCM close
after the link failed to train) is something I can exercise here.

Thanks,
Igor
