Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=84.42.129.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794172224;
	b=vc/WzAt8e8Fcemu9QZkQHVO+RpYfvlxrZcXKtylC13sLDY4TqnT9qO2ic47zgjQi2+Bu
	 7o2ztaPcxPvlATIEmfeGprlEA5MQRn1Vq0ErqWqteJmqSxFJ5J/q78JICFfgJa4cp5Mfn
	 z7UoTueTIrmiEYY5tB/NES0uUeEYpJ/PW8UDOkC8iGTUusLjUgFTSnKHOgMwzassaOQEP
	 2j3Vx5mjke/uMReUEsgwuJIQ+KouEwkxr19mUmtffjSO/gqPoV6Hp714YWLhuawfdlGwl
	 DKiO+uuSBnB4GNuQmhgLzQJQDbRWR33gp4z46OhfxpfrbcTU4kM56MMBwmHIOyRNySA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794172224;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=EjsqBLuF1sXdrDz3JLLwnQ4GN2c9mE8wj2r3EBY/VX0=;
	b=GqryPuEPfZ+QyVz8EoFZON9rZnSpSepCmpG/x7ZlZhhTXG0cPX3I0z7KeJoTC7qc7A05
	 U35eCx70WqyrUyeAsAcq8rFbMNDYm0q41V5ue4cAJZ/9mstOMvcP4jCXCPBd/I5zTmhnw
	 2h/0/1I4J9EaQ8/Qgnh8BTkQcocnRjsEQGMx5EjHJFeZvTZ1hJwJHb6Qqat4EDp1UNDID
	 4NqYu7zjWHqud8010jMTVixlr66LyZ0Xjr/okLMseRCimHCBXlnC9FZ+le/ErzZEgvYGJ
	 qKJVbWoVDJFZmJxH95NRPgEJfZk2CL6PPunA4nRP1SC1OWtTlvYQQ9XZh+6seuOcqWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ixit.cz;
	spf=pass smtp.mailfrom=ixit.cz;
	dkim=pass header.d=ixit.cz header.i=@ixit.cz header.a=rsa-sha256 header.s=dkim header.b=h1IFtuvS;
	arc=none smtp.remote-ip=84.42.129.46
Received: from ixit.cz (ixit.cz [84.42.129.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8710E606A322;
	Sun,  8 Nov 2026 21:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8710E606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.a=rsa-sha256 header.s=dkim header.b=h1IFtuvS
Received: from [IPV6:2a00:23c8:f560:e601:e685:a756:6ef6:d03b] (unknown [IPv6:2a00:23c8:f560:e601:e685:a756:6ef6:d03b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id C08AF5340178;
	Sun, 08 Nov 2026 22:10:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1794172221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EjsqBLuF1sXdrDz3JLLwnQ4GN2c9mE8wj2r3EBY/VX0=;
	b=h1IFtuvS1Hi4U5TjeWLUr2r7evJITovvIAaRS4lZen/12UOJ0o6UxfwKQxZ3EySkx6dUQO
	PJlbCjlJvr2NJIYOOOfSiN0y9mXitdKOJGaYvC1gCF6epMIg0FZSF/s2bj2xa4fNWxe7v/
	jw1RpDBNVfswX6cR2AoWbj7BFBYAEUM=
Message-ID: <7a0fba29-8577-4d0f-8f23-85745c196b5f@ixit.cz>
Date: Sun, 8 Nov 2026 21:10:20 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-lg: Fix dark corner in backlight
To: Paul Sajna <sajattack@postmarketos.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Amir Dahan <system64fumo@tuta.io>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, stable@vger.kernel.org
References: <20261108-fix-judyln-backlight-v1-1-af4b946f559f@postmarketos.org>
Content-Language: en-US, cs-CZ
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <20261108-fix-judyln-backlight-v1-1-af4b946f559f@postmarketos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/11/2026 21:03, Paul Sajna wrote:
> From: Amir Dahan <system64fumo@tuta.io>
> 
> Restore qcom,num-strings to the default of 4.
> 
> Downstream had qcom,led-strings-list = [00 01 02] set, so for upstream
> we assumed qcom,num-strings was 3. [1]
> 
> However downstream also overrides qcom,num-strings to 4 in the driver [2].
> 
> Therefore, the correct value is 4, and that value is already the
> default, so we don't need to set it in sdm845-lg-common at all.
> 
> [1]: https://github.com/LineageOS/android_kernel_lge_sdm845/blob/lineage-22.2/arch/arm64/boot/dts/lge/sdm845-judy/sdm845-judyln_lao_com/sdm845-judyln_lao_com-panel.dtsi#L29
> [2]: https://github.com/LineageOS/android_kernel_lge_sdm845/blob/lineage-22.2/drivers/leds/leds-qpnp-wled.c#L691

I would likely keep the links under --- as the links are going to live forever, 
but not a showstopper for me :)

> 
> Fixes: c6c66aa3ef33 ("arm64: dts: qcom: sdm845-lg-judyln: Add display panel")
> 
> Signed-off-by: Amir Dahan <system64fumo@tuta.io>
> Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
> ---
>   arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi | 1 -
>   1 file changed, 1 deletion(-)
> 
...hard-to-read downstream code, good finding:

Reviewed-by: David Heidelberg <david@ixit.cz>
