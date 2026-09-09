Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA264CB8B2
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948881; cv=none; b=DioOyy+ZuJYdir4t0fLCQAEtn9FHMWG+BzNZETnnYSHs8fHA99yzRfN85oGtRChAmAwSRvmjWPlQwb+jQ5rRNufbuj1cFj00wwDapQz6TK1G6pu9xzNP2wW+DXiBo3rOEtUtuttnM8+P6krDSvWdx6RQF88F4F43pJfZdYU3uvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948881; c=relaxed/simple;
	bh=OFauPF2CUfSjcRzXa8Qkrp6pQQa6fAVTCMziG5c/gwY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=j3V1QKkV3tqsQEDmUAjWq6Ndcy2L3WvxEuujt63mNclTj1tfVoNuxEw8X3oFG5Ua04FGGrja9N3O50NQZJ+IFT63bZeko6/Vj8FsIH2dMc8+0xCMs8+J3oJzfspXfhb9iSggM8eHrRxH9Un68+AKEcZaHJRNeuxV17BwaPQkcy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V+NHiiKt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V+NHiiKt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA321F00A3F;
	Wed,  9 Sep 2026 10:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788948870;
	bh=wQqWU5HDa79n6PLX0GNrsrl0jVGIVVI3XlEppgvNr0Y=;
	h=Subject:To:Cc:From:Date;
	b=V+NHiiKtp6IOGw/xlQi9lxv1Eh0BahLkBxK3qHyadkIFapa/sjTqXkDt2sdIg/276
	 KXUr7Iq4gl0ffIzbCe/1pGw9xgQX6Ojif72qiriYVQXDFpkv+rdJIgPmRKrUpVMfB7
	 IZpdbBTFD7xjfGqWggunjj6imeiZGuMa523mNwyY=
Subject: FAILED: patch "[PATCH] ASoC: pcm512x: sort the register default table" failed to apply to 5.10-stable tree
To: peter.ujfalusi@linux.intel.com,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:03:37 +0200
Message-ID: <2026090937-awry-woven-fb0a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 767d9ae714e3e9b0ae86237c410fbfca7056570a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090937-awry-woven-fb0a@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 767d9ae714e3e9b0ae86237c410fbfca7056570a Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Date: Wed, 5 Aug 2026 13:41:45 +0300
Subject: [PATCH] ASoC: pcm512x: sort the register default table

reg_defaults must be sorted by ascending register address, as
regcache_lookup_reg() locates entries in it with bsearch().  See commit
fd80df352ba1 ("regcache: Add support for sorting defaults arrays").

PCM512x_AUTO_MUTE (page 0, register 59) is listed before
PCM512x_ERROR_DETECT (page 0, register 37) and PCM512x_VCOM_CTRL_2
(page 1, register 9) is listed before the page 0 clocking block, so the
bsearch() descends into the wrong half of the table.  24 of the 45
entries are unreachable, among them every PLL coefficient and clock
divider default.  regcache_reg_needs_sync() then cannot compare them
against their default and reports that a sync is needed, so they are
written to the device on every regcache_sync() even when they were
never touched.

Sort the table by register address.

Fixes: 5a3af1293194 ("ASoC: pcm512x: Add PCM512x driver")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://patch.msgid.link/20260805104149.9795-2-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index fe3b5011fa16..03b1fcb1bf96 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -78,28 +78,10 @@ static const struct reg_default pcm512x_reg_defaults[] = {
 	{ PCM512x_POWER,             0x00 },
 	{ PCM512x_MUTE,              0x00 },
 	{ PCM512x_DSP,               0x00 },
-	{ PCM512x_PLL_REF,           0x00 },
-	{ PCM512x_DAC_REF,           0x00 },
-	{ PCM512x_DAC_ROUTING,       0x11 },
-	{ PCM512x_DSP_PROGRAM,       0x01 },
-	{ PCM512x_CLKDET,            0x00 },
-	{ PCM512x_AUTO_MUTE,         0x00 },
-	{ PCM512x_ERROR_DETECT,      0x00 },
-	{ PCM512x_DIGITAL_VOLUME_1,  0x00 },
-	{ PCM512x_DIGITAL_VOLUME_2,  0x30 },
-	{ PCM512x_DIGITAL_VOLUME_3,  0x30 },
-	{ PCM512x_DIGITAL_MUTE_1,    0x22 },
-	{ PCM512x_DIGITAL_MUTE_2,    0x00 },
-	{ PCM512x_DIGITAL_MUTE_3,    0x07 },
-	{ PCM512x_OUTPUT_AMPLITUDE,  0x00 },
-	{ PCM512x_ANALOG_GAIN_CTRL,  0x00 },
-	{ PCM512x_UNDERVOLTAGE_PROT, 0x00 },
-	{ PCM512x_ANALOG_MUTE_CTRL,  0x00 },
-	{ PCM512x_ANALOG_GAIN_BOOST, 0x00 },
-	{ PCM512x_VCOM_CTRL_1,       0x00 },
-	{ PCM512x_VCOM_CTRL_2,       0x01 },
 	{ PCM512x_BCLK_LRCLK_CFG,    0x00 },
 	{ PCM512x_MASTER_MODE,       0x7c },
+	{ PCM512x_PLL_REF,           0x00 },
+	{ PCM512x_DAC_REF,           0x00 },
 	{ PCM512x_GPIO_DACIN,        0x00 },
 	{ PCM512x_GPIO_PLLIN,        0x00 },
 	{ PCM512x_SYNCHRONIZE,       0x10 },
@@ -117,8 +99,26 @@ static const struct reg_default pcm512x_reg_defaults[] = {
 	{ PCM512x_FS_SPEED_MODE,     0x00 },
 	{ PCM512x_IDAC_1,            0x01 },
 	{ PCM512x_IDAC_2,            0x00 },
+	{ PCM512x_ERROR_DETECT,      0x00 },
 	{ PCM512x_I2S_1,             0x02 },
 	{ PCM512x_I2S_2,             0x00 },
+	{ PCM512x_DAC_ROUTING,       0x11 },
+	{ PCM512x_DSP_PROGRAM,       0x01 },
+	{ PCM512x_CLKDET,            0x00 },
+	{ PCM512x_AUTO_MUTE,         0x00 },
+	{ PCM512x_DIGITAL_VOLUME_1,  0x00 },
+	{ PCM512x_DIGITAL_VOLUME_2,  0x30 },
+	{ PCM512x_DIGITAL_VOLUME_3,  0x30 },
+	{ PCM512x_DIGITAL_MUTE_1,    0x22 },
+	{ PCM512x_DIGITAL_MUTE_2,    0x00 },
+	{ PCM512x_DIGITAL_MUTE_3,    0x07 },
+	{ PCM512x_OUTPUT_AMPLITUDE,  0x00 },
+	{ PCM512x_ANALOG_GAIN_CTRL,  0x00 },
+	{ PCM512x_UNDERVOLTAGE_PROT, 0x00 },
+	{ PCM512x_ANALOG_MUTE_CTRL,  0x00 },
+	{ PCM512x_ANALOG_GAIN_BOOST, 0x00 },
+	{ PCM512x_VCOM_CTRL_1,       0x00 },
+	{ PCM512x_VCOM_CTRL_2,       0x01 },
 };
 
 static bool pcm512x_readable(struct device *dev, unsigned int reg)

