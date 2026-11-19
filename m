Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116807;
	b=xNxz1kdAVsZQXK123b//L9EuZISbxslRCJ2QN0HJXD4kG6aQVsc4XLdjI6AsVKCS/dol
	 T++a8Bni9WZCHEXMmpgJH6T/HACOnuOg4U3LaFbwSRDBG5QLa7bXNkDZtLLH/I9ZTFFIy
	 3rTmJM96ZSdqYefPf11KWs/5lckzK+KTQg6DzgJYH4lCqbWvamaFuKLhMwJ4hy8z0jXkq
	 hv9IcG36nRtB676zZvV3pnuF94VqdPnc8V4B4Mx1tl7cn2x8CW9F1S2mA9i+GLK84xvZq
	 bD6swIKxmSJQJe0HEbFTJ1N6i4JKgmIXDgIaVMx1qIEFJb/diBAt3fIss3uqO/xSfnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116807;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=PWJMTYSDW6iAsrTqVmB1Qlvs30ErsSN50koeWjTGSHw=;
	b=2dL6uiamvg2Z9MRW6hTIX6KGzEFi/6QPc4qPPHLDxzcEOXf4edHRQqeiPTwS3QSlpDfC
	 cP1QWToBVb9KF60S0liwJKuJPvz/90v+8b6i3HXPcSIsSRYDHzNJSX5P6/zCuQUXTwI0w
	 leg8L5hvjrjoAjQD2LgmeezICNmqZO1IxW2Lk3aPZr2hV/TCfPwqgYDXet+V7NNFuaT6f
	 wAPsy/VhdIQf6mMCyHFiVN2pqrmRaF5ik03RuB3EVCaDKAmQ3HImQd6O4/IkS1ckU4tFX
	 9UT8RVzdHLHqKYN2blNpXRBN3I5jKZrqEre5oC0yDhN1i+f9zIC1XihyCoZx5KJORqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jMbOZnZA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6352F606A324;
	Thu, 19 Nov 2026 19:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jMbOZnZA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C531F000C6;
	Thu, 19 Nov 2026 19:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116807;
	bh=PWJMTYSDW6iAsrTqVmB1Qlvs30ErsSN50koeWjTGSHw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=jMbOZnZA8j4robSgY6UyfOJcpZdRYUZ3spw9ZtNR6lt3NqIPu7/4myaHxXzZ9Hvss
	 uVJFX8XXVocA4XEn1+0TuAoQJJPRFBQNGIrWHYEwqCWEMhyWPGle9UTNwmXDmyOEtQ
	 9JSwE0tk2mO/sYdAPWhDras1nnNN7jdFQqH6t+RR7C5XI7SJlYvbDDoYuJkA25K4kk
	 5GaRj6XWg7cQ+c/aQ7tNv/8YyohIH9AtXsxSgSdjdD/mzeUq5vQNjXjhxfUN7MgkM4
	 4QONZxAhnJ6Yb/P7yqnl1a0NAAK6jObYhIk4z/kFlbxH9eUNkuqHcj/OOzpxkmDlxD
	 f+LRLD1/Q7mZw==
From: Mark Brown <broonie@kernel.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Orson Zhai <orsonzhai@gmail.com>, Lee Jones <lee@kernel.org>, 
 Weibin Liu <liuwb@xiaopeng.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 linux-spi@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>, 
 mfd@lists.linux.dev, Guanglei Zhu <zhugl3@xiaopeng.com>, 
 Sashiko <sashiko-bot@kernel.org>
In-Reply-To: <20261026153253.689525-1-liuwb@xiaopeng.com>
References: <20261026153253.689525-1-liuwb@xiaopeng.com>
Subject: Re: (subset) [PATCH v3 0/2] mfd/spi: sprd: fix ADI transfer length
 handling
Message-Id: <179510519992.116416.10027054295285849555.b4-ty@b4>
Date: Thu, 19 Nov 2026 16:19:59 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1324; i=broonie@kernel.org;
 h=from:subject:message-id; bh=iDO03AS99K8NiTkPwHwoUiyjlCJKa8PanZB+Y4CFVDM=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLL++zNvVJnZu8Fg6lvRC7XTLpbfEPe7/Vji/dl3Sq+Cx
 SU7hc/ydZSyMIhxMciKKbLEZXG/rC95vYbv4MI2mDmsTCBDGLg4BWAiK/MZGa5XhM/+cut3VqSQ
 L39a5RrmU2FMRyKu/D+ww2G/7I7UhIcM/wtrWF4fn6r25dq+2UZWm78+v9Z5zPP9VNmLty+qlxu
 K8XMCAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 26 Oct 2026 23:32:51 +0800, Weibin Liu wrote:
> mfd/spi: sprd: fix ADI transfer length handling
> 
> Thanks to Sashiko for reviewing v2.
> 
> v3 only rate-limits the two new invalid-length error messages in
> patch 2. The exact transfer length checks and the SC27xx caller fix
> are unchanged.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[2/2] spi: sprd-adi: enforce the exact transfer length
      https://git.kernel.org/broonie/spi/c/ac867057db66

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

