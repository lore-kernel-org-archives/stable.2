Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4544F531AE7
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870027; cv=none; b=ZVHkgFIGzefq8gh8qrH9ITg4je0rqz12LV1uFZY/cTW7EEBKxfMC56HcHgBzuY7NgRAZ8qfByMC8QfV5x7h1SWRuzjEAZAgy40rK4Ovz8YbTr/mLwy9lvzfNNX1X3hj9GJg2wv3jxUdFbS3jtx+ksukrtqQGV57wfsRTqF8DhlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870027; c=relaxed/simple;
	bh=PMUFCYE1anyGTMOj906yLMjRieJYS85l2jokeUJGJ5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FQ9MXXsQc/QNet4y3DOePDqqthbI26loCXlm9I8EMKKMLrE90FQiLJaW2jVdk5nw1cvvxJABCMCjiBgVkPsrqZP69OYOU6skI5J07/pMY09B7YVsEkIqFGgRRsPo5dQw01UBVEca4cIbWFdUuw6cKQeh/uphj0T3r5glGN7nj4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC1A1F00A3E;
	Tue,  8 Sep 2026 12:20:21 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hui Su <sh_def@163.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] fbdev: ssd1307fb: defer I2C transfers from damage callbacks
Date: Tue,  8 Sep 2026 08:20:20 -0400
Message-ID: <20260908122020.2050714-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090352-freebie-sprain-0960@gregkh>
References: <2026090352-freebie-sprain-0960@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hui Su <sh_def@163.com>

[ Upstream commit 9ad709afdfa32509ed64938a6d9cd00db3cd54c2 ]

The fbdev damage callbacks may run from fbcon while printk has disabled
preemption.  They currently update the display synchronously, which enters
the sleeping I2C transfer path from atomic context.

A complete report from an RK3566 system follows:

  [  258.129004] watchdog: watchdog0: watchdog did not stop!
  [  258.129067] BUG: scheduling while atomic: systemd/1/0x00000003
  [  258.129076] Modules linked in: algif_hash algif_skcipher af_alg bnep
  binfmt_misc lz4hc lz4 zram snd_soc_hdmi_codec brcmfmac_wcc hci_uart
  fb_ssd1306(C) fbtft(C) btqca btrtl btintel btsdio snd_soc_simple_card
  motorcomm pwm_fan snd_soc_simple_card_utils ssd130x_spi nls_iso8859_1
  ssd130x btbcm drm_shmem_helper display_connector brcmfmac ssd1307fb
  brcmutil bluetooth cfg80211 rfkill snd_soc_rockchip_i2s_tdm
  snd_soc_rk817 hantro_vpu snd_soc_core snd_compress snd_pcm_dmaengine
  v4l2_vp9 snd_pcm v4l2_h264 rockchip_rga snd_timer rk_crypto2
  spi_rockchip_sfc videobuf2_dma_contig snd sm3_generic v4l2_mem2mem
  videobuf2_dma_sg dwmac_rk sm3 soundcore videobuf2_memops videobuf2_v4l2
  stmmac_platform dw_hdmi_cec videodev videobuf2_common dw_hdmi_i2s_audio
  stmmac rk817_charger pcs_xpcs mc cpufreq_dt sch_fq_codel ip_tables
  x_tables autofs4
  [  258.129215] Preemption disabled at:
  [  258.129216] [<ffff80008012f96c>] vprintk_emit+0x11c/0x340
  [  258.129234] CPU: 0 PID: 1 Comm: systemd Tainted: G         C
  6.6.0-rc5-rockchip-rk356x #4
  [  258.129239] Hardware name: Rockchip RK3566 OPi 3B (DT)
  [  258.129243] Call trace:
  [  258.129245]  dump_backtrace+0xa0/0x128
  [  258.129252]  show_stack+0x20/0x38
  [  258.129256]  dump_stack_lvl+0x60/0xb0
  [  258.129265]  dump_stack+0x18/0x28
  [  258.129269]  __schedule_bug+0xa0/0xc8
  [  258.129274]  __schedule+0x9ac/0xd30
  [  258.129279]  schedule+0x60/0x100
  [  258.129282]  schedule_timeout+0x194/0x338
  [  258.129289]  rk3x_i2c_xfer_common.isra.0+0x384/0x498
  [  258.129296]  rk3x_i2c_xfer+0x20/0x60
  [  258.129300]  __i2c_transfer+0x194/0x648
  [  258.129308]  i2c_transfer+0x9c/0x130
  [  258.129313]  i2c_transfer_buffer_flags+0x64/0x98
  [  258.129318]  ssd1307fb_update_rect+0x42c/0x560 [ssd1307fb]
  [  258.129334]  ssd1307fb_defio_imageblit+0x34/0x50 [ssd1307fb]
  [  258.129343]  soft_cursor+0x13c/0x210
  [  258.129350]  bit_cursor+0x2dc/0x550
  [  258.129354]  fbcon_cursor+0xec/0x108
  [  258.129359]  hide_cursor+0x44/0xc8
  [  258.129365]  vt_console_print+0x398/0x3b0
  [  258.129370]  console_flush_all.isra.0+0x17c/0x410
  [  258.129377]  console_unlock+0x4c/0x100
  [  258.129382]  vprintk_emit+0x1c8/0x340
  [  258.129386]  vprintk_default+0x40/0x58
  [  258.129389]  vprintk+0xb8/0xd0
  [  258.129392]  _printk+0x68/0x98
  [  258.129398]  watchdog_release+0x170/0x230
  [  258.129404]  __fput+0xbc/0x288
  [  258.129409]  __fput_sync+0x58/0x70
  [  258.129413]  __arm64_sys_close+0x40/0x90
  [  258.129419]  invoke_syscall+0x4c/0x118
  [  258.129426]  el0_svc_common.constprop.0+0x48/0xf0
  [  258.129432]  do_el0_svc+0x24/0x38
  [  258.129437]  el0_svc+0x48/0x100
  [  258.129443]  el0t_64_sync_handler+0xc0/0xc8
  [  258.129448]  el0t_64_sync+0x190/0x198
  [  258.573087] ------------[ cut here ]------------
  [  258.573098] DEBUG_LOCKS_WARN_ON(val > preempt_count())
  [  258.573111] WARNING: CPU: 0 PID: 1 at kernel/sched/core.c:5871
  preempt_count_sub+0x9c/0x148
  [  258.573130] Modules linked in: algif_hash algif_skcipher af_alg bnep
  binfmt_misc lz4hc lz4 zram snd_soc_hdmi_codec brcmfmac_wcc hci_uart
  fb_ssd1306(C) fbtft(C) btqca btrtl btintel btsdio snd_soc_simple_card
  motorcomm pwm_fan snd_soc_simple_card_utils ssd130x_spi nls_iso8859_1
  ssd130x btbcm drm_shmem_helper display_connector brcmfmac ssd1307fb
  brcmutil bluetooth cfg80211 rfkill snd_soc_rockchip_i2s_tdm
  snd_soc_rk817 hantro_vpu snd_soc_core snd_compress snd_pcm_dmaengine
  v4l2_vp9 snd_pcm v4l2_h264 rockchip_rga snd_timer rk_crypto2
  spi_rockchip_sfc videobuf2_dma_contig snd sm3_generic v4l2_mem2mem
  videobuf2_dma_sg dwmac_rk sm3 soundcore videobuf2_memops videobuf2_v4l2
  stmmac_platform dw_hdmi_cec videodev videobuf2_common dw_hdmi_i2s_audio
  stmmac rk817_charger pcs_xpcs mc cpufreq_dt sch_fq_codel ip_tables
  x_tables autofs4
  [  258.573268] CPU: 0 PID: 1 Comm: systemd Tainted: G        WC
  6.6.0-rc5-rockchip-rk356x #4
  [  258.573274] Hardware name: Rockchip RK3566 OPi 3B (DT)
  ** 37 printk messages dropped **
  [  258.574064] Preemption disabled at:
  ** 42 printk messages dropped **
  [  259.190237] Preemption disabled at:

