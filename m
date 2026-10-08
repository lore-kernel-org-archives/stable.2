Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C5A3B7760;
	Thu,  8 Oct 2026 09:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452691; cv=none; b=EseLBG070HwfFDX/2kxqvGKNLBegSc1EqqPehV046rGLguLk+WE39Zlgkub+shcqEtuuIup/+cMV8K56YPj4tyhJQ/l/BcBDK1aeyppeD6IwzSRRdMoX7+xc23FbD2iYrFOK9WgGk5aEsDzqjL8YzjWFnrfJnYJ8quh0+kwGPeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452691; c=relaxed/simple;
	bh=tIWKNokKZ9do3AnRTcPv2sHkIvOb/UhZMhCfk6dpXTY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=d/nRsJ/rafkdZT1+lI9rQwGgjTdB8vpPg9YBAEzBvr6JNekD30FZvJF1Ki9yOEgIEIRJHDJMgrO6yycFi2Y2CxeQF8hyufYvHgchWXTKT+1J4sbwatba8WulqCMfAbLW2fwP2D5LVQUX6nbvQUn+gi+ROJWj/zzh1AwMDNwR8C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJVPpqfS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJVPpqfS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D011F000FF;
	Thu,  8 Oct 2026 09:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791452690;
	bh=gBCi/+Dgc6mXIeQ3dTZreG0MYlhf/Sp/PUnYU4cdJNQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=OJVPpqfSotxdHBvLTUXa+UWhrAaiQoqepOzZUTouWRhwyaKnn1BMrap5ptnSqZk4T
	 C0NmnBUYHtFrWWxX8tMLU2f/8Va+kowB8HW3FxKsH07YFWFcGLWMdTvM64C9Yyej3a
	 2chCoydYDcXstUdnLEXXSsxWYiFVK3EMxN7FIOpIrFEc4QGAnxvoa3/2g0PnmVw8aM
	 ysW62i5mLA5rHgSVnktN4whOY81/+WH4ggFNls4ogpyJCS1+qxkd75K4l7D625uKy/
	 LvbVuRAy/doaeycLFnFwDZ9J9ZXgIghP8GwrL5PjfAF/jLNlQ+89Z5hucQqZnP1Lkj
	 UaGFFko/WFI0g==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com, 
 yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev, 
 stable@vger.kernel.org
In-Reply-To: <20261008090143.15158-1-peter.ujfalusi@linux.intel.com>
References: <20261008090143.15158-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: sof-client: Use event-handler mutex
 consistently
Message-Id: <179145265815.2423942.9687769068748752029.b4-ty@b4>
Date: Thu, 08 Oct 2026 11:44:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1138; i=broonie@kernel.org;
 h=from:subject:message-id; bh=tIWKNokKZ9do3AnRTcPv2sHkIvOb/UhZMhCfk6dpXTY=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLKOp34NntT6J3/V+YniXUk2XfMmOmobWgdHrb4c8mvnz
 BMvmdyvdZSyMIhxMciKKbLEZXG/rC95vYbv4MI2mDmsTCBDGLg4BWAiGcmMDM3HHnGLx16ymM9X
 tN7pqcFv5nsaJTYJcyq7txZclFcPfsvIsDSna09Hzh1T8w1PY+zqAsU6WG81bi1+G/w9ZOXkqnI
 DdgA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 08 Oct 2026 12:01:43 +0300, Peter Ujfalusi wrote:
> ASoC: SOF: sof-client: Use event-handler mutex consistently

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/1] ASoC: SOF: sof-client: Use event-handler mutex consistently
      https://git.kernel.org/broonie/sound/c/f90f8afb61be

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

