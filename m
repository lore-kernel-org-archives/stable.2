Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794394462;
	b=UHqRFUy3Dlv/H63IFjLnmEaRaJ6DzeAvLxNJTXQQY7HGFbXqwae3+39npmCwqGRzt1C7
	 ALG3ETHJDJyCQww2/VVGv4f2FiOy/o3kZca4hvo79p+PYbWF302V4uV+ShnG6HqDlILGJ
	 amnifs2W8H0aJ8n8+ZklsXZ2EE4XM0Rf/RgjREdRX2SWDw+PgY0w15DNLVR399RGU0HNi
	 zLuOl/HBXGAqtaC4y+4m1q3BybqmpUynYlpJrGx1TME7DXSUHjX72obhxqHgJN1wL1iz5
	 GUerJsY7DqM+1+A5vzChnxn2II3ICwy93nk3hz63ed/63itB4HTDR5pHTpg5p3fU/IA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794394462;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=4SvOebTKFMbQya7gCBewPTnTPz0HZqTShakBlkHoz88=;
	b=nRSTY+MuiccpjToWYH7tnRBLNiE6jvty5apQqoTvL2com6pNKwBTsGia6t/E7sdQvyHM
	 53kaEw8lQmVCBw7SiS6r7wbblP/n32Rv5ggTwtZQAFmQlxQNZyycjxarvmvnAMMcCTWbA
	 UFzpG92KLOpuQNmpyXFiKZoaGw0FUrxT67NjYVHsBXHBr5fTlzZ30U+A0Q0P0cWUtZZ9E
	 Qmp6xaYiMebuaNZvPxaGEgSOeyEUnSvTbryUxlhBCMBmWSYx+MFxjPmNjh42FwoLZYLVt
	 hiZeGGScaEE0M/T7M+OJ+Zw32E9Chf6UmnKYLhcdOHV+yEV/fvY8t+RkzT49sWiaYrA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LeCNeuyb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8953E606A334;
	Wed, 11 Nov 2026 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LeCNeuyb
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794394462;
	b=2ibMg6OIntHZ+s2Q+CGBOPao/gmpIiXZ1by7Mz0LS3qpRdEDrwiej0pNZ/Sy3KIC0+nO
	 3O7YtWNGw7Lakiowf7YMrNYoJkzuWNPVGnaiTIHFH/jJZNg6jPnJOf5emui6+SmDGlCwd
	 R4nhw7vZDw2sNOaPr2aiFe+zkjZKtR7QCiOJ7jK/a+DwOcrTGB4UPYOIncoDKp1YDSymS
	 GB+5Lsz3rAO7G0jIs0eMlWDiUo/CkxG/Rpt+77jYHoHZSV7VtrDPlr30ObobCf9ZrZbMx
	 yXMyFEpsnIENFPmV4R+nq6CFyBCqer2EgxDHCmoxo8nD7UxNYYAEqyMLdfeRMdUgP4Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794394462;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=4SvOebTKFMbQya7gCBewPTnTPz0HZqTShakBlkHoz88=;
	b=bgLpOmzJYhKRk5Io0+0fPF68Eeel76gwlfRjy4HOfTGKzH3YEnqOVxlS8OFNtWpCNkdL
	 3+K6jLgz9xH7bg+ZZo9Q3h2EyjWN4QLFd0xfE8HeE0IMz4P3chfWISE+fwEFtLJZJmUuD
	 k7uJqiASOJi7CIDhYZ6W/jdOyM7IXi52mkDG0hXwIbQuZGf6U9niAylGiSrAd/kSdNJhy
	 5tC5R8Tb/q0ti+yU/x6yzE53kvSNyyZ9Why/NefvIqKskl++7bvVGb2mcx7/TmkkdGRbP
	 qpD+X5s/CIexb7Clkhu+u5DeU1KURHPK0TkfQJTIEEPfUb+CpgV4nPrj5asMSSUA0ww==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B47501F00A07;
	Wed, 11 Nov 2026 10:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794394462;
	bh=4SvOebTKFMbQya7gCBewPTnTPz0HZqTShakBlkHoz88=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=LeCNeuybQ+iH1kwOsw76u3jCz6tZ1Ad789hIGy8LGg1RfCpXa1E6reUnHJxnAjz/9
	 njYW6M1W059Q2KljpwUlho8iFIEIf605iWpwd1XPks05qaAErdju/1l/w9IEhOwYUD
	 p0ntnSgaZ0A4auSgeAawNe1IV03AbeL1VEnC7fuhCSECQYpyPm1ns53DoIJX+0LOAd
	 Qz9JjcBC3WLS7M+Jm9fr2mJJOMBFx7tW6w78Q9PEyCjjULzaVUhQqOb/dio66b9zQd
	 ajR9LRnrQ3YjbFSmUQgTbGTpgWFoq6982QH5PPQtarfYCwPLwSv5/2nd3HWwPP4M3H
	 wcMuKH3OvCQlg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 436DE48F58;
	Wed, 11 Nov 2026 10:54:21 +0000 (UTC)
