Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795177597;
	b=JcKiNSA9I981ppZvlxn/RxgpVZM7IWRG3PbhO5cJrmhSI6tXKLybZohAzk+mIt7nTaoq
	 hyh+8MEEZl4xdoGW743/3dEOWbvxGr6ao/mWHljskexyKqiD5OyrxX+M9SSFku6lUxMrX
	 nRC6sFhJenRI59TzDvKVrPImInBJcnvSxAQNbI+wvJT6k2CgKUS5RyPJVayjMFsutiWJW
	 3Qtxs7vvVX+pP9AbFvt3iD1DAfaytW+WZtGqe4Pmdxe0qh9+l4LEzJHTInfA+eKjiuySb
	 uRYQDIvL2Wqt+sOtYI0xVAXZ3hlxi5KNI1JgBCtjv+z8chutm00tUyBc82tfkNjf9cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795177597;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=I3G768SLhqBwcqMXJfbPX0ci4T8MgwSXdL6Wve6YoBU=;
	b=uqxqG0KdcdkifqRSnSLBcf2YAKeINtxHyfgjR3QzrDOUPW78bx/YFqyuQgoyx+UUIkBK
	 V8jeMHsJ0qjPM7qn2OH/s4r/gcA27yCG76O4cwzSPJKTGnKiAdcLNBJncReZ/o8X1SIJN
	 KYYlREUdj3na02xjiyF9F/pfcaz/kW+E5pLArFmXP6mTaV76JYlsVCyr2Qd1D1Tx/aHSr
	 B6Aw7w/6ICPw78oGZHSGj4eN4a3LE00nCJseJnhhF29oGm9CyotXmZ+yRwLiqqpZ/T+Wl
	 pHrb7OU5n2F1c0k65ZGSH24t4NNJS998zlp3PJ9JPa9xEdFsB60uMYkQAAkLKy2e1AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TKcab7C1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E02606A33A;
	Fri, 20 Nov 2026 12:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TKcab7C1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB12E1F000C4;
	Fri, 20 Nov 2026 12:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795177596;
	bh=I3G768SLhqBwcqMXJfbPX0ci4T8MgwSXdL6Wve6YoBU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=TKcab7C1R9cGiTnawXGCIuQ4YfvOE8xeZpbqHAh8PRhcxQDF/zSOOT9ntUkuCTOAZ
	 2anxMbpo3Ok8rAZmg2et4tx8PaHSkQ6LEb3DbFhjefmIVXdwRy1z7yCMyMzSESwNmr
	 E0vf+bjVfGT45e6Q+lBkkkeNA6uvtAZhfRjrx7LyGXSRFKvLrf+PwmKeIGeUQv3Iem
	 HaN660JjvcTr3hLRC+pTEW+Wvs9buXOa2LtpFEtjZZw/pyQZ0dT4/dd+mCTnvYku4o
	 7+zhkU+gdMgpR+QyR4SrAPBEGlypiLqSkrVhdTQns4i24mrtp2/uh8UebHq7l8uxgv
	 zrQn7c/fLhwMg==
From: Michael Walle <mwalle@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 haibo.chen@oss.nxp.com
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, michael@walle.cc, Haibo Chen <haibo.chen@nxp.com>, 
 stable@vger.kernel.org
In-Reply-To: <20261023-spi-nor-fix-v5-1-bb6e0ce21169@nxp.com>
References: <20261023-spi-nor-fix-v5-1-bb6e0ce21169@nxp.com>
Subject: Re: [PATCH v5] mtd: spi-nor: clear the default read_sr2 opcode for
 Octal DTR flashes
Message-Id: <179517759444.1010165.14064662323338062426.b4-ty@b4>
Date: Fri, 20 Nov 2026 13:26:34 +0100
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
X-Mailer: b4 0.16.0


On Fri, 23 Oct 2026 15:11:54 +0800, haibo.chen@oss.nxp.com wrote:
> The core defaults opcodes.read_sr2 to the legacy RDCR opcode (0x35), and
> spi_nor_cache_sr_lock_bits() reads SR2 during spi_nor_init(), i.e. after
> the flash has been switched to its runtime protocol. On an octal flash
> running in 8D-8D-8D mode the opcode is extended per cmd_ext_type (e.g.
> 0x3535), but RDCR is not a valid register read there: these parts access
> their status/configuration registers through a vendor-specific indirect
> space, if at all. The flash does not answer, the register read times out
> and probe (or resume) fails (on i.MX FlexSPI: -ETIMEDOUT and a controller
> WARN(), seen with a Micron MT35XU01G and a Macronix MX25UW51345G).
> 
> [...]

Applied, thanks!

[1/1] mtd: spi-nor: clear the default read_sr2 opcode for Octal DTR flashes
      commit: d4d6fbd84fe7cb60f8fce048dbb8362b69704078

Best regards,
-- 
Michael Walle <mwalle@kernel.org>

