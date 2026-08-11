Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CA22D595B;
	Tue, 11 Aug 2026 06:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786429894; cv=none; b=VwFtZQgBwwnzP+vx0DAhIjv12J9t7BYE6TlPsVE9FaQpqsK2nBHwh61EcpjkBHQHh9+6fjoHrRZ3//hvrGHDRu7q+xqKwvOMaSiEjeE6LuFUVtQUTkEKTvQxinlfpsK4H9eQbzOJQHjYjzFePzkyBDtCzGSOoey0Q8OdSPLU9qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786429894; c=relaxed/simple;
	bh=8LzsLnF1PaqYsnCozWpdZKGrvlEuBVru4xkqBjzsB/4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=aHAOEpjpbMgHmqcBebSOCL+sI1OvsMcrngR9B3DeuhiNmOeCB7T20JTIjV7Jk+jXpNxcTy94S2/8rq/ufFFo+u6sZyXVDGj3UkJlfV2MaZ34+OOg1bIsIjra/MmlEsq4JmXLdfMmdeRnq46mWENZNRSA1l/2/L74ryAAKbe4Xpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4320:1000:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 272BC4EA;
	Tue, 11 Aug 2026 08:31:29 +0200 (CEST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 11 Aug 2026 08:31:28 +0200
Message-Id: <DKLWJLDFA3QD.DW07KLCA2H96@kernel.org>
Subject: Re: [PATCH v3 2/2] mtd: spi-nor: macronix: Restore fallback
 parameters for MX25L12805D
Cc: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <alvinzhou@mxic.com.tw>, "Cheng Ming Lin" <chengminglin@mxic.com.tw>,
 <stable@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Cheng Ming Lin" <linchengming884@gmail.com>, "Pratyush Yadav"
 <pratyush@kernel.org>, "Takahiro Kuwano" <takahiro.kuwano@infineon.com>,
 "Miquel Raynal" <miquel.raynal@bootlin.com>, "Richard Weinberger"
 <richard@nod.at>, "Vignesh Raghavendra" <vigneshr@ti.com>
X-Mailer: aerc 0.20.0
References: <20260605084837.1875896-1-linchengming884@gmail.com>
 <20260605084837.1875896-3-linchengming884@gmail.com>
In-Reply-To: <20260605084837.1875896-3-linchengming884@gmail.com>

On Fri Jun 5, 2026 at 10:48 AM CEST, Cheng Ming Lin wrote:
> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
>
> In a previous effort to drop flash_info fields and rely on SFDP, the
> static size and no_sfdp_flags were removed from the MX25L12805D entry
> (JEDEC ID 0xc22018).
>
> At that time, the legacy MX25L12805D was already EOL and unavailable
> for physical testing. Verification was inadvertently performed using
> the newer MX25L12833F, which shares the same JEDEC ID but supports
> SFDP. As a result, the probe succeeded during testing, leading to
> the mistaken removal of the fallback parameters.
>
> Since the actual MX25L12805D lacks SFDP support entirely, it strictly
> requires these static parameters.
>
> Restore .size =3D SZ_16M and .no_sfdp_flags =3D SECT_4K to this entry
> to fix the probe failure for the legacy part.
>
> Fixes: 947c86e481a0 ("mtd: spi-nor: macronix: Drop the redundant flash in=
fo fields")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>

Reviewed-by: Michael Walle <mwalle@kernel.org>
