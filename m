Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792656914;
	b=nfymshcfjup7/JpqOPySJM0li7druz1YoFEBR4edkeW//d6pFXt/6hLkIFjG2lMIGbwo
	 b2M+Q5ABJdcIYKOfmxMsH/QF1RmkryiL7+HNI2gvtaaT8HJZ72dOApu4cgbmbSJKL0hY7
	 WUUxpJEF4x7DbRXTEBymfjW90yDhVOfE53sk+8SeIH4NxacjheFlQhVZoteCn/EwiUkDE
	 hJ1smlhuTuCUb1VisXbqhgWmPJY85eQSRQ+VaSw6HTWphmw0aHDjCSstgLDDLubAFCsMh
	 Ziru5ujJGJO9AUXKvRiJB2HujkecUCS0/TZIlIETRGoVduiI0eZDkPN8bCskTPlmN+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792656914;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=wv0Ff/VPdRNNNF3G95aZ3coboS6ciDDZitBRH5mmPys=;
	b=Tp5KTjmniT/cSV7mclfshTwjcYsRK0xnkJXGg/mscoqewfjZUPIsWP1pEJgyXsajt/Js
	 XoOvD6jW5/bnQxfXx3NRNuMUKdan84ITakg8xOM5ISltj/IIKx4O6hq8rwjqCRn3k3gge
	 12ntkTd5Gq2lCdmC2bFrsy8BcR3jGPIBxkxNtZVgYgq8MnKA+J1WRT12gnC0Qg6om+DF5
	 LFITU6DWqkYMylkReHgzLdfizoe6EOG4Q1W3WFKIhmo9xFtAGdJ8j2Vc9QnRjwtPooWT9
	 L5Mv8MScrYitaya89XtE/+tB+OUYTnMDqhjr+XJ8ggRtS5Rqv95sqwTvitzjtIQtdhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y79VFA6z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB44606A31B;
	Thu, 22 Oct 2026 08:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y79VFA6z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9888D1F000C1;
	Thu, 22 Oct 2026 08:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792656913;
	bh=wv0Ff/VPdRNNNF3G95aZ3coboS6ciDDZitBRH5mmPys=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Y79VFA6zA85Aqf5QQhxEMq21HEKLxtuZmPxqfkUZsAwJDoNXsi9gLnLGfMFZ4Wbwk
	 aM8A9Au1jkoqMWCtMwUx2zvDBvX6l5BxARG39Kt5wEGC3jotA4Mg5p2xg2yFtchf4t
	 MbDpg2LOCr2bFCvKr2Csp/BNr2wAdwsdju4YSO1kyuTr9AqDy1LyI3VPLjV5FMwv0Q
	 2rS7eAFyZvVFbDNV6aKE1xTYASlv9+wzoj4X1RZtuFd4qwJBj1gbCefyqtha8op9In
	 j4Nje4lvtqHpo6xu32lNQpZxwUMV6ECj3G+5FXY2pJldJ6CcMGhIXliH27U0ahO9+i
	 9xfbo2yQJoRQg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, 
 Richard Weinberger <richard@nod.at>, Niklas Cassel <cassel@kernel.org>
Cc: sashiko-bot <sashiko-bot@kernel.org>, stable@vger.kernel.org, 
 linux-ide@vger.kernel.org
In-Reply-To: <20261020101107.1449635-2-cassel@kernel.org>
References: <20261020101107.1449635-2-cassel@kernel.org>
Subject: Re: [PATCH] ata: libata-sff: fix race between IRQ deferral and
 ata_sff_flush_pio_task()
Message-Id: <179265691236.2226585.17128547417966363667.b4-ty@kernel.org>
Date: Thu, 22 Oct 2026 10:15:12 +0200
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
X-Mailer: b4 0.14.3

On Tue, 20 Oct 2026 12:11:08 +0200, Niklas Cassel wrote:
> Commit 4a2e5409472e ("ata: libata-sff: don't busy-wait for PIO data-in
> command completion") allowed the interrupt handler to queue
> ap->sff_pio_task from ata_sff_hsm_move() when a PIO data-in command is
> still busy after its final data block.
> 
> ata_sff_flush_pio_task(), however, was written under the assumption that
> cancel_delayed_work_sync() is enough to prevent sff_pio_task from being
> queued again before the HSM state is reset to HSM_ST_IDLE and
> sff_pio_task_link is cleared.
> 
> [...]

Applied to libata/linux.git (for-7.4), thanks!

[1/1] ata: libata-sff: fix race between IRQ deferral and ata_sff_flush_pio_task()
      https://git.kernel.org/libata/linux/c/69be7709

Kind regards,
Niklas

