Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D894F3B8945
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 19:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981457; cv=none; b=dVuEgQFAAHJdpiF+s1cTJZ7/gXImLiXXYlPRAOZutGPSqzz1quzHA6qLMwAnwafjTwH2RqlXe9NDWpywlVgAb/AidXxjkV3Qvhgq9xCCDoXNGNM265+TNI2BsyrZWIA3R6LHNLeaRxOLjRJNJP4vDCjc7IflnuPwOpcOWY1mGzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981457; c=relaxed/simple;
	bh=kEg6zsOG+39c6Hardax7MtyqcEXBsXRE9cKzo1UCw5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pEDg6w6YkyLgh1z9nArhnKmc0yQi7w60RGKOPf0lYdrOmR0rfUqT7j9Vt5jxzm/ooutVncY1Otp5FhCJS7a/9GFV+4WBCEC39er/FNYyDNT4HyW+cSDsyL1tmEhRDGm72iznWYrGuKPlxZedAQwObPqapyt9/ZFnGKMgGagt7PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wk8NRnMJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wk8NRnMJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026E41F000FF;
	Wed,  9 Sep 2026 19:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788981455;
	bh=sdH/WEOMjXFL7Xof2fZcDspHUP/IrHflOBGYBDm9/9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wk8NRnMJFIyofE+HuYi1iqs46QMKS8j05T7rzUsxkyf/8pFJ2f61DtFFIf692H5dm
	 oMheiJ7tlCApfJXKZAe0H+Wx0f6qaX5FuUrT5xGC2kiFHM4HYbKDLXtOFn7dVdznlX
	 YLjvYdEsQWKcsssfbCsi1pNCyH3AWbRddz2aa4K5h8Zoq77wv1b/c898Q/nvzvWJhY
	 dyu/Y4V1kd3Kl0h4dB7WX3Vofi1bhWhFz9NT1Fa11359vz2s4sEdpUARzZ6mMsYkpx
	 vCHBInzVmpcEKQMoeLeljkuk20AGyz9Kb4VeHTuKmAW82dxC8kDu6HraapS6cUo6bi
	 yKthos5K043mQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] ALSA: hda: fix kernel-doc warnings
Date: Wed,  9 Sep 2026 15:17:30 -0400
Message-ID: <20260909191732.3557673-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090345-hangnail-getup-f661@gregkh>
References: <2026090345-hangnail-getup-f661@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit 3531ba21f5520d0865004e7d75b6f505d08589f2 ]

v5.12-rc1 flags new warnings with make W=1, fix missing or broken
function descriptors.

sound/pci/hda/hda_codec.c:3492: warning: expecting prototype for
snd_hda_input_mux_info_info(). Prototype was for
snd_hda_input_mux_info() instead

sound/pci/hda/hda_codec.c:3521: warning: expecting prototype for
snd_hda_input_mux_info_put(). Prototype was for
snd_hda_input_mux_put() instead

sound/pci/hda/hda_codec.c:3958: warning: expecting prototype for
_snd_hda_pin_ctl(). Prototype was for _snd_hda_set_pin_ctl() instead

sound/pci/hda/hda_jack.c:223: warning: expecting prototype for
snd_hda_set_dirty_all(). Prototype was for
snd_hda_jack_set_dirty_all() instead

sound/pci/hda/hda_jack.c:309: warning: expecting prototype for
snd_hda_jack_detect_enable_mst(). Prototype was for
snd_hda_jack_detect_enable_callback_mst() instead

sound/pci/hda/hda_generic.c:3933: warning: expecting prototype for
snd_dha_gen_add_mute_led_cdev(). Prototype was for
snd_hda_gen_add_mute_led_cdev() instead

sound/pci/hda/hda_generic.c:4093: warning: expecting prototype for
snd_dha_gen_add_micmute_led_cdev(). Prototype was for
snd_hda_gen_add_micmute_led_cdev() instead

sound/pci/hda/patch_ca0132.c:2357: warning: expecting prototype for
Prepare and send the SCP message to DSP(). Prototype was for
dspio_scp() instead

sound/pci/hda/patch_ca0132.c:2883: warning: expecting prototype for
Allocate router ports(). Prototype was for dsp_allocate_router_ports()
instead

