Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF2143DEC8;
	Wed, 23 Sep 2026 21:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790199479; cv=none; b=bIvuc6HO/+1ZFgWEOOU/SxMZXFlBazqvn4BgqZAeJZonNa/41Dnx2wxIriKvLs2qSu6MMJ5UA4jK+vfjRD9RZGCqLOEVa5w4QXB9S9S9kQuJl7X/TqIEzM7vrO7vDeQNJ6CXUSUJCoIJJTQCqSxga7Yms7K0cJ3W9d8JN8f/ON4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790199479; c=relaxed/simple;
	bh=uWseL9MtokTbmidoCbOrLXBq7nOll6YvZXZUrPR09Q4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Qo0n/Xih9qs5Zn7a+LAA+t+wGIDXnbnoeyvqsVaXA31MrCcWXSXpcCvDUug+FOvcs63ajVJSjz87Sc/T/HHZYPkadcJa8UfQqGdrY4PoUbGTzfKpbhqrUrybt+AK67r3hSfviICMeNedrAtW7pFqSVyWGmEncvj8AwNzgINQ7oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1kGOVmJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1kGOVmJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DD61F000FF;
	Wed, 23 Sep 2026 21:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790199477;
	bh=uyAu47zUkyhI8o35FJeqCaCcq+21VWJUWLgzrg/IF7Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=S1kGOVmJNNgPizjRJLM3mmEWJYg8KdivmYTSCPIBkts7DxIUr+Bq/hTw9V8xdE808
	 Myk/SHw2DR7mcg6YkLD/br1rnRuQbfoGS/t3UdcZZsu82oD1CcvDDiaKc3SEcWsogm
	 EqydJ7JmTSVD9jcTK26iHxhLvCybTpT0eLoKCjxRyLdJM6vKCymajc0+xqim/wpqhf
	 lx7WG5D4f+RP46LtUzjUFCqbOvfAtFrlft0Pk+D3CRH8xlg/uKcldGhVw8H6HNG8oZ
	 etDadVI5pffGUrdyakJPGbZYAYheQopwKXIfKyyYIAemOPmrYmM/Xm9+qZgJxp7UcP
	 XoNHqy6OmQ/lg==
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>, 
 Shengjiu Wang <shengjiu.wang@nxp.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Myeonghun Pak <mhun512@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>, 
 Nicolin Chen <nicoleotsuka@gmail.com>, linux-sound@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
In-Reply-To: <20260923054017.93553-1-mhun512@gmail.com>
References: <20260923054017.93553-1-mhun512@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_xcvr: free IRQ before canceling reset work
Message-Id: <179016750164.322763.13341325503493899165.b4-ty@b4>
Date: Wed, 23 Sep 2026 14:45:01 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1123; i=broonie@kernel.org;
 h=from:subject:message-id; bh=uWseL9MtokTbmidoCbOrLXBq7nOll6YvZXZUrPR09Q4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqtEauhW23oxSzoxIL+Irgp0A2CD8P0X6VM18j5
 XBhD/rhiciJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCarRGrgAKCRAk1otyXVSH
 0N9BB/0YtHLEHoIMhJt84cgR3UffJD8L6WYiGnhahHrfFIPZxb/ENeT8SV4UFo3xyQTt/p0fRed
 9LjybeVUl+UTGIcGLOpFCyKGdyKTNW6OVcAwjWJfESNx75A2E/69+j9oHCUQsUboHgH3mnbN949
 zePy80PJtmqr2BWDa9D/1BxUVKHTsVLRJiJ5chf7I4Q9Totcb0YL+BoPqEwc1qN5TiTUF76NNu6
 cnsXhyLtwiqKbkpdGvSJm0OefU/hXndQzgt5aMcwdYhC4X97jfFsmtYffLe/fPyu3OT/vpU4ImR
 c6d2fHwgAO2SrhkMmVbbLV4MqmkH/06AwAmRXxIGPsp3Oyxt
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 23 Sep 2026 01:40:17 -0400, Myeonghun Pak wrote:
> ASoC: fsl_xcvr: free IRQ before canceling reset work

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: fsl_xcvr: free IRQ before canceling reset work
      https://git.kernel.org/broonie/sound/c/83701fdb2d8d

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

