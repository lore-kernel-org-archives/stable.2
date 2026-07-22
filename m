Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A79442B3B
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 22:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784757794; cv=none; b=KY78drfb+SRsiVf9ocXhoC7tpN3+WKyMxHCxnl0nulU4XOMuugvUfWTN1pQQUI/ydYB3XpnnBqLIX5C3Vmw1lU+E1Ls+Az682aSmC8Ft6C7Q+bQmV61AQdyY+So61LRuxR0Hc/0wy3Bb0x90HEdNowFwWueA2P7hZvGNJFytm2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784757794; c=relaxed/simple;
	bh=eRIStmwQ3KHb93t4SdTXpmEhOR5i1i164pZC82ShUbU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rO5EwmvWhA/MQvstdzgAhXMqMFr6XjlpkYXAzw6gYGzGboA1FaJVGfWWueD9Pb1Svn03sxEeTKO0nOhIjAbssfvIrsNqtqMf7ufx/NnBKLeYwq8yfV7+1AnAhlMOvySgTsJygCeG5QDcjGPyeukijUBQOX8CgMpt+euVLcoGlPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cluster.wtf; spf=pass smtp.mailfrom=cluster.wtf; dkim=pass (1024-bit key) header.d=cluster.wtf header.i=@cluster.wtf header.b=oRnWJE4g; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cluster.wtf
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cluster.wtf
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cluster.wtf header.i=@cluster.wtf header.b="oRnWJE4g"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4954df200ddso43035e9.0
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 15:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cluster.wtf; s=google; t=1784757791; x=1785362591; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ljf/v28ZX4Vl9t4iSMS22mImazlJU7lJSBLv2mkXpOk=;
        b=oRnWJE4gcGKO9MnPvQeEZVDniwODy3veJCKCU6TpjOfTsGsrjVZNQuQSLLRKixQMpQ
         mBpd7rslwr3+0lK5UqggEyuAWee3jo7VRJzMYVLw9vsLIZM1rZfp9blQuhRGqT7h2CF5
         xejsiKVziUYiAg6H2wvfH5PLFFsO8lqirhVPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784757791; x=1785362591;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ljf/v28ZX4Vl9t4iSMS22mImazlJU7lJSBLv2mkXpOk=;
        b=cfbjMaAFMlFUoiR7BumBt0Jh/bPJ0WwpnE1Kj79/mbcDh4btu05/UTI6EAes/rwG5b
         QuUmMa69c8fHIy2HLThTBYO9EqJvUHkIzwn7Or5Ov2lbCpxhIU2WcrtXszTwF9bdd7cT
         CQrMexzImNjGszxXRbu7chh51AFCaJ6zVonAdQcCe74gT6ViAK04l24flg60XY4XBHQU
         c8SY+BBQ1Z/Fu2xEmu3Cn6Psn4Uu3GX3Pkx4YqU6YxWD0vbeLYssV9Vi10LX4zg63Mdi
         IC0nYL1H73EPIl0yx9SanFNZH4tbi2Y9ayxPEUti0t9CTJ3eyFzY3cTg2mBf9lZSaQO+
         dHhw==
X-Forwarded-Encrypted: i=1; AHgh+Rp3cMV60f59ZTxmBvnKm2G4nK7z/gJbJvQ2eeOyiIu7l1D25xvxE5voZPBrNlj+Y2LPTtwKsm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOyMNED+2rR3Hd7SvTFWYu34GVtMhu9+ilfvvEideXPglomi55
	/HSrg43GA4Z0rhVJSi6c442Sp7sgW2ljyEIAzahDEZ01AJpElLY86canTekFUfHtXCs=