From: Marc Herrero via B4 Relay <devnull+marcht.proton.me@kernel.org>
Date: Wed, 11 Nov 2026 10:54:18 +0000
Subject: [PATCH 2/2] ASoC: qcom: audioreach: only disconnect the route a
 mixer control owns
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
Message-Id: <20261111-q6apm-fixes-v1-2-1beb5702b372@proton.me>
References: <20261111-q6apm-fixes-v1-0-1beb5702b372@proton.me>
In-Reply-To: <20261111-q6apm-fixes-v1-0-1beb5702b372@proton.me>
To: Srinivas Kandagatla <srini@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Marc Herrero <marcht@proton.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794394460; l=2173;
 i=marcht@proton.me; s=20261111; h=from:subject:message-id;
 bh=uwHreXeheF+PY4xZ0ZasSUnOSnlXrONYE6C8uZecUBM=;
 b=bLkWe0qoIIXe4vR/PnbDWg1bBcDb3ZcqkOH4+4smFjsy+J+H3bp+7RMSHR6hsb0g8jz20cm6Y
 IZlTr6OAuUaBpTR2JKIdOEDdty12wfeTZAMyPw/715ULBSQFkVIhSYd
X-Developer-Key: i=marcht@proton.me; a=ed25519;
 pk=pIPy6L+INgiuJt7L7umVilPgpzy/Ni3QS77ToLj/H9c=
X-Endpoint-Received: by B4 Relay for marcht@proton.me/20261111 with
 auth_id=1490
X-Original-From: Marc Herrero <marcht@proton.me>
Reply-To: marcht@proton.me
Content-Transfer-Encoding: 7bit

From: Marc Herrero <marcht@proton.me>

Each AudioReach virtual mixer route control ("<BE> Audio Mixer <FE>")
connects a front-end stream graph to a back-end device graph by storing
the source module in the device graph's audioreach_graph_info. Writing 0
to any of these controls clears that link unconditionally, even when the
device graph is connected to a different front end.

When two front ends can feed the same back end the result therefore
depends on write order. On QCS6490 (Radxa Dragon Q6A):

 - alsactl restore writes 'DISPLAY_PORT_RX_0 Audio Mixer MultiMedia2' = 1
   and then 'DISPLAY_PORT_RX_0 Audio Mixer MultiMedia1' = 0, which leaves
   DisplayPort disconnected although the saved state has it connected;
 - the UCM HDMI enable sequence writes
   'RX_CODEC_DMA_RX_0 Audio Mixer MultiMedia2' = 0, which disconnects
   MultiMedia1 from the headphones. A PCM started on MultiMedia1 after
   that never advances (hw_ptr stays at 0).

Only drop the link when it belongs to the control being cleared, that is
when audioreach_is_vmixer_connected() reports it as connected. Writing 0
to a control that is not the active route becomes a no-op, which matches
what its get() callback already returns.

Fixes: e4977b91cff8 ("ASoC: qdsp6: audioreach: Simplify handing FE and BE graph connections")
Cc: stable@vger.kernel.org
Signed-off-by: Marc Herrero <marcht@proton.me>
---
 sound/soc/qcom/qdsp6/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/topology.c b/sound/soc/qcom/qdsp6/topology.c
index 612d8f03e6e9..e92408e09bac 100644
--- a/sound/soc/qcom/qdsp6/topology.c
+++ b/sound/soc/qcom/qdsp6/topology.c
@@ -1300,7 +1300,7 @@ static int audioreach_put_audio_mixer(struct snd_kcontrol *kcontrol,
 	if (ucontrol->value.integer.value[0]) {
 		audioreach_connect_sub_graphs(data, scontrol, dapm_scontrol, true);
 		snd_soc_dapm_mixer_update_power(dapm, kcontrol, 1, NULL);
-	} else {
+	} else if (audioreach_is_vmixer_connected(data, scontrol, dapm_scontrol)) {
 		audioreach_connect_sub_graphs(data, scontrol, dapm_scontrol, false);
 		snd_soc_dapm_mixer_update_power(dapm, kcontrol, 0, NULL);
 	}

-- 
2.53.0


