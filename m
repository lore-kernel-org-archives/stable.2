Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8393655E0;
	Fri, 25 Sep 2026 22:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790373933; cv=none; b=hAs0N6c7RoZzZkadnO4Xo2kugLWBkYqQ2QRUWFDBsR3UwiGhrZvKHt29sh3wrXdFC8ugxO57MlyPmoe4LVi2cxFgF/ijX+TA7a/1gKqEmCQYdhzLOKpfeBwBtiJ4WmJMMFHF3ZmsBclewbZDTJ7hv63AC4O6+1hbPVrOMO00GqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790373933; c=relaxed/simple;
	bh=7eT7PUWjs0411v6rxIUz8bDPPZYI8hiqKSOCtT9YKjg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mGjIESLASdKyGel9mtqDjeHrDv9BtAUfeoWFUFEA+k8UFns04ZgImHSEnK5b70yjNPZA4eYloE7BDA44pA/ycFG953DMREzJC0XS1t6HZ6v+iG845ApKnew8xzUY9wfn2TtG+1qoHBfOZpDkTZFtHYzBhqUatg+6F5RgsZwgmbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPjkV3ko; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPjkV3ko"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52EFD1F000FF;
	Fri, 25 Sep 2026 22:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790373931;
	bh=q8F8aEDs/291b5v0Gs+UkW/M3P9nH0yxcjIqX8tJU5k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=BPjkV3koxNIwP2tAzGB1Dd9bOyZhEelIETl2+BazMXVpoUya29S7FoyfcIjgBiIWs
	 Ymv0wRPlsFAbc/umhcihg4CLlxLSrKle1vIhZVkX+CQFthIZo/gj4KdQm50Jk8X8St
	 v2g3AKmpciVuTfXxBHA/PuJYSL+aAGtUKi+D/8FAJb4hGTc/Fb91J4hdqPTIX7CwhT
	 5PUL9gcFxtSBu+GYEeoEZp4qhI8Tum+K/IvjCN7ETVQnyCkJFpbg2Y2XAsHTJKciA3
	 W7RA1TGMB8Dv0FJtRV3Co7aA4mCbe7ffM4P3Q3TXCeATgT6m5dLb5goFRlV6JfXddm
	 FcZ0y/GUyoMBA==
From: Mark Brown <broonie@kernel.org>
To: srini@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 vkoul@kernel.org, Ma Ke <make_ruc2021@163.com>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org, 
 stable@vger.kernel.org
In-Reply-To: <20260914095009.12049-1-make_ruc2021@163.com>
References: <20260914095009.12049-1-make_ruc2021@163.com>
Subject: Re: [PATCH] ASoC: wcd9335: Fix device reference leak in
 wcd9335_slim_status()
Message-Id: <179035784658.204944.1147782981571580690.b4-ty@b4>
Date: Fri, 25 Sep 2026 18:37:26 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1141; i=broonie@kernel.org;
 h=from:subject:message-id; bh=7eT7PUWjs0411v6rxIUz8bDPPZYI8hiqKSOCtT9YKjg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqtvAmSmZ0fAswx905+x5MJ2hrow3dndKNNnlR6
 r4dl7wExKWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCarbwJgAKCRAk1otyXVSH
 0CfBB/0ROktEnIEFi7Hm1T4IXfVZy9NStJ+0Pyad4GyOCUAnf62JPEaekX77+08Slwbcgp8bErr
 zUtkJFWqOjYfcHV5WwUq0zV0No4pTItMNKvBjH3wYnuOwQuknCc9ZBtDfeJ7C9kq4ifLy519sfK
 TIU+ElVxbDMnjZ9/4OMXVlafBuLhpm5WT4hHDp/V6eECor+LFxl9fqQ+9n2J8rZUOCIy0FZ+ipT
 EzdcsyinXZxfbULi0SSSXS9scgcHf27G2ewAtXrYoJ757cJkUPZvOcfA2yNgwg5QQgQIL7UX4Mj
 ZOuHdQTu+DJALq66oZQS3yRMucJUfEWTyaJHKBzEg8fsDA8C
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 14 Sep 2026 17:50:09 +0800, Ma Ke wrote:
> ASoC: wcd9335: Fix device reference leak in wcd9335_slim_status()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: wcd9335: Fix device reference leak in wcd9335_slim_status()
      https://git.kernel.org/broonie/sound/c/f0cc352be29b

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

