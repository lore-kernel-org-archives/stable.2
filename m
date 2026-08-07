Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5172A229B18;
	Sat,  8 Aug 2026 12:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786193377; cv=none; b=Lh4ELqMfOuGCKpEAk2WzEzLonAZYrOsrJlOUHEmscOH/lZjN81IL1kmg4B1zsUgL5tBuslasXqOzlRmkXl2FDjaQZuYjz6WTmSAGsPMGA+UZb5SEQRkittqxtOJcZ4jKx1gem6W+bEBogzAK2GP16COmGSDqKyljZOG6DkS88uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786193377; c=relaxed/simple;
	bh=GM8qP0tMb5YOEyFvkoMduniH5nY5H93IcfZSNXeo5OE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XzKd1g7SetnjYhFve+CFHJjpLFamSkS0ANjSsZUEfGHhQebGxEnRK80KJV+hfcJg74SvwtRpkJJ/5x2iX6lFPYQr65l7aE17nJytwf7OZ+AN7s6a/0Ka2z7Z/wtwemp5ivl0LNWUOLW7nDxBBrBU0tZ/L/VUONQFPDE7as+8siU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkhYyjF6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkhYyjF6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973001F000E9;
	Sat,  8 Aug 2026 12:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786193364;
	bh=YRWgpfz4H41W/lGXZZfeM3EypnpZfhLEoPBn1EP63zY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=MkhYyjF6uzQmUKc22sXmaX+KgW8D0l1sBfHpk8oWUi0rXMqh6VcDBti6K2TwFa9XF
	 cBknUE0iSda0xJKIg0YqrgkOBcXRlVvrT5XUIgJAwxukEXdIXGmwD71BFXXCeF7gsC
	 Ze1gdqn2dzIhuauvTzoRMggevINlWDz16hbiKvW723LBh/7mIz6aUkKseMgDjm1Blk
	 zVcwuMPx91Df8hzEoI54XTha+sENbGERC41iIrkpevcLbvoBa87mYYR2jmhzmhgHKh
	 MlRA+9iTXhAggwa0MzKFM1dU029X2eQFmILSr2vC6mDMDNpXsamFJg3cbIIk6YbEBu
	 Slt1XGoMyBAug==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: Alexey Klimov <alexey.klimov@linaro.org>, linux-sound@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260805113911.21723-1-peter.ujfalusi@linux.intel.com>
References: <20260805113911.21723-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH] ASoC: pm4125-sdw: sort the register default table
Message-Id: <178611405200.279158.3215679779461259893.b4-ty@b4>
Date: Fri, 07 Aug 2026 15:47:32 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev

On Wed, 05 Aug 2026 14:39:11 +0300, Peter Ujfalusi wrote:
> ASoC: pm4125-sdw: sort the register default table

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/1] ASoC: pm4125-sdw: sort the register default table
      https://git.kernel.org/broonie/sound/c/8dd18d9956bf

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