X-Gm-Gg: AR+sD11If4J85XcMrhBVPdCGxz11Ov0MtF3w3ufF/bWUs1TXfnFoZcsNbZ09ojWtkkf
	lGxGv2FS4vRBtADvUuSmgtY2rgWcSZDHXip01FyYLkxDr5EoPy2blEOvmWcOwYFOAMCLLn5TY3f
	olAZS4c03tWg0ByUNT1FVEymjwvWkjaXDfYudS37vjkkodXt1RCzUnGrwG9DbpzdEWlHe/4MBR6
	GSDHjfiVKovTVMKWwfE2PgvFMe8aDBCOgo0M1Qx9BuMXqm5yZ9AXQkNhQjCx3HLmSzBj022aq/p
	/WPjNrAZVx2+WnXGYce836W48cfIZdCBB701Wv5fS/sTPmhYzkYLZuThBDHWr4ejDDiz6qM18qh
	75v320zk4QMf9CpmJ3vJBzqJdzKIV635rtp6LDJngF7Hk2k5XNSk89hNOBUyArOUmFIahAJU=
X-Received: by 2002:a05:600c:470a:b0:493:c8a6:b517 with SMTP id 5b1f17b1804b1-49573d28ea9mr4069965e9.38.1784757790654;
        Wed, 22 Jul 2026 15:03:10 -0700 (PDT)
