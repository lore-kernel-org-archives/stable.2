Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794849726;
	b=O6t8JsHWr3S2eqTuW579wB22m9BGfDQXKn0RDE/lPQ3yAVsNDHdDajqmkfsfPv8+Gxm3
	 eO6DhVu3TJJkDru1Xd3bFqGqJcQy0wdH5mqa6RpzcStGHQkW2sozEFe7NZdOA6Tuc7Lnd
	 76FTGkuGfuGW3Sxk/kKkLSr13U7Anvgl9Ip5REo8nyYzQckA7tdI031XvTADNdHHo/Y1I
	 FMskkYn7eEb28GHu3XiPbzzRcuqL90Sg54SpD3fc1HD+B2RkYMQsTSwSHzbZH8AdiNPVX
	 mskZ1DRWs9VazFgt+dxwOVvP0eK9z6Yz1uZyJhC6ENCT1Upyv1DgTVwMUjpU4om3YEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849726;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=O7BgrBkMuexja3njpLbIXe/m63bIjcVrAywZghQs//s=;
	b=MWxPhMgNIjitUOVCjB7/yRP4tVVbm0Td6AgNPxMBPuf8c3YoAAeItjIFanxEvOZle9fX
	 WWMu8pARjjr/fGGXYmfPjDUanKNSX+1pyN8ELwr/C+y+B2+kHBvRnX8RYVYJjAo35ruHf
	 di3F12FLoYs7S7SK2aa13lyymxOCWA3ZbtoS8r1yq8cdyyoe64SfYKVvjRMueDRJbOtqs
	 Nq4wKThz62+yOEWzs3Qmcau39DC8forOsyw1o1fVxEFyCfHd72RgR/G5kgaonwwRySOTb
	 rk8TOngLGSNAZmaXrNCiiNDl1GiuiLHw7cwrMabVX1MDS8i5ZZBmafS9TH26MPb9+1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gwFkmIYL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C839606A31C;
	Mon, 16 Nov 2026 17:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gwFkmIYL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7481F000C4;
	Mon, 16 Nov 2026 17:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794849726;
	bh=O7BgrBkMuexja3njpLbIXe/m63bIjcVrAywZghQs//s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=gwFkmIYLQGHnSsvD4hEKcb5Y/3TEO/MJIBae/UiJnC3M98PdOrXe9U/tC6j2cmeDG
	 gg2PhpI4lwAU3RTKt788TwYnr3LkHftwwtXc76DOyrHtGDyAIzU4yo2Hxzq5fA8KKT
	 ufH1No6fL7yja9ML+j0FU8tettI5bK9EuM3Fq9EAXZ43zegrSSPqxunRQbn2C3HNgU
	 RxhvRvFDcKs2hZ0VuGtSmcBavQz9Gb67jQfQaiH0te05TrGk4+V1C8+uKZzQileXMf
	 fw2jDIOTEm50IBHF1eaNpE0uK64A9n5tra3H+s6qKgr+jVBwBu4gzY4A8KicsQAAtn
	 B/if6/L+pPa6Q==
From: Niklas Cassel <cassel@kernel.org>
To: dlemoal@kernel.org, linux-ide@vger.kernel.org, shao.mingyin@zte.com.cn
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261114015622273t9IBdo0FnDVvP3kTsQiZs@zte.com.cn>
References: <20261114015622273t9IBdo0FnDVvP3kTsQiZs@zte.com.cn>
Subject: Re: [PATCH RESEND v4 0/4] ata: libata-scsi: fix ATA
 PASS-THROUGH(32) handling
Message-Id: <179484972496.2801974.4760709190020871959.b4-ty@kernel.org>
Date: Mon, 16 Nov 2026 18:22:04 +0100
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

On Sat, 14 Nov 2026 01:56:22 +0800, shao.mingyin@zte.com.cn wrote:
> ATA PASS-THROUGH(32) still has translation and completion paths that
> interpret fields as if the command used a 12- or 16-byte CDB.
> 
> Patch 1 checks the reserved bits in byte 10, skips the nonexistent
> MULTIPLE_COUNT field, and corrects the invalid-PROTOCOL field pointer.
> Patch 2 rejects unsupported service actions with sense data. Patch 3
> honors CK_COND and generates SAT sense on completion. Patch 4 corrects
> the remaining field pointers, including READ/WRITE LONG count errors.
> The four patches can be applied independently.
> 
> [...]

Applied to libata/linux.git (for-7.5), thanks!

[1/4] ata: libata-scsi: reject reserved bits in 32-byte passthru
      https://git.kernel.org/libata/linux/c/4136e336
[2/4] ata: libata-scsi: reject unsupported ATA-32 service actions
      https://git.kernel.org/libata/linux/c/22526964
[3/4] ata: libata-scsi: generate SAT sense data for ATA PASS-THROUGH(32)
      https://git.kernel.org/libata/linux/c/bee1c872
[4/4] ata: libata-scsi: fix remaining passthru field pointers
      https://git.kernel.org/libata/linux/c/791ef60c

Kind regards,
Niklas

