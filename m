Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599095;
	b=zwYJ55Oz3iFuEPDj9deSSnaWSj2To66klpuOMh3VhPQkT69OVzJxCF1lmQaNJx8OpBvp
	 t/YE3e4Z2EiLyxj3hn4B8JiVhhIcTINyK5R0EjdrtnIx7LWxqqcp0b4v4g+2zEOiiSI2E
	 GctKWzOdZZcvU43FqWth3ldyqU/0bo4QyYHtLOgaSnQwzlHsH5BeAD+pbuTttgpEg27CM
	 NMhmRXJjgGF00mPcajGLsDW8PCb5p0fyunBdB1hnTY3LySebHJS0iWcAuIlCNQDJ19oxr
	 j0UWByr2/IAKmPe/j1ahE6U2OxAgQXFQ+DCX8ywn0upCiGq3I/uDXyB9lpN2+aypL5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599095;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1hkKlKtceu81xADzhfc6vL02oI6BthsOy5fKPWsZIJY=;
	b=P1v5s54GoPYS0IKPZk4eejFmX7zaGVf1IU+vNGIWmUHR+pWKSwPQ7Ws6M85Ca/4EhoVc
	 ckjYLxn1tUSXHZ3P22FJCM1EDfNKw0k8zlRZPw/p3mqatVrZm7FY4IYBrj4nWcmGTXCRD
	 wAQlLPsxnVXSpYXrWTN8wWCTYUXysK+cd0fUy6aVNoCXnwsL8MF0o4SXTBKZX3NvKA4qo
	 EkCf7HFw7aA9fnGhTXwfRIC64ZQiGPmJKkaPfLhdf89l9NBXIR5Ltb7u+Ehy/HwD/fDKy
	 1NNUVWKPlADok/E9rAAtRsjC+JLvA/OQaX2mEH2r6FyUAJivExYVCZDT8pqLpYfjfaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SS7fNEgw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4C4606A327;
	Fri, 13 Nov 2026 19:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SS7fNEgw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC841F000C4;
	Fri, 13 Nov 2026 19:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599095;
	bh=1hkKlKtceu81xADzhfc6vL02oI6BthsOy5fKPWsZIJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SS7fNEgwUqd1R2B9tl+Jsq6VRDy/KSQ8d9QpdRorn9pOyrhKuD7PVpZb4cC+48V0z
	 MWsAethHGASwiCBySmTsCnwLHhKOJ8rLMG/RAQgr25gefz6TWFxO+z8JM8uk8DCReu
	 v+firPudEiRWUECH9CD6WBvOhBTXqNnNzLy5LL48kayJqgNTTAGTJTlwbkmTzHn1Aw
	 hSqZ4HpgQch2TtsofFyLpz41nuuPoWiOElN3PPrzwtRfYJyw4nWeJXuyDSaZmwAQXE
	 c2Nr8GRpyVLXMLbrQhZ92A5UJ0AvbXhVeKgi8idNM6M63fm0gFBhxj/Ulhu/s6pRiF
	 BAglxN2hG+U4w==
Date: Fri, 13 Nov 2026 19:44:50 +0000
From: Lee Jones <lee@kernel.org>
To: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v5 0/9] Congatec Board Controller: Add storage devices
 support
Message-ID: <20261113194450.GM6323@joneslee-macbookpro.roam.internal>
References: <20261103-cgbc-i2c-storage-devices-support-v5-0-ac11f23fae51@bootlin.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-cgbc-i2c-storage-devices-support-v5-0-ac11f23fae51@bootlin.com>

On Tue, 03 Nov 2026, Thomas Richard (congatec GmbH) wrote:

> In this v5, I re-ordered a bit the patches to fix I2C bus names first.
> I also made an error message more user friendly.
> 
> Lee, this series conflicts with some other ongoing patches series:
> - mfd: Assorted resource lifetime, teardown, and error-handling fixes [1]
> - mfd: Constify mfd_cell arrays [2]
> 
> To make your life easier I rebased this series on top of them. Please let
> me know if you want to proceed in an other way. 

I think these are all applied now - less my I2C patch, which you are
free to collect.

I'm ready to apply this set.

Does this have to go in as a set or are the MFD patches orthogonal?

