Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501844D5984;
	Fri, 25 Sep 2026 18:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790360810; cv=none; b=IDEWBA3KKvsoHKcRerzHopk6XYLTSoUkwM+1nQMV4BR9bXgJZmz8/D9ShORtQOLOVGnWWsrzfHNWmtvEQ4ZkshSAHCpOde86qYG/dJHVBKSazSJaETnawYvUl0iNE3KtYVtguuUB7MZF/y9tNuaSQHosfWxiYPV+PkMUHDQbgO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790360810; c=relaxed/simple;
	bh=bHUYqtVWEAsJGNb8E8k3hE8XLkYTUQurYodFUi2bblQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ozc32hqA8vkvpC9S5XbH+AXbOoI78lLJ/WWZtBDvFoAy0dMBC1dEZ6IyIKvdshkVufWcYlViRuC+/mIHFYTG+VCPoJtwZZxvFks4GZrOwYIdp2NvmTQV4bDykkY7JDntsgpEyyfCdiEZ4dG17NQ+BgtfQOW8xqRh9+zlP6X9bL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmZIp0iS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmZIp0iS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64801F000FF;
	Fri, 25 Sep 2026 18:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790360808;
	bh=OWH8aBpbLBU/bj6i0nhE7KbyG25vTlj803jezpamD8M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=cmZIp0iS2QAdGweWsJ1eY/fb5QP/9IUt92CFA4eww+K4vI+V60+scjuR/qOSkoIoC
	 uOx8aH9o4Oc0lBv/Q7oVPiZBdxx2sQqXoddgpDcDsom1SVNE2KKC8qoK4F+MLwCQBa
	 I1MZAZaCH2WGIXW92UV/v+cEuDS53dEw5HI9poN0wJ+CvZ7a2Y48qyZZ0f1gd7uayv
	 qB75aqzhq4Ea//rUO6EwjvrpT8f2EZ7zitBPxIf89dvPxWKuz0DPVkRrLUf37ICdHp
	 dh8OhyOv95AGpE5xU86V7eYo3FwRLPNPi5aUgRm0ckqt7BLJTeV/5OSB0eTPdyFPR8
	 TVWSci4nnaNjw==
From: Mark Brown <broonie@kernel.org>
To: David Cemin <dcemin@nvidia.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Jack Yu <jack.yu@realtek.com>, linux-sound@vger.kernel.org, 
 linux-tegra@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260912182131.1156475-1-dcemin@nvidia.com>
References: <20260912182131.1156475-1-dcemin@nvidia.com>
Subject: Re: [PATCH] ASoC: sdw_utils: clear stale RT711 device reference on
 exit
Message-Id: <179035513174.204944.7908716001360886025.b4-ty@b4>
Date: Fri, 25 Sep 2026 17:52:11 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1135; i=broonie@kernel.org;
 h=from:subject:message-id; bh=bHUYqtVWEAsJGNb8E8k3hE8XLkYTUQurYodFUi2bblQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqtrzkZVeY81q47sj2JWjXO07V9e1sn66sHd0HS
 s9EltYUYymJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCara85AAKCRAk1otyXVSH
 0I7ZB/937gR96C275sPpEApV+U+JLPlNSOAUrqDLVAa0XgneZwHqZZtE4vw++0x6oI0iXXMQxh+
 ybCAy46RvG/hM5Grmb1885t/bVFJvpjHIDUC+e/3vWOKCRl/OFc5Mk4sydAlyPwavLNCbYAtSTI
 fV0OhTZa0gqsQl/gYt5e3HfzV4DQqROawSEqr5Niemyr1ebZexxtidvjvDyz/6X1y/wbXWi2ZfA
 ixGRO7JMn1fazRHz7dxJife0neU2sTK0MX8oL7MKPF5jZ1PE1KKOJKxq+F5iIBgoGGu38JFpmZT
 jm1Gg5WDQ/SWs6bOd6oJ+c8Kn37hlFuF6M8dlYRerhVqDEc2
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sat, 12 Sep 2026 11:21:31 -0700, David Cemin wrote:
> ASoC: sdw_utils: clear stale RT711 device reference on exit

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: sdw_utils: clear stale RT711 device reference on exit
      https://git.kernel.org/broonie/sound/c/7c7df141dcab

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

