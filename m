Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794404970;
	b=wBrjr1/Z2bFy7v2DMPPCn98b0tbWdga44g3+TEQ3ywOEAAQqezge4BjcCR3qpkP1pWrb
	 e9KgOxfIlzfBchh08bk+hy0kRpj3od5+jWKJquJGds1uxlOGr2RfOd9RLJKupQedbmoPp
	 62aAkIZXhFPb8XzpJE+4GD1RoUipgO407pvHWBiM9vfdQfNMmNt58XYi6/e0Ro2MZD3ma
	 I2587pDopLvYhHE2D0DTc4IXA0yxMkcFYa3xjQnc4OSxOK9DjEYiQk5e2K/x0i/Bk15u6
	 u7f3C3ykt98MUJvDMNVvtJgcul41upi53G+PA1KxHLwDYljAhCcnBljavhS+pbA12fw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794404970;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Bw9aWihjYWPZ2pc+cK7u1BOm3yUetlpv3HqSoI26ksM=;
	b=f4U2ONsnhIc1aJbOvbbSv2DjmaTm4irz2SiRtNQUynmEePoQ5OIDXy8MkicgvWH1e9Z7
	 ZkLb1hXk5lpWmBjQQQbSS7JRdJ7LArbliHSqOGzTcFVInLWbphSitNvw3o6p2R44CW9MQ
	 Tl84wVz1/Kt0b8Qw5XeioXNxKD1GJsq60WIkyj1QjosaBNZPvJs6VTe5p/jaefZFlSVmr
	 CeYT53iQu9W4fmuPzJdUgV90bCeOL+2LpavR32B8Xs5sGe4jKs666i9UkFaH8ttxY6Q8B
	 VlNSyYxA/5U3jG1iRDWYpvZOffBqrZCL/ym58EXzIwSMbEMuozOnXbXs61JlFAIJn5A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LfUljFbI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F891606A31C;
	Wed, 11 Nov 2026 13:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LfUljFbI
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794404969;
	b=kpLNfU3tKpDxA2BAtCAUy1cKRkGV0rS5dwR9wTwNn94ty5LVq6uaeWBzfVf7B4SIDDzN
	 aquRdVdWyLUQKSX3X37osQbyDScGqjAoex92KBXbgaLoh2yax+0Bamem9KNOPg5dYAjWh
	 KN8kbYMaw+5Tt1utQ08eosU+rlRHXhJFkYH5iKlTTwZSqEFj5DbVXGacz2CBM8+ftJvSd
	 fm2o2+h5mtEyoTJ2ET7LVdorHH5sotQCksXWXYyq+CHXrJvDh/vPokUjjxzu1bqUuTNOI
	 jPnTb65y7SoDGbahMH4AG3oPhy2SYkjHM89qk6RBwkq9iiMjLbtgcnb6fqVdPlzXNjA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794404969;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Bw9aWihjYWPZ2pc+cK7u1BOm3yUetlpv3HqSoI26ksM=;
	b=qPp0iX4ZmAbA6itnpUTWgnC7azhFI+ZSqxbeDUpjpdbhVYc3GkbxX6XAf7e5OBJueP7L
	 INvgogA5YQyFcC+xPKujwPJDZ2uO+5k/F5iNi7YxxCD6vWBgkZoLGMmVMyypUidAVKjce
	 JBzGsPrfuy8eI06FWJMmyKp4dUPwn2k0KVohK4OnVAAVP4SxL3cN3vySAcwl0gP7buFL8
	 vMANpyplZdiYjam9LMuJPEaXP11uKBBm25LcL/xZ1ePK2AoJUMwuxuiX8YlUtBmmFGvzL
	 w8p+J93hBhfQspd6afvMyIjvmW22W1Mn+wwSs1RtLoUAohTtqrz9vW8Jt8uiJJz2H6g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 523891F00A05;
	Wed, 11 Nov 2026 13:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794404969;
	bh=Bw9aWihjYWPZ2pc+cK7u1BOm3yUetlpv3HqSoI26ksM=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=LfUljFbIN8QEIUFk4G0Ke44qKTy1st9HOOWB4s9BAZbyU3YL5Glb8hgEZSZLJLg4K
	 LSfR+XKZKDlJ7wjp+WBmf9GBRf0FNO9qxffDjawjRnGRYQPuQulAilia6GvLXLOeFm
	 efpk2xL/2rUpHTIWi4JAxREBuOWei93aPk111/gn3+CCYZ22MEgxxHn+okutSvn3yG
	 IbntZXWhshjoPY3WmADgCN0LuM2cftBB3aVNlSqOgcaZsnJcur0RE4L3iaGwhqT/aF
	 aHWLZy+YIVxf7fWBDe4aG2ZiSqqdZFkOn/c8Io1Tg6j7GEO9/Lx1uJ0H+4ZziYo4vA
	 YXp8XIj/Jw2pg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 99E8E48FC1;
	Wed, 11 Nov 2026 13:49:28 +0000 (UTC)