sound/pci/hda/patch_ca0132.c:3202: warning: expecting prototype for
Write a block of data into DSP code or data RAM using pre(). Prototype
was for dspxfr_one_seg() instead

sound/pci/hda/patch_ca0132.c:3397: warning: expecting prototype for
data overlay to DSP memories(). Prototype was for dspxfr_image()
instead

sound/hda/hdac_regmap.c:393: warning: expecting prototype for
snd_hdac_regmap_init(). Prototype was for snd_hdac_regmap_exit()
instead

sound/hda/ext/hdac_ext_controller.c:142: warning: expecting prototype
for snd_hdac_ext_bus_get_link_index(). Prototype was for
snd_hdac_ext_bus_get_link() instead

sound/hda/ext/hdac_ext_stream.c:140: warning: expecting prototype for
snd_hdac_ext_linkstream_start(). Prototype was for
snd_hdac_ext_link_stream_start() instead

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20210301174617.116960-1-pierre-louis.bossart@linux.intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 36aa66de481d ("ALSA: hda/ext: preserve PPLCCTL bits when clearing reset")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/ext/hdac_ext_controller.c | 2 +-
 sound/hda/ext/hdac_ext_stream.c     | 2 +-
 sound/hda/hdac_regmap.c             | 2 +-
 sound/pci/hda/hda_codec.c           | 6 +++---
 sound/pci/hda/hda_generic.c         | 4 ++--
 sound/pci/hda/hda_jack.c            | 4 ++--
 sound/pci/hda/patch_ca0132.c        | 9 ++++-----
 7 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/sound/hda/ext/hdac_ext_controller.c b/sound/hda/ext/hdac_ext_controller.c
index b0c0ef824d7d9..a7cf900a21c32 100644
--- a/sound/hda/ext/hdac_ext_controller.c
+++ b/sound/hda/ext/hdac_ext_controller.c
@@ -133,7 +133,7 @@ void snd_hdac_link_free_all(struct hdac_bus *bus)
 EXPORT_SYMBOL_GPL(snd_hdac_link_free_all);
 
 /**
- * snd_hdac_ext_bus_get_link_index - get link based on codec name
+ * snd_hdac_ext_bus_get_link - get link based on codec name
  * @bus: the pointer to HDAC bus object
  * @codec_name: codec name
  */
