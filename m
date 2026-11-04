Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793835540;
	b=u+b565TIUl7xg3CJ7Hhx7xG3lWJArpyfih5u2xKI7wGt+n9MLRk4EZ5lWQElRLtr94+x
	 CKEvAdLddl5AfDMCQ7nG/NimYyO/mghRmm/LX5dJz4dgWxLlKRiPAsyktag57SEXaC6JZ
	 gmG3ucChVUEfzJtvSZTYU1N2vYk7ghznfFz/Eehoriqb4kcvGVxNlSltqbNNjN5gh8OrV
	 s3inA03UHlhfOACYnlcH4DHhcNgqiDoAZpqHt81jnCMXtXDcGcurMbRNUvq0IQluOo5YW
	 lwRK/AkufUFGARE3UWRGDs9FUmt6Swg6Y20VCoCmOK0OSPeIIMOXOhDlQxKztTqbFeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793835540;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=PBo1FWz7t49ZeRP8eHjWPfpVP+xiSb6ApP9pXpB3jTU=;
	b=jzYoV3gtFFI/chGutsE6bzsrQdJZFisOb1Z4bydGo1poDAkbFuYlCke0GJIQ3S59tXYN
	 6nJH6B96u15P1SN1+ZTIPvkd1QvpJecPJeM6Ay2dgBMIN6HECuoNmJujpSSpJPp2dFq+4
	 tXEcNPP4ZSbXn32miKz6J3AgE8gCoRan9pe7aQd7MjpJB/IJKPmbxnhxOl60b1go45e4L
	 QRu8GKHyPXwsaejZKoZSMaV8w2YKo34M0VId6yXn0kSCJIGHoGEIo85vj5X7qXPXQ08/i
	 HPwrukoi9y6oV0Kmi9PbDekhuUnEAIhhawkV9nsrpl79WC3oKYoi+WceE7/X8eQ3s2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M54hMSNL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA162606A326;
	Wed,  4 Nov 2026 23:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M54hMSNL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F811F0093A;
	Wed,  4 Nov 2026 23:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793835539;
	bh=PBo1FWz7t49ZeRP8eHjWPfpVP+xiSb6ApP9pXpB3jTU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=M54hMSNLlhW0lvKG24McDDocUjgwYtxQTQzLTQOwFHnCxIA4nkTJ7pYiuPLnwlU3X
	 18DEDVBOFD81Fqbkk1YyaUhm+9v04t5VAwfk/X8Ynop5uq+Ya55JYi3Hcus9JIc+IU
	 r2UWk68BzxoYibWKuJEmCAG25fvFloSVUuh8RcNb/S1ARt18AnJvdWVxVB2kfwvwly
	 gnuJfgbRkYsJLxJTQSue9+lpQqAEFG4cnbWN6cX6GuhDnIJnUXsVbru5YydMlYdRp4
	 5hGc5e5ZF6H21sIoTSeHHMIZ41hPWJRlAEzr+bYlYvIMVLHONSAo7aLjLUpxfEO+wj
	 75v+S+hKfeR3Q==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 96C7B26925F7;
	Wed, 04 Nov 2026 23:38:57 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Lixu Zhang <lixu.zhang@intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Arpith Alexander <arpith99@gmail.com>
Cc: Weibin Liu <liuwb@xiaopeng.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261103131435.21838-1-arpith99@gmail.com>
References: <20261103131435.21838-1-arpith99@gmail.com>
Subject: Re: [PATCH] spi: ljca: Don't require data in write replies
Message-Id: <179379982119.2456854.16535704243207910546.b4-ty@b4>
Date: Wed, 04 Nov 2026 13:43:41 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1110; i=broonie@kernel.org;
 h=from:subject:message-id; bh=1UNQPe1ArkoCFmDMl3wCs2pcQrT9mK4iM2DcvGk0QUg=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJeHxL04YpPyntudiVldlH2m+wTxZPSJFZOO5h9Z3kGw
 +KKv+J3O0pZGMS4GGTFFFnisrhf1pe8XsN3cGEbzBxWJpAhDFycAjCR1ecY/mm/+JDB2Rotp/3s
 a9BctVnHO5YxtummbWBKnjRj37y4J8cY/qmLK1+7+uK7HE+lng4/g88+A8uF89hqhUJnlRXkt6+
 oZgcA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 03 Nov 2026 18:44:35 +0530, Arpith Alexander wrote:
> spi: ljca: Don't require data in write replies

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: ljca: Don't require data in write replies
      https://git.kernel.org/broonie/spi/c/5072a9fae45a

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

