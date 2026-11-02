Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793705062;
	b=3B39zzjo6V9zX4FTje4VWjVRAOpO+2lMo43gJ55WpqoJHVFh9lh6dsx17fH8NPS5HRSK
	 9X5whEhBQHMSdXoGIUncjxEbezfM90SQBkUy3OsWomlDAeDkytOFxurDLT8gqaOxKq140
	 pUpFALuWiFoMztcJZIQ397GSq9xNl6WfytU5bT5pAsxSk0lhfbQED/3wiPdNsr1zTfB4Y
	 PP9NdOhulx0tzMcA2tSAU5w5CrBH3lvhfUYvvFwhorJ1yql3vlBEqqjLHEzNAtE695N1R
	 1RFHLznwNKRHjTXitTWDfARuxBW0drONm8uui8cCpj6dgD5vfvozzl+srUtD261siVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793705062;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=s2Yr4E3+8/7AWrLikM/3rlcpm/DQNp732uDlsmvsK+4=;
	b=y32+pMiDg1x4ANZcuX6DZmEgQfQQ4OZ7Lnz4c5NDVETIQzW965PUiHLs1dF05rYvKS4y
	 8sKQV63J3CdUbtDMlm2U7PGsDiQ/08MoYl4EFgTOZz30vEV1gS7FqjFIoATnRu4PnRLw1
	 bQ6hYWyaHVN2a/7KtH5FRKLQ6NSanfi7WPiLCn0VvXd5+UGwQ6tJb0YmNqGOFbRlzry0K
	 nz9dnz0njklCg+e0jxokPbuGK6yGNv/VjD4rd/u6g5m7lvpIxjjgfIAXcNuJOGkaokpJ6
	 LtQAalTICBfzlD+FyFZps01wnUczOo7YNLSuzAlIv1SfJF3Kae4uOSehgdBD+yqdNQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="n3/Heh3q";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68953606C580;
	Tue,  3 Nov 2026 11:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n3/Heh3q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A841F000C1;
	Tue,  3 Nov 2026 11:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793705062;
	bh=s2Yr4E3+8/7AWrLikM/3rlcpm/DQNp732uDlsmvsK+4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=n3/Heh3qkOcXO4+5lLQfRXt4Sk7G6zgM7Ns+yv9hDNJMinmI3qLPRMb6x/reMwQGQ
	 E/sYZE9tn9OJPxfLedNGRa5VFoFCZzJMfTwf2gxMO7Mv0M9ihBOJs1s20VjEtDpSRh
	 4LLJ3DT/uORXTF2+XkG/AYQE+M382okY/o5IVGOYXa+XuMdVikXke91VfJ2T+Bgb+X
	 U0gI0zDnyvK5El45R81ahieeEY1AIvJxWdSH6FUWu7gfS1BGwSCnbW8pAmZNin3itX
	 CVownV63CHWiPyj4ciZtEdrQbX3d2tEJD1PGEzNi2a6VFnWRyO+yV4OuCkGUF/JEW/
	 yOPNN9pvnpeGA==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id D780E253A06F;
	Tue, 03 Nov 2026 11:24:19 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, 
 Jiale Yao <yaojiale02@163.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20261027062605.2233921-1-yaojiale02@163.com>
References: <20261027062605.2233921-1-yaojiale02@163.com>
Subject: Re: [PATCH v2] regulator: core: flush deferred disables before
 suspend
Message-Id: <179365006442.2167617.10994277201122315242.b4-ty@b4>
Date: Mon, 02 Nov 2026 20:07:44 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1133; i=broonie@kernel.org;
 h=from:subject:message-id; bh=U1JFDzrLUD7ngRAiAG6LQffmIc46gygaJBFV4OjF6Bs=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJeHkne7LHVtVmcfbv1xz1cDlE9Sfr6B5KCe8RVY3LTo
 7dOvzylo5SFQYyLQVZMkSUui/tlfcnrNXwHF7bBzGFlAhnCwMUpABNZ3snwv8D4+L/lCQ/ld+9l
 3Ke4rUs4r++/yZJpc+0LhK5ybStLlWL4w+Py7rrjG7u9AYsDK/bbhO7bsHnu3+tbv2h8Vpgwn1f
 pGxsA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 27 Oct 2026 14:26:05 +0800, Jiale Yao wrote:
> regulator: core: flush deferred disables before suspend

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-7.5

Thanks!

[1/1] regulator: core: flush deferred disables before suspend
      https://git.kernel.org/broonie/regulator/c/cf828ffc92a2

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

