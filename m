Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF05A429CF1;
	Tue, 14 Jul 2026 21:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784064262; cv=none; b=A39y507o5Xp2La5FeeRrtEaNuGVAgzCUeNEEb+f+b2BtoWayEHvV+3Ch8ZPaS8LU930KAYN0348vdQenF3axWAcjClOQt9LyxCGYWIag0vo2pL+FUjQSJXKeDLF2dSRimCNDcQB9R1ceVd/3z+fbneiLxzbWWbHo5z/FdDI+mFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784064262; c=relaxed/simple;
	bh=IRprx/zzLM/no5bP7A6ObVlOXgMiMLel+tX+I4fc2zQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Nm7nRn/lOCwdP3PhQNDoojYTj5jOU/AeLLYGiOsxv5E9zqheVIEdgwn5JEJsT6LJ03eGIHTrgbNWvf+elJtIh+otfVBidb2Dm1CbY5vCLu+Ew/8//71ZYxepwUlGMh8uj5h6dzZkc1uTZpgrZEHRDrGvCMotK+YcyVJRBJVuUok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e600/Odh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e600/Odh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14E01F000E9;
	Tue, 14 Jul 2026 21:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784064261;
	bh=Mdxkfcw31jNebgrllO6zd2ynWr48DmtMYl0qIDCd0Hk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=e600/Odhq63GMHvFjmw0+5G4BhJlWd6PeGkcSEoRf9ArHi5HvBqZeizypQH2hHuIF
	 NeaBsAaOjDageEnHfGnyy2/oeZaeYlzASZVir9tn4kbnXq3Z3unka0BwuyvUISFf+h
	 86tioRwUYrmzo/EDWQLigdsT0CFwZXXCx0B4Yoe7I22p8LBLc+MDb/WHZKjyHfE/9v
	 1vFXfwEUjs85y1qDiIpjwE/HNYqCCw+qF+yvzYl0FuJ9q932RhdjzX7GWAfEK0nC+a
	 iB5yDP5JaYGFMwh57xEP+uHYQp9fcAqi5P0+PJU3mSa5byjoZ0G9BdzOMkdbzN/dzL
	 nVW8uvAxrZaqA==
From: Mark Brown <broonie@kernel.org>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Weidong Wang <wangweidong.a@awinic.com>, 
 Val Packett <val@packett.cool>, Luca Weiss <luca.weiss@fairphone.com>, 
 stable@vger.kernel.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260704192857.88366-1-jorijnvdgraaf@catcrafts.net>
References: <20260704192857.88366-1-jorijnvdgraaf@catcrafts.net>
Subject: Re: [PATCH] ASoC: codecs: aw88261: only check PLL and clock state
 at power-up
Message-Id: <178402818271.7661.46768093185969066.b4-ty@b4>
Date: Tue, 14 Jul 2026 12:23:02 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1156; i=broonie@kernel.org;
 h=from:subject:message-id; bh=IRprx/zzLM/no5bP7A6ObVlOXgMiMLel+tX+I4fc2zQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqVqkCOsIOa5N8rD9k9NiVyBNvXbsYJRdRYJqzv
 z1SfSWy76mJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCalapAgAKCRAk1otyXVSH
 0IH7B/96DvSreSns/50bFZovlLSJe0kBuQCnw+AJcP7sb2+CTY/HpB2fWSWhmNO0j9zQmdWunK7
 Cav+wGGxm4zpTrd9GJlJghRp+RBCD5HYsXqvdKhB5SbwEXvwwf6LYEmmVQk3bL9eUdiTOC+FUYl
 Rh5R7BCny2muiROJnr4aRYWLFBdJFotaALi3h/5WXjaF3NBdVyDVhOZWDv1ODX9/QNkjzqayeZ7
 WdkZnUlOSsMYsDZoN0Jof2D7KwVnrfEvThklagHDC7Y5hqWFA5dPf63Lre15K0kXYswDdvY62jS
 CrzP3br17VnMYzYeELSdAuIM7em9bXSfDlK2dV/F9MHUHJIB
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sat, 04 Jul 2026 21:28:57 +0200, Jorijn van der Graaf wrote:
> ASoC: codecs: aw88261: only check PLL and clock state at power-up

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/1] ASoC: codecs: aw88261: only check PLL and clock state at power-up
      https://git.kernel.org/broonie/sound/c/06b6f1245567

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

