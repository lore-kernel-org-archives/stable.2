Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C8C485CD2
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786037347; cv=none; b=tLjnrC1KxqDS1RGCwi3NqZKAImS0evZP8xqyYR0zpMLlVCGWXKwONi5uamwP08SijKZN8JMFThbSlHYhkCynWCJ8flLkYR/n+9zpOl+C0Qz4Q7Il8AvWqsvwbZheY+z9DEoO8QfN2RjhKcihLoHMCJLMGbD1s2ydgwamTir6ghQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786037347; c=relaxed/simple;
	bh=I+ODm7P47hW+UltLlaPUZUeHfkwv/REav8fE5cwjP2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=emG1a69ec4xIPvfuVRtmXOpYdaaxw53TRZllnGXrg1RLOhCFZTN6/0IerECc1pZtI6eZUh/ICnNtf+zuppQXzMjnwIs9jNh8QZNkLNlEO43Z0d84Emwx4M9cGLZvveaPw/m+/twclA08mF2pYTmACbmyx1Ep2YlRUUIdNlJOsUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WL39uADh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WL39uADh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9968A1F000E9;
	Thu,  6 Aug 2026 17:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786037345;
	bh=5dzbiuq6BEp6p/b6m95hIJhsn8lpbX4VTldodUJZD8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WL39uADh9g+QeTgWF9GXWPnwkr4CF1FSV19xd0KJtyBhsFv1+KvUsjTdLJ/HOMWbw
	 VXEGX7ycaXmCdYjjyuwMnwjCQWxTmAqtDkEADponNXpc5rHyWfFbeUVTtYLSRjhQ7W
	 TrpzMecw7evbEcZ2gUmDmt3KMH7U8522wqEzKK/wXdQGPczJPOhvQN3Sz3Fc6M8Smt
	 2Kcgl+bjESjUNQDse4By8by/oSYbD/zWp4lxr9YL5kBPv6t48JJtNot6RrA2p7uPiZ
	 chsK7kplvWD1gYwdKAQYykAyX3l9h0qoijUCupKmJ44j1tukTClpjDOqbRo0uNcJrj
	 q2xipCUMrOBzg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Alexander Kaplan <alexander.kaplan@sms-medipool.de>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ALSA: hda: codecs: hdmi: disable keep-alive before audio format change
Date: Thu,  6 Aug 2026 13:29:02 -0400
Message-ID: <20260806172902.1212479-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072952-shout-mandarin-8f3e@gregkh>
References: <2026072952-shout-mandarin-8f3e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

[ Upstream commit a3d6d3cedfe87bbd5a677d52b22ac20d28e59cf8 ]

When a keep-alive (KAE) silent stream is active on an Intel HDMI/DP
codec, opening a real PCM stream reprograms the converter format and the
audio infoframe in snd_hda_hdmi_generic_pcm_prepare(). Part of that
reprogramming - the converter channel count and the channel mapping in
snd_hda_hdmi_setup_audio_infoframe() - is not safe to do while a
keep-alive stream is active. This is most visible when switching to a
multichannel PCM configuration, where the active channel count actually
changes. In that case the newly opened PCM stream plays no sound.

Add an optional hdmi_ops .prepare hook, called at the start of the
PCM prepare sequence (before the format and infoframe are touched), and
implement it for HSW+ to release keep-alive. Keep-alive is then
re-enabled as before once the new stream has been set up, in the
setup_stream op.

Fixes: 15175a4f2bbb ("ALSA: hda/hdmi: add keep-alive support for ADL-P and DG2")
Reported-by: Alexander Kaplan <alexander.kaplan@sms-medipool.de>
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8412
Tested-by: Alexander Kaplan <alexander.kaplan@sms-medipool.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Link: https://patch.msgid.link/20260715180610.1371243-1-kai.vehmanen@linux.intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[ adapted three hunks from the post-6.12 split files (hdmi.c/hdmi_local.h/intelhdmi.c) back into the monolithic sound/pci/hda/patch_hdmi.c, with the prepare hook un-indented one level since 6.12 uses plain mutex_lock() instead of scoped_guard() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_hdmi.c | 48 +++++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index f5712c0aeb504..83ba6dfd28c3b 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -111,6 +111,15 @@ struct hdmi_ops {
 			    hda_nid_t pin_nid, int dev_id, u32 stream_tag,
 			    int format);
 
