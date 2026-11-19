Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795115035;
	b=4KSFbaRvYgw39QnzqumVrPzLDdT8Cd/9y2E2fsvN9Hu9xJfcGz9nfs/RbefkWwT05how
	 aLWhHh6r4PFFywb2g2XNKZJmVexnLws0+/mtjzAv2IRl+Xx78U3pnH8NZHHMp2mbQi27d
	 yDl90D5KSrf+tIbsqVXQfB3WW+9S+Y6pL28tMsAsvpCWaeaSTB6o8LEkKVoSJNZHKnsKc
	 gnViV7KdItwbwKzO39rNEyTRpyGQIZbcDNzTyasoH4gWM8qN+CFvvFMUq3kyuP5n3J48T
	 E8e+0Ljarwoub4MmCqhUQXcwcL2dybe5N7vYYMEsvVPoufvJJRFADr5A16LjjjfDwCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795115035;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=UrVO8XGwHaQjZz8zm07ChJM1EQesX9Q557uM+EHmj+M=;
	b=e0TO2iGaTH2PRcHRWJw21EG9fMFK6x1tcuTt+yKd5m6lEFd0B4gYg7g17ejmv2Khe1cg
	 BuzLpdlQmtAt3GiiSPjBICCtB8sUpnfUN82lOieFqy2MM8sAoQmv7qTtYP7Yu+rp4jafv
	 r8mRmTmJeNqtDA50Xj94Fl+4oZJ6+2kRQGC+4R1LU1pLb7NlCdRnjy9g63c6rBvnLZ2iX
	 klkLnTZs/L4b9j6T6/7K8g5L4rFIt7aL3YxvINtUr53vFyboLwnCQR10miGKi2IWOa8az
	 hfTQ3njLmCWUf0rbabpdGQiJX/Gay/6OVNXeGPwUDft/P9VNHB0QZFAYbpfmOTEhbiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E2p3cSUI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31945606A32C;
	Thu, 19 Nov 2026 19:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E2p3cSUI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82B31F000C5;
	Thu, 19 Nov 2026 19:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795115034;
	bh=UrVO8XGwHaQjZz8zm07ChJM1EQesX9Q557uM+EHmj+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E2p3cSUIza9WEyze8LYVC3oD5uhjdLoZC9UdoslJtq0ndKAWrosz64U3W+g7Ri7Bp
	 kYUtvQdtPNBbyxgf4SejJfAX3gJwfTGaU/ZEpAT1hvAYmD84gBTfEdvjUn9Aq+tUwE
	 xNDvzHOrgYvZdH6Ud9X5Np/8YHvd3TGEQdHfHxvxitG33PupQFYzyP9waNFq9gfp3q
	 A4N5jNcYnQqA8pvtZZ3Z86bLVTzoUu+EoAMl8Vy99Kb8hDfO8z0cp2y9hY1rQoknjN
	 HaztoZWZJt5545xxxXfNsD/Uhs/P4Nwukzsa4vnazWeu/CpeCYrpnKDTdlGfyYHl+W
	 9zF4syv18i1ZA==
Date: Thu, 19 Nov 2026 19:03:50 +0000
From: Lee Jones <lee@kernel.org>
To: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v6 00/10] Congatec Board Controller: Add storage devices
 support
Message-ID: <20261119190350.GB70182@joneslee-macbookpro.roam.internal>
References: <20261117-cgbc-i2c-storage-devices-support-v6-0-bb070ad3e9aa@bootlin.com>
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
In-Reply-To: <20261117-cgbc-i2c-storage-devices-support-v6-0-bb070ad3e9aa@bootlin.com>

On Tue, 17 Nov 2026, Thomas Richard (congatec GmbH) wrote:

> This is the 6th iteration. As discussed with Lee [1] I just picked his I2C
> patch [2] (to handle the conflict) and rebased the series on top of
> next-20261116.
> 
> [1] https://lore.kernel.org/all/c9d26395-93f8-4e63-9cd0-586ce913931b@bootlin.com/
> [2] https://lore.kernel.org/all/20261027093306.2812695-27-lee@kernel.org/

I assume this all needs to go in at once?

So we just need the I2C Acks, then I can take the set and send out a PR.

> Signed-off-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
> ---
> Changes in v6:
> - rebased on top of next-20261116.
> - add Lee's I2C patch (PATCH 2).
> - Link to v5: https://patch.msgid.link/20261103-cgbc-i2c-storage-devices-support-v5-0-ac11f23fae51@bootlin.com
> 
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
> Lee Jones (1):
>       i2c: cgbc: Propagate hardware errors when polling read status
> 
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
>  drivers/i2c/busses/i2c-cgbc.c | 135 ++++++++++++++++--------------
>  drivers/mfd/cgbc-core.c       | 187 +++++++++++++++++++++++++++++++++++++++---
>  include/linux/mfd/cgbc.h      |  16 ++++
>  3 files changed, 265 insertions(+), 73 deletions(-)
> ---
> base-commit: 749a4de370409464cf8501ec5b2451df45c84eb4
> change-id: 20260717-cgbc-i2c-storage-devices-support-b3ee7cea3320
> 
> Best regards,
> --  
> Best Regards,
> Thomas Richard
> 

-- 
Lee Jones
