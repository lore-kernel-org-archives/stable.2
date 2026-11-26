Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.209.128.113
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795680221;
	b=CLuDE/QrfjfdRWJexnr3JV1ne1hO2SIvJusX47IamOY40vWPxg8A+lTn0u98jy5iOMAo
	 figh/fzDf0VIiJ/h/y2Cyspp7/aQ/lFe2divb6Ls8Mw9mTb1yl5/4OJxPnNTt6996cDF4
	 F21MDGmCjQmc2fg+IqImvh+AxMEwGk+51XZvjUhBzKF2Nnwtd8sTN37g3wIjYojsCMuAd
	 zPAKDcN7FPrU3iYIe89STpdu3SS3jERrB4NeA2ioHtF9jSL2v0iIfpuJ5PU57tVsVo7DF
	 dzihV+hqpLK0Xgy6W0KD+UBDoTrNet0JFeaQ5EOUBm8Abc9Vx36c5lxHw6JRYGFcepQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795680221;
	h=DMARC-Filter:Received:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:Thread-Index:Content-Language:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:DKIM-Signature;
	bh=vygooTiSjYbQO8/tsqc0vjgWPN/b7cF63dCgZbTAnpc=;
	b=KpufbiE0gnPN0wLWX2yxqs/TGUn285nbIrhfNY7PCl27+RLcUsc/jCCP8XOJ1I22Z0Yt
	 6zePuAhkf2kaX3Lf8vt7EHhgcqQbVHsYrbS/g5iiKTnveSavXQ2rcelxiYXoVzUt47yRP
	 MhWCm4ojBP2bNh+8ivJ2gSsgzPD6Ea3o1/fkLX7EnNOWLYnIK+O0w0/ihgBExzaLgxVOQ
	 4FBdD3U3MYjWa+rHABW0b7HTLTwng52BoN3LgfFD3/h3VqH8muueqRDYJxTyo1pTnG9Cc
	 xjVdEj5bnM2un7gwNSKBkgIqxL1yxSK8qcwzyc1hmbc+5d0ZxodKvGNvQ8Y0KwFyz3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=senarytech.com;
	spf=pass smtp.mailfrom=senarytech.com;
	dkim=pass header.d=senarytech.com header.i=@senarytech.com header.a=rsa-sha256 header.s=default header.b=H2o7HWEm;
	arc=none smtp.remote-ip=103.209.128.113
