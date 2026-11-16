Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794871963;
	b=42PCZ1tzpzM7uKUDQnH1ykAbiWeKnevckj33lYlkS5d1+QDKw9KTKZhRyzQI6murCZau
	 Gjdl80EtBkjrmrxi0RnVYM2qKukPOpCpWX7IgE4KYyjlDb60c0OvrF6PCdxJ5JuyY7vBK
	 kadBJq0yhjaONOnDUxl4EIQH7Rm4o4Yrd8RC4hCDOlGnEDPJWyE9zMiTXA5qsayJmVgto
	 i+wS4j2ii5zSO66bwcMlO882ZbJoMJWmzrniqR2giToZzlMRAVCUyEiNZ6aHeZxbUeYFf
	 xFtt6ddHU1xIgp8cVDGk+i1M38WtDNOBSRyPP53l29mVyXnGaUVeUJPRCBf1gxY/3Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794871963;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=4m02QkAHdcS4W3c6T58NkYIc/QgcTEbwebhyZxesKr0=;
	b=yLK4gDvaFq2960DjGgXh9NzkLPDn9bmeVnj2+A1n1qk7bRvaATQTy22C5l32cgYl0X00
	 QC+6FELoA+nFPkkQcU2O/z7ccKImVanzSlV+oQyAWbVYBo76SzWtYsQ+PmoU70mPGrVnb
	 NZ9ZRRC7Mwrjfl2Nix5HYFUOa3QaJz7qgQ0fL+cddLuEwaMqVZSeBBTGbA1mJ3oEka95M
	 fXG4QKMWYVThSFc6yM1GLE0hGMHzZmCvKyIIQNwXNzD0r4q7wtktxo7me1JMpWWYVFHII
	 /oMLh6RyPAmC+gTSll0EyMsZkHxt/amZt+TAl42B+0njXbXN4G2jmrbfJ2f4TUa2NOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="j6k8yd/6";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD74606A336;
	Mon, 16 Nov 2026 23:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j6k8yd/6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30D41F000C7;
	Mon, 16 Nov 2026 23:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794871963;
	bh=4m02QkAHdcS4W3c6T58NkYIc/QgcTEbwebhyZxesKr0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=j6k8yd/6AWSoPdk42Iygk/T9yH3HvRY3vdDAvc14PFA39B6dJvYo6P+a2NE8wlA/E
	 mIWZsnv8bk9ESf7QSqmWtBg8pGN8l+qtK76cGkjjsA0lk8uX4PvDmPCal5UZ/R6GDf
	 dLnLlIb3S4zd4TYnPa4VL+En5iEgEZoDDULwYbdNmeUtxpoHGLmC2HZe+Ni97hKudH
	 JlQZBsj7C+SuE6avZ6SyjiAbcDoA0qUFOrM8Gf5gEjOxKsJB1LxmT4E8og0Oa0iEu+
	 NApSyGD243qI6l8BqGLZGCvt/DeeyOZf6eDCH8+1fpv/IiQSoQwExMh75ucmL/GF9g
	 fn6KyHJjPd4ww==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, raoxu <raoxu@uniontech.com>
Cc: robh@kernel.org, mka@chromium.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <4B7D8523DA6FC75F+20261109090634.3762484-1-raoxu@uniontech.com>
References: <4B7D8523DA6FC75F+20261109090634.3762484-1-raoxu@uniontech.com>
Subject: Re: [PATCH] regulator: vctrl: Calculate OVP delay before updating
 selector
Message-Id: <179486370700.2504946.18275650141256831509.b4-ty@b4>
Date: Mon, 16 Nov 2026 21:15:07 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1143; i=broonie@kernel.org;
 h=from:subject:message-id; bh=IE9FpNRofE0BL39vmIa9JUTZ2uVtDqZNzxbz4TN/BjQ=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJ+T5qR99Bn6bt87Q0v314SylRNSd7AF6LE5fApsfa3p
 4BIu1RYRykLgxgXg6yYIktcFvfL+pLXa/gOLmyDmcPKBDKEgYtTACbymZnhvwOL8EaLPpn3Rsy5
 O8KmL5wWxrNCftbq3O7b5w+ent1r0c3wv+rpk4P6Z50Tdume5s7m+SS2+UnY9i2Hlpg3piz9FeH
 +lhkA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 09 Nov 2026 17:06:34 +0800, raoxu wrote:
> regulator: vctrl: Calculate OVP delay before updating selector

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-7.5

Thanks!

[1/1] regulator: vctrl: Calculate OVP delay before updating selector
      https://git.kernel.org/broonie/regulator/c/33df365ad596

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

