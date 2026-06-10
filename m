Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371CA3A8727;
	Thu, 11 Jun 2026 09:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781169830; cv=none; b=TVDSiZCw3ewxLB0MoWfv0FjLyQL9yRAnBHp8lPVM0luiG0gNadMQMXqkfwbvpRxrQxJ+DwrVQ7UMXBjHCDab8ISPKTfDJe3mFwyNxYReoRaC23ntxjOUt97jvch+aQydJ2fjDDv9oLLg8OHQcvJZDQ9KnV6efsx/2xtmtrGMdnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781169830; c=relaxed/simple;
	bh=pAk/rz5nklkqgJsfteE1/x98ntym0NYpSou3iPJJxv0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qp1wR7KlTe5oy50LSOCX2sZcp9E1TMePuBj2BBGxEN+ZROg6iMQXDoyOm6DH/pLc0Ua/2MlzfAvzL8BzyRSoWDTZTK0l1bXhuZpbQUfjjY781vu+W+z/vcm+K1Gx0Vm3U98WWh5xxPGd9+ez5BNa9xatHTJ8nLeKAI94vPoTuis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/Ku2wQR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/Ku2wQR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726E61F00893;
	Thu, 11 Jun 2026 09:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781169828;
	bh=BDmJLkubdE2s64eOfBHL85xRlhFhARVgHJEEXr1vHRk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Z/Ku2wQRuWUiT7dL/qZc0NMNizstHmEaWrI+JtQMZY7pYizaYlS/bJWZoq2S4hsCa
	 B8LFvfD+3FBe7ZNsxmkKTNtj54kDT2wgDe1jpWG3bGi+9Yf2Egkz4HFVBjx74E+Tp8
	 31t2y6avEH/LXKQqxWYnXJjUFxcHC22ullLTryplAQbwf4Qu5Dx43Xm0IXFmLvkp3i
	 soUhqufZpR9NaPGlCC8vv6Z2FN/ZdI2OPXRRmhtlj7b8ezkdZOAhYUZv4VO/pYyt+w
	 MdtBfQg/6F14OQZYr3SuH5q/A6pASkOhkpYnJD/RrCxMsMtZQ/YBkiSZFMeloX/aLM
	 NV5PnLOC2IRLQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Cc: sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, notify@kernel.org, stable@vger.kernel.org
In-Reply-To: <20260603-sof-topology-array-size-signed-v1-1-84f97879a4ef@gmail.com>
References: <20260603-sof-topology-array-size-signed-v1-1-84f97879a4ef@gmail.com>
Subject: Re: [PATCH] ASoC: SOF: topology: validate vendor array size before
 parsing
Message-Id: <178108960580.232889.5715134893654319840.b4-ty@b4>
Date: Wed, 10 Jun 2026 12:06:45 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1145; i=broonie@kernel.org;
 h=from:subject:message-id; bh=pAk/rz5nklkqgJsfteE1/x98ntym0NYpSou3iPJJxv0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqKn6guXZdxStAH6FqoO1ALVgF+0Uk66t8yO1xa
 QFohaA5lVeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaip+oAAKCRAk1otyXVSH
 0OPAB/4t44eFnrkaFuZNTbAeUJgmYpSe6sJmoq6Yn71DidqfLugeMN0eZqt5sxd5BFgUbyYfGDD
 0fCSdayDytxPe3krtOlXhcIcXjY92HXI2uCd242EXUGTAE68CAGzWhdcAix695Q8+dF9jgf4ON8
 0Dzf35C98Wf33d6HHn/rqwcEt5z5cNSnMgGjA3E+F84/C9Zj4b6ZM6Hrq3hHu0Hcj5a5Ilb/VWz
 srQDPjHA8EQzKO3EE2f5DM49oIqIU6l1xdVp4rx9wgfnYb2m9Nj7HoKnUSeYon4WLWpNAEU7jCV
 HVmf5QpYR9lYjQ5fyIGcaOBOEJ3cUqZAZZnMf6jYachsrhT2
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 03 Jun 2026 14:57:54 -0300, Cássio Gabriel wrote:
> ASoC: SOF: topology: validate vendor array size before parsing

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/1] ASoC: SOF: topology: validate vendor array size before parsing
      https://git.kernel.org/broonie/sound/c/8468dd79cfb2

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

