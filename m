Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974054973B6;
	Thu,  8 Oct 2026 12:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791463198; cv=none; b=nixfVDcROpaINrkeEElZPeEmBa14WATRU3KdcBDtNhdK9iLtzX5BQmNFF0yGRQTlSjPhhZvX2Mz7j1knNpTbdrEMTdcnirnLHnQGT8xy0azfhWJrLaEA8g2qybNSjq4FJg1lJrE+C3O5imAVgxtr9Xh3un6wFZgu3KwGAqFAg3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791463198; c=relaxed/simple;
	bh=d9Db/4xediCepUoxhqgfSWe1Rx8QyBv8TMjk/AVJ0Lk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QOERLiVPPpOghBorayi/MI5rFhKjj52HIf6hxKQRDBtP3XNviKSB12/s1zOEFTmsslu0VHAhZsUItOzAG15pkjEAdx4uJrcRnLhjRPScQGrxFB0t2uc/mFHupoaubXik7bGBPA7V+fR5Za9WFBrg4b6reAXJKY+zXy5+xhlXKiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSeoIzBh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSeoIzBh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344321F000FF;
	Thu,  8 Oct 2026 12:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791463197;
	bh=tNIlTLIPqJGj9rBZ9sUKLOkSLyIwwLULlBNY5fcX28k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=VSeoIzBhHoIcDKL6ehF4MgKIYsJqZzOyMxN9udCWijKEDl1f6g9SdSiXHSBUc15Ds
	 tjZ25M4vQj1tG13Bsgi3b9aF2B7uF8r0jlYJBIeWf3CbhXOWATcdrZwV5IXao1PG65
	 ZnFH1bnNKglZdEFRT0xXnIA7v5T2GeJoedH3ZGLx63Gcfkq7Bqk+u8OeV2GTbzDqr3
	 T6nMI9+4kwpx3tj9d3vFnhukwSL6marEaL/GvzXN1tTE3WMpknLI+5L0doK1+2+TME
	 E44R9suGZs90L/DxfzZGILUL0nsWfTbaLMAOZFva4WRvZymbDln26P6tFG9BNFXJHf
	 bFP870krKrilg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com, 
 yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev, 
 stable@vger.kernel.org
In-Reply-To: <20261008090130.15135-1-peter.ujfalusi@linux.intel.com>
References: <20261008090130.15135-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: ipc4-topology: Fix shift-out-of-bounds for
 aggregated ALH capture
Message-Id: <179145233953.2423942.14804000076383829774.b4-ty@b4>
Date: Thu, 08 Oct 2026 11:38:59 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1172; i=broonie@kernel.org;
 h=from:subject:message-id; bh=d9Db/4xediCepUoxhqgfSWe1Rx8QyBv8TMjk/AVJ0Lk=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLKO90vKL73duPJr6fWa3CMsh7a0xfdLH3JKs73z/3Wik
 bb9iuLbHaUsDGJcDLJiiixxWdwv60ter+E7uLANZg4rE8gQBi5OAZjIlruMDMu+3/62/Mpfa6FQ
 g5vPtT/lzLbzufYnUW2vgwJjmvnVSUWMDGd4q/U1fP5MapjsJN57SWHpF/0Li5kSlateXXM4l/2
 IlQkA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 08 Oct 2026 12:01:30 +0300, Peter Ujfalusi wrote:
> ASoC: SOF: ipc4-topology: Fix shift-out-of-bounds for aggregated ALH capture

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/1] ASoC: SOF: ipc4-topology: Fix shift-out-of-bounds for aggregated ALH capture
      https://git.kernel.org/broonie/sound/c/746de48c3a25

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