Received: from localhost ([95.180.55.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a6354a3sm153384135e9.10.2026.07.22.15.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 15:03:10 -0700 (PDT)
From: cluster@cluster.wtf
To: Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/hdmi: stop KAE before multichannel infoframe setup
Date: Thu, 23 Jul 2026 00:03:09 +0200
Message-ID: <20260722220309.24432-1-cluster@cluster.wtf>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Intel Meteor Lake and other ADLP-class display codecs, HDA Keep-Alive
(KAE) silent stream stays active while idle and transmits stereo silence.
PCM prepare programmed converter channel count and the DP/HDMI audio
infoframe before KAE was stopped, then re-enabled KAE during real
playback. Reconfiguring an active keep-alive stream to 5.1/7.1 can hang
the display audio codec until reboot. Stereo playback is unaffected.

Stop KAE in a new pre_prepare hook before infoframe/channel-count setup,
do not re-enable KAE while real PCM is running, and restore the stereo
silent stream from PCM close when the sink is still present.

Signed-off-by: Alexey Cluster <cluster@cluster.wtf>
---

Hardware / test notes:
- Laptop: HP OMEN Transcend Gaming Laptop 14-fb0xxx
  (marketing: OMEN Transcend Laptop 14-fb0065TX, SKU 9T0M1PA#AB2)
- CPU/iGPU: Meteor Lake-P, PCI 8086:7d55 (Arc Graphics)
- Audio controller: Meteor Lake-P HD Audio, PCI 8086:7e28
- Stack: sof-soundwire + snd-hda-codec-intelhdmi
- Display codec: Intel Meteor Lake HDMI, vendor_id 0x8086281d
- Path: USB-C DisplayPort -> AVR "CZ350CK" (ELD speakers 0x4f, LPCM up to 8ch)
- CONFIG_SND_HDA_INTEL_HDMI_SILENT_STREAM=y / enable_silent_stream=Y

Before this change, switching the sink from 2.0 to 5.1 (UCM "HiFi 5+1" /
speaker-test -c6 on hw:sofsoundwire,5) could hang display audio until reboot.
Stereo continued to work. After the change, cold 6ch open and 2ch<->6ch
transitions complete with ca=0x0b and no hang.

 sound/hda/codecs/hdmi/hdmi.c       | 40 ++++++++++++++++++++++++----
 sound/hda/codecs/hdmi/hdmi_local.h |  9 +++++++
 sound/hda/codecs/hdmi/intelhdmi.c  | 42 ++++++++++++++++++++++++++----
 3 files changed, 81 insertions(+), 10 deletions(-)

diff --git a/sound/hda/codecs/hdmi/hdmi.c b/sound/hda/codecs/hdmi/hdmi.c
index 0b6816018a42..e2a77877358a 100644
--- a/sound/hda/codecs/hdmi/hdmi.c
+++ b/sound/hda/codecs/hdmi/hdmi.c
@@ -557,6 +557,11 @@ void snd_hda_hdmi_setup_audio_infoframe(struct hda_codec *codec,
 
 	active_channels = snd_hdac_get_active_channels(ca);
 
+	codec_dbg(codec,
+		  "HDMI: infoframe pin-NID=0x%x channels=%d active=%d ca=0x%02x conn=%d spk_alloc=0x%x non_pcm=%d\n",
+		  pin_nid, channels, active_channels, ca, eld->info.conn_type,
+		  eld->info.spk_alloc, non_pcm);
+
 	chmap->ops.set_channel_count(&codec->core, per_pin->cvt_nid,
 						active_channels);
 
@@ -1683,6 +1688,13 @@ int snd_hda_hdmi_generic_pcm_prepare(struct hda_pcm_stream *hinfo,
 		snd_hdac_sync_audio_rate(&codec->core, per_pin->pin_nid,
 					 per_pin->dev_id, runtime->rate);
 
+	/*
+	 * Stop Intel KAE (and similar) before channel-count / infoframe are
+	 * programmed. Must not sleep under per_pin->lock.
+	 */
+	if (spec->ops.pre_prepare)
+		spec->ops.pre_prepare(codec, per_pin, runtime->channels);
+
 	non_pcm = check_non_pcm_per_cvt(codec, cvt_nid);
 	scoped_guard(mutex, &per_pin->lock) {
 		per_pin->channels = substream->runtime->channels;
@@ -1732,6 +1744,7 @@ static int hdmi_pcm_close(struct hda_pcm_stream *hinfo,
 	struct hdmi_spec_per_cvt *per_cvt;
 	struct hdmi_spec_per_pin *per_pin;
 	int pinctl;
+	bool restore_silent = false;
 
 	guard(mutex)(&spec->pcm_lock);
 	if (hinfo->nid) {
@@ -1769,12 +1782,29 @@ static int hdmi_pcm_close(struct hda_pcm_stream *hinfo,
 					    pinctl & ~PIN_OUT);
 		}
 
-		guard(mutex)(&per_pin->lock);
-		per_pin->chmap_set = false;
-		memset(per_pin->chmap, 0, sizeof(per_pin->chmap));
+		scoped_guard(mutex, &per_pin->lock) {
+			per_pin->chmap_set = false;
+			memset(per_pin->chmap, 0, sizeof(per_pin->chmap));
+
+			per_pin->setup = false;
+			per_pin->channels = 0;
+			/*
+			 * KAE keep-alive is stopped for the duration of real
+			 * PCM; restore stereo silent stream after close. The
+			 * older I915 silent-stream mode keeps its own power
+			 * refs and must not be re-armed here.
+			 */
+			restore_silent = per_pin->silent_stream &&
+					 per_pin->sink_eld.monitor_present &&
+					 spec->silent_stream_type == SILENT_STREAM_KAE;
+		}
 
-		per_pin->setup = false;
-		per_pin->channels = 0;
+		if (restore_silent && spec->ops.silent_stream) {
+			codec_dbg(codec,
+				  "HDMI: restore silent stream after PCM close pin-NID=0x%x\n",
+				  per_pin->pin_nid);
+			spec->ops.silent_stream(codec, per_pin, true);
+		}
 	}
 
 	return 0;
diff --git a/sound/hda/codecs/hdmi/hdmi_local.h b/sound/hda/codecs/hdmi/hdmi_local.h
index 548241ad3fa9..20e7536efef0 100644
--- a/sound/hda/codecs/hdmi/hdmi_local.h
+++ b/sound/hda/codecs/hdmi/hdmi_local.h
@@ -74,6 +74,15 @@ struct hdmi_ops {
 			    hda_nid_t pin_nid, int dev_id, u32 stream_tag,
 			    int format);
 
+	/*
+	 * Optional: called before channel-count / infoframe programming in
+	 * PCM prepare. Used by Intel KAE silent-stream to stop keep-alive
+	 * before the converter is reconfigured for real playback.
+	 */
+	void (*pre_prepare)(struct hda_codec *codec,
+			    struct hdmi_spec_per_pin *per_pin,
+			    unsigned int channels);
+
 	void (*pin_cvt_fixup)(struct hda_codec *codec,
 			      struct hdmi_spec_per_pin *per_pin,
 			      hda_nid_t cvt_nid);
diff --git a/sound/hda/codecs/hdmi/intelhdmi.c b/sound/hda/codecs/hdmi/intelhdmi.c
index 6a7882544ab7..60ed2ffb182d 100644
--- a/sound/hda/codecs/hdmi/intelhdmi.c
+++ b/sound/hda/codecs/hdmi/intelhdmi.c
@@ -418,6 +418,32 @@ static void intel_not_share_assigned_cvt_nid(struct hda_codec *codec,
 		intel_not_share_assigned_cvt(codec, pin_nid, dev_id, mux_idx);
 }
 
+/*
+ * Stop KAE before channel-count / infoframe are programmed. Reconfiguring an
+ * active keep-alive stream (stereo silence) to multichannel can hang Intel
+ * display codecs (MTL and earlier ADLP KAE). KAE is restored from PCM close.
+ */
+static void i915_hsw_pre_prepare(struct hda_codec *codec,
+				 struct hdmi_spec_per_pin *per_pin,
+				 unsigned int channels)
+{
+	struct hdmi_spec *spec = codec->spec;
+
+	if (spec->silent_stream_type != SILENT_STREAM_KAE || !per_pin)
+		return;
+	if (!per_pin->silent_stream)
+		return;
+
+	codec_dbg(codec,
+		  "HDMI: KAE stop before prepare pin-NID=0x%x cvt-NID=0x%x channels=%u->%u conn=%d\n",
+		  per_pin->pin_nid, per_pin->cvt_nid, per_pin->channels,
+		  channels, per_pin->sink_eld.info.conn_type);
+
+	silent_stream_set_kae(codec, per_pin, false);
+	/* wait for pending transfers in codec to clear */
+	usleep_range(100, 200);
+}
+
 /* setup_stream ops override for HSW+ */
 static int i915_hsw_setup_stream(struct hda_codec *codec, hda_nid_t cvt_nid,
 				 hda_nid_t pin_nid, int dev_id, u32 stream_tag,
@@ -435,7 +461,13 @@ static int i915_hsw_setup_stream(struct hda_codec *codec, hda_nid_t cvt_nid,
 
 	haswell_verify_D0(codec, cvt_nid, pin_nid);
 
-	if (spec->silent_stream_type == SILENT_STREAM_KAE && per_pin && per_pin->silent_stream) {
+	/*
+	 * KAE should already be cleared in pre_prepare; keep a safety stop
+	 * here for callers that only go through setup_stream. Do not re-enable
+	 * KAE while real PCM is active — that races with multichannel formats.
+	 */
+	if (spec->silent_stream_type == SILENT_STREAM_KAE && per_pin &&
+	    per_pin->silent_stream) {
 		silent_stream_set_kae(codec, per_pin, false);
 		/* wait for pending transfers in codec to clear */
 		usleep_range(100, 200);
@@ -444,10 +476,9 @@ static int i915_hsw_setup_stream(struct hda_codec *codec, hda_nid_t cvt_nid,
 	res = snd_hda_hdmi_setup_stream(codec, cvt_nid, pin_nid, dev_id,
 					stream_tag, format);
 
-	if (spec->silent_stream_type == SILENT_STREAM_KAE && per_pin && per_pin->silent_stream) {
-		usleep_range(100, 200);
-		silent_stream_set_kae(codec, per_pin, true);
-	}
+	codec_dbg(codec,
+		  "HDMI: setup_stream pin-NID=0x%x cvt-NID=0x%x tag=%u fmt=0x%x res=%d\n",
+		  pin_nid, cvt_nid, stream_tag, format, res);
 
 	return res;
 }
@@ -608,6 +639,7 @@ static int intel_hsw_common_init(struct hda_codec *codec, hda_nid_t vendor_nid,
 	codec->auto_runtime_pm = 1;
 
 	spec->ops.setup_stream = i915_hsw_setup_stream;
+	spec->ops.pre_prepare = i915_hsw_pre_prepare;
 	spec->ops.pin_cvt_fixup = i915_pin_cvt_fixup;
 	spec->ops.silent_stream = i915_set_silent_stream;
 
-- 
2.53.0

