Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7D75187F2;
	Wed, 30 Sep 2026 18:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790792133; cv=none; b=TGL4fpIgYPdiex3B60GWAa3ISmRrwuD2uzjAvEsuKpAFBPdTyrcsor9ePcVTiJu6fnqPjoZ7CxbEqXmk9LsDAwj0fOdaS50ES+c/OpV9R+MQ8rqvjN0rrsVAYkB6lOIndW4LC9C44LKBCJGB/lxLytYmsGf89RqS8vF2xYYiy8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790792133; c=relaxed/simple;
	bh=9kclRhNa+pdcx2zC17CGOe8yWS8pzYlG0y1InHUdTDc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=t1I5fxyjfTNcQE4NvsFUEZd7C1VxOnF0MajCWPmllI/m7oV8j2UamF+l3iueY1QVGzoVX6vwfMdbtTeFl8Fr4OGmBHk+1eXhm1aSYwH6HGvDj+7VTEpfQyUZNolTzwKg4/Pflcytqs3pNx4eMAZ+CvEcTi0dwVOhCN+ejcAzHFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcPUuqYm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcPUuqYm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4872D1F00898;
	Wed, 30 Sep 2026 18:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790792132;
	bh=FMhj9LPnggBc3k7PWtzDXIA2bZfV2+53XsnLhzsJWyo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=kcPUuqYmmbImumhD621BfOC59ga9ygnENuCJdqtPzcs5bFriF1UJDjwc+7IRh/bM4
	 D9mP/oM9kJOVjeLOfFGxqnZmFRMt2Blm6Cg8NoC7L8s6wTH38JW8V25g9nkAqXY5Vz
	 gePjpd3g4DzetiUvomaDIKvIkpNpAzZEJgdWtGcEJJN6MFnk1UJCTkp+tDr/OWDpu1
	 B5k/xTCRKX17lAmMCZMxg/0I+z7kIod5I/esAkoevtKJi0Ch0vWxUWUrFceMyXHh8D
	 B+VpEysb086S08teoMLfC1gUn0pEfELWCma9FpNYY/MP8oO1K9SogEv6dW+1CZAFxg
	 p/SvFYSY8YjFA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Ridham Khurana <khurana.ridham222@gmail.com>
Cc: linux-kernel@vger.kernel.org, 
 Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>, 
 Bhargav Raviprakash <bhargav.r@ltts.com>, Lee Jones <lee@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Jori Koolstra <jkoolstra@xs4all.nl>, 
 Brigham Campbell <me@brighamcampbell.com>, 
 linux-kernel-mentees@lists.linux.dev, stable@vger.kernel.org
In-Reply-To: <20260930105333.3522412-1-khurana.ridham222@gmail.com>
References: <20260930105333.3522412-1-khurana.ridham222@gmail.com>
Subject: Re: [PATCH] regulator: tps6594-regulator: Fix n_linear_ranges for
 TPS65224 BUCK2-4
Message-Id: <179077659988.116826.5599228318428196647.b4-ty@b4>
Date: Wed, 30 Sep 2026 14:56:39 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1168; i=broonie@kernel.org;
 h=from:subject:message-id; bh=9kclRhNa+pdcx2zC17CGOe8yWS8pzYlG0y1InHUdTDc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqvVG/xqKWEo2c3uvKQck9L+WyHaScNcEEKGRM4
 oIitsGrd26JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCar1RvwAKCRAk1otyXVSH
 0JeWB/9JVzKZQuoO434mCKdykiGdKmQpbPP1jirj5S6oHNOckC/rn7OXc/VSbJ+SoofuS7b8vhb
 DUxJ4MdBBpUb9UDcr6olCDxupcCvUhg7zwA6iCFZmNneqZBc/qsLIQN3BFbnAMRQyWsEPI/a1om
 0qxVsCijAgvBWNFsHJYYCiaODKATzn3RgbEajE+tT35PwTSv1QRQl5OI/efD87uzlKvXzjwdtMG
 n/Mp6zVZxnsUj2au4B+rp5uve2mELWf4fG/Oz07oX6KnktLlYvxpbzX26kmgYNaT+LtaMRtCWny
 uBlNcmBPlqxtnqcnjGE4n5b5HnbInvYYwuONT/wzpaAVo4AG
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 30 Sep 2026 10:53:25 +0000, Ridham Khurana wrote:
> regulator: tps6594-regulator: Fix n_linear_ranges for TPS65224 BUCK2-4

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-7.3

Thanks!

[1/1] regulator: tps6594-regulator: Fix n_linear_ranges for TPS65224 BUCK2-4
      https://git.kernel.org/broonie/regulator/c/2f15518682c7

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

