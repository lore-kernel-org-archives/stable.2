Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794064608;
	b=wAIwHPlkStWDhuxEoFEzVfYSduTRbOWvYBi8qGLGdxjbWYBjQV/q6eX2dj8HB9osWc/L
	 ItgUThidad+Qx567tCTfekiwqBqzU/TXPNxy5PDlDSWxbBVxn1+elY69wVHDVkC+j7AHX
	 eA6o84IbDkSVK2Wwi4LLAGqYS17G6vA6AT4ddxdiFXRxD4mF3/ykpLyeNfiRc4ms4jQK3
	 DxRAgtyo4ni4Ic2OFhwqVddAJJ88fNfSVATKDO7r66zw6kueIJqY+cs6PoHcZh34+zlV8
	 tlcaJdksGdTGvIKUO2381p7qwxDAEZDh+yDnZFZqr2t79E/nUxpbt2d+6ft8V5wwe7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794064608;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=WcuhQ3hFkrb8fQW7yfgUWsh40+d8FzchJmD0Z3lY1go=;
	b=vM7I6AFLzBVe+cvtHSsf54U764xZnLukUoR2gfyEBr2of/x2COz5b+5J3jvrpCtFxYBY
	 /9ZeFenpkj2f7KmVSUi6khy4CfrgduI935YahfNFcGF6JUd9gPr9nCc9vvbH08eqeAzoJ
	 DB4smlYTX4FB9l/1jX2qHITojNrAH8sYHURx1HQVA/DjWPWwEBex2NjGdOROB6R1wsGbL
	 JkWG/SYKEI5LuNBU1NKKZqumUhfxeYqI/c8YCUrj6hZtdetdEUqMp4uhNuTMBAgyS8q3d
	 WwFTFW5Umr7w0u1+32oDDR2FeXWlqsGhf0AaJrzjZGDQrsuNBpbAV8JYUuFSWQ1u1hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SEm2vt8I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C75606EE82;
	Sat,  7 Nov 2026 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SEm2vt8I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556851F008A1;
	Sat,  7 Nov 2026 15:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794064607;
	bh=WcuhQ3hFkrb8fQW7yfgUWsh40+d8FzchJmD0Z3lY1go=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=SEm2vt8I8KjX5pguj4Q5aJz9jX1eNs7x7V5O9ZQVk+YVFE19U/R7fV5rL0nsx2eK/
	 bKgTe1ovA4ocWzOuyQVDNPE+xkYmpWvqgEi06f+UHvN9p3CRPkqkfh625BFSUoSCuy
	 fIVWJw7OTF9MnSGV0OgDb+iUMkhQypncKbjbGweOHMQQIMBHkeMS1r4Fbz02hhHvI9
	 gGY+CetZy3+4qa8h2SrIsm2lq/IV/XVdIBd3Qs+bfJM/Zkfbs8EVZgmjRI/4HWbBpF
	 vpyYBoVj9sKVksFgqyrSSe7Tgzq1giBvOpUsBesFyTjIihdmeuOjIqtnHFDYzPZ7Pi
	 JkzIrlDkQJPhg==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 2372B2AB30DE;
	Sat, 07 Nov 2026 15:16:45 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: ldewangan@nvidia.com, linux-spi@vger.kernel.org, 
 Weibin Liu <liuwb@xiaopeng.com>
Cc: thierry.reding@kernel.org, jonathanh@nvidia.com, 
 linux-kernel@vger.kernel.org, swarren@nvidia.com, 
 linux-tegra@vger.kernel.org, zhugl3@xiaopeng.com, stable@vger.kernel.org
In-Reply-To: <20261026132146.3806906-1-liuwb@xiaopeng.com>
References: <20261026132146.3806906-1-liuwb@xiaopeng.com>
Subject: Re: [PATCH v2] spi: tegra20-slink: size words with
 spi_bpw_to_bytes()
Message-Id: <179405581085.3424803.13259814176477205026.b4-ty@b4>
Date: Sat, 07 Nov 2026 12:50:10 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1120; i=broonie@kernel.org;
 h=from:subject:message-id; bh=cHLJXGgW2xV+vqVUshhFt0YpDCp2IMvEvkL3bjmPUsw=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLeO9yxTDMMijji+X+v3uYPn7qVbq7JYlxpcSqWQVmzn
 4t/yvXvHaUsDGJcDLJiiixxWdwv60ter+E7uLANZg4rE8gQBi5OAZhIqgcjw3oV986U71pXxKJ7
 Z6klyGn+a10Tflstze+e8UnWzTOLyxgZlnHUf7sb4N/zIyCDoy3CNu3vZ9se0zveeQurd7THnXT
 jAQA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 26 Oct 2026 21:21:46 +0800, Weibin Liu wrote:
> spi: tegra20-slink: size words with spi_bpw_to_bytes()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[1/1] spi: tegra20-slink: size words with spi_bpw_to_bytes()
      https://git.kernel.org/broonie/spi/c/6a50b668331b

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

