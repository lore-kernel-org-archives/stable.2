Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910271;
	b=uzVTKKpmmtbWmK1M6Ot2ZfuhryQW7x5gPvtltFWrQY3z2fm1f9zGZkvMLsIfp4KmAOCh
	 vw5qnGVCOMu4bBu6+91A7MSTITJxFIj9mTizVoGhOxIWjd4R//pQkDP51EG+FgCaODDn2
	 IFnPuku9KPO6+1X7Ey3SzgM4hevXZFVCxb+1pHTUXNVtynd1G7MYe4qdFeYt4amLpdQ49
	 eSq2Bg35EbPnUbjLI7oLNS559I5SveaEqEbnyrqgbSU5NEG/Ykb46CAC9uyWRWdoGR+ru
	 Fvw9H8kLZ31MIEHsz7l1iPFESDBZnTTGqlwjs7PiaMmcSbjmp21kqWTUd6CzNgAx93A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910271;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=Ppgm30tM3fo+UP/xYYdNk73qtDaf+xuOrqudiGSPRBM=;
	b=OL7J174BwLJV4JwMb4Ct9g3t8+YUwJp6aTdd9ZC1LTg4LRD6rkkNeYPkhx4XWE5qDr3l
	 bDfuvOzu6olDjZg3GROutiHSZGjMQSjT2Z1QdX8woCDvNCszgnnG1w9AbsZm1IKBUDIXe
	 lnxpU9Kxq/NTZvKvTj0haYu2p+vZ673cFPQ1rH2cyyJ++Xq3M4hiBe1E2QsHRpQPCY7ay
	 T9RURJyCk+hDmCPOQJq0FrRaYYd7d4oq5wfA8ndnT5+bGHc9wxLjWyekWb7mkkqPNvxVD
	 eGRk8+pI7BW88jfPmtjAA2TyhT0okaaTnVoU2Y7SAsrf0GJI8n1hBBbQxDO8VvzEIhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DzDpiCNP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1AB606A329;
	Tue, 17 Nov 2026 10:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DzDpiCNP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128EF1F000CC;
	Tue, 17 Nov 2026 10:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794910271;
	bh=Ppgm30tM3fo+UP/xYYdNk73qtDaf+xuOrqudiGSPRBM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=DzDpiCNPxOOtzq9FA/PkBBMzCYCmnmd/dxFyzfUKtXlyYmS+H3cldSa8raPhVZz1L
	 Tl75c+eIt/dOsajgIJhbGQud29igKk/aFnL8TMBzgbMp6pElXwoofGhHy3LWxBFX2J
	 0i64rTpVdfBv4NO3L7rh0w5Dw2BaGsSmX6xj3i/Dmfuju65BKyM4W4ActZnzHWG0aw
	 P3ZUvz+mRQs7qxb8Wi6bU1REJa5q8QuOlmOBtWVQ5S5ebnP5osrv1c9/xxJZxe9VPT
	 rEwDrWUUY9iA60Q0BZRQ3LrvKL+luEBx5Vgip5iRzYtKc2zoryomizpTUBsny+Twil
	 sya+3VVzANrkA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261116191008.2954277-2-cassel@kernel.org>
References: <20261116191008.2954277-2-cassel@kernel.org>
Subject: Re: [PATCH] ata: libata-scsi: fix the INC_512 bit test for
 SECURITY PROTOCOL IN/OUT
Message-Id: <179491026977.3156950.15099204028645966141.b4-ty@kernel.org>
Date: Tue, 17 Nov 2026 11:11:09 +0100
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

On Mon, 16 Nov 2026 20:10:09 +0100, Niklas Cassel wrote:
> ata_scsi_security_inout_xlat() tests the INC_512 bit with cdb[4] & 7.
> INC_512 is bit 7 of byte 4 of the SECURITY PROTOCOL IN and SECURITY
> PROTOCOL OUT CDBs (SPC-6, tables 280 and 282), and bits 6:0 of that
> byte are reserved.
> 
> Test bit 7 instead.
> 
> [...]

Applied to libata/linux.git (for-7.4-fixes), thanks!

[1/1] ata: libata-scsi: fix the INC_512 bit test for SECURITY PROTOCOL IN/OUT
      https://git.kernel.org/libata/linux/c/e2954988

Kind regards,
Niklas