+	/*
+	 * Optional hook invoked at the beginning of the PCM prepare
+	 * sequence, before the audio infoframe and stream format are
+	 * (re)programmed. Used to disable keep-alive / silent stream so
+	 * that the format change is not done while keep-alive is active.
+	 */
+	void (*prepare)(struct hda_codec *codec,
+			struct hdmi_spec_per_pin *per_pin);
+
 	void (*pin_cvt_fixup)(struct hda_codec *codec,
 			      struct hdmi_spec_per_pin *per_pin,
 			      hda_nid_t cvt_nid);
@@ -2138,6 +2147,9 @@ static int generic_hdmi_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
 	per_pin->channels = substream->runtime->channels;
 	per_pin->setup = true;
 
+	if (spec->ops.prepare)
+		spec->ops.prepare(codec, per_pin);
+
 	if (get_wcaps(codec, cvt_nid) & AC_WCAP_STRIPE) {
 		stripe = snd_hdac_get_stream_stripe_ctl(&codec->bus->core,
 							substream);
@@ -2903,6 +2915,28 @@ static void register_i915_notifier(struct hda_codec *codec)
 	codec->relaxed_resume = 1;
 }
 
+/*
+ * prepare ops override for HSW+
+ *
+ * Disable keep-alive before the converter format and audio infoframe are
+ * reprogrammed by the PCM prepare sequence. Changing the audio format (e.g.
+ * the channel count when switching to multichannel PCM) while a keep-alive
+ * stream is active is not safe, so release keep-alive here, early in the
+ * sequence. It is re-enabled once the new stream has been set up, in
+ * i915_hsw_setup_stream().
+ */
+static void i915_hsw_prepare(struct hda_codec *codec,
+			     struct hdmi_spec_per_pin *per_pin)
+{
+	struct hdmi_spec *spec = codec->spec;
+
+	if (spec->silent_stream_type == SILENT_STREAM_KAE && per_pin->silent_stream) {
+		silent_stream_set_kae(codec, per_pin, false);
+		/* wait for pending transfers in codec to clear */
+		usleep_range(100, 200);
+	}
+}
+
 /* setup_stream ops override for HSW+ */
 static int i915_hsw_setup_stream(struct hda_codec *codec, hda_nid_t cvt_nid,
 				 hda_nid_t pin_nid, int dev_id, u32 stream_tag,
@@ -2920,15 +2954,16 @@ static int i915_hsw_setup_stream(struct hda_codec *codec, hda_nid_t cvt_nid,
 
 	haswell_verify_D0(codec, cvt_nid, pin_nid);
 
-	if (spec->silent_stream_type == SILENT_STREAM_KAE && per_pin && per_pin->silent_stream) {
-		silent_stream_set_kae(codec, per_pin, false);
-		/* wait for pending transfers in codec to clear */
-		usleep_range(100, 200);
-	}
-
 	res = hdmi_setup_stream(codec, cvt_nid, pin_nid, dev_id,
 				stream_tag, format);
 
+	/*
+	 * Keep-alive was disabled in i915_hsw_prepare(), re-enable it now.
+	 * The pin lookup above resolves to the same per_pin that prepare
+	 * used (pin_nid comes from that per_pin), so this stays balanced; a
+	 * NULL per_pin only occurs on a lookup failure that also implies no
+	 * active keep-alive stream to restore.
+	 */
 	if (spec->silent_stream_type == SILENT_STREAM_KAE && per_pin && per_pin->silent_stream) {
 		usleep_range(100, 200);
 		silent_stream_set_kae(codec, per_pin, true);
@@ -3104,6 +3139,7 @@ static int intel_hsw_common_init(struct hda_codec *codec, hda_nid_t vendor_nid,
 	codec->depop_delay = 0;
 	codec->auto_runtime_pm = 1;
 
+	spec->ops.prepare = i915_hsw_prepare;
 	spec->ops.setup_stream = i915_hsw_setup_stream;
 	spec->ops.pin_cvt_fixup = i915_pin_cvt_fixup;
 
-- 
2.53.0

