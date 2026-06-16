Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE0740FDB6;
	Wed, 17 Jun 2026 13:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781703529; cv=none; b=YhukkTGP7NGQcfN4UxyH5KcWx/oQKEQQYaTR0s2igHJxW4ci4UzHOYPcOvJN95rIQIpztFKrIQYsRKqes+dQlEglvCFsOqfkwldIr3bGlGWmiWa1GEypQF9hG4gaT6jbPOGAKRLxPRmpTTtULW/yeq0XhgukUX9xyn6zKGHmvAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781703529; c=relaxed/simple;
	bh=Yt5piFAfsa4u6XDlNbqy38ZhsDBCx1dhPzIwYj2FB+g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ayvtyKfDS+VT8ByGlZPDn+CHRNc9HXkunucevXRZ4EM1k6GWp/kxRJwMzOzV5VhL0nWyPwuVp01G7Ws8IQMHlVG2HRFTUi0eQcIvKrfaaZeq+6IfpkQ1kCC+4hZZA1wjERarEBYXERZNr0/uOb1RirXlMTzKtjIXW1Tddk2Am4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdTGqWoC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdTGqWoC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B8F1F00A3A;
	Wed, 17 Jun 2026 13:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781703526;
	bh=nGizWfC9otp+o59Whtdk8BXkRwSW33Hyj/NP0brBll4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=XdTGqWoC+UonEG74Rm6DzsnQy+P+GPJxHJamvUGWTmEQe27Qqjp8sGpygGsm/OuK2
	 +sQIAw/3GyixYRaeCiJZEt+o9XgppGPTXKFOxizZIh3aLNsElvdAkoCsLx5JLNI864
	 WN7n/yLsoayT0GLcfEUsKzz4t+37fxXWBNS+df+kHSTIsyAbek693+rViAWRTFV7VS
	 e+I8bcpezQT9B+u5hh5gGE1/noIVtuuup+FZivPv8Tcd27zXfJmmI53yjbGR6HinGs
	 MiE/pcXc9lZYfd28uNO5y2qJlLq8JHkCOxtxXTyLtPbwCasIpSBqN3AE/v8HXm3otY
	 LiUfco9+JmX9w==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: perex@perex.cz, tiwai@suse.com, krzysztof.kozlowski@oss.qualcomm.com, 
 andersson@kernel.org, pierre-louis.bossart@linux.dev, 
 linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Stable@vger.kernel.org, 
 Val Packett <val@packett.cool>
In-Reply-To: <20260616170257.9381-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20260616170257.9381-1-srinivas.kandagatla@oss.qualcomm.com>
Subject: Re: [PATCH] ASoC: qcom: q6apm: fix NULL pointer dereference in
 graph_callback
Message-Id: <178164179255.683454.8789445883635807358.b4-ty@b4>
Date: Tue, 16 Jun 2026 21:29:52 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1155; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Yt5piFAfsa4u6XDlNbqy38ZhsDBCx1dhPzIwYj2FB+g=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqMqNjGSW+oWOqSYHo7QAX3billaGJGbl+PyIZX
 EHcE9o7GJaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCajKjYwAKCRAk1otyXVSH
 0JKQB/9R6uxgxO7k/JcLpxh8NjssLTvdaIfRdxfNGSHs9XGXhQ24qtl7KbZw7ZDpRwtgADs07fs
 srY61zO4jXoNSt83ndc5NOM51kx/n01YXWDbIAYNcaLlN15E/VystW5Rm/bdJh00jL1UvOWtTwn
 kbMLWotAFpX6YqVYkyBhM7o/vxBZCodSGIJkn3G5o9ZM4Yg2Znkm2q6547wmbT85B8eUOvkXMVC
 x7IvC0bz4dx9tB+8FZcGnLIsnVtpLCnRwr+yQtloK78B2SVwWKmOGEj6V60qTaNvu7bzTwN/SwO
 Z+57n/YpIqa8h3QGSh/5oSShBzKDjxndmjov2To89UuKsBtR
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 16 Jun 2026 18:02:57 +0100, Srinivas Kandagatla wrote:
> ASoC: qcom: q6apm: fix NULL pointer dereference in graph_callback

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/1] ASoC: qcom: q6apm: fix NULL pointer dereference in graph_callback
      https://git.kernel.org/broonie/sound/c/41c26d9bfcf4

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

