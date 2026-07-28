Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A45D4A13B1;
	Wed, 29 Jul 2026 13:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785331967; cv=none; b=MzmGoelYUC93rEGsqq56Mksj+R3R8cvxAObBcPEnVGPCNc6EytfMVXOpughoIAuC+k7em5MAzaYEAp957YRJbpn6kBbZgufsPoDM9DIQvOFEmwM2Vdh6W1Z5RWfGmp/vpbsK3N3cneVchqhxEYAIiVewi3X2IkntUcPOPGGOXoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785331967; c=relaxed/simple;
	bh=3eUi/Sk8zvSzEGlGTxbnKs2x/CFPNq4nDFv8w3V3al8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZvziaMT7OKdCzAIxvjweAOgB257bKSK8lya6MqNr6y2eW8dArBZKowqlk+EVRyKYQLz+nTj5RVB33R7yvSlY0XQxHdbZb2j3tSnt6e8q6FguX7oeX+0cHN64CbNju9BVLgp536sT61vMFSZPYvXF2gaQcQG+Vs9B3abQohI+tZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3gsXH4Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3gsXH4Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42001F00A3A;
	Wed, 29 Jul 2026 13:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785331961;
	bh=1tuI+G5BFSmI/oRU4Bmp/aoTRX2jKDAu3PO54XRfDT8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=B3gsXH4QVqoxk8djQAZgL0JB+YYetRHPWbnRUhQpsKA5oL+9GZNXc/wELtdXb1FHo
	 bG82vNKIIuo0iwen8Q1jU4AcCmXhhM8jKki4ASlufDU+DRskw1wVOoo6YOVLY0w5XT
	 lE0gl3xqwRxdB3lOwMxR0/FPH+vCG8Gex0H09W7nW7+3KY8OsOsWetuzhiasKI1/mN
	 3kymMckojlwhXdbndpp1Iy/Um162DbBvFYEJkVigzCYMOnfjs/hHcpUIgY9We3HJBo
	 vaq8ZukoCPmWUIQvzNoeNIegUviERGzlyTDPdeE4NtFA1BTqBnz+AhdvdJQP/erTKU
	 1z2vYULMtudIA==
From: Mark Brown <broonie@kernel.org>
To: Stanislaw Pal <kuncy7@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, Md Sadre Alam <quic_mdalam@quicinc.com>, 
 stable@vger.kernel.org
In-Reply-To: <20260727163216.109938-1-kuncy7@gmail.com>
References: <20260727163216.109938-1-kuncy7@gmail.com>
Subject: Re: [PATCH] spi: spi-qpic-snand: write the feature value before
 executing SET_FEATURE
Message-Id: <178525861341.13644.15757073965586666687.b4-ty@b4>
Date: Tue, 28 Jul 2026 18:10:13 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1161; i=broonie@kernel.org;
 h=from:subject:message-id; bh=3eUi/Sk8zvSzEGlGTxbnKs2x/CFPNq4nDFv8w3V3al8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqagD3BMMv9KlpqnWJd8Pcy9TisKk74FEBFly8F
 NA988tTetaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCamoA9wAKCRAk1otyXVSH
 0HQaB/wK0B3tafgA4sBW8kWrJ0xYpMyeRUA8U21O1WZN3ZdmgOA2Htpe8ZnzQy+GplH0DNgFQFJ
 WNT/tKrrYar1W3KJruQNgxR5xZPuWXeJ1IvxtMKSFlPybrVGsfb5pxzSHAppuDHEIbWYq8Leh03
 +vaZmCswXYi33LS2DH+Rg4EVu4gXAlJrU4QMo41/0mjtMMeVU4ADaWuhuOvygglhq9Nj9CtljEZ
 r/157isR3rYQdDzjW2UdVwwNfn7QmpZAuLFtWqyupqKuf3UkwUUtDWbaCnhrG+EAomT+V2kZW4g
 +853Wsat37YxOnsfq6jIKuM5chfDhhQemBziJAkdkGa5//IV
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 27 Jul 2026 18:32:16 +0200, Stanislaw Pal wrote:
> spi: spi-qpic-snand: write the feature value before executing SET_FEATURE

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/1] spi: spi-qpic-snand: write the feature value before executing SET_FEATURE
      https://git.kernel.org/broonie/spi/c/8fd62901d6bf

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

