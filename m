Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5A540801E;
	Thu, 15 Oct 2026 14:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075991; cv=none; b=smhaK1r7Cpgh6xoCLGc3ticF36N8YQR1bgwr9QjwOuY0dlo3qtIxTNB9bc0xroXt81KGQ9BSf+PPeSnsWwFI9pme821o5aGHPqeuzaQ4UoVc1iS+9aJWh0kTDWo0LsGWXXnJZywxkkWBpc1fN5+dNXqGwrVkgaTjxnzpsZ0e29g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075991; c=relaxed/simple;
	bh=IqQ9+kgXaUtGdf8nln1xZMLytbAnajS3J99M2j/WtgA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CW++BNGBqoCnewj5UlH4RJaUz39/LqazZKvWsvfMjKi7Doug0v+38SJXwUM2NfFA4gjba8D4geLPX6uXC0QJMHn+y5eOU6cnHthe/Ihm9AyeI+xMZkiNSOBG3Igz7lLLxsP1y8fe1kJvGjpF+NDzefn6ZpLI0l239t0NI49vdAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1LqZiGG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1LqZiGG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9BB01F000C4;
	Thu, 15 Oct 2026 14:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792075990;
	bh=ATDchpZ6CABJXoAoNwHtXO+Ejk1lTxaXtd8ebczUrT4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=M1LqZiGG8uMbvGVhkRbwm6P2cNwdGI+ayIp/4XESZAcV/x/FLEeWnwiofVbf7drDZ
	 k9ITIecFA3mJQWVxcZf6YlhXU4IlHcn++4Hq7Keo5qh90zvuBS8Q93/oAqHsxGgulE
	 4eXjfCLHK7lw7KITXO4Wrpspo8vw2U5+pYy/IfFVmxi086mB9fM0P0fCB1xWIZDm1k
	 DTcVSln/JNJk79R6JYWkyVfNKgrBiSNWjiqgveQu+hYtUPVG7oWJGGLwcMqlSU1rJ9
	 y5o2vRj2XvPduhtPAvKlETjAML7ZL9r0iyp8tARx45P9MbfwjC7DrwP1FJNIQ07duo
	 nD0u9Ia61cyXg==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Weibin Liu <liuwb@xiaopeng.com>
Cc: linux-kernel@vger.kernel.org, dalias@libc.org, 
 Guanglei Zhu <zhugl3@xiaopeng.com>, stable@vger.kernel.org
In-Reply-To: <20261014-spi-jcore-divzero-v1-1-a8205d30f2d1@xiaopeng.com>
References: <20261014-spi-jcore-divzero-v1-1-a8205d30f2d1@xiaopeng.com>
Subject: Re: [PATCH] spi: jcore: fix divide-by-zero when speed_hz is zero
Message-Id: <179206361067.134795.2646575690539439799.b4-ty@b4>
Date: Thu, 15 Oct 2026 12:26:50 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1116; i=broonie@kernel.org;
 h=from:subject:message-id; bh=IqQ9+kgXaUtGdf8nln1xZMLytbAnajS3J99M2j/WtgA=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLIuvLjMkLfPbVmLIleWnGGO6at1v16ybBDMjz0rere1m
 ydp79a9HaUsDGJcDLJiiixxWdwv60ter+E7uLANZg4rE9gQLk4BmMii1Qz/o3+6nIha17owbsO9
 TrHcDU1ss0/2zi+1F0i571XVlOIVxsjQLpv0reKiVcbSQJOddXY+Kyyf+5su7FkQ9nqbblLn+gQ
 OAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 14 Oct 2026 22:18:50 +0800, Weibin Liu wrote:
> spi: jcore: fix divide-by-zero when speed_hz is zero

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: jcore: fix divide-by-zero when speed_hz is zero
      https://git.kernel.org/broonie/spi/c/7db773075501

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

