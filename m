Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.13.135.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795342406;
	b=oSkhNLxmjssLcKUi38wXNFcwKNCHhxuCMZ6UjIy6OoCLgZrG8arwqsWkK5zM6u/7tlgz
	 h19La8XzDr2jvFRAMJJFxzZp+IvNr/j/kKTFhjY3klkndTEYMnD6VcNXzBXZvtyduVB7Q
	 telr71F9rCWFdouP1z/w1YXtyfS6ypECw+GveU7BN+1pAgc0V4Ge0PcqoyWknFfly2pd3
	 mnVjUwR4CyoJNEpA1n/ySQHWaxgN45LOFXG7mgG3kqMCjp/rRD7mV3V/+xL1ZhZM582IF
	 LAiUk/qV+dlbr/ij9i9xE+Fz+648ZlzANUVEwU6pzl3/pHmCim1mzkfxVDaRxhJvBRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795342406;
	h=DMARC-Filter:DKIM-Signature:X-KAS-Sym:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spamd-Bar;
	bh=zFjx2oOn9zesuMK23MckKDdD3Vemkvr6HzY56oGAmBM=;
	b=xws7YZxa89GPbXvQF2tacYR9PIFQWoDAFLk38PuVqxrFv+oKVteYnAG5T8Wnip0QfeTC
	 GovBQZghbH3c0PlJjPwQVhN5kE7PHIqGByfuGFRxjyz+5TTNM3+r/UYEJM63YAqNkPoa2
	 sDwDoibT1B+DRNTB1wGTX3R2xw8TnchGeS8/A2tAk8vvwyshpG4IbqZscfjBgR/ETZfiS
	 c0m/FWS7fuZfZKCfzQ8D+xRMDK9IYflxD/4pIQ7CS7AsDxnOCUcDOoLOq7zAVYJttsxph
	 k7sdlHW78TZvdv6m3ru2Ork0IC8yS2uZMaXwnMVUQcdEWuJiN9HykuB9u0fHUAHj90g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tsv-stahl-riesa.de;
	spf=pass smtp.mailfrom=tsv-stahl-riesa.de;
	dkim=pass header.d=tsv-stahl-riesa.de header.i=@tsv-stahl-riesa.de header.a=rsa-sha256 header.s=kas202608160020 header.b=R+EJ5bpL;
	arc=none smtp.remote-ip=85.13.135.14
