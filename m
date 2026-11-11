Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794421146;
	b=RYYV+iBewSgc620nK7C809Y4xtqZy+34Wq59V+wTfvwzrTgUKUyIHdiieHnmIWuoWADz
	 886f271eqWmuZlHsx7NfpuHmTH6b4FDYNhV5bIlDh6F+p9GOpsBi+znaZ+TntudBSnpXR
	 c0UqGEqfV4igyrOZ9zrHanmacKxzuFP2g9IibsOkwkX4iDKnWnz0IUY0RbuMQPhCssv7y
	 //LDvrONHuJ3nAzqyfunKG/u40vUM/HWYF/Qs34y0cUbKhwaAm60Uz6ajgp8WfoG7ptQF
	 odDUCEXtHGVAoblHtmxpLr70gt9LP00rlaw3FaQh2cAAFw/3/dk2byuQ8/b3r9n3Now==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794421146;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ix5x2z1KAcFfmQuXmYieb4DdG2WOm/4kPE7J06UbTpo=;
	b=ENhOdPckfIF9E6oyEOF5bZUb+qRWd8c5rEjAmn0rJYIP/oAElqJ4W5M/sHo5hYHMKWep
	 TJK3SNj9eUrHO8HSe3C7S/P4aIVtqzXtEX5lIZtFQ1qge7mVDHrvInWhh5qPIyf+Dbj9B
	 rBs8SSwhC0oPg8fz1GrAoCX7gjtzyXZOJKLqXNjCbHuMpei1LEcTx3uM/Q6dwyt+AfSxs
	 012DJXabXwwRd3RXpc2aOuPYHQSVCDMkRYZYLW4O2F0O7jb05Bxn12w7QWTuUlAdrPjoO
	 5BLIkupqeE++wPj+D/l6XZu9dA2KsT9VS9fEbsWfDM7AmLRxxtQ9q0CfJO+gUQo0Spg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LBf67H+b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D577E606A32D;
	Wed, 11 Nov 2026 18:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LBf67H+b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBE91F00A05;
	Wed, 11 Nov 2026 18:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794421146;
	bh=ix5x2z1KAcFfmQuXmYieb4DdG2WOm/4kPE7J06UbTpo=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=LBf67H+bhkLso95vIFAJsj90QZ6BGIQhs0unuJxGPfzYYm6OtyczH1Rg0n+pQ9+yT
	 fX4FTiA7zIKiZSXNUHWo8KxxuTG6CmvDSXeYaJrss068KdopaCLKw3JcbsB06BU5PG
	 SSjdAB1lgeHN57MNlqAuk9qct0bXcCh/saKUxy7t3pXFha4BPR7qmWZI8eQ/d/DhqJ
	 ulJBeCgzIzzKOaDYL/O0aLlAQGPKB0FjJpr16XzBxT5CxNKSJFjuU8DwTtM1CykFa2
	 lGtqjG+GqVtl/bNCZuk/rTWgpaeBCRXgWj4bq+I4awyhOERnZFPli3/0jPDlqvQSt1
	 0UN0OSvMdXNfg==
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
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ASoC: qcom: audioreach: apply volume changes to a
 running graph
From: Mark Brown <broonie@kernel.org>
To: Marc Herrero <marcht@proton.me>
Cc: Srinivas Kandagatla <srini@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261111-q6apm-vol-live-v1-1-be85eef649c1@proton.me>
References: <20261111-q6apm-vol-live-v1-1-be85eef649c1@proton.me>
Date: Wed, 11 Nov 2026 18:19:01 +0000
Message-Id: <179442114124.484483.17652250712513455919.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=677; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Qt31X+PQOd1JhipsxRLInzntzf96dh8r7ocuQxNrvNI=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLK+bJzm/sJ58T/m183Ka6z7DpVZCZw965RTInv+907/C
 z4bz64I6ihlYRDjYpAVU2SJy+J+WV/yeg3fwYVtMHNYmUCGMHBxCsBEPvswMnxkvb2Bdf4EbpNi
 4zdKn17vCQjXY9zB4rBiXw2PV9gj/TRGhmVsv2LiJntcstny49WNbKOruilCr7+n7+N+eOzVj3V
 BeRwA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> audioreach_put_vol_ctrl_audio_mixer() only stores the new gain in the
> module. The gain reaches the DSP from audioreach_pga_event() on
> SND_SOC_DAPM_POST_PMU, that is when a stream starts, so changing the
> "<stream> Playback Volume" control while playing has no effect until the
> next stream.

> +++ b/sound/soc/qcom/qdsp6/topology.c
> @@ -1323,8 +1323,19 @@ static int audioreach_put_vol_ctrl_audio_mixer(struct snd_kcontrol *kcontrol,
>  {

> +	/* The PGA event only applies the gain when the widget powers up */
> +	if (dw->power) {

We don't have the DAPM lock here so this could change while the function
runs.

-- 
Mark Brown <broonie@kernel.org>
