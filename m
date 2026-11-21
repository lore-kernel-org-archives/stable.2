Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795274877;
	b=PEGTHBcE9bpM/gB4czHtSdpD9EQiKE2oYIHbJyYwYC3A/za3y0ZeKMYfutDfmr4f9fpE
	 9IXJnEjtw1EsCbT/yduwAYJSiVnNll49+FUdsxsPDET36jEoAhu/5Bdhu9/MojewSkNzx
	 CzlKBei4f7UkZFixbpcpw72vNqwrSI58AT8g3JiCCxEOBPZ3xwnLtD48lMl4YFljDdCTC
	 zgCfEqFPOHy0XMpePFqJjI0KmPteEmI8ju8IlmmwszZl59mIhL7NNLGaNR9DOyDsfXFr4
	 6EaQiLM+N6eCJLVN3RZLyWx0R1q50bfetl9pCis2PW9gNsYiYC825UVRUURVNyGOpFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795274877;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=likZmZXx0F85Ku7zaOxGMi1gzgxcUUMJs5K24Oq+k3A=;
	b=4lq5IT+0SYk4dBnEAVnHILY8ANQRzA0SEYhLKfnvsxFcL65DLAWeaBdm41u9Uzl7QmHw
	 X2TqiEBmiZ3RwENQTTWCYWELCX8o+nvDatxZpkW6kSb16tX9lBsd0Eh9bfmy4QgL0o41v
	 EjzndIT2U1Duc5XkHGFgFlbS2GHgNk0roYvjHF6n6jL4Y/GRh7NsnIwjQW72MipyIWUgy
	 fvAguzK+xRlR7yZlO7bj/q91E7u2ORu65Ct+RjMQvjnFu1MWCbDa8VkHqbX+NqBVka4Hl
	 hhv9mCuby95kxWUzDkqfAwvXo0N/i8+tDaEmM2zAME9qpX6okpByDpBpPOjEqOF4Pdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Tsv6/XmV";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3B1606A331
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 15:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tsv6/XmV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D1F1F000D3;
	Sat, 21 Nov 2026 15:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795274876;
	bh=likZmZXx0F85Ku7zaOxGMi1gzgxcUUMJs5K24Oq+k3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tsv6/XmVk6SlUTc8QBNlLqlbOD+tdTkVPGTk2FpcG0s/xsOAp/Osm0ZkdUz+4vOif
	 GWjjGg1+ukPcBApILDGF6hkO4srRuuJczvoKX6QHMp4V7dflX0HE22XqCLKsk76ATt
	 AdB2XG9mWTBAsTXRvYGBY+uwEjBnTlRUPwRd6gB3qTyafVxWoUzKFPPZK4ZwrXcsCg
	 +qMOdfokbs1mEv3/XKen7TRqTbO2Lc10jgSxPkJ6eRQaSv6CczpeDSpuu6yZDZOTnG
	 CU8Vlcv5jTLBvi4wQbqYwbLGnLzNAWFIkHlQhNOLalsEOU6zAC31nAv2II78pTjDQE
	 Lko84aOxhrANw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: [PATCH v2 5.10.y] ASoC: rt7*-sdw: harden jack_detect_handler
Date: Sat, 21 Nov 2026 10:27:37 -0500
Message-ID: <2026-11-21-1-daily-reply-0009@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <1795216604-17006-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
References: <1795216604-17006-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 0484271ab0ce50649329fa9dc23c50853c5b26a4 upstream.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
