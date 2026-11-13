Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794743019;
	b=qM/i7wyH3M1KJ5V3fjXPsoJaQ/I9sQEgZ8a1qdCsN265Eoqy5e7/tY624tJp4Ftf48ai
	 YYK88euuH+LUZndf2gY61QFZuyboiQrL/5UPprn2nJPMtPnlp608h5BJcT7EVZl8yjGE6
	 jmathH7nvAjEdf8PSpOgtJD6NYV60670zs1s0S4TzXyFhexLOb9taOZWe1kVomz0KqBxK
	 0Wo+nA2EK4rQoqRD6qcobzI2JkWntumOmzCjB894iOeIN5GYUIcnr3waZuVz5mW7ZgASQ
	 SIkFEoyWTNSAOFwbR+TcCSaKq8515O/owHIalzRWfPNSxASaaAkjNxFaFySrIJVpDwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794743019;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=b8sO3FhCekJqG8gkayZyke9pQ9N10NbWdbOeXNfeb+c=;
	b=CKhWed9pt4/SRAmujk29xeuFL3iR665onNNxnnhL+qcNEOTxQWCluRQ0M2UDSUQiXnYM
	 lxUCXb/Y+A+IT/VgFmr4UOctbj4QaxEUeBcfPT9EB+4WI6aHlsewhbVU6Dd+eqCSOceMe
	 iJcadeaN8jV4cdj7rDWS94RT18Iql/5l4UolGd/GfY2YVENSlHG8uplVBfKw7zngPrFX7
	 GMKDBZISoeBkaDv1cdd/433/Sj7SLxvfM9sXIpxgGovPUg43xUbn4+CBheIuYNjP3apYy
	 9mOB6a6z82x7KhrOBinkxgm0qlGyIyuatKVw/0nfukPENrXvaKVAl0xA5zmwFLZqz+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nhGzO94Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8B6606A32C;
	Sun, 15 Nov 2026 11:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nhGzO94Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D661F000C4;
	Sun, 15 Nov 2026 11:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794743018;
	bh=b8sO3FhCekJqG8gkayZyke9pQ9N10NbWdbOeXNfeb+c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=nhGzO94Q4SS1VvHLayaaZxBOFzi7kRuCPkIWXL8HlHJuCWzng0F0rSy598bXDCcrw
	 D4ksi2c5GztShKF07qFidHpj1HdHVb27xRxwZ9726uXBeiPbQgSHpjMaUtpYIn33SQ
	 cv6RrwmlKdYs2B5GQyyR5joqscb/jRoeH6sp4/+ejju17O275ffF8Gj7C3fSk4JISC
	 DgdgW/8Tt6KmtAqRohmfsoKZBv4vZd70OeDnI3LcRrUAVkLPonOjvKs579WIW+UbMh
	 HrEhCPH/rZnvh3TyV+nThGYSyRzfQKSmHcOQrsiZ52aupb6X9JPkB9Y33eYpysMtOG
	 smu9KUozBjccw==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 0E6D13366C01;
	Sun, 15 Nov 2026 11:43:37 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srini@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, hyunjungg <hj351016@gmail.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261106114628.2555176-1-hj351016@gmail.com>
References: <20261106114628.2555176-1-hj351016@gmail.com>
Subject: Re: [PATCH v3] ASoC: codecs: wcd-mbhc-v2: cancel button long-press
 work on deinit
Message-Id: <179460985134.590303.9887273996770052957.b4-ty@b4>
Date: Fri, 13 Nov 2026 22:44:11 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1147; i=broonie@kernel.org;
 h=from:subject:message-id; bh=h/92pmD4OYZXWGmU3Qyf3t7FfRviTjms/y3AfH4XIWM=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJ+znrxpNNVWMRHuyf4973wEzd6j5dbpp7gWb+xNfCT6
 KX2qL2bO0pZGMS4GGTFFFnisrhf1pe8XsN3cGEbzBxWJpAhDFycAjCRGDNGhvMOJ5e8e5Xw9pZz
 v/quhx22N1rC1ugZyT3fs0Kn6cCypGkM/8x9RU/8LtN8eqz+19XvyWG87j5BV4/fspWy5Vi/7Yj
 vCxYA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 06 Nov 2026 20:46:28 +0900, hyunjungg wrote:
> ASoC: codecs: wcd-mbhc-v2: cancel button long-press work on deinit

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.5

Thanks!

[1/1] ASoC: codecs: wcd-mbhc-v2: cancel button long-press work on deinit
      https://git.kernel.org/broonie/sound/c/5f702565496d

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

