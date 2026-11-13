Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828633;
	b=MJ7YeAS/Vr8IzVIO/ydP36/Z/+7lJCbSvFIVZUa+jIn2PDwOAZ0VIyPW5IxEjFbP3Jv8
	 e219aH4EcEqmFEJSiGoiEnd0y62NmD8R105cE8frNgKssHFmlVDVicaZU94/xkwyWSpYO
	 wTYEcUcEu/vq8wIGIse1lrgxX3yBtDlF/Gjw0g2bBGaAA5BPhlOLs/CENnO3GkyGSrjsv
	 GfM+ebaLAoYD+eeazD8o1JnC/s3E/ej8cR3Byc1EzHYaGcKEzZMyqSr/kfpckhYuHtkeG
	 ki0QJv8kazJENrT4dI0pOKByAkeD897k+gaIY2gOd24wXZsqBm1wNfJiSxnSx3b7cwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828633;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=8AT+ODs3oTyh0wYOhNOjFWMvweLcef1FfqnGHxnc0LM=;
	b=goP0sO7992uq0FtlI1+XBAFydm4GYwrzQssj2MScbnc8BCkjVbtNWC4DZeHoVozI+kyc
	 M44j1H4m1bw80+GvzGUFnCkQYrY+2hL73yxlelunpwjiqU5YgGwZbSdfOtWr7WlxQcGrr
	 550hzYP6Pfm29eeXHBiODGQD/izMcWTtblyTmS2THO7v1C10V9lDI/3rAwol4+EeexHML
	 DpFVJ8dQuqeG1Neulv0WM3qb6Cx04BGpqtLEp5362iMSkHCD/priW+q0nh2jzPr5ZaSgP
	 2A4MKVNnJh7tG67ghV0YvEoi2iF2vp9b7BhomtoNkQkE/yZOgidv391rvmjdnp9GgNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ClOKAGMa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A69B606A323;
	Mon, 16 Nov 2026 11:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ClOKAGMa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E516F1F000C4;
	Mon, 16 Nov 2026 11:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794828632;
	bh=8AT+ODs3oTyh0wYOhNOjFWMvweLcef1FfqnGHxnc0LM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ClOKAGMast9SY94xnoz9n34oqm+OgmvJCQ2DT6vu7+VPHtqxXraBmrgmwlfLH5EZv
	 zHuCwr4s8BMS9q5g6KLZL33L2wR3VpkIf4o67MDghK9hHSuOt3HFGNnMneX4izvhAf
	 Nm9dzhuhi5vTZUXCawYx+qBTzQpMgOc8IoCMUi4ToCMAvFw7ynAbO56FMOPhXqEjTW
	 obs4C6JkbvvSiNhVS9SVpJp0B5ylhYSk383G4Z4j7lErxV81HQo9nEulDHRFsTrEIB
	 IUEECV4YZnFpFNdlnIKcyhrZNTzKsJFM+K8ct6pjoKMuD8RnCiGwSv05ceTCBblV3H
	 WbTbIRjVgkGuA==
From: Mark Brown <broonie@kernel.org>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 Kees Cook <kees@kernel.org>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-spi@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Dennis Gilmore <dennis@ausil.us>, 
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261113065508.i.606-kees@kernel.org>
References: <20261113065508.i.606-kees@kernel.org>
Subject: Re: [PATCH] spi: axi-spi-engine: Start the program length at zero
Message-Id: <179458720081.68977.3431166654947523276.b4-ty@b4>
Date: Fri, 13 Nov 2026 16:26:40 +0000
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

On Thu, 12 Nov 2026 22:55:12 -0800, Kees Cook wrote:
> spi: axi-spi-engine: Start the program length at zero

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: axi-spi-engine: Start the program length at zero
      https://git.kernel.org/broonie/spi/c/2a490521d74a

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

