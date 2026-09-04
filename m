Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FB64AA001;
	Fri,  4 Sep 2026 13:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788529243; cv=none; b=Ky6bDnT09Gv/eIgiZ9HbjeTsJdfegGkGwFliUMSpTNGqNZnOPgycYnpAZzxQ66pxP5AqZBSeeVPFBkC2EzVTQHlZPerUnX9/FsgwuABsyVD0X5Qen7n36gAg89qPg0onSoAFopDQcl7BTtxLfh0B+rcTCf/dV7IpsRSoBL738DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788529243; c=relaxed/simple;
	bh=ANdPafT8ZSrJJO6g4leyNj64YxEhHDEl6gnKgeHHiec=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dB7D7SKCW91hzbF46WYP0QxficTfDPm/FeebIrX6ggxS4mq2QR1AIHeY8B0EXa2w3WCSgJAhpfH11cMqf4eAuNvB7e+P55V6NjZmRN9H+HrR+aiXHMnXFMuAsW9sfMMGs6E8ONjL6oMXu5rCLvWD8TcQ5yF0tVz64vYTcKHMAM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyNRLXWp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyNRLXWp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2ADB1F00A3D;
	Fri,  4 Sep 2026 13:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788529241;
	bh=w5BleKMYPEzBnvbvt1SnxpNmZhMc1N9txPtpLqhEb+s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=RyNRLXWpz9O5yPxAqpgC1ssktH6LIgjCA8rAGGJdoHxytVJpU2e4CiYNDyi66hFKN
	 16szjn5f0awDmwkPfFX1o9J5jRz07cALR6m0IMZfXWXEoAaKruP5BPfgN7B9omGV/3
	 YhPrGsKjnM8FVeijyhBg5nPG8eijiX3hhSkO9IR+/Fl+cGLbB4GqaEySNyxIgpAMGV
	 r5a3uuuBJQ3oVqR4u0xaXRsqx7Rm9aJy20S6iwLtvqP9dg7N1i8iZdT92Khze9TOaB
	 c1kLeOqgwbkhEgudyW9q7+4iWjAxwIEQcG4g06pLj0sOANpsRxA3puXcvEDupF+4vu
	 EhBkX/ncWxg1A==
From: Michael Walle <mwalle@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260811-perso-rww-fixes-v1-1-5866a70e5d1c@bootlin.com>
References: <20260811-perso-rww-fixes-v1-1-5866a70e5d1c@bootlin.com>
Subject: Re: [PATCH] mtd: spi-nor: Unprepare legacy controllers upon RWW
 wait interruption
Message-Id: <178852923952.3340372.11391066199956007622.b4-ty@b4>
Date: Fri, 04 Sep 2026 15:40:39 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Tue, 11 Aug 2026 17:56:23 +0200, Miquel Raynal wrote:
> All the parallel locking helpers (spi_nor_prep_and_lock(),
> spi_nor_prep_and_lock_pe() and spi_nor_prep_and_lock_rd()) call
> spi_nor_prep() then wait with a killable sleep. If the sleep gets
> killed, we leave the controller in its prepared state.
> 
> Call ->unprepare() in these cases.
> 
> [...]

Applied, thanks!

[1/1] mtd: spi-nor: Unprepare legacy controllers upon RWW wait interruption
      commit: f594a33f9721f08facd98d0a31adc14ff6da9d70

Best regards,
-- 
Michael Walle <mwalle@kernel.org>

