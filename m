Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65864D956F;
	Thu, 17 Sep 2026 11:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789644770; cv=none; b=dYDz5JZJ6O2bkkYhsNOMRcisfVdaFqjoY1SdirX8jMX1Zj8fweEAs4SH/HiI7PwYiOkvo3n3r+h9o63Ggr/Yen+fjFAgb0pH7BMPlChtKmqRXg1zO/NUfp17vM/VgxeQA7HS0eutHC8VJCEXq9URKyVUOM0Yoolql34iaVZ40ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789644770; c=relaxed/simple;
	bh=cffo7sWwuU0dvkuf0+DX4vlZ2l/dAet1H1uUGBSuDwQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BOOya5KPzU87bTAo+YLnOM3kQMxsP7eqvH8aE4gJoeQrMRP3GruOw4Jw1AfhIaZdkCJ3AMY57nczU1koY/PJ1lMv7Vxs1jiXsTGkbDSOWYlDohhMFnDZpTVPVZTtHj0gMLnyGFxs5dbi0gvFHf7/eI+sYXy3P1R4/Js3up9LWDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQDusTXU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQDusTXU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605501F000FF;
	Thu, 17 Sep 2026 11:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789644768;
	bh=Ett9tkOq1/eceJ6vB9SlEQ9IvkP+PrspyfJVusZnlEs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=XQDusTXUhliPk8mcSYZP/e0/8m71sjbTJa7f0HIotHD8/8C0q9Iv4YbnIMnMDXJUV
	 hwborSzKwW4FGMczRs/VHCXfOqCT+4CFiFxnU55viphwCuHr6kV/QyX5cv7FkhCmpf
	 RVTPfWFRhPhq0lWdlmKfH6gO4TpQntbs+yIuahUrbz5rTceeuVCFEq5aX+hkkTkWPd
	 oOSZs37nq9/tTFrasc/Onti3WF207H2rAvTlMXP6CYNObFdUNnt6bnbQmEn3q3F16z
	 X8QsonoZXZ8sE+7JH70UKCNvz9Y0m3XI6NGJVeXXu5XvfWOL6iADkLRU1bMoiWKKpi
	 428/O5XNsVrAQ==
From: Mark Brown <broonie@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: ckeepax@opensource.cirrus.com, krzk@kernel.org, lgirdwood@gmail.com, 
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
 patches@opensource.cirrus.com, perex@perex.cz, s.nawrocki@samsung.com, 
 tiwai@suse.com, stable@vger.kernel.org
In-Reply-To: <20260916072737.1970990-1-vulab@iscas.ac.cn>
References: <20260916072737.1970990-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: wm8994: Fix runtime PM imbalance in
 wm8994_component_probe()
Message-Id: <178959286552.100121.820380594864090352.b4-ty@b4>
Date: Wed, 16 Sep 2026 22:07:45 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1150; i=broonie@kernel.org;
 h=from:subject:message-id; bh=cffo7sWwuU0dvkuf0+DX4vlZ2l/dAet1H1uUGBSuDwQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqq8/c0Z52rXbUI3zAeO4TbSuv1C4knccGYF40M
 S7tNVXqn/WJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaqvP3AAKCRAk1otyXVSH
 0DplB/9uL8Ylea/CoCvM/MoMF4BE/HkLVTvQUL+d9boQ8ViE1RAvyWacywfEJcD95YlntplALln
 o8jIIbz96kh6GMj0GS32D5SAxfpsYqxV/EZzHfLeJUfDgh1tsZDWbIq9L50q1UQ+qUPCBLFXbhi
 7as4RVif5h0in8JzwNrB5dVXfaJF/RtoyHotGZYJOiVLsnv0rfAY5EezbVYGHVENuE9vq7Zj+xa
 bojm7CDHVFjDNLidsNSo7ulo2eCYoQ48ywsIPlbbCDhlr080fdn04JSkfGRYrk55LuYN8p8XGb7
 emOOI/dnRwA954wh9eGMlLrO+x9ndDSVwT1W0uxc0c+Iuv+J
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 16 Sep 2026 07:27:37 +0000, Wentao Liang wrote:
> ASoC: wm8994: Fix runtime PM imbalance in wm8994_component_probe()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: wm8994: Fix runtime PM imbalance in wm8994_component_probe()
      https://git.kernel.org/broonie/sound/c/480a5528cb62

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

