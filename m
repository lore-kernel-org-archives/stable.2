Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878603D25AF;
	Fri, 12 Jun 2026 22:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781302768; cv=none; b=SfDjsS7NQnDHGUVxZ2AcUcMuZ+Be4iygoG7PmTi/NOE5PuIcnEjLaMv6p2MgMgqtXehZjKO/r8Y3mZ3cJH9LwlNTioE7hCJ+938Rzo4Twty/yDvDkJTeJCNrwlthf/jbCPq2Y1n4r8vj16awPjbIUUdOpq/v1BCaU9x/Nhcdd/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781302768; c=relaxed/simple;
	bh=iQP4iURnNfWJ6bCiMsrHhJ71HtOAjqOIf30nyAweiEA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QIEAvkkxIm6xQcVAAAq1qKOA6EzKyPHNCWBexQR9haGvlgdfZx4HIM6UKDUC0I4uZLGFMUi1QO3h6pUcsjZSnPX59A5gTH7xiCD2P6vAjHPmhyAbEAv6HEKqje1pJKJN0/l0/QvpLErNwDNYxEF2rzTrUegiNOq4LCzcrkB4g8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GS8+lZuo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GS8+lZuo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F911F000E9;
	Fri, 12 Jun 2026 22:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781302767;
	bh=mshDkpJApe19tW4Vf94zpuJCEkyCk6cdVsQ4m+3f34Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=GS8+lZuoEQ/duDjWZw1ThWknkN4BfQuQq/jzwB+08pW5cdjouWrcrS7jO1yDwfWpK
	 GosgPL1uB3bwyrjLvffL4xji4KQXWFgQzkUF0BFy27uexT598jVuFc9p+3ONReXvTG
	 Fe78A67MCLcakfQ50YsUQuxc4BaUNzjoeKxpwkygN4BpvprRAD7Ot8ifOfNR84GeE+
	 6ptJFrA2Z3Jm1FvLMnx8V7pIQGHvh5ggCKLELvG/gGtlTyqQiP3nd2yHAAYlqH4yCv
	 8SPrrEi0qNVugzUaViaDEPyrV2GEizDjht+Iupspw3n7w7s5IiPkuhTK9Py5L28OOk
	 HxJFxBXa0o7qQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, peter.ujfalusi@linux.intel.com, 
 daniel.baluta@nxp.com, Zhao Dongdong <winter91@foxmail.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Zhao Dongdong <zhaodongdong@kylinos.cn>, stable@vger.kernel.org
In-Reply-To: <tencent_3EED6D778DC52C3703A2D1EE8119372E8E08@qq.com>
References: <tencent_3EED6D778DC52C3703A2D1EE8119372E8E08@qq.com>
Subject: Re: [PATCH v2] ASoC: SOF: topology: fix memory leak in
 snd_sof_load_topology
Message-Id: <178121049716.484538.168128196158731966.b4-ty@b4>
Date: Thu, 11 Jun 2026 21:41:37 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1141; i=broonie@kernel.org;
 h=from:subject:message-id; bh=iQP4iURnNfWJ6bCiMsrHhJ71HtOAjqOIf30nyAweiEA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqLIXrA61QO0C28+DgmqHp1WJ4hCyH7Q3JhRY7f
 tr7lMcPInWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaiyF6wAKCRAk1otyXVSH
 0BIBB/wKizGX62RLfetiM1C7cgc9dx6vlnu8OtoBUytm8w0BdYu1aKhhg/uR8kn8siLyUAo6+ZX
 XlNpu6NboI1wLHYl5OMBJlikj6oCatEjmLUt3gIXpOa4964m/I9V+OmMmw0ri3MlweflLyGjVd4
 iwFpNqhZ8TKZlNvKV2qhOoYmCpYQ8Iy4oB2BQOuYk0JB2K66/RH0/rdT9o3Uzp8rncEcY9C3aHT
 qIKnvn5gEU+mFUaTk2iwJZv+AIkrvrS5AkEt+hj2MVtW69pnd7iyrTJqFO11KHnan7hHfoDXRSO
 0uPrmkHrHHllt9J++rFdi0YSzNB/jfauqhyKqCfsXZpiqvQo
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 10 Jun 2026 15:20:43 +0800, Zhao Dongdong wrote:
> ASoC: SOF: topology: fix memory leak in snd_sof_load_topology

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/1] ASoC: SOF: topology: fix memory leak in snd_sof_load_topology
      https://git.kernel.org/broonie/sound/c/d46f9f238972

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

