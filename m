Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E331DFFB;
	Mon,  3 Aug 2026 12:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785758767; cv=none; b=S/k57hmkHC2RitxeI1rY18kY7iKl86SGC1JCBby9afH4KXC/wxnoIEEqQrW7i/3cPc7ti/3fSCX+uvWPZ3o+BrER1TBcm4Uxs2jN4nFk8Z+IMWUMjeISRUyVIcYFGKcbARwjCHWhNIeOYN1azzlDMMv7khI3YkvWuBEL5zS3M4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785758767; c=relaxed/simple;
	bh=LmrZPd0sXoO1lZfpdxiRX9ff149gvbgTbp/A/5LhyxQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lPslMX5oyN3y3RC2Zk0kP312Ot4hj4rA7bxFoGjRs9AdEkyZc1RAW3v71JjiNkcTh45NW0/H6MTa//NyVhhlAMgycSTmSNq85hggKWmqNdrCROt2eJLVz0PYRkuVVI0gM9lQ5JF4YcXbQYp9hcVvhmFv50SuwCNX+w0asntrJcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzpQ3qXN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzpQ3qXN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA05A1F000E9;
	Mon,  3 Aug 2026 12:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785758766;
	bh=GwiisxtxnRbjDd426dl411y8wKX4uuzvgnveiiV+zlA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=dzpQ3qXNlgtGGtOcrD0U2ShzzrqMsnplHupbtdOUqpHXauGaDbEXRqrGrCMYcXwVw
	 TJpzVo/UY/wzOlDHbFE1b8ZmE1oTgXHVIirIpBu4S6mvuOymqBSssMZsb+44rofNUa
	 mSRPsriSXw0VXRs22pJmrtMGaNIIQxy53HVAnKpbuhibP2gsIP2RzYFW8wow9CzFfF
	 nE13mTxGoAoKzagi1pDYcCu1speJ1DV5yEBcIUOYKyCgx/1rORBJHL44gTVxVEXWqO
	 W12DB1kkj8CTPIj98filsSQfhOefRUwpCuFJpHim16TzJ70hdYFMjV6pC7+Hy0sxwa
	 ABaHj1w7KBwkg==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srini@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 =?utf-8?q?Dawid_Wro=CC=81bel?= <me@dawidwrobel.com>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260730-worktree-lpass-tx-macro-enum-fix-v2-0-6d091c736116@dawidwrobel.com>
References: <20260730-worktree-lpass-tx-macro-enum-fix-v2-0-6d091c736116@dawidwrobel.com>
Subject: Re: [PATCH v2 0/2] ASoC: codecs: lpass-{tx,wsa}-macro: fix enum
 kcontrol accesses
Message-Id: <178554254606.353541.16114714913692707408.b4-ty@b4>
Date: Sat, 01 Aug 2026 01:02:26 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1519; i=broonie@kernel.org;
 h=from:subject:message-id; bh=LmrZPd0sXoO1lZfpdxiRX9ff149gvbgTbp/A/5LhyxQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqcIQrWTkq4bz/8qyU1z3GHWxO0eSvnwLU8qEEs
 U6g5DaamMqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCanCEKwAKCRAk1otyXVSH
 0InVB/4+5hAUgsj77ZVk98Q8SJlVK6FhxtAr2+XB1yGKSAFOXsTSvpRj+TXd0mOT3mW6LH8msKK
 Kgprp67UDCdRuryf0h/RZGpMKuuFJ+a+sKd5bBhJl+WsOAStLHSk+q8uK8jtVBZsb/csZXE1+XQ
 afngOhgQIp1cQeh1OuwIr6SH5HA90Gpg4eNP/NriqmjZbQH6abmp25DHznlXuHvB0UNOkihr83m
 tmjWAK/3CC2rvOUI3UAwUED2XMGuIIk19DpO9c8dglb6XjJktJePDXYN2zS7q5KoPUVQtO7BDI3
 zH9KMJh0wfkY/AdisXO9goyn4t7pU3w+0VubcdQVgSoUOp/z
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 30 Jul 2026 12:58:11 +0200, Dawid Wróbel wrote:
> ASoC: codecs: lpass-{tx,wsa}-macro: fix enum kcontrol accesses
> 
> Both drivers access enumerated controls through value.integer.value[0]
> instead of value.enumerated.item[0]. The same bug was fixed in rx-macro
> and va-macro in 2022 (bcfe5f76cc40, 0ea5eff7c606); tx-macro and
> wsa-macro were missed.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/2] ASoC: codecs: lpass-tx-macro: Fix enum kcontrol accesses
      https://git.kernel.org/broonie/misc/c/1ba381759e45
[2/2] ASoC: codecs: lpass-wsa-macro: Fix enum kcontrol accesses
      https://git.kernel.org/broonie/misc/c/56f24311fd56

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

