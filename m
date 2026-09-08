Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050EB24A067
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 00:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788828872; cv=none; b=pxgWCJKhWrEOBTvgbnmzI+QvtizmKSMCr//LOOJVLWPSPAUaS3aUu/QTZxBsUa/udV6c+8jeGtGJ9wbFA4kBZjbw58CtAavA2c2SXSqNCjPYWxRRKjJb9MxvlgG7Vo3B9rM8eOUGPlya2agiYgewGHDCTpzUpNlHFHZxarsGq2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788828872; c=relaxed/simple;
	bh=LksKJnHQE6bb+qejJezrmu57AINmrsFUspaYR0UBy5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mST+oOZba7e86AmRZxVYAe1UmHJx8Jh4C+uRWwRwIeEhjpiwBcq8U3U+Pg3rTd829RaAD1iGHXBUUFrhlitiF8x62H8EBpGjHGykqEU0arG/X/KPtq9ttM3r62mpwK4C5Z7HwqoPn7PV3PCvDRPGAbTBpe+Iqlf9cuHusdhFjBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxU0toEy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxU0toEy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3A21F00A3D;
	Tue,  8 Sep 2026 00:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788828868;
	bh=2DzGgHiPMWdmD6NQ0zNcDPxrg3rzn32ed6HqBxjglLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AxU0toEyNzGO28Wpm4CpOTA4bD4fVoI9gyhiBuQFEos/CTFNj2pIKZcYm/NvCK1wK
	 L0lGeU65cjgSC0sWDx5o0O3sBmptEcji2Q/cvXtWdeCu4ntTzRhk4JVjcKESCvqc53
	 xKbzPCds4W6yoDjXo8DDT2GCGVslQonI0eOUxJ4uGM0BkZ47i6aNQ4daE65XDG9L3r
	 OlC49id2+OySnUqPHT0CeFvrLAKQY0ueyA10vpZhnNYwMz7uYkdC5fr27UHtApxZUC
	 uMdk0y9RLpNcgzJphJ6VbmFLGCZTCha4zJpEzpURw3+zFVfxo2N2uLWHCoH2vMsn1z
	 ZgXZPzEo1rxxQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Petr Vaganov <p.vaganov@ideco.ru>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Petr Vaganov <petrvaganoff@gmail.com>
Subject: Re: [PATCH 6.6.y] scsi: core: Fill in DMA padding bytes in scsi_alloc_sgtables()
Date: Mon,  7 Sep 2026 20:53:59 -0400
Message-ID: <2026-09-07-daily-reply-0022-scsi-dma-padding@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907084747.100011-1-petrvaganoff@gmail.com>
References: <20260907084747.100011-1-petrvaganoff@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> When processing the last unaligned element of the scatterlist, it is
> supplemented with missing bytes in the amount of pad_len.  These bytes
> remain uninitialized, which leads to a problem.

Queued for 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