diff --git a/sound/hda/ext/hdac_ext_stream.c b/sound/hda/ext/hdac_ext_stream.c
index 4276dae2e00af..c09652da43ffd 100644
--- a/sound/hda/ext/hdac_ext_stream.c
+++ b/sound/hda/ext/hdac_ext_stream.c
@@ -141,7 +141,7 @@ void snd_hdac_ext_stream_decouple(struct hdac_bus *bus,
 EXPORT_SYMBOL_GPL(snd_hdac_ext_stream_decouple);
 
 /**
- * snd_hdac_ext_linkstream_start - start a stream
+ * snd_hdac_ext_link_stream_start - start a stream
  * @stream: HD-audio ext core stream to start
  */
 void snd_hdac_ext_link_stream_start(struct hdac_ext_stream *stream)
diff --git a/sound/hda/hdac_regmap.c b/sound/hda/hdac_regmap.c
index 5c7ac8e8de0da..9b786cec8f1e1 100644
--- a/sound/hda/hdac_regmap.c
+++ b/sound/hda/hdac_regmap.c
@@ -386,7 +386,7 @@ int snd_hdac_regmap_init(struct hdac_device *codec)
 EXPORT_SYMBOL_GPL(snd_hdac_regmap_init);
 
 /**
- * snd_hdac_regmap_init - Release the regmap from HDA codec
+ * snd_hdac_regmap_exit - Release the regmap from HDA codec
  * @codec: the codec object
  */
 void snd_hdac_regmap_exit(struct hdac_device *codec)
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index fc4a64a83ff2f..3fa0aa63dd127 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -3491,7 +3491,7 @@ EXPORT_SYMBOL_GPL(snd_hda_check_amp_list_power);
  */
 
 /**
- * snd_hda_input_mux_info_info - Info callback helper for the input-mux enum
+ * snd_hda_input_mux_info - Info callback helper for the input-mux enum
  * @imux: imux helper object
  * @uinfo: pointer to get/store the data
  */
@@ -3514,7 +3514,7 @@ int snd_hda_input_mux_info(const struct hda_input_mux *imux,
 EXPORT_SYMBOL_GPL(snd_hda_input_mux_info);
 
 /**
- * snd_hda_input_mux_info_put - Put callback helper for the input-mux enum
+ * snd_hda_input_mux_put - Put callback helper for the input-mux enum
  * @codec: the HDA codec
  * @imux: imux helper object
  * @ucontrol: pointer to get/store the data
@@ -3949,7 +3949,7 @@ unsigned int snd_hda_correct_pin_ctl(struct hda_codec *codec,
 EXPORT_SYMBOL_GPL(snd_hda_correct_pin_ctl);
 
 /**
- * _snd_hda_pin_ctl - Helper to set pin ctl value
+ * _snd_hda_set_pin_ctl - Helper to set pin ctl value
  * @codec: the HDA codec
  * @pin: referred pin NID
  * @val: pin control value to set
diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index d697041a8529a..0fce21d13ea2c 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -3947,7 +3947,7 @@ static void vmaster_update_mute_led(void *private_data, int enabled)
 }
 
 /**
- * snd_dha_gen_add_mute_led_cdev - Create a LED classdev and enable as vmaster mute LED
+ * snd_hda_gen_add_mute_led_cdev - Create a LED classdev and enable as vmaster mute LED
  * @codec: the HDA codec
  * @callback: the callback for LED classdev brightness_set_blocking
  */
@@ -4098,7 +4098,7 @@ static int add_micmute_led_hook(struct hda_codec *codec)
 }
 
 /**
- * snd_dha_gen_add_micmute_led_cdev - Create a LED classdev and enable as mic-mute LED
+ * snd_hda_gen_add_micmute_led_cdev - Create a LED classdev and enable as mic-mute LED
  * @codec: the HDA codec
  * @callback: the callback for LED classdev brightness_set_blocking
  *
diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index 588059428d8f5..46bf294269b70 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -213,7 +213,7 @@ static void jack_detect_update(struct hda_codec *codec,
 }
 
 /**
- * snd_hda_set_dirty_all - Mark all the cached as dirty
+ * snd_hda_jack_set_dirty_all - Mark all the cached as dirty
  * @codec: the HDA codec
  *
  * This function sets the dirty flag to all entries of jack table.
@@ -293,7 +293,7 @@ find_callback_from_list(struct hda_jack_tbl *jack,
 }
 
 /**
- * snd_hda_jack_detect_enable_mst - enable the jack-detection
+ * snd_hda_jack_detect_enable_callback_mst - enable the jack-detection
  * @codec: the HDA codec
  * @nid: pin NID to enable
  * @func: callback function to register
diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 3acb4066b5eac..699de1b246efe 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -2210,7 +2210,7 @@ static int dspio_send_scp_message(struct hda_codec *codec,
 }
 
 /**
- * Prepare and send the SCP message to DSP
+ * dspio_scp - Prepare and send the SCP message to DSP
  * @codec: the HDA codec
  * @mod_id: ID of the DSP module to send the command
  * @src_id: ID of the source
@@ -2744,7 +2744,7 @@ static int dsp_dma_stop(struct hda_codec *codec,
 }
 
 /**
- * Allocate router ports
+ * dsp_allocate_router_ports - Allocate router ports
  *
  * @codec: the HDA codec
  * @num_chans: number of channels in the stream
@@ -3057,8 +3057,7 @@ static int dspxfr_hci_write(struct hda_codec *codec,
 }
 
 /**
- * Write a block of data into DSP code or data RAM using pre-allocated
- * DMA engine.
+ * dspxfr_one_seg - Write a block of data into DSP code or data RAM using pre-allocated DMA engine.
  *
  * @codec: the HDA codec
  * @fls: pointer to a fast load image
@@ -3255,7 +3254,7 @@ static int dspxfr_one_seg(struct hda_codec *codec,
 }
 
 /**
- * Write the entire DSP image of a DSP code/data overlay to DSP memories
+ * dspxfr_image - Write the entire DSP image of a DSP code/data overlay to DSP memories
  *
  * @codec: the HDA codec
  * @fls_data: pointer to a fast load image
-- 
2.53.0