Received: from dd13108.kasserver.com (dd13108.kasserver.com [85.13.135.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0342D606A320;
	Sun, 22 Nov 2026 10:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0342D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tsv-stahl-riesa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tsv-stahl-riesa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tsv-stahl-riesa.de header.i=@tsv-stahl-riesa.de header.a=rsa-sha256 header.s=kas202608160020 header.b=R+EJ5bpL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tsv-stahl-riesa.de;
	s=kas202608160020; t=1795342404;
	bh=zFjx2oOn9zesuMK23MckKDdD3Vemkvr6HzY56oGAmBM=;
	h=Date:Subject:To:Cc:From:In-Reply-To:From;
	b=R+EJ5bpLc/TAr04dybtVEK7dbcEOEsIss8SzPrb+vuTrxLA4YqBYosxFS97ALdGKx
	 8sskFIY4R0R4qkvfZgo/S5GZj7yJe8EieF9sqmQ9jLYiEbu+r1CgwOUq3pnDi33ElB
	 9nWgPROYNiwwT8tCeZ5ma5qnn68qxzz84RfJKKc5Qyqd6n+Lpt66IOQIoc36v9WN0p
	 4gNZMzy6aqz6aJsATOhMmGMYrtaqG8PQfAAMv26nNIoglq8gvnUTlTA3qMD9Xfniyw
	 sxYKRwBbKkU0NvNdH9sSALq/HESJeBbsfS2pRLLSndCrheEEhWdlXfqeLxfZm2n63F
	 NYOIT4ecIgJDQ==
X-KAS-Sym: v3:f51bdf72230551df:qJ5uOu2tDOwck04l6ZZT5ZgS9yYs6RwmRLkVQ2e11W2Qg
	xi4Fjh2AYzKKX2gAyElm3p0uCqidYfZPAU5b1CzV46YKHzkqvcvF9ccxgCloMJKvslloO6MCVfr
	6QdObSfYmUNWJ/0ucr8ReMwDqZqTusb+gYriedhqiF3fS0N72iVo5FfV8U+j8sjgdQrvg+UEGp/
	pMFOz7n2SOuS/Di7sMFu5a52da6xM7KbRWb1W+CP2vGKw25C/j+ejlSDMMtN0jrrQDY3+AOavU4
	QcErcPgCm854wBnsoLaG1yVxs1QYz+HjGQnrwyrtb2YfxTOOrtB2rQBg75sAG60ujUMzYTiA==:
	ZAj/4oY35NYMEd/U/9zhc/w84aoQlxTKNU5I2wFGMzs/70P7k3F4MDGF1s1jelCu6Bh2UKq9PAK
	IC4VmnPaImE8TshlwBidY8QR0I1CIHvn7SR0l1jLzftthFkVfZsh9blQVHj0V+77nRoZn3eyrmQ
	XUK2BIGrH9Eu3AnyUuS3kRpMQohO++8mg/JoXrbJnvWyrOkP9JYu8mmREfzdrUh74HsB6d0q4i3
	evO4sPzyWT9QZqyFGhO1jrbEArAFwh+SxT54DTnCUx0WOxngWf2zcu2Ldcqx5TQHXtrlBdSJ4oF
	HQG1JZbZUnTb47Dk0JpsV3Z+O6s/6H4jaEcQS91CYKd3Eqr4kzCX6UqFw5CVfM6zP7VcMr45Grb
	AdsDwphQiyjZHqT5qYYOkYT1UDIPAbECUvNQQe21b8BdeQ77GIyL03KSFx9D9CTc4lVkGJa4ALn
	/Kf4OXQuc489xt9FXk/nyYfSChzSfePvvNMQ12NmNoWf7IlfvZZNwBCvv6CzrC/huDbE/n88d9s
	jxEAJf4hT2Q5sLwtP2Wjj1L4I+88mc0gPF2xxXHZKK7BNfb0GGkys1b2ENRimxnbuVoQBIfUg20
	m3/IGBYRYNi5Hg8kyI4=
Received: from [192.168.2.174] (dslb-188-098-197-218.188.098.pools.vodafone-ip.de [188.98.197.218])
	by dd13108.kasserver.com (Postfix) with ESMTPSA id 8F90778203EB;
	Sun, 22 Nov 2026 11:13:23 +0100 (CET)
Message-ID: <dc9e1dff-a8f0-4b2d-b4f2-52248196800a@tsv-stahl-riesa.de>
Date: Sun, 22 Nov 2026 11:13:23 +0100
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
Subject: Re: [PATCH 0/2] serial: tegra: Fix 32-bit overflows in the clock rate
 adjustment
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Shardar Shariff Md <smohammed@nvidia.com>,
 Krishna Yarlagadda <kyarlagadda@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
 stable@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Laxman Dewangan <ldewangan@nvidia.com>
References: <20261025-upstream-serial-tegra-overflow-v1-0-267b5b7a79ee@tsv-stahl-riesa.de>
Content-Language: en-US
From: Patrick Fischer <admin@tsv-stahl-riesa.de>
In-Reply-To: <20261025-upstream-serial-tegra-overflow-v1-0-267b5b7a79ee@tsv-stahl-riesa.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: --

Am 25.10.26 um 23:50 schrieb Patrick Fischer via B4 Relay:
> On 32-bit ARM, both the clock rate adjustment from
> "nvidia,adjust-baud-rates" and the check of the resulting rate overflow
> a 32-bit long at the high baud rates the adjustment is meant for. On
> the Tegra Note 7 (Tegra114), Bluetooth at 3 Mbaud therefore ran with a
> UART clock 5.6 % too low, and the check computed -0.18 % and let it
> pass.
> 
> UART clock at 3 Mbaud with a tolerance of 136 for 1 to 4 Mbaud
> (pll_p 408 MHz):
> 
>                     requested    configured   check
>   without patches   47.79 MHz    45.33 MHz    -0.18 %
>   with patches      48.65 MHz    48.00 MHz     0.00 %
> 
> With both patches and the unchanged tolerance of 136, Bluetooth on the
> Tegra Note 7 works at 3 Mbaud: the UART clock is 48.00 MHz, and the
> WL1801 scans and connects to a paired device without HCI errors.
> 
> With a deliberately wrong tolerance of -500, which gives 45.33 MHz at
> 3 Mbaud, the check now reports the deviation (out of range by -555,
> i.e. -5.55 %) instead of letting it pass.
> 
> Both bugs date back to v5.4. 64-bit platforms are not affected.
> 
> Tool use (see Documentation/process/generated-content.rst): both
> patches, their changelogs and this cover letter were prepared with an
> LLM coding assistant (Claude Code), which traced the wrong clock rates
> I measured on the device to the overflows, wrote the fixes and drafted
> the texts. It also recalculated the old and new arithmetic for the
> affected rates in a small userspace program; the results match the
> rates measured on the device. I reviewed the changes and ran the tests
> on the device.
> 
> ---
> Patrick Fischer (2):
>       serial: tegra: Fix overflow in tegra_get_tolerance_rate()
>       serial: tegra: Fix overflow in tegra_check_rate_in_range()
> 
>  drivers/tty/serial/serial-tegra.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> ---
> base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
> change-id: 20261023-upstream-serial-tegra-overflow-48d3d0f7afd9
> 
> Best regards,
> --  
> Patrick Fischer <admin@tsv-stahl-riesa.de>

Hi Greg,

sorry, I am still new to upstreaming and sent my earlier ping without
any context. This is the series quoted above: it fixes two 32-bit
overflows in serial-tegra.c that leave the UART clock 5.6 % too low at
3 Mbaud on Tegra114, so Bluetooth fails there. Both patches have
Tested-by and Reviewed-by from Svyatoslav and still apply cleanly to
7.4-rc3. Please let me know if anything needs to change.

Thanks,
Patrick
