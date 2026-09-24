Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E5C486B86;
	Fri, 25 Sep 2026 10:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790331291; cv=none; b=FwWkUWM3ENBBDd6IA8wZ6eOjVBMgLjJ8VXd1tDKx1veEnR1VJm/wakdA1shuraggBQj0Wi9aCK9CvDt3LbPMNNyh8pjKK+BPA3S3PZ7d1AdfcvjYnsLMXIu8Jok4qCTlk63gEAfgas7yFzRUAMn83mM5IMJdrTnQQVr9HTqwgHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790331291; c=relaxed/simple;
	bh=RcdIZ4jfWxdjBom5SpI5cn4XiPQGKUQz2YtspofqS6c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hWV2H+x9zgPl+hyV6RhivHVBbt7h5dMECptuBB9Kzttud+lEMcrhu+13AiaChNYgWAc85HVTbQuE531V8czHL8qFtwIg3iKhQqo3XUQeAwzd/HrMaIyJwyJfroWXXntzFFbeImfo24m8R2QumIPss6REWk1JGADH9656+9X7ntQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HugQ0Rls; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HugQ0Rls"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98071F000FF;
	Fri, 25 Sep 2026 10:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790331290;
	bh=CN1Pa4PDjzT8+X5WSOg9UacQFOsrnjgWQI+frXZro30=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=HugQ0RlsZ5zIPYYwo7S7FtxWiLFQtqKS2igHs79RVo/XoaNvhg8DwvKXb0hd7qx+c
	 JzO6gMD1IqXIgRG+EDVwz/HMgGQi1bLuevkZblcHiqxVr6XMBFYTwL9Oc4sO9az+pY
	 B/eYhqte97q0qT1O5sxnYlCzI3Zr1foShVRSlqrsQWnhA9V9QCe90fl1zqHZpvAXU9
	 uHdDKyTrhyr5OqzYVC4az9ogRXfvW+Kvg9ZfRIGa3aATsMT2m85XVgg1JQNOgKT2C8
	 tt1r1KPX1MJ2xoYlcIOB+UgiGf3RwqYEh6QolCOxC2zRQU1OSizuvCevGmmwWgAPE/
	 fE2YqEO9FUnCw==
From: Mark Brown <broonie@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>, 
 Liam Girdwood <liam.r.girdwood@linux.intel.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thorsten Blum <blum@kernel.org>, Guangshuo Li <lgs201920130244@gmail.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20260924134932.1590967-1-lgs201920130244@gmail.com>
References: <20260924134932.1590967-1-lgs201920130244@gmail.com>
Subject: Re: [PATCH v2] ASoC: Intel: atom: Fix platform device leak on
 probe failure
Message-Id: <179027551467.149798.15264259602754764389.b4-ty@b4>
Date: Thu, 24 Sep 2026 19:45:14 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1138; i=broonie@kernel.org;
 h=from:subject:message-id; bh=RcdIZ4jfWxdjBom5SpI5cn4XiPQGKUQz2YtspofqS6c=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqtkmVD/TvpnT3PKO4TOadW76Gl2Kbybh04Yva3
 Edv2nCm4XSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCarZJlQAKCRAk1otyXVSH
 0Lm6B/46SNafmPzXhhR7JlMuCPcugJcNjx8hi2Y4nbW6S5SApA8W7Ehj/pwluT34b5jkNxEj+Z/
 nvbdqZv/2SFijFGeX3rhUPghEZq+bg8BI6mQ7cE/XmJKTCdsB0xvA+ldS9ogBJQR7R5S9VUkvMK
 VjigMx6CeOaEvo+XQ5xMdyvU9El4oog18ElYgFo8Am6afo2XJcObqFsZ89YSbK3HHr9m9s5mNqo
 zD+/L76o0zVTNfBItFcl54cjGdKHF5Q2ekFjTB19a2xodx/Py+0zKPeaLUZaVub4YAs/bb+drRx
 2KigsFNa1CKz0qGCixwa/36JzaiTCXIxUltWUOFC64zs3x9V
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 24 Sep 2026 21:49:32 +0800, Guangshuo Li wrote:
> ASoC: Intel: atom: Fix platform device leak on probe failure

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: Intel: atom: Fix platform device leak on probe failure
      https://git.kernel.org/broonie/sound/c/dcc36d766dc8

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