Track damage in the driver's private data under a spinlock and merge
multiple updates into a bounding rectangle.  Queue the existing
deferred-I/O work immediately for damage reported by fbdev drawing and
write helpers, so allocation and I2C transfers run from process context
without adding the configured mmap refresh delay.  Keep full-screen
updates for dirty mmap pages, for which no precise rectangle is available.

Tested on an RK3566 board with a 128x64 OLED by running five rounds of 250
KERN_EMERG messages in total while issuing framebuffer writes every 15 ms.
No atomic-sleep, preemption, or lockdep warning occurred.  Kprobe tracing
also confirmed that cursor-only damage remained an 8x16 partial update.

Fixes: a2ed00da5047 ("drivers/video: add support for the Solomon SSD1307 OLED Controller")
Cc: stable@vger.kernel.org
Signed-off-by: Hui Su <sh_def@163.com>
Signed-off-by: Helge Deller <deller@gmx.de>
[ adapted partial-rectangle deferred updates to the existing full-screen deferred-I/O worker. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/ssd1307fb.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index fd26d368fdf5c..74a3a7c331435 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -218,7 +218,6 @@ static void ssd1307fb_update_display(struct ssd1307fb_par *par)
 static ssize_t ssd1307fb_write(struct fb_info *info, const char __user *buf,
 		size_t count, loff_t *ppos)
 {
-	struct ssd1307fb_par *par = info->par;
 	unsigned long total_size;
 	unsigned long p = *ppos;
 	void *dst;
@@ -239,7 +238,7 @@ static ssize_t ssd1307fb_write(struct fb_info *info, const char __user *buf,
 	if (copy_from_user(dst, buf, count))
 		return -EFAULT;
 
-	ssd1307fb_update_display(par);
+	mod_delayed_work(system_wq, &info->deferred_work, 0);
 
 	*ppos += count;
 
@@ -258,23 +257,20 @@ static int ssd1307fb_blank(int blank_mode, struct fb_info *info)
 
 static void ssd1307fb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
 {
-	struct ssd1307fb_par *par = info->par;
 	sys_fillrect(info, rect);
-	ssd1307fb_update_display(par);
+	mod_delayed_work(system_wq, &info->deferred_work, 0);
 }
 
 static void ssd1307fb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
 {
-	struct ssd1307fb_par *par = info->par;
 	sys_copyarea(info, area);
-	ssd1307fb_update_display(par);
+	mod_delayed_work(system_wq, &info->deferred_work, 0);
 }
 
 static void ssd1307fb_imageblit(struct fb_info *info, const struct fb_image *image)
 {
-	struct ssd1307fb_par *par = info->par;
 	sys_imageblit(info, image);
-	ssd1307fb_update_display(par);
+	mod_delayed_work(system_wq, &info->deferred_work, 0);
 }
 
 static const struct fb_ops ssd1307fb_ops = {
-- 
2.53.0

