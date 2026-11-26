Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795700057;
	b=ar+tCe0bUaWU7CBQub6bPvbOsmcztCchWvjX/BgecCIthAOy2pjjEoAGpRoYozRJs/la
	 s57USgGJxDQ0IDE0gqA7L4TwkQkIio8mDzKxxvVyJ2YpKS9auLTVGVbnqsJ7tvJOijGAh
	 RY0rg/p7hmt1d000QJI2eQmxn99xKs4TSGpYknH5w8D9fZAZB31V+50whNSMKvK5qC/Zb
	 VKfoB1TFH0cetoQQ1Y2cXh2Qk0YhOBXGRsUx6UmVCz67PAwDAmmjZ7FeNiVQB90GOt6+T
	 uOw8ysC4BpHw/VlyJAaE1HxwvhYfk5b6pynW60bODix0swYBnW6u8kYFJ0+INfl61NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795700057;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lGn8gCQyesHPSLILnAr3zm2fB6gk9T9OZV7xJjvX7CI=;
	b=3Q6Si6OfsLh1LHLaHgctTS33zBcjVn84H7Zlq0JxoswHsD4Kelqxf6UG8YyIDO803Rne
	 MWv+k6nDa3LZc2MlJNfjIsVfdntO8U8aK95kAOa4NywFWYBFtKQsbGP9BcmojbPS1n2wl
	 J3HrWid6ks/yAagA4XpzTRvt16BiypXvHpyUPdKCwE5vMcDfFlR3mzUOvqHgjpjVvyCaN
	 /K6QKO5eq9rc1GqvQfcTB1MdjeEzRNf6Y+SWRyGzCCDPSvT19NcKBiQS6vnMeNLmYL3Fx
	 fsNbxYq4VIzUVEEg2IeKZUd6cPx3ynhQhLHT9dg9FGuEQFOlJ9gFKiXncsq8plYx/wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g8HVky0A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794F5606A31E;
	Thu, 26 Nov 2026 13:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g8HVky0A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0F61F000D8;
	Thu, 26 Nov 2026 13:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795700056;
	bh=lGn8gCQyesHPSLILnAr3zm2fB6gk9T9OZV7xJjvX7CI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g8HVky0AV19iVhDw9k0ewwReuMW/2BKz4ID2ZI+i5+ggHiv8GXnMFm+zHAHEJcKfu
	 djgMR85FeQUTJpc+jIF7PK6p3XXTPGannesswkfutGHBr+IWcDtNICWJnuYKNtmdc7
	 1ccJc2oJzVS34+cV9IWJ2u3W8haNeuPcI6eFyVHClGtfMeCj7TsHKGFY8Evdyv+wIw
	 kufgePSWSmVlzLq393NeXooyqUDNWY2W1j7FCROaWGf6P7UQ3SDOwFxsos//Tdb8jm
	 K9raQ9aTlHhe7lBlxaQNtyXs8R3jsUYSEttJg6a+JFPvJspb9NZPO2fBPymwmOuuNe
	 Px4sH0Ha14LLA==
Date: Thu, 26 Nov 2026 14:34:12 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Werner Gartner <Werner.Gartner@congatec.com>, 
	mfd@lists.linux.dev, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v6 02/10] i2c: cgbc: Propagate hardware errors when
 polling read status
Message-ID: <awg1RfdXHh3tVkpa@zenone.zhora.eu>
References: <20261117-cgbc-i2c-storage-devices-support-v6-0-bb070ad3e9aa@bootlin.com>
 <20261117-cgbc-i2c-storage-devices-support-v6-2-bb070ad3e9aa@bootlin.com>
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
In-Reply-To: <20261117-cgbc-i2c-storage-devices-support-v6-2-bb070ad3e9aa@bootlin.com>

Hi,

On Tue, Nov 17, 2026 at 10:47:42AM +0100, Thomas Richard (congatec GmbH) wrote:
> From: Lee Jones <lee@kernel.org>
> 
> In cgbc_i2c_xfer_msg(), read_poll_timeout() uses the same ret variable
> to store the polled return value of cgbc_i2c_get_status() and the
> timeout result of the macro itself.  When cgbc_i2c_get_status() returns
> a negative error code (such as -EIO on an I2C NACK), the loop condition
> ret != CGBC_I2C_STAT_BUSY evaluates to true and read_poll_timeout()
> overwrites ret with 0.  The driver then issues CGBC_I2C_CMD_DATA, which
> completes with CGBC_STATUS_CMD_READY without populating msg->buf,
> leaving uninitialised heap memory in the caller's read buffer.
> 
> Store the polled status in a separate variable, verify that it equals
> CGBC_I2C_STAT_DAT, and check that CGBC_I2C_CMD_DATA returns the expected
> number of bytes.
> 
> Fixes: 6894f640b8f3 ("i2c: Congatec Board Controller i2c bus driver")
> Closes: https://sashiko.dev/#/bug/linux-66cbf4b1-a219-4012-969d-236417bf419a
> Cc: stable@vger.kernel.org
> Reviewed-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
> Tested-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
> Signed-off-by: Lee Jones <lee@kernel.org>
> Signed-off-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
