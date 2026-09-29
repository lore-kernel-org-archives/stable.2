Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28A03EC810;
	Tue, 29 Sep 2026 18:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790705559; cv=none; b=HFWJrAXPT2f8QtBNVQt5JVdf1ltjATRCJKSOMz09L7i2kek9ujZYd4/JZHkmhygGcYsrIvZVA451XjV62z9HYD8VumQH0I/q/Fjupp564nKwpLB2TAJDq/SzPtyIeVZY5qlSn7/jn2xNjRle7qJlTNJpLiJ6EgbiPaLSqpO9+WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790705559; c=relaxed/simple;
	bh=1Jp9lC5lmUNbGotDTh5hwpiXsgEODQxozKoH2QRfGVU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=I0j6FeOMfQS87dSNLzTj2Z0WE1z+T8YSvfasXdBQ5poNkWWdePMYa9zSt9fKh3WUnoX9PjOtejJFxkWdcoQ5MtVZvW1j3GwTTcmtHaES023Nx4DK5v5n5fHpinarn8PygOze6rVMxRLtwUnOYmsM/NSnYAb0lfGQ9MJFBVpknIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqxPvboA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqxPvboA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFED11F000FF;
	Tue, 29 Sep 2026 18:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790705558;
	bh=AewnJYCmjMlqrdKta+ROW0UgJ4iRfCpECmE8t1Zigxw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=SqxPvboAcCVhQ5nmddBI/ScbjXz8Y3l5dIY/Buntx3u1v2YFiAp1sS2Pg1YIkPKsc
	 zMEQiAqYE4H0pLu3DMVOseXq7BMOs5qn9Jp7rK2WnOwhmcfWHp6fbcsZ7krumfz3Fl
	 B0nAKPKw8qge3Vi4Psr6cj5wc4cCT3s9Y8pYFhe4DzY+E7gTtpLW9wjxlRXdl3s+od
	 R41GFhUVaTXVlhbtHm/2wBxoqhV9i0d9xO+1XwGWZRFuBrIWKyIjwzgMmhjnB0QuYl
	 tvAQDRvbr2YBWOwzlY2K1uHI/o0/ZZz3g8kQU+kq1vZhHxCXmrd38khxVDeGXDiRMB
	 lhXhVR77il9Vg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shenghao Ding <shenghao-ding@ti.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>, 
 stable@vger.kernel.org
In-Reply-To: <20260929095920.2092147-1-runyu.xiao@seu.edu.cn>
References: <20260929095920.2092147-1-runyu.xiao@seu.edu.cn>
Subject: Re: [PATCH] ASoC: pcm6240: do not free an unrequested IRQ
Message-Id: <179070079857.463415.5484242725188416666.b4-ty@b4>
Date: Tue, 29 Sep 2026 17:53:18 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1106; i=broonie@kernel.org;
 h=from:subject:message-id; bh=1Jp9lC5lmUNbGotDTh5hwpiXsgEODQxozKoH2QRfGVU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqu/+S98vb3UAp4z9/AFUNR8nR5XM+NxRBOmzyv
 mOGzNIuyx6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCarv/kgAKCRAk1otyXVSH
 0D16B/0eet6QymIpIrsWE8UvaF5S7m6RBevMkEGXOGCRptqw5xZYU/3SH8sp6f/+zudPfEV4MWb
 cwwyEbvlnHTSVsM68m7rCbb0CtINnkfw14OcEUSxN0OryIM0KckFSParUn622HCDx1T4TYOrsu2
 qw6WibDEX9Xsrw11LHHph4Thndn3JiiArrWkd0Kjgz4zRq5V1sIg5Xy3BNUAKZOFl+q0o/zNjZX
 vTVhEoM029N1xd4jZkea73cp1zBVCYPE1Gmodbr17K0FFpR7kecj/AIQDtVYx+NB21+tyZEXXKG
 AvJkSnhktJqZtia0a8CcJdIex8r0jiO1tUGBeumfCvb/TqoR
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 29 Sep 2026 17:59:20 +0800, Runyu Xiao wrote:
> ASoC: pcm6240: do not free an unrequested IRQ

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: pcm6240: do not free an unrequested IRQ
      https://git.kernel.org/broonie/sound/c/995b96380ba5

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

