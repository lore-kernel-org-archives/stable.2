Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794871967;
	b=TTh1ipX8Dlo7F0f+QedD6cqovx6M2bgUS6MQ78a2nug/z5vFAPPONpohn5XxgXvKf9Yz
	 uo0g020CQdBHITBsSJckl0o7O/ngdLGKOatfgtd1a80uHSCAzpZNiG0SXY2Mpdzh94gW4
	 xWofKvwfmzorJdQRY9qsr4v0hviXt6AW43BbeKhoHFJPEfvT3nmy0AyoujYAvAJX7l58X
	 zDip37TdJJeY1EJgtrYVDpANATwP6pMCw3wnS1MDR4R4dBuMasLEmEDLgrAz5w/5V3tPf
	 ocUnGeURCpCWJH6Rgob3LBV8lmvhjE++2NFYeCV3/WpyabjSMyG8EPyk4T0QOjrwU8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794871967;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=jvObFOKHAYWa5eHjD6OlFRTmL6WO/fHvNogyw8ziwfw=;
	b=PrB8deWwK1GcJoAS6kBYR4HtU6lX3kr9rB2GSzh3Bf44qfYn956aTCWFUE1t5e03bhIb
	 r8M8SgXjLjk+XxAmXU1q9wCE0pmEAd80iJAgioz9uMiJvqnC1DOa7zdO78yb3cm2DmlDS
	 Ooifp4LAfTdz/UTPVmDFCAxf4TxsRVL4fMaNpirs8aoVT6dsz/hMBFMaYYChAZCL9bbEF
	 7o1JEBdOXHzg+mrv9e1aw9YHy+aeYgOFPSGQHbX7OjXMNNH7IQO4QBMINDbgEC1eYEU6Q
	 QLT6d895MgC7vgfnu5A4lKw3D/7UqRtAGb3Gm3hSnLh60JOgJrkkXzN/kA+U+rDEzBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GRleBCmG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89056606A881;
	Mon, 16 Nov 2026 23:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GRleBCmG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED7B1F000C7;
	Mon, 16 Nov 2026 23:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794871967;
	bh=jvObFOKHAYWa5eHjD6OlFRTmL6WO/fHvNogyw8ziwfw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=GRleBCmGHT8K8uEJDGJU0GJdWl/1guIjxW/JLbQANSYtoLoYlzDT6SgbH/mojrmH8
	 cUqbf/KiDmU/J24cuknXmrVfs6rWBNMxuzBiti32RtDiGdfv1GjufIhPzNYpFh1968
	 KykN6oKKP6SY4jESOjTzNEhBzUh+hP7+nLQ+xkqXQSWK73ALWozPzJXdEvTdE83gho
	 h7pQZdlC035w+KCfr1CYoPQZVE1NghhRLU6etfTtLmifnImWF9eNDAC2+BGU/0a2zK
	 n3Np4tuHsGplrn2bOMMPFlV6Vjqmn+4jxq6TQ73UuytPTTdXkfnZYT24tDlfzZBk2h
	 jjS2AlZVdNonA==
From: Mark Brown <broonie@kernel.org>
To: Oder Chiou <oder_chiou@realtek.com>, Hyunjung Ko <hj351016@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261109172144.1851173-1-hj351016@gmail.com>
References: <20261109172144.1851173-1-hj351016@gmail.com>
Subject: Re: [PATCH] ASoC: rt5665: cancel jack detect work on removal to
 avoid use-after-free
Message-Id: <179486331581.2504946.9205681463041578709.b4-ty@b4>
Date: Mon, 16 Nov 2026 21:08:35 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1161; i=broonie@kernel.org;
 h=from:subject:message-id; bh=I1BhjhMCVAecEFKyLU9clfQ5ynpbAW0BGejXnRfNsOE=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJ+T5rTvuG9XLTLPiW7DkFnUxa5uS+7jvvuF7515EfEn
 Q0N8sbzOkpZGMS4GGTFFFnisrhf1pe8XsN3cGEbzBxWJpAhDFycAjCRdTcZfjIyf9mbe3Q182d7
 Q6WwCWruJvLVv1iiIvnuP60P+xTDZMXwV1ApNFnD1XWiyrO1v7tVXqcnzojyij5c3xKWuHN/3pK
 zLAA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 10 Nov 2026 02:21:44 +0900, Hyunjung Ko wrote:
> ASoC: rt5665: cancel jack detect work on removal to avoid use-after-free

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.5

Thanks!

[1/1] ASoC: rt5665: cancel jack detect work on removal to avoid use-after-free
      https://git.kernel.org/broonie/sound/c/4561d07d897f

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

