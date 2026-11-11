Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794483415;
	b=cp5KvD6BGmIhEa/fuvmD7o0GAR5dtm7hXBDoeCUh355Vra9fhy8IzeGdT6eP66iYAzpC
	 4uUS5KNHzKbmvJLWugBmvmdcgaCk6XX0kcB9Wav4npOQ7Em2sekQADu+/5t7/bmQLEj5q
	 Z2bWu2BtipxoJh6r5OMymR1JF+BuBqUKDFJCYQAcArETqTceaFSU1VGgbLdzQPlGvCmbb
	 xwHfVjG8gTolVvHN21A74zXu6Tj5HszOsog8MCRqV/G23+GDXHh/5i76Vzqh8vxvA/1SJ
	 iucXW9D7b8+sx9UBz8eSr3QabkVyQ87xkKAraNk/ffuDAzJrTn7YitMHrFf5YbNh+cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794483415;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=XJtNcCJMFDWQYwcUNbsbODBqgC368Pu1CnYyfVfGjQY=;
	b=YdSFpwYodaUo8g/SIY4evj9ALYOB0irKrAk7BzJDRXDwDkObw4aVvRVho+dZNYpqlfle
	 t+4m7WJMwj9MCpbWwK7lGfiAjNY7TD+OOhCC9NwyXtGBa5OHE4lyPrV/Fu+U03j61sntM
	 NXZZtyh/PzyncqJi9EwQQ555Yp28lJuaDBH3PsDYlhkeVyhEjn11nulXlbdgb0vGfxLg8
	 ZLfpx6pDbbaz8XzKqbfRq2xK8SS6/eL2qtaCg2pPou99UQPW27Rfe44n1/VJWoxrgeD66
	 tJr2qDocwX9IDEjE0ushIXMubo1Op5GUCyhXC7K7yq4Es0w7+0rRubrLPgQzAcBmxnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="JcUDWBH/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C37B606A31C;
	Thu, 12 Nov 2026 11:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JcUDWBH/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A461F00A05;
	Thu, 12 Nov 2026 11:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794483415;
	bh=XJtNcCJMFDWQYwcUNbsbODBqgC368Pu1CnYyfVfGjQY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=JcUDWBH/LZPxwUzvHOtxhZv81slueft+P6MqFVWRmK+aIfNe90HvxpwRMXRsfN0hQ
	 wxBWIy0ETMriNEbhbUWogS8f+tt9STvZPNKpk/jIUn9qgFsVt+RP/4WqsYQmByE6LG
	 ISe5S06S0fgR1i7g2yUtQZN9bNT6iCzEBP9sgqIF9SzoXxRve/Taer25jP6TstlQrC
	 lrL3Tx8mYDHRCJCduE2HuqMIwt6fFHLWOQ1thq49icgtlUUehIRfCnzSwc/UdY0+Ph
	 5tVmJGZnnJO5AMlMaxz88EG9AJl+6CYqBLIcNcVD2blxYj0TXkWDabb/QTrkCH+vOi
	 07dA1lMA3KacQ==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, zhaofeng2 <zhaofeng2@cmss.chinamobile.com>
Cc: Li-hao Kuo <lhjeff911@gmail.com>, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261111024235.1542-1-zhaofeng2@cmss.chinamobile.com>
References: <20261111024235.1542-1-zhaofeng2@cmss.chinamobile.com>
Subject: Re: [PATCH v2] spi: sunplus-sp7021: fix clock prepare leak in
 system sleep suspend
Message-Id: <179442874822.513646.429223063588831846.b4-ty@b4>
Date: Wed, 11 Nov 2026 20:25:48 +0000
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
X-Mailer: b4 0.17-dev

On Wed, 11 Nov 2026 10:42:35 +0800, zhaofeng2 wrote:
> spi: sunplus-sp7021: fix clock prepare leak in system sleep suspend

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[1/1] spi: sunplus-sp7021: fix clock prepare leak in system sleep suspend
      https://git.kernel.org/broonie/spi/c/2bc7eb398cd0

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

