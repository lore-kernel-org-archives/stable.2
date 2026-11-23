Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795462181;
	b=CA4EkXz3fMp4zGkEIMfJ751DqcBXAkfSOp+P8C8jh2DTHZ9e04vYk7jQpzrRo+8Pc2JD
	 nataOCQIqHCvvFZYwe2tAoIFaD0uRAfb5UnxsWM2JZcnnOGW46a1P+WDx36yMEJPbxs7n
	 H1uhScz7ULiX+ZMIJZFU8lQb2ls/Kyyg/WqZz85JPEkuc6MtFCEaYKaBMUAIusujsM3Xz
	 JL0OHAV8bdmn3BJRLMLQunsdu35GifMpJD2+LQ0k2PKlVuy+AmBPnqymWXWAjYbLruGuc
	 PZPxevUcVhxj5VUqdJaABWMIQZyRMUCu18AEAW9lA88c9R8FcWkjPDtE0wwz7MkrLtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795462181;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=bigjH10zLaNPMlSkTCzCu9h2jiCICQadhZ5I+UJiw58=;
	b=xkzYKZKox/vQ0GliiS46X5IqJhBwd5EYTCsNZzBje5SaCvGNpa39HS9zOQa7PuYO5HoW
	 4jb/Ef7lra4LGfBayJkG9Spjt7W7N3b2KGMzelPbciBUu+oIbfl+6XniOxXzyxphNKwHh
	 obLTTSTV9MTq7nZEbeROUA4claQCJVeqoKAaa9tITZpxlokT4J9V/DlvC9QaFCSs3vble
	 mV4e9jxHPk4yyHIs4+HcI28mFMa/6T/xbmxIsqCB+Z2oUQBY1NjcDs+DlJWntsLwTg9yf
	 WPy26QeaWOw7CuL2ojwtJXDXfNCVURzVDjLRgTfRylhsuTCkpGSJyJHbNoM2fXJ8Low==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k1fA8pem;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167E4606A31A;
	Mon, 23 Nov 2026 19:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k1fA8pem
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2251F000C0;
	Mon, 23 Nov 2026 19:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795462180;
	bh=bigjH10zLaNPMlSkTCzCu9h2jiCICQadhZ5I+UJiw58=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=k1fA8peme9rsa9SZtPYp2SCdFZWzBRfGLQ7p3XILcRmuBVgtGbFQRNRgh7+5Z4up3
	 fsPVg+w6mDenQR0UfXcUMSfnNUT2ZygcgzV2VTa8mPQlBXJlt5OE6P70gcN5O4V/K/
	 mIpLhUvTt67xHTnqpX6aq2pAMtiuulH+GqwoxQhm+0tgDqMa0x6tHrDnBq157W7sZX
	 CWp2Sk2RtFwcRNixZsDiWUxM1odbGYybPM8s2ri+G41+tCGL4cGbwXRl4THUN+xO2d
	 ed4Uagqz2MLfUCCQsSXvjqcHWZERXU4tYQuNsrJZ67aYZ+hBRi1WCMO9OmscZlS9xS
	 WzGEOTBBh8uLg==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, 
 Mikolaj Kucharski <mikolaj@kucharski.name>
Cc: stable@vger.kernel.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <awNg5lUNAYmZ2tOx@gdkpeagp.my.home.arpa>
References: <awNg5lUNAYmZ2tOx@gdkpeagp.my.home.arpa>
Subject: Re: [PATCH] ASoC: amd: yc: Add DMI quirk for Xiaomi REDMI Book 14
 2025 (AMD)
Message-Id: <179545628055.25092.17562854443052654825.b4-ty@b4>
Date: Mon, 23 Nov 2026 17:51:20 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1151; i=broonie@kernel.org;
 h=from:subject:message-id; bh=0sEofry1lLv1FraWghw/Mzjz5tyHRBiVUBRbGwljwZs=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJZpigq2NX5XPuwlUeVR7X2zCfJHb5Kc2YeiXHOn8PlF
 HPe3vZxRykLgxgXg6yYIktcFvfL+pLXa/gOLmyDmcPKBDKEgYtTACbCJ8LIcPnc7t3Tlhc812//
 PcUj6d4a68VxUzP4HFdNP/jg/1G3xEcMf4UPBnkXmFQteaGT/C7ups6GzCImru6i55U9/3Kk8xw
 XcwIA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sun, 22 Nov 2026 21:38:46 +0000, Mikolaj Kucharski wrote:
> ASoC: amd: yc: Add DMI quirk for Xiaomi REDMI Book 14 2025 (AMD)

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: amd: yc: Add DMI quirk for Xiaomi REDMI Book 14 2025 (AMD)
      https://git.kernel.org/broonie/sound/c/e35cdd54ef77

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

