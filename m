Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4856D3ACF14;
	Wed, 14 Oct 2026 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791980951; cv=none; b=rH62/5zJJxxPfJJd2CUfVpv6tv9zVhEZKMkzJJxyhQJQFMrPxIi5czD63mTUVw8FQlEt6Kk7K1J/RxjjF/iImxhgztuOi1142vANKWFg/wMVqayXr7SNFloI1oWsJ2BdCmY/wEW0fiWbogYSj74ui3OL976A8Vc+G2EEVjKKxQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791980951; c=relaxed/simple;
	bh=8V5WBRZu+4QsmvpsrqfcWqEhk6oztuR9t7zuMYE/NgU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FOEksqDFcZX71egQw9bqKc7bQM4m+cbMTNEsieueg0jANjolG4pMEekzmxrH7peL8WEcP73MyUHnczkBp9xtrUQZmIDJOs4CNH9mLDcUNV5RVeXVv1GLnYLG28MLdA7FtpUIcVIicg/JtX0P1UVugRGZap+GxM7okGC9lWh2Cig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xt7892Jy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xt7892Jy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF2E1F000FF;
	Wed, 14 Oct 2026 12:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791980950;
	bh=ou04b0/hFtdaOVEHHTNfPP1cCZvVZf6j4VI84q0WiWk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Xt7892Jy0n6EC0YO2YLdu/mTSi1jgJ/5gXXOwZ2GsnGDO3fS/SmBX/8nZjQs/QAh4
	 1Klb3+ZNTo8HMpvShYos8H7tnn5TE6JRkoj+Eaj4t+QFv5Cile15hu3Wk0w3CrpqvS
	 52Rx6d08+9xMU5fjvc1aB1/dnBY3LCikDiX/hiiR+2ICnSRlaJsS0QnYmNpPzIb0tO
	 urzEY33DSzOsIDAvd4BtUKf3owCPfT5KMh7H9klQ/TjiDr9Rt4C9Qc/JHBeYfrBMCp
	 0ZEQsCYXPl+BKuo8dCThX8XSPkKoxfOhzf47p8ML2GMJ0w41nCGMPGNrEwlRG8xmgX
	 r3rmsw/AIINOQ==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Myeonghun Pak <mhun512@gmail.com>
Cc: Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
In-Reply-To: <20261003030439.599330-1-mhun512@gmail.com>
References: <20261003030439.599330-1-mhun512@gmail.com>
Subject: Re: (subset) [PATCH] backlight: lm3630a: Cancel delayed work
 before destroying workqueue
Message-Id: <179198094807.807209.15203791412466567063.b4-ty@b4>
Date: Wed, 14 Oct 2026 13:29:08 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Fri, 02 Oct 2026 23:04:39 -0400, Myeonghun Pak wrote:
> The interrupt handler queues delayed work to read the interrupt status.
> After free_irq() stops the producer, this work can still be waiting on its
> timer. destroy_workqueue() cannot drain delayed work that has not yet been
> queued by its timer, so the timer can outlive both the workqueue and the
> devm-allocated chip containing the work.
> 
> Cancel the delayed work synchronously after freeing the IRQ and before
> destroying the workqueue. This also waits for any running status read to
> finish before the chip's resources are released.
> 
> [...]

Applied, thanks!

[1/1] backlight: lm3630a: Cancel delayed work before destroying workqueue
      commit: 2cf184caab8b406fdd9db126ee40d62418237456

--
Lee Jones [李琼斯]

