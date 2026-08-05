Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC32E34041B;
	Thu,  6 Aug 2026 01:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785980931; cv=none; b=M1vMdFbuQu0zKsqmMtn96tWhrs4uNZrjbdPzaThWNn1wBMRBcEycqRjiNPZb4mHEGQ14cP3Z0ne7Ksjub0lb7ZXTDSWa4vMfSNhgv05Yp87eq+4hEF8J6d1koWQwhze7Ds9FSlInuYqPqF1MP8wMRRyp171oS8/6oPp/M2TrKaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785980931; c=relaxed/simple;
	bh=GNuDAmRBJ2l7bMXWYdxZKDiaZ0Mm0RmGfagHjSJgRWg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=l1urzWoA7BuTTaFY6F1Ce1EZD4RiRb04NcVvxzjNCinvQa37rgx6ZDq9tbHaPVK4DS6hyCOS8bElLbpl9TIoRPxTy4lXBc7oZ9P2Brt+CnYRiiqCayEayGrfc6j1GUhQIOWPYAYNgk4r5XfCiL5U5EC+6f1NhVAwYLU/eldyCqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5acj2Rg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5acj2Rg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A3A1F000E9;
	Thu,  6 Aug 2026 01:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785980930;
	bh=JjCNpR5wIJzN+Np/56MKnt0+6NP9pHk24HaODcyqUZE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Z5acj2RghtST5uq2eKUfy4nDV1S1w09rDjIXMcZp9wmvaHA3hSX8sLet1KTA1guVg
	 KBNyKXC2sc54yy2dnSTQ2z/1u/aHNgGhnnGRbMtNyMNm2A/bPJ6mv4xLzdjW2wy97i
	 8gwCeWOx++win2VYez3RA3csLaDKui5mqLlJ4kmjtNLKuNdOQPcS/9djsRl0yALsI6
	 KikZj3E/1MIlIfVUqKqxwM0SkQYLEHl0nk9gaP9FvI+iPcMI9hBRzvNvq3PF/rgaBU
	 ySSJe5AKyk1S3AxQJ0h1mdPJHGndFTIkteR1M2rWIIU4ohzH9vWB3/1JcgxgAHcw14
	 auIZ5tjHc2Okg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260805122713.11376-1-peter.ujfalusi@linux.intel.com>
References: <20260805122713.11376-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH] ASoC: adau1761: sort the register default table
Message-Id: <178594803063.199927.11939365972739493390.b4-ty@b4>
Date: Wed, 05 Aug 2026 17:40:30 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1114; i=broonie@kernel.org;
 h=from:subject:message-id; bh=GNuDAmRBJ2l7bMXWYdxZKDiaZ0Mm0RmGfagHjSJgRWg=;
 b=owEBbAGT/pANAwAKASTWi3JdVIfQAcsmYgBqc+gAEP95Jp5BgtcAyrSmpqzJsgPglg3qwReN0
 rdkt9ENhuCJATIEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCanPoAAAKCRAk1otyXVSH
 0DHOB/d0aThHY1b81uZMZsZzwmzt+bR3CSH6k6YM+Az7LhaKtARkODaJfgrMdxFncxHps/RVlrM
 eK+qinWaKUrX5EN6rqWwtbiGOUU9Cp9WBmOws4KGndPncvooOUldhQd6umGN7v7hxPcyHR/mQGR
 elGhXl9km+sbjnUnAB6nGfLphjTqm+sOdo/9pJi70EAqnLcS0aQvD8cHwMs5zl+feMcVp9isshU
 aZ2brlCtuI3Vt8TlAki5RwDUYzhgwJhPgSMaGUNK8qInvD2vYSmlfnarP8d3k/3x8P1WC/dJkTo
 nvwPaOSTn7ptU+zB/qzdjUOuR5xhzCG6MEHmzJjewfex7SE=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 05 Aug 2026 15:27:13 +0300, Peter Ujfalusi wrote:
> ASoC: adau1761: sort the register default table

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/1] ASoC: adau1761: sort the register default table
      https://git.kernel.org/broonie/sound/c/cc606b6c2328

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

