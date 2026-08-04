Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2887141B8E8;
	Tue,  4 Aug 2026 08:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833283; cv=none; b=YacK0DHnG2eOAUxZRIhs2sMDHr+lfrlZ6arHfWBX2oqIxA1m4RmOsMeO+7yGQrOrIRnkrRCRso9aAK4eAb4ZFsFZ5vgpPXgH+VnnKr7IV5lX3flE3ejfLGKZebQjax4NuF4T2toQ+BgUDKKkOz11Mo34sBsMbU/d9dFhuwocA44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833283; c=relaxed/simple;
	bh=qwGGcTkta0xGILUTKA3PC5S2tp5GWVVL8Ar+nltQ1H4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ejrnOsFU9qGjY+eTyqJLOlnXBB5+EjTxKvoqICuP1ltsrF3bBTsdM2JZv+tWRaove6mbUw+HMPOI07PFxFC4/1sUoBvAT5HEAG9sK2wL3rwsGp8MCZPyZxN67lo1ep6OL+FO1mqM4r8+eybzu2JGNYMvKex4OseficwBCbESGog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=p+NKlwdW; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="p+NKlwdW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785833278; x=1786438078; i=deller@gmx.de;
	bh=BR1bDdbGEuqgZ9T5I8Wt6ZWjRwaVKXJVhCkhE88R5ls=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=p+NKlwdW8BoJvqJEpTCmUNXvBUm7mYp0l5mXb0zLwcpgdlIDxPtKKT32AuybUmB9
	 BI42xLFWrUvfEg9EycOaxDYquTtmJH0XHduMjTCijzcP9wK295pLMOP5wHcLkK8gD
	 fuMsWiskCUxzDQ1PSJi968ZlJaAn5Yd6mJQSfUSS+tPoXVaqfvj2rcEJsUQ095Vfm
	 fZ2OVGCqHcZUE49PdFMbEBfO0XFYc2hb2oooG2gZmzo7ECT0fXxo6LG9D/kGSOHIe
	 J48YsuqInv7Sx8gBtzMefyJHEUcrswscFNy/gKElapcwMxW4Y2AKd6ITRxy2w0Grb
	 LcYGgUdeutLZjNnTyQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MORAa-1wZ73Y0L0A-00YXTw; Tue, 04
 Aug 2026 10:47:58 +0200
Message-ID: <097cec6e-e97c-421f-aa9b-f4370f459593@gmx.de>
Date: Tue, 4 Aug 2026 10:47:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: ssd1307fb: defer I2C transfers from damage
 callbacks
To: sh_def@163.com, linux-fbdev@vger.kernel.org
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Abdun Nihaal <nihaal@cse.iitm.ac.in>, Maxime Ripard <mripard@kernel.org>,
 Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Andrew Morton <akpm@linux-foundation.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260803183957.3481000-1-sh_def@163.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260803183957.3481000-1-sh_def@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XJkSxBEeYwh/WNUNBvdLgHB81M7uDVOzMgOW627jp+M1vhsWXeN
 TabZYZNpYxz+Vwa0XUduMMvpVDpsulyZIAsoH1rpZNwMt91LOJTsoVCVsC1xn6bO3iM8ADw
 GERgtsVhkmZLYrnOiwBZfoDrqvZZP7mHa8762SWPwJcZxLpeuKG63a8/jJqwBcbRGxJXKhP
 aA1+mirz5UvMstouyBC0g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:H6cKDsRspwc=;ndR0XJSiu/Bts6ucyIR5tSYoeiu
 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
 k7Wcx9JGnR1114NA==

