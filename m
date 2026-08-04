Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFA843A7E7;
	Tue,  4 Aug 2026 21:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785878348; cv=none; b=ZtpG15IPEaN8nVtuliAVkYPvhQxurv1Rzy23MHEU9oneDnxawwOxdQWQ85ig/+O4MfkhbZJ3ZN5ETJ/Cwx6JKpHUwcZvT34+YHNGvacsbFaLs+m9WhBU+wcjZFZae9hB9Bdx7PfuKPRHBMVFRaR0dyRY/3nC9O6A9gO/dXqJ6nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785878348; c=relaxed/simple;
	bh=OgcGXWrO+K5QIB1eNMp48jcNvGG7WDhPq3aQyzqGBzs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VadoKkiTK8x99sMBaoCf0Dg6JQp3OWuzrgegZzqWxAPECyHN+ZYTuVh2x2aYsJTkRhSZHjDtXDnSy5xICdhboQiZSC5g+GSNiiMJZ81ucApXl+mvBTAE3ZDh2io+tgQSsETv23rPfc1+UL4ojiOWaakr5k5SGZHokNlvAHxMVqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyAEMkHY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyAEMkHY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060FE1F000E9;
	Tue,  4 Aug 2026 21:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785878347;
	bh=+lrxdQ8iUYKtBjJhImhkRJG3H3/g7sbgzX1kZlyOn0I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=UyAEMkHYUQ32kj1HWnTk7R7nMY6bc66CCvw2Ad/S5vrU9K0K4SMUyrNUkGXRNE9Gs
	 he4nGIpaVJS0FwCs6V/2ZkBF/jC+a6o6IhDsFEkSbo1H/gGuwmdw+O3NDJEJgGjHlr
	 LK4Gt69riOMBbAjzaYWff9CacrowwFRi86LhL0T+41F5CYsBepi7J3pZ0aMmAl4JvF
	 0ERbWXl5G/VrBrqEVRivRuxVFaJKDCvB1hU0qFui79AhEGPLpwnVGCAtqfXwn35Q+h
	 TL2v+kRWy6jPtn2p/YufG5c13xlQKoLzouTHujFdxxotwBFit7YHJZaiWpEoi5xtQO
	 qioWnaO/+Zwvg==
From: Mark Brown <broonie@kernel.org>
To: jonas.gorski@gmail.com, william.zhang@broadcom.com, 
 kursad.oney@broadcom.com, Can Peng <pengcan@kylinos.cn>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260804072017.860974-1-pengcan@kylinos.cn>
References: <20260804072017.860974-1-pengcan@kylinos.cn>
Subject: Re: [PATCH] spi: bcm63xx-hsspi: disable clocks on resume failure
Message-Id: <178586729796.111355.1152517870926382176.b4-ty@b4>
Date: Tue, 04 Aug 2026 19:14:57 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1114; i=broonie@kernel.org;
 h=from:subject:message-id; bh=OgcGXWrO+K5QIB1eNMp48jcNvGG7WDhPq3aQyzqGBzs=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhqyicA8HfdaY5PiDL+fd7yiX0Hx73nSr6usJJpqx65ftm
 CLDU2rRyWjMwsDIxSArpsiy9lnGqvRwia3zH81/BTOIlQlkCgMXpwBMZFoY+19J5cPG7Kmb7JdV
 F/LVPNVi2KC3XCySYap1t2As/87r6xi36En8MVpk+/7TXWnX1kf+HtxhG8VmcAo+asthqfXfy3F
 3UrPReabzMeq2U1lCnzc9L7tuEFLxMPeFcm0sa/et9y0m3bblcar7lv+7k9XAdkQs+ntWdvUz2S
 nH8gzZ8ldxiDFvill/47+y//mQCSKcm9PSuWMyhK5edYxiU/NKzl63tm+S5W/pexw8Snc0Wfk9p
 nIprtNi7G39sfQGpyXPffUU7evvU9d9eG+w+9Cv1jbPNXKpnU87ua1Mt30LvOq6Q+V33ySpAs+b
 sfuXsIqrM94Xt3niu0EnTSXsBkfdxLY8pagDV335JkoCAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 04 Aug 2026 15:20:17 +0800, Can Peng wrote:
> spi: bcm63xx-hsspi: disable clocks on resume failure

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/1] spi: bcm63xx-hsspi: disable clocks on resume failure
      https://git.kernel.org/broonie/spi/c/3b0cee026640

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