Received: from mail-m128113.netease.com (mail-m128113.netease.com [103.209.128.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A695F606A31C;
	Thu, 26 Nov 2026 08:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A695F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=senarytech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=senarytech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=senarytech.com header.i=@senarytech.com header.a=rsa-sha256 header.s=default header.b=H2o7HWEm
Received: from Wangqianghua (unknown [27.38.157.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 56164301b;
	Thu, 26 Nov 2026 16:03:29 +0800 (GMT+08:00)
From: <qianghua.wang@senarytech.com>
To: "'Yige Jiang'" <yigejiang86@gmail.com>,
	"'Liam Girdwood'" <lgirdwood@gmail.com>,
	"'Mark Brown'" <broonie@kernel.org>,
	"'Jaroslav Kysela'" <perex@perex.cz>,
	"'Takashi Iwai'" <tiwai@suse.com>,
	"'bo liu'" <bo.liu@senarytech.com>
Cc: "'Bard Liao'" <yung-chuan.liao@linux.intel.com>,
	"'Pierre-Louis Bossart'" <pierre-louis.bossart@linux.dev>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <rc-b1-20261110-vc-07a-7c635620fec1@gmail.com>
In-Reply-To: <rc-b1-20261110-vc-07a-7c635620fec1@gmail.com>
Subject: reply: [PATCH 1/2] ASoC: sdw_utils: Drop rt_sdca_jack codec device reference on exit
Date: Thu, 26 Nov 2026 16:03:28 +0800
Message-ID: <000301dd7d7c$9fcd1fe0$df675fa0$@senarytech.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Ad19fJ6sRAfmq4G2QxSCaV7GDUoxxQ==
Content-Language: zh-cn
X-HM-Tid: 0aa216e18a4409d8kunm35a5610b95a460
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCQxgYVktPSh5JSU8aTxgeHlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlJTFVIQ1VKTkxVSU9JWVdZFhoPEhUdFFlBWU9LSFVKS0
	lCQ0NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=H2o7HWEm/ziPQxKrJmoZlIPPnG+d+HdAZ2WxnZmKyz0op8jFQq5lZmZ9JgBMJrBdGJxIMiIzVKB/hhhi1gH3evxWDFWCQrkacfiW8jBPVcQYiZIUNJSxaIXOl2dvhPn4k6tNhkhBxS/awmManzLexBO4W/RwMSRLj9xd6pa3XKU=; c=relaxed/relaxed; s=default; d=senarytech.com; v=1;
	bh=vygooTiSjYbQO8/tsqc0vjgWPN/b7cF63dCgZbTAnpc=;
	h=date:mime-version:subject:message-id:from;

Thanks for the catch.

asoc_sdw_rt_sdca_jack_init() always stores the bus_find_device_by_name()
reference in ctx->headset_codec_dev, while
rt_sdca_jack_add_codec_device_props()
adds no software node when SOC_SDW_JACK_JDSRC() is zero. Returning early
from asoc_sdw_rt_sdca_jack_exit() in that case therefore leaks the reference
(and leaves a stale pointer) on card registration failure / EPROBE_DEFER
/driver removal.

Your change matches the intended cleanup: only call
device_remove_software_node() when a jack-source software node was added,
and always put_device() + clear the pointer, as asoc_sdw_rt711_exit() does
for the
device reference. Cc:stable looks appropriate for Fixes: 526a1876fc48.

Reviewed-by: Qianghua Wang <qianghua.wang@senarytech.com>

-----Original Message-----
From: Yige Jiang <yigejiang86@gmail.com> 
Sent: 11/26/2026 13:18
To: Liam Girdwood <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>;
Jaroslav Kysela <perex@perex.cz>; Takashi Iwai <tiwai@suse.com>; bo liu
<bo.liu@senarytech.com>; qianghua.wang <qianghua.wang@senarytech.com>
Cc: Yige Jiang <yigejiang86@gmail.com>; Bard Liao
<yung-chuan.liao@linux.intel.com>; Pierre-Louis Bossart
<pierre-louis.bossart@linux.dev>; linux-sound@vger.kernel.org;
linux-kernel@vger.kernel.org; stable@vger.kernel.org
Subject: [PATCH 1/2] ASoC: sdw_utils: Drop rt_sdca_jack codec device
reference on exit

asoc_sdw_rt_sdca_jack_init() takes a reference on the SoundWire codec device
with bus_find_device_by_name() and stores it in
ctx->headset_codec_dev, whatever the jack source quirk is. But
asoc_sdw_rt_sdca_jack_exit() returns early when SOC_SDW_JACK_JDSRC() is
zero, so then the reference is never dropped. One reference on the codec
device leaks each time the card fails to register (including
-EPROBE_DEFER) or the machine driver is removed, when the quirk has no jack
source (DMI quirk entries without one, or the quirk module parameter).

The jack source check in the exit path is only needed because
rt_sdca_jack_add_codec_device_props() adds no software node when the jack
source is not set. Use it to skip device_remove_software_node() only, and
always drop the reference and clear the pointer, as
asoc_sdw_rt711_exit() does.

Fixes: 526a1876fc48 ("ASoC: Intel: sof_sdw_rt_sdca_jack_common: test
SOF_JACK_JDSRC in _exit")
Cc: stable@vger.kernel.org
Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
---
Based on linux-next next-20261109 (630059a5a632).
Compile-tested: arm64, GCC 14.2.0, W=1, COMPILE_TEST=y,
SND_SOC_INTEL_SOUNDWIRE_SOF_MACH=y, SND_SOC_SDW_UTILS=y;
soc_sdw_rt_sdca_jack_common.o built before and after, no new warnings.
No hardware or runtime test was performed.
The path needs an rt_sdca jack codec and a quirk with no jack source; it
runs on card registration failure (including -EPROBE_DEFER) and on machine
driver removal.

 sound/soc/sdw_utils/soc_sdw_rt_sdca_jack_common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sdw_utils/soc_sdw_rt_sdca_jack_common.c
b/sound/soc/sdw_utils/soc_sdw_rt_sdca_jack_common.c
index b4e427d55130..7902d423c8b9 100644
--- a/sound/soc/sdw_utils/soc_sdw_rt_sdca_jack_common.c
+++ b/sound/soc/sdw_utils/soc_sdw_rt_sdca_jack_common.c
@@ -188,10 +188,9 @@ int asoc_sdw_rt_sdca_jack_exit(struct snd_soc_card
*card, struct snd_soc_dai_lin
 	if (!ctx->headset_codec_dev)
 		return 0;
 
-	if (!SOC_SDW_JACK_JDSRC(ctx->mc_quirk))
-		return 0;
+	if (SOC_SDW_JACK_JDSRC(ctx->mc_quirk))
+		device_remove_software_node(ctx->headset_codec_dev);
 
-	device_remove_software_node(ctx->headset_codec_dev);
 	put_device(ctx->headset_codec_dev);
 	ctx->headset_codec_dev = NULL;
 

base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47

