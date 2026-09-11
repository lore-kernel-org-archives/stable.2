Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73C32D7DDB;
	Fri, 11 Sep 2026 13:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133120; cv=none; b=sfEXG7YRGGViwCrRW7BXuIvCVcddGya5lqViRaKmG6+WJ349wPYt6YwRI9HMfodumVEXnqPeQtGVntGFzPeXcJ1KdA28uHrgbSNx/zGxuCw40UFLaWpFUz0x7xKtBSqlcZsdMVIOKydfxFTcP5Mikz3fR9YBvXkqwpfydVYfjRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133120; c=relaxed/simple;
	bh=gosTHAsezkL+8XRcGLxbtaEUkJOHXo01SecIDcSq+a0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dcggHu9uMziyFDxInRVi0Qb1lOzxDgSu4FraslB1BzLLZg55PwwcYNUrq76pvtGrw0wHPuuwtGu+9MBJFrZp1Bj7mDJ6QknoHZNEoS3H1ZyZfqilG2dxbVJhjpUbwW0KhXFOcWC/5/qRjRxPODUF9nSBO0pDmUpRmnOzWzqoe6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsDH3hpu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsDH3hpu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E081F000FF;
	Fri, 11 Sep 2026 13:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789133119;
	bh=K4Ldxi/ZlTGjQ6moA2LIJ7Z2SgM2eFjuTQuvrL/U/wA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=AsDH3hpuHQm8QJOBSEgX9+/vhDIlwBRv91bpb6n8jrUELTQI+hzl5KqhZdLR9hSlM
	 r3cZ1OxGbahXrJVWc+cksRpRICcQ+faTtJDLr9FWCvQ69bAIUH09vpMubmqUjdau7a
	 FZHqTci5oPVLNoRhdmvsHa0L5N9bS2A53UESqFJnz2hRWPbmQmmkowCF+sxecZqIO5
	 P7vJppFqblTERVyqYwfKXYSg3TBfKNG88LIq1gF2Mr6vJTqkO3ItxdGXGMlkWX/AF2
	 8xQTbG/Sqw62Jqeze4ZGz5xm6SBhMAUYlWZB3JHdukuCkUwX04Lmxy2/p3qGvArd79
	 0TiO/geDyVT0w==
From: Michael Walle <mwalle@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>
In-Reply-To: <20260827082656.2772784-1-runyu.xiao@seu.edu.cn>
References: <20260827082656.2772784-1-runyu.xiao@seu.edu.cn>
Subject: Re: [PATCH v5] mtd: spi-nor: core: Fix mutex leak in
 spi_nor_rww_start_exclusive()
Message-Id: <178913311701.1915651.4791624215787396187.b4-ty@b4>
Date: Fri, 11 Sep 2026 15:25:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Thu, 27 Aug 2026 16:26:56 +0800, Runyu Xiao wrote:
> spi_nor_rww_start_exclusive() is used as a wait_event_killable()
> condition. When an RWW operation is already in progress, it returns
> false while still holding nor->lock. The wait condition is then retried,
> but spi_nor_rww_end_exclusive() needs the same lock to clear the RWW
> state, so the wait can deadlock.
> 
> Use the same guard(mutex) pattern as the other RWW helpers so nor->lock
> is released on both the busy and successful return paths.
> 
> [...]

Applied, thanks!

[1/1] mtd: spi-nor: core: Fix mutex leak in spi_nor_rww_start_exclusive()
      commit: 14dc3dee0efd18a7b85ba59879e7e217c7c6279a

Best regards,
-- 
Michael Walle <mwalle@kernel.org>

