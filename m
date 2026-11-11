Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413247;
	b=mdxZfbyjSBuOdp4PXph4Usal0Q8C7AGzPPxRqdrC+mgDOtOhEPj5vfIGZXBMcNUfZ/8K
	 kxcb9iJzwMv1y+CyQsAl5VyBl2U6oY28YXQnVSNloA+8M/dfvWoJgFcFL2RhXUjt0VpyH
	 9C7KnC5nPvNFUOvSllC9eny8jauvSl4rj4IdSWOHS0780BZ1KvahkNIaawrShJRdrrIi6
	 Q58B5Yi4yyfHjB8+oO/mBKu09ds9ihkSInXWOb7Q08zaqnH08b20eVUCWbekIReB2aiWq
	 dGyeGaHJ4qyfnPY4uXsIjtcvXJYpXyvwMHytKgo98fN6+dp71I8tMGrhWxDfFW04l6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413247;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=TLBik4EjgLGNAn8Ho3AzGHfznPzct8WEHc6RksUL3/Y=;
	b=o0Q51YQ2qAozEzqzXQHuS7Dp856vMjX067qQu8uKvaoFgG/o3AWJRbDagfd/jv/Wf6JE
	 rjXc5FQyfBjEY1fVXtmU6iSSir1LtO6YvNPfC1YLxNmZ4kaeJsTEP9F+yRe4Xv4Mqek00
	 zvdqsXGhP89OqKPfpB2FkB4dCxP6J4fPpyfK21kIHYsn/SuG/bNd0vGD4SPqpSfa9a0cT
	 jBwhYcV+EEgqdetgDwibXAuOOYkoNVQlT+x8QvSyX44g+2GUMY0k1ZQFQ8Iho3Cs9mVur
	 qsttk9KbwoAx8Kb4ryJuOKnQFYKuNAbj97PKWoRv5ywrQmBYEcIB1JltRrtdWJfEpQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j563T2Ds;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A907606A321;
	Wed, 11 Nov 2026 16:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j563T2Ds
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1EAB1F00A05;
	Wed, 11 Nov 2026 16:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794413247;
	bh=TLBik4EjgLGNAn8Ho3AzGHfznPzct8WEHc6RksUL3/Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=j563T2DsC4trQUXh5v7bUfq+h9Di6gyd0m+G63fguraGgNHJP9y6S2y2RD/CHVkNU
	 IDExY2ksZt6LKBWjiCVV2p1toNEvu7fb+nKj+OlSTDxt14GN8ja3u/ALjLyzu5bxOX
	 bfD5W0XfMP9s6Nwx8ii7pZPGLQLOc7S3ZEaTQgZ/HQKev6plzELQurw/t9HflE2V8n
	 2F7ssKENcFuWwJaguAx5T+r/pNwaE7G8eycKtDXEqVIG3XdvtJpIVn/ngl7T7cNpGp
	 Gd/lcyh6hl0lCUE1xCmsY9LW8MnhhPVa/bnHGgVlfKEYV0qU8qujkp/YdYwYuVWAnc
	 5idLWIvPBvJEA==
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 Hyunjung Ko <hj351016@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261110054453.2286414-1-hj351016@gmail.com>
References: <20261110054453.2286414-1-hj351016@gmail.com>
Subject: Re: [PATCH] ASoC: ak4613: cancel dummy write work on component
 removal
Message-Id: <179436227223.926575.10694675681335196432.b4-ty@b4>
Date: Wed, 11 Nov 2026 01:57:52 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1133; i=broonie@kernel.org;
 h=from:subject:message-id; bh=YRzSgstMfrNpSQAwLkTRVr60+HThrSfKBaIrq/IjlRg=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLK+TNrtIJL3V8nY0LpD+o/K5V1+9b/uCE+9lrrzQc59h
 fvSjZopHaUsDGJcDLJiiixxWdwv60ter+E7uLANZg4rE8gQBi5OAZgI82+G/yUyV5SuWzBUT7SO
 c5b1cUvU73l3LMWp4IlbeEpw5a3kZQz/DDM9jCoaJVN1rkVpM01j37mu25nFReT+S/VP3wIS06K
 5AA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 10 Nov 2026 14:44:53 +0900, Hyunjung Ko wrote:
> ASoC: ak4613: cancel dummy write work on component removal

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.5

Thanks!

[1/1] ASoC: ak4613: cancel dummy write work on component removal
      https://git.kernel.org/broonie/sound/c/c07982ac9dce

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