> [1] https://lore.kernel.org/all/20261027093306.2812695-1-lee@kernel.org/
> [2] https://lore.kernel.org/all/20261030071137.100954-3-krzysztof.kozlowski@oss.qualcomm.com/
> 
> Best Regards,
> Thomas
> 
> Signed-off-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
> ---
> Changes in v5:
> - mfd: fix error message in case we fail to get session handle.
> - fix I2C bus names earlier in the series.
> - Link to v4: https://patch.msgid.link/20261002-cgbc-i2c-storage-devices-support-v4-0-eb42e0f1df59@bootlin.com
> 
> Changes in v4:
> - Fix struct cgbc_i2c_platform_data comment (kernel-doc warning)
> - Move struct cgbc_i2c_platform_data from linux/platform_data/i2c-cgbc.h to
>   linux/mfd/cgbc.h
> - Use MFD_CELL_NAME macros.
> - Link to v3: https://patch.msgid.link/20260911-cgbc-i2c-storage-devices-support-v3-0-594b53fbc5ea@bootlin.com
> 
> Changes in v3:
> - rebased on v7.3-rc2
> - use PLATFORM_DEVID_AUTO for child devices
> - move I2C bus and I2C device definition in the MFD driver
> - Link to v2: https://patch.msgid.link/20260811-cgbc-i2c-storage-devices-support-v2-0-3efa998e0ef5@bootlin.com
> 
> Changes in v2:
> - i2c: fix typo in CGBC BIOS EEPROM label.
> - mfd: make cgbc_devs const
> - Link to v1: https://patch.msgid.link/20260804-cgbc-i2c-storage-devices-support-v1-0-fed38510671c@bootlin.com
> 
> To: Thomas Richard <thomas.richard@bootlin.com>
> To: Lee Jones <lee@kernel.org>
> To: Andi Shyti <andi.shyti@kernel.org>
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Cc: Werner Gartner <Werner.Gartner@congatec.com>
> Cc: mfd@lists.linux.dev
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-i2c@vger.kernel.org
> 
> ---
> Thomas Richard (congatec GmbH) (9):
>       mfd: cgbc: Fix use of negative error code as valid session handle
>       i2c: cgbc: Use real I2C bus names
>       mfd: cgbc: Add I2C platform data
>       i2c: cgbc: Use plateform data to get bus ID and adapter name
>       mfd: cgbc: Use PLATFORM_DEVID_AUTO for child device registration
>       i2c: cgbc: Add support for fixed frequency buses
>       mfd: cgbc: Add virtual I2C bus support
>       mfd: cgbc: Add virtual storage devices on the virtual I2C bus
>       i2c: cgbc: Register known I2C devices on the bus
> 
>  drivers/i2c/busses/i2c-cgbc.c | 108 ++++++++++++------------
>  drivers/mfd/cgbc-core.c       | 187 +++++++++++++++++++++++++++++++++++++++---
>  include/linux/mfd/cgbc.h      |  16 ++++
>  3 files changed, 244 insertions(+), 67 deletions(-)
> ---
> base-commit: d3dfdb6b429a5b99bfd47176bf07cad0956f14ed
> change-id: 20260717-cgbc-i2c-storage-devices-support-b3ee7cea3320
> prerequisite-message-id: 20261027093306.2812695-1-lee@kernel.org
> prerequisite-patch-id: 7d50ed21b2d5d1bb25290d19c46b4668073feddf
> prerequisite-patch-id: 45cdf12f5527ab86a560ba98c02cc447bf6eee4e
> prerequisite-patch-id: 6148da531ee7713f8afb7bec90fb3f548b562d28
> prerequisite-patch-id: fb0c30c409ef451192973c417a0585f989f8917b
> prerequisite-patch-id: 8403fcd8efcd44138f139767624773fa654a5a2f
> prerequisite-patch-id: 434546741519ecd3032e19f3acf2c5370e9a454c
> prerequisite-patch-id: 29540ca5739d6f6f3e2d3fe5b87893ad31f6c3ee
> prerequisite-patch-id: a33adadb2e2efe82d2a14417c1c35c579bf212d0
> prerequisite-patch-id: dd53f1e6db35d71b51061dad45de28dde9ebc70f
> prerequisite-patch-id: 85a1da1285d64ce3fc78c8ae7969fbb0dc7c3cd7
> prerequisite-patch-id: e9b952ebc380d058ac2144771c780a0b08c3b7c3
> prerequisite-patch-id: 1f0dcc7a8c5df7ae1c8bfb5a1c8f62b441704286
> prerequisite-patch-id: 077a4ef70d74321711e2efd4e016e01a1d41c818
> prerequisite-patch-id: 4dcd6cc156bb6ba43684605972fb179557a3891e
> prerequisite-patch-id: 62e87491674feaae09327a99a5ff1b4ed368f221
> prerequisite-patch-id: ab1eac435fd40cdb3d9a8d453a12852a105f57c4
> prerequisite-patch-id: 1cbcc3b666db27cbe9f3fa6c6ead2f49a0d459da
> prerequisite-patch-id: ecb566a7bea44600e9d7e9617e280c994773e3dd
> prerequisite-patch-id: 20e295db85a31587d342471a3c341615c8eb0fd7
> prerequisite-patch-id: 06118bf6e5affc234e7edbdb5c0aae9b05412b33
> prerequisite-patch-id: 17afeb13c5012348feee8eb739ff058e84ed2df8
> prerequisite-patch-id: 27693bdeffbc7a0a295c165912b89af5ca3264aa
> prerequisite-patch-id: 8313fe2293eaf0e69ffd2f0017e18fde64ca68f7
> prerequisite-patch-id: fc53af34353efecb4490087ed066ccb256a74695
> prerequisite-patch-id: 02ad8a3b1fddb4f4e806939d36ae642c01004c36
> prerequisite-patch-id: 7b9b8460613f4240492ffe11ee7ee0e6c0b6ded8
> prerequisite-patch-id: 699c068a32ac9d3171e7a494fb2ca5522045779a
> prerequisite-message-id: 20261030140240.211786-3-krzysztof.kozlowski@oss.qualcomm.com
> prerequisite-patch-id: f6cf975bf90acb029fa985ecd659b59076fdc0cd
> prerequisite-patch-id: 4f16ad80662de796ae1454904c938e7e85115fbd
> 
> Best regards,
> --  
> Best Regards,
> Thomas Richard
> 

-- 
Lee Jones
