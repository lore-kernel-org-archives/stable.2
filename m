Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776C4342173;
	Fri, 31 Jul 2026 19:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785527658; cv=none; b=DLtdgKTez47+nK5O2/1PLtcTNdtWy3VPHjYqliv/h1O3b1opX6SHFQucrFxpIBt5P7jexPfE4cFnErtpLv/eMQw7UOxFuAPYh1ltE4MtGsV+r0+vOS8v7FEAkq6PKRlGDDKcbkNp6meXHeslqO9aIHoN29QW1Byc1C7yr1KxLms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785527658; c=relaxed/simple;
	bh=tmGd7j0Cb1uKcM29ShP2jT9R97U0NIZZU26E10jA+H0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GYttvJF4M3ZPelA5Ch/5i7nBXRn/iC9IQFcnuIJkrQnCm7zYS9KXiLYkjnCMjtUQUTX7G1FIJ9rHoSDx0v9mFDPP5Qh8HPdCttzxweqRetXbsp2/UCQnMIwd8ZXnpi9NDsCJFjiaIm8RBicFFy5xCqCa7NkioEk1hTLInHjIJBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EC50nuWm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EC50nuWm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79AD1F00AC4;
	Fri, 31 Jul 2026 19:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785527657;
	bh=2v+7Lg6/Y3DBJQZuGqQuQCn0mZRyt25XD/6EVgdkIrc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=EC50nuWm/hb7fO4cHfQYyoDklHCudzLDFU5M3gRcFbmbYJhVM9381Hh5RIKiEk2A2
	 5LBwSHTC5PSyORsDseGQeJPx++1pxRbDPocZRgIAw2KySDS+WPQ6+YaD086pZ2pAYN
	 GAXVIgsGWP7XKT59gy3FdemCpHJuQCx/FVQmGYsqGfkLFrDJgWj7qOMze7ZbAu7v6L
	 7R9+e7Xo75xKJdTxX4QuhEANe7bsIQ/lmeT3z0w4xVC3XK8qta/oLsAIleXh0gyxcu
	 UD9o14YFavn/pAakmMQu3gqyNuSaywKQkbGD2nbj2Kj0l4AP9lxDUqwj9CwZzppAGv
	 4s3DJtZSgcK5w==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com, 
 yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev, 
 stable@vger.kernel.org
In-Reply-To: <20260730112343.26687-1-peter.ujfalusi@linux.intel.com>
References: <20260730112343.26687-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: ipc4-pcm: Continue the pipeline trigger in
 case of IPC timeout
Message-Id: <178551089072.353541.6659390446155129069.b4-ty@b4>
Date: Fri, 31 Jul 2026 16:14:50 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1166; i=broonie@kernel.org;
 h=from:subject:message-id; bh=tmGd7j0Cb1uKcM29ShP2jT9R97U0NIZZU26E10jA+H0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqbP1mz2DmaI0DwptKK17TMEt4xGUIbeDoLBShy
 fudURBacDGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCamz9ZgAKCRAk1otyXVSH
 0D1HB/4rygGByQ1gnyZJWPcB1EpBEefv2+FH/sqruHiaCZfw5MupA1F1GWvQtY7W2ddx1Jxq6dX
 hRS9DElZR59JyNmuCZUqzmOtAXRPqBXCl2itkiVGIJejsIcJ0dnJh0Q7f+F/elYu5njJkGeaVgk
 2/dzq1C8X62Y3Nwkmq3gvjSBUQJoxpKOoYPWAPuEqelbpE1SmYbQlPA7rKbj/nSfwoaLf9w/wwh
 95Q275MEDZKrPuUO9fgjcfc8PYBUoJfzupf9g15+aALKdHT+gEOj3qS2RnhvC9Kk9XYqmQi9f0L
 /947deh38es+v7aKwZshrVnGu1A9O4YTwtvoeGkBX2XlZ5Bb
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 30 Jul 2026 14:23:43 +0300, Peter Ujfalusi wrote:
> ASoC: SOF: ipc4-pcm: Continue the pipeline trigger in case of IPC timeout

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/1] ASoC: SOF: ipc4-pcm: Continue the pipeline trigger in case of IPC timeout
      https://git.kernel.org/broonie/sound/c/17661c67b206

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

