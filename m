Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A29486645
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330307; cv=none; b=gNTzAxorrE2mJQM0RU+F+yPhShMmJOzsjggnYMFxbusb7Ub7N0ufdFNVGavn9rKAczSfTmelbtyv5pILg55v5uaWYtH7w0P+DX8z1f/O0rCpr3Mxp1eJjFo5vB9dFoXjzQVMDFtDnJAvec/V7wDYhJUd+4URayGYDTq3rfYFq5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330307; c=relaxed/simple;
	bh=gEGBztjENHqKhmVhnop/UZaeCayrD1LTxyjuX/yz/mk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VcAMdX+8r+M4ZeIgg6HzOPDD1rcYNQ8T9RUtWqmuRlbeQtMQ1zP/x+02UH5K3ZsL+r+zflt2thd/vIiEuqhoH9R6qjHxAwW0LKEsiN84K92sbRSW3r7xSADtbsjjCMt+x5+np2FUXqvVNAzIBrq/NgFakxfSsZhBJDA3RLIpC60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UACyjpOQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UACyjpOQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7A81F00AC4;
	Wed, 29 Jul 2026 13:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785330305;
	bh=A+EBfSeEoaqMmPeVvGIWKdK9rDLNsaeB+YLeHIgHlIw=;
	h=Subject:To:Cc:From:Date;
	b=UACyjpOQDV/cld0lZ0Qz6ekKS/zwuO6pf/x5TkC/uBNUFRk5sOJjDtOkUZPRJbpiC
	 ldbcWZ8cbGShvRZB89jJTZ50vLcgzj8ilVFC9xn16uXutcPsyamWPdVZn7GMj45qN2
	 /l8351DdcYbEW++14FkLDx+OQBFEJ6TWJsT1AWoQ=
Subject: FAILED: patch "[PATCH] ALSA: hda: codecs: hdmi: disable keep-alive before audio" failed to apply to 6.12-stable tree
To: kai.vehmanen@linux.intel.com,alexander.kaplan@sms-medipool.de,stable@vger.kernel.org,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:04:52 +0200
Message-ID: <2026072952-engraved-iguana-d526@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x a3d6d3cedfe87bbd5a677d52b22ac20d28e59cf8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072952-engraved-iguana-d526@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a3d6d3cedfe87bbd5a677d52b22ac20d28e59cf8 Mon Sep 17 00:00:00 2001
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Date: Wed, 15 Jul 2026 21:06:10 +0300
Subject: [PATCH] ALSA: hda: codecs: hdmi: disable keep-alive before audio
 format change

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

diff --git a/sound/hda/codecs/hdmi/hdmi.c b/sound/hda/codecs/hdmi/hdmi.c
index 1f4d646724ed..a4a2f2f0540c 100644
--- a/sound/hda/codecs/hdmi/hdmi.c
+++ b/sound/hda/codecs/hdmi/hdmi.c
@@ -1688,6 +1688,9 @@ int snd_hda_hdmi_generic_pcm_prepare(struct hda_pcm_stream *hinfo,
 		per_pin->channels = substream->runtime->channels;
 		per_pin->setup = true;
 
+		if (spec->ops.prepare)
+			spec->ops.prepare(codec, per_pin);
+
 		if (get_wcaps(codec, cvt_nid) & AC_WCAP_STRIPE) {
 			stripe = snd_hdac_get_stream_stripe_ctl(&codec->bus->core,
 								substream);
diff --git a/sound/hda/codecs/hdmi/hdmi_local.h b/sound/hda/codecs/hdmi/hdmi_local.h
index 548241ad3fa9..dce9a335cff2 100644
--- a/sound/hda/codecs/hdmi/hdmi_local.h
+++ b/sound/hda/codecs/hdmi/hdmi_local.h
@@ -74,6 +74,15 @@ struct hdmi_ops {
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
diff --git a/sound/hda/codecs/hdmi/intelhdmi.c b/sound/hda/codecs/hdmi/intelhdmi.c
index 6a7882544ab7..73141046d502 100644
--- a/sound/hda/codecs/hdmi/intelhdmi.c
+++ b/sound/hda/codecs/hdmi/intelhdmi.c
@@ -418,6 +418,28 @@ static void intel_not_share_assigned_cvt_nid(struct hda_codec *codec,
 		intel_not_share_assigned_cvt(codec, pin_nid, dev_id, mux_idx);
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
@@ -435,15 +457,16 @@ static int i915_hsw_setup_stream(struct hda_codec *codec, hda_nid_t cvt_nid,
 
 	haswell_verify_D0(codec, cvt_nid, pin_nid);
 
-	if (spec->silent_stream_type == SILENT_STREAM_KAE && per_pin && per_pin->silent_stream) {
-		silent_stream_set_kae(codec, per_pin, false);
-		/* wait for pending transfers in codec to clear */
-		usleep_range(100, 200);
-	}
-
 	res = snd_hda_hdmi_setup_stream(codec, cvt_nid, pin_nid, dev_id,
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
@@ -607,6 +630,7 @@ static int intel_hsw_common_init(struct hda_codec *codec, hda_nid_t vendor_nid,
 	codec->depop_delay = 0;
 	codec->auto_runtime_pm = 1;
 
+	spec->ops.prepare = i915_hsw_prepare;
 	spec->ops.setup_stream = i915_hsw_setup_stream;
 	spec->ops.pin_cvt_fixup = i915_pin_cvt_fixup;
 	spec->ops.silent_stream = i915_set_silent_stream;

