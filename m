Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794146548;
	b=buLiDHD12zLjOwSbslwgCTx/i2hHYuAolbn3pO2Kp8fdVTAWd6wqiwF73yc2DtD1rA6C
	 LLWy3LqMD5nzdF8HfZqzKmTgxVpGxDrSgpY8tTKZEEMtyl2aebKiSDlcZNGJseVKQeid7
	 7IEkbQiUQ0qMmQU92J0LA9OkgjukF6cteAvR4NaEUTrcX+rOV5XpfsHLm8IR4xbuLAf8v
	 r+kAqAaE8Oe0+z4AqXI1FqoczUgvZw+nNhhzb73WbomngmmCQNjbDfa3CJPEFV98LVi7O
	 126EEo8iTR0ajNz/9YUkQUyfc/UY2wIJ0Nvfg95wMZxWwCKFxzV+/ZL7mW7yZycMorg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794146548;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=f2tJQIyFeT6b4NlFhJH5gULAQ8arU7VxffDMLwdcOIQ=;
	b=NNjA5sXe7OfyxFlQR/vTqIKzDbaMisigYCohKoIbeZ+mojNMIpzDtyLy20gtW/nTHgLr
	 ivxrKX5yNTp/NZuBSLY8VwhmnY2nJlQhgZtKseTyrc4pHQs5zE6IoD3iCQyL3CI36dedM
	 1pauDBLK6C/4O46263GnxuPXN4QZa1TkBgshgcRtjkPTFpKq6X2SGGtSznh7VEqXsQro3
	 iiuJUhOFyy8htD+gWEZj5oQN3+9TpH06I8VsnuqmEHyZmftuBscVpc+EZun+K+j+olV/d
	 Yc0c+rd8B8X8+oyB2dwUFDnTJ788iDTo3Yv1TioYoEh70PXYNelMdKWX/7HXezeTAtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XxDDGYvs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA33606A321;
	Sun,  8 Nov 2026 14:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XxDDGYvs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9401F0089F;
	Sun,  8 Nov 2026 14:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794146548;
	bh=f2tJQIyFeT6b4NlFhJH5gULAQ8arU7VxffDMLwdcOIQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=XxDDGYvsh41YUrhCWYrvUcjhEC6rK6ldz/HliXve8l9cXo5Vy516Jn+poLMjPo2XK
	 vZA3X4B3oyuX0+1cFtn54PjLwYr5d4G5cbjW4LkOGvNGuYNQVd+DfoDm/y9fOjdaIy
	 4ZY/5mKF1uvHGZniOYm36TKQPpSMnCwVUyQ3BeWIDMCx0pCsN5GmlDqiCE1h8JDBHf
	 9Ze0be9UQ+ZI1ZQIaOtl2kT/j1M0/40tPC1/619K9Fg9kY/3MoF7c+Ui0mRf10OV+G
	 eC0F6MbwdIOEHO1bJLmAuhK/rblHqoHTo/nF4GoF2hVh1F3PpcKdHjtqGeuTEQC77i
	 LxqidiLfIlo1Q==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 4CCCA2C7970B;
	Sun, 08 Nov 2026 14:02:25 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Chengyu Liu <lui2012qwq@gmail.com>
Cc: lgirdwood@gmail.com, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261104134838.326041-1-lui2012qwq@gmail.com>
References: <20261104134838.326041-1-lui2012qwq@gmail.com>
Subject: Re: [PATCH v2] regulator: disable disable_work for good in
 regulator_unregister()
Message-Id: <179414090868.3630016.14355012356063230829.b4-ty@b4>
Date: Sun, 08 Nov 2026 12:28:28 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1157; i=broonie@kernel.org;
 h=from:subject:message-id; bh=d7+mI9/geJK/cE59QnZq+hadsRrW3ExzUi6GcMNDbdg=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLI+NHz0zvDy8IhQS4jun6t6VYzXv3K3zL4vK8/yWCT3H
 HG94bmyo5SFQYyLQVZMkSUui/tlfcnrNXwHF7bBzGFlAhnCwMUpABOxjGJkmNDrfnrWXb6k2fca
 e5LsJ+wz+LLYWLlyrrrErYuhB3o64hgZ+kLafrkpt/EoRSjPnbzp74WOZumJEw/m94bN5168YbI
 mGwA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 04 Nov 2026 21:48:38 +0800, Chengyu Liu wrote:
> regulator: disable disable_work for good in regulator_unregister()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-7.5

Thanks!

[1/1] regulator: disable disable_work for good in regulator_unregister()
      https://git.kernel.org/broonie/regulator/c/1d8212cdfbbe

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

