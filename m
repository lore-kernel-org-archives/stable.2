Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFB34A8A2E;
	Fri,  4 Sep 2026 13:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788529238; cv=none; b=d3zFiW+TSlM6PoHWtG14vw/ZcGBmLWgfOzddopboFVzk/Nj2iEhoQaHo/mXZ3/YGb5gexnkWzIT+eTbiJ1sl7Z5+h0kC4Lje8SHbbIFrVLmvHrcZey4QXUh7y5KgvxPfbal7PLRtmn4ELb5WtXSOol66kOs8C1hW8fY1q0T1txU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788529238; c=relaxed/simple;
	bh=BqXkFmr2BFmvprEIenjqZoQHObgtMMV0RDJ1nAP08Q4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oohKjRQ7ELmtj/uvajaEISAc3wEuUE/fLNNbAEfmtcE4fC2M7tOg3FRYpwXN84mgM4vPCKDjBLs0dpAD2zMqjn4TTat1vtVdk7ZUOZYKk2XJP8H2Ht/YraNmtp/3/U/2TI1WFLvtX/U4Kh2SAX6l4GvNLWjgoxfqGpYENvMVUE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijU2MkHx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijU2MkHx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB291F00A3D;
	Fri,  4 Sep 2026 13:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788529237;
	bh=xTPV7lTpc7c2c1AVQyRzJ8VBjOgJlpzZPhcxPzeE5iU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ijU2MkHxl8Hr0e4IPPiedEvNTmWsoUO7MnI2tsbq/cw7NuYbtVOEAxVrDetrE+10s
	 aLeppAXf4eildOCH41aPRyIrP9MwY19wvRF+uf/OLj++WUHWV4jMdW9m/6lQ3FDRJu
	 77eb5xT741kR4WxQ/bBUVCvvYZji63A+C5iXNWAOVLum0sg+rjk8XHDkddbEo6JyCz
	 N0qsJYhPZvtt0zdJvDzzs31tjVVmtV5bw0KNgYVJtMYQLCpSsbeNr9oUJGSJ2sKbr/
	 hBsyTHXKiIVc6eQq+2wP1pFCqcK+y450gBHYSYA226B1mC2kE7B/I6Wp4pu/P15dNo
	 DRTi3Q0nzC9zw==
From: Michael Walle <mwalle@kernel.org>
To: pratyush@kernel.org, tudor.ambarus@linaro.org, 
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, 
 HyeongJun An <sammiee5311@gmail.com>
Cc: takahiro.kuwano@infineon.com, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260720141104.2054417-1-sammiee5311@gmail.com>
References: <20260720141104.2054417-1-sammiee5311@gmail.com>
Subject: Re: [PATCH v2 0/2] mtd: spi-nor: sfdp: bound two optional
 parameter tables
Message-Id: <178852923504.3340372.1775017146035395867.b4-ty@b4>
Date: Fri, 04 Sep 2026 15:40:35 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Mon, 20 Jul 2026 23:11:02 +0900, HyeongJun An wrote:
> Two of the optional SFDP parameter table parsers size a buffer from the
> table length the flash reports, then index it at fixed offsets without
> checking the table is long enough.
> 
>   spi_nor_parse_profile1()  reads up to DWORD5,  never checks the length
>   spi_nor_parse_sccr()      reads up to DWORD22, never checks the length
> 
> [...]

Applied, thanks!

[1/2] mtd: spi-nor: sfdp: check the length of the xSPI Profile 1.0 table
      commit: b9f34a95a81021fa1f3c9cb8cfd458e66824cad6
[2/2] mtd: spi-nor: sfdp: check the length of the SCCR map
      commit: 1413f38f37194673502e61cd3749e091c031370b

Best regards,
-- 
Michael Walle <mwalle@kernel.org>

