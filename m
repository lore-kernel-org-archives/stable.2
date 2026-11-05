Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793855911;
	b=uIzBhaMjlzER462ACNwRXgSTX60T96dwzb/h08GpM/0tdAIU14JmMuoR1BJIPhtsXVuo
	 0yQ2rs0q65GVFU6sw0e2TtTKpEoEKTReUfldzBND0Xys3LSDsEjKOzZm4dtNzdkw7FQKF
	 OnBEC+9yFM6yNbWXqtAsCRL7YIKW9jfjaXP2wSMc+yoIf/aZtAxSf/E9z8xjm9biE3Va+
	 97NfztNnvP48zqfaQC1Sct1T4GK16x9Um29hcuMheWhGWJeHL/R8cZvlYmH8VSIrYYxr6
	 x+dF7T4vdODjr//9KvCNF+mHlV/hOF1BAAx55jGb8QacEUu9WicSW7JL7ZM0LfghzIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793855911;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=+8q0BMvB9wWUz5f3EYAzIeMUb+gnozsdbkCnoECk4mc=;
	b=QOHJrC3iaO7fhaCbBujNQSbXLEQlszNWcg2PXCSob5BeLS8YorbM+NvXWAEdJbU1++Fw
	 qgujmmrTAd7EUdBUZX8zz26ns0sOAn3qAhXvG//zFZEeExuZmjQejMDFDEAiQHMIXug7h
	 sAW0cnsKQFx6enln9Fg7cJZ3Xlqx/StBAvf5q1Yb6NHK4I5YABcXKnD1VW2BAumQDiscF
	 QE4fdXrmsTozifn/efrYPcmEHfu64HtMPBzEMQcs2OEuuPD5DCEK0qz26nrPcEY7vVMvJ
	 sxkUwpxfzJMkQLjDW54VHFnSjWtuMGkMDTPA7UdBqa+1BaLycGVI7RIt5CrUXx/Virw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codeconstruct.com.au;
	spf=pass smtp.mailfrom=codeconstruct.com.au;
	dkim=pass header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Kh3y7Xy6;
	arc=none smtp.remote-ip=203.29.241.158
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C03A606A31B;
	Thu,  5 Nov 2026 05:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C03A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Kh3y7Xy6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1793855907;
	bh=+8q0BMvB9wWUz5f3EYAzIeMUb+gnozsdbkCnoECk4mc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Kh3y7Xy6tZVSiGt/8Es7VfOUi/arBd5FRbyFObIdv6Iiq6PPE8Ipb5wD/3A1B5YDB
	 jVC65cPMNvPDYZ9I7gkMppRVGCjkGLRRk2Q8Rut8QPRoZ97316SO0eNKVyl/6s3D0/
	 W/lBZC+hy5iIdqG6iMyiSDCQ/yWYBAZtNeLYaFwsmQw/X/Iw/nv3CBz0U2fhj92UZC
	 hp2LQKsSf9ylwKPVwnzrnLtIwGKrxNy95syFEE1QtZlsL1jEpTCOeKw191U2cLVbX/
	 rs3XBp6jJ1cc59t0iTHQlP46QweFyhZFYwpaG5QkwthHluMcomrhgQjD1p4ymDwmTC
	 U/dn18Hc4XOaA==
Received: from [192.168.68.117] (unknown [180.150.112.139])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 3446C64698;
	Thu,  5 Nov 2026 13:18:27 +0800 (AWST)
Message-ID: <3c6f78a78dcea12e97b62f8a65c0248f023bbc64.camel@codeconstruct.com.au>
Subject: Re: [PATCH 1/2] gpio: aspeed: Clear only the acked line's G4
 interrupt status
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Billy Tsai <billy_tsai@aspeedtech.com>, Linus Walleij
 <linusw@kernel.org>,  Bartosz Golaszewski	 <brgl@kernel.org>, Joel Stanley
 <joel@jms.id.au>, Ryan Chen	 <ryan_chen@aspeedtech.com>
Cc: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Aaron Antone <aae@amazon.com>
Date: Thu, 05 Nov 2026 15:48:25 +1030
In-Reply-To: <20261104-gpio-aspeed-irq-status-v1-1-9805645f856d@aspeedtech.com>
References: 
	<20261104-gpio-aspeed-irq-status-v1-0-9805645f856d@aspeedtech.com>
	 <20261104-gpio-aspeed-irq-status-v1-1-9805645f856d@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, 2026-11-04 at 11:58 +0800, Billy Tsai wrote:
> The G4 interrupt status registers are write-1-to-clear: writing 0 to a
> bit has no effect and writing 1 clears that line's status flag.
> aspeed_gpio_irq_ack() clears a line's status through
> aspeed_g4_reg_bit_set(), which reads the bank's status register, sets
> the line's bit and writes the whole value back. That write clears every
> interrupt pending in the 32-line bank, not just the acked one.
>=20
> aspeed_gpio_irq_handler() reads each bank's status register once and
> dispatches the lines that were set. If another line in the same bank
> latches an edge after that read and before an ack in the bank, the ack
> clears its status and the handler is never called for it, so the edge
> is lost.
>=20
> Write only the line's own bit when clearing the interrupt status on G4.
>=20
> Fixes: 79fc9a2fcc45 ("gpio: aspeed: Create llops to handle hardware acces=
s")
> Cc: stable@vger.kernel.org
> Reported-by: Aaron Antone <aae@amazon.com>
> Suggested-by: Aaron Antone <aae@amazon.com>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
