Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794581761;
	b=rrbmlCAXjENdkLPmaa9Lq+DQEvNn2a9hLUDu5qx1tgS21s4VgFqU4F9pDETNqM/N9Axb
	 iqhanQbELF1SKqRhMHImB22YOPzUeL7dnsbIaR8910RJwKNYVO+z8VPy2YTyvV3N575mc
	 jIU3u1M43O4RQNwq4Cpk1zh9mVLP3dYTMTHJsRwIjSQFU0SZM2X5Rf858VJiUFIf9IAw9
	 O0mEJeJ/p99BpyoW09quuCB+5+7khFemLOoyyHuYB5hx2PEQGBP1D0sXUZQIY4WtTBgPc
	 3GA7+o1cEMaD5UHxkFUD8E9uMOb4z+ik9SdlU8pst8XfEeQpAlP1Z6kgOWygb1N2d9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794581761;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=zbkck7rK9ZeAo1XYOdrmCRWw5wC2GxwTnQHKjlo4UCA=;
	b=rkIO8Zvmr2HVqOclBWzn9wutq9kjE2/P0f7fjcaAgRsKl/PvRELs86vwiGS/XNog1ojO
	 0eIlBsydiroOVflByGH85AzAq14YBYySJC77KoNhSZpPODbLw5JPtu8rc9DRMg8UwEDE8
	 d2jsxeyTjKVwCehgUfCBeVrqSYloZlDFbBGSCajZxumXpEsYgTUikNEmvQrKdlszaXTx3
	 x7Fx+lonCUWkb1VRWQW0MdY7y/2jNaZgYB2ogkRa4GL0nAcJpXvT8c4p//u2pvyD9ztlu
	 NmhEREsvJ84hb4JRmUte2dZss7uqe9UcPpQ1jjHG7XsYwe8poho9Bd1TGOWjovYuWTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PYlt8ay7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BA4606A32D;
	Fri, 13 Nov 2026 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PYlt8ay7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F4E1F000C4;
	Fri, 13 Nov 2026 14:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794581760;
	bh=zbkck7rK9ZeAo1XYOdrmCRWw5wC2GxwTnQHKjlo4UCA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=PYlt8ay7/f01k+uAtrpNqYuG1hJw+/7LJttkyP9OcoJhqFsQjdDouFWy74sFH4Kmw
	 +v3JSPjXTu8L5t9L/6vLbPR5xwY6kwSjLkzJ1qjh50v//sNp4RcwtxoSTE9jLbba95
	 hEoV5EW0v6d1HLpQWgmW4R09uAG0WoD0WlG9FOUfjA4PPQwLig5FMRf5NIOb4XGlRF
	 MLV89MQJVgkELPF47LPzdjydQ/7v8/L9KmyO52d8bb3+Kg0C9j7nopohNTBTDuzSn+
	 snMiWc9AsHkyNsbFxq2lc/Fx28LQGBjUq77kdmGXRHkkT2BgRq3xRkKbqtDvesbv4J
	 KSK+ANyLaVrRg==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Sven Peter <sven@kernel.org>, 
 Janne Grunau <j@jannau.net>, Yuvan Shen <yuvanshen09@gmail.com>
Cc: Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 mfd@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261101-upstream-macsmc-key-info-v1-1-fa9ff863d199@gmail.com>
References: <20261101-upstream-macsmc-key-info-v1-1-fa9ff863d199@gmail.com>
Subject: Re: (subset) [PATCH] mfd: macsmc: Hold the lock while reading key
 info
Message-Id: <179458175847.70591.13412979849674221335.b4-ty@b4>
Date: Fri, 13 Nov 2026 14:55:58 +0000
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
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Sun, 01 Nov 2026 11:51:58 -0600, Yuvan Shen wrote:
> apple_smc_get_key_info() releases the SMC mutex when apple_smc_cmd()
> returns, and only then copies the reply out of the shared memory buffer.
> A command issued by another thread in between can overwrite the buffer,
> so the key's size, type and flags can come from a different reply. The
> hwmon and power sub-devices call it from their probe functions, while
> the other sub-devices may already be issuing commands.
> 
> [...]

Applied, thanks!

[1/1] mfd: macsmc: Hold the lock while reading key info
      commit: 8734b221c98ea48b16c4d9389183e869b72b0e5f

--
Lee Jones [李琼斯]

