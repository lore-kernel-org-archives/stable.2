Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16045304BDF;
	Mon,  5 Oct 2026 17:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791220046; cv=none; b=ROqc3+wNwNRFuisTEAbDx3jU2CHsKrOUsw02l4wzrj3kCkEEH+1/L4DJqaO9+mN2n0Oir+asrjNfs6KGtWPoMMAT57sfSkwW5EB5OQ1nyQXgoBSk5pQYQApaDJdBquDzBAlNi9BOFLRSH2oifBg5VsohUazcS5uEaDlSAqLttIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791220046; c=relaxed/simple;
	bh=SDjpdbBFZ39k/DuqZfet4sOJQevVkxnoFhNHPvfFt4Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hRLSAK201si3wTwDAftLI+0ywrmf3P8Sl58iMQie3jZZaeHDKEMsi65oSuUqeW97iAxjBWeO8o24xQ89mUziYg4c9vpafp+UMKw6uFri/kjDZ9px5hnx+6tKm4WrPqMelKAEcIrCjmyosZ+fQ7hFbk1G6sZNvTfZECZG+LqXVfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6wh+Y1K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6wh+Y1K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69CF81F00893;
	Mon,  5 Oct 2026 17:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791220044;
	bh=U8ACKpVjEQV/kPL7mmZHikjht6n4jtDDawHP4b8fP7M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Q6wh+Y1KgHgLvqHu9MuuYV/+J8PMmpgB9CNHZEvHAzvulFE8NySCQXZ8DWU5GOr7O
	 bUE1F3pvpiUHPCfO/3KyxS6BCResJ6OIJUsVJHm9NmyEc6+q67Vy9b06Svfv/VS2FJ
	 IPlCf+3XztbWqZkg+PJRbbIAAQPtUm+kdEy/XSwQcigDIFAW4BqRGWcPUiw6urtwB7
	 V4zRWt+jjEg+r5KvNdOeDdPxtXvKZdQ+uABjfqdTMxyIVZ6PM4llDkXecuP18PzstM
	 59Am1qceqX/Vd7wKgcifPetMEiucw7wqRFJRRhdOgVX2f2fWd+ZcJtRyx1qp9Pk/tP
	 o4dKel6AqWk4Q==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, 
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Michael Garland <minimelkav@gmail.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261005-acp6x-herbag2-quirk-v1-1-a1f2683d758f@gmail.com>
References: <20261005-acp6x-herbag2-quirk-v1-1-a1f2683d758f@gmail.com>
Subject: Re: [PATCH] ASoC: amd: yc: Add DMI quirk for Acer Aspire Go 15
 (AG15-21P)
Message-Id: <179121031605.150114.10620784342608818331.b4-ty@b4>
Date: Mon, 05 Oct 2026 16:25:16 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1143; i=broonie@kernel.org;
 h=from:subject:message-id; bh=SDjpdbBFZ39k/DuqZfet4sOJQevVkxnoFhNHPvfFt4Y=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqw9lFtv8Aw42JM0ECioEstsSSwCsracVcxIzmh
 wvyDqUSUSaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCasPZRQAKCRAk1otyXVSH
 0FomB/4p/kAK6GCLm3616PNjTn0bLe56yfbLjXoEtl/PvrknAokPR8vcW+07psTlIvNV5IMtx6k
 Q+AB+PfeIwJ4So4eeT21njlH+vu5tacIpHl3yw5cgMRVi31NpThtlsMTnu4yCZvPnKj8IkiJsZw
 8RsD0TQiSYkv/n/4jyg+lICPP4NcDnxsxwdSTkFRHshFXf8GbvqX45wSGl/4Xj80QnC9/Fih3wn
 F0wNm5Vx+BztQ0vZCCpBYk+Lg50MSSG1X/Lt/MPbZcCLK9BQ+yiSQ+5N5q/NJ+zqaYM70PoCXR5
 J9S27LM8t4k77JKVa5vVm3065YOFVgwLYT6mMdeRuBmQF9K0
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 05 Oct 2026 01:10:32 -0600, Michael Garland wrote:
> ASoC: amd: yc: Add DMI quirk for Acer Aspire Go 15 (AG15-21P)

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/1] ASoC: amd: yc: Add DMI quirk for Acer Aspire Go 15 (AG15-21P)
      https://git.kernel.org/broonie/sound/c/d0cb7a7b2a49

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

