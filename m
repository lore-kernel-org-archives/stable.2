Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795519682;
	b=m4JH7l/EMtooznY4i1Idnk5WN7Tb3OfVV/WZwH4GJ8JV7GC8SIaMRijNahlNNoBXwKfN
	 ecUb5Bi9aSYWqTCRdfpEw5BFT06uNigcY+dacfJ++D2S3scb+BFiIsb0Y6GBc7Zkty0cq
	 8MweL8MW/zurWkFjYL9Hd7sYEnhN+VWM8t6DisaYbGrydKi5HbjLZlL7JTPJ0kBT9jJXI
	 vDlYJeZE2BaxGnOdrdkOfW92zimktkzFDSHuwFJfuV990qoSXPQlH+ImlK2s+oO4tDg8S
	 yigyEpRdXLm4fmvZtDuZMHsEPhoLkI/pJvO8H/raana/WxN+YWTT4O/4DAFy6WKOF+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795519682;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=mZqZ5sJLGwbaIRL7huQYFH34N+QOtAfLN1m5mgeP2K0=;
	b=zdcyuJKVbzufvL+xxGv3n0zptXn0eLx4YNwegDZZoaAVZiYCx95bf9qvXy5CvIruDbVS
	 auTruDcIkfof7iUjCbtidZq7XdEYplVNghlC+zOA2qF9C5/YLgGC8z3v2GZBZqjrDASi1
	 mZoz+hENw8WZMJ8Tu8pT8D93BSBYuPVUv91n/JZ27BMC6i0eXwNuPzGG/T6+LOFmepa8j
	 e4po5ERBBH3XtgfDBj4K76mYN/BjF7mGUlCvSnRLdSGwnYRbMTyR4sVwKyg6XqXLeQp3R
	 VUfU44XQxxDZIfVJLblrDfGL1xZayR/U3oWoy1HHP782Rrf2Tp4Gki8K2NNGSpI/zoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jp2gwds7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B32606A31E;
	Tue, 24 Nov 2026 11:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jp2gwds7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9201F000C6;
	Tue, 24 Nov 2026 11:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795519681;
	bh=mZqZ5sJLGwbaIRL7huQYFH34N+QOtAfLN1m5mgeP2K0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=jp2gwds7OttrYKwfNH32eCe+gS3Wk4WzRML/toAaPIbufM39ecvyVaE9m6GwCFwCq
	 LPTuNPkXAipgDARjI5WW1qu6bs7FgafA2/TX5rnu06BTekJBTj2ny8NcOv/sbd3i/8
	 gvkCkEk1WqlfW4d08O9YiGmTM/MKfD2L4oFNt6v+45P2LEbsQl69ZRkm5vGUr4QISf
	 zoT23QY/f5mrYROdv8oM3kNXzsq7rFb+kqp63ytCO4xr0MpYx6Pr+Zz72g6t50POec
	 7+/WOBMCvGMUTxuQ8Ft7395jsDUJvTJJffpgd0zmh7U0va33b2W4kDRmsp6SXkZHZx
	 7Dnojg6TQKP0w==
From: Mark Brown <broonie@kernel.org>
To: Somesh Dey <somesh.dey@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261118-spi-bpw-fix-v1-1-e475586ca8e8@oss.qualcomm.com>
References: <20261118-spi-bpw-fix-v1-1-e475586ca8e8@oss.qualcomm.com>
Subject: Re: [PATCH] spi: geni-qcom: Fix sub-byte transfer packing and
 length calculation
Message-Id: <179546169682.25092.17475274653524039881.b4-ty@b4>
Date: Mon, 23 Nov 2026 19:21:36 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1148; i=broonie@kernel.org;
 h=from:subject:message-id; bh=yCgnZB8RwZ6vxcNCkANeGLFA8h632YFiZooLgvISmN8=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJZS/ZdeLKtP+4M69FPRWoHpi1+qXRZKyWxxkXUjU9I9
 p7yxnUvO0pZGMS4GGTFFFnisrhf1pe8XsN3cGEbzBxWJpAhDFycAjARYW+Gv5KsR2XbHBtmMa8v
 Zc4IjLkfJymiv7NXlKvI++/EhzF9Jxn+B8bWRbw7+XJ70V6uqn6P33Ps9vxb1vNId0rW6x/MyaY
 CPAA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 18 Nov 2026 18:26:07 +0530, Somesh Dey wrote:
> spi: geni-qcom: Fix sub-byte transfer packing and length calculation

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: geni-qcom: Fix sub-byte transfer packing and length calculation
      https://git.kernel.org/broonie/spi/c/5bb070e3f968

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

