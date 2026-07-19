Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE5E428492;
	Mon, 20 Jul 2026 13:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784553603; cv=none; b=YHPfZkQVaXY079iPYlnsVf/Fum3pi/4STiKmVWFGNmbvvuHvYJta39FtLnqjT91YWNvoQlbS1eFkZThbPXXRViu4x093iox4tdp4vbOhmuQQPIPmZ2ZoWT7TbT/jp3JpT2QbFSo1ZyaI+0j1H/V8seYdDatu/ctNUyq1eBSvb6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784553603; c=relaxed/simple;
	bh=vbGNTc+nXZwsVUZgm/yWzgll9ddW1fwsKTv+8w/fsUg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gU6Y8cuNxekmpbRsx8TAQbt0j7DzgSD2KZmy2QWaGUFUEXuVl5KS5uXCEo0SVifEALM7tWlAYKh1avtBhnHiJt/hqPvs8L4/f5zNTFSVQPGfGLIqeC8zX2al1iK1K0mFc54GTD8mi+QE1eb+UTpvg0z+GzCeQjjcHZsQvHFuQrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7asEB/7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7asEB/7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978081F000E9;
	Mon, 20 Jul 2026 13:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784553602;
	bh=Q2qUUA9Htv4wYacLGCZOxwTG6UqehwjPfKsZV7xAt60=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=J7asEB/7MtRs5uXyLLgi76M1urSkblh2V3/UnKoDAQp+3fl0ffaEbQYs2YtDN3k8/
	 RmFVkDrFclY/8w3tiw5UtrcL/fWy9k3tU2Cft+UI1+tr9kTtcXSICIR87z6cGpgSEa
	 Gd7PKxcS9iaLgau5ryu7FyXXfAKFquzWwfCDr7bbqubTEtT9bWWsijja5SavDwANKz
	 az6wGt3W4sgj5IT/5SD+cAcx72/6qjSTBOYOcCVoZ8iBqkJFvzaTkZEYqiVaNi4K4T
	 MUYflR6MZtnsmNTXJDEKfEhygY6quVxfAxXMCSk3enWRY978kQY1YCLe4kt3mjfekQ
	 Zrj3y5YdvjMRw==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Sen Wang <sen@ti.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Haidar Lee <haidar.lee@adlinktech.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260715-asoc-tas2562-put-retval-v1-0-97bf467c924e@kernel.org>
References: <20260715-asoc-tas2562-put-retval-v1-0-97bf467c924e@kernel.org>
Subject: Re: [PATCH 0/3] ASoC: tas2562: Volume setting fixes
Message-Id: <178449517872.33801.16387185093346621490.b4-ty@b4>
Date: Sun, 19 Jul 2026 22:06:18 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1704; i=broonie@kernel.org;
 h=from:subject:message-id; bh=vbGNTc+nXZwsVUZgm/yWzgll9ddW1fwsKTv+8w/fsUg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqXiB/0us5rqRQpdBSNFzji0k7a3RXcyySV39gR
 fJ/QoOJVfiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCal4gfwAKCRAk1otyXVSH
 0AoHB/46DcjbsTe9kw3tYgzlMz3O9mWUZkOqkhvhJYgaibIwnvO6ncbYoYMK14s02VEIYNgnHIl
 nPXgJgpHwsdsG9VVw9bQZIGCGbGSDMNmHfbIZQHE8tnaXBNkk6L5Wzy/qPqZfcRl8au/Lj4tRuy
 2A+NGtEnvWb1jDKCcUg0tuTh20W8yufof6aNFxVaex76uE5FQ9D62UV8HePrEQ1AEH2zu8fZqte
 Kx4n0r3Gr6yxytNN8xBxicZTAsUc4lOxRjOJlq1ZwN+k3rNVzmSjQQdq/pdTgooxaMkpvHDVaSg
 iie94MFMk9qzbwHdruOAA2tc+0FyXF1XoIP3ZZh9frjLZyjp
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 15 Jul 2026 21:18:08 +0100, Mark Brown wrote:
> ASoC: tas2562: Volume setting fixes
> 
> While reviewing another fix for the tas2562 volume control I noticed a
> few issues with the put() operation, this series fixes them.
> 
> It's also a bit weird that the volume control is defined with twice as
> many values as can actually be set, probably the best fix there is to
> regnerate the table of volume values with the intermediate values.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/3] ASoC: tas2562: Validate values for volume writes
      https://git.kernel.org/broonie/sound/c/8fb41964f7e4
[2/3] ASoC: tas2562: Fix event generation for volume control
      https://git.kernel.org/broonie/sound/c/9a9269dbbf1a
[3/3] ASoC: tas2562: Fix default digital volume
      https://git.kernel.org/broonie/sound/c/58b638e7c455

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

