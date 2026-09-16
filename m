Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCF74DD3A6;
	Thu, 17 Sep 2026 11:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789644759; cv=none; b=QjPXEC2qbYKQMjFxBF1oWZwgSn/T6ZMgVGoNGHeP+QABMfc+oo+xHwDMKzfb2Tcb/I58xnrlWtOF7Si95B+TothUSxORvgoWN5D0N9O8l7ZZr8XgjUKjsOqANVCQbJEKT82wdKgYfxSlmMeRlU3H0s0DwO+A4svmk/nVAAfW1s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789644759; c=relaxed/simple;
	bh=v7Qytqm7ondVmKEizFYK+ogiJgUcD2OLVftKNCOl8aw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FwLRLQ/W2D6E/ier77iEuUf8sHxQTbZ+RQXMc8+3Y49c8LylzfBo9KfIQIKyOFKcevYtC6xZDxTPIebhUvnmiP0upE8riTVdxyLG1sEurQrG8X/WHwnS768P9ETGe/JJZy/drwJKb3BLflBl4/CgueNlL63x+39tgvXNoE0kUcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Brx3V4hj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Brx3V4hj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8DE51F000FF;
	Thu, 17 Sep 2026 11:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789644758;
	bh=NT3AR/HzkEf6lxJ23rCzyAMbJ3c/PpXIqyCYUYbJrjI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Brx3V4hj6iv2s2o4b/6RjtWMtmMAoZYawz3bokFPQRCMRlUfaD+1wGY6VriFLB2zL
	 Bla85UWBJyND1xUbcHVsTrXqnjpEEKBh0yhI6kD00DVCMYR579I9DqwcdGnRSYpXV3
	 wRT+DZzPpeqoOosfhQGo8hwBiyGUruI9ujxBqMkdG60PqKsJdjI7eW964wk15WFo3g
	 /tsr/JmHYyPlDUN9+xt6UJX3I6gN7NMSQ6uVsP5Z6WZuUuVJKgMUrgBsOrwOHVPzTz
	 NU/LQOxR5+9TpiHpiSBwhU4QzWQd3qmBmdAAEK0E7fVihGnCaXokjSls4IfXd8KxW2
	 HHsQFnV1vn7tg==
From: Mark Brown <broonie@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: lgirdwood@gmail.com, linux-kernel@vger.kernel.org, 
 linux-sound@vger.kernel.org, patches@opensource.cirrus.com, perex@perex.cz, 
 tiwai@suse.com, stable@vger.kernel.org
In-Reply-To: <20260916072900.1971595-1-vulab@iscas.ac.cn>
References: <20260916072900.1971595-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: arizona-jack: Fix runtime PM imbalance in
 arizona_start_hpdet_acc_id()
Message-Id: <178959288860.414407.1871874696214616582.b4-ty@b4>
Date: Wed, 16 Sep 2026 22:08:08 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1170; i=broonie@kernel.org;
 h=from:subject:message-id; bh=v7Qytqm7ondVmKEizFYK+ogiJgUcD2OLVftKNCOl8aw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqq8/SCSDvzS26PdxoKyK5Yqm2uk+FFOjOhCCOX
 wJSZPCLj0uJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaqvP0gAKCRAk1otyXVSH
 0KjyB/0QVU8d2fESglgTSzoDpkESbY6JXUdnHh8RHelGUqwXz23rHoiLg6DIWtVL48CGJCw+6qt
 wUtqgh5MFCs/o1stIPZuslTvs9iGcOdaxVUnqFp6Cz0p+2lXjhOuo90EC2pKhqx3sK95AF1m2m3
 YK6OBQCoWbDQXCRossyYuE7+lR7KrIxnmuePEPKxVBxHs+AkJfA1WpCTZXKomMH11LVpkB8Gnml
 MhfR9O3MitREwd6uNN9XGsmclbN8OTFGRQ/gJB1xGXoUaifrOv00d8S0H2AwPCco0kOMZC0Pl9h
 yesSvuHBn6xI4qy8xQEz/o7uXeiJyAhDngUol8iQoln0tPnc
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 16 Sep 2026 07:29:00 +0000, Wentao Liang wrote:
> ASoC: arizona-jack: Fix runtime PM imbalance in arizona_start_hpdet_acc_id()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: arizona-jack: Fix runtime PM imbalance in arizona_start_hpdet_acc_id()
      https://git.kernel.org/broonie/sound/c/e04dcb895b46

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

