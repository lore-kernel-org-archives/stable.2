Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EBD2F619D;
	Fri, 24 Jul 2026 00:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784854750; cv=none; b=OPN3oGSeRxYp2MgGkQJhBmlp1Na1hU5XTeGGk1Eti5yHXyPi32I0A6mzgqk1DL6nFhv66vEBWhNB/MiVloihneB4Lz63qSeSdj9pmk911m6aiZXuIX32LaAC7V0v9AgH1K7+vsCPTOYLDjN1MunSFjDvGoex0vKB0xcc7HH5yzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784854750; c=relaxed/simple;
	bh=te6kRqkLmO1krs0PSiQDjUfDFEbV9v++PLkeJvIjwSQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TL1k3BMuzMih9TgxhpKd+TOezs5HakqMc8Z6eKB4uQ1fX1IF1ivdOaWMYRczkD6qkFHJhp6BSej7hSEZlfYKlkJ28g3yU0cTSKWeKjczi6Z+GJiJ1el/hBJ0UgVwSbrqiIbwlkBug2WhuV4k7eBkrLjLZJn3qo5DuIGn6QFHFg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJyJPYoz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJyJPYoz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D30981F000E9;
	Fri, 24 Jul 2026 00:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784854749;
	bh=iyw4jjWpPNdvDo9cinrLl296ZjpnyaO9BrHyNRq15M8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=aJyJPYoz6Gd7gkzAcgDHEkL4vBL+x7Dfcuuv/Owvobr3sWQg7XwgUN4rNvsnyy1Xr
	 IZu0LO1ZiWZolUSpOdROzhteQ5xZPCOYFGavcCLviRygmi5F9h/S9pP2UhYO4iNkYJ
	 bIj1Qm5kU8XskUnQDW1DP8X2vbO3hUXN13B/9ew3zb+VyY09x/cES3Ign1ZY51MkXU
	 O1MERQRGov23T/VNCPWdZgZ04sfjc5y8Elb9X1oMO5lbdecfWvSanMjWZQPk3GNgrq
	 6/mZbHe323pMToNg7nsM+PIWvNBnfE5gOEv0uqq9V2Hf8LlBm2sJVo2Ph77zO+dldT
	 Il6r1TzCg40BA==
From: Mark Brown <broonie@kernel.org>
To: dianders@chromium.org, linux-arm-msm@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vijaya Krishna Nivarthi <vnivarth@qti.qualcomm.com>
Cc: konrad.dybcio@oss.qualcomm.com, damiendejean@google.com, 
 Vijaya Krishna Nivarthi <vijaya.nivarthi@oss.qualcomm.com>, 
 stable@vger.kernel.org
In-Reply-To: <20260722092358.459943-1-vnivarth@qti.qualcomm.com>
References: <20260722092358.459943-1-vnivarth@qti.qualcomm.com>
Subject: Re: [PATCH v1] spi: qcom-qspi: Correct max DMA length to avoid 64K
 boundary failure
Message-Id: <178482982951.53486.6775425961212426017.b4-ty@b4>
Date: Thu, 23 Jul 2026 19:03:49 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1161; i=broonie@kernel.org;
 h=from:subject:message-id; bh=te6kRqkLmO1krs0PSiQDjUfDFEbV9v++PLkeJvIjwSQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqYrjaNu9CHzBo9p26+cGi4onkU5kZomGDMRTUC
 uK4RW0uq/iJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCamK42gAKCRAk1otyXVSH
 0NEhB/4lrwB6XnLvSEJb8F8L8cPB5gX9f33JkVF7QnGc4J5E0ddcg118rb2PGr/3R6pd8YX48Bx
 4fEEdppDArclN9SPPFtkqnMkPPibfreNAuYRepwxqUhIo2ujpwo/auxwznoiKvTMDuiqS0WycID
 cekdEShI0LNkOpch5kvzazZNcWC/Q4/2b87RcXqPzTtMZjJw5wcidM80RKm5E4vC7UFPZuMPMvn
 5gG6jWM/sQoCatNal+iOTsvO13AhtGwwtanNUz3dfXGQ7WgphIbcDE4nlNWlQNAiHwS/roLffVP
 DoJbAyUXZ/oyJPN0KclcNcrd5wtUSBYV/DmDhuS40c2+Mh7R
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 22 Jul 2026 14:53:58 +0530, Vijaya Krishna Nivarthi wrote:
> spi: qcom-qspi: Correct max DMA length to avoid 64K boundary failure

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/1] spi: qcom-qspi: Correct max DMA length to avoid 64K boundary failure
      https://git.kernel.org/broonie/spi/c/90ef2f2961c2

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

