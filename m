Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB6D37C0F5;
	Fri, 25 Sep 2026 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349557; cv=none; b=CtLN7x9+Wh94PzDyMCdnNHVjbN029lKzMpGepF8MwRybswat5xy3lDa4MIX8NNlHrYt7ygtIk06HsA+D+mc+oq3qyvhNW/V2uwZgNiBg7xm3KAxhPNtULLtD3TSfvVjbd+PvGplJnvqtw6eX4GgXES1N9Au/cZDwFW5TYC3ulXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349557; c=relaxed/simple;
	bh=TpSqpNqKyuSoyeWtU1IVlmeYJTWYXguelTZlF/N9oM8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iEhspaAcv/Rnce5QripUv8U+z4uL5zUj7L8jrPGWZhmsVzyGwAtHFfm4TIeyUOjst7pbP43JHA5qgznPAKWDu98MggKoV9i/nQ1MA1vGciu3P0RzpR2r/nPVW9+RfSeU9Ga2sWsghMN8DJuF4lvW+0vvhcFfI5VGdTNzCJbHBz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQMRXT2S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQMRXT2S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D90E1F00893;
	Fri, 25 Sep 2026 15:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790349553;
	bh=Y6/QROIQGqleWmHbIv1YDGIron6nQb66ooTgjR8V0ag=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=gQMRXT2SAcebjcduC+LVDKul05frsCc2GYK30kgkoyHfetIipmEVvAgYP+8DO5pbD
	 DsFmzcVQZJ1I3wDSRhiva53JdpA9U+xIj4JBYFlzIjmcTz8RFUqVWcCvjFjJyT4gQG
	 1CIccSkH/Fm6Ei986b5sB4Lu5GgLMdmc0c1try3mwww1nEaaiogo07EfMuCohar1gX
	 s7BDBekKSkM4B3dT/sISOyBkvjcOEChb3nXTtLMjXulhNM5T4kVTWo4kBhtK5e8dC9
	 lwwPH93ocQNyh6mpoeXdcghgsCvYoKMMhPrkETL7c74BBkiIU5joyj1YYgTtmTzPzV
	 uTIKtdfw+j8YA==
From: Mark Brown <broonie@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: lgirdwood@gmail.com, linux-kernel@vger.kernel.org, m.purski@samsung.com, 
 stable@vger.kernel.org
In-Reply-To: <20260917143052.2156903-1-vulab@iscas.ac.cn>
References: <20260917143052.2156903-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] regulator: core: Fix coupled regulators reference leak
 on removal
Message-Id: <179029222340.149798.2335376229223099439.b4-ty@b4>
Date: Fri, 25 Sep 2026 00:23:43 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1156; i=broonie@kernel.org;
 h=from:subject:message-id; bh=TpSqpNqKyuSoyeWtU1IVlmeYJTWYXguelTZlF/N9oM8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqtpDtMwqQIkfu8fXvPS0kSS0bQktXCF72rSfHJ
 FrE8dJaPqKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaraQ7QAKCRAk1otyXVSH
 0EecB/4puWlU11SYpfUFj5+k7Rr4SdaS08noMASqXMiD0gr8toI4184/lgEKrEs1GEZj+TChJDu
 8BQ0tOxrr4DM4n00mMQPaR+X/MdQqLXjj7vOZ52vPieLZP3LUU2ox3Ge4pGftGCYO7IE56vsmnl
 3/ElbbibB533/A7HEiZJbtZ0cqN8kAuFP4G6SjN+/MfDqPmoCdzR3gdAegzJFyc1MaXXGgys1d8
 X5zAX04gm1MJodJ0e3zGRL6j8ptu70jdf7Vqj4VXtWP0vI5YfcT7m8CdrqJhfhPfvOzEeNWytHk
 Cva6RvbG0WiFmFmoPJc/WYQSLv7BJUQdRu/EymVSlA2dUxy5
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 17 Sep 2026 14:30:52 +0000, Wentao Liang wrote:
> regulator: core: Fix coupled regulators reference leak on removal

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-7.4

Thanks!

[1/1] regulator: core: Fix coupled regulators reference leak on removal
      https://git.kernel.org/broonie/regulator/c/b9205f0837ca

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

