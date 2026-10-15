Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2B33B19DB;
	Fri, 16 Oct 2026 09:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142863; cv=none; b=YBFT1zjWo3zaBobnkbW1xbCB58SHb240SVddrSOt83IBsE6Qvq2GyHOeWgJoMuNM0YNJf3TQ9t/o4ejmvIT2I5iDQISUN3Si9s/tu4FA/4t0a9RPNtB2GNYnHSvpqObVsI7HR+h7S801SI7mp8hJ/282OHLiQxLa79ixnn7ZNGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142863; c=relaxed/simple;
	bh=2GcCkbDtjmJmTyvjuqfSQkMp+rO2qm9Cayw7Zd8Iny8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZEj3qbC6MKizdGnthkcBST/EkOjsmxVVWAAgw7qPTCcsBl18m38e8CPPLziThEbUSK5nxU5N1fVVtAETelSAUJwLcxx1XC2uyMv2h4f1Lkld2tvFpLtZt0ggKNbhepRUWNK0yHyB/7Q9Zzf6yF3+Y7csh3CgjBIcyGooi2MJGg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpW2MS1I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpW2MS1I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F4E1F000C4;
	Fri, 16 Oct 2026 09:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792142862;
	bh=t5j0CRAvq/NI8o02TRYMRZeQXMG1lexbhlVmNwP3IlM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=WpW2MS1IcYZ812L9mpZpxlHfW6ezLfsP2Gb8pSVDWkVBvyVDA/cYBPsRHK/dq71BU
	 f3TMS3sVjgZVdyFp1iii22SxQOAom3PGpdsxPAYMOdFiMQzVlYW3D3DK6OP7AP3Odr
	 FzdEoSB06pXt829WYvAALEFED1R4o8goCoqJLAUPPEUmOFiYqqB0ICmPqePt3BzlQk
	 dHqpk+Nf77kESB8zJAwXTJa0vNDCNKindUftyL8MgdJuJOUr4GMlisqMArSSrG0p2M
	 Nv79EhWMaJ4Gqf6wypEWuCmGdQV3dRH5CKB4PJ4c7W5pN6qOqnZg/QZrqbY855dvgJ
	 PZSU1ZE8EGeDQ==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Raju.Rangoju@amd.com, 
 krishnamoorthi.m@amd.com, Weibin Liu <liuwb@xiaopeng.com>
Cc: linux-kernel@vger.kernel.org, sanju.mehta@amd.com, 
 stable@vger.kernel.org, Guanglei Zhu <zhugl3@xiaopeng.com>
In-Reply-To: <20261014-spi-amd-fifo-fix-v1-1-9fec9ab753e8@xiaopeng.com>
References: <20261014-spi-amd-fifo-fix-v1-1-9fec9ab753e8@xiaopeng.com>
Subject: Re: [PATCH] spi: amd: fix len==0 underflow and FIFO overflow
Message-Id: <179210311701.134795.14035717437104935583.b4-ty@b4>
Date: Thu, 15 Oct 2026 23:25:17 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1108; i=broonie@kernel.org;
 h=from:subject:message-id; bh=2GcCkbDtjmJmTyvjuqfSQkMp+rO2qm9Cayw7Zd8Iny8=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLIuvuNmZYq80CJ2PyPk+N1HF5SN/eVb9HLi1Ewcjvd6C
 MVMVz/ZUcrCIMbFICumyBKXxf2yvuT1Gr6DC9tg5rAygQxh4OIUgIm8z2H4xfT2p76oBWN3xQIe
 hmC5aL2Cqx3PJZzZetaEqfrumu14n5HhdW7rTpNdjjZ2Cebtsk8TzLWPfqtgmsiS0b+/sut/yDt
 uAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 14 Oct 2026 20:39:13 +0800, Weibin Liu wrote:
> spi: amd: fix len==0 underflow and FIFO overflow

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: amd: fix len==0 underflow and FIFO overflow
      https://git.kernel.org/broonie/spi/c/e2f4edfc061e

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

