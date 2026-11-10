Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794341286;
	b=Yfh2CKuuxCvH0ECy/KdB9satVJ85QYg0aclpISBiYtpcfMloTglgsRjiIDSUl+9VlQFn
	 wYpK2EC/B9aKjxQoLjr5JI1gJnv3EWYeKt/I2VXR8CpKaibVGl9yibe7j4gfRFhTIEdLz
	 Owmi0DCR51eGk4K8ltthcp05dFi77rg27gtsVizVL9S+58/yTE9NuoSutM4c94j0BeF6X
	 MvBCbYB2yZsp6ruTEjf14PbHC+rEqEupNrvg87kIzdVPS55EUH7+knCpaSHQsOTPKY2BQ
	 Xxsa/EsnDAM5LB9vjriTTG6ysMkET6VBltiW3EzxCtGBf0uqe95CaGLwb5xOZJ0VzAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341286;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=vIczeCecLZ2kWfpUkMZRwbldW9KS0EBFk9vG09f13Zw=;
	b=fnI3lRPfcAsdwdCHZNppFQRx9qdHlCcRd87DTJ4VU9CaOO6+HRpbLMbCHhv89Lq2uiuA
	 4OOkXb4ssiIXOaQba5vPrARo7Q2RG2PxpGEpKsM5dJGtslOxwi6Jd34bTJG92Qf8bv4Vj
	 9GH8puPo7bv9h9xJy/ZKCi1fp5E9IECfewpLq2WTnsoJK1Al2IZK0AwaAefbppMslcBGK
	 /2GGbGCjgNE6aJU4SGVVcshIej7Qllc1YcV/KOSdpElidstQfgb8mfyrU+CDTK+rJbO2b
	 6fT5isf4nT93LUUmqNTE4pouD2bzncoVB/+Ys37oHl35wkFCH38tDHHKslT/BBPvSJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=la3kUyv6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B554606A31C;
	Tue, 10 Nov 2026 20:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=la3kUyv6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A941F0089F;
	Tue, 10 Nov 2026 20:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794341285;
	bh=vIczeCecLZ2kWfpUkMZRwbldW9KS0EBFk9vG09f13Zw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=la3kUyv6zB1dp6JNzYB3kSIyNJG6TQc1bCcRfqssfcljTXkkzFn6fZ3oygU25GIa+
	 XP/08oflxf9u9Znp8btDFcPL2LVJOPIdQjKJtoRAhYyYDPaQQx+x3EsiJBIz1M0OzJ
	 /MhTxRnv5UJTtiI1D0gaM0ZI5vO6eGOlXdN01Pwl5ptvM/LPygBgKMGtjkeQHeywVs
	 VDKLwkWZTDevKRerzKEYy0y2fmf3P8kivz4OYD4m1yubiif0ZtQJFt+dvOfPY2WSf/
	 mYmqFjjHk1J5zMmf8RtwyZmCLaD84TjqrgK2SQ68tD5ET1llWMWc5HFsN8M1h4u6BN
	 hw7X/kc0oUa4w==
From: Niklas Cassel <cassel@kernel.org>
To: dlemoal@kernel.org, linux-ide@vger.kernel.org, shao.mingyin@zte.com.cn
Cc: hansg@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261110230327212pqd9rWq5IWa4wD-Ckj5C3@zte.com.cn>
References: <20261110230327212pqd9rWq5IWa4wD-Ckj5C3@zte.com.cn>
Subject: Re: [PATCH v2 0/2] ata: reject invalid DT port numbers in AHCI
 drivers
Message-Id: <179434128433.329300.16375323684839027136.b4-ty@kernel.org>
Date: Tue, 10 Nov 2026 21:08:04 +0100
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

On Tue, 10 Nov 2026 23:03:27 +0800, shao.mingyin@zte.com.cn wrote:
> Both the shared AHCI platform support and the DWC glue use the "reg"
> property of their port child nodes as a port number without checking
> that it addresses one of the controller's ports.
> 
> Patch 1 is in the shared platform code.  ahci_platform_get_firmware()
> uses "reg" as an index into hpriv->saved_port_cap[] while filling the
> firmware-specific port capabilities, so a "reg" value at or above
> hpriv->nports writes past that array.  Patch 2 is in the DWC glue.
> ahci_dwc_init_dmacr() walks the same child nodes a second time and uses
> "reg" both as an index into dpriv->dmacr[] and to compute the port MMIO
> base, with the same out-of-range consequence.
> 
> [...]

Applied to libata/linux.git (for-7.5), thanks!

[1/2] ata: libahci_platform: reject invalid port numbers
      https://git.kernel.org/libata/linux/c/b10c7a1c
[2/2] ata: ahci_dwc: reject invalid DT port numbers
      https://git.kernel.org/libata/linux/c/0f7d0044

Kind regards,
Niklas