On 8/3/26 20:39, sh_def@163.com wrote:
> From: Hui Su <sh_def@163.com>
>=20
> The fbdev damage callbacks may run from fbcon while printk has disabled
> preemption.  They currently update the display synchronously, which ente=
rs
> the sleeping I2C transfer path from atomic context.
>=20
> A complete report from an RK3566 system follows:
>=20
>    [  258.129004] watchdog: watchdog0: watchdog did not stop!
>    [  258.129067] BUG: scheduling while atomic: systemd/1/0x00000003
>    [  258.129076] Modules linked in: algif_hash algif_skcipher af_alg bn=
ep
>    binfmt_misc lz4hc lz4 zram snd_soc_hdmi_codec brcmfmac_wcc hci_uart
>    fb_ssd1306(C) fbtft(C) btqca btrtl btintel btsdio snd_soc_simple_card
>    motorcomm pwm_fan snd_soc_simple_card_utils ssd130x_spi nls_iso8859_1
>    ssd130x btbcm drm_shmem_helper display_connector brcmfmac ssd1307fb
>    brcmutil bluetooth cfg80211 rfkill snd_soc_rockchip_i2s_tdm
>    snd_soc_rk817 hantro_vpu snd_soc_core snd_compress snd_pcm_dmaengine
>    v4l2_vp9 snd_pcm v4l2_h264 rockchip_rga snd_timer rk_crypto2
>    spi_rockchip_sfc videobuf2_dma_contig snd sm3_generic v4l2_mem2mem
>    videobuf2_dma_sg dwmac_rk sm3 soundcore videobuf2_memops videobuf2_v4=
l2
>    stmmac_platform dw_hdmi_cec videodev videobuf2_common dw_hdmi_i2s_aud=
io
>    stmmac rk817_charger pcs_xpcs mc cpufreq_dt sch_fq_codel ip_tables
>    x_tables autofs4
>    [  258.129215] Preemption disabled at:
>    [  258.129216] [<ffff80008012f96c>] vprintk_emit+0x11c/0x340
>    [  258.129234] CPU: 0 PID: 1 Comm: systemd Tainted: G         C
>    6.6.0-rc5-rockchip-rk356x #4
>    [  258.129239] Hardware name: Rockchip RK3566 OPi 3B (DT)
>    [  258.129243] Call trace:
>    [  258.129245]  dump_backtrace+0xa0/0x128
>    [  258.129252]  show_stack+0x20/0x38
>    [  258.129256]  dump_stack_lvl+0x60/0xb0
>    [  258.129265]  dump_stack+0x18/0x28
>    [  258.129269]  __schedule_bug+0xa0/0xc8
>    [  258.129274]  __schedule+0x9ac/0xd30
>    [  258.129279]  schedule+0x60/0x100
>    [  258.129282]  schedule_timeout+0x194/0x338
>    [  258.129289]  rk3x_i2c_xfer_common.isra.0+0x384/0x498
>    [  258.129296]  rk3x_i2c_xfer+0x20/0x60
>    [  258.129300]  __i2c_transfer+0x194/0x648
>    [  258.129308]  i2c_transfer+0x9c/0x130
>    [  258.129313]  i2c_transfer_buffer_flags+0x64/0x98
>    [  258.129318]  ssd1307fb_update_rect+0x42c/0x560 [ssd1307fb]
>    [  258.129334]  ssd1307fb_defio_imageblit+0x34/0x50 [ssd1307fb]
>    [  258.129343]  soft_cursor+0x13c/0x210
>    [  258.129350]  bit_cursor+0x2dc/0x550
>    [  258.129354]  fbcon_cursor+0xec/0x108
>    [  258.129359]  hide_cursor+0x44/0xc8
>    [  258.129365]  vt_console_print+0x398/0x3b0
>    [  258.129370]  console_flush_all.isra.0+0x17c/0x410
>    [  258.129377]  console_unlock+0x4c/0x100
>    [  258.129382]  vprintk_emit+0x1c8/0x340
>    [  258.129386]  vprintk_default+0x40/0x58
>    [  258.129389]  vprintk+0xb8/0xd0
>    [  258.129392]  _printk+0x68/0x98
>    [  258.129398]  watchdog_release+0x170/0x230
>    [  258.129404]  __fput+0xbc/0x288
>    [  258.129409]  __fput_sync+0x58/0x70
>    [  258.129413]  __arm64_sys_close+0x40/0x90
>    [  258.129419]  invoke_syscall+0x4c/0x118
>    [  258.129426]  el0_svc_common.constprop.0+0x48/0xf0
>    [  258.129432]  do_el0_svc+0x24/0x38
>    [  258.129437]  el0_svc+0x48/0x100
>    [  258.129443]  el0t_64_sync_handler+0xc0/0xc8
>    [  258.129448]  el0t_64_sync+0x190/0x198
>    [  258.573087] ------------[ cut here ]------------
>    [  258.573098] DEBUG_LOCKS_WARN_ON(val > preempt_count())
>    [  258.573111] WARNING: CPU: 0 PID: 1 at kernel/sched/core.c:5871
>    preempt_count_sub+0x9c/0x148
>    [  258.573130] Modules linked in: algif_hash algif_skcipher af_alg bn=
ep
>    binfmt_misc lz4hc lz4 zram snd_soc_hdmi_codec brcmfmac_wcc hci_uart
>    fb_ssd1306(C) fbtft(C) btqca btrtl btintel btsdio snd_soc_simple_card
>    motorcomm pwm_fan snd_soc_simple_card_utils ssd130x_spi nls_iso8859_1
>    ssd130x btbcm drm_shmem_helper display_connector brcmfmac ssd1307fb
>    brcmutil bluetooth cfg80211 rfkill snd_soc_rockchip_i2s_tdm
>    snd_soc_rk817 hantro_vpu snd_soc_core snd_compress snd_pcm_dmaengine
>    v4l2_vp9 snd_pcm v4l2_h264 rockchip_rga snd_timer rk_crypto2
>    spi_rockchip_sfc videobuf2_dma_contig snd sm3_generic v4l2_mem2mem
>    videobuf2_dma_sg dwmac_rk sm3 soundcore videobuf2_memops videobuf2_v4=
l2
>    stmmac_platform dw_hdmi_cec videodev videobuf2_common dw_hdmi_i2s_aud=
io
>    stmmac rk817_charger pcs_xpcs mc cpufreq_dt sch_fq_codel ip_tables
>    x_tables autofs4
>    [  258.573268] CPU: 0 PID: 1 Comm: systemd Tainted: G        WC
>    6.6.0-rc5-rockchip-rk356x #4
>    [  258.573274] Hardware name: Rockchip RK3566 OPi 3B (DT)
>    ** 37 printk messages dropped **
>    [  258.574064] Preemption disabled at:
>    ** 42 printk messages dropped **
>    [  259.190237] Preemption disabled at:
>=20
> Track damage in the driver's private data under a spinlock and merge
> multiple updates into a bounding rectangle.  Queue the existing
> deferred-I/O work immediately for damage reported by fbdev drawing and
> write helpers, so allocation and I2C transfers run from process context
> without adding the configured mmap refresh delay.  Keep full-screen
> updates for dirty mmap pages, for which no precise rectangle is availabl=
e.
>=20
> Tested on an RK3566 board with a 128x64 OLED by running five rounds of 2=
50
> KERN_EMERG messages in total while issuing framebuffer writes every 15 m=
s.
> No atomic-sleep, preemption, or lockdep warning occurred.  Kprobe tracin=
g
> also confirmed that cursor-only damage remained an 8x16 partial update.
>=20
> Fixes: a2ed00da5047 ("drivers/video: add support for the Solomon SSD1307=
 OLED Controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hui Su <sh_def@163.com>
> ---
>   drivers/video/fbdev/ssd1307fb.c | 72 ++++++++++++++++++++++++++++++---
>   1 file changed, 67 insertions(+), 5 deletions(-)
applied.

Thanks!
Helge