From: Marc Herrero via B4 Relay <devnull+marcht.proton.me@kernel.org>
Date: Wed, 11 Nov 2026 13:49:27 +0000
Subject: [PATCH] ASoC: qcom: audioreach: apply volume changes to a running
 graph
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
Message-Id: <20261111-q6apm-vol-live-v1-1-be85eef649c1@proton.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MywqAIBAAfyX23EJ6MOpXooOPrRbMSkEC8d+T5
 jaHmQKJIlOCuSsQKXPiKzQRfQf20GEnZNcc5CCVaOCj9H1ivjx6zoROGSOcITvaCVp0R9r4/Yf
 LWusHTawBiGAAAAA=
X-Change-ID: 20261111-q6apm-vol-live-d6bb1dbec7c9
To: Srinivas Kandagatla <srini@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Marc Herrero <marcht@proton.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794404968; l=2295;
 i=marcht@proton.me; s=20261111; h=from:subject:message-id;
 bh=SqVgjL7+4cci4LPqvCK4Yw6wIkE/kOA+SDqD9jR9pW8=;
 b=FX1Y+Wi7BB5DpHA+0W6yE2XKgDCznVqlJos0UpJ8hstQWnTb3zNutOendQ72+lQoI638F5yi4
 7XppBorHE+kCr74otdQVCgfAsNs5c2orZsVM06hNcGbVazYVy6NqYr/
X-Developer-Key: i=marcht@proton.me; a=ed25519;
 pk=pIPy6L+INgiuJt7L7umVilPgpzy/Ni3QS77ToLj/H9c=
X-Endpoint-Received: by B4 Relay for marcht@proton.me/20261111 with
 auth_id=1490
X-Original-From: Marc Herrero <marcht@proton.me>
Reply-To: marcht@proton.me
Content-Transfer-Encoding: 7bit

From: Marc Herrero <marcht@proton.me>

audioreach_put_vol_ctrl_audio_mixer() only stores the new gain in the
module. The gain reaches the DSP from audioreach_pga_event() on
SND_SOC_DAPM_POST_PMU, that is when a stream starts, so changing the
"<stream> Playback Volume" control while playing has no effect until the
next stream.

On QCS6490 (Radxa Dragon Q6A) shairport-sync uses this control as its
hardware volume: the volume set when an AirPlay session starts is
applied, but every later change from the phone is ignored.

Send the gain to the DSP right away when the widget is powered, and
report no change when the value is the same.

Fixes: 36ad9bf1d93d ("ASoC: qdsp6: audioreach: add topology support")
Cc: stable@vger.kernel.org
Signed-off-by: Marc Herrero <marcht@proton.me>
---
Found on the Radxa Dragon Q6A together with the two fixes in
"[PATCH 0/2] ASoC: qcom: audioreach: fix S24_LE playback and route mixer
disconnects", sent earlier today. This one is independent of them.

Tested on 7.2.9: with the patch, moving the AirPlay volume while
playing changes the output immediately; without it nothing changes
until the next stream. Builds on asoc/for-next.
---
 sound/soc/qcom/qdsp6/topology.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/topology.c b/sound/soc/qcom/qdsp6/topology.c
index 612d8f03e6e9..5b3378fd29fc 100644
--- a/sound/soc/qcom/qdsp6/topology.c
+++ b/sound/soc/qcom/qdsp6/topology.c
@@ -1323,8 +1323,19 @@ static int audioreach_put_vol_ctrl_audio_mixer(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_dapm_widget *dw = snd_soc_dapm_kcontrol_to_widget(kcontrol);
 	struct audioreach_module *mod = dw->dobj.private;
+	long gain = ucontrol->value.integer.value[0];
 
-	mod->gain = ucontrol->value.integer.value[0];
+	if (mod->gain == gain)
+		return 0;
+
+	mod->gain = gain;
+
+	/* The PGA event only applies the gain when the widget powers up */
+	if (dw->power) {
+		struct snd_soc_component *c = snd_soc_dapm_to_component(dw->dapm);
+
+		audioreach_gain_set_vol_ctrl(dev_get_drvdata(c->dev), mod, gain);
+	}
 
 	return 1;
 }

---
base-commit: cde5523c75f1320a55ac1d55a717ccbb566557f0
change-id: 20261111-q6apm-vol-live-d6bb1dbec7c9

Best regards,
-- 
Marc Herrero <marcht@proton.me>


