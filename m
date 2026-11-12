Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794510122;
	b=YxIVrYak0ydJBxLrPsN/Y5USXtu4521hPKGyKmC29vFWSi4sQQ6PpD0C/AEbZZ2GCZ/e
	 Yk7OF9lCFsUGg2Ces8My+PPd+X35E7bzrPNZqpKXTyekontJTmqCTIJ1p0SeDsMzcY0vr
	 boWzK5rV98l7dxuNBc8ZKBRAUCBAVRtU2KuwzokjRKiirkayaNN+zonAM6aBCKGOKLCGF
	 4MR1fqomUJVMqj/bvT5QvLfxZuM1ep3K9SmWtceasY7U0DQlhrgR5eUQikySTWLcUyyNj
	 XGCRSWWHE6+Mrla8jNjghVXPN9fY0QUXrlglFhxeOIYf5R/8TbDQrhbHwPuCYji5NVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794510122;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=8oQqp5ZFpZOMdHO9b+pT+N3zGm1+2+rTxitamo+faxQ=;
	b=qzh0hAkZ2qyoNoJfTBjAn3A7YzonEgXAcjyxYk1ow3Xp9ihcCePH43wz0H7fvJTCoY27
	 IOKN/YBvQM5X+YJdPgn8RkQs7riaiLnzyrxSe5zEV14OC2hashjYNkWz9uSM1i1HmRuoL
	 J0rfkn/miSUBebqzc8+6iMWzML+3HkRro6G7DwocRns0vSGgm+9xwu3zpjC1E5eIxBxtR
	 JI7aKiV9uCNHgAlH2E5t+Y00a1qWP+5uIm7st6FDjNunL5ZCHPrXmRqB+tNiBcR+x0wKM
	 qsjqpSjfECjZydQ1oU5uBuvNoeqIMBsyhVN/5O7pBlmaU9hB2Kp8YIPfkaMg0C2ogeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ioytO1VE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEF3606A321;
	Thu, 12 Nov 2026 19:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ioytO1VE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242821F000C4;
	Thu, 12 Nov 2026 19:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794510122;
	bh=8oQqp5ZFpZOMdHO9b+pT+N3zGm1+2+rTxitamo+faxQ=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=ioytO1VEB9be8NaFbuKahvAmiz6i/Upe3bugSBD+2k7xrQMoraf8R4wGz9OCBBsJo
	 yxcmvkAFXNk96DYFeJKEF9QE5xQ1UuXMizsSWjWJX0NHdhuw2Tb2aytQLgnj8NIdJ3
	 m2pjl/phkDTdSo3Yoy02qN9UhFtDoWTM3w3UlwohA680GYNBjpv2yMxq12TrqX3fSq
	 /shkzYXu7W7wKzCZ+7IsGi/L1Uw3T4nuFgtk684ae8Q2Cld3owNNoQGitPCQJfa0yR
	 u0HN3vrpTJvj1xsHvi6Fp7z3fB2hPrfOPZklhVWtXM83EVV3Kw5dfFEJb6jCAx11eS
	 m3JhWJSeAjv7Q==
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
Subject: Re: [PATCH 2/2] ASoC: qcom: audioreach: only disconnect the route
 a mixer control owns
From: Mark Brown <broonie@kernel.org>
To: Marc Herrero <marcht@proton.me>
Cc: Srinivas Kandagatla <srini@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261111-q6apm-fixes-v1-2-1beb5702b372@proton.me>
References: <20261111-q6apm-fixes-v1-0-1beb5702b372@proton.me>
 <20261111-q6apm-fixes-v1-2-1beb5702b372@proton.me>
Date: Thu, 12 Nov 2026 19:01:56 +0000
Message-Id: <179451011682.339049.14469654235895476017.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1365; i=broonie@kernel.org;
 h=from:subject:message-id; bh=gn1UP5ur3U+KaSIP3nb1/aOczNsgnsnj1KzQ6Nq+nsI=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLK+8aptrVkdsiA+fK8Df6KQ4KfZaudK1b2ua+dv7JJqZ
 Vsa2Hqqo5SFQYyLQVZMkSUui/tlfcnrNXwHF7bBzGFlAhnCwMUpABNpuc3wz2QN65aOSeXfFyT+
 XvsymH+/bsaW2+diKhQaBPYw6bnLJDD8Mz13inXhThb9zNtzGVeunVF9lYfhecU7rwmrGWeEcDH
 W8AAA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> Each AudioReach virtual mixer route control ("<BE> Audio Mixer <FE>")
> connects a front-end stream graph to a back-end device graph by storing
> the source module in the device graph's audioreach_graph_info. Writing 0
> to any of these controls clears that link unconditionally, even when the
> device graph is connected to a different front end.
> 
> When two front ends can feed the same back end the result therefore
> depends on write order. On QCS6490 (Radxa Dragon Q6A):

> --- a/sound/soc/qcom/qdsp6/topology.c
> +++ b/sound/soc/qcom/qdsp6/topology.c
> @@ -1300,7 +1300,7 @@ static int audioreach_put_audio_mixer(struct snd_kcontrol *kcontrol,
>  	if (ucontrol->value.integer.value[0]) {
>  		audioreach_connect_sub_graphs(data, scontrol, dapm_scontrol, true);
>  		snd_soc_dapm_mixer_update_power(dapm, kcontrol, 1, NULL);
> -	} else {
> +	} else if (audioreach_is_vmixer_connected(data, scontrol, dapm_scontrol)) {
>  		audioreach_connect_sub_graphs(data, scontrol, dapm_scontrol, false);
>  		snd_soc_dapm_mixer_update_power(dapm, kcontrol, 0, NULL);
>  	}

Given that this is just about protecting the link update only
audioreach_connect_sub_graphs() should check for a connection, the mixer
update will still have updated the per mixer state so DAPM will need to
put that into effect.

-- 
Mark Brown <broonie@kernel.org>
