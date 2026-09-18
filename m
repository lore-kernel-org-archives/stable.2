Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D725450B8D0
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 15:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789746852; cv=none; b=Nk3D6agIzLNTjfH6bRvQEY5K69rEcAfVbfZ+xH3wlu/sGgApZnOO9lu4TR4ATKJv4mN38SBtf8CSiiRp8huqjgbu/ckjXWanAqhb6ToeUK+PTDuBhvdbr59TGIrh2x1jGO9KWSDm18JbVvgYwd51yC8KKIXJFshtFbLzPcZ6NUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789746852; c=relaxed/simple;
	bh=eAPoLsqbg3ZmbU6b8AMuRF9A7sVgsmf0NZ0utk5ZBRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJaypJyJpxExrPC1QPgpDRITR1HpYehVR/QeDm2oopAFVFMqrblQjUkjpOwSbIN1BIqQa1PaAAlhkXC4VODIHUvmmipED8OgMtD/BeLkfQWRymoPhUCbK84wyU5fOVJVN5wwQZreM4YgIR+C5XTnGXY+OXsP9404ZYVylOvr0VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+z9ycTj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+z9ycTj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0EC51F000FF;
	Fri, 18 Sep 2026 15:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789746851;
	bh=+fWXAuD2Qxb1U/6xZJzYeyb4W66Q2rkHZGu4k0/X7QI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L+z9ycTjduEqCEqg/BtmiqWz6+qmuUoPfPeuE+fRVZR/X/7NOVZpSSH9efZrXK8/+
	 ooZGn2Daf+/yuxoaRpqn7+VMictBUs/BJjdhyikzXAKol3grK2F3RRHwHux9M9DfEv
	 y9Vur9cawvS1izHi2BcBWSXZH/JcHR+hwiqsHyqteq8M5uZmk0qo3eLavbXRKqmorV
	 DBXLJmE+DqDMRMOp+4G0peme7tRWG0bAUUoUJz2o2zZFlPI5qVWNv7iCpZ/VwZFZyy
	 vufJdXvsh/cvoYKk8YrZteM6ZPdhTiUw7Xms5XdmzxvzPfTxWADZ6QHs1YQlHRDCfL
	 KO5najBaP703g==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	broonie@kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	patches@opensource.cirrus.com,
	Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: FAILED: patch "[PATCH] ASoC: cs35l56: Fix race between kexec and" failed to apply to 7.2-stable tree
Date: Fri, 18 Sep 2026 11:54:02 -0400
Message-ID: <20260918145650.1789743410-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <688ecaba-8692-4476-b055-cf6021814d24@opensource.cirrus.com>
References: <2026091611-legged-other-642b@gregkh> <688ecaba-8692-4476-b055-cf6021814d24@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Sep 17, 2026 at 03:39:43PM +0100, Richard Fitzgerald wrote:
> Question:
> Have the two prior bugfix commits applied to 7.2-stable?

Two of the three are already queued for 7.2:

  883e78c9e6007 ("ASoC: cs35l56: Fix race between kexec and
                  snd_soc_register_component()")
  1d80a4792f1de ("ASoC: cs35l56: Fix probe deadlock waiting for
                  SoundWire enumeration")


> This failed one is the last of three bugfix commits:
[...]
> fbf2c660bac86 ASoC: cs35l56: Fix pm_runtime imbalance if suspending 
> before first attach

This one is the gap: it isn't in 7.2-stable, and it isn't queued for any stable
tree. Its context doesn't exist on 7.2 either - cs35l56_sdw_system_suspend()
there still calls cs35l56_disable_sdw_interrupts() rather than
cs35l56_mask_soundwire_interrupts() - so it needs the same kind of
adjustment the other two got.

If you can send a 7.2-adjusted backport of fbf2c660bac86 to
stable@vger.kernel.org with the original commit id, I'll queue it up.

> From my naive testing all three fail to apply to stable/linux-7.2.y

Right, all three need adaptation; two of them have already been adapted and
queued, which is why you only saw one notice.

-- 
Thanks,
Sasha
