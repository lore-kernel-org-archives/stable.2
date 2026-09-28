Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0BF4D6C3C;
	Mon, 28 Sep 2026 14:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790604703; cv=none; b=At5KeAYNQ+LYvg3wa8VaOtPDLHYfqz3Xbu+YlhD3mDhK7N4bmDFvXleFNgxceV7ttJPBnPEwr6R+4mfKzUcgJ7sinNgqnMkzWgJg9NZeF0l+wUMhdfDfd5/3DUnpi/IOQLGzKPP6ZdUpKl/7igovCKCXFjLJQCDUHFxuQ+dMNSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790604703; c=relaxed/simple;
	bh=2eP5f1rC2G5giHatLBd6b7XUPgX5PW7havgM7U/tMFs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FnwTWTgWE7DUb+5blEayNyPONvNlzCz4cDsTlr2xRCF8CRL7/2LhfaOQUh0PogJMAt8d4sQIz5ISgHG7PbCG0eRp96N5ckZ6m6TQqlnANR8d5+msfacOtiMqwqKxInkoauTrCks3A/vBiTmOOfT3MMfj9gevMK2xLgvYi5mxi20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FilZl3yf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FilZl3yf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F401F000FF;
	Mon, 28 Sep 2026 14:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790604701;
	bh=/JkV/Sw9hstmhD/AD+QsTDqQ77j7eEPvuBV/wLIAZlQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=FilZl3yfjI0otOpLyDYwzbxlXWXRDsg5rzC5ts+2saEdI6MgdxQi3AA5uOnWi4apD
	 juYXxS7uVxVyGeEMr9B0P7rCW282TEYu+lPfn9J7iMr/gZq+lp/Au7eFuKBYXug2n3
	 RvFPjch+73FwIzQo5LQLS3jtoUej1K7t0CAESWVX0beZTNRrOZ4AZ+yxDqehWlM3UK
	 T4XgLRaxFW3ecE4JXZFiD4pFvTjzzRG1zFErOa2koGysoOeieqJMl/KZLiatM4XQdf
	 eojKOarmO9FbdjLxZ+LWr/XbeyQHkMIJGblgdT+KNg7qJnuEpdKpHywdkGxJ53q1MV
	 bkIbV3dmK0i2g==
From: Mark Brown <broonie@kernel.org>
To: srini@kernel.org, Zimeng Li <me@lizi.moe>
Cc: lgirdwood@gmail.com, tiwai@suse.com, linux-sound@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260927010911.51980-1-me@lizi.moe>
References: <20260927010911.51980-1-me@lizi.moe>
Subject: Re: [PATCH v3] ASoC: qcom: lpass-cpu: use DAI table index for
 playback constraints
Message-Id: <179059599429.109964.10222268664920619691.b4-ty@b4>
Date: Mon, 28 Sep 2026 12:46:34 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149; i=broonie@kernel.org;
 h=from:subject:message-id; bh=2eP5f1rC2G5giHatLBd6b7XUPgX5PW7havgM7U/tMFs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqunWZzwsXv1Sl/skIb+0NPksNcuEHBirUxYy0w
 3dAVhWuzfaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCarp1mQAKCRAk1otyXVSH
 0Os9B/9l72MKnKurLzHvVHgHLONVKdwgpkheNOYoJQ/YRXgYejujWPGfMiyaEtEX7v/P0+dmlsl
 94XBj2RWQ4u4NLZjcbbQb9V6PS1fRCVJgd7pyiCKFTGm6ehXIiSBij3a7B3z8UW2tsXexBZ6qJe
 CO99m48F29oVyHQR2DwtH8LCC/+qISe4IU9kBxvDLhBXzXeaAZhPLN70pwXlGUGpirlh4zqcFeQ
 qi2L29Z92VLvD0JwmwMSucqOIM5l5YlsVN7EU6awGr8bmAJBjfmiZ3n5dnfCiTqlb9HfbZM+MZ/
 G7C/VPqFlMHPUi4Jc8IJdC2PdI6ZVyjcOVeTD/OCKkQ8rXsi
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sun, 27 Sep 2026 09:09:11 +0800, Zimeng Li wrote:
> ASoC: qcom: lpass-cpu: use DAI table index for playback constraints

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/1] ASoC: qcom: lpass-cpu: use DAI table index for playback constraints
      https://git.kernel.org/broonie/sound/c/ca51771c8efd

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

