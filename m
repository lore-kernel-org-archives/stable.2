Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794785246;
	b=Z4+uE5H0h/V/FP7eK/xtyscpOBmslb45QEgxxzSwQyZifRYZqMASDKvX9qW5Qaimdtxd
	 gu6MykFR5PzUyi3mgsX3GvTxHGzgb9Lw1mfzRImMMpE5fr/iXJ+XnXg0c1zG6N2yNPwf5
	 wFmH8lUQUKvZ0nsMnqZgMm41F5d7bsxD8XRI2jb/4Hi73jknwB6LPZmCbolLWFKmZRQvq
	 kQAWV9MQDlFIVZSmkyonEi4zA0M1a6T7l8bomxgwlfJZbNFtDno/vVzF8STxvNTLu9U7s
	 RdryEKVFY1Jem4PVLnHggwxOO8PzGN4cN32uAAoDQ/qeM8NnQUS1C34tkW+BnAetwwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794785246;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=8avGk5JBGul3hBeisCG2W22d+l9vhZ85CMAb8/QdrjQ=;
	b=sLcgWiMVvB/wG1JtUAFalVN9dZfpoyUJx1ahkgmge2JFsIHPaZ4Os9sdP6fSYOUSkXEP
	 GpyhlAeNQgyENf6F5CvSkqLk9PVi+XmNCfFSGgKJgXZuWty7iN7MT8ou2GJt6dwEu7ISh
	 LC0wnfGV7QaBzhBSNjVv6AOI9xxr1G9tZlnhkaoG8Xpxx1v+5vHfHTQvaf9enXLl9N9n0
	 yu1KPGmCfuhZAaQv2pu+3PZmy2p69xJsTWiq8DlKxE42fsunsAmDXakl8UV/fa/XkugNR
	 SHyy0sxCTVbSRGKJq7ZIXQw9dUoFBjdOb5i+AxH3Jc+sH6KI1f3d2rSQ/kfTjjyoPyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SWr7o8ZB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44409606A31F;
	Sun, 15 Nov 2026 23:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SWr7o8ZB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6401F000C4;
	Sun, 15 Nov 2026 23:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794785245;
	bh=8avGk5JBGul3hBeisCG2W22d+l9vhZ85CMAb8/QdrjQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=SWr7o8ZBGhPrpWikB/cSncS8daIhOpKQ+IBV9u7XgCp+5CosdZQvI1yzdlFrOU7zN
	 zXeo6lCgBjzNNFAzeec/oFmh7PEO7sVTDe6f4Uv/hO7Rwrb7xuj4Nkx8zEw1jT0PsC
	 Mhms6RZRTiRUzb473W1IH/J9DBCBCOIQEKt/3t0+/6Pm/pIh1oGHocpvr/7oEOT8Vm
	 HrTu9bE2v9QNOj7z6YqBIhTG8hKMUZGx/73uNLHgyfF+NZcq6Y6CrQwMNBck4bcpcK
	 JkCyM4V4DCq4k9agAInN1RaldAQ0EC9RIVfklseJ5IoOjMFtX9OEuhQXR3M5I4oVzG
	 Kohagwfjx8nSA==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 412193438EE1;
	Sun, 15 Nov 2026 23:27:24 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Oder Chiou <oder_chiou@realtek.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Tristan Madani <tristmd@gmail.com>
Cc: linux-sound@vger.kernel.org, stable@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
In-Reply-To: <20261110230603.2110759-1-tristan@talencesecurity.com>
References: <20261110230603.2110759-1-tristan@talencesecurity.com>
Subject: Re: [PATCH v3] ASoC: rt5659: fix teardown order and stale state
 across card rebind
Message-Id: <179476742200.140154.3384054500213156937.b4-ty@b4>
Date: Sun, 15 Nov 2026 18:30:22 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1154; i=broonie@kernel.org;
 h=from:subject:message-id; bh=b7+hhAo595bS0+aonRgQ/iSM0jJlt0LFDQFx2Ry9794=;
 b=kA0DAAoWL+9zsLPQOIkByyZiAGr6P9ygb66UssKiz3NgO37xyr5ETxPj9Yy6gSVwO7biCLa9w
 Ih1BAAWCgAdFiEEXmoL6X9066wOwaGGL+9zsLPQOIkFAmr6P9wACgkQL+9zsLPQOImViwD8Dukr
 yRrKGiETn/2eSq9CKRY+jd2hwOiIQKTKOAI9zkoA/3P4eVgcn5GPkL6iun9bfQkLMBf6N6uRPxu
 feNhUuVUG
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 10 Nov 2026 23:06:03 +0000, Tristan Madani wrote:
> ASoC: rt5659: fix teardown order and stale state across card rebind

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.5

Thanks!

[1/1] ASoC: rt5659: fix teardown order and stale state across card rebind
      https://git.kernel.org/broonie/sound/c/f49581b7e27e

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

