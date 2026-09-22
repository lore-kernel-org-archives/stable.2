Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5713C1D75;
	Wed, 23 Sep 2026 08:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790150983; cv=none; b=Nae1YvCHGPXn6OwDDr1DDAGDu5taBUAgA7Uc8+/MJJWjEaIZthElPNJYxDTPMFbtjFnoXOzkCciXOM7AOdT5RfqAZyah3kflyuNCEDjD5yJ27FDzO7Lr5+0k3Vw2zTNFiyOYwueKczSg7X9WZd4ZWCr+9hueFmaK9wzMsEJ6Dd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790150983; c=relaxed/simple;
	bh=cBkoYkEUgWXbFok1WbESfD05Q8+1YvgrO3rwKxJEqUA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ksDoiUjNHuZsF4ckhLqBUZDueYDfzt32CA1f1fFQuQ+w6Jomd6e51657OlwBE/DD1HoGt9BmcldiD+Lrq4HTFYyTd7ORY6nQweYocNAiyEmS9B88DjUO1GJvS39sO3tQfPh4mWFlXGCc+VDs+VjdyrrYaiTGvx/7oHNu//orTK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyyjrijj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyyjrijj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28ABE1F000FF;
	Wed, 23 Sep 2026 08:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790150982;
	bh=SrDyYQJxBvyWdWh2KnL9I5MwXJFAZqZc24zljiQayvQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=iyyjrijjXYprauRWpm+UtZGtsyrfChJJ2fgUgahc3mpcUBldni3xrbZKPoAj3HLol
	 ZkcsXs4gbg3kLbCkUuFDBtEbeZEHO0D1fs6qgt0e7qsQIZfjw9wUnKMn/XL1NVfJf5
	 Q7wSuNh0wZ1vGyc5sVkUVQIeeKe8kqkjDeu/nsCeL01gjXpnFwrS/NOe8gsrICiTHB
	 AmfZTEnkfZe8tpjuJ4jH7Ny/GLH0sxouanSFLwASZOnWM5qICMZKbUeWSaZygWI4XD
	 NdHymKzCVBN+diYTdmA+3mQK0e6i9PuGQ0Ao/mEqrlZJC92sGr8uD+Om2tjcjIZTkv
	 U88OjnVgO+TTA==
From: Mark Brown <broonie@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: lgirdwood@gmail.com, linux-kernel@vger.kernel.org, 
 linux-sound@vger.kernel.org, perex@perex.cz, sen@ti.com, tiwai@suse.com, 
 zonque@gmail.com, stable@vger.kernel.org
In-Reply-To: <20260916073136.1971673-1-vulab@iscas.ac.cn>
References: <20260916073136.1971673-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: ti: davinci-mcasp: Fix runtime PM imbalance in
 __davinci_mcasp_set_clkdiv()
Message-Id: <179008516133.322763.10344212401091933999.b4-ty@b4>
Date: Tue, 22 Sep 2026 15:52:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1180; i=broonie@kernel.org;
 h=from:subject:message-id; bh=cBkoYkEUgWXbFok1WbESfD05Q8+1YvgrO3rwKxJEqUA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqs4lA7V6ZWkWpYVBuT/3a6D6rY1GWAYZRiz7tb
 3H1b4KxWGKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCarOJQAAKCRAk1otyXVSH
 0OD7B/0brEHQKzdGRDP+vVITgVtk8ETM0jhzJ8ydOWEwzDUYxPGE7xVG46nfkMYbCjREcBehLPw
 NLucMxllQHv0vuGHSgHA55escw0g97hH7icsZ3/BxxYQlLchKI0rBGmqE5Czs1vqv/8OAq8DUJa
 iqSr5xqT/JD+fgepciRovejXfgB5VzLfuC5BoR+OgA3p6qoxUx3wUcJMfaivgYi3f+uL1K5EqUp
 bY/iG8ee/ZDwuvuvgyc1uc0HU1mhA3gLf7pCvMIhb8dREsYny+drqQziHLuw8P7c46WaXIzGGXW
 oMtkcrbXc3EtzvT/0tkAEosV19xwJjA8/SUiERiNmKwXkSmW
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 16 Sep 2026 07:31:36 +0000, Wentao Liang wrote:
> ASoC: ti: davinci-mcasp: Fix runtime PM imbalance in __davinci_mcasp_set_clkdiv()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: ti: davinci-mcasp: Fix runtime PM imbalance in __davinci_mcasp_set_clkdiv()
      https://git.kernel.org/broonie/sound/c/ba593d662183

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

